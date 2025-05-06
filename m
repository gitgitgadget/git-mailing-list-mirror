Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5128134F
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550247; cv=fail; b=Z6NzE5N62PJUXzdr9lqktTkMOBACVBrqNPYiX/HtUGxtH/lrBRxfthN1t5szrmj8N7/6o2xMM7aM41K5k7p/AHi6IEM1GwULkVr62zAadAHntkHA+MD4VMfJZx7cxknx2JoQlsKxFCE8EZWlFNXopkKniEsgyDia1wJ38VvpluU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550247; c=relaxed/simple;
	bh=ZnvoTo3loLHCHtPBquVBpN89LfzsW9kFQIHvSBbKoac=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bzBAZNox9NlUlqnQo3SP1IpBxSvdnehXHgGD69rK4M5S8AesRLJZJ5wF59UoANMvbqKMV8HIHxNF9HBm/eNo6NKHFDuzyUF80XpaeNF4fs/6eBDrppQ9p0EYRIvDgSAKUMH1upHWxuFcDHdyY+japAv09q2BkiZ9pUo1bFnKBjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YcPgLPSD; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YcPgLPSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3L/QkhBjjUonTHZWshTPHy5bjPTDtpKgIxl4AK80q72hOrjhxJZZfIV0nnNA/skRjy8gie6FHM95Dsir5aRrAe6oNzQ3COE2E1d05zhuZvwWAM6vvYewqs37Bcihls0KFDIYKe8GZy9PLq3/PakO5/Ubv9O1luFf5r6YsvfPWEKHxy+7l1Ygsd+Ncber/cPrJlSft9UWLN3F2sXRrW/uPIz2jJCE8VlQlt29recEy29VESGcckCvn86h23vOCnbejnqykPtY1VcW/K3/BvKdrRbU8zP1MDTf0H/wFaKqsGcA+LnbQBWTSqRfiof10eGPbiHfYcpCpGkVT0oVhkAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gu4EHGGXlEGTB5MA1OTCxIQUhwoha2AmnlxaABHrrw=;
 b=MirZON1SFTe1frpp6W/aJciwR1pt5jL5V/DVGl1Y/OV+JR926g31qTt+4K1mSJr464dIV1FRHqgkRxZAj6Zsf4bxxf8SizeNWdrlbQHxr5LjMo8TjNEcwHzOckNoT8QnHynLiFITZaogWM41116JbT8uRXSirCeXAPi8t7cPlNq0bzcqDlNO8wRWvgri1bJeWic5hLx1++vFjPO0tZrgO/I5TiXmoMrsN5B25TGIhXRbVA1XG8idwa0amDdx8t9wjOwm49vCGpboVg5VwDRGzU36aa2hoVQLSqNGNyekrAxTTMT2GLId6gMOptafi2ALpLU3lcSQdq9MHOBv74aT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gu4EHGGXlEGTB5MA1OTCxIQUhwoha2AmnlxaABHrrw=;
 b=YcPgLPSDCj+tyGxgc8sypMXFJPa8CxozKDhYoZBJunJXY+9pWe/h8++vkw4xLmZUvRYGUskJrJbuFMR+5uMQihU36CiTJUGcGSfly61HwcYFqYdGbjbXnPHctm8//UPqR5IsqQt1WrWNNk0gLw5BKjDzHzs29TQgmQMdxNIHnlGSd/uS9NWvrPJI++DVIqPJ8rfnpkntB32OZL2cs41rA/Zicd5m5BcHQF5NafbzOv/65NC9XmTGRyqPuUiGayuoDkC+dN5TTBZxY/cHfufF2oqReag+Qma0+2Xl8pub3t6ecZ5XgriNuYfsvTmSSdIx1j6CH7oth8+2cu4k3avAiA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9967.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 16:50:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 16:50:38 +0000
