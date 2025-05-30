Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30323182E
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616713; cv=fail; b=m7E/MK9VAhdT1TykCf43fnwohQB5ebn87qj6rUD4oiJFrrXGwiv4zaxVzz5H2HJuO/9ajZGjh2JICXB775f31H/9UsCbQgZukJTJhFww5aWauCD/ypHe000KYafpsh3rmzh47Nw4yxAkjK9lhPQoQsOw8EyjAzfQ2bv76dNe+C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616713; c=relaxed/simple;
	bh=OJo6/kmiOhG2LObkVtySHiQb+IET++LcFCVaFDFeBdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9UPTae3Z5rd01OYr6otFsvtLmO3gOPlAIwDFm5BbYG2jQbTj+/u5+wMaKy1LEVxleTB7aIpPg2Dq2fywCIHYn6FaZXVFgxH6v1KE8AcohrV8rZ24mFkCxAkNtJb578xAeeRIh9qUHNqWDFJ4BnvJZoJmz5C7s0TYgmZCMoMLrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=EeTCOap+; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="EeTCOap+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy2bHBWRk4diV1KEiduuoSfbgDYjhfEaY9ijP3dOqzCsLspuKdLemAAIcIevSbTVPSo25kPObPYqSvNLWUv4TA3Tsz2hVuQcAViphTZi6w6ZNIk6STXZZ7+Ca6YWQHt54VCp/DK7RBHr1Z8Lr1z15OoedlDuIxpdtERQaajBPFfi8I56hDUWF5tnWoGb6PTf7ap4Hif4MryOZv6kZC8OnW9NLDAAtAbNRbfoFKAJ1RzCrW2QwoZ3SjLd1ICyVIaUHXiaBbvR/8ZVNgFlBJ2XvcgMnavcgqjb3go2Q1fyTIw0ohEiy7xHdb/vzutWpc5LGObiKT0hkUQBq+Ywog0XPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJo6/kmiOhG2LObkVtySHiQb+IET++LcFCVaFDFeBdk=;
 b=pn8wU5w7HiBcFjdB2CQDa4OPSJUtLBkEzKyYx+iA6zfIPkiOpK/BQzPEfPQBawsPW2VoN5HndVp/wNpj4OSkyxTxRPTJnmnR2ScDXfdN3lwL02ZMiTuIMO+UmGWcNzVb5bmQMX26prQBmHHlzKwcp1uClAi9Nv6oSjls0vP6DUMKUpM6Sw1yvjkGnuUTYBIYP56mxD6tc4IXSyBg6534CspVqMoHbHBfEtU17Hm/Y/mjNixGNAFf+nuYDA7DU1GMKsapSdFLtab7xWqINx65zL+vStzUAXh9/TWLWN6mqH1TCEUFdwl5hrPmXJ0Sa/+VSB301fy64CfbXtymSWwLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJo6/kmiOhG2LObkVtySHiQb+IET++LcFCVaFDFeBdk=;
 b=EeTCOap+wrmeVDU1ZCezpkXoiHS15yX35ga9CfaTosmjvs/Vjnb4DVVSQmGkF1SoXjo9NykgyeA+td/z4w1ZpeAbuQnxVoiJIwaU6ZMmyWj5zgkCBr7upFhofIslAl7f6TsiqaHQOVkksKNu4qlgTPudgFdWyWxCNT81f37qAIASVVFCVWeEsJd7qESiJYzJFlslVGMlmlDcMKULq8XgM/qrhi2erlNApIpuJLusAsdT7EdCM3o6INs/au9ZMe7t64mEtcTvsL6HZy4D03VjmliF8p9F5g+V4CsGSlYoAubuC/jaU8yEKuoRXRtdC46rjYu0K+cbd5BJ4u75KvNejQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9539.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 14:51:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 14:51:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ben Knoble <ben.knoble@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Julian Swagemakers <julian@swagemakers.org>, Eric
 Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHbz57oJD/WCXZ7hECPdkjcTXR6SbPp7EDLgAANoD2AATRLa4AAFmUAgAAA6oI=
Date: Fri, 30 May 2025 14:51:45 +0000
Message-ID:
 <PN3PR01MB95971B9CDF3DA9BDD9C5A0BEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <877c1yb53w.fsf@gitster.g>
 <C1E8439B-7666-472F-9C23-C558BA9ED53E@gmail.com>
