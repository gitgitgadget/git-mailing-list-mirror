Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011038.outbound.protection.outlook.com [52.103.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1A1553A3
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465319; cv=fail; b=fT/oWd5Z8S4W2o77LhwFAtrJgRrCd9iQo/AolPEJETo70c/G1y7lWpozD88Grp7PN1ijlMMvdegM6tXXK1uTr7GJksGX2Mtfa4w01+465dO/UJMdqCvFUt/80izTLilutUa0cwg50czR6UazjJH5QW+DLB7di/ElEwYAZd10ChE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465319; c=relaxed/simple;
	bh=NWTyoFjHzGVEITk+k4OjihDTjUSI5MkRrPGfExcurr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iK9a90uS2tRjZvYMP3M6FvA8KvtoeSe3bboXoEylMHWdGNgmzxHFCStjjxMkeF2C1JPQ6bx6GJXCa25W/xdR9G/rLaLwKeJc+araw/6wyUnc2bKkkFApUIaSq21gNClidq7aC4vhb93PYeD58PVITTb1qp9lDZUVh/6jzzIWP5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aNqTWxOi; arc=fail smtp.client-ip=52.103.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aNqTWxOi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEGM6dpOf5fM+bmkGTQBHZ0M2EHQB5PnYq1ifwhc2a3nwLjjUPC/T+vhK1iHSGM7STN8pK6EB0klyux6PSj5Qe/UAgYkD6RWXIzWpTV/rN/ltbiI7URFobDl0PSYrWO2HuoyVk20HcIhg3Sze70KokePl6B9B8WaqszHGADaCKj54qWtFSgwhaiHmQttwmD67DtFgiHdmX4UpfaOqbwDVJNACJ2dGptYyzYXG4BeleHr56jqGT9gCAft0+CHIK2RxYNzwNsyaQ9jyYTjSfI/QHMGYpLwPpbbu0abCwfjyLNdX40aWtn2i2Glc5vCW1h2qCHjwT9lKN+WNfuXm2PGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWTyoFjHzGVEITk+k4OjihDTjUSI5MkRrPGfExcurr8=;
 b=An/NoKYK5CjKot0VazKRwHUosGgO1gB4cNu9ZL7MG33yTmTX/Ubx9LoqCqWkMfwDGKZte+dag+GxoDiNDyeeu3xUKnTt+8BDIeNw+sQReP+IXCRNsknr5fVAKcTz84OgfKVfJnF98SrAZCYOmk09sUmznl1XZs3j7vfUr+PW4PqZODQ5LQcnrmzTsvr6sIFyPEEWW1JNrLhODCydQMA80vOS26PaS8EcrJJG1I+FbeEH9Hjp6/fwCJli2xiegR8knt8GJHHEyo+x2NsX8x4iDRGc/qHORbWJUNRall6txfk9V9YVokI9p4R6XhN5/tQFir639XJ1Wcw4S9nBSqJpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWTyoFjHzGVEITk+k4OjihDTjUSI5MkRrPGfExcurr8=;
 b=aNqTWxOiTkvn08gEoILmExhMTlSsj7RHFa5h8aZ9lvxo0BscTG5hixjx9zP7hXyZUMzZLvQcdgz8Ick6nWt2BKQ57WKpps0ZwHg/xEC0fP+IONnC8T6QQ5JbpTkSpmXRkT9VnKQ6Lzyl00cnDazPRTo/OT0cxmeJ2FDhm9ma408iEV5s4q6tuwcOgoY6z5G4zZMOZTcKQQimk0UjeJyde5p2xOJFiJHfE0KyW+L03Sbtdvb3rpWlpr3X9A7IGW/C3Ev1StYkf9LeiTU8H1mjKsYgHCXrlTjPkMJmrmBGoTY+TrKFRITdb4VoBos4+sVkBI3wYszByrI6PMcU0PR0VA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9406.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 10:35:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 10:35:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Question: is there a short way to merge the last commit to the
 second last one?
Thread-Topic: Question: is there a short way to merge the last commit to the
 second last one?
Thread-Index: AQHb2KOPWyAfSXgC/0CQICcBf+4X97P5nScAgAAJYoCAAPRmgIAACCUO
Date: Mon, 9 Jun 2025 10:35:13 +0000
Message-ID:
 <PN3PR01MB9597E099CDCBEACF395866DFB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
 <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
 <bf6b2d49-d2c6-4197-99ae-06401093c8b8@gmail.com>
In-Reply-To: <bf6b2d49-d2c6-4197-99ae-06401093c8b8@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB9406:EE_
x-ms-office365-filtering-correlation-id: 48ed541a-5cbc-4e5d-56b1-08dda741511f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|7092599006|6072599003|461199028|19110799006|15080799009|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nm5yV0VoSG43eXZIc0FtdGFEU0ZqRGRvRjBYVUIxRDFIemdRRExiRXUvcG5N?=
 =?utf-8?B?TGhTMFVrazFmREorMnQzV3hRcjJicklVcFBGY1BUNExTTnFuN2d0OUFWc2xw?=
 =?utf-8?B?RU9SUVRsRmgwRFByaTk2ekh1S01kSnZpdXdBNHNJaVQxTTgvOXpObTBURm1i?=
 =?utf-8?B?U2JMMU12bzlHTUN3OGtPdXpROVFtSHZHenhxaVdhYUplVHZ1Z2hEQ1p3NDNM?=
 =?utf-8?B?bUdZby9aZmtGM3NuU21NTm12S3owdXFoQXFDUnFYT3pTSlBXRmIzZzRhOWhI?=
 =?utf-8?B?M0pvdFlRN0VJclRJUmp3NUZvWEpiNlpzWGtuQlZPMmtHYndZNGcxZ2dRYmJk?=
 =?utf-8?B?QUU0cjZSc3pzMUNFMkxBaEY0NkVIbllBRUtsOGNhbTdJOXd0RDhWd3NNSkZQ?=
 =?utf-8?B?QUhBUjIraThhbXp1VFRvd25iS1FjdmpSbmRob3BiS0ZnS25aNXhTRFJmZ3lN?=
 =?utf-8?B?RzZpWGpYUDZXc0RCanQyQ214MVl6V2QzUlovUXJ0eVBOc3BtTVJuTHZjSUpz?=
 =?utf-8?B?WG95ejFrenFLalVyVzc1c1I5SmVLaVlYaWdta2I0NkJ0aklJYzBCWGVxajNN?=
 =?utf-8?B?Rm9tcWxMQ0YzZTF5bWZNS2QvM2tncDUzcG5BdndVcktiWGQ2TkpWZTJ0empL?=
 =?utf-8?B?TXVHNy9QTjl4bGEraG8zQTY2S2xJMDB3Mmk0VmVjQ25pSnZqalJiY1Z2TkV6?=
 =?utf-8?B?QUVsSmw2em55REtzZ3hhcUVQeWczUmcrRWVUcDNuMEh0Ty84dFZqc3krVklB?=
 =?utf-8?B?QlVlbHNmWkthVHREVEJXaUxNU0dGcFZRZ21GeDltREg4eFNrNGQwWnVZUEJP?=
 =?utf-8?B?UEZMUVhKdmJLSnFvWFI0SnAwZUpIQmFXSlVwV01QS3kzaUdFQm5SNmpBTHBH?=
 =?utf-8?B?M2w2aWJVN3k0dlhVZ2Fua2dwUVFyM0NSUDk3a1JBMkRGNmRNMXc0Q2psTlly?=
 =?utf-8?B?ai9WYkJsK2wzMWVpZmh2aUI4NjQweDBvZ1F4U2dndTRBUjh0Q2NtbFJmeEV1?=
 =?utf-8?B?Y01KZUUyVUphVkFSdjdhZit0d25URUpXcGdHYTVKMmF2UVBwUHQ5NDlLTFBj?=
 =?utf-8?B?aVZoSnM4KytRdVBUWmh5R1RQc0FLMUROeUEwdFdMbFpJTUg4d3hRUEJYMmdV?=
 =?utf-8?B?ejVXR3VpMUZmM0k0dzQxd3NxYTFPdjE2VldlOXhaNzArQ01ka3JGNnFCZy8x?=
 =?utf-8?B?NHRDNWZad1ljYWMxVGxaWVRad0JoUERPdGIvVGM1cXc1d1BGS3V6Wk9PV0Iy?=
 =?utf-8?B?WXNRVjVseVlOazYwY2JsaTJvY3NUNXZDVWRqc1cxcHdKcmVSZjNqQjNhY05W?=
 =?utf-8?B?ckM4YWxRVVBadmp6SkJQT3I1ZnlxSjlRQ21heHZqdTdabzA3ZXRJRjkydUl2?=
 =?utf-8?B?Mk0ybDVISG84Z0srRW9Ia3YvLyt0N2F1ZHl5TmtBZTdZbS8vL2dCV1phZ2ly?=
 =?utf-8?B?dnA2eGtsaGNzWFVrSnJlV3hqVnJTWUlVQkdZQyszSjlpWVluNldiU28wOUpN?=
 =?utf-8?B?ZFJZU3pCTEtYdWhNV2VVTDFFdC9wYllIbWZZN1hQN0FnS3dWNkVHY2g2b2Ey?=
 =?utf-8?B?YXJqQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWFnSFFmTkZSMEpCbUhVUzhHcGUrWlV2MkRDdTUvQXM3ZlNIUjN2M0tlR3M3?=
 =?utf-8?B?SklyNWl0ZXlTWnNVeCsxOGdWeW4rSWtjKzBqcTJPRjNuVXBHVXRtVnpielJ2?=
 =?utf-8?B?V2FadTZCVVliSjUyZWxjaytwTmpTYzRNdzBxY0liaUp3bGlZalY4UjVqYU1J?=
 =?utf-8?B?V28yQ0szVGJYRFNHWktLN3I4MlRzM3E0ZFZsUC9SUEZtOC9FWmJUbVUzQzNX?=
 =?utf-8?B?c1lKdkg3UWNiSWR2WW5pYnNLYWZkeVVZMnR5WWZZeWkxQWZ4UFJJaTY5N3Jy?=
 =?utf-8?B?U0c0dHMwM1BYdXRjMno2bnBEQk0veS9XTy9jQlhEbTFQZ0dubWE3blg2RUZh?=
 =?utf-8?B?aDlMVXltYmFPQUJTL01KYXR5a1dZUW5PQmt0azlQSXZpMGdhOElQRFR6Sllx?=
 =?utf-8?B?VGhUakJ3TktRM2NPT0NCZ2R3ZHhjT3ZVVHZyMVYxVll1SmRBOWwzaUxOcmlt?=
 =?utf-8?B?eE52Z0lxUkZuMEljRFJsL1hXZ3U1RzRCTkVwZXIxTXJYcmMySzRaWDdUY2I4?=
 =?utf-8?B?QTdZK3BmVmRSVU0wcVQ3NnVmSWxHZ3IzWFFYajdMSVhqVlpldTQycFJ1empq?=
 =?utf-8?B?WlVHQW4xcUtNcXBQOHBEUmtGQklqaklVZ0xKSGVLRndQUnNhTnp0RENDYktl?=
 =?utf-8?B?TlNHRzNRSEtLNFBoY3BaQW5WaXp0My8wTytQSU9kd1o0UldNTitEVHhmaEcv?=
 =?utf-8?B?VTcwS2JDUmQ0Z2x6am9VWStWbnNiRE5jdENDTW92eDlvL2diOW9XMFA5TVJG?=
 =?utf-8?B?K1NxTDRnQXp4a0xpUFVMcWI0R1hTTkRrdC9meW56TGp5NVlhclE2L2tIZnpa?=
 =?utf-8?B?WENlTHJUTlBkNHN1WTB1Uy8wcjJtMjBDV0xaUTFrYzlVSEY1U24ralBXUHBK?=
 =?utf-8?B?Qk9uSWFwbFVxd0FJMll1eU5tV09vY1FCQ24yQi9SMXUxTWkyMy81MDJJZlZz?=
 =?utf-8?B?bWEzN21yLzJHL0crbFhOUUxHTzVBQU1BeldYdGhBdEliWWM0amI1anAxZzRW?=
 =?utf-8?B?ekZZK2xBYllkNmdIVFdENTVpbklVTkdPb3VURy9RZDU4ZXU5NDJMdDl2WW95?=
 =?utf-8?B?Yy9yVEhPTUY4QVdBVVVORTJjdnByZ1NlN2U2UjJmcE51MGJVWnVUTlhpUklX?=
 =?utf-8?B?c0tqYnFkSWxzQXkrajgyVGFOdmx3YUFEYU0xU3FBUXY2aFJnL3AxaTRLWUda?=
 =?utf-8?B?TEloMTJwRzU5MXorYnZUcWJ4VmljaUFrUjFWWGg0T2gyTXB2ckJvdGlqOHlK?=
 =?utf-8?B?VU9mN2dGZENlQ0xXMUNnaDV3U1JvblhLMVFCZTF6dzB5UXloZTAzdExkdXQ0?=
 =?utf-8?B?TkpOT0pKeDBvWGhKM1p6TnR3d0tIMTlNZWlPNlliMEoraTlPT2ZScFBabmp4?=
 =?utf-8?B?MGs0cVpueVVsM0UwQlZORkl4ckVRRE81K3JuTlRUbWU3cHhFR294WGRXdkph?=
 =?utf-8?B?MzI5anJ2N0pJWGtCVnYrVXFmTWlVYnFpVHNwaXhpN0N5SFowdHNlLzRHVzVD?=
 =?utf-8?B?MEordEZOSE90SUcxKzhyR3RmemJaUnQ5NUtCbStyc2VYNUE0b1haK2ZIekMz?=
 =?utf-8?B?c05pZUN3c1ViOURTVW96YStRSm41aWJtYUZGVGQ5UXQxVXR1b0xFK2syaEh0?=
 =?utf-8?B?aUhwM2FpL1BVaEkrK003emVOamlCd0hWV0dma0lCcjN4NDhSZDdwMGY1L0p4?=
 =?utf-8?B?SDdNOWlLYjl5QlA2RnBwTyswem5OOTRudDl6OWtHSWpjRHJzeEFaaHYwRVo2?=
 =?utf-8?Q?in3Rb31j6bvz6A8MsM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ed541a-5cbc-4e5d-56b1-08dda741511f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 10:35:13.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9406

DQoNCj4gT24gOSBKdW4gMjAyNSwgYXQgMzozNOKAr1BNLCBQaGlsbGlwIFdvb2QgPHBoaWxsaXAu
d29vZDEyM0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gMDgvMDYvMjAyNSAyMDozMSwg
UGhpbGxpcCBXb29kIHdyb3RlOg0KPj4+IE9uIDA4LzA2LzIwMjUgMTk6NTcsIGJyaWFuIG0uIGNh
cmxzb24gd3JvdGU6DQo+Pj4gDQo+Pj4gSWYgeW91ciBnb2FsIGlzIHRvIGp1c3QgZG8gdGhlIGZp
eHVwcyBhbmQgc3F1YXNoIGFuZCBub3QgYW55dGhpbmcgZWxzZQ0KPj4+IGludGVyYWN0aXZlLCB0
aGVuIHlvdSBjYW4gZG8gdGhpczoNCj4+PiANCj4+PiAgICAgIEdJVF9TRVFVRU5DRV9FRElUT1I9
dHJ1ZSBnaXQgcmViYXNlIC1pIC0tYXV0b3NxdWFzaA0KPj4gSnVzdCBhIHF1aWNrIG5vdGUgdG8g
c2F5IHRoYXQgc2luY2UgZ2l0IHYyLjQ0LjAgeW91IGNhbiBqdXN0IHJ1bg0KPj4gICAgIGdpdCBy
ZWJhc2UgLS1hdXRvc3F1YXNoDQo+IA0KPiBUaGF0IHdpbGwgYWxzbyByZWJhc2UgeW91ciBicmFu
Y2ggaWYgeW91IGRvbid0IHNwZWNpZnkgYSBjb21taXQuIFdoZW4geW91J3JlIHJlLXJvbGxpbmcg
YSBwYXRjaCBzZXJpZXMgaXQgaXMgbm9ybWFsbHkgcHJlZmVycmVkIHRvIGtlZXAgdGhlIHNhbWUg
YmFzZSBjb21taXQuIFlvdSBjYW4gZG8gdGhhdCBieSBhZGRpbmcgIi0ta2VlcC1iYXNlIiB0byBh
dm9pZCByZWJhc2luZyBvbnRvIHRoZSB1cGRhdGVkIHVwc3RyZWFtIGJyYW5jaC4NCg0KSSdsbCB0
cnkgdGhhdC4gVGhhbmtzLg0K
