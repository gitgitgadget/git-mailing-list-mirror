Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19124211460
	for <git@vger.kernel.org>; Sat, 31 May 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748682407; cv=fail; b=mfxGWS1lNR1+kzqqfMkQTs1hG9BwHcwBVwe5MENvKaOPDuMm5MK19RPBPe1Ze1Si6c7YvJgnW5aN73KSaaS54Uw69HcHEpRR4915+K3cZ/2g2GexcccKHyNXUnFzFjUpenkPHkRnHDEFs+0Y3V1U26sibqxh2EOv65uP84Vkx8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748682407; c=relaxed/simple;
	bh=4BLY4+w16CM6NEZhPzwEmHFigKzaqd+wkycNwFun4gs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtkoFw9cg1AJVgorrd/qX3sDRxROI8Nwpf9lI5I6EnIJAeGZfAayUvYPEGtK9aG1TpV0wRpzh3dO5z4ykKCWYDeC53ht7LLA/QDgeYmcXVEA9R/iUMpE7S0Y9EE37LQxeWsLL4COMtRTcUbg41NSyeF/QWGOdDE+aMhvpVR8seY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bdF6kq8V; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bdF6kq8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etiphU06z6mvmT2W8KRyEt8kUiFG3lhBuUO5LFIvQVUCA1H8raz+JwzF4XSqTNZYumwDiQ2ydRqwJIenx6P1paedklFLDtKRaxUjZ3Co123RahzwfxA9cfrk0PbCqceidR89+Kxwld8APA+q//x4TKPcxBi7XH0f4dxI9rgXtizKf53Ad9+wqYTMoQR69+KvY3Tymx0o1zr2XtpMW07I+a8bvcoKcwdC1+7e/pnd35lPxFd+lawm8VR4Vetc2kI3tnoID3EgQPaH+BrlubZcT2wjCYoN/x9zVcAUfHKI3tPmx1Q0G6Y+KShdhOq3yR21wQpdw1kgw3Dq7nM7Gg1hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BLY4+w16CM6NEZhPzwEmHFigKzaqd+wkycNwFun4gs=;
 b=OGKL3vh8/oIwWH8y3pgJl5ltyFRhR1fcySCR6ILyyqoU4xh1U57VAXTY7KdAAP4zZzBcMryfffylQYa8zbjrghit43GWt3a7DIBiXB6L4V/1Wv7gPea7xMjFMgPnC/OWb0yAb5xi4k52k8PDaIjIiOYz/DRB+9NHloJjIHTXIiaX/6v6Kl/02XKN2ItgrjFinYpsCAgAThmte8jSSZTfqzifQ4ib+X7Cn7wfjTzGC1WNK9g3VZhzkjphjXnSgg8LnBDmY9wsWB0R9YGayxI1grCLmuLL1H2vzcM9g+fOhhYXFDJCrRBnnflzLd+siSmFkaFQYhiyTU5z/5tNgcUPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BLY4+w16CM6NEZhPzwEmHFigKzaqd+wkycNwFun4gs=;
 b=bdF6kq8VVM36R/kSHJFxwd3ZqBWhHaMSaACqnW1Iw1uoGBTp/ff/X7n27WR1ul6paPLVlrwRBrfQxoGTXfRXGTV2UoJGFt269sk6saOsaWwev0bgsJpT3qSVHkQJ5GUt/bdm8n/DK2aVvQI8Nmtnb7ehEdzLAxDimqULEt1mWOyCYapa3naTLn9Hz75tW7981ApNKBYuQHgZ6rYXpmi8q0eSr9fPRSVhhUrZ4AJYjEQmZbPOltyE2PoyLALhB6TfdhDX64YJ+5AUD2L9xSdfulkkcztEYS/Zqv4oeqTeoFmUOj+I/Lnv5arMxhquxHuGohQgsuUrVLm1lcwbxG5wWQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAYPR01MB10555.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sat, 31 May
 2025 09:06:39 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Sat, 31 May 2025
 09:06:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 2/9] imap-send: add support for OAuth2.0 authentication