In-Reply-To: <C1E8439B-7666-472F-9C23-C558BA9ED53E@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9539:EE_
x-ms-office365-filtering-correlation-id: 37b2a56a-1f90-47a0-352a-08dd9f897f62
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CuCreJHldClTqX8wGvhw9XbxNpfrI/Ro6bIYpIb0VxaRZ7p+lN4HDU1/tj/r1r9V1WPyrtOr7uy7AiWew6DWm0F21MYylgXxYM5S1uQkfaJaVotHhPTmwLbb29BbaFZC/iu2yL1Enfi4xBkFogmEWAgHNbzSESlEKI5AU6Vdii9SHlLMmPWiJ9rmHyZPLmggfC7bL8gfEmwA2a9QaH52Vrf4BSVo+IG6DpZGXQLfhmBwWsevPtgS7IUVA7fKnprgUM3d2cEASe3I8pNpToog7Xn2zevkdO38D0QCXIz5pMIQ1E8ftiRmziOILZkbw5aHS9UnR7m7/MmgiJBzySCT3T53E1LgVhHbAFHvnTIdtJUpTf8TbYBwKdWeEvCXjLanMFVBmoZtbYyGdoCdzTxFRrwR+lqZYH83UD0ZlUBt4t1RlyV0dh3qE4GECsZjxpnbT83Ww7H0GjcWuEjXWPMNcBPLEhe+QiT1hgMUVe2kEGLjSyessScFCSpeC+zoiLkHUiyT3Zn3MSNI8RQQF019xYSgStt6xENc3eswbSzmYGMqhkq1SyIL3mZNoTLUvHJ+JQjPyfHTUzbZ7Ozk+43Hc8KpGPOGm8vcu7H+Qerw59ax2e8jcUT7Xg5/GdmvpDON7QgsJTCG8KkHdIw9g7zdqZrlorAot1KlaT6EpHU8SxEkFtHPWCR8i/v4piOg5qkmOx3Ra3VoH3+kRXyJ0kpX4W3keJOv9uVEk
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|15080799009|19110799006|6072599003|8062599006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?UC9USG5tb0U2Y2V1MEFmcnRTVWdJTDN1R2ExTmp0MlRzZGtvclI3N3l5U1N5?=
 =?utf-8?B?dVVNZ2JJQTNjSUx1TFVqQXFlbXpZWVUvZmpKOHRxSUgzVDcvNXVWTjlaWnFq?=
 =?utf-8?B?SW5UVWl6MFRXR0JtM25vd3FYUG43aEF0NzE3OHZZTTRrbmk2SldoQ01hQVFy?=
 =?utf-8?B?cW9vZW43WXoxS2hRemdnTXdsa3VLQ1paUXBCYnpURFpRRTJGdnljb21CTjB5?=
 =?utf-8?B?S2JSRUtTSjdZZnBTNklRTnBYZ29XQTE4RkdZeFhzU2g5eUdPVzBGVTdCSnB0?=
 =?utf-8?B?Z1ZzRGUwV1kveGUyMkttY3JPR2d5OXM0YnJaVzduamM0bE0yTy84eTJEUVF2?=
 =?utf-8?B?NWd6NGxOaSs2S0JzcnBYMHVXVlcwOGttTFppV3FMNWQvcFlGa1gxOGt2ZCtY?=
 =?utf-8?B?cmhuRGJDZXdTTHh6SUJkSE92eGwzRkZBVXFVVkczMGdNUXpXd0c5UDl2MVRu?=
 =?utf-8?B?UXpNeENUSktFTTJ6ZjR1Y0plaFZlUzdXaVdka1Q4ZFAwckR4V21WTFdqMHV2?=
 =?utf-8?B?RUROMExNT3pqd1VDTzNTcDUxaUlNQ29CUWxlcUowN2ZrS2VTbDZ6TWt2QkNh?=
 =?utf-8?B?a211aDh2RTFFQnRHaHNMUFVudWpMTlBTa2RPN3lpR2Q3dlluNmY5aS84L0RO?=
 =?utf-8?B?dllJUVBSVkZHdFFWYTF3eElhcm1sREJUaUIxYkpSdHJxa0xSOXZJbWxOQ1Nm?=
 =?utf-8?B?OXQrY3E0ZERIQ0g2a2IvS1RmTFN5OHdVWWpwMHFZWGJNRGdBZ0ZIdFpWTlRv?=
 =?utf-8?B?S3lzVGpBdW5wZ2FtMTdUa3FXTFlsYmJTRTF2ZXltRnN6WWpOWEYxRUphS3VO?=
 =?utf-8?B?eHE2NmJQejZzYmFjbmRKYnR5R0J0UUJzdUl4S0ZWcTV2VmN0MkpDc1ZWdGwx?=
 =?utf-8?B?Y0U2SWcvYXc5c1YrcllEbEhLSU9EcWRnZEVFSEZta1ppV09XZUV4aERaUzdm?=
 =?utf-8?B?bzllUG9BZllLZUI5dnpkUlNLN20vV2Q4NGJHME1DZHpsUGVJclRLbUdmd2t4?=
 =?utf-8?B?alNLQ09acW1CUjh4eWgzeDFJNVlFc2pTRXByd0E2VitzRmhZVVlxOE9tSVBK?=
 =?utf-8?B?SmJobFNYMzFUYnJBOHVFV2c2WTZoejIreitGSWl6ejBna0NFaTcxZ0h3VnFt?=
 =?utf-8?B?bldYU2VJa1ZWWVdVM3hjeG83VXc5SFZuMGczN0hhQlY3cXpnQUJwRnJ2ODZt?=
 =?utf-8?B?cjNZN08xQUVXdUpkdU1TZktRQW1GSDRibUpBdXJDU2swMHJpRW0vdEU2M1I4?=
 =?utf-8?B?RDErUGFaRFNmL1FzRnhvbTlKRFJHYzFvMWU4WnM2d3UrbDN4aG9rMEU2QU90?=
 =?utf-8?B?Qys0VDBMKzBhR3N4bUt0YzdMTU10WktPU0EzVjYzclZHSU1TZjZDUjhUcGJD?=
 =?utf-8?B?L0ZtMy8yQWZjT09RbnNub29EQ3YxMTZQV05QSjNYZWJyR3pOYnd1bDRxMzBx?=
 =?utf-8?B?OUJOVmNsOFA4NWlUeklGVXJxWFZxVW8xYjNQbjdiemJaWithMkRoS1FrYnRi?=
 =?utf-8?B?bE9IVUd2dGdlZVpTRys1Y2ZKVG5tcHFGTUpJQm1IcjByRTlMOGVNNE5PTHNE?=
 =?utf-8?B?NkpYZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzZmZ1h1aXkwVzlQSStUbkNBMTJQWDRjR1RkQnFmai9FVTI4MlNDU2VONmdY?=
 =?utf-8?B?ZUJxWStIR1JhRC8xZ0lBRTl6MWhDL1BiRmNTaDdISTY3aXlCNGV3V1dBTGRz?=
 =?utf-8?B?VkNadzc3bEVZamFFZlo5bGNsamhobkhWQkNwUWRkanpmVHRrWC81TUtQc2E5?=
 =?utf-8?B?M3NQUVJrVGhJc0tuTWdncW1ZWUVkc2F3akJobk14ZGtrOEUveGFMRk15U0p1?=
 =?utf-8?B?QXc3TVpzVGpVaTV3N0dxRTRyQU5NTXE5RFNmbFQ2U1BxaEtqQnkra3lPbDg4?=
 =?utf-8?B?YTJTS2NyQklYTnVNUUVQemRZVDZpeUttclFMTE9zaHVqbEVUVTFoVGdCVGZH?=
 =?utf-8?B?QlRGYlROVjMvR2txV0xIdGl5SHlvU2dVNXNDRXdjNi9RcDVFSDF5VlkvTkFN?=
 =?utf-8?B?VkFOUkVvKzlQZWVDdWs3VGEyYUQyWnE1Z3U2K04rdXhXVEJhYlNzUUFsNzR1?=
 =?utf-8?B?VzlaS3Q1cmpBaFZPdGFORVd0ZVdxVitrMU1Db3oxZy95ZWp2cnAxTForNjRO?=
 =?utf-8?B?dkJKNThqajBWbUJFT05tU1djMHRCcWJnQWhDQ1BuUi9zVjM5Sisxd25vV0ha?=
 =?utf-8?B?MkkrZU14WG9ydG9Jcnp2WUVCMUVMTEp6bnlkUkNINEVGWlFQRVFhK3hQR3hs?=
 =?utf-8?B?TVVPWGMyQlpIR0taL21BL0FXeDYwU0UzTG80bFl1U2RSR2FleWhtL2l1aGJ5?=
 =?utf-8?B?QjRLeVZaRkhXbmVBYXZDNUozLytscElGS0xBbFByczZ4eGY1L2dQUjh3eHRi?=
 =?utf-8?B?L1hYSGJuR0RsRkZtSHJhVFlBMzFVT214VFovUXU5TUI2SEpzVm1BWHFJMlZG?=
 =?utf-8?B?VngweVFCM2JsRk5EWTdDQmg5Uitaamd5Y3pUSnZiTkhlU05aeVRvdUtjVHlI?=
 =?utf-8?B?Zzk4RjY4WU1STW5ra3FPc2VKenpNSVVvakdmRzJPdHp0aVAzRkxBdTU5bmlx?=
 =?utf-8?B?aE1ZejVtNjNsa1lyVUJwdXEzMi9UVFRLSytaVGlDbzdMaDIrT3c2V3FZM3Y0?=
 =?utf-8?B?OXgyaEdXYkhhZVJPaWUyRWw0cnNyaXc5S2pWSnJERTk3b0ZJUVV6bUlzUWF0?=
 =?utf-8?B?Snd2b0tuODh6bzhOZXl1L3dJS3IwWEx5QWJCOHpTVDE4T1FEVmVJbzNWU0Jw?=
 =?utf-8?B?Y0lXRGNCdlpONnNKMmZhbS9GSEFSVUllU2tQeE56NEl0NXRhOW8yRFNFNGRm?=
 =?utf-8?B?WEhScTVWODNqcEJUMlFkSFJ6bmp0VGZ5NTRMOGg0SWJjK2Qyb0NVRklGNEhl?=
 =?utf-8?B?TGRxZFhaSjQzTDVhUDdOejNOSUl4a2JsV01yVDQxeHQ2dzBXTjlIZ1F0clRs?=
 =?utf-8?B?dWl2V0pMNzZ4Z1BnVXN5bkJwOWxMeVBFN2R6T1p0U2JIR2RuOFc0VFRqVGRr?=
 =?utf-8?B?YndlajVzY1d4M21TOWpWbm4vUXpvVkFtc2VsZW4rNHlheGZoQkxwY0dpZEVx?=
 =?utf-8?B?VWZyY1NIOXZMNEkvMW83ampnWXdiTmRQYzc5Q201MmIvKzlRVmJTSm1aNTcx?=
 =?utf-8?B?MUJmMGY4c2dmK3FlakliYzVOSG13dnQxUXZ0VGJoNWErRFlzaGJYeS9SL3BH?=
 =?utf-8?B?aC9LWnF4WHBIVGc4aURFUFV1OHN5UXFXQzNlSDlJT28wc1NGamFBWXIxYXh2?=
 =?utf-8?B?ajM4bjY4L2VqQmt5Nm5iL08zQmpKc1VSVWZoVitoTmhRREdBdm1KN2tvcUFa?=
 =?utf-8?B?QnAvTnZUWXhEaTdnY05OOWE2UTNBSCtPdUFSUzgrZGtVcHNwQ0xYVTlPenBG?=
 =?utf-8?Q?U9SWOVTxeNIc25EfRs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b2a56a-1f90-47a0-352a-08dd9f897f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 14:51:45.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9539

