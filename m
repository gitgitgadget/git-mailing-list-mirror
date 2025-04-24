Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE2199396
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466161; cv=fail; b=cRhxVKDiP0lL0FEzqihPyoFB4gn7edTcGlgG/44SZRubmn4xXDSj63srZmgyk/YbvaiOq0fEcuiN8ffN/lDuyu5xNWzUtKDe1nFx/fUbhm/wa0M0+JJDUA8uMnxSj9nz8WS/TbZuV/spoTpa5sgS1pAzeranTCVe1VCZgJKvMqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466161; c=relaxed/simple;
	bh=OHMYWxusZdpFjQLHjoCWd6ph9Bc8/OSIwMgYvjqvDu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aar6w8Pi1aYiozXgDqv0MnYA5rGX+RX5G2X6j4atbGEHI5yvQZXtD655SB4lyJsRBiHBvGoonUdl7FZ4kIBxYcIfQq8w7uRCOpCyXRcZPSklWIcbC2jYsiOooBKANatwosXlJ7YqYEAicv3jGJE6j3L+Z9vghCLf87apRXOBB5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XuE6qX92; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XuE6qX92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+fdBcNZyti3W1PzN9Fw+mEUknqjfsNtvuGNxsuHuVeJYzyDjvyL7f9eSTwF3Df9N0oleEu4VAcw1fM9ZpU4nvBCWbwLjAxB7j33hXCQBiaOg/Nl9F4sFGFf1Q5kayj91LtjgrdGMe3ZfLemzK+vSmCQqeO/XFkwRcSjOTMdjJQYCYwd/ov23nHKMLlFooMokURe9OiaOV6Y9DGKu44+dqcu1WGuI76/G5wCG2D+Tbq8NvhO2k/60WfoQcisUnDWRdtoEFoZ6A2hmYd7926ihs3bPzL72pYQ/B5r/mtatXrRHbc8lUxq8M+ghEFRK45UzCkgq2XqnLfHS7xMZHHwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHMYWxusZdpFjQLHjoCWd6ph9Bc8/OSIwMgYvjqvDu0=;
 b=USw2TZUFHizP0Wo9YNVRCXw74ONoDHHpKQFhH85SPxnps1K3HszgNBXPVK+3x82fE/O5L7oLpSjiK++NbC5LhijbOYoZO1LvUNCt78lSfRr/pkX/TJ7Sy8iNYzmjmehxhPY53QddG5r5YsHTleSazQEHaquHFDz+agjVYwVlk3ZHxc6QpOWmESvbaK+bUtmXppeneYJnAZyBnm5bXUWPVCoUN+QAgEJ2Ve0PhnQguMwD/fZ52WcwGGGHlzvJ7Uek2MBlOorvN0nfnY9o3NLnrQ6ywHX8DEjX6LPNFZNX1KQ3HrCIHRQa4bYSvM+c5yQbQeezd88D4czqPDupY9izmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHMYWxusZdpFjQLHjoCWd6ph9Bc8/OSIwMgYvjqvDu0=;
 b=XuE6qX92rnuJIsScA0lwSesa7SPRh+WxbrvfKYnT7M2G9o9Mr8yBufoCM6BtvvNhnfwyE/h6Crf4Wyxpmc4Oa/bNPToy3uWEUNr8m6Yu3w55DX5+A4IJTdodAXvcVQw0fMIrIknSi9pFs8uenyy90ocOI6ce7YCITomMGH1g/8ZB0Wvp9L67ILW01ROEbx1Qfm4XJ7AoofyCDCuQuKcSb9E3lg1RXWxMh6RGFpq1SuxrF4veAaK1lYtfXVC9JZoPcHnC/9oe9G1WgRBW/XFcZ4DOrfRpqp3fwupBQpnRVlnlGksgvK24hjiLj5rAKeNLsByu6mSSsQdI2OIqtojF7A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9396.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:42:35 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:42:35 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
	<mirth.hickford@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Topic: [PATCH v4 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Index: AQHbtEtRGdMDsFK2GESvTfD0iYgxC7Ox3EwAgABQ8Yo=
Date: Thu, 24 Apr 2025 03:42:34 +0000
Message-ID:
 <PN3PR01MB9597C6D0C0C031880D237536B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aAlvRBDVygspE5_0@tapette.crustytoothpaste.net>
In-Reply-To: <aAlvRBDVygspE5_0@tapette.crustytoothpaste.net>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9396:EE_
x-ms-office365-filtering-correlation-id: 12a01ee4-9342-4296-debb-08dd82e20d10
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+IxpwBcqvoBrjQfpNwZ7EJve/fyrOfjVXYzTc8itASP0TOXWD4qmInvomSPM2DjUWrLcGXkHkB/BYEtZswhHy8Lq0DADHsn/9v6sYaTTWf5N5AjzgPn4xV4apRiE1sPWnlQUWQE/pXcSiAetDiRWcV4yPzJBtw4mTeqIPvSf5LRAVpW8Nfnht7jlbmNAZjBZ652EsTmDF/xv1zc96Ok89ml92pxZtpxrrH1B8Z2xKvuVTvzuyiRTM+pJT1AKr1mRADawmeroBrAQ2CZxm1el5nVGvXzfniiEZFqVjrNpA03Lvz83IJLsx+rwToYa13b2VS5GspTiL+xazQ6agEcMAxFT40QPRiMhdQh2o8fvZfRBiXaEC3nFYXqrofy9YDO0qF/hGDpwvD5QgocCxFYGMpAJBkapKBmy01BhtPi5vFaIOLimz+YbrGSZREgdNjNVw3aBFevCFvkq9MiAKt6t1LMC0g0knk/PgepzQHf+LtQkK7nAxh23e0tIGOvoJdMNK5ijbFR8xO/OYo648qynIeTws2k/Y+I1DX3EegJHWgOvfw3A4YuXUwXZ6wj0byT6aWIC17uNtDZknfyVczF17wGyef1fY/efpxzwYW023tqBORu/r+hsomVg9CJ+OzJFZcr8bftdEajaNT2imnH/TW3x3oz0ABI8T9u91Q1AESRMiim8IChcsqCSC8AX1h77ikxUl5M8nxB0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|6072599003|15080799006|19110799003|7092599003|440099028|3412199025|41001999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGRmdVk1L0laSnRNUnBLZjc1U0FRR2JVRDM5bVdXUXFkdDFRUmdtdEtmS0hk?=
 =?utf-8?B?V0JzNVB6TVJ6RFZSZ3BITXd2dEhwWEhERk9LelBmM1RGNmt0a3lTWWZNQlNT?=
 =?utf-8?B?RGhmQU5zWjU5Y0dBUjZMOUJWQTNja2VuaVNxcVVKcFBZTFlIYU1Cb0tZSHdZ?=
 =?utf-8?B?dE5NY0g5QjV2N3ZYZ1lwTXhKQkpzSk1XTDNWVEpFbTZ0MkJGOFB4K0M3MU1o?=
 =?utf-8?B?M1BsaXYzMy9uUXd5eURCR1pRRWoxYzQzYWRoaU5idUxPTFFwUUU2UlpxV016?=
 =?utf-8?B?VjJTK0czT01ZOE9NVTNaSVF4cFlrRTE5YmNwUWRISnpBOGw1YndHWS8wc1Nw?=
 =?utf-8?B?dzhrQ0ZnSnVzTU0yYmZGN1E1MnNLVzJ5aUovZkVweDZwODlDNGFORmdqejBk?=
 =?utf-8?B?bEFxZ09lN1pBclVxbG9qd2JDSTA5K1UzUkxkWXYwM0RuMllMazdvZm04SEg5?=
 =?utf-8?B?THpVRUprTkRLdGRQK0xFMGMrcVV5blp6K21BYUMzZUNNN0h5OGo2S1NVVHZl?=
 =?utf-8?B?MXA5cHVwK0ZyUGdwS0JHeHhhZ3EybGgzcDkzRHM3M0hMM2tVTytVR0FMOHJw?=
 =?utf-8?B?T1h1Y2FNYVJHODBLMi9vRm1NM01ZVkZpZ2NHeStmQXRnMTErTjVxRXFnTXV5?=
 =?utf-8?B?ZHM1TnhnOTMxR2gxMkRXak80RjUrais2V09RQjhWQ0lvcm9RSUlOamJzUzFh?=
 =?utf-8?B?b3NCWW9vdnNSOGZFRDROVEoyL1VLNmxuWDZnZGpYazc5SmZvZjg0a2lJVy9D?=
 =?utf-8?B?MXNScTlEZ1BFSWlmNERBTzZXZUwxQWpvMGV5aXpGOWFzTmpkdU5SNFcrcmg5?=
 =?utf-8?B?eU50NDhuemJlNlJFTUZCR0Jub2VVQjhWMHpoY1RvR3BPbElZQW5VcW5DQTFM?=
 =?utf-8?B?dkJMK2NHMDZLVjRVRjJwSis3OStzeXhGMmJaeWZyK00vbmhvQjExN1JYNlli?=
 =?utf-8?B?eDVGWDJXRjF2Y1BCUFh6OEk2N1cyLzVMd2lxYkVzaUZDVDlhUm9yL2JvQmg0?=
 =?utf-8?B?NUFoOWE3L01saWVObVhBQjdPczBiYVgxbnpYU1g1TkNadkdMRjhjUGFua0ZY?=
 =?utf-8?B?V25xb1ZHQktsL3lrUlAzUlM0MGtzeW9PYXV5a1hTNWJ6YVkwMk56bW16SzNG?=
 =?utf-8?B?WWI2R1Q3SDc2UmxFaEFWV1VtSUtNNjNrN3NrNzBwd2pyL2VZWGJXOFJ0blFv?=
 =?utf-8?B?a3hxV0JtaWYrcjI3TDdNWjk5QnVUVDF2WXJjcXdoNEozZFpOMUlNSU91Y3V3?=
 =?utf-8?B?UGcvUCs1TUJ2S2s0MytXZGxHYlI3ZGkyekxKSm1Qa2Z0Z3V6WlV4NVRRV2pY?=
 =?utf-8?B?REg2Ujc2cXg0UXJiekp0WWVSa0VTT1J6VW5tV0R0UkNXVm5XdXpsd3BCejd1?=
 =?utf-8?B?bnY3cXdtblMvNFZrZmFjek9ZYnZGMGxYeHNKdFlIZEtKN0VTR0J5c1JjT2xR?=
 =?utf-8?B?OThXWEkvVE9rTGJUcU9sOHo2czd1T1hOUEJwSXY3WG5Wb2ZRdExBemQyNUtw?=
 =?utf-8?B?RVhGKytJVkdpeXBLN2JkN0lsZE8zUk1mcXV2QWJuaTNhS3hhdWJMcnc4U0pF?=
 =?utf-8?Q?UKRrE+HQoaij7CNjmSFzo2yAs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTdTekJwVUpXZDhLaUt4d0RIdDVoUC9ORnozbGkrd2h5bmxIdE9HUjFTUE9p?=
 =?utf-8?B?NWdLWTlEZTNNOEpnY1dDaGFYZEZadExXakhRanc0UmpSMzRvb0U3OGpUaGhh?=
 =?utf-8?B?WFFjS1pXbFAwSDBjRTRhUHppbTc2Rk9tdUlFQ2daOEp4MmxKV0tRSHc5bzlQ?=
 =?utf-8?B?RWhBek10Mk9yelhqdDBCMGdvdTE3b2F4OXcxb0VHcnlOMVNyT00xZGJ6d3JH?=
 =?utf-8?B?MEtYdnNoanY0Nm8yNmcxcm9aQ1N1K2hUUndMeEFiN0I3REMySTdqMWZtbmZW?=
 =?utf-8?B?dGpYVytZRVlQeWRydXF1QWViVE8xYS9pZkllT0xFaml5OURRSHE1VlB0R3c4?=
 =?utf-8?B?V3diV0EyVE5WQlRybEJ2cnhsYmtqbGdiaUlaNjRwRmRMbSs4WmErSGJZT1I0?=
 =?utf-8?B?bHJLTm8xYWlHR3Ftd0FPZ2NhbmJzZkw2aEppN2F4M3QveUUyY3VFVFZmbHoy?=
 =?utf-8?B?cWVvYUQvaVNUclVEcTFaVmhBTEQ4NFdJZEZGYUVwRWxkTVZJM0tydlc4WUFa?=
 =?utf-8?B?M2phdHJhRTBoK1JUUWh0QjcyUDJRMmhVUUJMWng5WTNvREx0Mm0yKzF6RmpN?=
 =?utf-8?B?bkRObE1wMW0zM1dwRnUvblAvclpxZmtWRmh6Sk9EYS9vbjI0Mkk1S1A2YVBm?=
 =?utf-8?B?TTZtemYrcmdRL1d5NStGdjQyUmRadC83OTNSbFF1YjI2dVJJSkQ0b3NVSk9x?=
 =?utf-8?B?QUJ0YVZRckxqWUdvRFNCTTFScnd4bzB3U1BmR0NUakJseWFWbWIyMzdJNXVZ?=
 =?utf-8?B?ei9YMllURjNSQ2pOblBXbHJXUmxrems1TGdXZy90dTdtS254RStobkZzdkti?=
 =?utf-8?B?WnRhNWJPTTNFZk9NdkJWTlRTNzVEeDl2Ykh1d0pZN1VGRGdlSzhLTkV4TVFH?=
 =?utf-8?B?UTVNNVM4R2djbEhndVJjekhEUGpITng1UGhCV3cwSDRHL1ZQSytpM0FNZ09H?=
 =?utf-8?B?RDFlUDRNeWFvY3RHZSsyVE1PYUltek9XTUFLSGY1TFZZSHlBSmtYcExaeHdr?=
 =?utf-8?B?R0ZUMkltWU14dDhIUlVIUElVcjczcjJVSURMS05aNG9VM0djMWpJcTVtQTN1?=
 =?utf-8?B?SFVYWjZYdEZaN09keHBWV0RaMFo5RTRjZ3lYNDQza3BZUk15dkdtL3BJeUdG?=
 =?utf-8?B?YTRkYVNLbmoyNWFtdEphMXB3RUlYRW92OWJDaStaS1lmcWFISW9LZjdvbnZI?=
 =?utf-8?B?bzdBNGxXQjNJdFdHRldqSWt6TmF1SWJnZmI3ZnRqZ25OOFIydHgzVnFjVDdy?=
 =?utf-8?B?UFd4UktrREM5cmdoN2hQbUM4S2F4c0RFMVpKbjlDSXBZdW8zUjJTcUVkR09H?=
 =?utf-8?B?TEFqajZtUmJGZWYweTMwQXUyZmh6Wldpem9WSEQ5OGR4aTMrSjErakZPSG5p?=
 =?utf-8?B?T0ozeE5VelZiQTRlbGRwb2VleHN4Tk1WLzFMVDZpYXYxL2FnU3NRK2RnSFpr?=
 =?utf-8?B?c25zYWlSdFN0NU9ucDd2QVhRMTlDbkRjQTRCRHhMSkNaNGdXTHM2dUhUWjRO?=
 =?utf-8?B?ZnR1d0hmcG5ETzIwRng0VnN1L3VEazRnUHd5RTJoOEJ3dFFBd2lxVytobWxh?=
 =?utf-8?B?UldaZ2pJbG9NMEd2UGR4U0NnekFtMGEwdEE5MlB2WXZkMTl6RXpKLzlJUG1W?=
 =?utf-8?Q?z7IG3++ARbcmZXE61zDWY38FV4tTr+ErSuzvm+xWpb4Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a01ee4-9342-4296-debb-08dd82e20d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:42:34.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9396

DQoNCj4gT24gMjQgQXByIDIwMjUsIGF0IDQ6MjPigK9BTSwgYnJpYW4gbS4gY2FybHNvbiA8c2Fu
ZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3JvdGU6DQo+IA0KPiDvu79PbiAyMDI1LTA0LTIz
IGF0IDEyOjE5OjQ2LCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IFRoaXMgaXMgYSBwcm9ibGVtIGJl
Y2F1c2UgdGhlIE1lc3NhZ2UtSUQgaXMgY3J1Y2lhbCB3aGVuIHdlIGFyZSBzZW5kaW5nDQo+PiBt
dWx0aXBsZSBlbWFpbHMgaW4gYSB0aHJlYWQuIFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGZv
ciB0aHJlYWRzIGluDQo+PiB0aGUgc2NyaXB0IHJlcGxpZXMgdG8gdGhlIE1lc3NhZ2UtSUQgaXQg
Z2VuZXJhdGVkLCBidXQgZHVlIHRvIE91dGxvb2sncw0KPj4gYmVoYXZpb3IsIGl0IGlzIG5vdCB0
aGUgc2FtZSBhcyB0aGUgb25lIHRoYXQgdGhlIHJlY2lwaWVudCBnb3QsIHRodXMNCj4+IGJyZWFr
aW5nIHRocmVhZHMuIFNvIGEgbmVlZCBhcmlzZXMgdG8gcmV0cmlldmUgdGhlIE1lc3NhZ2UtSUQg
ZnJvbSB0aGUNCj4+IHNlcnZlciByZXNwb25zZSBhbmQgc2V0IGl0IGluIHRoZSBJbi1SZXBseS1U
byBhbmQgUmVmZXJlbmNlcyBlbWFpbA0KPj4gaGVhZGVycyBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBz
ZWxmIGdlbmVyYXRlZCBvbmUgZm9yIHRoZSBwdXJwb3NlIG9mDQo+PiByZXBsaWVzLg0KPiANCj4g
VGhpcyBiZWhhdmlvdXIgaXMgYWxsb3dlZCBieSB0aGUgc3RhbmRhcmQuICBJdCdzIG5vdCB1bmNv
bW1vbiBmb3INCj4gc21hcnRob3N0cyB0byByZXBsYWNlIHRoZSBNZXNzYWdlLUlEIGhlYWRlciBi
ZWNhdXNlIHRoZXkgYXJlIHJlc3BvbnNpYmxlDQo+IGZvciBtYWtpbmcgaXQgdW5pcXVlLg0KPiAN
Cj4gSSBjZXJ0YWlubHkgZG9uJ3QgbG92ZSBpdCBhbmQgaXQgaGFzIHRoZSBwb3NzaWJpbGl0eSB0
byBicmVhayBsb3RzIG9mDQo+IHRoaW5ncywgYXMgdGhpcyBwYXRjaCBkZW1vbnN0cmF0ZXMsIGJ1
dCBpdCBpcyB0ZWNobmljYWxseSBhbGxvd2VkLg0KPiANCj4+IFRoZSAkc210cC0+bWVzc2FnZSB2
YXJpYWJsZSBpbiB0aGlzIHNjcmlwdCBmb3Igb3V0bG9vayBpcyBzb21ldGhpbmcgbGlrZQ0KPj4g
dGhpczoNCj4+IA0KPj4gMi4wLjAgT0sgPE1lc3NhZ2UtSUQ+IFtIb3N0bmFtZT1Tb21lLWhvc3Ru
YW1lXQ0KPj4gDQo+PiBUaGUgTWVzc2FnZS1JRCBoZXJlIGlzIHRoZSBvbmUgdGhlIHJlY2VpcGll
bnQgZ2V0cywgcmF0aGVyIHRoYW4gdGhlIG9uZQ0KPj4gdGhlIHNjcmlwdCBnZW5lcmF0ZWQuDQo+
IA0KPiAicmVjaXBpZW50Ig0KPiANCj4+IGRpZmYgLS1naXQgYS9naXQtc2VuZC1lbWFpbC5wZXJs
IGIvZ2l0LXNlbmQtZW1haWwucGVybA0KPj4gaW5kZXggYTZjYWZkYTI5Yy4uYTE4ZTk3OGUyMiAx
MDA3NTUNCj4+IC0tLSBhL2dpdC1zZW5kLWVtYWlsLnBlcmwNCj4+ICsrKyBiL2dpdC1zZW5kLWVt
YWlsLnBlcmwNCj4+IEBAIC0xNjM2LDYgKzE2MzYsMTEgQEAgc3ViIGdlbl9oZWFkZXIgew0KPj4g
ICAgcmV0dXJuICgkcmVjaXBpZW50c19yZWYsICR0bywgJGRhdGUsICRnaXR2ZXJzaW9uLCAkY2Ms
ICRjY2xpbmUsICRoZWFkZXIpOw0KPj4gfQ0KPj4gDQo+PiArc3ViIGlzX291dGxvb2sgew0KPj4g
KyAgICBteSAoJGhvc3QpID0gQF87DQo+PiArICAgIHJldHVybiAoJGhvc3QgZXEgJ3NtdHAub2Zm
aWNlMzY1LmNvbScgfHwgJGhvc3QgZXEgJ3NtdHAtbWFpbC5vdXRsb29rLmNvbScpOw0KPj4gK30N
Cj4gDQo+IEFyZSB3ZSBjZXJ0YWluIHRoYXQgdGhlc2UgYXJlIHRoZSBvbmx5IHR3byBwb3NzaWJs
ZSB2YWx1ZXMgZm9yIHRoaXM/ICBNeQ0KPiB3b3JyeSBpcyB0aGF0IHdlJ2xsIGhhdmUgc29tZSBv
dGhlciBob3N0IChvciB0aGUgc2FtZSBob3N0IHdpdGggc29tZQ0KPiBvdGhlciBob3N0bmFtZSkg
dGhhdCBkb2VzIHRoZSBzYW1lIHRoaW5nIGFuZCB0aGVuIHRoZXknbGwgaGF2ZSB0aGUgc2FtZQ0K
PiBwcm9ibGVtLiAgRm9yIGluc3RhbmNlLCBpZiBJIHNldCBteSBkb21haW4gYHNtdHAtb3V0bG9v
ay5leGFtcGxlLmNvbWAgdG8NCj4gYmUgYSBDTkFNRSBmb3IgYHNtdHAub2ZmaWNlMzY1LmNvbWAs
IHRoZW4gdGhpcyB3b3VsZCBmYWlsIGFuZCBJJ20NCj4gY29uY2VybmVkIHRoYXQgd2UnbGwgaGF2
ZSBjb3Jwb3JhdGUgZW52aXJvbm1lbnRzIHdpdGggdGhhdA0KPiBjb25maWd1cmF0aW9uLg0KPiAN
Cj4gV2hhdCBJIHdvdWxkIHJlY29tbWVuZCBoZXJlIGlzIHRoYXQgaW5zdGVhZCB3ZSBzZXQgYW4g
b3B0aW9uIHRoYXQNCj4gY29udHJvbHMgdGhlIG1lc3NhZ2UgSUQgZ2VuZXJhdGlvbi4gIFdlIG1p
Z2h0IGhhdmUgImFzLWlzIiBmb3IgdGhlDQo+IGRlZmF1bHQgYmVoYXZpb3VyLCAiYXV0byIgdG8g
dXNlIHRoZSBgaXNfb3V0bG9va2AgZnVuY3Rpb24gYWJvdmUgdG8NCj4gZ3Vlc3MsIGFuZCBzb21l
dGhpbmcgbGlrZSAiZGF0YS1yZXNwb25zZSIgdG8gYWx3YXlzIHVzZSB0aGUgYXBwcm9hY2gNCj4g
eW91J3ZlIHdyaXR0ZW4gYmVsb3cuDQoNClRiaCBJJ20gYWdhaW5zdCB1c2luZyBhZGRpdGlvbmFs
IG9wdGlvbnMuIFRoZXkgYXJlIGFuIHVuZWNlc3NhcnkgY29tcGxpY2F0aW9uDQpmb3IgdXNlcnMu
IEkgd291bGQgc2F5IHRoZSBwYXRjaCBpcyBhIGdvb2Qgc3RhcnQgZm9yIHN1Y2ggcHJvYmxlbXMs
IGFuZCBjYW4gYmUNCmV4cGFuZGVkIGZ1cnRoZXIgYXMgcGVyIG5lZWRzLiBBbHNvLCBJIGRvbid0
IGtub3cgaG93IHRoZSBzZXJ2ZXIgcmVzcG9uc2UgaXMNCmZvciBvdGhlciBub24gb3V0bG9vayBl
bWFpbCBwcm92aWRlcnMgbW9kaWZ5aW5nIHRoZSBtZXNzYWdlIElELCBzbyBkYXRhLXJlc3BvbnNl
DQppc24ndCByZWFsbHkgaWRlYWwuDQoNClRhbGtpbmcgYWJvdXQgY29ycG9yYXRlIGVudmlyb25t
ZW50cywgdGhleSBoYXZlIHRoZWlyIG93biB3YXlzIHRvIHNlbmQgZW1haWxzDQphbmQgSSBkb3Vi
dCB0aGV5IHJlYWxseSB1c2UgZ2l0IHNlbmQtZW1haWwuDQoNCj4gLS0NCj4gYnJpYW4gbS4gY2Fy
bHNvbiAodGhleS90aGVtKQ0KPiBUb3JvbnRvLCBPbnRhcmlvLCBDQQ0KPiA8c2lnbmF0dXJlLmFz
Yz4NCg==
