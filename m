Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A831E5210
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161307; cv=fail; b=ojUI/f+1G2gTMNlXqdFcaqVLuMZ6CDceTajjkSv0F7vLhl46j37miXQ7n1yga0rplhPlV3VGVqyi8iNYuBe3JA9aGGHFVD2Vq986mNU7Wwau/6m7SwmyPLVa7GfdNCXsCtTGbgOAeX/bc5RirFBWGKY3ZosGQlqid8SOzN3VdFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161307; c=relaxed/simple;
	bh=y4h0I3s1rOjWyFkhnK8re01NKO7kX3rrlfC6qGqSzUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6tQ4+n3X0z+QFj+z4UV4rtHZD9FzE0nrVgLGgDdPuPv4uc+5UwY21lfENsHSGg6PtGZpONcCGoxrunondG/VcStGUVKexvWw9ViSGA/5kKAsRpAW5DvhIrhgANqj5zhWL0YgCo8BtX9IKpfB3aA41YV9XlmjaGBlz3sIZ3pnXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee; spf=fail smtp.mailfrom=proekspert.ee; dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b=OM9H2uOb; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b="OM9H2uOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojuGYyUldRf9ICfCccwLelSUDfgcNGfsa437Ojznl3Y+PO5JaYUkN7hban1npTjKBvTVAKDfxopeCx+rQZniYfopak+dS5RXBpdteZgAorZE674fMssRKbUL+eW20LYUCkm6dQewUGRiX/xTw4jeBEQXa0WpEWGm4GeObDLHCKbMeFOoO9vFnBH98jg0f1LK4fDyfYqBO537zsEGAbaCfW6CSK5kXkU2rcuduFJo1Z6poLNuO0qUkcJPwS3IhHPa4V3Jaq6EeVgTlplKx57IRngJOylo0uMXdPKVs+Eoj/NiPmtf8u++kasLMxU5bG5qX4CWkfOBKi1CUClUOGeXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4h0I3s1rOjWyFkhnK8re01NKO7kX3rrlfC6qGqSzUM=;
 b=viISiPaLyDlYb8jhnrFByE8DTGns47RKbzw9XIlkk61O3nhEKKRX3PquUZ8xZz3NsAByXqNYX/TlQhfnWL1J+PkacKZwSZcwF030YwOJeRxB3fLhT9rGH6bhzoHWdiDxwBPBCVXmJe6oGlwF31CermE2THoiCieDsXURLYXpZQCxQufCuWvpL0eTbNZhG32ULllZmqgidGhM863PKkxONgN2Q6xCu64Q7tPsH+yA2wmsdWffTSNgIAjYlPJCp6Xae0muX48z7lTbeJC6Mv4DhRu1FTOPSeeMwfeTee51YSlqtuugIntBum5gOfOdNFi0x3gguf2GpVquATLeQNVJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=proekspert.ee; dmarc=pass action=none
 header.from=proekspert.ee; dkim=pass header.d=proekspert.ee; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proekspert.ee;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4h0I3s1rOjWyFkhnK8re01NKO7kX3rrlfC6qGqSzUM=;
 b=OM9H2uOb3q2eRgwmoFubs1Ceg6gcp0WFWS2B5l1lKodcdqLKTN8XUD06+XYEZngM0S/JXVf29EVPG1EI6YqN3ntWYdF1YDnYFzk8wTeLQXa0BxdAjyN/0lvoIJm2Nj+5ZDDxOBybPft+/uHZgH3+mJAaZ63eJcDK+lSA4mlcNyI=
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:539::16)
 by VI0P191MB2703.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:251::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 18:35:00 +0000
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a]) by AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:35:00 +0000
From: Lauri Reilson <Lauri.Reilson@proekspert.ee>
To: Eric Sunshine <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Possible git-gui bug
Thread-Topic: Possible git-gui bug
Thread-Index: AdupPkrODeM5biBoRQ6P7hGlivxuEAAR54MABqEe6uAACrviAAAAD8Iw
Date: Tue, 13 May 2025 18:35:00 +0000
Message-ID:
 <AS8P191MB2174D9A6C109202A5195CAA2FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
