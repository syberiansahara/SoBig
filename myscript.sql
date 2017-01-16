create table lar

(Loan_Type VARCHAR(20),
Loan_Purpose VARCHAR(25),
Loan_Amount_inK INTEGER,
Preapproval VARCHAR(25),
Action_Type VARCHAR(25),
County_Name VARCHAR(50),
Applicant_Ethnicity VARCHAR(25),
Co_Applicant_Ethnicity VARCHAR(1),
Applicant_Race_1 VARCHAR(25),
Applicant_Sex VARCHAR(25),
Applicant_Income_inK VARCHAR(4),
Rate_Spread VARCHAR(5),
HOEPA_Status VARCHAR(1),
Lien_Status VARCHAR(25),
Minority_Population_pct VARCHAR(6),
HUD_Median_Family_Income VARCHAR(8),
Tract_To_MSAMD_Income_pct VARCHAR(6),
Number_of_Owner_occupied_units VARCHAR(8)
);




insert into lar
(Loan_Amount_inK, 
co_applicant_ethnicity, 
applicant_income_ink, 
rate_spread, 
hoepa_status, 
minority_population_pct, 
hud_median_family_income, 
tract_to_msamd_income_pct, 
number_of_owner_occupied_units,
loan_type, 
Loan_Purpose,
Preapproval,
Action_Type,
County_Name,
Applicant_Ethnicity,
Applicant_Race_1,
Applicant_Sex,
Lien_Status
)

select lardb1.Loan_Amount_inK, 
lardb1.co_applicant_ethnicity, 
lardb1.applicant_income_ink, 
lardb1.rate_spread, 
lardb1.hoepa_status, 
lardb1.minority_population_pct, 
lardb1.hud_median_family_income, 
lardb1.tract_to_msamd_income_pct, 
lardb1.number_of_owner_occupied_units, 
loantype.value,
loanpurpose.value,
preapproval.value,
action.value,
counties.county_name,
ethnicity.value,
race.value,
sex.value,
lienstatus.value

from lardb1
inner join loantype on lardb1.loan_type = loantype.code 
inner join loanpurpose on lardb1.loan_purpose = loanpurpose.code
inner join preapproval on lardb1.preapproval = preapproval.code
inner join action on lardb1.action_type = action.code
inner join counties on (lardb1.county_code = counties.county_code and lardb1.state_code = counties.state_code)
inner join ethnicity on lardb1.applicant_ethnicity = ethnicity.code
inner join race on lardb1.applicant_race_1 = race.code
inner join sex on lardb1.applicant_sex = sex.code
inner join lienstatus on lardb1.lien_status = lienstatus.code

where lardb1.state_code = 27
and lardb1.property_type = 1 
and lardb1.occupancy = 1 
and lardb1.action_type <= 4

and lardb1.applicant_income_ink not like '%NA%'
and lardb1.minority_population_pct not like '%NA%'
and lardb1.hud_median_family_income not like '%NA%'
and lardb1.tract_to_msamd_income_pct not like '%NA%'
and lardb1.number_of_owner_occupied_units not like '%NA%'
;

\copy lar to '/home/gpadmin/FINAL_LAB/csv/lar27.csv' delimiter ',' csv header
