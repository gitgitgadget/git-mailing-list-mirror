Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2C27FB08
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553803; cv=fail; b=K0SIufwlUbJds6a5C+SkoPNCMwpPIf8XTgdQJCo8jkfr/mUlCgIj3ua3QEpzJo07xX6zG9g1perZ9Enbut1zX2YW1kAqqbBF6G3+b3r8SeebRT0S/bnwaTufM6q+7vD1Ajnm0x0DZmZUYqfq5dqz0z5Ho5t43sv1xYCBAkKPXz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553803; c=relaxed/simple;
	bh=6dGxa9F1K92BbEY11O2z1ZSmXqt8lMDEs78pTj6SKPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0vQFDZtCe39WPMjvTzLO+A5GaPmiamP2d1y1dgdZrkJnqWXpCPT3repXfgF4jQhVY6QYh8PgcaA07X7mbc/Brc/cz3X43Bi7NssKHqAjdZtxENM9CU0Omm6z78/JyjC95XeRQtKfS6rOO/8xKIgINBTZYIrWKEmnwHKP4k0wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vTLD6EmG; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vTLD6EmG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTFoyk6qigL1cNWx1s386sMtfdXTkbGnLcTcdLieRAB8hodsbVeGmNs1NANasWBpHa9LaBHGI8nayfAaOlwxkGttJ4iP0JIIzkdaEMdkkf7t00NSvg7EiCxvWMvkJ8b4muK5I3NbSem7V2fRZog2Wf7CfOEKMIbIwIhcsjHYF607ptCCXBfx23lWMiT4GPZsI0VYKQy4tb9zzbOCLypSBv4XB8mQlNwZ7ETnX6TBbP3kaG5FPAnDSz1yjuoxmXvO5bHO0SFc0RSQsCXYidWlhVH6+MAUSuezmee8CbLkuIdptSYC02B1yC5mpd+4RaBc0k2RXYRNguUeaZ32axalsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dGxa9F1K92BbEY11O2z1ZSmXqt8lMDEs78pTj6SKPo=;
 b=kKrDjDf93ZtrnEwWvxoI8SGvzLSlm8xH/fYd4ZneTQt7GISbKVlWPSQeib689e/XR/odm3I47/q/XQmZhoeHJ5uIJo7VBD4snnL3n3BjjSsIpfRhw56S9AY25Q1sUgGNFNsxkfQWPlluoIR9NVCzLboscEP870s+rDiv7b/NyDTXOkpuHf4R8TRkhCwEOv/nSTQSmbqsIkYDVKUNTAAfwVWuaVYRF31QeBKGQxOqdvVUzdWasXjkTYu2WT56Y29jW2n3SryWNc/fl0AEES+iRx55B5Pxy/heUpU4hUyNmSxGlICZKLAWCudbkjY+NQtBHm6+xH4OXBWVh9PjwPr7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dGxa9F1K92BbEY11O2z1ZSmXqt8lMDEs78pTj6SKPo=;
 b=vTLD6EmGVJbtqK4tTALL87/YbjUI3ek2zIY10Ui/wCMxs0BgLrEVYOkSc6n4bmyejbOixxYj/iWv1sHIdAAF1/UslaDb9qtEmLeb0IGFA9dHjPaX8JscchRObXXBK4bOCwTO/iLYOv1J7dVKS7hTG96NArGJ4lyxF8IIQnRYrXUbWFiHYYh4DAXmoY07TIPyIGQumHI9dHD6Uc+SUfAaUV+TFFRFcjwRO6LIWw1p00p5mkQy9RZxnheqr6dYsf8q+EooprDcwE74rzvGqTM4CbA0rssme7yzDTH1jKnAJ7h0WTxhtvWTQdwWa9JptZfLvlzJrUOwp2+MM2pgQcmB2g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:49:55 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 17:49:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, Julian Swagemakers <julian@swagemakers.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Steve Hay <steve.m.hay@googlemail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Topic: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Index:
 AQHbvdIH1wi2Dpyl3k6jAvs66vPp1bPEtSClgABhdcSAAEIS+oAAf3fRgAADegCAAAdPqw==
Date: Tue, 6 May 2025 17:49:55 +0000
Message-ID:
 <PN3PR01MB9597CF56985502FBC32A8520B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqplgmlisy.fsf@gitster.g>
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqecx1ll5e.fsf@gitster.g>
 <PN3PR01MB959731081532150F5FE54875B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB959731081532150F5FE54875B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB10065:EE_
