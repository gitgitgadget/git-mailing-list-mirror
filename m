Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DD2144CF
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700695; cv=fail; b=muOGUMwocWPILFV/xxeLMhURqlS5rErzfA/YuAYod+ihCqUnI6h7quU7C398SK79UsM9WU4OzrJ6dCKvXrBaAmEA9A8oa6Vq8dI7R8gVJP9uN0XHh8ws5kDpvwdQev889UxnnEYkLbaIxoB5VygGBh8A2g0GU4ggRWh2qGDButI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700695; c=relaxed/simple;
	bh=Nm/50VRgDm0dbqiM8XHCqZ41XX4rjDbVFWNhTTW7j+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLXbEwbbWEPqSeQE5sizv2lnDf4dBockzPWMP0N7/4IqNs1ws833PWRNPpOJ1CG8CsCwbJ3479SDru3dSMN+eThb1t7yan9/dHGdbiqTKJAdL12N22UKYcsCTbQNhkEZriMV0zm5yNUy7RvLwd2UM28872EYd6k2thP7MgvQrg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZT1JZ31k; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZT1JZ31k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn4lpEUFzStOKliiI4bl2KV5FNpmlfcpTWfQs47H0h/VesRG05zdSCrYDUW7Q3w6qGA++4QoZUvKy5y4Y1XJ/U2abWV6uKylXnpEWnJHvebR1U9MHyuri3hQUsXEH4pYRXMhH9cJssSN1dr63aUObvbkmgdRQfUzgqkjl3nY9k35gP4Tw9XshMi9T0/TkFaruJbUlToykXbYRtqqawx8SmQJb5jHa3jNV2a0NAIYbf2c4dzd7M6dV9LR8oHDDlKoKQGhFHmS+Z81YPNlwvuPGW2+GerKWOpXeD29jaKoQnRF/5IEKoQNhwebylhGVz7MZ8ZqOdRSGqw9SqMzIIFbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imz3pJX3LA//aslOM7Feu/6eYDjtqnEZPwC1xuaUeTw=;
 b=HF/DpFNO27lccqZpDWOlxANAPH8JjI3UaSVc3x0nL7QYQUvhV1K026S3MoLvnwCxLa6I4VRc60nQuRAivIWkelKx/RoVG0OhF2LJvGwXMiiZ57nS0392ApCU3vWa9Ki6TSHr5aff+nNqxfEOwB3ULyRLxbYDGo3LeFlcZqjX/GIMf6boIGfjBddqron6om+pYSu+rdN8RdVmb11redD5Lg2PItwlz8q94g+0rjKwRRr5Hl2VB8gTBqPQfhggXIHdCv4NBbQ9JQpbP7OWIi/davvT5T2PvP+lUgUGTM1ovPGbPcH3moN/foHaKlX4b33OxZPVb8dz5p9RuqT0zjId5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imz3pJX3LA//aslOM7Feu/6eYDjtqnEZPwC1xuaUeTw=;
 b=ZT1JZ31knFYV7y36Kp4L2XGRkG2BDWRDBLwH0CnkYVzyOtj7unmTQCL5yooVmAXA1MCuY7NsSHxEczm/BoXEYdPhIuGkGArpbub0FD47nhgdrjTXf/JUnIiVd5/qKs6eN394BWJKZWJZZHSVO2zZZkS966ed+vFjNUHZv9SLZ6HITlCnysTA+IPLtAJyXrb58JUZnQ4f989V8qQoPnSgxCCt6ysSpWBqD38OHOZ92YRANEqz1jWUqSk3z7GAU9M91JLMmUr8DVo9IZpyV9kwcptd9X6vy4V2xJ7NfQpc2Mxt+dcqo6s9SLwQ1gcBoWqOgli9tTnVL9VxcM0wlOgkpA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9409.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 10:38:08 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 10:38:08 +0000
