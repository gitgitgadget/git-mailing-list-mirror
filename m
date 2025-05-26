Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE941DB546
	for <git@vger.kernel.org>; Mon, 26 May 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250401; cv=fail; b=OrGh74ExOW7Wu2Ix6iYKZnJiH6LpaPrVBXrcr1KMlM8io0cQErygpTP4soBOp/VUrdCyV8L+NWQzonEE5ACiyxPUxnZLu+bJyTDxYr0jVN/OFw7LjnYPsBwF98naVmL48d+BGUnlERVx3QReg7bNtZHWmgvgbCTIwyyC2t0XbaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250401; c=relaxed/simple;
	bh=KzWe52706SwfUWbV2HTxb85OAdSXX6DeI9UFPUsykQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beAY1jAzPaIvyamHZ1C1uJgoIAA81DsvPyyj1ZY9FX4SbkFxM9OjB8NjteanGm4c/xgI5gkc3duem2t4KFpV5arz2uxyoob6JV1zDhX89I+EBGhSUYqBtJlrxawGSo95xFrfbyd3CNjoawS0+qSE0kCqTWluJ6rs/0CHnCfvP3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=iz3TWkzd; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="iz3TWkzd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSxBHesQZvJdk5/om+fRaXO4fXAIjNaTr4EJZZM4AYDee/wpcQjlwV0quAQl72W3/FmyWS2fKQzcAClPnIvgJaPjAK3gkst6KS8qLoGDVDoAaeWsRucFNJDNfBmme8ucWAe+1E/DTd09cVULoQ5XsrWsAjJ3ANOvq5QSr+uAQd0ZxdawxdaP1wMdtDHin0ejpR5/7sBYF/t4LYkLvInbj0UmDi7h1FLd6BKAHnhCDFzk2GYp0MC9Tl0sVQP5OhrdE1+FAC7FAQHyGjtcMvUTeXEilrr1DIFreKCx1TAXs6Pxln9Qp4d44wFAUwhxHrH7HEylVQEAhcAAuha771G7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo9A9oR8iXB93uQJGwlDY6JTCg67MKfVMtpXdqnFz5w=;
 b=wN0dD9pGydRdyPkh8yfaZC8zo3feANd3ts6aAKwhujA4d3aQYbrr/sZ1D+MlRMndzFy7QjlS2gi3acxOYWZ97W0TWKmACbn3HlNo62j0lMR7QB/4dhWtjt1kMUkmfD13krsTUDsiwlPB+i8iTNGdaMIfqO24Q2bK4wBYpZD+3UuLvVH4zLadXR6+dmHPX4L0cKsxoS1my1VGG7rMKKms0/TDJLk7FBJVqF/+lwjZ4+uNM7b/t9NCM9FYNUm8QJUkNFPTTA5Ksj/J8liyymnBQ3mVvgAQNnzLNAE5ec9Y0CSyrLGikj5rZ/wvVz+rbi0oY8bmBw6v1NQ8aI3jw2mO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo9A9oR8iXB93uQJGwlDY6JTCg67MKfVMtpXdqnFz5w=;
 b=iz3TWkzdYIO8zV+RFGlCp7HdtTJSelhiOQnOQQq1Ri9v6YwuScKC1yMaeND9NrLppwH9PRyYsZiKKBQ4HcX1KkegdHYWq5ruMl/Ll9BkOmZwgy3jEn8F0cQ5E318+F5EI1tShH9Sk2XqXWOIrGR3byFMxIPM3AZqI6S4t5W6ju1TrT7B6WKH0+0IMzhmUhC1wDXGxkvTZSTTrWqMYllqm11pJxCoUmfEZrLXPnBbt3Uj5I8BhEvK2A/NdGIm74r6uRGvFXRzGixlGL1SGJYBExvOufQCqHRUu4uQ7goshWArFLS9G6R93vyK0uxKCbZ3rUITod5HP+93nuONqwg+5Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6208.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 09:06:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 09:06:34 +0000
