Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013074.outbound.protection.outlook.com [52.103.46.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906920CCE4
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764820763; cv=fail; b=P5+PrP+2Mwalz9aGUJYoK3PJ8uZCnNp9CsLc0NH9/76CtBJ3iZYT/tD20i9bTenIbj0Pxz2BskgsxZg05trcek3LzH54rUtJyjFPSdQJ9MZzGAax2j8L/nIo9oB/vUsP676OsTslxzQYwLBW3ogAa4p6RiylPFdvRVIhi51pB8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764820763; c=relaxed/simple;
	bh=BKlncaVjacemDke53/KWJy2lzEleNMBJ+KppEsfE6j8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hd7SjEd3LDRsRXeOJ7IvSDKX133VLxj176SvLUhqQmHpJVrZuRaFocZVobndOi2gASliKC+WxiRxTf0rSJdalhB0TF4xsHlvSMEuE9cOhASKTr/60ppL5FEBtxcpoGHD00VRZzAJiWE1/Wb8P7aEbFnLMWstpn6CiqJcOlNlhbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=iJ/PRS/A; arc=fail smtp.client-ip=52.103.46.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="iJ/PRS/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrO7fnpaoCtk1pC67AvMecsrKCYrPbTreFhEDcMwiCEqe1lNdSPcJui+dAHWOvbo5Md9CPsnQbQMothSmgUzQvGf6te8hDIwKI40Z1ukq+QE2DQ+AWR6iOZuBVQFA2I8gSxr1FbtCCdFt2Te0IiZ2KuILk0IJqN6ZO6isBeHqMCMAYbX8BhsArNhm0O9NPP0begiKu152Z4jLFBGKrgCx+8qQRkvKyfAYfl9OFKcPqGUqvWCw318Q6Gyr4m70IuRuHXiDV02Rm/nfQyPP8CxrIbdYVgUQdNL1O42I8/8SFbxdmUhAWi0l8cyF3Eunq2Ijs5Lg/E4c9J+ryea3kij5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKlncaVjacemDke53/KWJy2lzEleNMBJ+KppEsfE6j8=;
 b=GNi6SDQZan7oNqk9exgCAjSz2WHWIEcnryJwyi5twcgnXGmzFNw3fJYES03Pmw4SRmyb2yeL+GYYfCkpVOyNw8w+k7L7o26ucdkLc+H9v3oYKfSMqX5DSCvq4AcQLO2hCnfjfOX7DNi3au/qBd8pAGWgFLWCxilAZlf+/PGlyP2HfV7zb1yM2bqg4kuvQOwCFC6ySpslYSaFd4e1wLFIQIfzYWQ53TLNHpWX3Wrc+aRHeZ3ujMovFXbT9MwL+l80xjVQtxt9NAcd+Ht+R8Ev6BbmhH1CtG2DZGJmQ33lkhFGsThfx2xN8+DD5M+rM+DRh9P98KcFHT7l/Hj6rdJHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKlncaVjacemDke53/KWJy2lzEleNMBJ+KppEsfE6j8=;
 b=iJ/PRS/A74YSwNiRvbkelsZ2tMcVhLZHQxytue750Gx6m3AYV8FIIs9Qfx6gAj3XgVpDZt33i3cChVlgk7CukAVRoufsvcgEF+g3pITSs1EuiJBLbnZpMKZUBDFuQmePTWUUfGTr92iwkiNf/z/aBmgswkEOYPs8WSuccL3YKUzbOHFIetNh9Tg/zVFLXWXRGwF69JVpp0MXGcrvo6KJLMnv7MiV9l+Es6vphyACYKILcJXR98saQS+ZFJbBkUUsdFEfeNEeIUihUwOoTmab6ryIRX4m9zTPuCZSMMu2X3MGmYWoYvn5szrjoxQRd9UxWMNxrCyK+jQq4u3RX9Q3Ow==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by AS4PR02MB8648.eurprd02.prod.outlook.com (2603:10a6:20b:58f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 03:59:19 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 03:59:19 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Copieing git repository to another disk is dangerous ! Especially in
 combination with remotes set to local repositories !
Thread-Topic: Copieing git repository to another disk is dangerous !
 Especially in combination with remotes set to local repositories !
Thread-Index: AQHcZNANxv+9d4zHWkWdZOP5UpgyTA==
Date: Thu, 4 Dec 2025 03:59:19 +0000
Message-ID:
 <AM0PR02MB44508B247E4B6EF4F387DA5FB3A6A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|AS4PR02MB8648:EE_
x-ms-office365-filtering-correlation-id: 40ad71ee-021c-4681-cbb7-08de32e98033
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpUgH3QNX0t+J4zM1erZle7oiEEArIO1PKx2s5tRZY4Hr7uU34BhWmtwm0cZsb6cWq+gnE0FUzWnoy0VDq1Iec2HtQLlo1UJkq2yMKBf7bJVrnOaR/BwHKG2N43g8MI3/H+hUx+ZT/cAHlQcR/n0iw9m/EJEOxpBqxaVRaFH+hLkFCYnFpE7pCysMD6q2Kvb4pUOhRmLpvL4QamrrB48UdU88ewuDu7/V8YaSXHkmr3qsBqQrXz3Nd4NgDaxMC+qp/keBWBfNPQhobMmFqfYH6BKNVmHOOgips4Rw34Ck32Nv0txV/W4sr0CBS2pFMnjPIlNw8bWf0ugSeL8iD4zSSiuY0wJmde/GmHEyhQXuqr80FumiOQMIBcTz9DjUTATkSnoif2ivhXs0O7RS6aUE/+nEdhV2n6aICTeLtug/p0sBnvHJurhvJpiKwJDpkbYIDW0pjTyqNIRIQ7d7gcizZVm60Alzec03fpostVhLSBzp6qDZZMM45uS8Rnq0v2ZQL2zHnKXgP9VocQ7AUZyBrNEeLj2KuE6mDSZTMMX+l91tuflzTgyse0yDKEAiCJqE1NKRK/UBDk/S9+iucHEMaUMLvMrOl4ln+gd8miltQG5qDPAYKctY2TaffzxM8t6LWSZFlo9hU3KvubHsysx0kWDcgDWwv8AXL2iFpyALXx3W0bOl/vB4gOtM6t/o1shUqCC/5DVN3YKN0qONXKG13LqK605goJax2nRZm9DdCQ7woHWcwYZUgs7
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|15030799006|461199028|19110799012|8062599012|51005399006|8060799015|40105399003|102099032|440099028|3412199025|10035399007|26104999006;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTY4Rm1SaUFZYXkwdVlIOEtDTVVzT2tGcVowYUdvU0hWY2FvNzBQUHpkYlBK?=
 =?utf-8?B?bmk5cU9panpzejlVemY1Q0hpdEZqSzdyV1piNzJtR1cwT21vaktQMzFWeGhE?=
 =?utf-8?B?OTJWeFJJejQ2dENZS0lQbi9tNEZWR2kyM3djQkh0ZkRuY0IzalRrWUhiSnJZ?=
 =?utf-8?B?VzRRd0lVbldBYXoxajFlOWxiWTRQUThBUFpORi9wVDIxKzVhMHhxUGV4QWFK?=
 =?utf-8?B?RHoxanJpZHFRS0RORHNKejNPRmNZRWxENFA2b0lnUTBkY2ducG8wV0FPdmlP?=
 =?utf-8?B?Z0RYZWh0RlBubVcvWXZYeE9vQ3NHMU5UWGYvVjI3WnNNVU1sSW9WUEcxVjVN?=
 =?utf-8?B?NWJMSVdoT1p2K095Z0NiYkVDV2RpcklyMG5EcGw5a3g4V1hRNG5oM0RhOEdD?=
 =?utf-8?B?OXh3OUtRSUp1YlF0Kys0Ky9DMGhEVTZpT3o4d2dMYng3TGk0V1BpYlVQSDJC?=
 =?utf-8?B?dW5rM2lZMTdxYWsvdjJsd3UwbWRjSHZFbG5WbThWd2NWcHp2Ry9leFNaREpM?=
 =?utf-8?B?QnVlNzZiSzZDaFdPQlExbGpXdDR2Tlk2eS9zc1VjSXRtRm5BeEw2dU1ZQVhx?=
 =?utf-8?B?MGgyWXdMMXZKUHVGamdZbGlUUDRZOUoxNUxwbFBsRjZPdUgxeWtVeW5McURR?=
 =?utf-8?B?eEs5cmp0WmhmZmdnNHMrdkRhVG9wR20vM0NmczNWQWlWQ1NlWTM2b0ZZZXAw?=
 =?utf-8?B?ME5qSGd5cGQ4M3BTTlVUV1VHT3hVSllsZ2RPKyttdDIvb01kNWtzVUdPK3BQ?=
 =?utf-8?B?djRwd3RYejd3aUxjOUdidXNvbHZnM0JLRzdxOEVGRWpsd3A4YkxHVE1MMkFJ?=
 =?utf-8?B?Mm5EMU1vdDUrdkl5bmdYREI0YlBBdWpQT1o1QnFmejlrckZrU29Vd29wNnR0?=
 =?utf-8?B?QmtxdnBJWVUrTGpYdXpWZ3Q0YSt5YktYV1ZWUFZyVmQ1VE9iRVErNmVSckRQ?=
 =?utf-8?B?K1MrZjl1eTNwUEk5aHhzN05DSWJzMzVqbTFCeHNwZVZyMDNyUU8xbVd6dTRo?=
 =?utf-8?B?K2w0QWx4UktvU3R2dVdRYmFTNXBQNU9QM29UV3VnNjA1QXpjcmFJWXVMK3lR?=
 =?utf-8?B?MzM4bmdTRDZTNnlOQUVYcmZhNWl2Z05pamV3MFlqZ2hTVkNZbkgyNEcrUHpy?=
 =?utf-8?B?aks0Zk9OdGpYTi9JeUtCUjBHdXNZT0pPYVJqMi9wQUpRMmhFc3owL2NwZnln?=
 =?utf-8?B?dFJJSWRvUDh2c0REYTM0Q09qM3JXMCtTMCtoOHJyUDZZbXVSRXI2TWdzU3Jl?=
 =?utf-8?B?Qm1VQmJISG9IaU10TWwyL2twMkVZVENDem5mSEN3QTdFY2pFYmtMdWFiT1Fa?=
 =?utf-8?B?SENDbnBubWI5VDhnb3p2N2hBUStDOG9kQnE0RVBWSEh6R0hhWW1FRkJHcHZ1?=
 =?utf-8?B?Tk5RK0wzS2ZkUnFzeDNibHJlY2FrL01kS1BEeklya3RWNjhlTzZYcUtJWTUx?=
 =?utf-8?B?UGZ4b1BtWU43dlU1VGw4Q3NjOFhEV3IvVGRBVHpheklQY2pVNDd1WEZlV1ow?=
 =?utf-8?B?a1pGWmhHOTFJUkNrOHhPUEk1eVFybEo3TldqLzZuemZ0V2d6MVltdlJPeVBm?=
 =?utf-8?B?V0FiTzFreHpjNEcyTTdvWkU2Q0hPRFE3bkRTcnRWZlhQcVRUWXp0aG01Qm1o?=
 =?utf-8?B?U0JDWnEzaUhMRXlCd251SzJpOS9FcDJDQmhvVEwrMFQ5OWFIUEM0YUVockNn?=
 =?utf-8?B?djFSaWQxNzQ3bGVtS0VOU1VLQ2tvaDhzQ2o3RC9sSkllcjUwWWJFWVVSL3hO?=
 =?utf-8?Q?DrBA13ZJ39JUM1li7joHmKZAcAB6nQqkL8cz6mP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm0xOXY0M1JDdWp3UG9GM0ljdGtqSnRPbTVraVpUM0dYRFVkVm5XMDJKTWlQ?=
 =?utf-8?B?TjlBL0c4WCtBV2txcENVd2M1ZXBiTnFkWTQ0QzFqQ1ZHNDE0MHVxZU5walVr?=
 =?utf-8?B?OW4zVmVzZ0R1K3FCQkxFRzl0VzdrZXRHbkVJV0Y2YWhuZkFxZDVFZ1NhK0RP?=
 =?utf-8?B?eUlVVlJTeHRzbHJRcVpNVkhTSnhDdUVEd2dFQWx0Tmd4ZmpxYnNodHRzVzhq?=
 =?utf-8?B?SnVpTGFCR2xEbXg0dzBmTXRxYjlyMHBOSWV4V1EzYmtPTG1WR0FnU3ZMSFlM?=
 =?utf-8?B?eDg5Yk5FbUIreTFXeElNYm04Z05YVlJvNXpzS1dIRGhXSVBmNFFIVlZjY0JI?=
 =?utf-8?B?M2xKbWh4dktQNzAzWFd4Z1Y0TlE4Mkg3c295cEtWVWR6bjl2YXFKcmpJbzdW?=
 =?utf-8?B?V2RRWWVDNERLRGxmc1ZtUlRaOGR1N0dHYjZxMzlzdzQyek9jMXlYVWJFZzJT?=
 =?utf-8?B?SU1jV21ETzdjWEplRGFtOTdqbExPWmJxdUROSlJPTE9vYXFXa3pXbTRjU0to?=
 =?utf-8?B?eGdOcjNlZ0JtWGhvTkFoemtRQmJLMFRIdnJucHlIMVFCUjFCNFcwMzF1U2F6?=
 =?utf-8?B?NUVmcGZBaWUzNXNKaW1kQ204RWZtMlp6Q2RIM2xta0JuMTVoM1VSRjhLTjFO?=
 =?utf-8?B?Y3pEdHpMdGdlQUQ1T3h5T1FreXlIVEgreVMyczAwQXNSZUYvU0JXM3FIWngz?=
 =?utf-8?B?RnBSTEZOc0Qzb1dhOGlmdGlzN1F6a29vMUlQYXRhcE4wZnVCTzRHRW01anZq?=
 =?utf-8?B?QkRoYUoyajdXTzRXT1hSK3F6Slc2MXYzdi9lL0x0OUp1SE9YczBkMjN5TGxX?=
 =?utf-8?B?UkRnU251M3pSVEl4Tm9vTm9wanlDL29TMFdDUmtReG1WKzIrdVptWlQ4YUpB?=
 =?utf-8?B?OVJRRzk5ZlVxTkpsQVNXV3BNWENyUlNHZHJEYWtvNGN6bmovTU8xT2l2SnFm?=
 =?utf-8?B?Vm1xZXJOWTZ3OTZLU3ZqbWFjYU5qUkRxYUYvWEs4dHZoQmhRckZpQzRUdCtr?=
 =?utf-8?B?WjMwaGtJd1hZTXpudG9ZQXZYeWhsSjloSDVnZ2JYc0dkakY1bnlYTHlwa2s0?=
 =?utf-8?B?dThDOGIrN3lUL0wwN3FwTTMyRlZVZm1Ta0pGVnhtSDVXcHJkVGg1bWljU3hQ?=
 =?utf-8?B?YzZ4WTdkZSttWkVlWEpreUdjS0M4RnZxcXVjNTlTREFYeWM4UjIzcmtGRHZx?=
 =?utf-8?B?QmJJWVJ5M1VmTVNodWhybi9YdGJwbW02SzVFelM5WldHQkhWcGFRZnNkYkxW?=
 =?utf-8?B?aGV4Y1JDLytGSUF6RmJZUFVidCtYRlhLaVl0MGVqMkdJSDNlT2lXb0doUVAy?=
 =?utf-8?B?OGtmaGlIeGprTmZPQzc2dkRjL3piUCtFb3RrVlRsaU4vNmVYVjJkZ3BqYmhx?=
 =?utf-8?B?dHlOdGdIenI3cU5EMy9kamVjaElQaFlSVGV1YWF3OG5GL2dPMWIxd3J1disz?=
 =?utf-8?B?N0NYRzhrM0w4SU8zRXdheExaMnpMUUx5eDg3NndtUTRmTHlndjZVT1lRa1Yy?=
 =?utf-8?B?U1h2ek1JK0sySEJTYnZwUjJ0Q0d4NGRibzhKbGlIb0k1anV2eGU2Q1pTVG1I?=
 =?utf-8?B?WmpaM3Voem9uWUJtVUdvd1JXUmRJTXBkU3ppMlZuMmhibXZHbUxIYlhIQ2J0?=
 =?utf-8?B?Umx2QzlTd1djN0VUcGY3UVB2VWxlTGp0TjR5RWVpMkFRNmtjclpzeDh3TDNT?=
 =?utf-8?B?MTFGQVNxS2I3UWZYNmc2c2lDdys3dlA5bzJodGE2Uk9sMVViOWY2d1FTR0NP?=
 =?utf-8?Q?7wbqSeVIPjRMABk0yw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad71ee-021c-4681-cbb7-08de32e98033
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 03:59:19.1686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8648

Rmlyc3QgdHVybiBvZmYgYXV0by1jYXBpdGFsaXphdGlvbiBpbiB3aW5kb3dzIDExIG1haWwgb3B0
aW9ucy0+ZWRpdG9yIHNldHRpbmdzLT5hdXRvIGNhcGl0YWxpemF0aW9uLgoKVGhlbiBJIGNhbiB0
cnkgYW5kIG15c3RpZnkgeW91IHdpdGggcHJvcGVyIGNvbW1hbmRzOgoKWDoKY2QgWDpcVml0ZVxS
ZXBvc2l0b3J5XE1pcnJvcgpnaXQgY2xvbmUgLS1taXJyb3IgaHR0cHM6Ly9naXRodWIuY29tL3Zp
dGVsYWJzL2dvLXZpdGXCoC4KCmNkIFg6XFZpdGVcQnJhbmNoXERldmVsb3BcRGVscGhpCmdpdCBj
bG9uZSAtbyBSZXBvc2l0b3J5ICJYOlxWaXRlXFJlcG9zaXRvcnlcTWlycm9yIiAuCgpOb3cgY29w
eSB0aGUgY29udGVudHMgb2YgdGhpcyBkaXNrIHRvIGEgbmV3IGRpc2suLi4gKHZpcnR1YWwgZGlz
a3MpCgpSZWFkIGRvd24gYmVsb3cgd2h5IHRoaXMgaXMgZGFuZ2Vyb3VzCi4KLgouCi4KLgouCi4K
LgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgou
Ci4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KLgouCi4KSGVyZSBpcyB0aGUgcHJvYmxl
bSBhbmQgZXZlbiBzb2x1dGlvbjoKCkxldCdzIHN1cHBvc2UgdGhpcyBpcyBjb3BpZWQgdG8gZGlz
ayBaOgoKZ2l0IHJlbW90ZSAtdiB3aWxsIHNob3c6CgpYOlxWaXRlXFJlcG9zaXRvcnlcTWlycm9y
CgpJbiBvdGhlciB3b3JkcyB0aGUgcmVtb3RlIGlzIHN0aWxsIHBvaW50aW5nIHRvIHRoZSBtaXJy
b3Igb24gZGlzayBYICEhISEKCkFueSBjbG9uZXMgb24gZGlzayBaIHdpbGwgY29tbWl0IHRvIGRp
c2sgWCwgbGVhZGluZyB0byBhIGJpZyBtZXNzICEKCkl0J3MgdGhlIGRyaXZlIGxldHRlciAhCgpJ
dCBtdXN0IGJlIHVwZGF0ZWQvY2hhbmdlZCA/IQoKV2hpY2ggbGVhZHMgdG8gdGhlIHF1ZXN0aW9u
OgoKQ2FuIGRyaXZlIGxldHRlcnMgYmUgYXZvaWRlZCBpbiBnaXQgcmVtb3RlcyA/CgpVc2luZyBh
IHBvd2Vyc2hlbGwgc2NyaXB0IHRoZSBBSSB3YXMgYWxzbyBraW5kYSBzdHVwaWQgYW5kIG51a2Vk
IHVwc3RyZWFtL29yaWdpbiB3aXRoIGNoYW5nZWQgZHJpdmUgcGF0aCwgbGVhZGluZyB0byB1cmwg
bG9zcyBidXQgdGhhdCBpcyBtaW5vci4KCkFueXdheSB0aGUgQUkgaGFkIGEgc29sdXRpb24gdG8g
c3luYyB0aGluZ3MgYmFjayB1cCBvbiBaOgoKTXkgb3duIHN0ZXBzIGZpcnN0OgpDb3B5IG1pcnJv
ciBmcm9tIFg6IHRvIFo6CkFkanVzdCB0aGUgcmVtb3RlIHRvIHBvaW50IHRvIFo6IGluc3RlYWQg
b2YgWDoKClRoZW4gZm9sbG93IEFJIHN0ZXBzOgoKU3RlcCAxOiBGZXRjaCB0aGUgbGF0ZXN0IHJl
bW90ZSBzdGF0ZQoKZ2l0IGZldGNoIFJlcG9zaXRvcnkKClN0ZXAgMjrCoCBTdGFzaCBhbnkgbG9j
YWwgY2hhbmdlcyBhbmQgdW50cmFja2VkIGZpbGVzClRoaXMgZW5zdXJlcyBub3RoaW5nIGdldHMg
bG9zdCBvciBvdmVyd3JpdHRlbjoKZ2l0IHN0YXNoIC0taW5jbHVkZS11bnRyYWNrZWQKClN0ZXAg
MzogRmFzdOKAkWZvcndhcmQgeW91ciBsb2NhbCBicmFuY2ggdG8gdGhlIHJlbW90ZSB0aXAKZ2l0
IHJlc2V0IC0taGFyZCBSZXBvc2l0b3J5L0JyYW5jaC9EZXZlbG9wL0RlbHBoaQrigKIg4oCC4oCC
4oCC4oCCVGhpcyBtb3ZlcyB5b3VyIGxvY2FsIGJyYW5jaCBwb2ludGVyIHRvIG1hdGNoIHRoZSBy
ZW1vdGUgZXhhY3RseS4KWW91ciB3b3JraW5nIHRyZWUgd2lsbCBub3cgcmVmbGVjdCB0aGUgcmVt
b3RlIGNvbW1pdCBiNmZmNDFmMjgvd2hhdGV2ZXIKClN0ZXAgNDogUmVzdG9yZSB5b3VyIHN0YXNo
ZWQgZmlsZXMgaWYgbmVlZGVkCmdpdCBzdGFzaCBwb3AKCklmIHlvdSBoYWQgbG9jYWwgZWRpdHMg
b3IgdW50cmFja2VkIGZpbGVzIHlvdSB3YW50ZWQgdG8ga2VlcCwgdGhleeKAmWxsIGJlIHJlYXBw
bGllZCBoZXJlLgoKSWYgY29uZmxpY3RzIGFwcGVhciwgR2l0IHdpbGwgbWFyayB0aGVtIGNsZWFy
bHkgc28geW91IGNhbiByZXNvbHZlLgoKU3RlcCA1LiBWZXJpZnkgYWxpZ25tZW50CmdpdCBsb2cg
LS1vbmVsaW5lIEJyYW5jaC9EZXZlbG9wL0RlbHBoaSAtbiA1CmdpdCBsb2cgLS1vbmVsaW5lIFJl
cG9zaXRvcnkvQnJhbmNoL0RldmVsb3AvRGVscGhpIC1uIDUKCuKGkiBCb3RoIHNob3VsZCBzaG93
IHRoZSBzYW1lIGNvbW1pdCBoaXN0b3J5IGF0IHRoZSB0aXAuCgpUaGUgc2xpZ2h0bHkgYW5ub3lp
bmcgdGhpbmcgaXMsIHRoaXMgaGFkIHRvIGhhcHBlbiB0byA4IGNvbW1pdHMgY29udGFpbmluZyBl
aXRoZXIgbGFyZ2UgZmlsZXMgb3IgbWFueSBtYW55IG1hbnkgdGhvdXNhbmRzIG9mIGZpbGVzLCBm
b3J0dW5hdGVseSBteSBzeXN0ZW0gaXMgZmFzdCBhbmQgZ2l0IGNhbiBoYW5kbGUgYW5kIG15IHN5
c3RlbSBoYXMgbG90cyBvZiByYW0gb3RoZXJ3aXNlLCBPT1BTSUUuCgpBbnl3YXkgSSBkaXNjb3Zl
cmVkIHRoaXMgcHJvYmxlbSBlYXJsaWVyIG9uLi4uIHBwZmZmaWV3dy4uLgoKQWxsIHRoZXNlIHN0
ZXBzIHdlcmUgdHJpZWQgb3V0IGFuZCBpdCB3b3JrZWQsIHByb3ZpbmcgaXQncyBub3cgdGhlIHNh
bWUgYWdhaW4sIGFuZCBpbmRlZWQgdGhlIGZpbGVzIHdlcmUgaWRlbnRpY2FsIGxvY2FsbHkgYW5k
IHJlbW90ZSwgYnV0IGhhZCB0byBrbm93biBmb3Igc3VyZToKClo6XFZpdGVcQnJhbmNoXERldmVs
b3BcRGVscGhpPmdpdCBsb2cgLS1vbmVsaW5lIEJyYW5jaC9EZXZlbG9wL0RlbHBoaSAtbiA1CmI2
ZmY0MWYyOCAoSEVBRCAtPiBCcmFuY2gvRGV2ZWxvcC9EZWxwaGksIFJlcG9zaXRvcnkvQnJhbmNo
L0RldmVsb3AvRGVscGhpKSBBSSBTeXN0ZW0gUHJvbXB0cyBhZGRlZC4KYThiMzQxNWVkIEdvVG9E
ZWxwaGkgbWFwcGluZ3MgYWRkZWQsIGV4aXN0aW5nIGFuZCBtaXNzaW5nLgphN2EzYmNjMTIgZ29s
YW5nIGNvbXBpbGVyL3J1bnRpbWUgc291cmNlIGNvZGUgYWRkZWQuCjdmOGRmYjQ1ZiB2ZW5kb3Ig
cGFja2FnZXMgYWRkZWQuCmI2ZTVlN2I2ZSBHZW1pbmkgMy4wIFBybyBmaXhlcyB0byBMb2cxNSBh
bmQgY29tbW9uCgpaOlxWaXRlXEJyYW5jaFxEZXZlbG9wXERlbHBoaT5naXQgbG9nIC0tb25lbGlu
ZSBSZXBvc2l0b3J5L0JyYW5jaC9EZXZlbG9wL0RlbHBoaSAtbiA1CmI2ZmY0MWYyOCAoSEVBRCAt
PiBCcmFuY2gvRGV2ZWxvcC9EZWxwaGksIFJlcG9zaXRvcnkvQnJhbmNoL0RldmVsb3AvRGVscGhp
KSBBSSBTeXN0ZW0gUHJvbXB0cyBhZGRlZC4KYThiMzQxNWVkIEdvVG9EZWxwaGkgbWFwcGluZ3Mg
YWRkZWQsIGV4aXN0aW5nIGFuZCBtaXNzaW5nLgphN2EzYmNjMTIgZ29sYW5nIGNvbXBpbGVyL3J1
bnRpbWUgc291cmNlIGNvZGUgYWRkZWQuCjdmOGRmYjQ1ZiB2ZW5kb3IgcGFja2FnZXMgYWRkZWQu
CmI2ZTVlN2I2ZSBHZW1pbmkgMy4wIFBybyBmaXhlcyB0byBMb2cxNSBhbmQgY29tbW9uCgpaOlxW
aXRlXEJyYW5jaFxEZXZlbG9wXERlbHBoaT4KCihJbiBteSBjYXNlIHRoZSBkcml2ZSBsZXR0ZXJz
IHdoZXJlIFU6IGFuZCBYOiBidXQgSSBjaGFuZ2VkIGl0IGluIHRoaXMgZXhhbXBsZSB0byBYIGFu
ZCBaKQoKR29vZGJ5ZSwKwqAgZm9yIG5vdywKwqAgwqAgU2t5YnVjayBGbHlpbmcgIQ==