x-ms-office365-filtering-correlation-id: fb566c02-9656-4742-ca40-08dd8cc66915
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|6072599003|461199028|8062599006|7092599006|8060799009|15080799009|19110799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1lJOGRpVWRILy9hcmt4cU5BSDNuczVqYUZBN2tzYWxpM0x2blZ5WlF6MURK?=
 =?utf-8?B?V0d5MTRRZmVzTDJjR2l5a29LTHNCUXd6TUw4YllmR3JRdGN3d3Z6UFlIS01n?=
 =?utf-8?B?V1pJZGZYajNtWkhGLzlqbDhkKzRYZ0JieElhSW9YOWErNTF4NWRTcnhHZHJv?=
 =?utf-8?B?UXFEY3dRQzB3QWkxa1AvWGRvMlAwMUxiVEFBdG8xdjdHSWJIOTFsMTY2bG9s?=
 =?utf-8?B?WUlqOW9xZWszR2h3R0lOWm5kUksxUzY5K1pQc0UyajFuYTRKd3ZvOSswODhM?=
 =?utf-8?B?bTZrSXY0UGpnNVlLckkyb1NhWHJPZm1CQjZwZDk3SHVkQzRUcHlNRFBlT3Jt?=
 =?utf-8?B?Y09ZTjJmeTRMVFJyV1VtMGZJcDJYWDFnd25zRFhZTUk1UjZxVVJ5bXR1RlJs?=
 =?utf-8?B?RGJiVFVLOXVhQW9yMG0xNlFKZzBCS1V4aGlnMFVmK3JyenJ0Z3l3MGtpR1ov?=
 =?utf-8?B?V0t6dGFmdE5OUmU0OFVLK21ZV3ZKZlFleHFRNjlsVk0zQVlXOW10WDBDc25W?=
 =?utf-8?B?bVd1VlI2NlhQaC9LUVN6d3NRQTlUV1I0alIwR2g3V3ZJR1hLK01RSm1nTXZM?=
 =?utf-8?B?VEVLVy9CSHF4V1VqVFdIelhmR1U0L0RxdXpHZlZPYVpDTklWOUpaL0xUN3ZJ?=
 =?utf-8?B?T0FxdjhBK0s5Tyt6NmZYanZIRUd0SzRKWnBLaEV5TWwzb3NpKzFEN2gzRDBU?=
 =?utf-8?B?b1IvMlBMblliWmVRQUNLOTVhb1d2ME8vdjQ3YzJxTzRWUnZBUnhxTmo1UVR4?=
 =?utf-8?B?SGpXRE0xaE1wN0J5TTljRDB3VkMvKys3Wnl1bVQvZ1dhVEJFVlEzaWZzL2sx?=
 =?utf-8?B?UjNvT0kzTXMxRG1qa1N5KzhGWXA2bUwrdHpqNXlLMUNTNnBnS3U0N1ZZSU8z?=
 =?utf-8?B?T0hSWUlCTU1zZFZwTjBCK1kxSms1N0F3bDB1ZGxUTzJWZHRQSGVpWjNNWHVJ?=
 =?utf-8?B?TWJhdHNwSklCM0RScXZXZFpsUkx3dHFNT0xNdjZFSUU0cUtxcGNrVVhaWCsy?=
 =?utf-8?B?cjRaRXdESXVCSldUUFdtMys1ZlJNRVdDb3NqalEwTStsVmIrTjNJMUxueVMz?=
 =?utf-8?B?blhOYXhyZ1NGdFZXUjNqallScUZHUUY2dE00bHZObSt0MW5XeWlrNWNJaGdP?=
 =?utf-8?B?RlpmNk5UQndNck5ydHRoUDJDVkVlV0tPWjg2S0l1OEtEQUVEUmJzUTdqL3Bl?=
 =?utf-8?B?T0w5TWQxYitvRFlCWEs4Mks3cXpQMlh6YzVTWE15TFRWUzBBM1oxOVlnek44?=
 =?utf-8?B?UE9NeXBCbkRJbGkwR3p0Nk5LeTJ3RGJHczdsM3dxVmN1YlhJM2d0NzhRVVR6?=
 =?utf-8?B?Yk05TWJKaFBYNVpwYm1QQzBNd2I2dTNpVThxdTFjRzl4RGRsaVk1SjRFbGJ5?=
 =?utf-8?B?YjZFV0EwVHFZVWs0TGUxTGFDRXYrWEUwOUQ0cFdwTURJQ28zUDBoWm5BTFBT?=
 =?utf-8?B?WDVnMmpMckpoL3R6TEhsL1FrTUxhMk9MZjdNdm9LSXpSRUl2cEZJaVFtVW1T?=
 =?utf-8?B?eWxCUFJqd1dtSURvRUlid2duRTA0ZytFWjVuMnMza0J2TnhwVXVaSlBhS3Zh?=
 =?utf-8?Q?Z6AOlNEEjB3F9eDLnXYQor9F0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3g3UmtENVl5V0hjeHpNemhQUzZGSkZZV2VjVWkzMmY3a1pWU21YTEZWVzFC?=
 =?utf-8?B?VkxWZTF2YVh3Y2lkbnlRWWlOS3owdjN4STNsd05ZTkJwcHg1ZFgzRERERHcx?=
 =?utf-8?B?cXBGQVZGTUpuakhzdnlKZEdhcmFDYy9SY2x1ZStZdWxNSG04Z2cyc0FuYjla?=
 =?utf-8?B?TjhHUHdwTHN4RFpzanU1V2lDQkl1aTRNL0d5a0NvZTZFQzJtckx5ckZ5dGVj?=
 =?utf-8?B?djVwTFdaOUtGOVIvSi9oNW9hK3R5Y1Aydzd3Wk1ESHVHdHZHNnhHbURGVmRR?=
 =?utf-8?B?TURNL3FLbHJ2VWtoMUFmRnM3V3BMVUFYeUhWUEVSejYrcTVFVXc1MDhQUGpG?=
 =?utf-8?B?L00wb0F6bzBqTTZSTkR0NElMRGhtMUVEL0xqVFQ2NSsrTDF5UmtZZHUrWTc3?=
 =?utf-8?B?c1F2Q3FVNHB4UnZKTXNpQ3VpZ0NTTjFlcmNyb0hWWkRGbmJoSTlnRHVrVklS?=
 =?utf-8?B?a1NVQWUweC9pbXNuYTE2ZkVzUXkxRXREYmpOQnNMcG9OblpBMUlxRHVpandI?=
 =?utf-8?B?TlpuYkpTR2YxRmlhM2duUm5BbXBUbG5ZY09YUGpPQ09TQ05xdkJFK0xManN4?=
 =?utf-8?B?dEpQcFZBRzZvaTdoZXBYVmFtYWRVYitnNGxJbWNoNmRWM1JPMDA0a2UzTHpX?=
 =?utf-8?B?dk42ZGl4MlpKd2ZhZWV4eS8vQ1BZT1cyUEZCdTg4VGp2TzhlNWxsb2RLeVRt?=
 =?utf-8?B?VHJBY1NwcE4yalB4Njl2WG0rTnRJblhXT1QvT2s4SUQvSEYxQyt0Sm5lRGU0?=
 =?utf-8?B?TGNwY2poYVBwT0xPUGZiVlJJUDU2cUxzbDA2MnUvU0NaMmUrYWdrekFBeVBj?=
 =?utf-8?B?ek5aMHdzeGd0YzNGSk5NOUV1RzBJUUNYZ1B5UWk2STQ1R3VDYmFPNVgrUFRj?=
 =?utf-8?B?RzNrd0NWb3ZLNGdCRFdzOFhaaGprR1ZXZG9YSE82NUswL0xIcTBoR0NicnJF?=
 =?utf-8?B?TDJydFloaVRZYnVwejdkNmxLdEpTSTFpcHNlOFJDT3NTL2dZTmZ4Ujk3VzZ4?=
 =?utf-8?B?VWJGQnlJbElwVGxJSzZoMnk1SVJTa25ISlMrYTA3NnNkbDBFYWl3OHJQbWxN?=
 =?utf-8?B?MDVrdTg2WEtWdExYTzJUdzRGc29uckZuSmVUN0hkWFJYaTJ2TGd6OEJhcGhh?=
 =?utf-8?B?bjJneWZYSHlQdWs4aFlpQ1F3Nmp2Q25oaHp0cWhpQXZVb2p0bXVlSGdwOXVL?=
 =?utf-8?B?MkVCbGQxZlNVRHBNY1Jsd3FjdkkvRTNxQ3pNTDdRa0FCQlJnMkhiajQ1dzVO?=
 =?utf-8?B?UVVJNjduaFlvQjduYnlBVFVRR1NVOGYzWXlIQ1FVMkcrNlBrUUh0T3RSZm1Z?=
 =?utf-8?B?djlFWUM4MzduYS9JTTA4NUJJaXYrM1VTdzZwWFRTM1JuMEdNUXBZakJnN05Z?=
 =?utf-8?B?MS9aK014WGQ0QWtQT2srSVh1TFBmVnhCd3pvSW1CVmhiWlFVREl5UkU3NGIz?=
 =?utf-8?B?Q0FFTlExYWZ1VFJWaG9qclJIV2ZTb2pObmZCZXo5RGZjYzdHem1nMHBPUFFp?=
 =?utf-8?B?ZVIyVENJTG03S29IOUJnSFJLc0ZFdWUzM3FCdDlnUjQycjZHMnJTbE1wcmEw?=
 =?utf-8?B?QzhrS3BiYlJFMWtLeHkwQ1lwRlljaU5sdDlsQWJQZGF6QXhFRWFmNE0vdkVt?=
 =?utf-8?B?RW1YOG9tNUVYRHhQeWpQNjZDWVBOT09ZRzFBYnVVeUNKTlpCOGhCK2Vra3pR?=
 =?utf-8?B?VVFYRjRQR3A1T2VCeHNMM1pvemdodmhVY09pcmxxSUh6bU4rTXE3SFVBRVB5?=
 =?utf-8?Q?HIg927FebV8gUK/2Y8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fb566c02-9656-4742-ca40-08dd8cc66915
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 17:49:55.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10065

