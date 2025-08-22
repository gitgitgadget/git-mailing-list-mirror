Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C8212B18
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875663; cv=fail; b=mRbxmoMTwDvf76SsJkBv0xj2hCrQS+vCjh5uCSUoI1MXq/zfC4+yDKxtvbol4OwWNWzI14UrPu8DJPB1fEAaF23M88eIJPGQ4/TSN8HKOffj2OJ5cyFAHOo1OJK3SBTRe6V2zPOaEoC2CmIRb/QvPrzBJMO/KDp9br+h+XNIGUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875663; c=relaxed/simple;
	bh=w6O0XHE63hsilyMyyAtBNFe2rHPCaOtZ6Mul6J0gdIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTwru2mhEp9ERnh4XLfKHS5Q9suv2bgjv+QBS6IrirFP8i1YuZSMlJZi0hmDODqD+cy47iSGHJbxQwZ4oK5VgC4d/EFqOjP9CLeqqePHVdInBN88nRwttgeCRoywkU4eB0SAgoxQr2sjWEZuHih/klMZde44UQQHhri2FC8Dg44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=I8cmbrer; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="I8cmbrer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS1KxCslOktNdVkpLiQutmZOUndFczDBwGwNJzTYubOL5vsvEsyvOQRhGD3dfgOo/fwEouQSbySpXGYOi5wgy/A9088ToRh4IAJ5qiyQhj3LH2+GWK4TL/yEnoUUSTEhxh6PQTihxMpawXCM9DBJ5Ne+ebcxZUXBtl/OwUPtsp2+HXEegONaNzZgiR8wsUraiE93cGLvQSD0mW4TdGZR8yAayBu/RSepj8APhOItOFFQ5QdkvLGuBjDdlI2bKxlJXzujKdpIUOIJtlCnTz419gSKJKynMuUEI0LTjsfrs98NvIQtpYkat4jw32jaHcAWTECZknu0nXrvEYwBTNoHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnDMk6fXpr0J8+npPFu+6uJr79ZcxsC6xdCgxm4Y+dg=;
 b=h8R/wQExloYLba7LsZEQRo511ujJjLlDDx+3AqGICyApG1TI1ZqT1eZs18mR5rwLtWeqQHQstd4bpdqemOjiAbH/vdp3WLGi3qsNrjH3VvxpX5bYuJ6X+SzVA8VSLb9RzyifVYjFlfwZHZguX/qgbo8R72+h51VO3hOiBzB/vxhtJ5px57u8Qnp9wD9cFf2yqT9ZpsfcIisRLq25jFavHRGsS10XLMa7xtGJE1sDtPjOFQUln98m5NEFcVcqGO3220szMnUXaIunKujxciPvTNaaiJBmDplXluVRRq0EsD9vbRYPH1nSLVhR3JErzmfzMavQPspB1X54Hjm2UvdqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnDMk6fXpr0J8+npPFu+6uJr79ZcxsC6xdCgxm4Y+dg=;
 b=I8cmbrerTn4cInf1EWYBR7kdq1VDhqsgYUh8zHHmviRmo5evaNthxJdodAZEmLUEy1xfbW1IrlQa7T14USD+/copEuBqFCODYzBCaPTGh8OmnXO2c1p24uqFUxk7JctTBPmJQx1C19lIYXwsfqdFfB2rzAdfKdpCJvZa9EVHxF8TKaCceIl31TZMsO9SFbn1YwatzBVknFShavu2gv80s3JzMX02tU07rY7l6TDPHuYYSi128qcBgbeaEL2jfTmnmtj5erMQKRr6fq392P1tHvsrpWWenP92r3P4iTBKfr6DyBMoEDShilpPtP8+oHgLYWgNwiAkVX2dCWQrwlNs8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB11372.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:14:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:14:16 +0000
Message-ID:
 <PN3PR01MB9597AA61D622066CD32568D1B83DA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 22 Aug 2025 20:44:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] send-email: add --get-smtp-server option to fetch SMTP
 settings
