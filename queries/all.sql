#standardSQL
SELECT * FROM (
  SELECT  
    vcl_sub AS Caller, 
    CAST(REGEXP_EXTRACT(resp_http_X_Version, "^[\\d]+") AS INT64) AS Version, 
    REGEXP_REPLACE(req_http_User_Agent, "/.*", "") AS UserAgent, 
    REGEXP_EXTRACT(req_http_User_Agent, "(?i)(firefox|msie|chrome|safari)[/\\s][\\d.]+") AS Browser, 
    REGEXP_REPLACE(req_http_X_Trace, "^.*;", "") AS LastSub,
    *
  FROM 
    `helix-225321.primordialsoup_logs.logs201812`
  ORDER BY 
    time_start_usec DESC
)
WHERE
  Browser IS NOT NULL
LIMIT 1000