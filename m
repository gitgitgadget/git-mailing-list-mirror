Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010001.outbound.protection.outlook.com [52.103.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680538DF9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671104; cv=fail; b=fifjxi3NxZ7+xs9jeiqUdU4O9WOozRfBl04iVBhuvqagBC0sVRxxNdX8e3SIYht7H4CcoFaOaXI5vQXOI74+xss7tc9etkQaxzA2Yq90reIHuecsUHuGN/wCRl/QIyILBrwDQeUB7PGXLmadFro5dD+zkx3MrVXXW+t9cugTlyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671104; c=relaxed/simple;
	bh=MkGkYhtqgBo8mdTQdS/F4nMSbCwM7scF5jTo9ZUpFpo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kt5UP/in54kF15c0GFZfXibDVC5TpiCGMzatfBqcbci9EZlBXEeVpPoXRT++pODJW2UBda/EmvGgjpj/wOHfkpn/SbZoa9hQF6afGGbyeQ0ucLmQoFKbE8Xc16M7n+nLxAe71C3uzW140MuuLaHw5+r29wEfCTJ1Zcodb20MATE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DnonrHoX; arc=fail smtp.client-ip=52.103.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DnonrHoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vm0pyOh0L/1x/pS+1EGa6Zv6h6eEzluXceJDka6quYiGMnoxYL2/wlweOVOjZGT6CoVCKtRtMRHe49F/3TMp9Y/nyPOTumKabU/3//FppyUEHfAYF7o6f0EuxbDp4Fdx0FIgx/malLHESC3HP7AC0k53XeL/pC7mgc28c5nbdpixNENdUxel3Y3yTnYkrWiKX6v60g3m1XxxZXvSy+Dy2HGpI8eKRfhZ8Lirsu3TtsjEBL71lRAfGSguj+rVCu1YfjQ07FX3najZTZc3nDy3Ng4QjPbZmWb1uXNVViuyXtCKzrdj9+1qQINhhBOMFmPawI2tSeebKxDwDZ3AO+VKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrdRWatthxtrGAMIkyalbgqyx+ZBPAvHFeoQlUI44WY=;
 b=I1Oh1CDDkBkPNeGjHSWaWgAUc7L/yYIDVKNe1OOy/fR5B4WBYcgOC5E1DE9Gzbf/qxKLEUj0xPvq/81Fj1k5v6XuEPQQ3Azg8YDgVb5rdvo7k4E6ZH/Crd8ur3xfdYr7M8SN7Yj595zDhXGccQ1nwD/xcMEgwq2tRGHnRvBde8LhbTV3XNs0BB6u7dkfyKJeUhbljyLIzG1C1X4lE2xJYZLq5UE3Os8mxo+tETwDoVEoPol8yQazqzgetYHUrs8QQUMUxzUjkdC8xDJIJvX83FY0m8EkdmQUIlXdJgcz6DqLRzxo6UrMg7A4JyQETpRbroiF38ZrvY04BBruh0jsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrdRWatthxtrGAMIkyalbgqyx+ZBPAvHFeoQlUI44WY=;
 b=DnonrHoXxLNXZOmWtWAVt6mZVCXUQkqhFwkgxGH+Nz6mf50mgb+YeFj7GNHUhwL28DFWB6yxuJgFtKONQrDcrsz6teXmQPHfb+/AUem3XgFo62X/qsHoPRo3Zi0Fdq+FOzDPnl8sEd7LHyy0emTDPGWr1rL4djkic2vUrDcR+4i17ydmhfqbNA2HWfrPxTnA4roWexfGY/RGpk2iOD+nqXt+EvLn9wxWVJa4STceLTBG76gVtDdgbkcCNOjv8c5YKXKy8e3nYIsI8RScYe0v8tS7y+v7XR8jtqZBA3URJaHW7ByyS1NIIpD3C618Vk+aeHQPi8Gxhxp8uD2KZ1s1HQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB10586.jpnprd01.prod.outlook.com (2603:1096:400:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 18:25:00 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 18:25:00 +0000
Message-ID:
 <TYCPR01MB8437CDD2208EA6555117E72C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sat, 12 Oct 2024 02:24:57 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Julian Swagemakers <julian@swagemakers.org>,
 git@vger.kernel.org
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
To: Junio C Hamano <gitster@pobox.com>
References: <20240225103413.9845-1-julian@swagemakers.org>
 <TYCPR01MB843751F88AF98DFDB606B0BE98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <xmqqed4mecrq.fsf@gitster.g>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <xmqqed4mecrq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <9f18ba63-3c41-42b3-a44f-cd6a63c8b813@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: fc82a0ed-0d7a-4c5b-1589-08dcea22046e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|461199028|7092599003|15080799006|8060799006|4302099013|440099028|3412199025|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHI1NThVUmYxekhzSGF0SWE0QWp2TEo2TmduNHYrazBPdVRlaVp6NmRhRFJZ?=
 =?utf-8?B?bHRHcDJtYmQyaUdkdHIxMXY4SGxIc2NLWlRZUC9vQ21Fa0pzaVNnS1JzNGE1?=
 =?utf-8?B?bzdET3VnMjlPajFwUEpGSGtpbjROTjRmOXNsNGVaUmp2NUpCejF3MlBJN0hm?=
 =?utf-8?B?cVU2czhwS2lGUFNUa2dCVCttUFpUMHVqZlZlUCtPaEYxeGpKMmFnc2ducUhI?=
 =?utf-8?B?eWZlVDBCWFI1MFVYQ2ZyWDk3QW9iNE5vWVFBT0ZibXQ0bksvbm1JM0Y0bDFo?=
 =?utf-8?B?TkVsbWRUYVgzMHFWRHRKWHFHcEtFU2Q5c3ppUUN0Q0prVjVjNXh5U1lnb0M4?=
 =?utf-8?B?Y20xY1ludzZDOEdpY3A0OUE4M2RDWDNyTVk1cGp0UlVQbmExTnV4QkNqaHhT?=
 =?utf-8?B?aFJtTGduK29XZVNsa0d5c09LVGRCblUrMnYyNmRpZ09KbW1vQUwrS3pnem04?=
 =?utf-8?B?dEs4SS81QU5ENUFodSsvMmhqYW8zd3BjSmtTeUloV0JYMDRLLytwSU9mczFF?=
 =?utf-8?B?blFESjBmS2V3Vzc4YmlOalJLSU9GODh5b0Mrd3V1ckdFR3VETTMxUHh5bDJQ?=
 =?utf-8?B?ejVnK3ljajNlaklmaGNzczBNanRtQyszd1JUblRzNEp4Q3JXRTl6TTREbmp2?=
 =?utf-8?B?V0FHbkxBT3llMGRBR0ZPV3hDYUpTRG1XYk5TZnlMRHBrV0VKbDk5UU1aZ09v?=
 =?utf-8?B?THdFcG9BL3k0SXVTL2V4c1Y3ZTR0aXo0cFlLR2UrUDRQUi9zTnI5Uk1WNVpL?=
 =?utf-8?B?MGtYaWU4dnVDRFRzdzZObkxJZEZyQlQyaTN6amdVb3JrbC9CYkJXWmxnK3pZ?=
 =?utf-8?B?dFVJSTRXalJOSzNPUGtaU3lZYjEvNkx6VVE2N2llbzBQclBhUjlGWG4zVnh3?=
 =?utf-8?B?cjhkOURwS3JJcjNnOXA1S1RYODVHeWk2MTVzaElnWWhIVm9iV3VhbzVITEZH?=
 =?utf-8?B?Q2x2cGhYR2xrclNwYTZrT1JTUUJFeEdqZ1N1ajlQaTBYbWt3Y21SaEN0VVA0?=
 =?utf-8?B?MURoYXRNVTdnRStya3BoYXhhOHl4MEVRZ2ZDZEtZRjQwbmlHNVRTa3U2TkJv?=
 =?utf-8?B?ZmZkTWxXU2pCbWRieCtGMjZiN1RVV2U4aDVVcUFWbHg1Y2ZtUE1KdGJENUtj?=
 =?utf-8?B?YWwvcDNudGlvaHJmV013QWFVTDBZUXcrd1pFdTc1U29UaW1WQWtaRFBLRHk4?=
 =?utf-8?B?cUtRWkdxWTNnbWQvbVl1bHoza1lIS3Q5eUxDaEducWxpU29KNjU3SGl1SU8v?=
 =?utf-8?B?QkNCY0pDMVM1V2NjZ3FGMWV3ci9McGpQVG1VK3ljazZTOWJXT1NHUVYyTzNP?=
 =?utf-8?Q?cUHXy04TQd+v0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy9QZ05ZaVBna3VpM0UrK0J2aUxHcmJQSzNMN2gyWStaYWJTdzV1ZnZBMUpq?=
 =?utf-8?B?NW5kWjZldFl1MlZvYXAwWkJaeThhbjRWb1FrU1lmbGE2cDFGSUlwdGpsYnlD?=
 =?utf-8?B?TEJaTjFNdE9naW9yVHlaTjlKWE1wallOK3NyQUg3RUVpUWVWZXZleG5CN1lw?=
 =?utf-8?B?UWRoS0dpSTVpdnBpSXhaak9pemp2aGh0Rmd6TDYvZ0Z6aWlXcmRDbWo0UWow?=
 =?utf-8?B?VzJweDFieEliN0xjZ3ZIWFhWbkE1aWFlVGJWLzBjbG5jdU80TGlDMjM5YXRZ?=
 =?utf-8?B?SHgxdHNXMTJTOXhIU2hFcUx4ZmcvVFc2d09LSjBWQ2Rrd2pjS2xMejNWVXRj?=
 =?utf-8?B?cGNoZDFCUmFGd1VzRk1mT3J2aitEZkpWYTVWQStsRDhZamEvL3pTVnBGNWEv?=
 =?utf-8?B?WWk5QndLbHRac2pmOC94RVFyV085N3FEY2VQaUhBek5UbVFzZVMrREhEUjdC?=
 =?utf-8?B?U3lJMWltUC8xNU1iR0F2L0g3dWkrTENCVnh3R2I3Y3RRaVBybE56SUNSN1Az?=
 =?utf-8?B?ZTNKZ2ZvT29oZ3hjNXpSc0RKbkd4bzJycEdiY3ptYkhvWTVoNGh3em1jdDd2?=
 =?utf-8?B?aGRiWlRsejhUTUhEL2paWFNBdzFibGVaU0gwMktGdzJXUFpPaVJqTStYMzU1?=
 =?utf-8?B?emlxM25RM0YxWDNEWjJaL21vZmVrVXJJeHVEZ05hK21mOStJZHpnQVU5RFZV?=
 =?utf-8?B?aTNXSlRCUnFjVW9BRW5iaGdWUHVYdHJJUUlzUEI2QyszUEloN3BOOWtkNVVk?=
 =?utf-8?B?TktqRzRsRURnMDZBbzJnQ3BBd3BsVmJKVktRdm1iZ3hOeGxPV2tZcmUwUTlD?=
 =?utf-8?B?MzVyQ0JpQmRmeFhVMjd3S2E1bFVvTWNWb2REclI4RExmNlIzcS9za2s4ZHh3?=
 =?utf-8?B?cnZ2M25JemJoeTJIQ2F3dURCTGRDL0s3Y0o3Ynd2V2ppQ3BSYWZzbU5HNVJY?=
 =?utf-8?B?VGNtR3FHTW55S1hOWUkzN0FWNXNjRzJTdnZ2QUhOcnczMU9udm00UWUxNVdu?=
 =?utf-8?B?a3RIVm03RXE3bU5wMklrVmNMaWJ6V0U4cHdvYmVYZXgxK0NvZVpJN1FweXh6?=
 =?utf-8?B?bndxY1VyVTVKTUF3a2RERTYzYkpjRWlpUUtiN0xIeEIzNEZmSE83NnByVWJl?=
 =?utf-8?B?WVIvK2NSOEhlbXVPbm9JMTlpQUZ4a2FQcUZkWndyNjJhSFo3T3ZOZDFrdmxm?=
 =?utf-8?B?Z2p2VDd4TStuakhJZ3FLL0E1MXc0Zm1sRHJXWWV5Vml3YmFoKzZkeWROVTd0?=
 =?utf-8?B?SUZnL1A4RXpEYW94NW1pUHlnV3pCUkgyOXdyRTZlSXJjczhWRklqdXRoR0tp?=
 =?utf-8?B?VEptMk1jUmpjbHpOS0lBTmV5eXZNeXF2VTJ6cklGb3dsM3BtbDBkNDl5MU9u?=
 =?utf-8?B?ckduejAwVU04ZXYwaDI1WGNLZjRNWmFhSkFQMVN1bnhyY2ZJRUw3cGRvSFZD?=
 =?utf-8?B?MHZNaUNIUHFZQjhwb3VDWUVlTWdqZDF0cm42QmhXMjVmcFhKdUpyUmRPakRW?=
 =?utf-8?B?VkY4MmQvSGNuanJrbFZKVUhraTYvUjBoY3BVdlhCcVA3T2xSVTNiaEk0WWIr?=
 =?utf-8?B?NDVCWFgvdjBkMEptVk9IQis3T3dtQldab1Bpc1J1cHVQV092Qi84MXhBcXlJ?=
 =?utf-8?Q?UKKBrI6oeOJ/k1OjgxlTQGT8C+wNVNOjQnInnIUalWAU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc82a0ed-0d7a-4c5b-1589-08dcea22046e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 18:25:00.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10586

Hello Junio,

Seems you didn't CCed all relative people about this patch so that
maintainers about this file might didn't notice this patch, you can try
the script mentioned here[1] and resend this patch.

Best regards,
Shengyu

[1] https://git-scm.com/docs/SubmittingPatches#send-patches

在 2024/10/12 2:05, Junio C Hamano 写道:
> Shengyu Qu <wiagn233@outlook.com> writes:
> 
>> Sorry to bother but what had happened to this patch? It is more useful now
>> since outlook also switched to oauth2 only mode.
> 
> You are the second person to mention that what the change wants to
> do is sensible, but nobody gave any review that verified that the
> change does what the change says it wants to do, so it was left in
> the mailing list archive.
> 
> Thanks for pinging.  Perhaps it would remind and encourage others
> (or even better, yourself) to review the patch to help it move
> forward.

