Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D419D07A
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465356; cv=fail; b=FTw1chHBcY2EHEvBYVxv9FpXY561mUsx9A0IiCAzX7y6fnAprVQMjTNeLCcElZFzTk+XFak18K/1xY5dnt2Svrqf/nC2bjJ1NIyY+YHLjGo3eoweRFySgptz8XF1n68SJKj0JBmpMxBbZlbSOPrOAVveunbw16HPYvN0dOh4DU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465356; c=relaxed/simple;
	bh=GWc9WfryUmaPdeFFPs1V6c9ynNS493y/ly+Jw8ujywE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIkRR7MZ7LNUEYJhx7OTYULP3EPtO4GgUYES0sieluZWHfuYbaJ7fMZIZyvYSAjwAshe2gCUbN7WiBbPJQYZlYO2yplCQ83UTnqfyi5BX+NirVxuhzevJja8/wn5Ms9Dpd61WhyqsjxciB6kDhdz66vw72NIPIirjty8oYH2ZiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Q/K2R92C; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Q/K2R92C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR2NWSZvQMY/JCWhNnv1E8KPv8pRjRsJid+/TrFE7HaTnO/UVXlTAwCtlUPiGAhLg6lXdogkh3nsMJbIFY4jN2mm4+aaLWGdzRaKNpj6ptYo49kJpyBPA7lQ53MvqV/gsEwlpDwNGukbiuYNt8OhDPWYP3Vfl0i8WNWo94Vc9XCzNrayUiJ0/aiZXmcSnN4J2eww0Ty0sWk8Dv5tbIRijNPQOFFz79Sjosad3r2rDUfE3C6Yg0PqKowkPCA2TDBD03OsG6LqK6A+ZgdH0aPmejrH0v+TwKJoy1PEkI36GdlPCjMfAOYbaMuh532DIbuq2xgiSS3Xi7/RPbfar+7d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWc9WfryUmaPdeFFPs1V6c9ynNS493y/ly+Jw8ujywE=;
 b=Yt9XkCk3NE759zUyOjCjdtrnnYg3Y4A7vUhYzrgmcnWQnjYOuD0pwsTwnKSwqSDCYz1wR83RUvb45Q2tJrnmUGOwSb39a9gOe9FyDjko0IKfKipaH/f3YLZxGwvhkdH7OARcRga1dy0LavunCMBTH55K8+PUzrH+PhidlyOC8GaNiuQCb55qsAYK+eWdx0Vle+Rkz8Fl1L+BmmPf1i8U1cvThVLIg5GQOMFMsoqanN+1goTkuJxmoD2yZ9ce3qzBrXDULT/P9lHPw8LB7/5C9Xk4+ICY92o8PPU7LUK7RwQYtJEFA8+ew2EvqNE5e8idSIYIFQ0iC6KhbNwtg9801w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWc9WfryUmaPdeFFPs1V6c9ynNS493y/ly+Jw8ujywE=;
 b=Q/K2R92CzF3v4c+ZvXmWgJWV1dRi5JUOKWImf4ZW1lJLDyaipANxBXw/qMsiU7Ispr5/HTMYvO6lzxxw5P05WWOY+Qz9p2FtpQc9YRv5C4lOu+3sTqU06DnP03c4FWk0Z64i1A83AMlfc16an86KhdCTaxrgIB2fRaHniz6FSvFACsIlnwAcGV3oNWF6+m1nXiq1jx/XZIitLuZNFjUtDWbW1ZXI3hYIS0FrRlVNS19o/JcteX+T+J4Kzs3dGPjbJcYkh9GW/wNcI4ale9b0I9/xz0z91eI930o2OLM2mYjWUXXJaWaOaZvowEsrehEfyGAC0Kh7qZGNaOlbzno8Ug==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB5746.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:29:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:29:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>
Subject: Re: [PATCH v4 3/3] send-email: add option to generate passswords like
 OAuth2 tokens
