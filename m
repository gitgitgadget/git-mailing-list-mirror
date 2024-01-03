Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2053.outbound.protection.outlook.com [40.92.89.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B4182A4
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XToK1SNgVfry6C6vLlNkBIPsJhBkAARJPqUTs4jEm47C0L2rmz9RJ7ZSXRdw/Cvbx3TwytEtWSba5jG1NZMsUs7eTD9FuuYnwQ1vQc2Pev/LwTNr759zK4dq4b4dWfVrEwW8kTgUgM57mNzNb9FL9EGue+6fbcdRuTCCQH+M2nzVtda1EWK6RY67GoyVFr2xdyYjjY9kEUCqj1xvYwKgRtJR0dXs1chAMx7lLSm2VM3Yqi26FR1JQ2TFlV9jP5e0tdiJyWPkq8tkYeLa/stla1vwmHESDnn+rGfAmeFewQJVRoNzouqWYkW6itqNgXQxeYtnPsme3qguG0x7EpEIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGzh9UNuAZ2QTnKD1ZFRTUVB4lEMGnawx5MzCLIf6ro=;
 b=GXygr6NcUM3To/oT8eLbwQ06JTRkDTrWHbcHD5Nm9DMvIS2u579CD2ARvMDjP2FOZgl943sTDTvJcGkd5sbA3kk/cuEjBQsqy9rrUxptGI7oeD0W4hpfR/pEJAvnbdVGr0G/QvEUNzJAdaMT+N4+XdCeLIrFzxOsQYJq5OeblRTf2CgcG/e4G76fN0ewvoHuLpWHhBI5p6ZCmPdDQtUbjFV7YhZLSPRC7Nv76ratk/lkxIKdPQ7Ve6NdzIzd5LOPPxsgVKGd30q1ggWp/V8ZhQso+HuEAfqD6T9kK1NDE/IVbWx7fmD7kSUn2hjuQKHBijy+yfkmbNhLXRdE3x3JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AS8P250MB0378.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:21:17 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 08:21:17 +0000
Date: Wed, 3 Jan 2024 09:21:16 +0100 (CET)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Junio C Hamano <gitster@pobox.com>
cc: =?ISO-8859-15?Q?S=F6ren_Krecker?= <soekkle@freenet.de>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
    sunshine@sunshineco.com
Subject: Re: [PATCH V4 1/1] Replace SID with domain/username
In-Reply-To: <xmqqa5pnckm4.fsf@gitster.g>
Message-ID:
 <DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <xmqqsf3feilq.fsf@gitster.g> <20240102191514.2583-1-soekkle@freenet.de> <20240102191514.2583-2-soekkle@freenet.de> <xmqqa5pnckm4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN: [e39rXu7miRiLvm8M9nNkmv4eN+TLfQp4]
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <0e3a25c7-118b-20d2-33c1-6edf6379023d@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AS8P250MB0378:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aab21c-545a-4dda-788e-08dc0c34f544
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zlz38e269fkNQi6hNDuyGEwkfkjBR+9idINIfuE7y6NaXIaOkMENI0YdyEL+fflUPzqL/oqGdn94SJ5LL2P8kNJugw11akDgsO1kUWeRb3QidOIrFwNb0MSZAkLMCaZtWeM7uGmKhMn+Xwj+5W9+KDSmoNyi/hueRSA6mrv5TnLF3CxQ4FRESurNCUhV+N0FjfZIiAHSZ+71+r53wJ9jezCYAFTOVkHp+gmA6ShAsznB/l4wRDO8mX9lxGzLenEbzIhC+ZC+fBzpxdxNCeduhej/Nd5J9nfOEsnFTRS7h1kNHFvrqpXEeFM72QOhW/LSt46h3S2rwZXqmZtdA/HJ7NBWh+pXT9tTLRUhIjooQI5GMNMRiJ9EkeDo5kCEodZK/eJHFy6TJlNvziNyc0RWJEcU6VOem1zo5JXkZkvKKqrSvbUECbM3qooH80ppR61ji2/7on4v5RIsevbbugrUWwwEx7qOvptVqAApPy1PYJmPPL3chL+BHzMNpdGurHTXYkuVFB7/oYlsgJr+RYyTIl4C4SOvS6Izs/QT7ED1E1GtGL9Gk1f4hA0CME1N3XKwv2O2Q0Z9VVArnkGsyU5ibggjpIESkLwT5gmDAvbhalg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RKK1g2Y0JlZGM2Wm9XeFk1SUdlaGozQi9yQnM2VHpiK1lVSXlaZkxyazFz?=
 =?utf-8?B?NG1XUDhOeDlXMiszK2p0VkpoUmwzdERLcWxvKzNidkhwaTRmOXl1YXE2MHcx?=
 =?utf-8?B?ek91LzFuejNmaFVGMzc3ZGpmZkJMOVhEUFlJbitUUnF3aUZhdDBPZ0MrWUx0?=
 =?utf-8?B?bFB6SnNKeFlzcm44RVY2WXN2TzJwMUdyMjVxUVpKNUJ4UGhEZ1U2ZFMwUEFH?=
 =?utf-8?B?UENhY21yZ21rQlpYV2pYZjRsYVJFVmk2SW5pQ3FJMUV2RnR1aXFJVkRQU09Z?=
 =?utf-8?B?UkhQUExTYVJJdWc4QkVRdCtkbXNnRHpUZlEwMUZDNlAxMU1VT1RQK3A1cTNO?=
 =?utf-8?B?RlhJZSt1akI1K1pZaFJsK3BQU2ZVMng5NkNLYnhRbGNZVlJGQ3FLc0RkMURY?=
 =?utf-8?B?K1dGYStOY2lLR1JMTk1SMjZjQW9vTGpoNlVrTk5PcjVERnlxVWJseVh6Nmps?=
 =?utf-8?B?Y3VrbTdybkEwNjFuT1AvdFBOcG5WcExhZ1RWbnZSZUl4V21iZDNTY09JcWQv?=
 =?utf-8?B?cnZKekNBUk4zdFA2cEtYMUc1M2tBR2F6RmlLMTRvSzVHenh1WnJzS21udWZN?=
 =?utf-8?B?SzdXZnNZUGVmekxEYUZXank0em96L281a3VuMUZBOWlxcG4zVFdmK0Z0a2lH?=
 =?utf-8?B?SUZsMHVTR3NaNlMrYzZ0N21RSWFSVW1QZVpkT2Y5ZTd5Q1lSc3NEWjFJb202?=
 =?utf-8?B?Z1NsaWJEWUxFMnV3U1FmM3c3RGJmbUlCQy93dm5ZUWQ1TDBRNmFZeDZ2dEk1?=
 =?utf-8?B?ZVVCZVNqcnJGTXhrdW1aN3FKcE05WmpLVjQxZXZyWkl1WkRiMkVPK2pLd3Fp?=
 =?utf-8?B?MFkzdkFIUkVrWTI3YXN1RExVYm5BcXZ5TDJDY0RaNCt3Y1lTRnVYem54bXR5?=
 =?utf-8?B?VllGdndZblBzZjZDQXovcmI4M1pLK3ZieXE1R2lMN0E2cy81QndNbWk5cjB0?=
 =?utf-8?B?czhRaDVsWUlUUGRrd2dXNG1NQWwvbDFSb09VS2VCUXM5dzJuMUxRV2xGQWYr?=
 =?utf-8?B?OWo3MmQwMnZIeWFBdkhPYmp3YUxrWmxwR1ZoMHBFS2MwYm9jcTY2cVVmZk5s?=
 =?utf-8?B?ZklyejVDaHhLaXJpZXJYZEV2VHRaL043bEtNU001K0o2eFU3WjM4clZFZ1dt?=
 =?utf-8?B?bmplR1ZzOUpRaytLakU3Y3o1OE9vSEZhQzFWTjhiRmhKU05GdS9lN3ovdTdo?=
 =?utf-8?B?bVhlWCtRcGZxU0ZZMFVFMEZWTHVjeU5hNVVzc3M3Y2N2eEM3SldkOUlDclow?=
 =?utf-8?B?VVRvUEUvZDc3NlNRODJFSVRrekllVnlTUHM0RDZXd2l6OWo5WWZoSEZ2a1JP?=
 =?utf-8?B?UUE3RzFaSEZ1Z24rTlRRNFNZckFNeDNXU3pGT2xFWmR1c1JqMXpYMTNqb1RI?=
 =?utf-8?B?Mkl0VVJRZXdqQW1wSlN6d3NyWUJLNEZNRUI3aVNBd29SS3BDWVBYcXlpYUVY?=
 =?utf-8?B?cm5OWUR5elY4YjdnQjVudFlTdytnMGd0R3Z1d1JwMmwwcnNwMDNkendNZWpB?=
 =?utf-8?B?bjdFZTVES3UvUWNOZFdRWjBtWG5rYmNjbWJaaTBtWlVwNlJPdnhRd1FKVElK?=
 =?utf-8?B?b0s2SU5GSzV1QnZaczlHSThEMFNRWExZWEVZWjNRUkxFYTY3RWhqRnZ0SzJz?=
 =?utf-8?B?UERtdEdra2dnMzI1N1FWc3phdWlnOHc9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aab21c-545a-4dda-788e-08dc0c34f544
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:21:17.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0378



On Tue, 2 Jan 2024, Junio C Hamano wrote:

> Sören Krecker <soekkle@freenet.de> writes:
>
>> Replace SID with domain/username in error message, if owner of repository
>> and user are not equal on windows systems. Each user should have a unique
>> SID (https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers#what-are-security-identifiers).
>
> That paragraph your URL refers to does say that a SID that is used
> for an account will never be reused to identify a different account.
> But I am not sure if it means a user will never be assigned more
> than one SID (in other words, the reverse is not necessarily true).

To my knowledge a user account will never have multiple active SIDs, but
the documentation of LookupAccountSidA [1] explicitly mentions that it 
does look up historic SIDs.

> In addition to looking up SIDs for local accounts, local domain 
> accounts, and explicitly trusted domain accounts, LookupAccountSid can 
> look up SIDs for any account in any domain in the forest, including SIDs 
> that appear only in the SIDhistory field of an account in the forest. 
> The SIDhistory field stores former SIDs of an account that has been
> moved from another domain.

[1] https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-lookupaccountsida#remarks

>
> The paragraph also mentions that a SID can identify a non-user
> entity like a computer account (as opposed to "a user account")---I
> do not know what its implications are in the context of this patch,
> though.
>
>> This means that domain/username is not a loss of information.
>
> This statement does not (grammatically) make sense, but more
> importantly, loss of information may not be a bad thing in this
> case.  If more than one SIDs are given to a user account and
> processes working for that account, these different SIDs may be
> translated, by using LookupAccountSidA(), to the same string for a
> single user@domain, and it would be an operation that loses
> information in that sense.
>
> But if what we *care* about is user@domain between the current
> process and the owner of the directory in question being the same
> (or not), then such a loss of information is a *good* thing.

This patch only changes the output of our error message, though.
It does not change what ownership information we actually compare.
So if we had a hypothetical user Bob that was part of the  domain 
example.com (SID S-1-5-21-100000001-1000000001-10000001-1001) and
had been moved over from the example.org domain (old SID S-1-5-21-
2000000002-2000000002-20000002-2002) and we would detect a repository 
owned by bobs old SID, we would now lookup the old SID, find it 
attached to a user named example.com\Bob, look up Bobs  current SID, find 
it belongs to a user named example.com\Bob and print a confusing error 
message.

> So I dunno.  Arguing what we care about (is that exact SID equality
> between the "owner of the directory" and the "user, which the
> current process is working on behalf of", or do we care about the
> equality of the "accounts"?) may be a better way to justify this
> change, if you ask me.
>
>> +static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
>> +{
>> +	SID_NAME_USE pe_use;
>> +	DWORD len_user = 0, len_domain = 0;
>> +	BOOL translate_sid_to_user;
>> +
>> +	/* returns only FALSE, because the string pointers are NULL*/
>> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
>> +			  &pe_use);
>> +	/*Alloc needed space of the strings*/
>> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user);
>> +	translate_sid_to_user = LookupAccountSidA(NULL, sid, (*str) + len_domain, &len_user,
>> +				   *str, &len_domain, &pe_use);
>> +	if (translate_sid_to_user == FALSE) {
>> +		FREE_AND_NULL(*str);
>> +	}
>
> Style: do not enclose a single-statement block inside {}.
>
>> +	else
>> +		(*str)[len_domain] = '/';
>> +	return translate_sid_to_user;
>> +}
>
>> @@ -2767,7 +2788,9 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
>>  		} else if (report) {
>>  			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
>>
>> -			if (ConvertSidToStringSidA(sid, &str1))
>> +			if (user_sid_to_user_name(sid, &str1))
>> +				to_free1 = str1;
>> +			else if (ConvertSidToStringSidA(sid, &str1))
>>  				to_free1 = str1;
>
> Do these two helper functions return pointers pointing into the same
> kind of memory that you can free with the same function?  That is ...
>
>> ...
>>  				    "'%s' is owned by:\n"
>>  				    "\t'%s'\nbut the current user is:\n"
>>  				    "\t'%s'\n", path, str1, str2);
>> -			LocalFree(to_free1);
>> -			LocalFree(to_free2);
>> +			free(to_free1);
>> +			free(to_free2);
>
> ... the original code seems to say that the piece of memory we
> obtain from ConvertSidToStringSidA() must not be freed by calling
> free() but use something special called LocalFree().  I am assuing
> that your user_sid_to_user_name() returns a regular piece of memory
> that can be freed by calling regular free()?  Do we need to keep
> track of where we got the memory from and use different function to
> free each variable, or something (again I do not do Windows so I'll
> defer all of these to Dscho, who is CC'ed this time).
>
> Thanks and a happy new year.
>
>>  		}
>>  	}
>
>