DQoNCj4gT24gNiBNYXkgMjAyNSwgYXQgMTA6NTPigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+PiBPbiAwNi8wNS8yNSAxMDo0
MSBwbSwgSnVuaW8gQyBIYW1hbm8gd3JvdGU6DQo+PiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+PiANCj4+PiBJIHRoaW5rIHdlIGNhbiBhZGQgYSBtaW5pbWFs
IGNoZWNrIHRvIGVuc3VyZSB0aGF0IHRoZXJlIGFyZSBubyB0d28gZG90cyB0b2dldGhlci4NCj4+
PiBEb2VzIHRoYXQgc291bmQgZmFpcj8NCj4+IA0KPj4gSXMgaXQgYSBjb21tb24gbWlzY29uZmln
dXJhdGlvbiBpbiB0aGUgZmlyc3QgcGxhY2UgdGhhdCBzaW5nbGluZyBvdXQNCj4+IGEgbmFtZSBl
bmRpbmcgd2l0aCBkb3VibGUgZG90cyAod2hpY2ggaW5kZWVkIGlzIHZlcnkgbGlrZWx5IHRoYXQN
Cj4+IG5vYm9keSBzaG91bGQgYmUgcmVseWluZyBvbiBnZXR0aW5nIGFjY2VwdGVkIGJ5IHNlbnNp
YmxlIFNNVFANCj4+IHNlcnZlcnMsIGhlbmNlIHZlcnkgc2FmZSB0aWdodGVuaW5nKSBpcyB3b3J0
aCBkb2luZz8gIElmIE1hY0Jvb2tzIGFzDQo+PiBzaGlwcGVkIHdvdWxkIGJ5IGRlZmF1bHQgY2xh
aW0gdG8gYmUgIk1hY0Jvb2suLiIgbGlrZSB5b3VyIGV4YW1wbGUNCj4+IGhhZCAoSSBkbyBub3Qg
a25vdyBpZiB0aGF0IGlzIHRoZSBjYXNlLCBhcyBJIGRvIG5vdCBsaXZlIGluIEFwcGxlDQo+PiBl
Y29zeXN0ZW0pLCBpdCBtYXkgZ2l2ZSB1cyBhIHJlYXNvbiB0byBzcGVjaWFsIGNhc2UgdGhlIHRy
YWlsaW5nDQo+PiBkb3VibGUtZG90cywgZm9yIGV4YW1wbGUuDQo+IA0KPiBJdHMgbm90IGFuIEFw
cGxlIHRoaW5nLiBJIGFtIG5vdCBldmVuIHVzaW5nIG1hY09TIGF0IHRoZSBmaXJzdCBwbGFjZQ0K
PiB3aGVuIEkgdGVzdGVkIHRoaXMsIEkgd2FzIG9uIFVidW50dSBydW5uaW5nIG9uIG15IE1hYy4N
Cj4gDQo+IEl0cyBhIHByb2JsZW0gd2l0aCBOZXQ6OkRvbWFpbi4gSW4gc3lzdGVtcyB3aXRob3V0
IGEgZG9tYWlubmFtZSwgYW5kDQo+IHdpdGhvdXQgYSBwZXJpb2QgaW4gdGhlIGhvc3RuYW1lLCBO
ZXQ6OkRvbWFpbiB3aWxsIGFsd2F5cyBvdXRwdXQNCj4gImhvc3RuYW1lLi4iLiBZb3UgcHJvYmFi
bHkgc2hvdWxkIGNoZWNrIHlvdXIgbWFjaGluZSB3aXRoIHNtdHAtZGVidWc/DQo+IEJ0dywgdGhl
IG91dHB1dCBvZiBgaG9zdG5hbWUgLWZgIG9uIHRoZXNlIG1hY2hpbmVzIHdpbGwgYmUgImhvc3Ru
YW1lIi4NCj4gDQo+IE5vdyBnbWFpbCBkb2VzIG5vdCByZWplY3QgdGhpcywgcHJvYmFibHkgdGhl
IHJlYXNvbiBpdCBpcyB1bm5vdGljZWQ/DQo+IFNpbmNlIE91dGxvb2sgc3VwcG9ydCBpcyBuZXcs
IHN1Y2ggcHJvYmxlbXMgYXJlIGJlaW5nIG9ic2VydmVkLg0KPiANCj4gDQo+PiANCj4+IEkgcGVy
c29uYWxseSBmZWVsIHRoYXQgInJ1biBvZiBhdCBtb3N0IDYzIGFsbnVtIG9yIGRhc2ggc2VwYXJh
dGVkIGJ5DQo+PiBhIHNpbmdsZSBkb3QgaW4gYmV0d2VlbiIgaXMgZWFzeSBlbm91Z2ggdG8gZXhw
bGFpbiwgc28gaWYgSSB3ZXJlDQo+PiBkb2luZyB0aGlzIGNoYW5nZSwgSSB3b3VsZCBqdXN0IHVz
ZSB0aGUgcmVnZXhwIHVzZWQgaW4gcG9zdGVkIHBhdGNoDQo+PiBbKl0gYW5kIGlmIG5vYm9keSBj
b21wbGFpbnMsIHN0b3AgcmlnaHQgdGhlcmUuICBJZiB3ZSBnZXQgYW55DQo+PiBjb21wbGFpbnQs
IHRoZW4gSSdkIGRldGVjdCBhbmQgcmVqZWN0IHRoZSBjYXNlIHdoZXJlIHRoZSBzdHJpbmcgZW5k
cw0KPj4gd2l0aCBkb3VibGUtZG90cy4NCj4gDQo+IFRoZSByZWdleHAgdXNlZCBpbiB0aGUgb3Jp
Z2luYWwgcGF0Y2ggY292ZXJzIHRoZSBkb3VibGUgZG90cyBjYXNlIGFzIHdlbGwuDQo+IEl0cyBi
YXNpY2FsbHkgZm9sbG93aW5nIHRoZSBSRkMgZ3VpZGVsaW5lcywgd2hpY2ggYSBzZW5zaWJsZSBT
TVRQIHNlcnZlcg0KPiBzaG91bGQgZm9sbG93LCBhbmQgc28gbXVzdCBhIHVzZXIuDQo+IA0KPj4g
DQo+PiBbRm9vdG5vdGVdDQo+PiANCj4+ICogLi4uIGJ1dCBJIGRvbid0IGtub3cgaWYgeW91ciB1
c2Ugb2YgbmVnYXRpdmUgbG9va2Fyb3VuZA0KPj4gICBhc3NlcnNpb25zIGlzIGNvcnJlY3QuICBT
aG91bGRuJ3QgdGhlICJhIGxhYmVsIGNhbm5vdCBiZWdpbiBvcg0KPj4gICBlbmQgd2l0aCBkYXNo
IiBiZSBhcHBsaWVkIG5vdCBqdXN0IHRvIHRoZSBmaXJzdCBsYWJlbCBidXQNCj4+ICAgY29uc2lz
dGVudGx5IHRvIGFsbCBvZiB0aGUgZG90LXNlcGFyYXRlZCBsYWJlbHM/DQo+IA0KPiBJIHRoaW5r
IHlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGlzIGNhc2U6DQo+IA0KPiBzb21lb25lLi1leGFtcGxl
LmNvbQ0KPiANCj4gTm8sIGl0cyBub3QgdmFsaWQuYQ0KDQpBbHRob3VnaCBteSByZWdleCBpcyBj
b25zaWRlcmluZyBpdCBhcyB2YWxpZCwgd2hpY2ggSSBjYW4gZml4LCBidXQgSSdkIHJhdGhlciB3
YWl0DQpmb3IgdXMgdG8gY29tZSB0byBhIGNvbmNsdXNpb24gb24gaG93IHdlIGFyZSBmaXhpbmcg
dGhpcyBpbiB0aGUgZmlyc3QgcGxhY2Uu