References:
 <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
 <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cR4Jb0w=McwobCrtySD1nH8sF6rv7MGduQ-yVsRUHHSBg@mail.gmail.com>
In-Reply-To:
 <CAPig+cR4Jb0w=McwobCrtySD1nH8sF6rv7MGduQ-yVsRUHHSBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=proekspert.ee;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P191MB2174:EE_|VI0P191MB2703:EE_
x-ms-office365-filtering-correlation-id: 4c5991b2-9cc0-470e-24d6-08dd924cde51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnRRSzNVMGdCNkZnVlFrT3hoUEI4Y1VRLzNjZU1QdzdHZjdsWkQ3Y3BtTERK?=
 =?utf-8?B?RUZRa0RTOWxYTzVXY21SdUx2U2xhY1lFYVFadTJNc09jdVJFbkFzSlluMml4?=
 =?utf-8?B?R0wreWUxM3VwSXRVSlM3bllZWVpIQlZvZUdKTjdVQ2wrQktjRjhSbHNUYUJZ?=
 =?utf-8?B?UHFWbkVaM3hDR1RraGlZaGhObUtMN3hac3JmM3JYalZIV0c1YnZQVDkyNTFv?=
 =?utf-8?B?THRZekN2NWxuUThkeWdTU29tMTQydElCb3VPekx5OFgzMzZLSGpFaEJ0VFFx?=
 =?utf-8?B?V3NOOG8wTTh0RHB4VEQva3prY0ZPUGtpSVJ3V1FJR09WNjJ1bHMxY2tpU3l5?=
 =?utf-8?B?ZUNxVHVpVXBMdnVGeDhickx6azBHM1UwOUg2d08xNGV2UENEVWJuZE1FUUtJ?=
 =?utf-8?B?M1Y0NXR5VWVNeTBhWm1uOEtZbFQzOE9lQ3pKc2hnTTc3YXAwc2REQ1lFbndj?=
 =?utf-8?B?alQwaXZ1M1Bxd1lWS2owSzJQTFpSc05RUVQvYjZSWjVHR1dBeDFCOE02OGYy?=
 =?utf-8?B?d0xkK3NneFBsallJLzdjcmd6dSszcFdsY1grdnpGR2oxM0N2Z3VyU1J3eVUx?=
 =?utf-8?B?K0M3bjVzVkVPa0FobUdPWWdrK1ZUU09pSzR1SytUVU9VTGRKYmh5RnMwQXcw?=
 =?utf-8?B?dnd0UUFkejM1SytZbU80Ly9zWjVRa2dNYXlTdUdORElGdGRWQ012cWlCV1o4?=
 =?utf-8?B?eDRDVmgrTzBjTTF2OEl3QVcvZ1k4bDl2NWxvTmtVRk9YbnhBRlNFYkUzT25J?=
 =?utf-8?B?bWFvaUJsZ2xOTnJnVUg1bVltU0ltcFpDZTk4Q3ZzMXdQcG5QUVVOMDJRdndo?=
 =?utf-8?B?U0FpRVdHVlJ1ajQ3UUN2UnNEd0ljdHBOaUhYZllXQ0ZvRCt4NVJqSVlJUm11?=
 =?utf-8?B?Ymw1Z0NBR0VCQUxMTTJMUFJoUEtaUGprVC9GTlRFR1lPd0lFM0RqSmcrYTA1?=
 =?utf-8?B?Nk1Qb0dkNHZmemNySGNKYnZxTzU2a2JUOWh5dHR0akdRR2p5b1g1YXA2MTk4?=
 =?utf-8?B?VlhPN2luMW96Zkc5U0R3Vm1kR3F3Y2UydFBoMUpuUlRjVUdXbmdLV2lEUU9S?=
 =?utf-8?B?ZWxaYU10M3d4emdKR2Q4alFnTlorU2dPVmxsdEpZZWNEbkVSYzR2dGdpNkpk?=
 =?utf-8?B?NlRmTkF5SkFvNC8zOEFDdWtiMDNTT2V0b0kyZ3hyNjlJdldYSUE3WUVjMS9M?=
 =?utf-8?B?N01pSmMvcWtBM3duOFZGUVE5eGVGZHF3Q0NNUnBudTJGZVRILzV6OXMxNENs?=
 =?utf-8?B?TGxDeTd6eFZRckU2akM0OHVWUE11MnRjWlJHelAxbXUwNEp0Q01BZDJzS3VW?=
 =?utf-8?B?cThKaERER2VVbklTcEdJTDZmZ2ZnbGlXNG5HeDdEd0FTSFl4bXN6WDVvbHVM?=
 =?utf-8?B?aFRjYkgzNlAwbkV2Y1hDSWgzZit5dGdwSnNvVGpzNmxYOFB5TUVQOENOcHhI?=
 =?utf-8?B?L1FqL1k3SmpuSnExWjRpM09udFN0dURnUmZWU2dKQXhYTXRsbE52NDU4MU05?=
 =?utf-8?B?L09tS1QvNTVCN3dEZ3cwdnpuZyt4czBWaWJyMzR3ZXRqL2plUHlTSHg3cWRC?=
 =?utf-8?B?cDcvYjdQd2NqZlMrWlBwRlJuOWQ3cTFhZGxGQi83ODlLTXJXU1lRcE1hd0hk?=
 =?utf-8?B?YlM5bWZFZHFCY0ZmeEhhSTR4MVFtY01UZkJlMDI5VitOSWlqcEhIY2lETW9n?=
 =?utf-8?B?STVuL2s3cGduNWtLb25HN3FZUXZCVDBPamN1MUVzd3pCWG10a0N5Qzh0SmJw?=
 =?utf-8?B?TTdGUGp5QnMxZ3Rkdk1IdzRXNzhkT2VvRHpoaGNKTm4zWGhSTGwwdVFEU1p5?=
 =?utf-8?B?ZVQ2emVvYkx1TGhUT0FJTUpqd3dUcGJoT1lxaCtEZXV5T2wzeFBQbmlZQ3dT?=
 =?utf-8?B?d2Q0UHptSU1ua2hDQXBwYi9FZlpSODkyMzR2MlpNNjdLMkNEdDVDVUVORytQ?=
 =?utf-8?Q?SJZodsP47CQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P191MB2174.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDRuYklMRTUrWFBBOUVsR1dUYzlUcUpHSmo1VGFlS2FPS3NmSmk3MEJQNHlt?=
 =?utf-8?B?OGsxbS94UURDV1lvcFAwZlFUbmhJdTFNZlJFTE5aamFLRkhVVWlGd2dGbFVu?=
 =?utf-8?B?ZkR2UnY4Z0ZMSTNsTFlDNTcwQTF4ZVRxR3BvVUZOMk81K2dwam5FS21LNXd5?=
 =?utf-8?B?VDhCSjAyK2x5MWMxY1BtQkUvTWpHalJHWTgyV05mdnRnTlVJWWhHZXp3T05m?=
 =?utf-8?B?dWduN2RGd29EVWFFcXFIZDUyRmNxR2xVYldsTnlZR0w0RzFFcktFaXVOejUw?=
 =?utf-8?B?NXdCcDJRdytPQkttZE9FT2UyUHlkUlUwTlRKQmk1R0ZyUVJNRmhqV2N6RG5J?=
 =?utf-8?B?NWh1MHMzOEs4MC8vL2lxdlJzUlBtdG5lT0JuQVhQNExHT0trTGJNUzA3L1Ry?=
 =?utf-8?B?cElXR0VDUEVIb1VMNitmZnMyVXlHaWQyaVVrZUxMRlN2WmNheFh1Sm8rZWF6?=
 =?utf-8?B?SlJOanZzOEM5VjVibmR2L3dGL2JvaXNvdkgvQXY4RnJKM0ZTUXQ0bk02VFZK?=
 =?utf-8?B?Yzd4OTlNMjBJckhDckRnZUNGV0hRdkUwU1UwUmFJTUx3eG1mUmFJa3I4K09M?=
 =?utf-8?B?VFZlQ3k0YjNwUktuZWZyWUg4OVZ5c1ZKSDdFWEg5SFl3ZnVpZWlrbUdvdzRy?=
 =?utf-8?B?OEJpcnlLdXl3UWN4QlBOQmNleDJnVFJqeTJDV09iV2taRllDbmxRalEzZDFq?=
 =?utf-8?B?UzZ2NmROZDJDempDbHlXQUNHcDdCcExML1diZm0zLzIzUXZBaFcxTnhyRi83?=
 =?utf-8?B?WnFBaGc4Q1lJQmpxZjhwbmZDaVpXMjRqY0cxdDQzSStKSDl3dVhwT1BqNHhD?=
 =?utf-8?B?cFlIcitIeDJLSlAxV2VYRlNmWldCZ3BwTlYxMFNiZEQxbXNIN3liV1VqTkNS?=
 =?utf-8?B?UVNKRjZ1eUl0Zmg2WjRZYk9mTjgwWnNOaDBPTUprMWRlbVRCZlVYQUpYM0tF?=
 =?utf-8?B?U1pHQjBZTXR3YVh5WXRDQ2lJdTBZOG56YnBjRUx3bllMaVZCSFdXWU1Fcndz?=
 =?utf-8?B?MWI4S1lpYW1TM2VjNjVBSU5DdVpHaDMra3hIRkh3c3J4cVBzZ2hVdVFGMnc5?=
 =?utf-8?B?OXVZUFg0OGt3N3BrQnRDdVdKWG45YkZTaGxjYTRHL2tvdE5CaFVkTHFMTDVO?=
 =?utf-8?B?M1EvSXF4dWdIVEVaOHlNT25PTndabjBobDhLUEpudi83R05kVTI3WEJzeVFL?=
 =?utf-8?B?aytSTytia3lMQyt4QlYrTWtBNnFnM0E5dVhaajRSeGRPOHBZSURJVG5PTGVy?=
 =?utf-8?B?MTA1UGZpZWYyVkh6WWY2Sk9iOG9qaklTelcxa215OG8vRCtzSG4xSzVET2p3?=
 =?utf-8?B?ZW5GLzFDb0FmS00zc1lpb1FxaVhET05sWTdZOEhKS21hb1hLY3FzWlE2S3l6?=
 =?utf-8?B?ZzNVdlNBRnhBOE5OTXphSVU4M3Y5RlBtUWNPeStKYkV1cFg5TkFRNGFnRnpG?=
 =?utf-8?B?WlFLSi9tbDFwaTFSWit0aE81NWVuZDBjYVhxMERsaFlJSWpxYzJkYzlZbjRx?=
 =?utf-8?B?Y1hpa3BEYk5vK1lIbXF1Q2xoWklLUXBwb3dBaHp3R0ZUbG5kMEdQZlBMaVRu?=
 =?utf-8?B?UEpmUTI5NnNCMXNqaUdNdTh2Z05FanJPR3g0d0lXMFB5ZEF2TkppQ0FHbkkx?=
 =?utf-8?B?MnVyOEpLenhXRGJaaWpvd25rZU1RKzdKSFBpRmkvenpudzlxalBvQUs1MzJl?=
 =?utf-8?B?ZGVMbzNHUXZodEhOdGhzZUtOYUFhc2ZwdlpqNTI4UVg5SDVUQ0xNNWNrU2Vu?=
 =?utf-8?B?bTZuZWxKd0JSSGIxRkowTnNYRXdBUk41NXNReDdKc2E3czBYa2dRdHdPdVgx?=
 =?utf-8?B?TENsUTZZcGxiaUdjUHAzUndiQ2dBNzI4RzY2QjBzSjlzZDFXVUJ3UzVnakRw?=
 =?utf-8?B?dTFYaGJOWWg4S0sxRU52RTJRZ0VXTlBmak1tU3RVQkRTaGp4K3hvRmxFSWJv?=
 =?utf-8?B?a2tzZmxkYjBDRy9DWVFsUG1jSTFHd01yLzNpcmtGSXFJUExTNEpnUFA3SVZK?=
 =?utf-8?B?N2V0SG1kYm5xcXVENTdjVW1aRU9ISWNkTDNEanErRkxxN2lhbElEOGEyajJm?=
 =?utf-8?B?Q1h5ckpKaC9Pd0hGTUtHMVA5QlJNYjFURS9rRVJSanJNdWFGczhCMHk3V2FL?=
 =?utf-8?Q?N/tqndEKlWkM1LROsXDVLvAzF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: proekspert.ee
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5991b2-9cc0-470e-24d6-08dd924cde51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 18:35:00.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4fc69ca6-ce6b-4059-8ad9-2049c3c135b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1liAA5hiNZABn42/KpHyz7wj03vrbWSGsjiMKWgeU5w9+ljzS1WEfQoWvQyVGrUolWSghlZqpmAF6j7ti8Tc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P191MB2703

