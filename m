Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22D288C8F
	for <git@vger.kernel.org>; Mon, 19 May 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679407; cv=fail; b=UogVCF+3ZVV0zRNlrKesMFnXOSQT9f0yktmNHZsFClF44ne3N3WlIU/6cDVUud1L4aZaGr9Oo0EmYgXWwJn1xhsIiNSvXHL5YfJGHRLCfP9LY0FEuieus50GhBcKN8jF7TQA3bESFG+PaTpD2wvBSQrEwHkvA9knjxDLyhyr56g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679407; c=relaxed/simple;
	bh=EcxHJ4E+hSkjg4r6A8P2Rg6yIv6J8X693tGoBoembEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHSw3urxS4oQ6RT0iYxW2ujFnf2oO4hGNNyyrSiGkuaKIN4mt3IqHEaUoG/qrVzq6alv1SDsPBec0Qg2s/KIZt8YcB7ZafFTMVW2ijG0++w4u4VdWVEnLyzRK2Rol07i4LJAod/d/l3buYT7fJiAwUXUTDUNz3H3dMeWJlunJ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LoDZtXCe; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LoDZtXCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owK56Zs29M8EJX/4ShDj2aJN/pNc8B1m6KhhHvz4J1spjHgH+rVtsHzOEmnpCLE/kcgpSuXOa8z5uO/W2wczstnzyeHlbvOR2XTJtcfdkhWmAAWItw1w63MiMWd49EdzbeGP/8jycen4vH6vnmIFIHE9eG/jW2x59PDtcMdeICi3sjzhF3nUs8l4wYV2Rskjf+nWWsBSDTOCHv7nLKZo4mDPMxyfiX4C0hDS9qxhBorXZNynBUCxsu/Dqu1cdcoz80YTDS7sZwaig7KskmXAWIsDgruVCF4z1CvoRG5QHaRi3EXpVB32Ur2nU92wXJlNJvZjqcDaYrVlp9pkAuHdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anLz5HroqWmrBLxZdPAwXA8kX1pzWvle61VbH4TTSHI=;
 b=lQ+JdSOf5hAwDpGFUg4HxkhLvwoQW3zBLBOUz81/Bwj+RbuT0LZCL7Iskfe+L+Soz8QXl4HRSvudjv5WST9cL5O6VdnC2ZCuc0BJqfebyE5gCh56OPRmlXRsgylHxUvEWgzrDKeYtf0hGKrIsn/+HmBBhDvYuNPJ3BYH5ug/lDz/Nt/BOrIfHy6B/XK8wQRz+GqORxJJdAzvTXRgCE6R391Dll45U5ZSP6LTaDtR0YQW87OvOISSQAFiIzwITzUNA1qW/qCz8Jbm7CBuA7uwxW2uU/z8C3XBfCKWUBAqYUJIiI0ThywI4hHa9Baa5bMXTJ340ArJRXxUa+zIH6t8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anLz5HroqWmrBLxZdPAwXA8kX1pzWvle61VbH4TTSHI=;
 b=LoDZtXCeAmmRW9N5blKmCKuGd0OLO6hKhtCnTpRO1eEu0aLVqEo6v61njF70RnRW8L5yef5lZg1d2VRYtIgASLVuLRmWHxiYk95eCsXJk7IOPYsc6ZvO+thayMyLMPdUSILwTdF8y72eur6EnPHZbIMO7wkQZynt2ushI0UR1kq6gdUfQOHQUZRMDX0pA8KB1m9o3C8dtFi33QLX4oMpTBjF7DfJyOCg2vSWUMQOT4heZN51G+oiSK2PHq/sstq217PwD/cyi+G4GCALBvZ881z8rIfx0Xmbgqs18h+pLUcB4cuFe7nCQjdfI6eW7erD4gVj9I1VjIN793yCJrkS1A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6941.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:30:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 18:30:00 +0000
