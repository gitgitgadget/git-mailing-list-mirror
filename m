Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0B221FB1
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447075; cv=fail; b=selLDHMNkDw/c4K23XoaDrGf2ywhulx8VwlgV+4F1U+fWLdBexoVSAD1vLxXq3VmXYeOZZE3UVH7XijXRnotFDFOE9//LRpT0sn+H5e2rFUqvHRCCvYp3I/RdcTssF5CHIEmJhgVz7s6n/JcrRGCROxaYQyXjra4wQeSPLPRCEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447075; c=relaxed/simple;
	bh=iZo45P4MgFRDCvnCihiyRJfzTsg1UShSiQZkLmtX5pQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXBciOZyxE3hpg4gV1rybR2tJ8f3tMXOpZ0BjDkwbEBdhLuNoSz+cZ5lM1EnFptHU3jcuNxAFLtpT+m6mSma1R5evlEqxQtaww/sCE4OgEB5mQmsFn4LgNHPw1RuD6C84dy/Q+h1QpY5+XO3wJ3lTSZoJGTv3DxOocFBdqI3xmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlXWwmMQ; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlXWwmMQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydd1ryPg0MOd8mIosZh0KPu6NwJ+5cuUUZB+dQII2pVy6kZDN4QFqmD5860t/EoKGHMJFrOFXpFWx384K/CSVcF49O/EIBM6Kljf0yMrPIXvdOS34BRR6zC965AJja9UGexmIowTGhcwp/jWTNt/0xJRdLC45HD1rWmYq5KbQ31psY9zG5j4/DcEu3JOpS71V3coSs0xrf9+/IBJ2IViL0KoV1D1u3cJuSsh7Vf4K9ssL79XwyaKIEoqz26SBtVJbNlIML5V/LaHhUNPj1wssZNPBxMwsQRTcuBjbKbuR9DtB9Tap1QVtRKVS9hw77VJJLqc/mOKtfPD2SIXCyD4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nri85B2BzUEwIJjvjbkkX2RYlXQeVRReuTtmAkwXCrE=;
 b=GRrgK749qy27oPl00R2PrYrAqmqC9Kz3r7GInGRPjQfdoWYZKboGu/8Tw4mtuGx03ISEuxh5YxqiRAnZh7JdjTMC1In659s4PTlcTWaPsFz04emnWYlLIudXwYxZf5eUxjnE5mtwjGeVaGrzn+3wCxAF8ySFhynxVQMFMu4WKcDaYcjB6eXmcyAy73oxihJUsnUZxFonXu0yxrprGCAtm22XAlzHUZBGQXd9DaEmItU5IW41RIzy/drWnKD4L9s3fBlUTn1lpym8XA8WjDR4iKFHRRe/Q5O59ydjOQizesA4qZ8kj1c102GyiZKXhVj10v40/+nm68J73oiiTqOFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nri85B2BzUEwIJjvjbkkX2RYlXQeVRReuTtmAkwXCrE=;
 b=BlXWwmMQWeso7L+gB4OZd02GdJwurFm4ZPUfMwgZFtU6iw83G6VhGOaFCzvBCYVz11pWZAOD2GtCvoLbj+Bn0jc597ogkPOLmKdgioY9+ruPvO+Hr26SfMtzSZvhGYD0YK4pAwP/6Ulqqf5L/k0SRIgUm1OJkJOelP7BjZtT40IS6dzv9tq4WI0UOIL8aLaOMIXxQVb+xo0e2zZowksiwFaj9+DWgFrcCWkPx6myx5q1HfilzXNeBAC1CI7m6hbSKIplg8u4uOZKjZmwtfHtyw7R66Um2B9fVJi759bAIjIJNnej6TlHSb5kS0vVkb34ozl+baGf5bN6fADrMLs8EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 by CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 00:37:49 +0000
