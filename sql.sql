Общая информация 

SELECT COUNT(patient_id) as количество_пациентов, 
ROUND(AVG(length_of_stay_days),2) as средняя_продолжительность_госпитализации,
ROUND(AVG(treatment_cost),2) as средняя_стоимость,
ROUND((SELECT COUNT(patient_id)*1.0 FROM med WHERE visit_type='Emergency')/(SELECT COUNT(patient_id) FROM med WHERE visit_type='Routine'),2) as Соотношение_экстренных_к_плановым
FROM med 

Демографическая сегмантация пациентов

SELECT age_group,
COUNT(patient_id) as количество_пациентов, 
ROUND(AVG(length_of_stay_days),2) as средняя_продолжительность_госпитализации,
ROUND(AVG(treatment_cost),2) as средняя_стоимость,
sum(treatment_cost) as общая_стоимость
FROM med 
GROUP BY age_group 

Анализ по отделениям 

SELECT department,
COUNT(patient_id) as количество_пациентов, 
ROUND(AVG(length_of_stay_days),2) as средняя_продолжительность_госпитализации,
ROUND(AVG(treatment_cost),2) as средняя_стоимость,
sum(treatment_cost) as общая_стоимость
FROM med 
GROUP BY department 

Выявление тяжелых пациентов

SELECT patient_id, age_group, department, length_of_stay_days, treatment_cost
FROM med
WHERE length_of_stay_days > (SELECT AVG(length_of_stay_days) * 2 FROM med)
   OR treatment_cost > (SELECT AVG(treatment_cost) * 2 FROM med)
ORDER BY treatment_cost DESC

Анализ по типам лечения

SELECT treatment_type,
COUNT(patient_id) as количество_пациентов, 
ROUND(AVG(length_of_stay_days),2) as средняя_продолжительность_госпитализации,
ROUND(AVG(treatment_cost),2) as средняя_стоимость,
ROUND(SUM(treatment_cost) / SUM(length_of_stay_days),2) as Стоимомть_одного_дня
FROM med 
GROUP BY treatment_type