Message-ID:
 <PN3PR01MB9597E09838320FF9F403D255B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 6 May 2025 22:20:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 M Hickford <mirth.hickford@gmail.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Steve Hay <steve.m.hay@googlemail.com>, Steve Hay <shay@cpan.org>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqplgmlisy.fsf@gitster.g>
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <2537cc30-f6d3-4762-8b6e-0aea1e765a7a@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6611de88-2306-4fc0-b237-08dd8cbe20b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6072599003|5072599009|15080799009|8060799009|7092599006|19110799006|6090799003|10035399007|3412199025|440099028|34005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU5BbU9IK0UzQnFPRklSd21rWml1NFBCd0RuSXp2dWE1S0RSUkxEUnZ5RmNv?=
 =?utf-8?B?U2pkYkx2TldET1VoUVVmQkI2RmhvNWpYLytQUHRmdVJ2SzZ0a3E1VWtzSlpj?=
 =?utf-8?B?R1dBbFhncnZDN3pMRDNFZUpTM01SZC9HS0o2ZWwyeEdwZm00R1Z4R21tR3Jh?=
 =?utf-8?B?K2RwRmU1QWVBUnNpZW8xemdOOEVvZWx6QWc5LzR3OHdHNVcwcHVhOEVqMzlu?=
 =?utf-8?B?UW55dHpXMDFwM1QwNE93K3BLNHlVK0ROVEhRSU1qckZPUmJXNlpweFJNL3lO?=
 =?utf-8?B?RlNpK2krUlBnTEluQnFKOGpIV1RWeXN3cVptY2UzSHBVOWJsaVZaUFRDWStp?=
 =?utf-8?B?K2pmS2tEYzlFTGg4RHVHeUs5L3VEM0N3QXJDRnUwK2VXZTArWWt6Zks3MmFC?=
 =?utf-8?B?NWVNYTlBMSt4M0IwTkNCSjhDeCtDMGM4UmlkT05iRGpWNnBCdjZCZUJJNkI2?=
 =?utf-8?B?cXV0SHU5NlhNZnZlOUs2VUM0elFGL1p1UEtpaCt0UEtIRnRQMmNLbkJJcFRp?=
 =?utf-8?B?b29nbE9oQ2lLTUFiWmxIeXhZOWt1eTRabjR4cDRZV0pMSnpNamlLVDRVUDRH?=
 =?utf-8?B?T2JrbnFtOWdkUldKaGVJOVM0STJWN09qU2xMaERJSE5yaGFtV2YrTXFlby91?=
 =?utf-8?B?Vm9hMk0xTUVpZjlMcm45YWZUOWR2em5zZTBORnNrNlI5RUtrZVoxZndiRmRu?=
 =?utf-8?B?WU1GVVpxYWZpZ2hSY2tEbGZpOUhyc21CR1I4blhDa3BNcHFEaHBDUmNZS2hY?=
 =?utf-8?B?V3l0MHpNZjlWRFVOZGtTQTN0R2hkOFkvdUc2SnpJVUhyTXQvRU9KZUN4Z3RY?=
 =?utf-8?B?NjRYNFRQT2lwelVaVVVyS1NhY1grLzdSVE1nVFBiMzh1VnlXSHduRFYyemxx?=
 =?utf-8?B?NStPRG9GL3JMRmlyMEVIcW90Z094UlZYVHZzMzFUUXJUZnZ4M0tMSDNIQWIr?=
 =?utf-8?B?YTlDZzdLSmVKanFwT1JadlZWQmVOTm1zSWtHeGdWV2NpTFZ2SjkvZTF5aGw0?=
 =?utf-8?B?WHc2RnphczVkVEFITkcrRCtyeXBVWUZkYzA1OG9tckE2WGVQZ0JvMjI1YlhP?=
 =?utf-8?B?Vk1ZbEVjMFpwZWJNdktmTjlsMTNjMUZwVkVhQ25BODVMQUkrUmFYME1UUW54?=
 =?utf-8?B?UmNyaFpiV0hvRElHQ1QxMkNyVlJ2aVlWc2dySVVTQXozRUZCZVFhM05vT1k1?=
 =?utf-8?B?UWlWRm84VCtucEJLRkJKem8zUkR4a05YaGg3bGxJTTMxc1Vwb1Z6YWg5a1NH?=
 =?utf-8?B?YzZZaTNEcXppcktKQkJDSldSYkdzZ0lQcFRGa0phLzBxM0s2emUwWHFFblI1?=
 =?utf-8?B?QjNHTDlPZWdxeWVRdnRVNHlkN3drUzNldkxHOTlYZldudjl0cWE4d1B6ZDBi?=
 =?utf-8?B?cXpSWk1qb3EvS2ozMEg3R3oxZHVUQlhNb0pCM0huM3d5RExJNDMyZXFWYmhn?=
 =?utf-8?B?MGg5RkdUbHp2KzNWb1l4R2R2NlQ5OHRXY1J1bHpSQWVRTWliemJqYVdJZ0VZ?=
 =?utf-8?B?N2pOOEQ0emp4ZURLRWpQaWI5NG93MnI5YXFSWnFHMWtPTVhZZGdsOHVHWjlu?=
 =?utf-8?B?aVBXdVB5emQvZ2JCS0xZQm5odGxoUTlJd3VLYkpQS2EyMFRZcU50QkNuU2Nv?=
 =?utf-8?B?QWh2aEw2UnBBR1Q4TDJaMDhrbU9BNjJheGREN3RibUwzTnpRWmFPZUNKeTBh?=
 =?utf-8?B?Q0ZDMGVSWWJUWlVENWQwcjlEYzNyOXpYTzFxYTdyN3oyWi85KzNzTTlnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWNOemt3V0dJZEJ4ZTdoR3lNZlBKWE14MnlscDlNdE1henIxRDM0Zmk0VFVv?=
 =?utf-8?B?S3VsYUxvakNxWm1EaXNOZS9EMENDbCszcFJqOWs2RjFOVGc1ZWdkbEpZQzdK?=
 =?utf-8?B?cnJXQkdwOC9NU1JFcGpNbkpIa05uOFVaT21PazdwaFlBWUN6eGNXMS8xdVpa?=
 =?utf-8?B?bTg1TFBJSXhaRFJqSTkzK0VmVjI3aEo0SVlyQlFGYUQrUXQwR3pRVGtoRjZQ?=
 =?utf-8?B?anAyWmpVK2wyZ1JUS3FlU1ZOMWVmTnE4UDhYNmZnWEt0dk5KVHErWk9PQzEz?=
 =?utf-8?B?alhDMll5SmZzYkorR2x4clc1OUxNMFRvODRPbGsyWm9kZHJQOHFpWUFBdzdW?=
 =?utf-8?B?aEFaRG1qMTdhcEhJeUdpYm85ZG84eGpNL3NLRGtSOHEyVnJpWjdqNDhxMmNi?=
 =?utf-8?B?Zm1YeWtBa3FUbGlTa3ZENHhwTFpCTWM3aFZQS1phcHNyYjM5OWM0c05VdGZj?=
 =?utf-8?B?eFl3R0wrSEtvN1ZYVTY5L2NqY2VkcFFKOVJlbjdYT3d6aFNoU3VzTkJaWHNF?=
 =?utf-8?B?MjhmUFVOLzNPMFFtb0txMTZpWVJOTTJHUjZta2ZyMEpQeThDYU9wb0dZdWhn?=
 =?utf-8?B?RkxVOFI0TnhST3VxNUUwMG5UQlVPUlVXK09TSUE0bXY0eDVEMlBzb1RLN25W?=
 =?utf-8?B?aU4rbWtVRFQ5Q0NXRUdoQlFpQnhpcGRWUGp5SW9uenBWWXlhNVdndnJ4YW40?=
 =?utf-8?B?d2NGUkJpVHA3M2ErdVVjcnp5TFBzUTQ2OXFpZ1BwRUhyYXEyb3Y3a0ZaSDQr?=
 =?utf-8?B?ZzAzVkZQNk1aSklRWDhMd29HSHF5dGJyU1hTaUNXT1NQblNRMDFsdGorcmRu?=
 =?utf-8?B?emVEV2toakVQYWZ0OFByZTZzek1NNjhKS1FLVmRWVHdkT1N2UU5pdXd6WlpY?=
 =?utf-8?B?ZUhjb2l6eVZKK25ieEM1SXA5cGdrbnFDbjh5djl0UC9VVjFjc2ZzMlhncW1H?=
 =?utf-8?B?VXBoRFphUVpzS0N6SFBrcVpKWW5KYU1keDNFZ0cvbnJiV2NUZ3g0cXlJSFZH?=
 =?utf-8?B?cG9sMytJampIM0JRL0J0czE4bnpuRis5T2p0MVZ5TElTOFBHK1ZOVks2dVpK?=
 =?utf-8?B?V1grQ0pDYThiek5PdXpLek0rdTVMaVBGaGNVSUNFZk8vSm8vdjFuUUU3b1U5?=
 =?utf-8?B?V2grNHpYbjQyQkt1YWp1NWdDWGVtKzNPN3QzSURzRU40ZThNYjA0S0ttRUlv?=
 =?utf-8?B?UHZzeGZBbHNybU1QS21IYUU0N3Z0M1kvK1FZSHNlakFPZTk0cHpxQ09iaHAv?=
 =?utf-8?B?cXFFV1FpQkpORHBOSTRDdUJWL3ArZ2pnMndUa3E0YjdTSHdZd3U3WGFxZUJl?=
 =?utf-8?B?VEZJdVcwQ25zbWZGNkRHWWY5S0ZTbWFEVm40STgvUkI3bGMrakthVEkrcVBq?=
 =?utf-8?B?QkVaZmdOdGVVcjJlTFZjZ0J5SXFTeXhJc05rWnFaN1IwU2R6aHY1V2xkb0pn?=
 =?utf-8?B?YWc1c2hKb04rS0xBM1l5SjlXL3ZkV3NYd3ZYbVovekFyY0NLMmVWei9vTzlI?=
 =?utf-8?B?cEVtNUpMdGx3aDU0QUhqeFFtdWNVTXQ1NjQ0ZGRYOE1TU1VJMjFaQi8rRnkr?=
 =?utf-8?B?UzlsUVo1TjQ5VGg0OUF6N0ZPRTFJTmYzNk9VK1lOYkc5SzdhOEI3ZGpCUjRI?=
 =?utf-8?B?dkp0dGlQZmpWRmoxRm1rMGl0TzU0YzVIczE3UG4zbkwzUEZsbGMra1ZrUTRs?=
 =?utf-8?B?TTc4VFlHVWJlcSsrYXppUEJsM1RieEY3ZWFEVWtMZk05a1JnaHVYVGNmVE9q?=
 =?utf-8?Q?mtrCAVdVv8/TGN6FvXsOPROATYaqarr9erZtpwN?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6611de88-2306-4fc0-b237-08dd8cbe20b5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 16:50:37.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9967