Message-ID:
 <PN3PR01MB9597B28DEE072C9D452EDB68B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 8 May 2025 16:08:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] send-mail: improve checks for valid_fqdn
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
 sandals@crustytoothpaste.net, Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqzffo9h6v.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqzffo9h6v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <395e76e9-36d6-4af3-9f18-c2dc3dc894d5@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c0731c-e444-4eab-5383-08dd8e1c6c73
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYuurUjAp7mLbzqrkWjgNtYiwZOeZRVJFPDgqC32KutGG/uPd+RxZGpZ23Q+HJMfPHpmnwPI5F3MDV0a777pvwEr50T3AhJx73vVRVkOeldZHaQo/lrw0Em/ZsGKxm3zTNL7SdFy2Q5Ldbi91vo5EqNlEUI/Ga/4uzjITiXMHPcZcRcUmzesxp2joJAxn+k6qMShqMpaDmevU89NqZFXazQXXSCxZFj5SZZ5PLxFqcqEIbKnCHXSJBvN1byNZiE7friE8+hRkacNwWSano6I0hA8b6fAZ3SxD1nRV9wnglyR1iWZUlpikCjHErRwMyk+xZnePkxK2aSvVPJS8RLxOf/d61OL9eIMxO+El9txAm1MMQpZwBkTl3e0wovtdhDQMldfiiMuZyGNO/8Emhrx7n9tb9xV2QEhGULNLLsC5JdQfJ5eTaBpYsOHXmZL9SlYC112ZRelXf92eSYi/HTfsrzCkpusCGxHbUOM/h2/LcT5p7jumT3RC1kiR2rhkE6TAqMPiNMTQ96kY7osfrtnweHt3ca7DSPHuymst+UDqGTYtNvy1mw7ED8Qdt8de0MDNcNbRV5uvY5nQKLBlvInnbOK09dtA/pHrDaOkf1oa6MfxSBsb2ia+nYOnxxxd1fafkYtJZSI6BfsBW76o2OwdASMpCBEQCw0YMAw9GJQG68p7Sye+g1Zt70P1vZr3+Ydxmb90jwWjPep8nOvDetV8Ggu6xnOnI9cfOsNKwH091b6bJjfLBGNukR+03cvRBsTFEBSCYwks2FHtbNxnuJ3Tj72w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|15080799009|19110799006|8060799009|6090799003|5072599009|1602099012|440099028|4302099013|3412199025|12091999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REtTTWxZQXdoak1scjJ1NWxlbWVpMkI0bjByZFdLVC9oTllmbUw2SEdYSnNm?=
 =?utf-8?B?eWZiSGdyL3VTK3dRTWZKckMvc2ZsVVl3SmhKb21aeHFJdWxRUWVCbHpzUlpn?=
 =?utf-8?B?SGhMbCtUQlJiN0gxNnZhZXA1ZDJpOEhuYXptbGdSSTZjUHhHV3QzY3NJMjl5?=
 =?utf-8?B?RGlhSnM0VktmaUtEM2EvTFNMdFdQbjI1MTlKTHkzVHc2T2JrNldCalYrUnRY?=
 =?utf-8?B?RzZCR0RuUmZyT3M3NXEvQUxWbzhDTFh1VXg4QnZqN29IdTV6Z0U1WFNvOXht?=
 =?utf-8?B?WnhpYjgyYklmZmZJaUdvV2YydUtaK1lWU3pzcU50bXlPQlBjMGxTK2QySENR?=
 =?utf-8?B?bDExdlVqdTVEdjNFTjg1a01qQ01XQ0kwcnErcUtFbDErai93aExqOHlKdW5x?=
 =?utf-8?B?dm9TWUxwSFBJanZRSUE0ZU52M1lVam8zdFdoTGJkaCtwRlFhZnRSY21zaDk3?=
 =?utf-8?B?UW91R3diOXdWMWt0ejQ0ZkVVVVdEVE1vYWExTzllaVUrOUoxa0JJY1RpaUw2?=
 =?utf-8?B?R29nTnpYdDZwU0lVWmFab0RjY09JYWRyZ0U5dUtPR2tzY3U1YjFJUk84K2hv?=
 =?utf-8?B?MTBKZkt2aUhNQXJLM2FvN0V3cS9lMksxWDRHODVhMU05YnY1SE8zUWFqVklh?=
 =?utf-8?B?UTk4bGlpRjhsS05YQTZpMmNyVGtCSDc3clNWa2VBeGdaQnE4VmZCTXpoczh6?=
 =?utf-8?B?Wm9CWW94ZzB4eEExNEI2NDN4VTlMZlQ0WmVjNzBETVFRNEoyRDJ3anY5bjM2?=
 =?utf-8?B?L2RmYmpGb3RHTzRybW9IdWlsdGYzK1p3d3V2M0c1bzJ1NnNud0hwMEcwOTlM?=
 =?utf-8?B?SFJOczBEYjk1bVFIbTU1bG5FeWJIMUN3Ni9EdmJhOXQ2Zm1ZQzFERGc2eXpp?=
 =?utf-8?B?aGs5dVFUN1FBUnR3eC9CYVBja0NIRkc2SzVDNnlHaWFDeVp0QmJtSU9tSGln?=
 =?utf-8?B?Um42UEFRRmFRemh4WlpMRGpoaVdSTVJkY3NuTUlrL1VPYnN4K29aQS85V2pw?=
 =?utf-8?B?TnE5Y2w4OE4za0JDVFp3b1dXTitySDQyWmVuVFJKVmRkQ2hZN29WR1Y1cktY?=
 =?utf-8?B?ZndkTkM2OXNlVzVQakwxdkVvbVVzNVc1RFhyK0QxN0txSzZzQ3FmdmI0N3hz?=
 =?utf-8?B?MDRUTWQrWE0zb0EvcDZ1eU85OEUxZHVUWmJqM01KN3cwL05yY1NhSUJLc1k0?=
 =?utf-8?B?eUttYVNHSHE3QnFKaG5sZllWOFhHUVVzMGFPUkNaRG9zY0xJTElqL29QUU8z?=
 =?utf-8?B?c3E1dnJBOVAxYVBTR21BNGVLZ2JNMEhiVTBrWHBCMXZTNVNYVTdOdWM3aVF1?=
 =?utf-8?B?ekQyRDI1bXdoT1VoTDZHN1VDY2ZmbDVJaFU0ZktDMkYwWjdESlRJL1ozTzND?=
 =?utf-8?B?ZkxEWmk0MFF2c0pUUllmVFN2bDZ2Wkd2VTM5dmNMaVpmM2dobnZSUmpEQmo4?=
 =?utf-8?B?WjJIalUwRjBzWmliR2J0akg3SG9iNXpDYzVCa2dvOG1RcnV2NmFhR05NNlRs?=
 =?utf-8?B?bEV6VnFjUktSOXpZdkN5bEd0MWR3NW9nOExhcE1aSFZMRVBrNzBCWXJ4WVpy?=
 =?utf-8?B?c3VMdjF1VVhjTWdlb3ZsbDhaYmtlTVNsMlFWUkZPVGFMQnpvU01id0cxY29h?=
 =?utf-8?B?eTdRVmpjenBLSG5QbzRqMjFKbGpCZEJtRFhZLzhZR0F0SnJoWXBHVkpGb0ht?=
 =?utf-8?B?NWdYVjhSQzJ0L0xlaWUyUDdkYUpRUWU0RE1Qb29vWkx4L0tRamFQTDh3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZoN0x6KzFDT1A2a2dCNHk3cXREbmZwV3lmemFjdjdjQ25UQ3N1cWFqbkd2?=
 =?utf-8?B?eU5oc1E5NE5IckZMekZpZlowbUZMRFY3MVFwQmtQazMxaXgrUUt4K1dMRTdF?=
 =?utf-8?B?Vi9GOTkzZkg1bnZvVVd5MjNvSEhLUGhpM1lwbjZSNnRLbWFvZHpWSURaa0tq?=
 =?utf-8?B?emF6VTBPMzBtQzI2Ris1QmFsTGkvb1F4cVdWd3ZQT1lpbGhVZkRxc1p1QU9v?=
 =?utf-8?B?aDNRSHJlUUxLdVVTV1ZkRGVreTNlOVdVOUQzcm1EQ3lPcE9FTDYyakpPcjU4?=
 =?utf-8?B?KzNaVytiZG4rdHV5THdrd0cwYllqdFRIM0pNdFc5TFdTMHRSMkZjVGRQZGpZ?=
 =?utf-8?B?NGh1Ny90N0Q2a3hya3RwYjBBVUt1N2hTeEpmQVQzaWdHb3AySVpkRjdxMHJN?=
 =?utf-8?B?ZTltMnRiVVc5blRVNktOOXA2RUVjaUtNb3AyVm1XSkJLWUxQWmdjaHcxc3lS?=
 =?utf-8?B?QlN6YU00NVFncXBDeXR1OWVOYlVHejE1NFhrd1ZhTFZjMFZ6eWZrQmx3Tmcr?=
 =?utf-8?B?MTZJaDRoZVRjOUV1dDFDalhyOXFlTDhRQktnM25qZ3B6dUxrc01KOXpRLzI3?=
 =?utf-8?B?U2d0ejBjZFM2dXA0UkpUU2c2cmMwZisvcG44SHBIcEcwM1l4NXAwSWtKRkZv?=
 =?utf-8?B?bTRvUStmSDFqVlRVSnVkL1NreVR0OWtxdldYbnZmTmtEbW9CV2hKQVptUFJT?=
 =?utf-8?B?dmpyZDNhSThZcnY2VHZCWk5MMkJtaHpDVWFTaUlXd1cvVFI4NldKSTZ0ak1q?=
 =?utf-8?B?a0MzaU5rZ1JkNGorREFmNUl0UGg3Wjd5UE5rMjhJV0RTSHZ6d25jMEdVcmdF?=
 =?utf-8?B?K0NheFppdjNiKzkwd09McUVpbjZMQjBQSGU0MG1JbWVibWRYd29IcmJ3L0pl?=
 =?utf-8?B?ZWdqUk5WelRrUm9GczNYUnYxMWhUcitTeHJiMlRidDZTMFpDZWJSa0FGUkx0?=
 =?utf-8?B?S2VkY25WTzBXRzh6d2E4NTF0YzNJNzd1cWJ5N1NiMm1IcE9pUjVJdHdVTTVE?=
 =?utf-8?B?Y0ZxdnRMN0Yrb3RFdzFIVkY1dzlBL09FdUlPdFoyei8zV1J4SkpKcTRuWGRP?=
 =?utf-8?B?NU1iS2xBVEVVWXZjNkFRNWgxQmZ5dGtqTkxxWCszNkE4MXJFU0dGL2hVMGQx?=
 =?utf-8?B?N0dFWXFVVHdIaTlQM3VkNndjdzZWdm5BQU44K2EvclFIb1NNU1RNWEl6YVVG?=
 =?utf-8?B?bFUxTVZMdDNybmd2MXJJTWkyeUFXb20yRGNvOFdvdVF1WkxueURsNWU3d0FV?=
 =?utf-8?B?bnpqUGNqZ1VTZTB2ZVROWTh0dVVEak1ONHRjRmNBc2dFbzlyanYxOVJPZWdy?=
 =?utf-8?B?Y2lQeWJDOWVCQUZjdGNwb2ZiV2lucmFaUktCU2V4dTVORWtmQlZvdytvcWN0?=
 =?utf-8?B?dTJvQ21EZWdtSG8yRThSTXVpT1dKaktyQ3loMnhtY3lLcnJaVVZZanVvYUlZ?=
 =?utf-8?B?NUtiU0IrTEhoTFlkcllHZEpQM0tKbnBGeG8vVWNwVytsNmVSTEM5eC9hVHlG?=
 =?utf-8?B?KzZDb1kvYmt3bzJGY1ZLRXN3L3BxY0FpL20ybTRQMnJCbU8wUXFGVG1uRHlo?=
 =?utf-8?B?eFlwZEJQM0tDcGFJa3I1K2ZvaFBDdFA0S3dTM0FBRHhhSjZHTnhHc1c0NVpD?=
 =?utf-8?B?UTBmRE9aZ051YnRZU2k4UEdGRGxBczhMZjE4YTFlSm5PSWJUb0R4RUQ5NGpl?=
 =?utf-8?B?b0Vmd2JLdDhDN01nYjRyTStTT2RKT05TdTVBbzVkS1VEQWNYNzRUN21hSzA1?=
 =?utf-8?Q?vbYwOmFBRivTdH1EFH6xTBniSm8sWo52qCmk7Qz?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c0731c-e444-4eab-5383-08dd8e1c6c73
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:38:08.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9409

> Yuck, can we do something about this overly long mess?  
> 
> If use a temporary $subdomain = '(?!-)[A-Za-z0-9-]{1,63}(?<!-)',
> would it make it easier to spot the repetition in the structure,
> i.e. /^$subdomain(?:\.$subdomain)*$/ and make it less error prone
> when somebody has to touch lines around here, or something?
> 
> But other than that, looking good.
> 
> Even though this allows "foo.local", on "darwin" it is still not
> allowed, which sounds like a regression-free change

Sent a version 5 here: https://lore.kernel.org/git/PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM/T/#t

I forgot to add --in-reply-to while using git send-email to send v5, so it got sent
as a separate thread by mistake.