Message-ID:
 <PN3PR01MB9597533601501DF4EF04C99DB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 26 May 2025 14:36:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] imap-send: make it usable again and add OAuth2.0
 support
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
 <CAPig+cTdaGsJpaE2wHv9miPyRk2GusETOykmLT2O-MGiavfY6g@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cTdaGsJpaE2wHv9miPyRk2GusETOykmLT2O-MGiavfY6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <e42f16be-b740-4b23-b197-260f74181841@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f71d8a7-0b7f-4511-f948-08dd9c349d28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|6090799003|5072599009|19110799006|15080799009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDhLNDhnekhHNGZZK0VhcWhaVy9DSmU2MnpMSFQ3cmlFUldxUldhblVTMWlq?=
 =?utf-8?B?OFBJbkwyb29xL3NaVXJnVTJ1WEdmanFnLzRLd0ZLMnZaRno3K2FNcHpXbmR1?=
 =?utf-8?B?NnlSc1FZVFZDOW9oTC9GMmQzSFpBQUNhWnptalNRUFF2VkJaQWwyUVoxSFJM?=
 =?utf-8?B?Yjk3L2FNUTV3UXFkZy8zWG14OEZhcHN4czY2MEtrOGlNd284dFp4ZS8vNjJE?=
 =?utf-8?B?d3ZYQWp0T21xOWxtTjk0L3BhWjMvak5ZOU5ZT0lTSE9nRzBRTWkzeXJYQWdR?=
 =?utf-8?B?NU5SSEEzWThpYmpJc2s0dU5iTm1aTFdMVkFhV1EvV3NPNnZkbU9ZTXYxbi9K?=
 =?utf-8?B?T1JtQzlIVXB1T3dKU1EzTitVMHlFbmV1dHVjNVpmZTJBaEhDblBqMktFODdq?=
 =?utf-8?B?eitNTEM1U0I0RFNzQ3NRVEFadmw4dVlpRFpiYko4UFZ4a0FvVnM1ajYwSHBo?=
 =?utf-8?B?Q0hxUUdpOXdIeFhMaHBEMTZoN0owczdjYjVvNGgyZmYvVVk0RnVkeGpIL3d0?=
 =?utf-8?B?MTlpU2F2MmYwb2RHVlkzb2dpeDkrUU42aHZsUEV3QUJUcUZJRCtzTmN4Y2Rq?=
 =?utf-8?B?cmhmZW1OZUcwWkgyd2kxc2tpVmhBSTJ2WGVmU1RRL3RBV25wTG9QM3FiU0l5?=
 =?utf-8?B?elB4NWpaUGtSbXlEYXhiR203MXpjQW0xN3VzZ2lHRHNoZGVDQjdLc1JQaHBI?=
 =?utf-8?B?UW9zdGMxMklmemNIdm5VYmtnUC93RWpHSndyNm5lclRyUlFiRWZJTTRhclFF?=
 =?utf-8?B?ek5ydjdOZVFrR3VuNVFobmZSakd1S1RteDM5Y3JiOXFpUnlTZ2lJSE1jL3p5?=
 =?utf-8?B?SENhcFI5Y081a1pTc1YvaWlMS3RUTGxyb0g5bGRZM3p0aFhxeTdxMGxFN0gy?=
 =?utf-8?B?NkpiUGx0VW5JZ3VuVVBkalhpUEtSTGppVUlObUtCNFBWcjh5VTFzNTljUHZU?=
 =?utf-8?B?MjljTCthcEY2TzRIN2hVTXF3S2FQeVk5d1phcFFRTzBxdkNEdHZHREFpS2x2?=
 =?utf-8?B?UkJKRmtML21yTjdyZE5SekEwMnZyaUxSY2R4UGlpV09wclY4MkN0RjhMSFV2?=
 =?utf-8?B?VEhoMjJYbUJwRXlzL2pOOEptRkhGL3M3UnJ3SzZ0Ny9zelhlNDNaWTZOd2tl?=
 =?utf-8?B?RytjMzAxbVBHYzY4bnh1R2RDTDltNnlabGx2UGNxR245Uk1QaktIRUdlRXJK?=
 =?utf-8?B?RERTMlJMUFJPSllOczZQMGxwam9iK2licWV4OFNrT3RjakZhWW0wSE1NNm1u?=
 =?utf-8?B?ekUrZ2xSZjBOdlc4SlFSR3NFV2hvWkpaYVpUaDRuSVUxNnBxMXBxeTFPUTVL?=
 =?utf-8?B?eDFEOWpBV2VBNWhjdHY3RWJYOUtMd2V6WGlFN0dQdEk1N3EwTUw0T3c0eDMy?=
 =?utf-8?B?alg2aWY1TEQ0bTVIeVFTeFJKcW16ZFNkM3RZOU01Q0FXdk9DN1JNRTU5NHdH?=
 =?utf-8?B?SlhkNE42cU5KcEFrWEk5K1RIcVJTbWZwZmRzazRCQ2l4VXErcW9hNW9VTnl3?=
 =?utf-8?B?aktIVTlkWjBzOEU4UkFsQ01iWnZ2OG5mWWRRQzEvNXhQMWlrNjFGM3V1ODJ6?=
 =?utf-8?B?VlowUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhIMWdJdU5Yb2JEd254RjJiRVNMRnpGRW1aV01od3dsNGJXZXBwd1JibGVl?=
 =?utf-8?B?MFBxZ3hCaTZFbFIwYmpHVEdVV08vT2hKQ2ZoWGRFUFBYL1RjVjF5OFVKc2VU?=
 =?utf-8?B?RlB5Y2FNOUMyU1VGZENYbFpSRFg4cDRyWTVneENUOFd2THdLVmNsaFJ5Y05p?=
 =?utf-8?B?YVhlY0tQbWRDaXllcFB1anBhMzZOSm1ZSFpER0tmV3hpY1labnB4cmpEZUs5?=
 =?utf-8?B?cmY5Q1dZMXQvNUZZVHJmdHVtbTFVRWpTUlFkaVpGSmI2VERzMHlvWDlBNnJ2?=
 =?utf-8?B?clRrTVRad0swN2FsSW1QSndjSk11NEIveDdldVAwNjdZaE16VTNJY3gwdVdQ?=
 =?utf-8?B?eWlSUXVMWWdJek1zN0FidS8rUXZmbWxPSzBxUDJjQVp3M2hQVlUrOTJSSkwx?=
 =?utf-8?B?Qm4ramw3WmQzZTZnZ004c1A5QkovZ1FVbnZXWDBJdVoxQVdibEYzTThKRU43?=
 =?utf-8?B?cjNSQlVoZmRqaGxtK2dGYmJkOERNU2QyYlAxQ0Y3cjYwa0ZMcnNLd0hIbVpn?=
 =?utf-8?B?dW9KaDdDUjBDakJ6K1JIVGJJMFF3MDRrQlpqVmd6U28rSlh0Sjd5b0V6UXVC?=
 =?utf-8?B?UGI3cWgvSC9tdlZvUzdvVjhML2YzQWFHa1FHV1l4MDBoVWJESXJ5U0ZaRU90?=
 =?utf-8?B?NzFaOTZUK05wV2hvYnZGSVdCOWdTUytCTFhnYml6RHBmTFdyeStoVThEVmpW?=
 =?utf-8?B?UGswR3pFYzdjdVcwRzFuRE9iQ2FyekpoeDY0SjhQS2htYzd2U3c2cnFJUXJp?=
 =?utf-8?B?STN3eXVsK0pzbGNIZndMM3F2UWxpNnkwV09EcWFXLzh1dldkWGMvRkMzT3lr?=
 =?utf-8?B?NkNKdHJURk5yVmJGNUVWYkwwWjUzTmFHV2dkZHJ2K1FqZ3BQbEs4QWZYRVNF?=
 =?utf-8?B?a3NBR0pDQ1JSeHNJY0VCckIrWWFzOXF1TTl4cWtZR1NxbklFS1A2MEV3ZWps?=
 =?utf-8?B?YXFUY2greXJWZStRYW5wYTFjdG4zaWRpQm9VMG42SDNpclM1cWRFSFljODF4?=
 =?utf-8?B?YWQwQlV3MHlGK1dUTXpZUHpORVBsYTA1WVdSaGU1N2N0WUdUbkN3WVdDUG8r?=
 =?utf-8?B?KzA4Rnl6M2J1MXI2N1JGVUx3bWhpRjNoTVN2di9QQTRHQ3hVWGxRbGoremkx?=
 =?utf-8?B?MEVpS2xMUXB4RzZRL0t2amhTUWsybkJ3NkQ5ZTAzZGpJRWd4UEZLOHBoQmVM?=
 =?utf-8?B?bWVrbGk2RzNrWlVOYVY0NW1helFRYm55QW5wMWI0aVQ4T1EvbGlIcytTZW9Z?=
 =?utf-8?B?M20wS0gzK0xKeEs0bGo4R2g4WDdUc0d2TzYreG05cU9adWdnL3RDZnB6ZTRE?=
 =?utf-8?B?eVV6dVh6YkhETW0xdUxzMkZ0aSs5WFhKcC9EV1llN2hTN0tUYVpjTjM0MVFN?=
 =?utf-8?B?UGVBQXpyWjIzeG8rdlRXbkdXVTJ4R0FrU25zRldaNFpKckpCU0tDTjBEUTJ0?=
 =?utf-8?B?UVBXWlNqK29PRnJoL3pEaXZFUGdXeTlTRWdYV0R0S0ZubitnTFFocWE3bzdi?=
 =?utf-8?B?VXVHdndKSW5ZMWFweXZoeTYxazRqTEZIbGxMVFJtWFVqdHozVjdrTCt3MXhP?=
 =?utf-8?B?MTd4eURUaXc1cE9iaVI0WHNlNy9pRHpndnZNTXhTdWIweUNJTzJHblpDUzNE?=
 =?utf-8?B?U2FvRkErL1Vxb1JheEtLMHRhNmJIL2VqdEIwdFlJbDJpMml1YXZUR1ViUDRz?=
 =?utf-8?B?aTdUTGZ1enFVdTRYY1BLKzRVZEtOZ01mb3U0WUFxMXI1TkFnT3RRUTdlZ0Vq?=
 =?utf-8?Q?6ZKA7IaGwxcEKCTfS0=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f71d8a7-0b7f-4511-f948-08dd9c349d28
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 09:06:34.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6208



On 26/05/25 2:04 am, Eric Sunshine wrote:
> On Sun, May 25, 2025 at 2:55 PM Aditya Garg <gargaditya08@live.com> wrote:
>> v2: - Added support for OAuth2.0 with curl.
>>     - Fixed the memory leak in case auth_cram_md5 fails.
>> v3: - Improve wording in first patch
>>     - Change misleading message if OAuth2.0 is used without OpenSSL
>> v4: - Add PLAIN authentication mechanism for OpenSSL
>>     - Improved wording in the first patch a bit more
>> v5: - Add ability to specify destination folder using the command line
>>     - Add ability to set a default between curl and openssl using the config
> 
> Thanks for describing the changes between versions. Reviewers
> appreciate the thoughtfulness.
> 
> In addition to describing the changes in prose, you can further assist
> reviewers by including a range-diff (see the --range-diff option of
> git-format-patch).

Will do in future. Thanks.

