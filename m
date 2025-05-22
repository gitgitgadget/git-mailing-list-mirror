Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34D27715
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942841; cv=fail; b=haVN6Q8yncKIzd+BYMwu7JY6yGAarVvIrvOlYnloIW9HDlLo1xN6XRe9yudccERohCU8Rkgv/SvbCJuKZPzOBVer8Xe9aWj9ALvUB9lk3ji+dnRzhhZbqz5GTBiyGw77H4kRmMiQFGpUU+WN16iOdmIzMYGKnqGxkRsDzL8IhMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942841; c=relaxed/simple;
	bh=VKD8PfMynYM6D9EuS2+oOeAdh2Zw27tHY1gXsG5j1O0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMcKncqOR3CR5MSsls+6iwT1dV0sqPo3DJhBTY2gqeGel5qdbgSNdXQIAU6D/bfYxvzhL93H1xOIWsDC+VZ0puO5IZTdmLMmLGFPukLi4Rp7lQPjZtw7yKfeteD0NI26sOTJKmzIvVN1DEqhzh7LTem8z6F36G2emwCdPP/EboY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Dfv2KR9V; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Dfv2KR9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXdbW3qG6a8cpuuhl8vYrNkGAf7sRbgBCijg2TsSk5PJzVuV0VrS7nvX9GdsSouOYq+qrj14mScMy7GtbK2Su+DzzSBkSoIX64VAjwjDQCcj+jGHECF+yxEkYwk89Y2ONxCrlky2x4/e1fSBMHpCQTcAsY1pjPTL6nxa2LAnb+uOre+HngYYKVFnGB1rPbug0vpbSzv1npUJb01csTop0hfK3UU7i6Z0M82RDaIC6rWDTGxJDinIXOdcJ5s79EOHeLffcf3926RB0pa7HRe4w6GY1a9Y3k4+h3kie9X0FJzBqDj1OSAi1Mpnn9qQAOXa1UTO9rsMb9an3jSqLiQFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqnV3ofiqmz1dv0OQDfh0U7kkYeSkgla+GVIdbn2EtA=;
 b=uGMh1RKvHL+JX/Vxrh6x732M/F8HRqsDXKoK1b6M+2nAadtuT8bXG61lExvscoG0GiDojqNWd+FE0DHsPJ10JHY19kDjxmN7ipZtkguETa2cE8mLASo/O6cUdIUmD0U4TwccsB3nCzeywh0WKxVCujnxNJ2LAKJPYvFB4CixpUTU3OPNMGuaaDtudSWerBsOEEP4n5W33J39kSoy6lob3DnHpVNMUKe7sGrR6gmhMdbvm5c43Nx2IiYNogE2NROfINX5MJh0n3eER2cHlr8uPSDout4UXTes9ykuo+phz7CgF3XbML3LRNMD90hhtr1Qwbdy7kntcDYds4AE/p4k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqnV3ofiqmz1dv0OQDfh0U7kkYeSkgla+GVIdbn2EtA=;
 b=Dfv2KR9VEgZCS5P+ZMv7f/EnjhBoSvqvlhr360zLPqIlQgU+Ms3FnSCAdN7bbb0ofux9B9mk3XAR5t6w+sTOz+1GeIpwOyiokTJXs2RuKSSl3aibqEEJttaWSBdIEJ/G7ZlkN2dHriT574VAFQeKIcW2w7z9udk7vsYLN68DnthhBH2m8PL3EL3p9BQ+sVJh8Qkwh6yF1QyaR2g4qnj5m/Zym7DVJfyLoDHiEWwYX9xWPacrDq4yMyu90tRGp9bVYK2o9gZyZtKImWhMNi1r7U84nM3wy2F+oj+7jivZx3wxZ7A4vnWmwxLwVag2sKdijbA71Bm1yMHQBQe865qnag==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4339.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:15::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Thu, 22 May
 2025 19:40:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:40:34 +0000