To: Julian Swagemakers <julian@swagemakers.org>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20250730151227.12389-1-gargaditya08@live.com>
 <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <781e72fd-0443-42f5-be34-dbef8d7ab924@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fbd0a7-1379-468c-16fc-08dde18e8f7b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799012|23021999003|41001999006|19110799012|5072599009|461199028|8060799015|440099028|40105399003|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVlWeC9VU2dqRHVZQjZaZmRFa0RCSCtKcjBudVRiZVNwZ1dwa0hKVGdrZ1V2?=
 =?utf-8?B?blorWVNJZUp1VjRiREtlOWNsUjcwR1g4cTJzU0xSdDFjVlM0K2RxclExTGE4?=
 =?utf-8?B?NTV3T3IrazJ5OHY1MUlUcThVV0xLMUVMMTVhTTArZ2dtSTJsSis5dUwycHBO?=
 =?utf-8?B?T1NqVzJudmRRc3hhYWIrMlcwTU1NeHdhVlZKb2lrQWpNWWEzRUs4N2lGUUow?=
 =?utf-8?B?d2dqR2ZqRUY1MTFvallHWE1qY0NkVGpFMnhiNFlzTHVtUlM4UzlJQktUK3Yr?=
 =?utf-8?B?RzNiV3E4VGQzVklEckI0eU92VHVpdzdsekFwSjZkeHBHVjhlVnlVVEJtUnpT?=
 =?utf-8?B?NDlnZ21Ga21WY24yVmxEM2szRnoxTk41bE9sVkV3UzJwLzEva2kyTks2bnQx?=
 =?utf-8?B?Y1d6NjRUZFdPZzZxVjE3ZDlaMmI2MU15RlI4RjNRS3FJY2VTWks5TVpIbjha?=
 =?utf-8?B?clcxbGhWU245N2VTc1ZCMnZVT3IwRU81Wk9PUDU5WVJYSTBwWmI1T2laZ0ZK?=
 =?utf-8?B?dTFIRitLaXNnS3JpT0NDVVZOem4yd0FpVXJPcWpWY3lDUXZISit6U1VQaVlt?=
 =?utf-8?B?T3dMaTEvZGUyNEpaeDVkRmtCZk85TlpjY3UrVnpTeDRGaEM2d3NHVDEwVHo2?=
 =?utf-8?B?ajAwRVpVbGN4VHFIcHZJT3RvdGtvajByT2s1ZUtxMVg3YldOL0IzY0x4bVNL?=
 =?utf-8?B?N2N0bldlRzdGck5OK1ltRnFOWEFORDFSRWQyWHp5QnEranA0M2VWTnRzb1hJ?=
 =?utf-8?B?bVB5YnBZbVptWEc0QkxOcldabFJaN2U2REE0R25GR3lPTzY1aGRlZng3STQz?=
 =?utf-8?B?MU5pSEJmMzdkbjBrNWhxWnJ3Wm1LUm9EUEJuT2tGV2d0aDY0Qno0cXVuMG5r?=
 =?utf-8?B?V2hWOXNLdjllV3ZQYy9wY01HVmZSd0pxT21EOEhGTWVrVGtRVzN2cFVRc3F2?=
 =?utf-8?B?MlhzY3E3c25reUlmakhJT2hISHQ2Y1hLTVI0Y3MxdkdiWUwxbGtvWndsL081?=
 =?utf-8?B?ckRjb3AyNzhxRmNobE5wQy8xTWhNdzVhREZDdDZ2b0srMlMxZExhWGVIVVEz?=
 =?utf-8?B?dTluZkY1S3E0ZzN6YkovT0JBczZDaEJlRUZ4eEpyVC9DaFlsQ3NFQnJqSURj?=
 =?utf-8?B?dXJ3SlF5cVZPRVBlcmc4bHI3aGJEYjdEM0k2dkx4Wk96TG5LSHp0ZXZEU3cz?=
 =?utf-8?B?TXZBMWpsMkRWcE44SnJiblRoemY5TWxDRzBCUkZwWXFqYnJrVkQvOERnVVZr?=
 =?utf-8?B?OXRZZXJ0c3I5MGlLc2FraUZ2VUQzYlVUUlBJYlV5YS9oR1FFSXdFbHNxMXF1?=
 =?utf-8?B?MWQ1a09nbytWcE5iUFY2TDV0MFdtdUxGM1RxS001NEdPQ3lTK3JwUUQ3OC9l?=
 =?utf-8?B?MEFORG1xaDdJYVlNd1U3Tkh6aFdJYVdNYUp3bVB3ZlowdGt5N3QzVDhvL3pW?=
 =?utf-8?B?VjdVL3l0TzRSQWk4ZFp6S285Y0xiVzlFUWtLQW5MdVQwb0pINTlqK3U4eGE2?=
 =?utf-8?B?Z0JGTXVpWjFWcklRYWZMUndSUDRVWGdsSXkvSW9mZEpGSFdWOTFrNFFMVUxq?=
 =?utf-8?B?R0FsUDk2UC9kYjE4RnpTSGhzTzNZb3FkRmJYenIvVWtXcjRLWkZ2NEhmemsr?=
 =?utf-8?B?cUVIVEZVQTFWOXhGa0d5S3pHSm5vYlE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHdiOWZMNVB6ZGg1Z0w5ays2cDFKVTF0cDJCVW50WHpka0tNa3hFMGNBTU9H?=
 =?utf-8?B?bHlpTFNnWUlYS1EvVHVYQU5DbXpUM0xObVlqYytOa2YzcVQzS2h1QUI3TGNx?=
 =?utf-8?B?S3V4OVVjSFA4dVkza1NtRnJqT0dudVQ2MTEzdU41cjB2c0R0Yk5LRURrYmlI?=
 =?utf-8?B?UnZWTE1RYnBXNFRqTU1Jd2ZDN1I5VEMyZ1FDdU0wUUc5dmQ0L082NWpEZWRU?=
 =?utf-8?B?VWF3VHkxQzBHUk5yeEJHWnRZVUhySEVhWUxNdmJMUGJXcmZjZnJWS2VuQVVq?=
 =?utf-8?B?QVcxVUJaY0hmcG5pY2RUQkZINWlFWVVwTGxtZGkxNnBWSmozL2NpM1JBTXZx?=
 =?utf-8?B?cUpVTHhzNWV3M1daNlV6dzZIVHFnL1JMdEVmMkY4OFBXSjRBeXJaeldnME15?=
 =?utf-8?B?VUFMVVkvZytLcDFqOFp3V3c2b0Y1N1Z0aDhYcnNJb1hXdW0rTE03NFh3Y00v?=
 =?utf-8?B?bHF4Si8vNTlaOEpQckowTE5pL1RkajczSjRtaHVjSWt2SE5CbWx2L3FCdW5M?=
 =?utf-8?B?ZlFYOSthdlBrRE9kSzNrNFNwbEFyeUpvUGJWYWdvYnJPZHhENzJuMld3c3pk?=
 =?utf-8?B?ZXp5Q1czQmdOSUVmN3BubVRZeWZVMmgxSlF2OUpjdE9pQzBZQ2xqckRha041?=
 =?utf-8?B?QlIvK0w5QnpJdTIreFlLZ0pJa3RjbWU1c0lvMjBUS3hYQzlBU1F2YmE0UVBC?=
 =?utf-8?B?Sk5qZW4wLytmUHBCS3lncUxFZnVoelZXNndpWVkzWFk2L1dILy9ueVl3aDJj?=
 =?utf-8?B?MGRTQXAvSjFGcU5zRSsrM0JVc215SGVPcWtnc3pEbGI5RS9WRmRqTU9ZcGkx?=
 =?utf-8?B?aUh1NEZobFEyMHQxdTVoWS9Wbjh5ZHMxUHJqakUxR1lVMVlCTC9QVHFQSi96?=
 =?utf-8?B?OHc1d0FLb0o5bTZjOXQ4ZE15RDFjNHRDUVMwa0xxY0lHNTJrYk5ZYkM4aXlD?=
 =?utf-8?B?cDRIUTNnQVZyci9lKzRxRlo0NmpWblNld01Kek15NEsrOUlOaEN0YTdzWTJL?=
 =?utf-8?B?WFlEZVJsYTNyWVQ4cFgxRlVtU2JJcStqNXdnclBqcEQ2ZTFYamxvbXFqdkh0?=
 =?utf-8?B?eFl0bS9wVWUxMDcybkp0WjBjQ3BSVDBwNTNtU3h3VXVUOExscThXSFI4djg0?=
 =?utf-8?B?cWx5bHNBaEZQYjRMWlo1dWZKUEEyaFNEdi92UXdWUXQwYlQ1QnQ3d1NMcEhw?=
 =?utf-8?B?VXl0eTQwZHBQbGRWMWRNcmVaV3RZODVPc1NTcmxqQWIzNVdlOGhaSTNKVUlN?=
 =?utf-8?B?T2xlUWdIM2FyUlM5MXkxNENSVm9LN2dNUkRZN3JMbWZOTWVVUUZrWnBvZDZZ?=
 =?utf-8?B?d2tReXJkSmlZdUVrS01YWENpVU03eFVFVEpqVFMvUVppRVVjUlRKTk5ZbldZ?=
 =?utf-8?B?bnBlK3NmcmYyTC84WlVrTktpNkpQa3Y2VEhUWGwyUk4raFhINE1SeVc0dWxF?=
 =?utf-8?B?eWd2V0owQ0RjZUNZdkIySnFzVTNLSWpRbGtERmFpQTQzZm1QVG10UGM2TWI3?=
 =?utf-8?B?MjhJRUpIRHJUOGRJSVpSdXJuQ0ZqbkorZXQ3THU5b29uSEx0bDJ2bWtnT3pk?=
 =?utf-8?B?VnprZzlsc0k4VERPSjF3elpqVTArVmMwTFVaa29jWTJ1RTZoRUgxSy9KM21t?=
 =?utf-8?B?RmU2eVh0SmJFbFdNL0d4NncwbTJPNUUvblVOWWVZanc5aEFoU292ejZEWFZj?=
 =?utf-8?B?R21sK01raGNkb3dVN2ZITGcrdDJGMFVJZHEzS3ppb3RuMUxhb3VZbEZNMW4z?=
 =?utf-8?Q?H1vaORRw3ZV2aHyS2U=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fbd0a7-1379-468c-16fc-08dde18e8f7b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:14:16.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11372