Thread-Topic: [PATCH v9 2/9] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb0YjaOtyos1IoHkCDzCMoVBcae7PrpiCAgAAF05SAAMecqw==
Date: Sat, 31 May 2025 09:06:39 +0000
Message-ID:
 <PN3PR01MB95972787839A31A0152A16ABB860A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD09F7A450C6CA26B421B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<CAPig+cSFLF9de3i7RsG6j4wSGkRRhGgOGOovoFXm9U2+t=qC+g@mail.gmail.com>
 <xmqqfrglerbx.fsf@gitster.g>
In-Reply-To: <xmqqfrglerbx.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAYPR01MB10555:EE_
x-ms-office365-filtering-correlation-id: 6af34ce5-52c8-4430-bc0b-08dda022741e
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|8060799009|7092599006|19110799006|15080799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHZYaWtYN2NzTUpwRTVtb1JEVnlmYjNqZkNzMVRjS1RVL05MK0tWWTVtYmdI?=
 =?utf-8?B?VVBiYlI0Wk5NakwzNTJiSjh2cVBKdU11d002bVI5WFI5YWJ5SStsa1crTEVP?=
 =?utf-8?B?UEp4eTE3MDZFN3ZWSlhLa053SHdPSmxBVVUxUGlGOEZyUjRWTlpYdmRqTnV6?=
 =?utf-8?B?S3E2anlyRVV2d1Z3SkNIWXQ1SXNVTmdJSmpGcWlqUnZTcXJ4MWlOMlh3V1I1?=
 =?utf-8?B?STBRTU85NzBYaWdkNGE3N09ma3pWRmdTRitLM2ZiVmlJNVp2ODNxbENsQ0Vu?=
 =?utf-8?B?ZUtnbnh2SC9CbTdqNG1heWdvRVVyRUhHcTRkbG96WElKNjBoODRPNXByNXBC?=
 =?utf-8?B?UWx5TGMxK2tGdVZ6Q3drZ0Z6d1k4UGM1anhiWUU3Uk96VkFDdUVKd1pQTUUw?=
 =?utf-8?B?emxiTWdPc2JRbVowYit6MlYzRWRZV0hidUk1OCs0Z1lDVXBtRHRqellPSjhu?=
 =?utf-8?B?K2llSUdFMVdoeFMyYXUrNE9URkt1Y0d1TzBLSnRxbTdEdlZpMFpLaWlyVGZk?=
 =?utf-8?B?MXcyUUpIMHgxb3hSWUdQaVlnaHhzNEhBSGpyckZCL2JiVlFMZHQvYXROUFJl?=
 =?utf-8?B?SUIwb3NPNWdXV1A1dHdmLzVyb0E1d1BoNC9aempyZTREaWpjMVVrenYxL1Vv?=
 =?utf-8?B?TTdya2lhb1NwY0ZkSkNYY1kxV3pHa2RTWUlmeEwyWDVTcXB1NlBYRkwxUENM?=
 =?utf-8?B?WU5HU1d1bXEvUE0yMFlqQlBIK1hEVmZpMEMxTHc4QzRVQVhiazYzQVlyVUdq?=
 =?utf-8?B?SUlhYmN4WW1oQml2SW5Db0xOaVl4RzRHa2tFdVdwc2RHRTRZR3piWksyMlBE?=
 =?utf-8?B?dnFGM1JHaEQ0czJ5SGd1N0piR2h2ZmxYTXhVNUFXRDJDR1Y4VVhqQVBoTjVk?=
 =?utf-8?B?eTF6K2ZzR2hHemptMEY4MzV4YmNlOHRseDU5WEF3Q2ZwOVdNeFNOdlZYYVdm?=
 =?utf-8?B?Y2M1YkdSYlVnK0l0VkJVajJ2S3pxam9oWVVXRmR0UU81cmVOUTg0NzFYMllK?=
 =?utf-8?B?eGVLUWNBUXJZeENIVFZLTlZhdWsyclZlTWdXKzE5MHFrYnBDSnNkL2JGSysz?=
 =?utf-8?B?Z2xHOGlpeWVmWisvWU5EdXFSb1lvVmtVTk85SUlmQXI4aitldGdCbU1CUWpi?=
 =?utf-8?B?NVFCQnorY3NVRWVqSGlaTFZ0VHNwK1hjYXQrUDlQckhFdVJ2K2dQaVFyM1I0?=
 =?utf-8?B?MUxDQnNla2UxK0plWTJNRWlLcmJkcXRxWWd2cGRDZ0xvcElHeENNc3BNN2xX?=
 =?utf-8?B?ZkJHejl6RXFiSE8wS08rM3N2RXArOHF3MzlXbGFuT3FvZmp2Rk5xbGcxaEhB?=
 =?utf-8?B?QS8xaGxGZEROd0ExZEZvT3dKMHNpOTl4akpPb0oyWUk2UTB6QldrR1JPcmEv?=
 =?utf-8?B?ci9VRjVZcnFYNE9jcFdINVZTTWxDcVIwOUM1SG93VFhSeWh6Zmk4R2F6SXNY?=
 =?utf-8?B?Qm5CeDhHTVFVS1k2YnNlcHhQTHhoUGcvRm0vaiszNGRLQ0NZcmVMY2l4SGVW?=
 =?utf-8?B?bHdPbHdTdUlSSm81MVdWdFRha1ZyMzRWcHNCcmp6UnA0SjFrNi9jbjdxaGNF?=
 =?utf-8?B?SG5DZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2ZCTjFXSGtldWM5cGVSRGI1NVNsSzI1YlNWbit1dHgwOHhnRzFpb2IzaVYy?=
 =?utf-8?B?WEtMb1dtL0pXQTRnbFU3ZXhJeXU5TTVIa2dJUFlzcDAwcEJ3RFV2azlmZk9K?=
 =?utf-8?B?cGQ2cGx3WTJYekprSEp4K1hOVUw3dVhDUCtHeStNelhGSG1heUpTNm1ZZ0dG?=
 =?utf-8?B?N0kwbHNUaEtXY0NxNnlJazIyK1d5UFhLYUlHUG9mU0J3QU1FeXJpTWNEWlc0?=
 =?utf-8?B?QnhvUllJR05Zc2RNby9lMXNCOVJEQVBjYllPSWNwRFJjZ09ZTUN2VjZxcWNT?=
 =?utf-8?B?T3ZaMXJObkovUkx3S096UkNMbnIxQVA2eGduZ0QzUENHNmJzWkczMlBnSldV?=
 =?utf-8?B?RDhOV0cvNUpVR3BKWnd1RzdTczFXV1lIZ1dPZ0JVbGt0WDZGeGZFY2xIOTBD?=
 =?utf-8?B?WUxDb2k1ZWZXdWx6OEd6c29qVFY1Y1J1MU1wUGFCSlJaVVFqOHBvdXY4V0Qy?=
 =?utf-8?B?dTJhd0FQekpWekNuNmlRYW1CVzU5ODVwM1cwczZTQ3krVVZWeWh2N1dVYnNO?=
 =?utf-8?B?UEFVY3NnY09VcEdiMnkrY2hIcFFCbm1FYldBVUVxR3p0T3FyNjY0cDVwU2xI?=
 =?utf-8?B?YkNoOVJyZXU0TjlpUWNWajN3bFVvL1J0NHVSWWxBdGpwaWZSN3FrcEpCa0Nm?=
 =?utf-8?B?NHplelQ4OVI1cThLM0luS1RWZ0E0Vjd6YVVCaGN2aWlwWGFVVmdWQi9wM3dn?=
 =?utf-8?B?VXJ5RXczSkNobngwcGJ3TzZvaTBkV1ZoUkhUNUYxYldjUmk5SWF6TDl5SXg1?=
 =?utf-8?B?UWdyTXord2RPV1NjeU9DUlJpTUVYNVJzRWpQbXZqd2U5Wm1ick5TSjYxRTdH?=
 =?utf-8?B?d21rYTR1bkpqUHhiZ1JRTG9rdEx6TFZPVzhPWE8yQzg3TDduSmpBUUdCbWpH?=
 =?utf-8?B?cFEzYVlsZERMQ3had2VUWEhKeTJieXN1dXdhdHhrVTNUaC9UbXUwMkNuRFc1?=
 =?utf-8?B?Qk15c25pZTRYY1hyTEtjNmJDcHhyMEsrT2RQK0VNSVUreU1STW9sUWltaGE1?=
 =?utf-8?B?bnoxZmJISkgyYUxRQS9hVzdacUM2SHZsV1ZyZVVFWjhwellnTi9VamdmdmZL?=
 =?utf-8?B?OEZIamJqaFpqQzk5QVZwbjd0dE9FL3QwTHFWdlVjSUtoNDAvVGJPbW0rbmFT?=
 =?utf-8?B?emdXRDladFdUUzlhZmphOTVxYzhvZzlKbWdYZHREWkx6N0I0dnVKUHgrdzBF?=
 =?utf-8?B?eGJUdDRKbEJnUUxoSGR2YTQ2Vmg1aDhsaDRHcldaaEM0WWJNOEFTVVhKMzly?=
 =?utf-8?B?cU1ETlByTnIzcWRVcWZRSVV6dVRCbE1YMVBld0czT3h2ME9ncng1d0dwRmgx?=
 =?utf-8?B?WGpBaS8xdzY5K0h2M0lXdDZJTVpCYVNVVUg0WEJNekpERzIrWkVUMnJyZjV4?=
 =?utf-8?B?TlAzUFVsZTZ3RHU4anVOcDg0Nm1ueGdKZVo2RTVWY3ZHcEZidGY2ejhGTFZG?=
 =?utf-8?B?aUU4NEZEeGh2OVJCV2xGVkV3RmZWbmcwVDVNKzEzS1k1Y0FGUFAyU2dhZW9y?=
 =?utf-8?B?cFhXU3pCWUh0eFRTVDhEeW9CQ0EySURRNXJjQjB6Vm1DZzg5L3BjUFIvMk10?=
 =?utf-8?B?bk14eklkenBadTcxTDZnOS8wTHpjY2FPN1o4b1hCWFpoWnRtV3JjZlNuUW45?=
 =?utf-8?B?OEpxRVVRbERubWJ5N0JPbndjSWI4NEp3MVpkNUlhd2Y0Y3RqZEtJcTRaTmdn?=
 =?utf-8?B?Q3ZGeWtaOTdDNmhTM3lpUVo1WnU5dnlFNlhjclZ3VjFMeFJ2TUdWOWEyL3RJ?=
 =?utf-8?Q?4GZZFcrHWsqDjCXThU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af34ce5-52c8-4430-bc0b-08dda022741e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 09:06:39.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10555

