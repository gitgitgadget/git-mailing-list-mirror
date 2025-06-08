Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE941EEA40
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749369291; cv=fail; b=rvg9IVj1UV4rfD2wF9hMaVje6ZRpf4BvmpRfH1IWwWikreKD4dapGjZ4FLIO6EhTRZOPr/SB/lP/M+TgqIBPFkj+k1cnJvWH+lB/XB/akNHCALi+E1qW9xYatRC6bk0vG9jGTM+y1DKDmw2NCk+rMXC133vvac3jbftZjOO/tpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749369291; c=relaxed/simple;
	bh=w/PBRvpkLhl4oueLuHDMM87fFpoS2QwKRhz09oNbDek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5pDxOwh01KmoSCHihfgZz0Cc58EHEgLxeoH/vX8pD9CNlZWIK1j7o558PWX/oSr/f8EVBofZm+U2JWyojelHmLxvqoiwuU+GGL5l9Rpmg9gY9LF4EIRuMK0nDqUFBYT/5m+p8Yz74rGvbK+LabHQBF0HbSH8QTeBCCO0unROos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Tmaf/RgZ; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Tmaf/RgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvWJTwqQ2MpSYgdtmQ93qxOSO/CAUYLjZAsYRe1n6pK4sNACJxxIW9luvNVZCD9Tgzf2vADZ1gi0Y0OGkQB1AZdpzy5pqrr47c+C+4yJOYTSdCpq+d0KLaFlsXB6RMLm2bzIG4vCQMQICUOWXXjQFfVB0eo96Gf3ATIOq7lZ2wKo+IlggO09rt0l8LTZRjSvn7oAu4WA1Jlc3spP7frfIOJ4u9IFAvtcQPi5vLMu3NxtJna+4d98MGMhb8Fd71wCiXZyGZGd09lDe4lU9RZ0TYBcCns5PERBKR9mbbsaI+8PVb5iRocr3vpyIjn03EAJTDEa+oMj7i+XbFgHp2qmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/PBRvpkLhl4oueLuHDMM87fFpoS2QwKRhz09oNbDek=;
 b=iKSeD6B3H8HVpNvb8Ow4TtY4MscdWb4D6xpssistywzRFbq4cAANE1schopKTWl0wfh5wKqsx65A9TlKxrD2nf7gXFmCYxS1Isib26dpFhx9yIdE71DaP724XJlLZyj1VIK1mXGvIHNn5LZ4ad3YI/dpE/ehMb6mJ7AX0M21npSfemH4vl2mDTm1RPsB5yQQaX+AgVNJ2fV4Oft4u+3z6UHJW+uaLP/j+ePUjjYYWKV7AP+mBwOKvKzGdRRcBLGcteCVuuic454FnvIkDY/u1s90vNgkBsc6yjxUOAjWAR854FHvcxG4tm5LHc6q/Ul79v6GonSVK1U8ZOox2H32Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/PBRvpkLhl4oueLuHDMM87fFpoS2QwKRhz09oNbDek=;
 b=Tmaf/RgZMN+p4GUUirqswJ2tXFSEaa17/EobqvprYf+QgjsVPzDJ9jOslB6rPZs99ok9KrgypbiBNQenDLOGZ3lHgwe2h/lbZU+obdnTJGagdvVknBuMvnQDq95C38Menw3IQfJEpD5vsFDr1LQL/V6hMTPJCOcTGwuS3FB37hh+cUA59Q/q5TD/S1Bi5ydCvEmvUepFxuIihQIyBUL7RT1PFk/99kauBOmxLnJtEjkraQMZJ2BkrtyYqZ3Lyi33vK9duGPk/qFf6TWKoLd3yz53sWILGyqq6xtrkgO9mIzVedkoREp8R+fpIVBgYEOdvXPuklG+rnexEeF14GNFiQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7556.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Sun, 8 Jun
 2025 07:54:44 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 07:54:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Topic: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Index: AQHb1x7RwmU6j68CikiCTe6h/Egw8rP31HOYgAAcK7WAALp/M4AAO9SI