Message-ID:
 <PN3PR01MB9597FEFB450A45DA3E9E0716B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 23 May 2025 01:10:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95972EB02A873B8998F51877B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cQkrwy2GBNh7OdBAzWnuSo7mVH1XFUyuB7LzJ4cMf10MQ@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cQkrwy2GBNh7OdBAzWnuSo7mVH1XFUyuB7LzJ4cMf10MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <b03f3dc3-7bd2-4288-bfbc-a5b06d47f0cb@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PR01MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 01915785-a038-4b45-4fba-08dd996884b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2xaVVhKVExYWGxwdnhxeklqUmtjUWwveW1pV0FTOTR4LzhJTEdYNUdwU3dR?=
 =?utf-8?B?ak53MkxleFA1bGtNZEhhL0l2RVdYcFRBVWN3c3Z0b3pBa2ozVnRnVmNhcTV4?=
 =?utf-8?B?ZktPaTlqOHluYy8vdjB2OHRTaUpPM2pFVGxncnprQVVaMjV2Ti94OEo0djZr?=
 =?utf-8?B?c0duamRZNnFiSW1jYkxMR1BQcnlkdm1IWFNUSUJvTGwwMnNWc0VUL0JtaStJ?=
 =?utf-8?B?aWoyUTlTZjFja1NlV1hIZm9VaytMMTRvNHFKR0lPVVdVNzk4L2dVbDRaNitI?=
 =?utf-8?B?Z0NFcVBLZGgxaElER0JYRlVubzgwOWx4NzAvTEliTGxrcHA0aEsyYmF0YjR5?=
 =?utf-8?B?bkZ6dVNRUXZrZlR5T2VxUDBYLzhIcDVjYWt0d3ZPTitJVUV4dnJTbEN1dC9w?=
 =?utf-8?B?Wm9iMlRZUzVwWmdzNFNNdFVyYVFzZHhhcWhSaDYrYkNNVmRtOTUvWTc5VHhN?=
 =?utf-8?B?TVNGQk9OR2pzVXpQZFhyZHdvOGl3aWxzNE5CKzBzVDN4bi8yL3l2MmE0K254?=
 =?utf-8?B?clZsQkxyZkczeFQxUkY1TGZScnRaTVphOEsxR1JtOHIzMmlKVE96Z3dheXVL?=
 =?utf-8?B?a2J5TzJUcWJOWnBsWGh3L01RMGxCaW10ZG9QLzJSOHFFVERDWFg0VXpGS0hr?=
 =?utf-8?B?VmhVODZrNXExSit5QXovTUtqbjVpSW01QmpuNW5tRTVLTGVCT3E0M0J5YmRN?=
 =?utf-8?B?YVlxV3NiRVJRSzdycGhjSEhkNjhrdCtPUGlUa1NiZXVlZ1F2My9CMEZocDJj?=
 =?utf-8?B?U0tVZTZRblVSNzV3cmRIMEJDMC9vbWNqOTNMKzJTa0RuMU04bEVoV3g5NVpa?=
 =?utf-8?B?WHlYaS95dU1JYkRDQXVRTGJZaDQ0RkxGMlJHbERRaGFmOFlSRXlWZjNDN0Uv?=
 =?utf-8?B?ekZodHlSa2JHc3kwcE5Jb011SkpUOGpMQ0hXL052QWQ4NnlXRm41dzRYV0dh?=
 =?utf-8?B?aG9BMDUzbFV1aW1NVGgrbS9KTlZxTHhINGs3bEd1NkYwSWtRaXRPWFJSWFdo?=
 =?utf-8?B?WEYzWi9BY1QzK2FwSnBtbTJNZzJqeGc4MVEwMVNva1k5dmZXVTFyZVlqTFVa?=
 =?utf-8?B?QkJUVitBZWhaNzVHdzA2YnV0aklqaEpKMzhmeEQ4UnpFMG8xR0RNbnppU0dV?=
 =?utf-8?B?R0xiSjZtK1JjSk1OZmZjMnFiSzZBTWRtcHRyYjFaM2lzcklYdjQvbDk4VFhm?=
 =?utf-8?B?TjFOaHQ2aXZqOFpFNUZLY09kUFNUcjFWWjRoZXQ4UktWZmV0ZndSajdtN2tP?=
 =?utf-8?B?OWo3S3hQTHRWVWpYUXJXcktOZnkrdXVOUmIwRTNoZnF3R3RFb1pVdGY4SFE1?=
 =?utf-8?B?WUI4QWFmOG9oYksrbFJrS3ZHMUYzMXNEK3hYVG4rSDZ5c21tZCtwdUZwR2lm?=
 =?utf-8?B?eVZobzJJUEQrRkJIOG1EM1VybjRmYzRiNVhrRHRQcFo4dWJWODRyTEszZmp1?=
 =?utf-8?B?ZFhGYXRnL3FFNXVMbEZSUUozUU45L25Ycko3VnI3V1Nqa2RjdHVLVTJ2YTJG?=
 =?utf-8?B?MWVlU2dRK0JOeUZtYVpRMkFMeFdidjNYOE1EOGdLeGxwUFpQeEZ6bzRNYzFM?=
 =?utf-8?B?dGFPcGdNSlVpM2dtclBFNlFlRWFtbFNYbGJXUDhsUjRiL0kvMitoZTBzRnJv?=
 =?utf-8?B?cmsrTVFuTmUyY250aWhuU0w2VkxCc3c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZjbk5RRG81UHFpOWRGRGxpeXI0TGp2SmFleGZuVnREK0l1TW1KTWpEQjB6?=
 =?utf-8?B?NTdsZ1VFUE5qUCtMNVIyR3E1TDJacVdocHZKWGV0SUE4VDNhWmRMckVKK0ZX?=
 =?utf-8?B?bXB1bmk4VzVMekt4aFMxUFhML0x2QVdQVC8reUlOOUdyRjY4eC9BK2pTRitj?=
 =?utf-8?B?VHVpU2M4V3hORVYzU2c4cElwcWtKOHZ6MUI1UXlqT08weGFmbVAxM3hGOXhs?=
 =?utf-8?B?Z00wUFpZR0wrRkoxTjJoYVp5KzZKWlhTVGhtWTM1L2xzeWd3K1JPT0FwQXdW?=
 =?utf-8?B?WWJSdGhSRVdoRHgyNCtKTTNlTzdIREFIcmRTUm92ZURiTDdOQmlrWUxWUE9t?=
 =?utf-8?B?MVdaZ2dFNmN3VFBxdmZYN29aRGNWcURzQ2FtYWhVSmRNQUkyWG5pcFBncXFr?=
 =?utf-8?B?N2wyL0VYRzVFTEZsOFdXLzBJd3o1blFMeXJ5b1NDaFgzQitFK1R5NkpCM25a?=
 =?utf-8?B?VGpJaE4zZExXK2hNSWp2ZG02M0s1aHVWekFDaUJHM3VHOWE3VG1hSjBnYjh6?=
 =?utf-8?B?dFU0dWVHTkozNk9qWlJzZXBtSENmV2ltaGdoWlc4dXJ6aVhxU2tpNmVzZGV1?=
 =?utf-8?B?WDVoVWlaUGtkazJqSXN6NHljUXJLVzVlMGtZS2IvVEUvZzQ4aDcwK3I2WmVi?=
 =?utf-8?B?SFBsZnQ5b0YwMzRBTEpWVlp5Z1NuU1NNZTgyUmFPTW1RbkwvVzRBcTdQUklY?=
 =?utf-8?B?TGJPOHFRbXlXd2toSEl2RE9FV0RPVStRdkFnNStZV0RCc21jc0xidnIxVVlZ?=
 =?utf-8?B?dkFwbXdlUEFNam5jRWcrUzFlR3lsUEcwQmNTcUt3eTVOQldEdDlkdWhEaWpi?=
 =?utf-8?B?MkYxemJ5VGJQaFdqMzV6RjZqZmdRU3lMRGt5S29lWk1QYm05d3VFanhEV2Fv?=
 =?utf-8?B?Zzhyd1FuU3I2Tkpnb1kyYnNEZVJqbWFBVXdWMkJocEJvaWpDYW9SU3dnOWp0?=
 =?utf-8?B?VkluTUZUZ3ozMzJvSURBb3ExUjZJNVI0b1d3QVdwNzlOR0pJT2xEODhidzdz?=
 =?utf-8?B?SmZJQWpUM2duTHJMUnJTRyt3VVh4N1R1bGV0WUl2VnFzMjNBZEE3bmsxZ0VY?=
 =?utf-8?B?UU9ERnVlNC9RZkY4MHNLWjBuTWdoSU1nS1hrL1cxQnkybDlKc1ZwRW1jSXp3?=
 =?utf-8?B?NURQSFk4TTFkZkFkN3JtaXJOZVo4Q1hRdTRiZFJycVhEUVM2YTBaSlQvQXU5?=
 =?utf-8?B?d0x4bnN5ZnpwQldiUExFS2ZQUUxLUitSWXI2OUtUTG1xbVJ4bXZtR3kzOEww?=
 =?utf-8?B?WkpSMURUaEJjU2N0dVY2SUQ1UzA3b25iS0Y4M2YyYUc4ZldCUVdmcndHUEtW?=
 =?utf-8?B?Q2xhUHRveEJleWJIVjdlQkRLeGgycWtVdmdneE1xcnpGaHdMV0hPMEdpR1Np?=
 =?utf-8?B?SklseE1Ta3N3NWp6NXFyMjRGRXFraHJJc3RuTDE2a1BROHlUNjBhajduVUgz?=
 =?utf-8?B?eVdRSkJpMFFMQkRBcS9YMTVoSHNYd1FETGZyWEs5a0xnb2FWbjdULzFLUmRw?=
 =?utf-8?B?SkhPdzk2ZUxTT1VqUmt2OUlnWVh5Ty9KWVNJbTREV0YwenZDQnQ3MFRaVGt4?=
 =?utf-8?B?THhMVWhPb3ZOaGdjQXIxa2xhTXRQaUJyYmM0N21FVnNHdVRWS3oydEdLVWFM?=
 =?utf-8?B?SmhhNCtraktFSmFic1FkaTdiU0gwZEwxTzQzbjlCdzBON1Y1djNoNk0zaXVN?=
 =?utf-8?B?STFlWlU5RUdlRk15TUN1a3RSaEc2alJOMEZpem9zdGZ0UXMwakhaVTRsaVVt?=
 =?utf-8?Q?jtgMfo6e1AqSO+OwIs=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 01915785-a038-4b45-4fba-08dd996884b5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:40:34.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4339



On 23-05-2025 01:02 am, Eric Sunshine wrote:
> On Thu, May 22, 2025 at 3:30 PM Aditya Garg <gargaditya08@live.com> wrote:
>>> Not sure about server_fill_credential(), but I think this is also
>>> a potential memory leak
>>>
>>> static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
>>> {
>>>       int ret;
>>>       char *response;
>>>
>>>       response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
>>>
>>>       ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
>>>       if (ret != strlen(response))
>>> +             free(response); // fix for the leak
>>>               return error("IMAP error: sending response failed");
>>>
>>>       free(response);
>>>
>>>       return 0;
>>> }
>>
>> So this change leads to:
>>
>>   imap-send.c:990:2: error: code will never be executed [-Werror,-Wunreachable-code]
>>           free(response);
>>           ^~~~
> 
> Is that because you forgot the curly braces around the `if` body?

Yes I did forget. Side effects of writing python for a few days ;)

Not working on the port leaks rn though, the logic seems different from the strings.
And again, feel free to treat rest as a bug report.
