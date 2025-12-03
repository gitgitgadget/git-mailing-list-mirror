Received: from mx0a-00278502.pphosted.com (mx0a-00278502.pphosted.com [205.220.164.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D12FF660
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.164.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772862; cv=fail; b=hHF5acd0fvWz9hl2QtCQIVr0qGknsTrBvAD8fxSvWNNBJ0RMqBLzv6hwgjScOJUzpNJqUReB4186WHUdXnMGfbNAY52qtAWFhkmkZsUH++kaOPtzvtBYxco9ZeZU0zRfQJjjeLXjUXZwrDLqiUhVcI3GgR+Mimqx1D7vro+2D3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772862; c=relaxed/simple;
	bh=g95jk4jtQDAqcMfpTNetH2qFqL26N0k5p0mqpZAZBWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njWTKD0KQdJgSrzQcg+DNg8jk/rgrHvII9tFMeZrZYHI4nogEd9eKX6lYOP4NxQxC121SODst9AT6kYnkl8Nj9pJ0VHQ+rFvY4cmA/L8fMlo/f9f7gdi9uF4xGhQKwCguMVLvEssQ6Nv13fr49RQVkofSOgC96f73FfZujLur4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=disney.com; spf=pass smtp.mailfrom=disney.com; dkim=pass (2048-bit key) header.d=disney.com header.i=@disney.com header.b=VE1ywnmt; arc=fail smtp.client-ip=205.220.164.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=disney.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disney.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disney.com header.i=@disney.com header.b="VE1ywnmt"
Received: from pps.filterd (m0315026.ppops.net [127.0.0.1])
	by mx0a-00278502.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3Dva7L4114233;
	Wed, 3 Dec 2025 14:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=disney.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	ppdkim; bh=g95jk4jtQDAqcMfpTNetH2qFqL26N0k5p0mqpZAZBWI=; b=VE1yw
	nmtT0K3VvlIozJ4BE+E/9tkXmqf8a6wskifr89Jn+E3RWvV0Nu6hKi0l5r61QSkr
	laRKUmnRe8F6jhThBpBm510rw9xovZmRSFTOuWSJ9kpFRVh/ORAZ3RJl34rTgFLk
	MtsqKcHKwZ/SkgtxMGK592CHdghFxIIJP4nn06IaOhHPVqyK8PXJRZJHsQs+QT5C
	q64+EwxY+z9fmU7r0MIlKYZyR6FcgoKayAQNe8me+VP0LNcVOiU/lJ8l1PRYd4Hw
	fnwAjnf2juNOujniZHzXhq7ZEX9Ukae0nFB8nxT4hiYjf/f0vEwaWWrrD25K8Kwc
	hH8fHdGIdP3HPtaxg==
Authentication-Results: ppops.net;
	dkim=pass header.s=selector2-twdc-onmicrosoft-com header.d=twdc.onmicrosoft.com
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	by mx0a-00278502.pphosted.com (PPS) with ESMTPS id 4atphx8m78-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 14:40:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPvyp0AhW+iBmlRpGa7fZFhOtPC5I1xb/8Z5HnFkQW3nGJntIS92xZJYXdK0Ps+fouyeZT+VUfArBRTb3lH8qsTkuS8yBU5RJFNyrqi5R76g8WJ+1uX9JAX2wGoi/yOiAA57FJC0jl5let6OxUDNovs64QTkW61BjpQxAaC63ThiMHPx8JxX64eGTkWlCsoU4Jfv9HN13BjaRYpP1ZpZCCZE4qqBBIJ0AJHEoDOBTRI8yiOJO5jFW2XaqhWaab8RL/092phF+DIdR/D5a49HNFnw7TnS1IKR6wtnVxTqY5/NddrmatTFnvhP2gaGicNgdlk1/WgUtOxBkBViFr0blA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g95jk4jtQDAqcMfpTNetH2qFqL26N0k5p0mqpZAZBWI=;
 b=G3VIqf6zGrSOfjQhe82BbBUgSnJAZoMZwO1nhz2eHeKFqD89XChn6Ci4i4wTmWnjq6rsxqMizXMwWJyYi/c5iqViDcP1cTPJgl3c6VkJEt3AP459/+YS9iLoElX7lDTdKHvvrdZo5CyRsAOFdU3FMef1J0agAitySPpybj0Mw68mFB4Rkd4roio6GGW/QASQiE3phcvVQlaatMvBCT22KFjvOqSzcKxL9LyrOclDip/9w4+3Dsfb8Hvymq3nSxpLTLby+M/2h6ajD2WOWjDAlIJK2DlkR5SFJ5tJl+Kr+GMkSjzdzFfCKQoXGsHAFQTqyWUtPZwknLWWGYVB2GyJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=disney.com; dmarc=pass action=none header.from=disney.com;
 dkim=pass header.d=disney.com; arc=none
Received: from CO1PR03MB5795.namprd03.prod.outlook.com (2603:10b6:303:9b::8)
 by BY5PR03MB5095.namprd03.prod.outlook.com (2603:10b6:a03:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:40:51 +0000
Received: from CO1PR03MB5795.namprd03.prod.outlook.com
 ([fe80::e393:3b:64b7:21cd]) by CO1PR03MB5795.namprd03.prod.outlook.com
 ([fe80::e393:3b:64b7:21cd%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:40:51 +0000
From: "Lipofsky, Dan -ND" <Dan.Lipofsky.-ND@disney.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: status shows no changes but stage won't pop
Thread-Topic: status shows no changes but stage won't pop
Thread-Index: AQHcY8EydAOYDndMwEOStm1Sbd9wJLUO7EKAgAC+DQA=
Date: Wed, 3 Dec 2025 14:40:51 +0000
Message-ID: <30A402A0-589B-4B0F-A7DD-E732FE738986@disney.com>
References: <95EA2230-530D-4EB5-AF19-ADED54976F17@disney.com>
 <aS9mNdJSJP49-V4Q@fruit.crustytoothpaste.net>
In-Reply-To: <aS9mNdJSJP49-V4Q@fruit.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Enabled=true;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_ActionId=6a9e6004-9528-49fd-a02c-602897be3f32;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_SiteId=56b731a8-a2ac-4c32-bf6b-616810e913c6;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Tag=50,
 3, 0,
 1;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Method=Standard;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Name=Internal;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_ContentBits=0;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_SetDate=2025-12-03T14:36:51Z;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Enabled=true;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR03MB5795:EE_|BY5PR03MB5095:EE_
x-ms-office365-filtering-correlation-id: 39a20893-c42d-4e8e-0780-08de3279f4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDNYNHhZemlkbUFCMyt0RGJVUktZWW53K0pObTgvM1pjL0JsMlRCZkJQdDBw?=
 =?utf-8?B?TE5BVmphODRhcmVrMkFYMTNLMHNINGNWK2Q5WXBwMFYvWTkwS2JXQS9EZC9r?=
 =?utf-8?B?SVdzQ2FrM0tINHJQSDVpRWVQRkVwMytSaFh4TXpQeDF2a3Z4N3BSNllZMmVZ?=
 =?utf-8?B?S0hCS1lhOE0yOU5OalJqSnZCd0tHZG9aSVdUQk1UdDVGYkNJenpsL0M0WVZz?=
 =?utf-8?B?S28wUXRIa1FnLzdWU01xaEcwaDhkaWZXTHNSMDk5WHU5WWR4ZzlvcVVuZXRQ?=
 =?utf-8?B?ZVRoYm5PWDFkSUU5TUw4QmVmdWxCcXlnUFlFU01OeklQMG9VeHJXS3BjczIr?=
 =?utf-8?B?SERkczd5ZzdCaUo3Nk5sR2xHV1NmRDVTc0NYY2ViK3BxSDVUMS9VUWRNbGNB?=
 =?utf-8?B?VUkzN0p6Rit4NXZsRSsrNm1qKzZjNmpPNjY2RGFLZUJLV21RYjBIdStSWk5B?=
 =?utf-8?B?aTFtODQyT25GOVZwWEgxNUQyVzBrRkpqQTAxSDlLUG1WY1hHcldwUnh2eVdp?=
 =?utf-8?B?UFlxVVVRVmNTQmRRa05JU2FQcE1FdW5jSmR2YUhaSDF1TjlIT2cyMlUrVFJw?=
 =?utf-8?B?aHMvdU5uNU1RcjVCaXY0dWFHbXpDTG90RWtEVnUyd0NKTmpsVGpiRGNSNXFF?=
 =?utf-8?B?NHFXRDFML09mZ25Ub2FXTXhKUllwaHY5K3ErYnRBRFNOdDNFeDlVKzZrMVFi?=
 =?utf-8?B?VGtUeWtWWWcrbkd1aWJpQnZjU3RDZ0d5bVg5M0RxejNkS1ZGOU9INGZMNjNo?=
 =?utf-8?B?OGhENGRoSlNGNTVSUWVpRG10V0ExZE5aU05RaTR6SXhnNEc5OVVFSVRKYUhN?=
 =?utf-8?B?VlRRRmF3WlhCc0tlL2JrQS8yWTl6L2p3YTN1VlJ0aVo3emd6aS9QdldBMkhY?=
 =?utf-8?B?MS82UW1DanFyVHZNa2RUOTRpL2xpNXVzYnBqY3lsb0pvOUN5VUw5N2plTVZ4?=
 =?utf-8?B?K1BVc2xNaGFnekFUZmduK0oxUll6N0RYQlU4d3hNVWl1cXZtdlAxR1FKOExK?=
 =?utf-8?B?anpiS1gwL2JkMFQwSUtXbmhwRVYycDcwYk5uYWdXeXhaNXY3RjB0bFYrZS9E?=
 =?utf-8?B?YlZwbFhvakFpTU1GWVlWbkZzOExNRW9PbEpTY00rV3lSL2FzRDUrWXArSGpo?=
 =?utf-8?B?TjF2T2VhUzBYME9iZGpTSEVtU0NNSzJwaXc3amNjNmFTOHNwakZPOTEreWRv?=
 =?utf-8?B?QXA1R3UvKzhNUVNxVEtyTFZJelhQY0gvOXI2MmhuZTQwbm5CNW1tVC9ISndG?=
 =?utf-8?B?NFNJTWdHaS9XZTkrZUpnYmszdllKN3NuS1V6aVY0d0taNS83TXd5SVM1T0wv?=
 =?utf-8?B?RU9xWlMrT2JLSTZta2ZzZFR2Rzg0bUNTSjBJcUZPZW5zMy9Xa2sxcUh4MDg4?=
 =?utf-8?B?VkJuTTdwU0tKWmtnOWZSUXZ1YnRROTlhZkgyQVpOWjZvZkdYQXFMVXkzekRK?=
 =?utf-8?B?MVQ0anFaZ2p0c2hkNndobWdmNU95ckRvSFB6YVdiaTF0MXNnTEV4VVJZOVJL?=
 =?utf-8?B?TVBhQnV3Q3drZHhzcDl6RGZCWFlVbzlVR2I3YVd5NEQyK3RvRVRIdUJxYjho?=
 =?utf-8?B?aDlvTWs2Rzc3WnZEYUlzNWpUcHlzNzBhZ3gvd3J1YlBvcy9jUXZZUzJRU1lK?=
 =?utf-8?B?c0gxN0ZsK1lMTmtwNWhzMVhjTVpETGR6bTBxSU9Lb2RxWUxZdXVrOGFpQ3hl?=
 =?utf-8?B?YzZIa1J2RTNPSWU1L2dTT3lKU2tKdjh0Wi95L0NQemJiQitpNWxJK285anJu?=
 =?utf-8?B?R3RXZlpSU0ZNYjdKbjhRTUl4NC92djVxSi8rUklabm80cWdBV2hoQTc5QjNi?=
 =?utf-8?B?QjNFOEF6bDNNcmY1RUhIYjFzRXRQTDM2UEVEWGNCRldYOHRzRXNWejZlVVZB?=
 =?utf-8?B?UE1nRVB4T3hudFFqMVJZS0xoYU5LUXA0TFFjTmxDTktMV2svVW40dFBDajlo?=
 =?utf-8?B?ZVFOeWdyMmIrNW44NzFhbkdYaVY4NEI2dVBwQkpmMG1LR0NqcUlLMDhwcXpz?=
 =?utf-8?B?dWhMZ0w5STB5RHFTNDJQVThhbXZlMHN0MjVzd0dZdEVZSExadDlwOERpTEU3?=
 =?utf-8?Q?XhX9p0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5795.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkxGbDE4WkV3Q2YzcGZjU2tiY2tNU2ppUnNtNFNlMFJtOHBrSVoyQk0xWHRs?=
 =?utf-8?B?ZXY4QlQrU2dsQ09WV2VwYWVvMTk0bmVQdTJaVGJ4c29xcjFGMkE0MGVwMC95?=
 =?utf-8?B?Y0NXd2Z2cFl3OVJyU2dXaVlwZDBvbDU0V09nLzRJZ0JwNm02d0VSK1gwampH?=
 =?utf-8?B?U0dweWFFU0psODA5N2pqN0xIZlpMSlk3NWgvam9YbG5xRnRSRFRLUHFrSzFD?=
 =?utf-8?B?NDF1S0Q5ejB4U0FvdTVxV3Vwa2tBNVI5eWFxY1luQlV4NEFsUmM4dFlwUU05?=
 =?utf-8?B?UXcwYStReFRCTWdnMTRGem9yQUFud1VibVhOQmFFY0lsQXlhRkYxa01yOEJF?=
 =?utf-8?B?WnZaUm1aUGc0QXVMdkdrdC80bE1ZdmVia3o3dW1sRGpkb2srejJZNXZUZGpa?=
 =?utf-8?B?bE15YTA4WkM2a2ZXeWYwQ0dVdXhFTTc0WHd5RmZFV01xWml5L2ZmVjExMWYr?=
 =?utf-8?B?VDJuV0VUYnZtWFltdGpwQUxVelNCbGUwSWlxN2svZHo2MUpFWHVtZWR6VXda?=
 =?utf-8?B?RkZ2QkxGTEZsK3VrdXFLT2RGdEQxb1psL25BMjJpcjhZclZsKzA4Q2x1OE1i?=
 =?utf-8?B?Y3VJNkZZVk9SZ1lWUUZqSkk3RU1na1BpcWEwRWJyK29wdkRlZ3Q4cXg4RFRu?=
 =?utf-8?B?d3p3emdtVGNnUDNVZ2hlRmdsQnBmcC9FazlCekVGMU9xZ0NoUDNtSDMzYXRW?=
 =?utf-8?B?ekJ1bGtNVk5hQUxlcjRsd1Q1YTRkUGN2R1RmS3VMM0J0dnlrZkM3REtaMzBS?=
 =?utf-8?B?Q2M1Uy9kU3BuZUd1VDhueis3U3VMWk00empiM3BvRzdmbzh1RlBObjlHYVIx?=
 =?utf-8?B?MmtiK1pMTkRHK1VIazZaZ0Y1VHNtTjBoK0NSanhSbCtyMnoyU1hSYVAyUHA2?=
 =?utf-8?B?aVpxUk5YREhUVm5vSWV2VldVTkdMellYNFVYWU1mQ3ZOQU5NblZHZHJXNkx5?=
 =?utf-8?B?S1c2N2lSSEcyb0hoeU92UEZLUFJxQll6VGIwVm5Ic3g1dzBVU0lPWWl0Qnlq?=
 =?utf-8?B?dmNJL2FrMXEzS2NLR2xEeXNSRkc2M2hUdm9vcHFBNkRjZWlNNm9QeElNVnhv?=
 =?utf-8?B?dng1VTc5STlVNFlOMnpVNUd1V2RqdStuNWpvRmtsMmZaNFRCQzhHdzZzTVJs?=
 =?utf-8?B?WEhpajlTanpWWG9Zc0JFS09iWk1oWGNBWURGMHNLS3QwTDd3ZHBaUi95WjBh?=
 =?utf-8?B?Z3F6ZlVHMXlzVDl4dTQ2ODh3Vmk4KzNUU3dPOTlTeWdHTmJZZEVhY0RQNlAw?=
 =?utf-8?B?cFU4di9kWnR4Q284UGlJRlFvSDhHRWhoVFZXSlNpNlZHSGdzQ3JjV05wZVRp?=
 =?utf-8?B?a0FxZ09QSkhYTGNoZXhscmJUVHlwNExsR2ErUkMydlhnWjZxL01CSGoxa3VN?=
 =?utf-8?B?ZW9wNHkzU09XZHZzekxzaTJucmZ3M2huLzdDakRnZ1JBQ2ZrUW1iSmUvTFE0?=
 =?utf-8?B?dUtrMGdOd29pcy9scjUxbFErbWlLc1ptVE5BODJYWXhiSUIySGpGbkkrT2d2?=
 =?utf-8?B?a01BNWJ4L0hYdG8razJZT2luY0doMHBEWlZQL1J1Mnc2dmhCWFE4WjJyRTRl?=
 =?utf-8?B?T2E2TEVJYjdRNFlrTEVqMkpmN2J2RWgzaDhKRXE4anVDVmVybTFpSlJLK2h4?=
 =?utf-8?B?aUJiaXk0Y0Y0TUgySE5FOXkvdE9LaVlsNWMwUmpVM21SdENUSjN0MGdlWnZB?=
 =?utf-8?B?K3U3UWY3UmZEYVdCZS83RnMzWno4Y1VXZ251WnVWTEQ1TU5pQU9mVHN2WXpZ?=
 =?utf-8?B?T1pYVWtHNWVERTJ2aDQ1anhET2xQbXBZL25vZHMyd2w3RmhlbUppOFZHcGJC?=
 =?utf-8?B?L2JhTDZUSWl6QmkvWGxCbFJQRERFY2tvWjV0M1BUMHFUMkN4R2dwRUhnOHVl?=
 =?utf-8?B?ak8yVWk5elhwMkhDU3FwWXQ2SndLVDlPTjVIWHlRVDlxREs0TUlteHhUbXdP?=
 =?utf-8?B?MmoydmVkdUFBaHlFdFFGeGw3dW53SHphOWluNEp0M3dlUWt1ZUtxTEJxUGdO?=
 =?utf-8?B?bHQwNUcrdCsxbDJQSk5wakpJOXFhRGFaMGdWdk9FQzUyTEtyY3NxR2ZqODBK?=
 =?utf-8?B?Y3ZiSHowMXYyb2xONVg4L3JNNmRnMDlxU1M4RGttWGlaMVQzeDNTUk5RSVNt?=
 =?utf-8?B?bEhlaTlvZHhLV0FaODFqQmFDK3czdVZBdlJzNi9KdFlSTjlNSk5aM3l5QmJl?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4483312130AEED4D8DD208881E274C64@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lnKKACM2YVTqQCLDBuKJ7DRGgx7GDsRGAmMwjcxmYZq3t7JUZSlkK4IbGLHcK78Hh5awy0KW/V2BZnY2p3njgSV8g4iSb31s5lBokn0h4rPwOP7qVTSUzG9ILYgbJZ+UjlOqhZ+vEpG7pofoAGdGMIO/gOsd/SUnN97j8ijGSNucw4ruLEDbxHcp21NrZu7FDqha3/q2GsyzDBEEzC50We3+1AtXqJt4oVDPOnJKaECAxvcXuHGyf5+Q1zVCNoog6pkK0EEMPxBopG1fI70ASZI3Fu/mcyzXjyglEND6kZP5/gZ1rCAL1MCYM4VaDT1x9Y/0RIHl/nqgZQsnZV+wh2E9NVd3uiSUlz5KUZgnozxspwVNKFwBzkKejtAdUqWOd2erZfloi0CHqdVzc/vQOxiAEfgsBCoaNpUgSSw42dq29i4lITz7k0y1X4jtEPPqYZGVBKWRpeEoUFxAiJH4sPDbufZIekBYBJ/tFtTCPCUgD6gQhIlsbmPgI85lBM2YczxTtxlY7+WxAsBUYzQkKWhCji4AFJWtY82XI9iQR4/hpMnCE48W7AKgtX6G0l389SGxpQufJ3WkXoXISnEBctWnyPyywBoECln4eM3jYUOMDYZRK4It+uzAhIYuw2ITFpNOk/Jspw4ywWIzfYwKwQ==
X-OriginatorOrg: disney.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5795.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a20893-c42d-4e8e-0780-08de3279f4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 14:40:51.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 56b731a8-a2ac-4c32-bf6b-616810e913c6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBdoP10K0g4isVi5Phv2hJgH4QhU933xml/8GhqEv75RMJ86W8UZWblntXzplQRHPCKVjruDSGO4UNTlW8m/94DXfXBUqpprUn/rEGXFx0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5095
X-Proofpoint-GUID: BramrNXAfmo0jZz40dtltXMWx2v1G4eb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDExNiBTYWx0ZWRfX5AQH3GbM+m79
 fyCBXbFfC5t3SFWVNeAXpuGr/HvNCTDk7fBtEVnKiJaUDEf8pXnp17zlcwtOxq7NPs89pmXksv/
 ap5luMTC5BBuvf2uAw/BjRfbIwv5Xb4RIipldlM/3imMhw3fUL0gJwpxtWtvTiY2f7aKlEpMM89
 YkvDt2shU832ADnsAP4Nv3CSdJapD9zcSGwIrOm2LHfOM2xLoZSW28PWXOSulby57jZBchnIrtv
 1MvNenrc9tbu1xtJy0VHZfjKbx6BzpEBD7IlraZh8zCcRw/QdO68V/DYjTyvSm/ihCnxdBIe6cz
 1C8TusW4TrO8pL5kRqwSqClJtwtmiDA/9pgwzUzkw0lNjHqRe+ZrGRsLnJR1wp7YjTlFJ3HP4re
 3OGRAAYFIy1HC24VxKHEjXTpwmnT7A==
X-Proofpoint-ORIG-GUID: BramrNXAfmo0jZz40dtltXMWx2v1G4eb
X-Authority-Analysis: v=2.4 cv=SMhPlevH c=1 sm=1 tr=0 ts=69304bf5 cx=c_pps
 a=1s4lD5itHyb3CJ4oxNoLhg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=TuYCTXzSnvYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iKrn8l-KAAAA:8 a=jJrx74tJFvZheD-d2TgA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=vz8bQswTWcriz0i0jksL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030116

T24gMTIvMi8yNSwgMTc6MjAsICJicmlhbiBtLiBjYXJsc29uIiA8c2FuZGFsc0BjcnVzdHl0b290
aHBhc3RlLm5ldCA8bWFpbHRvOnNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+PiB3cm90ZToN
Cj4gRG8geW91IG1heWJlIGhhdmUgc29tZSBmaWxlcyB0aGF0IGFyZSBtYXJrZWQgYXNzdW1lLXVu
Y2hhbmdlZCBvcg0KPiBza2lwLXdvcmt0cmVlIGhlcmU/IEkgd29uZGVyIGlmIHRoYXQgbWlnaHQg
YmUgY2F1c2luZyB0aGlzIGlzc3VlLA0KPiBhbHRob3VnaCBJIGRvbid0IGtub3cgZm9yIHN1cmUu
DQo+IA0KPiBZb3UgY2FuIHRyeSB0aGlzIHRvIHNlZToNCj4gDQo+ICAgZ2l0IGxzLWZpbGVzIC12
IHwgZ3JlcCAtdiAnXkgnDQo+IA0KPiBJbiBhIG5vcm1hbCBjYXNlLCBJIHdvdWxkIGV4cGVjdCB0
byBub3Qgc2VlIGFueSBvdXRwdXQgZnJvbSB0aGF0DQo+IGNvbW1hbmQsIGJ1dCBpZiBvbmUgb2Yg
dGhlIGFzc3VtZS11bmNoYW5nZWQgb3Igc2tpcC13b3JrdHJlZSBiaXRzIGFyZQ0KPiBzZXQsIHRo
ZW4geW91IHdvdWxkLg0KDQpUaGVyZSBpcyBubyBvdXRwdXQgZnJvbSB0aGF0IGNvbW1hbmQuDQoN
ClRoYW5rIHlvdSwNCkRhbg0KDQo=