DQoNCj4gT24gMzAgTWF5IDIwMjUsIGF0IDg6MTjigK9QTSwgQmVuIEtub2JsZSA8YmVuLmtub2Js
ZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiBMZSAzMCBtYWkgMjAyNSDDoCAwOToy
OCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiBhIMOpY3JpdCA6DQo+PiANCj4+
IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyaXRlczoNCj4+IA0KPj4+
Pj4gLVdoZW4gYC0tY29tcG9zZWAgaXMgdXNlZCwgZ2l0IHNlbmQtZW1haWwgd2lsbCB1c2UgdGhl
IEZyb20sIFRvLCBDYywgQmNjLA0KPj4+Pj4gLVN1YmplY3QsIFJlcGx5LVRvLCBhbmQgSW4tUmVw
bHktVG8gaGVhZGVycyBzcGVjaWZpZWQgaW4gdGhlIG1lc3NhZ2UuIElmDQo+Pj4+PiAtdGhlIGJv
ZHkgb2YgdGhlIG1lc3NhZ2UgKHdoYXQgeW91IHR5cGUgYWZ0ZXIgdGhlIGhlYWRlcnMgYW5kIGEg
YmxhbmsNCj4+Pj4+IC1saW5lKSBvbmx5IGNvbnRhaW5zIGJsYW5rIChvciBHaXQ6IHByZWZpeGVk
KSBsaW5lcywgdGhlIHN1bW1hcnkgd29uJ3QgYmUNCj4+Pj4+ICtXaGVuIGAtLWNvbXBvc2VgIGlz
IHVzZWQsIGBnaXQgc2VuZC1lbWFpbGAgd2lsbCB1c2UgdGhlICdGcm9tJywgJ1RvJywgJ0NjJywN
Cj4+Pj4+ICsnQmNjJywgJ1N1YmplY3QnLCAnUmVwbHktVG8nLCBhbmQgJ0luLVJlcGx5LVRvJyBo
ZWFkZXJzIHNwZWNpZmllZCBpbiB0aGUNCj4+Pj4+ICttZXNzYWdlLiBJZiB0aGUgYm9keSBvZiB0
aGUgbWVzc2FnZSAod2hhdCB5b3UgdHlwZSBhZnRlciB0aGUgaGVhZGVycyBhbmQgYQ0KPj4+Pj4g
K2JsYW5rIGxpbmUpIG9ubHkgY29udGFpbnMgYmxhbmsgKG9yIEdpdDogcHJlZml4ZWQpIGxpbmVz
LCB0aGUgc3VtbWFyeSB3b24ndCBiZQ0KPj4+PiANCj4+Pj4gU2hvdWxkbid0ICdHaXQ6JyBpbiAi
b3IgR2l0OiBwcmVmaXhlZCIgYmUgbWFya2VkLXVwIHNvbWVob3cgYXMgd2VsbD8NCj4+Pj4gDQo+
Pj4+IEFzIHRoZXNlIG1haWwgaGVhZGVyIG5hbWVzIGFyZSBhbGwgbGl0ZXJhbCBwYXJ0cywgc2hv
dWxkbid0IGVoeSBiZQ0KPj4+PiBtYXJrZWQgdXAgbGlrZSBgVG9gLCBgQ2NgLCBldGMuPw0KPj4+
IA0KPj4+IEkgdGhpbmsgaXRzIG9rIHRvIGxldCB0aGVzZSByZW1haW4gaW4gJycsIGFuZCBkZXZp
YXRlIGZyb20gdGhlIHJ1bGVzIGEgYml0Lg0KPj4+IElmIGJhY2t0aWNrcyBhcmUgdXNlZCwgaXQg
d2lsbCBiZSBhIG1lc3Mgd2hlbiByZW5kZXJlZCBvbiB0aGUgd2Vic2l0ZS4NCj4+IA0KPj4gSSBk
byBub3QgdGhpbmsgSSBhZ3JlZTsgYmVuZGluZyB0aGUgcnVsZSBvbmx5IGJlY2F1c2UgdGhlIGRl
bnNpdHkgb2YNCj4+IGxpdGVyYWxzIGluIGEgc2luZ2xlIHBhcmFncmFwaCBpcyB0b28gaGVhdnkg
ZG9lcyBub3Qgc291bmQgbGlrZSBhDQo+PiBnb29kIGFwcGxpY2F0aW9uIG9mIGEgcnVsZS0tLWl0
IGlzIGhhcmQgdG8ganVzdGlmeSBzdWNoIGFuDQo+PiBleGNlcHRpb24uDQo+IA0KPiBUbyBnbyBh
IGJpdCBmdXJ0aGVyLCByZW5kZXJlZCBIVE1MIGlzIGFsc28gbm90IHRoZSBvbmx5IG91dHB1dCBm
b3JtYXQsIHRob3VnaCBJIGRvbuKAmXQgdGhpbmsgdGhlIG1hcmt1cCBoZXJlIGFmZmVjdHMgbWFu
dWFsIHBhZ2VzIHN1YnN0YW50aWFsbHk/IFNvIHVzaW5nIMKrIHRoZSB3ZWJzaXRlIMK7ICh3aGlj
aD8gcHJlc3VtYWJseSBnaXQtc2NtLmNvbSkgYXMganVzdGlmaWNhdGlvbiBwcmlvcml0aXplcyB0
aGUgbG9vayBvZiBvbmUgb3V0cHV0IGZvcm1hdCBvdmVyIG90aGVyIGNvbmNlcm5zLCBubz8NCj4g
DQo+IEZvciBwbGFpbnRleHQgdmlld2luZywgY29uc2lzdGVuY3kgaXMgcHJvYmFibHkgaGVscGZ1
bC4gIA0KDQpPayBJJ2xsIHNlbmQgYW5vdGhlciByZXZpc2lvbi4=