DQoNCj4gT24gMzEgTWF5IDIwMjUsIGF0IDI6NDLigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0VyaWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1
bnNoaW5lY28uY29tPiB3cml0ZXM6DQo+IA0KPj4gTm90IGEgcHJvcGVyIHJldmlldywganVzdCBz
b21ldGhpbmcgSSBzcG90dGVkIHNldmVyYWwgdmVyc2lvbnMgYmFjaw0KPj4gYnV0IGFzc3VtZWQg
dGhhdCBzb21lb25lIGVsc2UgLS0gcHJvdmlkaW5nIGEgcHJvcGVyIHJldmlldyAtLSB3b3VsZA0K
Pj4gbWVudGlvbi4uLg0KPiANCj4gSSBzdXNwZWN0IHRoYXQgd2Ugd2VyZW4ndCByZWFkeSB0byBw
cmlmdmlkZSAiYSBwcm9wZXIgcmV2aWV3IiB5ZXQgb24NCj4gdGhpcyBzZXJpZXMgYXQgdGhlIGNv
ZGluZyBzdHlsZSBsZXZlbCwgd2hpbGUgdGhlIGRlc2lnbiBhdCBhIGJpdA0KPiBoaWdoZXIgbGV2
ZWwsIGxpa2UgInNob3VsZCBjaG9pY2Ugb2Ygb3BlbnNzbC9jdXJsIGJlIHJ1bnRpbWU/Iiwgd2Fz
DQo+IGRpc2N1c3NlZC4NCg0KSSB0aGluayB0aGF0IGhhcyBiZWVuIG1hZGUgY2xlYXIuIEp1c3Qg
bGVhdmUgaXQgYXMgaXQgaXMgcmlnaHQgbm93IGFuZA0KZHJvcCB0aGUgcGF0Y2ggYWxsb3dpbmcg
dXNlciB0byBzZXQgaXQgdXNpbmcgdGhlIGNvbmZpZy4NCg==