Thread-Topic: [PATCH v4 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
Thread-Index: AQHbtEtR5ALx84NNEkKWcojXW6FDXrOxnFnFgACNJKA=
Date: Thu, 24 Apr 2025 03:29:09 +0000
Message-ID:
 <PN3PR01MB9597B700337C132A0FB053FFB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B50EF69AD097C594F844B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqwmbaya21.fsf@gitster.g>
In-Reply-To: <xmqqwmbaya21.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB5746:EE_
x-ms-office365-filtering-correlation-id: 44c3a408-ffbc-4f90-de22-08dd82e02d0f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|6072599003|7092599003|440099028|3412199025|19061999003|19111999003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3l0cGVtbGxCUGNndlZWUURvcVJUd3MwWlVCbXJocE1lWTV6V3pGaTBGWjNa?=
 =?utf-8?B?ZnNUcXhmRk4wVWVuSUlxLzN0ZlVvZHZqVXBzZ1NDSnUzVzRjL01YRlRrQkRL?=
 =?utf-8?B?a0pWVXY5Y2NwL3BSa0ZuT05YOHRrWmlVNURzZWdkdmF4cmNuNC9Zd3JpNXdM?=
 =?utf-8?B?cFpWT0Zpd0pTZmxpZmN1T0psekRGM1VCY1c1bndmOWxVMms5aldqRmNodzYw?=
 =?utf-8?B?QmFuTDFUZlRETU5QOVBWVUNaUERiS0ZoNUMzNHZvOTQ1aFZoYmIvVGtPS1Rx?=
 =?utf-8?B?azZqZ3RXOTdSSFlBRlYxWnNwZjBRcm0wditMOHNpRGdxSTgwOWdjQm8xcStV?=
 =?utf-8?B?bzZtNU1pTGI4dWQ3bmFYTWxWcHVqanlGYS9YaXVoMFd4cDVMa1pmOTUraDNP?=
 =?utf-8?B?anM5dGNTZldOSGJMdDl3YzQvcEVndkM0eUV0RDFHRDU2REVJbWErZ2UwZk4r?=
 =?utf-8?B?R0NTQURvYXd1YlZnS1V6UG4zK3FnbkZVdGVUU3RlcXRuRnJZK0lsRGZaajRv?=
 =?utf-8?B?VEloOWVTNHNKQWtyb0I2bFN0QWMxb3pCTDZGQVh5MUlkbGZwK1ppZS9hMEt5?=
 =?utf-8?B?Q2UxajB1SUVOcFZ4aStYbm9wMDZST3dpaFhGTGFoODB3aExTVWNSN2x0VzAv?=
 =?utf-8?B?dlA1RUJsNGxIbWRTRG4rWmIxeDAwK1RweisyTWJpaWdodDQvdTA5YkdEOVVU?=
 =?utf-8?B?S3B0NmJPZXBaaFZNTms2cGZtbksvdVNyNVA5aTFsVFdOZXVTS0k5S0VSemRK?=
 =?utf-8?B?NzhOa2pxRmZ1V094QjZYM3llaHdaK2FkclRUTC94WjNoR3VUQk5BeUFEdFhS?=
 =?utf-8?B?Q1NOM0Nvdmo1STg1aDNuWHJlY2xONzJiSlhTbklwYm1NaWJWQjBQelhQa1FS?=
 =?utf-8?B?Qk1WRy9PTmtCS1FqdjFFVHRQZEpjQmJkSmNhNnRCTjdIeWJSbFRCNFovY205?=
 =?utf-8?B?QWhSc3p0cng4cUE1U3BaR1JrRG84ZTNjOGF6VU1yU3hWVGJrelR5NzFCUm0w?=
 =?utf-8?B?QURCODM5YiszYjZrYXJqaVZNZURoWUdFNjNJa1MzNTk1WENRT3Y4Qmh1Tk9N?=
 =?utf-8?B?dytKVUxNeVpZMng2cTNua3FMVFZHNWRHaFVPMWY5U3FuT0ltSFRoeHZ3WWxV?=
 =?utf-8?B?cTZ5TGxGVE9yZlFrQXc4VE13ZFZRV3ZmWEUxbXhGV3VRM3ZPVGFwcy9TYTRh?=
 =?utf-8?B?NmZuWjVvcmhUUEZRSTB6V3hkeWN6Q0dLb1VjLytNaGxjUDJkM2pFbzRqNFdz?=
 =?utf-8?B?bTJDT3dMcTZ1Wlk2dGlSRjJDM0t6NTBXSXFuS1Q1ak5sV0VQZ1VEVlRvdTdm?=
 =?utf-8?B?SUVOdjlndExWU2d5bytxaDdsUkNFTkp0OTdpVVRzekxtWjBjUXBIcDBnSjVE?=
 =?utf-8?B?ZmdrTnJTajhkWUE1dmNTaGl2cDlBVFBPWEtGYVozT09xeGhmNjNGSkcxNDBm?=
 =?utf-8?B?OGltVll4dEhoNGpFYkk0NlhjUDhwVVBZYmx6NCtMMjBzK2ozZ2RBUlhLT0w4?=
 =?utf-8?B?QkhhdjNwQ3V2YVZQcDg5cUhnb3IvRHZQRWcySVBydjJ3M3B2b0pXdTZFc3Y4?=
 =?utf-8?B?S1VvdWRWd0hwWkZlRTFGVkdaTkx5bmVkdHZqUHcrMDlwMElDbjN5bWg3R2hw?=
 =?utf-8?Q?SqhGOTJUoq8EtdcPToQ5x31RNf1mPBuhhN9bXUBOrN7g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2xtREo3MkRYM1dtVm0wMFZJU01UZUpldWpHbWJKMGU1TXcvM2tjQThIdU9R?=
 =?utf-8?B?eUxpaXpwYk9FK0lQM1FqbzJWUlYvRlExVjFkY2dlNUpDL2N1R0V4Q2hnb1Y5?=
 =?utf-8?B?c2YxNjlWSW9UOXlNQ2taNitrbGxlWGdMeU1yRnZvcWZSSnBMUVFabEdNQVRL?=
 =?utf-8?B?WS9ELzR3bW1ZM1cya2x5TFZyajJrVUtzS1ZGSHhhRU4xV0c3KzRrRUJIUDM4?=
 =?utf-8?B?bTBuQnZyQlJBZkswc1JMOWgxRGJSUjc2Q1d0cURxRXlacFdXSGtsUjFXaW9u?=
 =?utf-8?B?S2tsS0VZbHAvdnNibkNERGJsTG01N04rUVE5UFhjRlF0K01IL1RZVTJVN2tM?=
 =?utf-8?B?SlVWYzdDdzJaUDhtUmpSRWNyZmZuMWZpY3A2TkM0RmFSdUlZOU9WaldDSzZI?=
 =?utf-8?B?N2NON3ZFWU9Va1oxOXlJYmFGWmFYaFIrNEtGdWs3LzRlNG5mNm5XVjJpNDBU?=
 =?utf-8?B?ckJYYzZMODdyeFlIa1EzUWExc1pub1BuK3JWZUoxVjhlVEw4Mi80TmlQV3lr?=
 =?utf-8?B?S0JCVXpiclVuc096aEMxRXFDaGdDQm9uNkw2MTBHWGgveDd1UVExUGtiUTg1?=
 =?utf-8?B?Tm00KzR1S1ZicDE2dG9JUjdXQm9abVN6V21BQjJGVDhXMHZNMHcwaVBWYngy?=
 =?utf-8?B?WVl0Wlpid0lWazMxT0J5UlIvVzBjQU93L0VEeEMraXppa1lDMFdaUHZJekRM?=
 =?utf-8?B?dS8wZ2Zvbkd0N0dWRVB2cCtiK1gvdUpGQStwcUxzTW0wSWxvak90czJzR3VV?=
 =?utf-8?B?Qkl0QmFKUkFQWW54aXZ3a1Z0OFV0NlpZTUFYRFhGT0I4L1plYmhUamdmMGMr?=
 =?utf-8?B?VURSR3lSSDJlVjBjWkJraHFvaHpSanFsdFlFMWpTa2dYOFpTTmN4dmRERlpB?=
 =?utf-8?B?eVNPVFo1L1Z4TENFWVoxRVZkSGpLWXJRY1JJaWJBRkVyekJKbVhGdGpUQU9t?=
 =?utf-8?B?RzNpNG1GTjA4TlZldFkyU3p2NmZLRWFBOUxreHhiMkVVek9MZ28rMFcyZk44?=
 =?utf-8?B?RXpERUQ2VnhHam9qUGdHOC9wdEsycWlQWDNiUDZJczU5WmZWUk13UmJuSmtC?=
 =?utf-8?B?WDVhdHQvSkxxbUFhRngwRE1JcURqMUpGSGNXcjBQcUs3S0hmYmwxSUxjbXNR?=
 =?utf-8?B?WktJVUUxS1lUMkcwcC95TjRPS0JGQ3ByVHF0NXJzSkVCWU5pOVNzcDlncisz?=
 =?utf-8?B?bVdVcW1BNS9JWk9nQkJVNlVJN0hTb3NVZS9aSVRVTzFReEs5QUl5RWNGelp3?=
 =?utf-8?B?dzFpRUIxdm1GYUl4Q3Z6OWRFWWJhbVBVeVIxZ3h1eTF0b1dKN0JBOE5vcTdM?=
 =?utf-8?B?Qys3NU1MbkpmT1FrbzVZYzE2TzdDc0x1YWh2ZDlEb3pRWWtjUk1TRWdwdFoy?=
 =?utf-8?B?VGdKaEVMSWR1aVhwcWF6WjBSOXJsMWJLbzd2NHRjM3JiRUpCNnI5SnJ2eDBR?=
 =?utf-8?B?NFA0N2YzL0pWakNveDVTQjVUeDQvNE5iV0pPYmpwMWVOM0RSMm52UFcvUVJJ?=
 =?utf-8?B?a2NnUEtYWmJLSCtoM2lYMUlFVStkM3pEajQ5Sys2UkgzOUtCQ1BGVndtRTkv?=
 =?utf-8?B?NmdGME91bWZBWEp0Mi9Uc29CQ0hJemZxZ3VYYWUraG4wNXkvL1hjQ1FlQjBu?=
 =?utf-8?Q?vM4//aCaBRnAr/Xjm0hTNJUlBRpcf+f9DuG4mOry2Vaw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c3a408-ffbc-4f90-de22-08dd82e02d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:29:09.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5746

DQoNCj4gT24gMjQgQXByIDIwMjUsIGF0IDEyOjMz4oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gQEAgLTIzMCw2ICsyMzAsMTQgQEAgb3Igb24gdGhl
IGNvbW1hbmQgbGluZS4gSWYgYSB1c2VybmFtZSBoYXMgYmVlbiBzcGVjaWZpZWQgKHdpdGgNCj4+
IHNwZWNpZmllZCAod2l0aCBgLS1zbXRwLXBhc3NgIG9yIGBzZW5kZW1haWwuc210cFBhc3NgKSwg
dGhlbg0KPj4gYSBwYXNzd29yZCBpcyBvYnRhaW5lZCB1c2luZyAnZ2l0LWNyZWRlbnRpYWwnLg0K
Pj4gDQo+PiArLS1zbXRwLXBhc3NldmFsWz08Y29tbWFuZD5dOjoNCj4gDQo+IExvc2UgdGhlIHBh
aXIgb2YgW10gdGhhdCBtYXJrcyB0aGUgdmFsdWUgb3B0aW9uYWwuICBDb21wYXJlIGl0IHdpdGgs
DQo+IHNheSwgLS1zbXRwLXVzZXIgdGhhdCBpcyBkZXNjcmliZWQgYXM6DQoNClRoZSB2YWx1ZSBp
cyBub3Qgb3B0aW9uYWwuIEl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBsZWF2ZSB0aGlzIGVtcHR5
IHJpZ2h0Pw0KPiANCj4gICAgLS1zbXRwLXVzZXI9PHVzZXI+OjoNCj4gICAgICAgICAgICBVc2Vy
bmFtZSBmb3IgU01UUC1BVVRILiBEZWZhdWx0IGlzIC4uLg0KPiANCj4gYmVjYXVzZSB0aGV5IGFy
ZSBkZWZpbmVkIGluICVvcHRpb25zIChiZWxvdykgaW4gYSBzaW1pbGFyIHdheSwgbGlrZQ0KPiBz
bzoNCj4gDQo+PiAgICAgICAgICAgICJzbXRwLXVzZXI9cyIgPT4gXCRzbXRwX2F1dGh1c2VyLA0K
Pj4gICAgICAgICAgICAic210cC1wYXNzOnMiID0+IFwkc210cF9hdXRocGFzcywNCj4+ICsgICAg
ICAgICAgICAic210cC1wYXNzZXZhbD1zIiA9PiBcJHNtdHBfYXV0aHBhc3NldmFsLA0KPj4gICAg
ICAgICAgICAic210cC1zc2wiID0+IHN1YiB7ICRzbXRwX2VuY3J5cHRpb24gPSAnc3NsJyB9LA0K
PiANCj4gdGFraW5nIGEgc3RyaW5nIHZhbHVlID1zIHRoYXQgaXMgbm90IG9wdGlvbmFsLg0KPiAN
Cj4+ICsgICAgR2VuZXJhdGUgcGFzc3dvcmQgbGlrZSBPQXV0aDIgdG9rZW4gZm9yIFNNVFAgQVVU
SC4gSWYgc3BlY2lmaWVkLA0KPj4gKyAgICBpdCB3aWxsIHVzZSB0aGUgb3V0cHV0IG9mIHRoZSBj
b21tYW5kIHNwZWNpZmllZCBhcyBhIHBhc3N3b3JkIGZvcg0KPj4gKyAgICBhdXRoZW50aWNhdGlv
bi4NCj4+ICsrDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQt
c2VuZC1lbWFpbC5wZXJsDQo+PiBpbmRleCBhMThlOTc4ZTIyLi5jYWZiOWFhNDNiIDEwMDc1NQ0K
Pj4gLS0tIGEvZ2l0LXNlbmQtZW1haWwucGVybA0KPj4gKysrIGIvZ2l0LXNlbmQtZW1haWwucGVy
bA0KPj4gQEAgLTU5LDYgKzU5LDggQEAgc3ViIHVzYWdlIHsNCj4+ICAgICAtLXNtdHAtc2VydmVy
LXBvcnQgICAgICA8aW50PiAgKiBPdXRnb2luZyBTTVRQIHNlcnZlciBwb3J0Lg0KPj4gICAgIC0t
c210cC11c2VyICAgICAgICAgICAgIDxzdHI+ICAqIFVzZXJuYW1lIGZvciBTTVRQLUFVVEguDQo+
PiAgICAgLS1zbXRwLXBhc3MgICAgICAgICAgICAgPHN0cj4gICogUGFzc3dvcmQgZm9yIFNNVFAt
QVVUSDsgbm90IG5lY2Vzc2FyeS4NCj4+ICsgICAgLS1zbXRwLXBhc3NldmFsICAgICAgICAgPHN0
cj4gICogUGF0aCB0byBzY3JpcHQgb3IgYSBjb21tYW5kIHRvIGdlbmVyYXRlDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhc3N3b3JkIGxpa2UgT0F1dGgyIHRva2Vu
IGZvciBTTVRQLUFVVEguDQo+PiAgICAgLS1zbXRwLWVuY3J5cHRpb24gICAgICAgPHN0cj4gICog
dGxzIG9yIHNzbDsgYW55dGhpbmcgZWxzZSBkaXNhYmxlcy4NCj4+ICAgICAtLXNtdHAtc3NsICAg
ICAgICAgICAgICAgICAgICAgKiBEZXByZWNhdGVkLiBVc2UgJy0tc210cC1lbmNyeXB0aW9uIHNz
bCcuDQo+PiAgICAgLS1zbXRwLXNzbC1jZXJ0LXBhdGggICAgPHN0cj4gICogUGF0aCB0byBjYS1j
ZXJ0aWZpY2F0ZXMgKGVpdGhlciBkaXJlY3Rvcnkgb3IgZmlsZSkuDQo+IA0KPiBMb29raW5nIGdv
b2QuDQo+IA0KPj4gKyAgICAjIElmIHNtdHBQYXNzRXZhbCBpcyBzZXQsIHJ1biB0aGUgdXNlciBz
cGVjaWZpZWQgY29tbWFuZCB0byBnZXQgdGhlIHBhc3N3b3JkDQo+PiArICAgIGlmIChkZWZpbmVk
ICRzbXRwX2F1dGhwYXNzZXZhbCkgew0KPj4gKyAgICAgICAgcHJpbnRmIF9fKCJFeGVjdXRpbmcg
dG9rZW4gZ2VuZXJhdGluZyBzY3JpcHQ6ICVzXG4iKSwgJHNtdHBfYXV0aHBhc3NldmFsOw0KPj4g
KyAgICAgICAgY2hvbXAobXkgJGdlbmVyYXRlZF9wYXNzd29yZCA9IGAkc210cF9hdXRocGFzc2V2
YWwgMj4mMWApOw0KPiANCj4gSG93IGNhcmVmdWwgZG8gd2UgbmVlZCB0byBwcm90ZWN0IG91cnNl
bHZlcyBhZ2FpbnN0IGEgYmFkIHZhbHVlIGluDQo+IHRoaXMgdmFyaWFibGUgKGxpa2UgInJtIC1y
ZiAkSE9NRTsgcGFzc3dvcmQtY29tbWFuZCIpID8gIEFyZSB3ZSBPSw0KPiB3aXRoIHRydXN0aW5n
IHRoYXQgdGhlIGNvbW1hbmQgbGluZSBhbmQgdGhlIGNvbmZpZ3VyYXRpb24gZmlsZSBhcmUNCj4g
bm90IHVuZGVyIGNvbnRyb2wgb2YgYW4gYXR0YWNrZXI/DQoNCkkgd291bGQgYXNrIHRoZSBzYW1l
IHF1ZXN0aW9uIGZvciB0aGUgc2VuZG1haWxjbWQgb3B0aW9uIHdoaWNoIGFsc28NCmludm9rZXMg
dGhlIHNoZWxsLiBJZGVhbGx5IHdlIHNob3VsZCBiZSBhYmxlIHRvIHVzZSBnaXQgY3JlZGVudGlh
bCBtYW5hZ2VyLA0KYnV0IE1pY3Jvc29mdCBoYXMgb3RoZXIgcGxhbnMuIFRoZXJlIGFyZSBub3Qg
dmVyeSBnb29kIG1ldGhvZHMgdG8gZ2V0IE9BdXRoMg0KdG9rZW5zIGZvciBmcmVlIE1pY3Jvc29m
dCBhY2NvdW50cywgc3VjaCByZWxhdGl2ZWx5IHVuc2FmZSB3YXlzIGFyZSBzb21lIGVhc2llcg0K
b3B0aW9ucy4NCg0KQXR0YWNrZXJzIHRoZXNlIGRheXMgY2FuIGFsc28gZ2V0IHlvdXIgYWNjZXNz
IHRva2VuLCByZWZyZXNoIHRva2VuIGV0YyBmb3IgT0F1dGgyLg0KVGhlIHVzZXIgc2hvdWxkIGJl
IGF0bGVhc3QgYXdhcmUgb2Ygd2F5cyB0byBrZWVwIHRoZWlyIHN5c3RlbSBzZWN1cmUuIE1heWJl
IHVzZQ0KTFVLUz8gQW5kIGNvbW1hbmRzIGxpa2Ugcm4gLXJmICRIT01FLCBJIHdvdWxkIHNheSB0
aGUgcmlzayBpcyBlcXVhbCB0byB0eXBpbmcgDQpzdWRvIHJtIC1yZiAkSE9NRSBvbiB0aGUgdGVy
bWluYWwsIGJ1dCBpdCBkb2Vzbid0IG1lYW4gd2UgcmVtb3ZlIHRoZSB0ZXJtaW5hbC4NCg0KPiAg
SSBhbSBhc3N1bWluZyBpdCBpcyBPSywgYnV0IHlvdXINCj4gZm9sa3MgaGF2ZSB0aG91Z2h0IGFi
b3V0IHRoaXMgY29kZSBwYXRoIG11Y2ggbG9uZ2VyIHRoYW4gSSBoYXZlLCBzbw0KPiBJIHRob3Vn
aHQgSSBzaG91bGQgYXNrIGp1c3QgdG8gbWFrZSBzdXJlLg0KPiANCj4gVGhhbmtzLg0K