VGhhbmsgeW91LCBFcmljIQ0KDQpJJ2xsIHRyeSBpdCBhbmQgZ2V0IGJhY2sgdG8geW91LiBJdCB3
aWxsIHRha2Ugc29tZSB0aW1lLiBQb3NzaWJseSBuZXh0IHdlZWsuDQoNCldhcm0gcmVnYXJkcywN
Cg0KTGF1cmkgUmVpbHNvbsKg4oCiwqBTb2Z0d2FyZSBFbmdpbmVlcg0KbGF1cmkucmVpbHNvbkBw
cm9la3NwZXJ0LmVlDQpQUk9FS1NQRVJUwqDigKLCoFPDtXBydXNlIHBzdCAxNTcsIDEzNDE3IFRh
bGxpbm4sIEVzdG9uaWEsIEVVDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBF
cmljIFN1bnNoaW5lIDxzdW5zaGluZUBzdW5zaGluZWNvLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBN
YXkgMTMsIDIwMjUgOTozMiBQTQ0KVG86IExhdXJpIFJlaWxzb24gPExhdXJpLlJlaWxzb25AcHJv
ZWtzcGVydC5lZT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogUG9zc2li
bGUgZ2l0LWd1aSBidWcNCg0KT24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgMjowOeKAr1BNIExhdXJp
IFJlaWxzb24gPExhdXJpLlJlaWxzb25AcHJvZWtzcGVydC5lZT4gd3JvdGU6DQo+ID4gRnJvbTog
RXJpYyBTdW5zaGluZSA8c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+IE9uIFdlZCwgQXByIDksIDIw
MjUgYXQgDQo+ID4gNzoxMeKAr0FNIExhdXJpIFJlaWxzb24gPExhdXJpLlJlaWxzb25AcHJvZWtz
cGVydC5lZT4gd3JvdGU6DQo+ID4gPiBJIGhhdmUgYSBzbWFsbCBpc3N1ZSB3aXRoIGdpdC1ndWku
IEkgYWRkZWQgdGhlIGdpdC1idWdyZXBvcnQgdG8gdGhlIGF0dGFjaGVtZW50Lg0KPiA+ID4gRXhw
ZWN0ZWQgdG8gY29tbWl0IHVzaW5nIGdpdC1ndWkuIENvbW1pdCBtZXNzYWdlIHdhcyBpbiB0aGUg
Zm9ybWF0IDwjdGFzay1pZCBtZXNzYWdlPi4gSSB1c2UgIjsiIGluc3RlYWQgb2YgY29tbWVudCBz
eW1ib2wgYXMgIiMiIGlzIHVzZWQgYXMgYSBtZWFucyB0byB0cmFjayB0YXNrIGlkLg0KPiA+ID4N
Cj4gPiA+ID4gV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KPiA+ID4g
R2l0LWd1aSBnYXZlIGVycm9yIG1lc3NhZ2UsIHRoYXQgSSBuZWVkIHRvIHByb3ZpZGUgY29tbWl0
IG1lc3NhZ2UuIFRyaWVkIG9uZSBsaW5lLCBmb2xsZWQgdGhlIGVycm9yIG1lc3NhZ2UgKGZpcnN0
IGxpbmUsIGJsYW5rIGxpbmUsIHJlbWFpbmluZyBsaW5lcykuDQo+ID4NCj4gPiBUaGlzIHNvdW5k
cyBsaWtlIHRoZSBwcm9ibGVtIGFkZHJlc3NlZCBieSBbMV0uDQo+ID4NCj4gPiBbMV06IA0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8yMDI1MDMxNTE0MDkxMy41Nzc0MjItMS1vc3dh
bGQuYnVkZGVuaGFnDQo+ID4gZW5AZ214LmRlLw0KPg0KPiBTb3JyeSBmb3IgdGhpcyBsb25nIHJl
c3BvbnNlLiBUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4NCj4gVW5mb3J0dW5hdGVseSwg
SSBkb24ndCBmb2xsb3cgcXVpdGUgd2VsbC4gSXMgdGhpcyB0aGluZyBnb2luZyB0byBiZSANCj4g
Zml4ZWQgb3Igbm90Pw0KDQpJdCBhcHBlYXJzIHRoYXQgdGhlIG1haW50YWluZXIgb2YgZ2l0LWd1
aSwgSm9oYW5uZXMgU2l4dCwgYXBwbGllZCB0aGUgcGF0Y2ggbWVudGlvbmVkIGFib3ZlIHRvIGhp
cyBnaXQtZ3VpIHRyZWVbKl0gYW5kIHRoYXQgSnVuaW8gYWxyZWFkeSBwdWxsZWQgdGhlIGZpeCBm
cm9tIEpvaGFubmVzJ3MgdHJlZSBpbnRvIHRoZSBHaXQgdHJlZS4gQWx0aG91Z2ggdGhlIGZpeCBo
YXNuJ3QgeWV0IG1hZGUgaXQgaW50byBhIEdpdCByZWxlYXNlLCBKdW5pbyBoYXMgYWxyZWFkeSBw
cm9tb3RlZCB0aGUgZml4IHRvIGhpcyAibWFpbiIgYnJhbmNoIHdoaWNoIG1lYW5zIGl0IHdpbGwg
bGlrZWx5IGJlIHBhcnQgb2YgdGhlIG5leHQgR2l0IHJlbGVhc2UuDQoNCj4gSXQgaGFzIGJlY29t
ZSBxdWl0ZSBhbm5veWluZyB0aGF0IEkgY2Fubm90IG1ha2UgY29tbWl0cyB3aXRoIGdpdC1ndWkg
DQo+IGFuZCB0aGVyZSBoYXNuJ3QgYmVlbiBhbnkgdXBkYXRlcy4NCg0KSXQgd291bGQgYmUgaGVs
cGZ1bCBpZiB5b3UgY291bGQgdHJ5IGFwcGx5aW5nIHRoZSBwYXRjaCBtZW50aW9uZWQgYWJvdmUg
dG8geW91ciBsb2NhbCBnaXQtZ3VpIGluc3RhbGxhdGlvbiBhbmQgcmVwb3J0IGJhY2sgaGVyZSB3
aGV0aGVyIGl0IGluZGVlZCBmaXhlcyB0aGUgcHJvYmxlbSB5b3UgYXJlIGV4cGVyaWVuY2luZy4g
SWYgaXQgZG9lcyBub3QgZml4IHRoZSBwcm9ibGVtLCB0aGVuIG15IHN1cHBvc2l0aW9uIHdhcyB3
cm9uZyBhYm91dCB0aGUgbWVudGlvbmVkIHBhdGNoIGJlaW5nIHJlbGF0ZWQgdG8gdGhlIHByb2Js
ZW0geW91IHJlcG9ydGVkLiBJZiB5b3UncmUgbm90IGluIGEgcG9zaXRpb24gdG8gdHJ5IHRoZSBw
YXRjaCBsb2NhbGx5IGJlZm9yZSB0aGUgbmV4dCBHaXQgcmVsZWFzZSwgdGhlbiBwZXJoYXBzIHRo
ZSBiZXN0IHlvdSBjYW4gZG8gaXMgd2FpdCBmb3IgdGhlIG5leHQgR2l0IHJlbGVhc2UgYW5kIHJl
cG9ydCBiYWNrIHdoZXRoZXIgaXQgZml4ZXMgdGhlIHByb2JsZW0geW91J3JlIGV4cGVyaWVuY2lu
Zy4NCg0KWypdIGh0dHBzOi8vZ2l0aHViLmNvbS9qNnQvZ2l0LWd1aS9jb21taXQvNmI0M2E1N2Rm
Y2UxZTVhY2Q4NWY3YTgzNjVjMDgwYjZmYzRmODY0NQ0K