Message-ID:
 <PN3PR01MB9597D02747FD9F3091C03C27B89CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 19 May 2025 23:59:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] docs: update email credential helpers and improve
 formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Shengyu Qu <wiagn233@outlook.com>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <A84F634C-3423-48E2-B648-068A75423037@live.com> <xmqqsel0mp8d.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqsel0mp8d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <1cd6de09-9cab-4b37-842d-db645cda653a@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 75606d09-da88-435e-99dd-08dd970329d5
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CelZlAGH5pkRuPTMvMjw4895HMHU8Hein46L1CNPdarSkgpaMW6f46dEk3DrClSQddu8OnrwfZ9hEYI0/Y9pQGkp6rcTCKOZWn52jHkSO8y3K7mtdNBSPO2TpI9VYdDOMghBgUU8/yUh1CU6TVlijy8yAeCQjh8ltRFQR3h+WGcDpdN2094fjboWGlRCl9nxqr3qTYI5acAhUDhfBfKpZptL6uEqmqluJ7H8dI3BKCzo6jc2fHZ1134lGnaje31kUAy/+dfghcE6OBNAVzhegnsd7EowXACnszFtmz+vW3UbmGhH9Qeu29mWv9uhSMDRZeAsGwu2F8Wzaf8o/okXrYPZXG7RRTcVPTVgULbE77oIiBuwpy8AYuSMt6KM0+zTA00KWjPvLseZudsXe9vqu/Y7hSvSC2Vv5nQieRNGDVPHrZ+f2Cz2LMdBhRowIbKWwcdMI+7bO/dkvjcQgkXvPdUAfGXWb1G7RRXDE+jeeymE0n0JF+jJzMSSv2dBUsNuK72H142HkvmHkFr14wMqIRkLcix3LKKRdEaEtabc1zJqdeNNRXBKou0Hqvz5XGP+VlszGl1lgdJ6G6WOvqoaAtDv/6Y2KUQm0mYM8puj6uDxbr65a8e6/AX+w9FYnQ6N6C+s9WRDP8RFpOFb6oSN0FiEniXY7o6u2021T1wK/emoeEDgYKA/otjdkQ7X1kzVZdO0xJmjZR4EzkTDJr93pYqNzDqCt4DXg
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|21061999006|7092599006|8060799009|19110799006|15080799009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGcvK3ZSV0h1VWthTkdiZXJmNTI1Yk80NGJzbHh4YVg1OElWVW04SmN4U0JV?=
 =?utf-8?B?c3dYTTRHNVR1YmRtZTF2czhubDU1Wkk4RkNXazg2dklweExmcnR3UEh5YktG?=
 =?utf-8?B?aGRvQjFyL29sYllENldtbXVIN0ZOWnBhOEZ2aXFPbFg5aTJXM3JqL1ducW1N?=
 =?utf-8?B?WXU5eFY4N1NTQ09CUk9ibTJWSlQ0dUl3aWh3czhkcTdocHFvRW8xVmgvZkto?=
 =?utf-8?B?ZG5CNkgxVzBCUjBTc2lHQkczNmIrMW1WYmtBVWRKY0VaQlBtSGJlQ2x5WUdR?=
 =?utf-8?B?c1hqYnRCNFpINUFhVEZNeTFjVVBkNDE0ZzAyTHlReHpiTDhTM1Jjenh2T1hK?=
 =?utf-8?B?U3JqUTR1UkVtOTRaQmRNUjZKU0JubWhiQitXNG14U2JPcHViZDhoZWkzTGwz?=
 =?utf-8?B?S24rbWNLQlBnL21HM3ZGTUVneWRTQlI2cnF6V1BXd2xiejFzTlEyei9FSzZI?=
 =?utf-8?B?d2h0WjJmRmlGelBzMmRodWRMZ2FBVmlqK0RaWWNQWjhDMFpBaitUcTl6elJ0?=
 =?utf-8?B?T2VTN0pMa0Q0TFFFYnZVdkFma09nM2ZCQ3RJdytkeCtRZmo5UCtMWlhTYngr?=
 =?utf-8?B?d0xBVDl0eEJqSFBtRHBGNUp2MmFrRDRRMS9DZVl4Q3hCZTR4S3FKM2hCbzZv?=
 =?utf-8?B?RExOckN0QVpsbmttUHJjdkpRUndwK3BOMWhyYkViM0dYRDB1YXdMTm9MWkFE?=
 =?utf-8?B?MTA5cUh0bk5sNHRicENROW1nSm5yYjd5ZWppN25lQktETkRZVFUvVFVOdUVl?=
 =?utf-8?B?VERyc2N3L3BrY3Z4c1I3NUM3R2JSMm9FRHRhU2lnUEpXNjlXZ1V0ZmdTcWx6?=
 =?utf-8?B?cFR3SElpL0JIeTNUVDh4R0V5ZTYvc1RHSE0vc2xnZXMrd3dRTm5PS3d5T2ZI?=
 =?utf-8?B?NHFRK2RUekg2ZHVKbktZVmljLzBHUlhCTEtsdHpmeXpkVjM0a1k1SlNkNGtQ?=
 =?utf-8?B?dE0wUWQxL0srZnp4RlVrY2hWdmxWc2tvRU9DWVl6VVRTUDNGd29yallScitv?=
 =?utf-8?B?OTJSS2pTZ2pSeFVtcjNrM2hEb3JoRFUvNFBrZWRlSmxETll1UVZGTW8yMTIz?=
 =?utf-8?B?QlQ4Ym5rcnE3Y0pYNmtkdFVnZFVidUJTL0JORDEzNk8weDdXL0pYYVhnQnBE?=
 =?utf-8?B?MFliZUtJaHVxM2pmRWtkbTV3MkhqNGZwdUJ1bG5vRmczSHBwZXdpN0lzaEFV?=
 =?utf-8?B?YnhaNS8xLzlSanI5MFphSER6a0hYQks1dHUxbmFYOWR2R0JGelNqU2FCYzBm?=
 =?utf-8?B?MnBzY3RFS1k2VGkyajdTVDludnJjN29mQ2ovNkJjSEhseG5wL0hmZlBmUmtX?=
 =?utf-8?B?WWF1cDlUdTUxelV0V0FUUHZidG1VMmZKOEZ2NEFreDJNVzB5RnJ6UzFRbzNa?=
 =?utf-8?B?K0ppTExzaHprQ1NwZEs2MTFwazFraDdibFU3c2U5VXExYzduSlU4anIrN2tq?=
 =?utf-8?B?NmRPSzlzUG1nMjcrRmtpb2pjVWN0RDZtNEFBNStSL1A3cEI2RFl0Nk1nNEw3?=
 =?utf-8?B?RHE3czJvVFoyOGdQOXJPZmpRV0Vtd3BvYmxyTndRZURubXBpZmorWHBCRWJV?=
 =?utf-8?Q?yUmR7hAAr33f0qio2ZYYeLU1s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUplUjBWUHZsL0RCVGl1bU1BdUJ5K2F3UTd2dUo0YVBVYmNtVFpQRkQ4cW5t?=
 =?utf-8?B?Nmx3a1AxREN1a3Q4YmNyRlVvV0dSRURHWWdEUzQ2NVI3MnNqcEJQSDNPYlFq?=
 =?utf-8?B?em1yUWJXOFBaZ2IzaGpLOHAzckRSYTM1RmNtM0ZVZkV6K1IrUUkzVnFlQjVJ?=
 =?utf-8?B?Q1FDNTkvN2pOOWdOVXhiMlJiamcvNlZaVzZVbG5NZ2VXY1lOSTRXeXhxY2Vj?=
 =?utf-8?B?d29mTWR4NjMzY1ljeUpPMVRUUEZwellSM05Na01JQVlNZU5PZ0dOVEZrL254?=
 =?utf-8?B?aTFVN3YrcTlwcGk5dHd0bXNzMzNYQ3MwR1Y0RUFQODRtekZFaGlvMm0rV0V5?=
 =?utf-8?B?VEt6dG9adkROZlBRK1RzWS9meTlwbGtXQVN4d1NkcWlCSzRweUw2NFpwUHNT?=
 =?utf-8?B?Z1RFbDhzZVU0bVZWQ05QMlcwYzcwZjdqTE9QdEFGeU5IOWg0aU54SU56OEJD?=
 =?utf-8?B?enYvbnVWM1lOK2ZNWngyTktzMGI3Nm8yR0Y0VGpIK0toczIxQWFpb1F5aGVE?=
 =?utf-8?B?alZtVW1vODExRklGc3c2MXNVK0tFMmltdTdvMDJTU01BQ1RyeFRsYlMyUyt2?=
 =?utf-8?B?TEY1TUhYSTI5RUJ2TWpyRVNoSDd3N1pJZW82ZzNsb2FzQmpMdlBwd3NrdVZI?=
 =?utf-8?B?OHVMSHVjQkFWeDBpSG4wSFo1MFY0dzkxQmlIOEwvUTZlWUFKRmlGT3o4Q2sz?=
 =?utf-8?B?ZnpJem1nV2lQTU1EQmh6dWI5cEJUVHdSd1N1UEZtZXJsUUVTRHh2M3VIT2hH?=
 =?utf-8?B?WVNKcTRra3cra2FpeUxDb3pOV0I4RjIreDF1Nzl1UDRFNTFQVVBLNUdpemlF?=
 =?utf-8?B?M0wrTXFySHk3RUlnSFoxeHdkL1R5NnkzQjN0QldkOEdOM1RkZnNHRmlMVllL?=
 =?utf-8?B?T1hBRlpDM1hkc1NRTjJ2Tnc3L3hZRHdyZXVvN1V4Qkd0aEFwZVRQeFlZUjZP?=
 =?utf-8?B?Mkphb1pmcTJDUEp1V0kzQXRBQ0tuVjJ4MVJCR0I5VE15alJLMm1wMTVjaVJm?=
 =?utf-8?B?WXdQTkU5OFZCWFdPSkszNUdzZjRubmhXWjhacThPellXNENaR1c4amo3ekN0?=
 =?utf-8?B?c0xwVjJDOXZRa0NSeHdDOFBRRU1XSTJGelNjOUtRVXZWZnliMWZTb1ZFdlZr?=
 =?utf-8?B?elNpdG85cTYwMHdjOFYyaUVHWXh2WTNDd3diZHRCQjYvS1Fuc2FmUUhWTC9t?=
 =?utf-8?B?dlo4bHRlK3NGenlmRlhFQ0wycGgzSWZjVHRqZ2VRN0ZkZW1FREZCOXk1YUFD?=
 =?utf-8?B?SnBJNXZJL3ZwZWIyWXV0Y21LTXR5R2VxcGdBcmFkb0dET3dHanYvWjE0Z2No?=
 =?utf-8?B?S21jV3VaVThWNW5vQzVuVjZnbUNZcmhHaTJ0NWJTUUUxWHdTNHY0d1A4OVhk?=
 =?utf-8?B?VG1uVjUxMFJmY1JkZ0JUWG1tdndnMjE0V2lXWE9CUENIYnFNTUxDVVUxZWho?=
 =?utf-8?B?bmRqQmlwSVJtVTFpZU5MR0d6VUZHWk9LTisyeC9hWndnQjh5ZWFYbnJYWk1E?=
 =?utf-8?B?dmVOWkxqYmJyOWR5TmFGNFZnMDZMeDB1c2FxK01vc0hPMUd4UlN4Vk1oVFla?=
 =?utf-8?B?NWJkQVFYeFBtQkVVRE1yT3l1SDhud1E0aUNTRVFVcXhuemRrZ25IUEhDc1V1?=
 =?utf-8?B?ZC81RG1MNzVkcnRUR2tLWWRBYTQyTkRiMFU0RHNZRU1PcnNJUjJnbytWUCs1?=
 =?utf-8?B?MWtKc3JUS1dtNFIyamkvSXQ0ZXlONTFPcndmUldMaFJtQXA4NnhNTThhVEV4?=
 =?utf-8?Q?uBm7lkeWLdgkSr2o5A=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75606d09-da88-435e-99dd-08dd970329d5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:30:00.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6941



On 19/05/25 11:56 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> 2. The second patch improves the formatting of the `git-send-email`
>>    documentation, making it more readable and consistent.
> 
> What does this series build on?  The patch apparently does not seem
> to apply to any recent tips of 'master'.
> 
> When you are not building on 'master', please leave a note to say
> things like:
> 
>  - Because this breakage was introduced between Git 2.43 and Git
>    2.44, and the area of the code hasn't changed since then, these
>    patches are made against Git 2.44.0; the result applying this
>    series there merges cleanly to 'master', too.
> 
>  - This change depends on the topic, xy/frotz, which hasn't been
>    merged to 'master'.  The patches are made on top of the result of
>    merging that topic to 'master'.

I'm sorry, I'll make sure I specify that in the future.

> 
> I am guessing that this is meant to apply on top of a merge of
> ag/doc-send-email ba998f61 (docs: add credential helper for outlook
> and gmail in OAuth list of helpers, 2025-05-08) into 'master', so
> I'll tentatively queue them there.

Yes you are correct!