Received: from PH7PR12MB6465.namprd12.prod.outlook.com
 ([fe80::6f9e:688f:d9da:65f9]) by PH7PR12MB6465.namprd12.prod.outlook.com
 ([fe80::6f9e:688f:d9da:65f9%6]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 00:37:49 +0000
Message-ID: <5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com>
Date: Tue, 2 Jun 2026 17:37:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] http: preserve wwwauth_headers across redirects
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20260602161150.1527493-1-aplattner@nvidia.com>
 <xmqqpl28scll.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqpl28scll.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To PH7PR12MB6465.namprd12.prod.outlook.com
 (2603:10b6:510:1f7::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6465:EE_|CH1PR12MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db355f9-bed3-4861-3d4d-08dec10856c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|22082099003|6133799003|11063799006|18002099003|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BZWE6nxS+UFb4hqVtkH82lTaAhKRwnnnedjs3F0EPNrETm+tFWM26LpgNLvPn5D63a3eTjP+CsCAb0C8AYzwZ1+nGCe+8UNLA1co1xTX9CgUxKc53JRfILkvwJ0RIWCWdTUPNPJF1Q4J8k4zENxBZTqVtn424NQtAp/VasBYdyjEHYOB4rETEizzOrfpfVx0Ce6xVVDDuYg3U1e+Tgdv+HpltGUCM+JDZ0e4xtWuazyFvFbW+5oVHv213rRMlcMXv/VEjy5TprgzsOhbJ9Dh+sjpTIlNc+D064PMu2JfoLZy9JPza/JnxclmYpmkJZ/UveYwydpgNF/wFj/Acw0Y6Q0f/QVX3zwveId15tgEw9Z1Z2CibaGeIclYTxgxeD1qhqombY5nftnMHe11rZCS0T6eIvSnJtYO7wYdcKFXXhg3BVMyfPoGCmTUAsSOHtNnKieaKjy/qqj3hX0mraVq0VGqTmT9+e/OXWRK1fVL9llqHrqU2H9kKnFZR69bcqvf2ZbXU2+KyoUOrih/Yd1ShqkibB8gLRaZ+h70vKnAwBbGqhzPcbovO2ADgsQKtgof/qQjxi1uoGclEh7oeJfVqQdX+rBLf0i9kmTtI3v19Y8SZwXajrtRUYoWYLyZhQMYplNft7xKaSwN50QLu5FdLLavKlEwCMYTpYCveshA0/F5h+kwaf9FGL+wqvditC1k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(6133799003)(11063799006)(18002099003)(56012099006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJWTlJVdmFMSkpXaWVVNWNiYWdHN25DMWUxTnc3NCtYNlByKzIyWWFkMmxv?=
 =?utf-8?B?VGw3bHZvaVd2R3Rndk80NGloZ21DZVZoOUNnK09JVmJsdzl4ZDlNRTUvNW56?=
 =?utf-8?B?WnRuOTE4MkdaVUdOQy9QMVRaTHlMN0xkWCt5MkcvOWhkaUtVNnRXSG1TN1ZF?=
 =?utf-8?B?U1BRckhXSG5HVjZQdU5JL1JFSDZrOHp1djdOQURFVmNtTW42SFN1bzE5akY3?=
 =?utf-8?B?b1k5UXZNaUVKQkZjSTRrN05kVjFOSkNGNzF1UVM4cHRmalJmSFo3QVByVXl4?=
 =?utf-8?B?RHJlRGtxb1ZBek4rMzFKU0swN3NBMEZUNEJFdEpMMXhXZXZBNjJiYzJPZ2p0?=
 =?utf-8?B?eVZyMjhvN2RLWXQvK3p1WjM3eXBHVC85YVByYzRiU20vQ3NpVEd1K0FnNlNk?=
 =?utf-8?B?RUlxR01YOStBdXBSZHV5enVIUEhBZXQxbHpQRmdUYVF2cjF0MjJ4ejFEUE1j?=
 =?utf-8?B?c2EvRjNmYWc2UE5IT0pERnBDOXQzay9HMkdqeDJncWVkVFNRN1BObEFNb3Q4?=
 =?utf-8?B?MnNwNXk1azNlUlFJWWU1RnV1YlUvOWkwMmdDd3YyOFd6bmpFSW1QeGJwRW5X?=
 =?utf-8?B?VnI1dFpSa2E4Y0lTRkRMNmFOak5iNHQ3eW85cjl6a3N0eTRjMWFDZUxTSXNM?=
 =?utf-8?B?TElXU05IRmpWTVRreXJjbjFPNjV1azhENk01TUJaN1dHK2tVdlcvUlFwTzBW?=
 =?utf-8?B?L0tBOFZjSFJoSTd6NFpQV0RKaTJUWEVXWnpuZnJEeXlQcFhQelp4Nzc3Kzc1?=
 =?utf-8?B?K0g1a1lWT2dXaFgvQmhCeHBCMmhvZEE2RG9mekpVOVBOZTIvV0Zlb3YvaXRT?=
 =?utf-8?B?R1Z2Si9RRWlNcDUxUzVIYzJDcVMvU2VieGJrMUFXN0xNUVJUT3RzbU50RWRi?=
 =?utf-8?B?enlqWUlGcWZpZENITVZ2MmYzaklvUG4zVXJ2cDhIeEoxdEQ1SURPTHBwc0dz?=
 =?utf-8?B?SjJrdFlVbEVmNE1Eemt4bmJpM3pUbkh1WU9kbFJCbW96Z2M3MkZ2Q0JuWHNv?=
 =?utf-8?B?ekNZWnFFT29QaGt2OGVyTDE1ZnVJZ3lUaGFhbUNlbzJYbjZDZk9tT3JkcXZj?=
 =?utf-8?B?NGdhZlNLY3NHd3BNcFFzVm9zSkYvOEtxNkZRNkU2cVc0ejFGUHVuY3pPOE9o?=
 =?utf-8?B?Z005QUEyV3NUTDlXZWtIUjlVMkFOS0Q0KzR0YUxwclVubCswMFErMFlySzMr?=
 =?utf-8?B?TC9yZ3o0Z3Y5NHBxUHZxKzJqUFVvbDNMRGQ2Yzl3c1VtK1liMlJKWWlER0Uw?=
 =?utf-8?B?QnFpV0wzc3g0YnhOL21zNXRuZ1lDQjA2MUpxQzY4b08zRFBOUk5PbFd0ZmJl?=
 =?utf-8?B?K1RZOXBMMmZWZEQ2cVp4bkhYVzNTYzUxN1RZZ095ZVZTbkZlRlgxNXJSRC8v?=
 =?utf-8?B?RCtJWFlodldXUzU4N2JuaUtzZEgrd2wwRy9Oc0hBWEZOOW9YQVNsSjc2aGND?=
 =?utf-8?B?WWtkdjF1MEdvaWdnQjVVYjlPMW9DWlNzZUM5bUw3aHcrVWZBczViVmZxRXZ6?=
 =?utf-8?B?U1hvTkN0YmVFVytqQUhOOFJCTVdUQjJ3aE52SmVuQ2pKNUMwbThsQnRsd1Ev?=
 =?utf-8?B?STlqd2tXcmhYVjQ3amV6V2JlUkJKSDJVTFoxdDdGc2QrS1ZaRlcxa01xUVps?=
 =?utf-8?B?RVpsMUE1M2FxVXJlMnRIcFpGYXZKU3ROcWt2YW4wSXk3UHEydnZHMWhxZmpB?=
 =?utf-8?B?RkxmNWtPNnUrUXpjN2c4eWVsd0lDV1A0WXBSNjlCY05oSXlsaVFzZHNsUXdZ?=
 =?utf-8?B?OXVIdzNaZVFJeEdMUUFzYi9URk93WjRTMXFtb1FEK3MzWVhQMkw2b0dkM2dR?=
 =?utf-8?B?eU1rNjFiN1JGcWI3UU9FOWljSGVkcFRjRzdJRXhkSklsdUZWOW0xQzR0aUZk?=
 =?utf-8?B?ejZsWVJyWjNnYXB1RjN2NXNrVVdKWlV3Y0ovUWttMVlndERad0RINklRL3Jo?=
 =?utf-8?B?MVR0U2VSOW04ZElrUXo2eDFWSEdiUmo2TWNYUWFOUXhkRjBPdkx0cGsrR3hU?=
 =?utf-8?B?MGs4T2N2Y3BSY1lnVk5DdjNzaHlMdHRBb3A2aEhiTUlpdFJPZGFGVUc4dFg0?=
 =?utf-8?B?Y2t5ei9aMDUxMUlsMzY0OU8yQ3licEJvRlRCaXdMQzNNL1h1U2pUWXNMZmE2?=
 =?utf-8?B?c3g5RTBTc2hES1ArUDlIaXh2NUhtOHNjZjRmZE9scGJDVjBnWmF3RDU2TmtY?=
 =?utf-8?B?Z01PMHBUc2hxeXJzaSs0UnQyYnQ2QXFHKzdnTnQ0Lyt6d2lYYm13aDRmbVhB?=
 =?utf-8?B?Q2VuR09HLy85TGFyM05aK3lCeUZIWkxOYU92RjN1Yncvc2lvcU82Tm5YZXhk?=
 =?utf-8?B?U1A3bjd3SWlLSHJIb1hyTkJPUVM0NjR3ZXlTVC84dzQxZXhEUEsxSnVDY0wr?=
 =?utf-8?Q?b/tMtv6TsIq1Kkc/0VV+EB3zDoEuzwL42dBuRO0k5tC8S?=
X-MS-Exchange-AntiSpam-MessageData-1: bJ95GZpmvK8MdQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db355f9-bed3-4861-3d4d-08dec10856c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 00:37:49.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8cXBofDmCulftGplA55+s2Pg1gf1FaSJkc0PRCzS/qgaxkp8FhUqqzB3jHgm2umRi/6PcQ1M87BmZvA2YCymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648

On 6/2/26 5:15 PM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>> diff --git a/http.c b/http.c
>> index ea9b16861b..cac8c9bfc9 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -2425,7 +2425,21 @@ static int http_request_recoverable(const char *url,
>>   	if (options->effective_url && options->base_url) {
>>   		if (update_url_from_redirect(options->base_url,
>>   					     url, options->effective_url)) {
>> +			struct strvec wwwauth_headers = STRVEC_INIT;
>> +
>> +			/*
>> +			 * Preserve wwwauth_headers across the call to
>> +			 * credential_from_url(): if the effective URL doesn't
>> +			 * specify its own credentials, a credential helper
>> +			 * might need the wwwauth[] array from the server's
>> +			 * redirect response in order to authenticate.
>> +			 */
>> +			strvec_pushv(&wwwauth_headers,
>> +				     http_auth.wwwauth_headers.v);
>>   			credential_from_url(&http_auth, options->base_url->buf);
>> +			strvec_pushv(&http_auth.wwwauth_headers,
>> +				     wwwauth_headers.v);
>> +			strvec_clear(&wwwauth_headers);
>>   			url = options->effective_url->buf;
>>   		}
>>   	}
> 
> As strvec_pushv() makes copies of the strings contained in .v[]
> array, the above will
> 
>   - make a deep copy of http_auth.wwwauth_headers.v[] and store it away
>     in wwwauth_headers.v[];
> 
>   - let credential_from_url() get rid of
>     http_auth.wwwauth_headers.v[] (the original is freed here, but we
>     have a deep copy stashed away safely), and perhaps add some of
>     its own there; then
> 
>   - add what we stashed away back to http_auth.wwwauth_headers.v[].
> 
> So it does not leak and it does not have use-after-free, either,
> which is good, even though it may be a bit inefficient having to
> copy these strings so many times.

I agree, although in the grand scheme wwwauth_headers is a drop in the 
bucket compared to, say, nearly any git object.

I tried to find an easy way to just not clear it in the first place, but 
that doesn't really match what credential_clear() is intended to do.
> I briefly wondered if it is unconditionally adding back the original
> wwwauth_headers always the right thing to do, but I think this is
> good.  In the context of http_request_recovorable(), the redirect
> has already happened, and the request to the redirect target has
> failed with a 401. The wwwauth_headers currently in http_auth were
> populated from this 401 response from the redirect target. Since we
> are updating http_auth's URL to match this redirect target (in order
> to query the helper for the correct host), the headers we currently
> have are the active challenges for this new URL. Thus, they must be
> preserved and passed to the helper.

This matches my understanding and I think it points to a more 
fundamental design issue: wwwauth_headers aren't really credentials at 
all, and maybe they shouldn't be in struct credential in the first 
place. I wonder if it would make sense to encapsulate it in some other 
http-related structure that lives alongside the credentials, presumably 
along with the protocol, host, and path.

> A few design questions that came to my mind are:
> 
>   - Is wwwauth_headers the _only_ thing that needs to be preserved in
>     the existing credential in http_auth?  Will it stay to be the
>     only thing, or will we need to rethink what this patch did in the
>     future when we add such a new member to "struct credential"?
> 
>   - If we need to preserve some other members in "struct credential",
>     or if we add such members to the struct in the future, what would
>     be the recommended way to extend what this patch does to cover?
> 
> If we add new members in the future to store other transient
> response-based authentication state (e.g. Authentication-Info
> headers, or proxy authentication states), they will be wiped by
> credential_from_url() and will need to be preserved the same way,
> no?  This observation and thought experiment may hint that the
> manual save-and-restore approach is not robust against future
> extensions of struct credential.
> 
> The current approach of manually saving and restoring
> wwwauth_headers in http.c creates a tight coupling between the HTTP
> layer and the internals of struct credential. If new transient
> fields are added in the future, developers must remember to update
> http.c to preserve them, which may be error-prone.
> 
> I wonder if it would make the design more robust and future-proof to
> encapsulate this logic in credential.c instead.  For example, we
> could introduce a helper function:
> 
>      void credential_update_url(struct credential *c, const char *url)
> 
> that does what the new code added around credential_from_url() by
> this patch does, perhaps?

Yeah, maybe. I'll think about this design some more.

-- Aaron