Hi Julian

>> Autoconfiguring SMTP server settings is a common feature present in many
>> email clients. In order to get the correct SMTP server settings easily,
>> this commit adds a `--get-smtp-server` option to `git send-email`. This
>> option attempts to fetch the SMTP server settings for a given email address
>> via the following steps:
>>
>> 1. It first tries to fetch the settings from Mozilla's ISPDB at
>>    `https://autoconfig.thunderbird.net/v1.1/[domain]`.
> 
> We should first check autoconfig and then move to the 3rd party
> database, this is how thunderbird[0] and aerc[1] do it.
> 
>>
>> 2. If that fails, it attempts to fetch the autoconfig file from the email
>>    provider's autoconfig URL, which is typically in the format
>>    `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=[email]`.
> 
> The documentation mentions using `DOMAIN/.well-known/autoconfig/mail/`
> as an alternative to the autoconfig subdomain, what do you think about
> supporting that?
> 
>>
>> 3. If that also fails, it falls back to checking the MX records of the
>>    domain used in the email address to find the SMTP server. It can be
>>    useful in case of emails with custom domains. It attempts to guess
>>    the correct domain for the email from the MX records, and repeats the
>>    first 2 steps with the guessed domain.
>>
>> This feature is heavily inpired by the autoconfig feature in Mozilla
> 
> s/inpired/inspired
> 
> 
>> +sub parse_config {
>> +	require XML::LibXML;
>> +	my ($xml, $email) = @_;
>> +	my $parser = XML::LibXML->new;
>> +	my $doc = eval { $parser->load_xml(string => $xml) };
>> +	die "Failed to parse XML\n" unless $doc;
>> +	my $config_num = 0;
>> +	my $smtp_encryption_config;
>> +	my $smtp_user_config;
>> +
>> +	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
>> +		$config_num++;
>> +		if ($outgoing->findvalue('./socketType') eq 'SSL') {
>> +			$smtp_encryption_config = 'ssl';
>> +		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
>> +			$smtp_encryption_config = 'tls';
>> +		} else {
>> +			$smtp_encryption_config = 'plain';
> 
> 'plain' is unencrypted, I think this should be accompanied by a big
> warning.
> 
>> +		}
>> +
>> +		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
>> +			$smtp_user_config = $email;
>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
>> +			$smtp_user_config = (split /@/, $email)[0];
>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
>> +			$smtp_user_config = (split /@/, $email)[1];
>> +		} else {
>> +			$smtp_user_config = $outgoing->findvalue('./username');
>> +		}
>> +
>> +		print "\nConfiguration $config_num:\n";
>> +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
>> +		print "  Port: ", $outgoing->findvalue('./port'), "\n";
>> +		print "  Encryption: ", $smtp_encryption_config, "\n";
>> +		print "  Username: ", $smtp_user_config, "\n";
> 
> The new option only gives you the needed SMTP configuration, as a
> user you still need to apply them and to do that you will need to
> look up how. We could help the user here and give them copy and
> paste commands similar to when trying to commit without having an
> identity set.
> 
> The XML file also contains authentication details, what do you think
> about processing those? That would also allow adding references to the
> documentation in case it is OAuth2.
> 
>> +	}
>> +}
>> +
>> +if ($get_smtp_server) {
>> +	require URI::Escape;
>> +	print "Enter your email address: ";
>> +	chomp(my $email = <STDIN>);
> 
> Someone sending out emails will most likely already have set up
> `user.email` in their gitconfig. We could just use that instead of
> prompting for user input, or at least suggest it as a default.
> 
> If you don't have an SMTP server configured then `git send-email`
> will default to `localhost` and fail if you are not running a
> local SMTP server with: `Unable to initialize SMTP properly.
> Check config and use --smtp-debug.`. I would suggest altering the
> message pointing the user to the new option

I've sent a v3 with hopefully your suggested changes addressed. Let me know if something is missing!
