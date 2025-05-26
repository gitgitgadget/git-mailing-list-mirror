Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011027.outbound.protection.outlook.com [52.103.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC843AA9
	for <git@vger.kernel.org>; Mon, 26 May 2025 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748230703; cv=fail; b=gb3SK8LtViLOM2BcwiuKFcuToLFXhSBRbXn0vH5JCbLKsbs18tPB7Hy5Sb/mXEgLTnCCl0xWr2g4RqMXCFLI1Rn72VID4SbLMm3C5BCMALCdy+S1lkp1F+/STplLtVUy2adZx8MH6Q3AQKzmOGSSYuB6NTmOKDHAoeo5/CmvNec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748230703; c=relaxed/simple;
	bh=CqkrAMI9PTIaatGoraGKi0Za8VGkVnHCN7NZeS1pvws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnW5VLEZl+NSA8UCQELC3004vdXj5KZs6jZDSkWyO1uTJc0FgY8ddTu87lneiaAygFfd1j+09FKwGXcsmzUc1cjT1eqDVa/5a2UWJQUPhT99F1kbvp3Z09k46RLAksyjf5Z9iT+W+DNchBVeJSS47bZBYMtVa2SU4wg+KEcxCxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kyxNxlCo; arc=fail smtp.client-ip=52.103.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kyxNxlCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exm46PxTlv8IB6XjZE9G5G4IXcM67m7VvlI8RCdYWMA1pf+gL9WgS2W1njQxC19qlyK7LoJ/lME/e3ShoBz52KuXKULO83vdhFmIwuOyFdWi0GJ7VgAsfDzDyeh+YaeIMzh7WagZBNfCMDff3GknNQg983H3lMqwaNAmf6Un9xLaIxuGxo6a1+qbE8BPbw3xmDA/F1opgItsCiGKl6GVrJILEtNGmx4tANkeuvMxS/tZ0Lp7/KWamO+cyNOGgvjsMpt6EIQd1mwITOEc0gBBcTfhV+iusDVP6DgF1Yc+FIBGZr+JMFZcMePCab5/m0t6YXPUO45OLg3Qgs4R0zPLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqkrAMI9PTIaatGoraGKi0Za8VGkVnHCN7NZeS1pvws=;
 b=D3nkW43PB1End7oiKm03YmK4q5O+020YC4hL8BdqNjbaaSrT3pCvA1vOVywJIpgtr0dIyFCLDNsEwphJZk/4naWpobtzWtxGlpgBMwKb2No/VLWy3WTgCQDTd0HBItDmx55YlcowAdCLOm6WhKGlaM9PZvEvPsEzEzdVhJA7whRregJpfue0HdowBqCJDL0gqrghEJMYpoUVV6zikyNaElytOsvVLAfRqinPBWoNCRxAfcAdwUgNcgktiU0Nvt6ReAqxuKQV6tsR6wS/MLxlJ7ujnZ8JUf6RkgiG9EvSLVLfs+xR6QKEbpgVVvqSI6xGdRYe61dxbOQyvVvwqSSuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqkrAMI9PTIaatGoraGKi0Za8VGkVnHCN7NZeS1pvws=;
 b=kyxNxlCoVvJtXJirnuuEXVpXOK3HTw9jgBwW2CVdlZ2bpHuwyVi2BOSo+bRj+Q4eVDctNF+NU0pca7+x28F67MpWKPkqeAUcg0NpjeUlHtlEvfMnMht6tRO7F/E7Sl7gXWa+U0m7HQTlY/njNWHY2jeCTwzyVG91BCCh8PVx9psiXsvFIzrnBhNyJolQCaBj6sDdSErVLTOUM49s5+Nx0f1sKZ/J0vkDzGEjweqZqYhX7SY2LxsnHiWeF65W2rd+D7XPLbt9VSFW++VBjXqVVinxwlZEk4yPAMemIw5+oPzz3pzwFh4GbVSD8gH6fVm7oXHXwjHoZawdBziJcP4xkg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAXPR01MB4182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 03:38:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 03:38:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>, Julian
 Swagemakers <julian@swagemakers.org>, Jeff King <peff@peff.net>, Zi Yao
	<ziyao@disroot.org>, Rens Oliemans <hallo@rensoliemans.nl>, Drew DeVault
	<drew@ddevault.org>
Subject: Re: [PATCH RFC] send-mail: add support for Microsoft Graph API
Thread-Topic: [PATCH RFC] send-mail: add support for Microsoft Graph API
Thread-Index: AQHbzWUSqVJsjYz9NU+BJwLg9+xtcrPjy1+AgAB5Dac=
Date: Mon, 26 May 2025 03:38:13 +0000
Message-ID:
 <PN3PR01MB959731DDE3E22C88211A84C2B865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <20250525110621.64308-1-gargaditya08@live.com>
 <aDN8mYEJS0ARD1d7@tapette.crustytoothpaste.net>
In-Reply-To: <aDN8mYEJS0ARD1d7@tapette.crustytoothpaste.net>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAXPR01MB4182:EE_
x-ms-office365-filtering-correlation-id: bdbddee9-8847-4acd-8436-08dd9c06be73
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|6072599003|8062599006|8060799009|7092599006|41001999006|19110799006|15080799009|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0xRZ0RvQUhLd1ZDcnVRaDEzRVo5NXBSVGRnNXV4b0luUVdJZU9lR1RSbEpa?=
 =?utf-8?B?OXNZZWNub0JVV1lOSGlwZ2pmU214K3REaU11YUoyelBRWkhCVVJwaTVSWnB0?=
 =?utf-8?B?K09BT2FLVTk2dWNuc2dXUGgrMlp3dHBrYUE2S295cEdPMUVrUElvVytkVTdL?=
 =?utf-8?B?aXNjTEtEaGpDb09PckJqYlJGM2tCbHk3dWZvMEJ6c1pzeFJvcC83dEJ4dWRY?=
 =?utf-8?B?YlBFcEhqaGdkTmNOUDc5dFZxRDJyVDFwZWhSOWdMMmQ4eHBYWTY5ZHpBNXZO?=
 =?utf-8?B?SUl0UmkyMTlMUVd6aVUyb29hYXpQem5Nb2F5K1hMdC8zK3BISXhOUW12aGVi?=
 =?utf-8?B?NlNGTEcyOGVjS3lTVXdSZkcvRlliM0lSOFcxWUtkR2ZJd0QyWWo3dE9QSVlB?=
 =?utf-8?B?b3hyd0wzMFRIM29LWE9TcUx0WlRlMGlsVzhEUHc1Tks2d1YrYmJkUXpPTVNa?=
 =?utf-8?B?OWlsRFpPaFF4UHAxaEEzKzAySkh5d01iaGxPbXU5Wlc1dVg4T3hIdEExVy8w?=
 =?utf-8?B?L1FBRHBoYzJtWW12VlFWd3NZM0U3U2RFTFVZbmJGcDVocGRSMUtaNkpYNlJD?=
 =?utf-8?B?SDNBUDMzYnJRS3FVSmZobFl0L3hrRnNXUnJZM0RJRFhHQVlLVUVpK1lzWDBD?=
 =?utf-8?B?VmVJZjNzRUN5RzZBMitpUGhxanZEaEh3cjJZZy9hMFJ6ZzZXSW03MktGYVpi?=
 =?utf-8?B?WXNjdXRLZnhvZ2VBc0VnYUdNalBWMmxwdmp4dFFkRjc3K0xoTlU4M0d0anBo?=
 =?utf-8?B?NjFNWXM4eE1heGo2N25vMjVsV3R6QlhzamZLNzZ3dVhQaGMrU1ZnMUcrME1G?=
 =?utf-8?B?S0lObkMzTjhLaGdtVzFKSDNUSi9UWVpNT3ppZG0zVVlCbVRMT296MTVPZ2RP?=
 =?utf-8?B?VWgvVGlYd3VtZHNMTlFiOHVXb2JVOWRTMW9iUGVXN2lLSGJZbVQyU2gwbzkv?=
 =?utf-8?B?WlRLVW9pODBsclE3SU1hdVJObVBQOGxTZEI2cEFUblpzdUlWcnhsRUlQMGtB?=
 =?utf-8?B?dEFFOGhjTHJhaGlTVm9TdSs4QjRXTFF2cTh3WW1lWTJESWtSVVBKL0FMdmNT?=
 =?utf-8?B?ckcweWpzNlNXYm9iNFhtUzBnbERCTnkrdmw4L0x1K045T1dCNG5jK3JEU0tj?=
 =?utf-8?B?eHZIMWpkRUlGUlBoM2pObkp6RGFQRHV1OC9mOUNJczVIZEpIemFlbUszK2VB?=
 =?utf-8?B?NnpVdWJOSy9QdTVBOHdKU1FZSFViczhORjlYd0F3ZWVxSFE1SENUTGZXYTBw?=
 =?utf-8?B?QStxaWNHcHF3ckNuTkRrMzR1UGxBYkVjd0IwT2FYakRXaVh2OGV4SVRydmU4?=
 =?utf-8?B?aDRFWGljREVWYXNrMFBDTUtRSnJGbHh2Zm9KSFNLTkNwMnRmR215UzJLL0Mz?=
 =?utf-8?B?cWttU051dUJrKzdWdXV6Z25ub09QajAwUGZBWjlxRTQxR01talIwSGZVTXdZ?=
 =?utf-8?B?TmM3VVNMdkEvNVVlRGE4bUJ3ZVRzTjBaSzNSRktKbkRCbUVBK0tCd0Yyb1E5?=
 =?utf-8?B?YUc5akd1YUJrcmJjYTBVOFowL25jUk9kWTY4QTV6a1JlcW9oY2E5cGdWUkVR?=
 =?utf-8?Q?/YgYnO8OCGdqPWeJ+QDA+WraY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWREVkUzb283Z1B1RDI4L1h5U0lTODFhaUZnSy9xU1hodUJLUVNsdkRTeU9a?=
 =?utf-8?B?a3RxTjhDbkpSTnNTSmY4Q3A0NGpVVFNoaFVQeDkvVzMrQTV4R1lwRTBTcGRN?=
 =?utf-8?B?L2NSMThxWXRaSGoyQzZtR3c2WEdqejJobU16R2ZaMDY2bXhIOWJmN3UvZEtY?=
 =?utf-8?B?WSsvbWhnVHl0QytaWUdra0I0MHFPRTRvc3ZvaUVSN0pxQ2U0Sjlxb2Y5N1ph?=
 =?utf-8?B?Sk5ETnU5RXAyQm9NeFpJRFozbC9MczJZM0RDY05TblZJM2piSlg5Yk1OMWVW?=
 =?utf-8?B?UWhCQTRHdFpGOFNYUWlwSjk3OTVXUjYvcXBvY0s1YS9NcWxITHlEcTZLb2o4?=
 =?utf-8?B?clI4OW9WZ3dpUzQ4MjZtKzBUVml4UkZnbzlMd1hlaFU1OUhLWGJuNysxVWFH?=
 =?utf-8?B?aS8vK0pTNjg3bEZTQml5ZFgwSXZrY0Y3VkxWZHROTmdpQXkzVUdqMWpQZ0RL?=
 =?utf-8?B?OFlmUjR1eURWYmpWcTdVL3dkVU1OSGY2RWpSOUR6N0xOOTgrOWRxU1FzVUI4?=
 =?utf-8?B?SlJUS0JDcFZiRFFLcUhyNEJ5R2RmanY0aTFSNkhSdXd2WkRhRVA5bmtXc1RT?=
 =?utf-8?B?ZE43UFRpVU9qeTNjT2hXZnA2Szhya21hL21INnBDMmwyUjErV0Ixd2N2SXU0?=
 =?utf-8?B?ZVdTMjd0aUZla1ZvR2s5V0cxSjFHclRBWHNnMm1NVWkxNG90OWhlckNQalo2?=
 =?utf-8?B?WmpGa1hzOThrc3Y0NkR5VlcvWTJyWThVVnNIZnExb3N4Y0l5ckNwTDV3SFFS?=
 =?utf-8?B?dW9xZ1hJd3lXcEo3MEtaalJ0QXNNNVNIcFJ5SDZ1RmNwSUxIVWpLakFFL2lW?=
 =?utf-8?B?eUV0enU0am9Ha1ltWjdLNVBUb29maW82VHRoV1JoOWFuSm1UN09lMzdvUmww?=
 =?utf-8?B?UU9mcTUrbjV4VkR2UDdPQi9HVGE4eW1EYjV0L1F1SGxELzhDSGYyejZLT1RW?=
 =?utf-8?B?ajFwK0xpY2gwUWk1WUl5R2JPNjlzZ0l6eE84RHlpSFJCRGw4V2RETVNlaHk1?=
 =?utf-8?B?WkxMTzJQMGpNVkRhVzlmU0h0RWxyMHoyYU5mVjRFQzJ5UG1vK0Rxb1lIVk1I?=
 =?utf-8?B?WVpYV3RpNkZLemg1VzNqVEV2dTMzSVBiYUhxUjZVUjhyekQzclZ3Q0NiTnEz?=
 =?utf-8?B?ZXBuRi8wbVI3R2pwUTNURzFGRHRuWS9IT1FGQ2JMWWFFTnFQekdOREJXbFd2?=
 =?utf-8?B?eSt2RFBlWmY1eC8yb0ZtVVM4eUFJZ3ZLTHNpTlFnZGVSWE5UTk0zQVBETUlD?=
 =?utf-8?B?emRCaERIK3MvL2lFQUlJeGNKVWdnNWhod0IrWDRNNEQzQzJnUE5Pd28yOVBG?=
 =?utf-8?B?ZGl3UTZUNE5TU0R6UHRPZ3B3eGlGbHdBdFY2dXZka1Z4NHdvTEN4VkNpWkVs?=
 =?utf-8?B?amlwd213MXp1R2Vka3RJT0JLNHMvOEYrbkJIcEJDYWRxRmh2b2hySkZ2bW1Y?=
 =?utf-8?B?c1VJQWgxSWpQMjRCZG9TQW9sSWR2ZzdJWkQvdXE0MG55WVV6T3l1V1RtdUl0?=
 =?utf-8?B?SzlnWStjT0tTYUdiczRZd0lOQS9wQVNrUTFhRnVBU0t3MFY1dW41WXBkQ3J3?=
 =?utf-8?B?Y1BHL3NpcU42ZzF1ZmtsYm1pVGZQRXpLcllOdlRVWVhVQ3JDeGtSamFPVE9Y?=
 =?utf-8?Q?XLz1bVVoiRahD1024ETwN8cHYuOBPKdMkk1IZAmQPMUY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbddee9-8847-4acd-8436-08dd9c06be73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 03:38:13.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4182

DQoNCj4gT24gMjYgTWF5IDIwMjUsIGF0IDE6NTXigK9BTSwgYnJpYW4gbS4gY2FybHNvbiA8c2Fu
ZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3JvdGU6DQo+IA0KPiDvu79PbiAyMDI1LTA1LTI1
IGF0IDExOjA2OjMyLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IEFwYXJ0IGZyb20gU01UUCwgTWlj
cm9zb2Z0IGFsc28gcHJvdmlkZXMgYSBSRVNUIEFQSSwgYnJhbmRlZCBhcw0KPj4gTWljcm9zb2Z0
IEdyYXBoIGZvciBzZW5kaW5nIG1haWxzLiBVcG9uIHRlc3RpbmcgYSBiaXQsIEkgaGF2ZQ0KPj4g
Zm91bmQgYSBmZXcgYmVuZWZpdHMgb3ZlciBTTVRQLiBGaXJzdGx5LCBTTVRQIHNlcnZlcnMgb2Yg
TWljcm9zb2Z0DQo+PiBhcmUga2luZGEgc2xvdy4gT24gYW4gYXZlcmFnZSwgaW5pdGlhbGlzaW5n
IHRoZSBTTVRQIHNlcnZlciBldmVuDQo+PiBvbiBhIGZhc3QgaW50ZXJuZXQgY29ubmVjdGlvbiB0
YWtlcyBhcm91bmQgOC0xMCBzZWNvbmRzIHdpdGgNCj4+IHNlbmQtZW1haWwuIE9uY2UgaW5pdGlh
bGlzZWQsIHN1YnNlcXVlbnQgbWVzc2FnZXMgc29tZXRpbWVzIGFsc28NCj4+IGZhY2UgZGVsYXlz
LCB0YWtpbmcgYXJvdW5kIDMtNSBzZWNvbmRzIHBlciBtZXNzYWdlLCBhbmQgb3RoZXINCj4+IHRp
bWVzIHRoZXkgYXJlIHNlbnQgYWxtb3N0IGluc3RhbnRhbmVvdXNseS4gU2Vjb25kbHksIHRoZWly
IFNNVFANCj4+IHNlcnZlciBkb2VzIG5vdCByZXNwZWN0IHRoZSBNZXNzYWdlLUlEIHNwZWNpZmll
ZCBieSB0aGUgdXNlciBhbmQNCj4+IHJlcGxhY2VzIGl0IHdpdGggdGhlaXIgb3duIGdlbmVyYXRl
ZCBzdHJpbmcuDQo+PiANCj4+IE1pY3Jvc29mdCBHcmFwaCBBUEkgc29sdmVzIGJvdGggdGhlc2Ug
cHJvYmxlbXMuIEl0IGlzIGV4dHJlbWVseQ0KPj4gZmFzdCwgdGFraW5nIGFyb3VuZCAxIHNlY29u
ZCB0byBzZW5kIGEgc2VyaWVzIG9mIDUgcGF0Y2hlcywgYW5kDQo+PiBhbHNvIHJlc3BlY3RzIHRo
ZSBNZXNzYWdlLUlEIHNwZWNpZmllZCBieSB0aGUgdXNlci4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsg
d2Ugc2hvdWxkIGJlIGFkZGluZyBzdXBwb3J0IGZvciBwcm9wcmlldGFyeSBtZXRob2RzIG9mDQo+
IHNlbmRpbmcgbWFpbC4gIFRoZXJlIGFyZSB0d28gc3RhbmRhcmQgbWV0aG9kcywgd2hpY2ggYXJl
IFNNVFAgYW5kIHRoZQ0KPiBzZW5kbWFpbCBiaW5hcnksIHRoYXQgYXJlIHdlbGwga25vd24sIHdl
bGwgdW5kZXJzdG9vZCwgYW5kIHdpZGVseQ0KPiBkZXBsb3llZC4NCj4gDQo+IEl0IGlzIHdlbGwg
a25vd24gdGhhdCBNaWNyb3NvZnQgaGFzIGludmVudGVkIGEgbG90IG9mIHByb3ByaWV0YXJ5DQo+
IE91dGxvb2stc3BlY2lmaWMgZm9ybWF0cyBmb3IgbWVzc2FnZXMsIHN1Y2ggYXMgVE5FRiBhbmQg
TUFQSSwgd2hpY2ggd2UNCj4gc2hvdWxkIGFsc28gbm90IHN1cHBvcnQgYmVjYXVzZSB0aGV5IGFy
ZSBwb29ybHkgZGVmaW5lZCBhbmQgbm90DQo+IHNwZWNpZmllZCBpbiBhbiBvcGVuIHN0YW5kYXJk
LiAgSSB3b3VsZCBhbHNvIGJlIG9wcG9zZWQgdG8gc2VuZGluZyBtYWlsDQo+IGluIGZvcm1hdHMg
b3IgdXNpbmcgbWV0aG9kcyB0aGF0IGFyZSBwcm9wcmlldGFyeSB0byBHb29nbGUsIEFtYXpvbiwg
b3INCj4gYW55IG90aGVyIHByb3ZpZGVyLCBzaW5jZSB3ZSBhbHJlYWR5IGhhdmUgY2xlYXIgc3Bl
Y2lmaWNhdGlvbnMgb24gaG93DQo+IG1haWwgaXMgdG8gYmUgc2VudCB0aGF0IHByZWNlZGUgdGhp
cyBwcm9qZWN0J3MgZXhpc3RlbmNlIGJ5IHNvbWUgdGltZS4NCj4gDQo+IEkgdW5kZXJzdGFuZCB0
aGF0IHRoZSBPdXRsb29rIHNlcnZlcnMgbWF5IGJlIHNsb3cgYW5kIGluZWZmaWNpZW50IGFzDQo+
IHdlbGwgYXMgbW9kaWZ5IHRoZSBNZXNzYWdlLUlELCBidXQgdGhhdCdzIHVsdGltYXRlbHkgYSBw
cm9ibGVtIHlvdSBuZWVkDQo+IHRvIGFkZHJlc3Mgd2l0aCB0aGVtIGFuZCBnZXQgdGhlbSB0byBm
aXguICBJIHNob3VsZCBub3RlIHRoYXQgSSBkb24ndA0KPiBoYXZlIHRoYXQgcHJvYmxlbTogSSBy
dW4gbXkgb3duIFBvc3RmaXggYW5kIERvdmVjb3Qgc2VydmVycyB3aGljaCBhcmUNCj4gdmVyeSBz
cGVlZHksIGFuZCBJIGZlZWwgY29uZmlkZW50IGFueSBvdGhlciBwcm92aWRlciBjb3VsZCBkbyBz
byBhcw0KPiB3ZWxsLiAgSSBhbHNvIGhhdmUgbmV2ZXIgaGFkIHRoYXQgcHJvYmxlbSBzZW5kaW5n
IG1haWwgdGhyb3VnaCBHb29nbGUncw0KPiBTTVRQIHNlcnZlciBhdCB3b3JrLg0KPiANCj4gSWYg
dGhpcyBSRVNUIEFQSSBhcHByb2FjaCBpcyB3ZWxsIGRlZmluZWQgYnkgYW4gUkZDIG9yIHNvbWUg
b3RoZXIgb3Blbg0KPiBzcGVjaWZpY2F0aW9uIHByb2Nlc3MgdGhhdCB0aGUgcHVibGljIGNhbiBw
YXJ0aWNpcGF0ZSBpbiBhbmQgZGVwbG95ZWQNCj4gYW1vbmcgYSBsYXJnZSBudW1iZXIgb2YgcHJv
dmlkZXJzLCBpbmNsdWRpbmcgc2V2ZXJhbCBvcGVuIHNvdXJjZQ0KPiBpbXBsZW1lbnRhdGlvbnMs
IHRoZW4gd2UgbWlnaHQgY29uc2lkZXIgYWRvcHRpbmcgaXQuDQoNCkZhaXIsIEkgd2FzIHRoaW5r
aW5nIHByb3ByaWV0YXJ5IHByb3RvY29scyBtaWdodCBub3QgYmUgYWNjZXB0ZWQgdXBzdHJlYW0u
DQpJIHRoaW5rIGl0cyBiZXN0IHRvIHVzZSBhbiBTTVRQIGJyaWRnZSwgb3IgdXNlIHRoZSBzZW5k
bWFpbC1jbWQgbGlrZQ0KY2FwYWJpbGl0aWVzIG9mIHNlbmQtZW1haWwu