On 06/05/25 3:05 pm, Aditya Garg wrote:
> 
> 
>> On 6 May 2025, at 11:08 AM, Aditya Garg <gargaditya08@live.com> wrote:
>>
>> ﻿
>>
>>> On 6 May 2025, at 5:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>>>
>>>> Due to current implementation, I was not able to send emails from
>>>> Ubuntu.
>>>
>>> It may be that send-email did not complain, but I have a suspicion
>>> that it the above is only half truth.  We do have an ugly last-ditch
>>> fallback to claim that we are localhost.localdomain, instead of
>>> using a misconfigured maildomain name that servers would not like,
>>> but that name is a meaningless name; from the point of view of the
>>> server, if everybody uses that name, the name loses the meaning as
>>> an identifier.
>>>
>>> It is more like due to misconfiguration you couldn't send e-mails,
>>> and by tightening the condition to tell an invalid maildomain name
>>> and have the misconfigured maildomain name that is invalid replaced
>>> with "localhost.localdomain" fallback, you managed to send things
>>> out.
>>>
>>> The real fix for individual users may probably be to see how
>>> maildomain_net() and/or maildomain_mta() gives you a bogus
>>> "Macbook.." and fix _that_.  Until that gets fixed, trying to use
>>> "localhost.localdomain" fallback might be a good workaround, but
>>> that is a workaround, not a real solution, isn't it?
>>
>> I think I should dig deeper on how the domain name is being assigned.
>>
>> Maybe its time to fix another perl module after Authen::SASL?
> 
> I've noticed bug reports regarding this in Net::Domain perl library.
> Most reports seem to be not addressed. Maybe its no longer maintained?
> 
> I think we can add a minimal check to ensure that there are no two dots together.
> Does that sound fair?

I have opened a PR here to fix the Net::Domain library:

https://github.com/steve-m-hay/perl-libnet/pull/47


Although, this library is still seems quite unreliable. See:

1. https://github.com/Perl/perl5/issues/17135
2. https://github.com/glpi-project/glpi-agent/discussions/345

I really doubt the maintainer still maintains this. I have added them to the Cc though.

As far as the script is concerned,

- The script currently checks the presence of a period in the fqdn.
- At the same time, the script does NOT check whether the fqdn starts or ends with a period.
- Also, it does NOT check if 2 periods are together or not.

a fqdn without a dot at all gets accepted by my Outlook server, but the next 2 cases are a big
no. I think adding checks for these cases should make sense, afterall no FQDN would have these
things.

