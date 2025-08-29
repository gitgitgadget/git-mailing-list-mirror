Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010005.outbound.protection.outlook.com [52.103.33.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD4246BAA
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498306; cv=fail; b=NUEtbxhmIuI18A6CL+KCgKRJ+R4BliqYFduSMtfY+4Q1RprFksSIyU2IPaOui4EFZZyg3pdWOtKFR/ZSCnA8Go2KfrGMa8fH5qb+sO0GkOdi1BoCDsoV1lxdD92Z9KphTBzxGeRbUMVs2PvguAMHYJ4RUxckGiBPjpGc1jEtK1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498306; c=relaxed/simple;
	bh=+WQRQ3A4e5bR7eKssoUMrAD9anmwoXnQWPc9Nk9b+pQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajwxdRjujMMQw30IW6CXXOv2jUG5yCtO724daK+hwrlUsZ2tl2rXmEw0tHs10EBr4p00Jw/45BKiUchEeucHw3wSdjzbnES93hor/lizUf0LyCTcOYsIK49YOxGwN5gdcfilWXR33mc/WMmvWlQrWtCWPpNNr91UxjIzraszYvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Lxbgg1qi; arc=fail smtp.client-ip=52.103.33.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Lxbgg1qi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOxurkj9OyLn7Da17KphrjO6M8mXmmXKn71tatrSYfnbJWwptkqX8MRoWu9mzf2rBs1Vn+yXBOYqStwlvS+2QmWC07XRtNL5RRS8XUZtkkVrdw0IWm87HYjyvZO8bpMsr0VxuR7aV1aTy5l99zIQufeR+6GOdO5YHF/oLLvpRMz284+tdHSE7nzwI1g3hzGcJ2cFzuw0mUMqfsSY3XB47gU/5AyeXwSBjMAEoID85Nd9DyOdb4fiyORb1K++j2p52n3Y4scRx+XiZub1oXiLg7EvwaaPybKasF7fX+s3tvW6iB2Rj2bKgCnA+QTac7A2MDZI6OupYemJje4JcX9Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WQRQ3A4e5bR7eKssoUMrAD9anmwoXnQWPc9Nk9b+pQ=;
 b=Cwae/mPBZtaa2JMfE48lBJfIhm/ycNmZe5Mn3FZumA+LsrSqRIdLfZW0hah6KagcP0UgCxNzIrb3mJqpUjvhLfzKcZ2DYe/uYdLrsUSA5ptt2qmji0+6SnEDf0KMI/a/39sAXiGUBigPSLG/WHtB/A2zAlfBIQeWc/4/4fKVukTywjneoVEKtJ6y0Jh10iAPOEmYO7r9HEmsjctS//foVUilYa32UboUhzs63AOau1gkENyn5Dj31fn954/3a5PM0Fi3GUadafxoAbrOtVa2HBjQR5iUCs1AfcJyoUFL4Eu9DbrWXrWu2r27Y6qa2iITHj6yKrvGPqMg3PNn28UzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WQRQ3A4e5bR7eKssoUMrAD9anmwoXnQWPc9Nk9b+pQ=;
 b=Lxbgg1qiGEAw8wnUCVucGMEmLUR3baKLrPStAz+ZSIQTvjQaJhZPONUbIhGV2c6REH4vmS6KjYM8bA6KC5gktt5Wk+ls/5ctplsdTfLZShPou0djUIaHYDX6oOKkQ5JibHd/nNg/k2T4/ncqCCfFV+e8fvmm+Pam16PE/STIQMqmbsRHgIl9K2w0+CCFeUcXTWYa2KVTgDGAyH5WpHF5d9ds2fLEXZmAJ3DOdXp7+dAvA3g3bKYYJjMMVmL6gKUpRoQMXqEDthSz77F90PaDJZAZ603vR8qRxoFFj3dbYg/eXwqFK6gC7N9hn8FTBbc7D/Y2a5NKw78akynC5LZUoA==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by AS1PR02MB8186.eurprd02.prod.outlook.com (2603:10a6:20b:475::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 20:11:42 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%6]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 20:11:42 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhLR6DyAs
Date: Fri, 29 Aug 2025 20:11:42 +0000
Message-ID:
 <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
In-Reply-To:
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|AS1PR02MB8186:EE_
x-ms-office365-filtering-correlation-id: e2ad3ce3-80d6-40f7-1620-08dde738453e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|8060799015|461199028|31061999003|15080799012|15030799006|3412199025|40105399003|440099028|13041999003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUtEaUQ2Rk9KdWNYQW5ydFJUaXVaU1hwL0N3Q3NFckl6QXc4bk94YVp2VTZD?=
 =?utf-8?B?SFpUTTJSWCt0K3VkTHcvcnB6NUE0Z0NLVGJ1Y1NpSnZnUXRmTHVvYjFWVDRq?=
 =?utf-8?B?djFnUnhuVEU4QnUvVndKcFVEaGVhQzRPcjdjZ200Uy9VcGhIdEpxdnRQU2lC?=
 =?utf-8?B?NGsrWWNTdVFaQzVMekZJWGlZYVAyRUJTTEdZc1pCTVZ0aHYrdnlQakZCYlgy?=
 =?utf-8?B?V2djVlVOYnpTQnlDTGYzUDVvdVdpY0FFeWlPN211M1dXblFabm92ek90QnNL?=
 =?utf-8?B?UnM0bVZUak0vQ0lzSU1QZFFPdStQOWlMdXROazFVY3hpQmVFMExkbXJxUDB0?=
 =?utf-8?B?c2RGYXN3WGhMamJEQUZBc210UDNkQmVoc0RXS29vSUZpd1FubDBKb0FJYWR0?=
 =?utf-8?B?TTh3NS9LUG1hL3l6YWx1N3RNanRwSlJHTlZrSjZ5c3NYSUtkUmdOc0wxcFNy?=
 =?utf-8?B?amRWTGRpY0pBNytrTm1ORGpRa2VlU3JiUDlqZjNxRHcydXh6QWl6R1dPdUU5?=
 =?utf-8?B?MDcvY0lVQzZDVGJ2ZHBBN3c5M1NPbW5PTTA2M3JpSUJ4b1p1amd5c2tLUVE1?=
 =?utf-8?B?cGpqT0QxcXJtMUNGcW83VVliSGRvL0VQOUI5WFc0ZHd0WVBuSUlhNFMzL0Zt?=
 =?utf-8?B?OGg0M2E3UnpFWmJqMTFWNVpiWWxXbC9TNk5GV29KWUpxZmdzYmZoS1J0d2Vs?=
 =?utf-8?B?TWEreHFGOGRBbWkvWHJZL0c3ZE1TUHBrWUw1TVpCcUpJNVlLbGc0NkhkTlY4?=
 =?utf-8?B?NTd2ZnYwY1ZXbDFwYVZxazAvdElaTDVDWDI1clVUUU9HUWdjRUlMQ1BuMkdi?=
 =?utf-8?B?RmlCNmMwSXE3eFZkY1BPNE9zRGdHVDVaS3N6MzF1TTNpZktNdzl3M2M5UGxI?=
 =?utf-8?B?UGZRbXRpaHZwSW54cDl4THcrVGhHMUhSVG04cm03enNTN294L21vVVRydDZE?=
 =?utf-8?B?V0lCVG1JS1EzNWZ3Vjh6YTBBUXhuUnQ0L3VYMTR1OGVwNzlQSDM5bHZZWWFB?=
 =?utf-8?B?Y0VWT01qUHdGOWtRbGJSdHQvdHlnb0xXUXNiU1ZjRWJETjFjeWRWampaVTVX?=
 =?utf-8?B?bGptY2NMY2V3aUtWd0Z6QzlOc2x5Y3dHL0RhejZEaHpybjc4SkxWRGFIb3ov?=
 =?utf-8?B?ZnNoMHRDV3dDbDBpaUdmd0R2a3F2Y2tCaE5aNGxta3p1RXZ6bTI2NlA3Rm9F?=
 =?utf-8?B?a1dNUHExRE4wYVNDam00QnpYWGhRaHVvMlJuWXlZOFdGWjJjZjRCU1lwclRo?=
 =?utf-8?B?OXZMTDlRajhzTHZSQ3d4WHcyeFdLb3J1YXRRK0QxalNaTzd3bDk5Y3d6WjFG?=
 =?utf-8?B?bDhaeTV2TU9YZEkvT3E4VGRkcUd4aXMzbEhyZjdWbkdmSW51RzUxMWdOcFJ1?=
 =?utf-8?B?SEZlMlJFbmxMQ2hwV1FYdHBlZzRXKzg1RlJoYTFYZVBTWFlOd2JLbEpZYTJZ?=
 =?utf-8?B?VG5NbmNjWFBsZEo2RVRqMzRqNjdHOEtWMFhaMDdwZWpIWWVVMXNzU2ZtR2hk?=
 =?utf-8?B?WEdldXI5bFhROXRScjZOV3pReXllSklzN2RucWFkMEZ6VzZRMXFWcWJpUWJB?=
 =?utf-8?B?b094UzR3dUZrdjRCU3lEcGRoSEsxdnRFdWt1NUZyQkNGeUNkQTFncGVBb1py?=
 =?utf-8?Q?oMVEZohVfSNvBDgq7CfYqGKyXE775uPsyUBIGFF9Hzf0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHJTSS9zWHZIWmdkSVpGUHAvNUIzT1d3bkpUSGM5YUQxMDNjcGpIc0VXcU5a?=
 =?utf-8?B?VGxjbDJiYTczMU5MRUlVd1JJV1hEYkhnWk0zSm50cDdDVVM3RXk4bjlLZlhq?=
 =?utf-8?B?NTRuYnVVeWxncTdhSVk3dU9jdVZ0cTBCcW84RTJId1I2RE1MRGo3SVNSWERy?=
 =?utf-8?B?dzZkY0IrMVU2akk0UG5JQ2h3YkxRVUNqVFU5STY4b2IvQlFvbzRtNE1Qd2th?=
 =?utf-8?B?ckVCL0g1R3lHdXRYTHFDUzN4TFFZblUrQ2pxQllsbXNFcFV3UDZCUW1ZOEJB?=
 =?utf-8?B?RnBXVkpRSXJkZlFGV0VPeDVmdk5Ra1NiWlJGUVQvQ1hocU4rVlJGSU8wVzlU?=
 =?utf-8?B?OUpNNkdwNTgxdXlYWmt4KzFLWTZQeTZyamJ5NDNZQWxSaDBVTmFWWjdOd211?=
 =?utf-8?B?ek15Y2IzbVVLUDk1L3dHTWdVbTF6Mm90djFRckJsSFBmdTh2NkdHR0twMWZp?=
 =?utf-8?B?aFV1ZjR6ZnlpU2U0Y20vTDVtZm42c3A3VVRkTWdGRXpQUlRFZXYxRkNBamJa?=
 =?utf-8?B?ZVBISzVJMWZoVThNOGcwV2JBNERJWGpZU3ZZcWwvMkpxMk1vOCtLVStsdUgx?=
 =?utf-8?B?N0hIUDl4Yy9jUVoxVFpTeUQwWWhyM2hiaGxFbUJSTG5YblB2RXJLU3M1K1Fu?=
 =?utf-8?B?QUJCV3VqcVp4cW1Pa1NsZ2JqbnVPRlNjTjVEZnE2QlNMamxJRWVkY2pkSytK?=
 =?utf-8?B?a1VEbE8xSW9BZlBaOWVnSHhEeUtTNVY5Qi82bEw3d0haK0taV0hIbXE5VG11?=
 =?utf-8?B?aCtZcXlmK0lBci9ycUxjTmtYeEpJb0JHdk9kVWlMWmpzR0NrM0duZlc1dDY1?=
 =?utf-8?B?OURtVEJXUjFBQnVtOC8yRHdUQSt6N1JxZjNyNFJvQlE1OFBRdWxsNTYwVzUx?=
 =?utf-8?B?THJ4aEwvek8vUkhLc0pxUjJwT2loWXBBSGUzWlU0VVdYWkRnN1NqRG5qQ1Ja?=
 =?utf-8?B?QjUwc2pqVWlUS1JITmVCU3FlZHc3dmU2OG9NM1I5MXNVY0J6OVV0bnMxNmtD?=
 =?utf-8?B?TnpGdGlVMkV4WDNmb1k0bU82ZDdCWmNBYTVhTFpua0pFMEN3SzBVZUlqNFFa?=
 =?utf-8?B?RFh4Mi9qWGVYNTZtcUR4ZS9LaEU2a2p3QjZLNWc2SzhTYk51eFNlUHFWRVA0?=
 =?utf-8?B?TDAyMzdVdEI0YmpRNnpva05SSWJTMUVQOUV6eEN3ZkpBN0RUMTdJTTg2c0h4?=
 =?utf-8?B?K1BVcUpuRzl6Q0o4dU5aS1FBbHdqZW1GbEk1aWJBMmJpdGRTWEcvVWM2azBK?=
 =?utf-8?B?T014MXkxcEVFVkJ3aVhGMnVuMldrUnY1QmI5QUN4ZDQxUkJWUk5LM3kzWFBY?=
 =?utf-8?B?cnk0SVNKRnJQamFha0VieTJYcXh6Z3I0T1B3dVlveWtLd0EyaHBRem42WlZB?=
 =?utf-8?B?MHhhakdFRkNHc2w1WFBzdC95WVRXS0pxV3cvQUVNNTQyTEZ3VlpNTlh4ZFNj?=
 =?utf-8?B?RDRicXRoWDNRQXYwL09aTGNSVDcwb3lTaUw3UG45WnFkUkMzUldXcGQyZ1RK?=
 =?utf-8?B?dUNHb0tMYjdDSVVHNWszVm10L3R6eTEwSVVqbGZxM1lKM0gyS1lMaXN5TmpQ?=
 =?utf-8?B?Tk5YTytYWFBMTFp6S1RzWHlUYjcvVVZIT1Bvb3FZQ0tPQTZsMHBCVEQ5ZzU1?=
 =?utf-8?B?K3EwbW9aWDZldjZFYzNWaHdiaG1McWhaMjR6bUhDVUdvK3Y4eVBoak9OZ053?=
 =?utf-8?B?SFZLUHJDZ1N4Q0dpSUJTWFErMmJsaHAwSUprSC92NEFQTFpWYml2RDg5L01o?=
 =?utf-8?Q?IkEjWbPgDsBafltdSo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4271.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad3ce3-80d6-40f7-1620-08dde738453e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 20:11:42.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8186

SGVsbG8gTGlzdCwKCkxpdHRsZSB1c2FnZSBub3RpY2U6CgpUaGUgbnVtYmVyIG9mIGRpZ2l0cyBm
b3IgY29udHJpYnV0aW9uIHZlcnNpb24gbnVtYmVyIGNhbiBiZSBzcGVjaWZpZWQvY2hhbmdlZApi
eSBjcmVhdGluZyBhbiB4bWwgZmlsZSBhcyBmb2xsb3dzOgoKQ3JlYXRlIGEgZmlsZSB3aXRoIGZp
bGVuYW1lOiBTa3lidWNrR2l0Rmxvdy5jZmcKClB1dCB0aGUgZm9sbG93aW5nIGNvbnRlbnRzIGlu
c2lkZSBvZiBpdDoKCjw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9IlVURi04Ij8+CjxTa3li
dWNrR2l0Rmxvdz4K4oCC4oCC4oCC4oCC4oCC4oCCPEJyYW5jaFZlcnNpb25EaWdpdHM+NDwvQnJh
bmNoVmVyc2lvbkRpZ2l0cz4KPC9Ta3lidWNrR2l0Rmxvdz4KClRoZSBudW1iZXIgNCBjYW4gYmUg
Y2hhbmdlZCB0byBhbnkgb3RoZXIgbnVtYmVyIG9mIGRpZ2l0cy4KCihHaXRIdWIgc3VwcG9ydHMg
YnJhbmNoIG5hbWVzIHVwIHRvIDI1NSBieXRlcyBzbyBiZXdhcmUpLgoKKFRoZSB0b29scyB3aWxs
IGxvb2sgZm9yIHRoaXMgY2ZnIGluIHRoZWlyIGN1cnJlbnQgZm9sZGVyIGFuZCB1c2UgaXQsIGlm
IGl0J3Mgbm90CnRoZXJlIHRoZW4gaXQgd2lsbCBkZWZhdWx0IHRvIDQgZGlnaXRzIGZvciBjb250
cmlidXRpb24gdmVyc2lvbiBudW1iZXIpLgoKKApFdmVuIGFmdGVyIHRoZSBudW1iZXIgb2YgZGln
aXRzIGhhcyBiZWVuIGNoYW5nZWQgdGhlIHNvZnR3YXJlCndpbGwgZG8gaXQncyBiZXN0IHRvIGlu
Y3JlbWVudCB0aGUgdmVyc2lvbiBudW1iZXIsCnRoaXMgbWF5IG9yIG1heSBub3QgYmUgZGVzaXJl
YWJsZSwKc28geW91IG1heSB3YW50IHRvIGNvbmZpZ3VyZSBpdCBmaXJzdCA7KQopCgpCeWUgZm9y
IG5vdywKICBTa3lidWNrIEZseWluZy4K