Date: Sun, 8 Jun 2025 07:54:43 +0000
Message-ID:
 <PN3PR01MB9597F2063272A3D7E572443EB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqy0u3zhxl.fsf@gitster.g>
	<PN3PR01MB9597C03C260EC7F5F9237A5FB869A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikl6yid8.fsf@gitster.g>
In-Reply-To: <xmqqikl6yid8.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB7556:EE_
x-ms-office365-filtering-correlation-id: dd55a2d6-b0d1-42f0-e17f-08dda661bb29
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|6072599003|7092599006|8060799009|8062599006|15080799009|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2UzQWwyNStTQWVENXVnSE54V3kyRTYwL1p3ZnJ4VytVTm1IcVRIWWlTVEVE?=
 =?utf-8?B?cDBrU0F5R3k5Wmlza2lLSm1kdFdycjRSczNnUm5kcWRxWnp2azd2UlNrTy9C?=
 =?utf-8?B?T2RPeGpNcVY2M3BFU2YvWHVKY1l1T2dTdXZ0cEY3cDBLQWN1bzBzeVl3RnAv?=
 =?utf-8?B?L1o5bXBNRytHaUZXc0lEOVhjVVRhbEZnajNvNzBZQkJrbGs5bXBBU0c1dlov?=
 =?utf-8?B?VUx0Q21acjIxZzEzWWMra0FwcGhSaTV2ZmFHS2dua1dnVmYxdzhsVmU4U2kr?=
 =?utf-8?B?cmFaaTZUeFZjSDVlZG42Qlk0UzR0WUxsdTk4eDhycjhXY3hPeHB2OGkvRHJv?=
 =?utf-8?B?L2NBM3BVa3MxTXFoY2xpaHF6LzZCZnVVRG9IcWtwYVlpeHg4eHEvQURPRHFZ?=
 =?utf-8?B?aGp0V29XRkVlbDhEMjVKUVVCTUhocGpTUCtWbC9zTWUxSVIyQW9aaHJJUU91?=
 =?utf-8?B?VkhuNE1KK0NSRTRpRzJpUGd6OFVQMkJKRCt4ajg2K21YL2hLMkdJMUc1SGVK?=
 =?utf-8?B?ckFDUmh5aWNGdjljQWgrRm94WkowVWtPaHFRZG0vSG1FZVZhQlJvenVTbTlu?=
 =?utf-8?B?Tmw1bVJzZVowemtqL3hXMFVJRXJtN0xjenEzOTFpWmlJemh2UENjeEFoTC9D?=
 =?utf-8?B?NGJhTkpZRW95UVVPRWQ1RTRvcHFTUHlmTDNFamt4SlVpV0N1NTBGZzRzTFM5?=
 =?utf-8?B?VmZZbVZkSERyUWJDSkx5bHNKMVBoRzNmSjJvVmcxL0RQZHZYbnBOYzl0U2Fr?=
 =?utf-8?B?b1ltam04eDBjQzdzNEkxTXhvNEhnUVVEdzZyWW92eWRaeWJyV1N3VDJtTGN5?=
 =?utf-8?B?WEdpekIybktCWlRQR2pUc1FCMUxQUDc0Y0tzSEJ3Vlo1elNRYlNWZVVnSGZT?=
 =?utf-8?B?aGtpcjFJZUtkdTI2ZU0rdHNFRmJYb2FEZ0hXV0RReFNjb2thYW0yRmVEUE1N?=
 =?utf-8?B?WUZiTzVPbVc5bTBnN3QvY09IdEIyeTJoUGdHTU41eWptL2hUY0huZ0Mzb3h2?=
 =?utf-8?B?Y0w0RmFNZDlFMlpYOVZYVEFiMjJiejlmNGZ3VXVMNHBHbWV5WEdvZFRHcHhL?=
 =?utf-8?B?VUpHNmxPVDhTbGlhVk9TZ1NTbXJsSWd4a1dkd2Jza3BrYW1lVE1vMVoxZllR?=
 =?utf-8?B?SFlCRWlaUVJjMU5CWW9FcmpjTXlMaU4yekxHV3FNYkNsdWsvU0FNU3FEUi9N?=
 =?utf-8?B?OFpyZDljQWFDTGsvd3BVbzBhQWM4aGtzdXBJaW1JZG1KVHJxdURpZk5SMjNk?=
 =?utf-8?B?NEtzNHp0NG9wYzl1cG5VM3pwV0Vtb3drOVUzd1VSaFhPamFuZFFOb0dYY1lC?=
 =?utf-8?B?N3lmWW1mZGMvQ0cwMFRRYS84OW9kaVgxUWtyV1lOaDhDQUowWEhXZzczQnJu?=
 =?utf-8?B?SzByOWFJSXd2NHkvZWx3MU1kdWxxNDlHeDVJZjVYb3hVTXNDRWZGMDljVEJz?=
 =?utf-8?B?Vno2RVhaWnNTT0EwQ0EyWE0zQ0hMK0F6VXBWQXdlQjhjOHBFNnJiU2ZyeDll?=
 =?utf-8?B?SzlKYzJxclFxdzB2OGdmSXMzTGJCRS9LemZZbTB0Wlp5TUNqL0VmV1RtOWJQ?=
 =?utf-8?B?eStoZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUErR0NBd3haMWx3bzB6L3VHaVI3VjVUQVIzaDJoSWhiZ0x3VzFnQXZVbzEz?=
 =?utf-8?B?UTF5VXZwQWc3VTVrY0wwV3BweEJ0cG91TnJXS2pEdTFhUEExTlY5a0d0UXIr?=
 =?utf-8?B?SjBBMHJ5SDJOeDNzTVIwbFdlOXYzazAyUkcrMUx2eWFlcTBMQzNISENvZjc2?=
 =?utf-8?B?OHRzM0xnS1A2RWN1L3hueGdScmhyMm5jc2U3eW1NRWRQdVVZaGVvbDUvQ3F2?=
 =?utf-8?B?VzdtTlA1VGlFREptQThoa3BPREEwUnRjU0pXN3prNGdiRjVQZUlPa2lkVCtk?=
 =?utf-8?B?MUV4Uy9wZUJoTkMwMExoMjY4VjlOZnVxUFpoRHZMVkFYdVhJQmsvR09uTVVp?=
 =?utf-8?B?WjdNcmptUlM5ZUpnN1hGTzNlWm5wN0VlbXV0L3I2cW53UmZGNVIrK09MOTBt?=
 =?utf-8?B?S2dXQVBXME5PMWJjbFdkY0h2eTQ2WTE0WXBhVUNYRmgwNGZudHlYUWMwT0xN?=
 =?utf-8?B?L01QMU9CaEIwYlBLMHhsTDRUdjhGRFVkYU5ZN2pTU1hVbEpEOGtldTYzMkNZ?=
 =?utf-8?B?ckFndUZqM1pjc3BwWTcvU0tGNzFRRCtJM1F5WFEyeHJSeG82RExtWU9rM0hH?=
 =?utf-8?B?WmRUbWpzdW1NaVZ2YUJ5ZElaS0RZSThwc0JnaVhHY3NaeDNRZUdBU3VWWnpK?=
 =?utf-8?B?Q3BUUWZqL09NRkJwT3czRFh4YlJyaUJMcFZFaWYvMytWeFdOaVYwQ2ZKOHlm?=
 =?utf-8?B?ZnVmeDM2S002dm14d2pnUEtaQzRuNGU0RHdIY2dKTDF2T0lIWnpZTjJiNkpF?=
 =?utf-8?B?RGNBc2pxQk5POHQ5L2JmemtTRG85Tmdsa2JTTWppZnI2bGc4T2F6MmpsbHNz?=
 =?utf-8?B?ZHAzVjk5V3NncWQ1azE5VTZtWEk2RnNmRE4zOGY2YnRtZnJsdkp3REFud0J2?=
 =?utf-8?B?K0lUMTVBKzZvQ0NadkhtSEk1cEZPZU53VGI3emIyN0I2ZFZqOVRadnZKM3ZL?=
 =?utf-8?B?WVd3ajJUYW5uMFFDSk9yK3NSWXE4RmhQVVEzcU5GSEVSV1h6VnlWZWpQeEFv?=
 =?utf-8?B?OHllV2pyR05uZnUwZ2I1KzIyODEvakx2Yk5JVlRDNlBwZXpRV3NDVXpsSjRR?=
 =?utf-8?B?cFNVd21QOHdIRDkwbk9JTXZZR0l0SnlkTXNOTjVQeUFtZFdocWMvQytQUzJo?=
 =?utf-8?B?NGpxNnUrWHNPSjA4VnFrY0E0bXRrV1p1S3JKdzZQYVJSTDdhYmF3MjJaSkQw?=
 =?utf-8?B?N2xXR2lwOE5MZERacm43NDljbkhoK2NaakJ4ZnNhVDhOTXhScU4wUFFQUjJr?=
 =?utf-8?B?VExXWXkxYW5KdjkwbDYxeWRpMys3S3d6dm0zSCtvUng4ZlczcXY1WlV2MUd3?=
 =?utf-8?B?WTBROWdqOEZxQ0c0U1FaQXBtQzBIT2tHKzVzYm9nNXFxellNMVhoV2xvZHV3?=
 =?utf-8?B?aEpzSVpUTEZINzFWbW16Nk1WNHpaS01qaVZ2UHYvSVZFK2tzMlJ0L0tGOGlN?=
 =?utf-8?B?R254YkV0d3EzZG1aVlFsRVJyRzJhUXpHQ09QMnVzTzBnWDZxb2hKeTRnQmtQ?=
 =?utf-8?B?a0RlanUyTmRYajhrSURLUm5HKzJDTzJwZEZHNFpEV1pvWC9WRE9mbVNYK3By?=
 =?utf-8?B?aUVRdDN1MTExai9IbFBoVVBtOXg1MmV3TkJNOGZZM3VOZVZpeHVoajVsVVRq?=
 =?utf-8?Q?jEzVbJx2zy7zre5ANhi85afVXgOyG7HYuFkMKmdLjtog=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55a2d6-b0d1-42f0-e17f-08dda661bb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2025 07:54:43.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7556

DQoNCj4gT24gOCBKdW4gMjAyNSwgYXQgOTo1MOKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IC4uLiBpZiBJICpoYXZlKiB0byBtb3ZlIGl0IGFib3Zl
LCBwbGVhc2UgbGV0IG1lDQo+PiBrbm93Lg0KPiANCj4gVGhpcyBpcyB0aGUgc2Vjb25kIHRpbWUg
YWZ0ZXIgSSB0b2xkIHlvdSB3aGF0IG5lZWRzIHRvIGJlIGRvbmUgeW91DQo+IHRvbGQgbWUgdG8g
dGVsbCB5b3UgdG8gZG8gaXQsIGlzbid0IGl0Pw0KDQpXaGF0IEkgdW5kZXJzdGFuZCBldmVyeSB0
aW1lIGlzIHlvdSBzdWdnZXN0IG1lIHJhdGhlciB0aGFuIHRlbGwgbWUuDQpBbnl3YXlzLCBFbmds
aXNoIGlzIG5vdCBteSBuYXRpdmUgbGFuZ3VhZ2Ugc28gSSBkbyBtaXN1bmRlcnN0YW5kDQpxdWl0
ZSBvZnRlbi4=
