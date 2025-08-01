Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013080.outbound.protection.outlook.com [52.103.35.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0451AAA1B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071130; cv=fail; b=Tjh2DLgMzssoqy+RMD79JStye/CmzzUmdAKQZincSwb67b9Edor9N5bmlOgmciUmSamIKIfVeAv5lC3t/BwvUS0GaR40tnHwpH8dYUKDjSFPb8IMvJxJSkFxtgH5DD1j5T/pVNT8ArJlR1K6jAF2L7EsJTFti+3GJorxiTsKqZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071130; c=relaxed/simple;
	bh=c9UMW7QBH8DiJRx/i7vrMTLY1mWxw1zgF5UUhazDLUs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JaDJMlnrkVcd4fjNQn/YqW8G5pm6fecZOWzU97b9pY81mUayzWg942h5aU9KUxcBzvOROjaciE0Swb3QVaJabQhESwxW5BvS0S2ABMy0zbyZlH0jtBtfrHYBwuPD7HbfV/52kGZNfJO1S6vq9kWQUohQfxIXn6hOdNk4TfKJh5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=I13e8uKD; arc=fail smtp.client-ip=52.103.35.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="I13e8uKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhZqJtRPS8QsIOH/5sIoU57IMm4IGaq0utvCP4jHs7BMFaR2ulmrY8cEpaXF11f5650kV4IbmxTWhUBjJXg8rPIrz8Rn4jI2eJCVk3Avg3vpe3Kav8komQA2TjU4wamUMcLZDughrxMPcmgMtdHARD20hxb2/0sh3wzUWccTiX0BeLlQfdV0VB7D6PQFTLYkkzTaa4PuyZNCelj3uZCAU78q9c0tfExkOp01CsMHrlzfh0y6ArmTPIg44ryUA3FGLsQ21GVuUuBMcUspxQ3VC/eezmxjd5iSyJg/V6DKLogNgr8Zk4NRglUTWz01ZwrlL3e3XK2zgrGKfFihNo5EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9UMW7QBH8DiJRx/i7vrMTLY1mWxw1zgF5UUhazDLUs=;
 b=UekOpPB9sLgIo8pCKE+7p7ev8g+mtgkU8/Z5rPReEc3/XTORV3fkBhU8gnse2uQ8U1WeuLb7HUmy9SQYY7QNU3f+s+lGYrC+nyUp4YSrGWeBWM7O15FKQ9d2z7xRdpFmWEDfw134KkVKW3dAr/XuKeT7GMPD2dfYLP/moQkkWx0ZB5y3ecWspWvedY3RDK0D28ee31KOckifSetTCAPYt22phEZaKVqjnjU5KNvPeUip6AICTJXklly29OoP5PX3p/PA2Hblu4Df1U9ncTdx6YiicyC4WpmoFuP9lStiCzR2W259agrGq/JWnaTeRkE6D9YNj5Q0DIUw8niAYcfxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9UMW7QBH8DiJRx/i7vrMTLY1mWxw1zgF5UUhazDLUs=;
 b=I13e8uKD6iH0mt5UXpFx1l1u+9s6KegIN9AxjaWMZQfne5xhrms5acai2/D4+tIm6n+0OSIVRHUbSuVsmy3VDBKjm42mPzm2ICzfekQVYSqoOGAncHrlnYrHynLO4NQ/G6yt5YPmcrAIkUxgmFn9Zv2FUUyVk7SZJrYuuY6QePAZGRTgwHDyNIkV25wkI1u7Ynt0tn8YOy1mtyWFl10ETG/zJjmNDQ7nxMtRPSbt7ztSeCSrceWUJ2q7jEappuRRdj+ESNSIkGvSkhpQ9qGZEIfAMlNdJ/n8rY41CZvyAHq5IKPXlEgGrw+thZZIHXPQpshSKFA1DihhDknVhJGB2A==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by DB4PR02MB8774.eurprd02.prod.outlook.com (2603:10a6:10:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 17:58:46 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Fri, 1 Aug 2025
 17:58:45 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Minor issue: "git remote rename origin skybuck_repository" removes
 comments behind refspecs in .git/config
Thread-Topic: Minor issue: "git remote rename origin skybuck_repository"
 removes comments behind refspecs in .git/config
Thread-Index: AQHcAwxW/d496VSvyE+ZTLwfGU5QZw==
Date: Fri, 1 Aug 2025 17:58:45 +0000
Message-ID:
 <DB7PR02MB4265AB8791FADBBC5968C74BB326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|DB4PR02MB8774:EE_
x-ms-office365-filtering-correlation-id: fa140269-e7f6-4f74-9fb4-08ddd1250f65
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|461199028|19110799012|8060799015|41001999006|31061999003|15030799006|15080799012|40105399003|440099028|4302099013|3412199025|26104999006|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckNyQyttcDNaK0l6ck9SUUxOZXNTVEpJKzF5eUdSWDFwTFZTWVhpOWR3ZWhF?=
 =?utf-8?B?SzNjaG5zeFFnRWcxeDdXZGdQMWQwcWROdE9lMzFjNm1XVllOSzV6M2VVSU9R?=
 =?utf-8?B?R0JJSHFpNEtnOU1nZ04yTUMyWHBzMUdMcm9tbzVEKzhRVmJrUitxNXFESUJS?=
 =?utf-8?B?YVdSSVNva2NVT3UxNUx4M3JkUDkrNHBWbXlLQkJONXY4NEl5eVo4WVN5Rzln?=
 =?utf-8?B?UmprWEYvSm4vb0MwNnhVY2ozM2lFeDZ0bmxxWFg5Q3dGbVZjZE1YRmxucDhL?=
 =?utf-8?B?cU1kR1B2U3RZYWZ1b1M2dm1aVnAwR2t1U0ZRcmtabmp3c0ZIdWJIUVU3Sktv?=
 =?utf-8?B?L0ZTRUxvUFFIbnRxbFBVM1RjRTZMTGFlcWtFY0RLRDdSc1lsVFVaZFVlT21t?=
 =?utf-8?B?RTg1ZkFQTnhWSVBRb2R1ek5wNlB2NUJTaVZXYld0cjBZSCtOdHVxL01ZeE5n?=
 =?utf-8?B?Mkg3b0JXb2VjRTlSdEZ5Sk5aMTg0UllkVWJTT0VnYkpnckpuN0JkTkVCUjV2?=
 =?utf-8?B?WitxSmtSeS9FQW4yM0VEalU5WXB4MHREbHc4amVDaSt5bVptTE93UTRDTzJ5?=
 =?utf-8?B?cDRHK21MYjJwMERScURxNEE1WEd4VHNTUUZJaERmajZXUmdWUk1xRldvbTIy?=
 =?utf-8?B?REcrUmtJcEtTK09mUGJ6eVFjNXJxYVFvVVY1Y2d6YVJwMUNNaTlTWkVWM3ZO?=
 =?utf-8?B?NmpYSkE1cjJ2eE91dzBITkdRYlRhV1lyMkVkL2JBSGlnNDArMDZDNlloQzRo?=
 =?utf-8?B?L3lrdEgxOEdTMUQ5eXhmaVpTOVFrd2NtVjVDZ1BiRXVjSFhCMDV6a1VGT0wr?=
 =?utf-8?B?L2FsY20ydFE4UG1DTXlocVNuTlc1MnBaUFdPR28zTlN0K0ZuUHMyaURTZGh1?=
 =?utf-8?B?RllBNnRERkVUa1NEdWNIbkVHOGd2SkxxdUgrN3Y2Z2cyR242blVidW11aW1q?=
 =?utf-8?B?TExxc1FLY0I3ZWg2eko0UXk1OGtsVStZWmkrbDZ3Y1hEcVJHc0x1aHI3Zklx?=
 =?utf-8?B?bmpmbERjRW1sRnJOYVJVcktnTnB0TGk0UzlxcUtNKzdHVmVLbXdnbU9pM2hU?=
 =?utf-8?B?WEpTUER1Z09DM0Nub3VMR0lLNGJEL2dVeEw1SjJOOStxVzJ4UHNRS0lEMm4w?=
 =?utf-8?B?L2UybHVqWVpac3FXeEE0Z2tFcU5oS3RZbmRDMkpMTGEwOTFDMEt4WllQZlZX?=
 =?utf-8?B?UnYzd1ZDL3JseTNpek9DWVMrQVZVM0w3NEt6OG5GclcrRm5ZZ3lPYTBYbzVw?=
 =?utf-8?B?TkdpRUlxTXEwTk9kaFVQdlF4bU1oYTNTclJPNm5UbGJoM3NmNjNUNmZ0L3o3?=
 =?utf-8?B?akQ3VFh2Si94eWpiOWkvbFpuU3ZvaXFkNGg4UkNLS2tVTTZjblM2RDNhY1Jv?=
 =?utf-8?B?TjFjYkkvMEtJS3ljWW1vK25iSnROSmdUeXBsS0pGRU5BaDh5Q0dRdnFrV1po?=
 =?utf-8?B?eW93M0p5MFlET050R3dWb3IxYTJPcm8rU0VqeFpYT09MRkRsejREaUs4QlN3?=
 =?utf-8?B?UjY2cmd3ZVIvQUQySTlYbmdSTjd3V1M1ZExqbm0xMndrcnRHdlhTWEVMaVNY?=
 =?utf-8?B?S0RCcWlCRXFJc2JZQU9TbVdIa1kwb2s4dnQyNk9wTFFSVWVkaXNOT0ZEbGNI?=
 =?utf-8?B?WHFLOWRDc0Rkeld3WEMyLzl5SWZQc0d6VmRIT3VNNjNzQWZRRWRmZWJqcUpD?=
 =?utf-8?B?Q2IzQWZOd2kwM3YxWE5tWlNYdnk0c0ZYVU5RTWpjRkY0cmpjUnp2R0xmQU9X?=
 =?utf-8?Q?sGmY77rBzgjfaLxvH/CW6v9i7xhRiTFPI+znNbV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUVsY1lHZ0l6RURvNUZGZ1lpRWgrdGNGaEY4ZmxLdFhQRDBjMVM1Q0Q1cmUw?=
 =?utf-8?B?eDkzc0lXU1BTWEtqMFl1aUFOSVIzem1sT3BMRnJjQ3Q5K3hkMHRnSEdhamNh?=
 =?utf-8?B?d0J1MUxGVjkyUXRjcnBSeTZBQmVWdXRESzVFNlJlVVpQalltaXkzTmUxdnpH?=
 =?utf-8?B?cCtTOWR5cDJKZ0FKaVZmYmFaNTcwVVl2R1doL1E2Q2F5WTZKL0hqZUhxMElG?=
 =?utf-8?B?bEkwWXU3eU95Z1hJVFFPM29PRmRRQitHVHhnQllGRXAxUlRpSUtwc0dCaWdE?=
 =?utf-8?B?R2s2TmJJK2tIZVZIYThSK1JCelFkQzVRZThGYkV0ZzFLRjlCZXVVaFJ1RWV4?=
 =?utf-8?B?T2FGYnZtNllJSHdvY1ZoODNkMU81WmJtK3o3Y1pjYnRPNmtlOEV4elpDMVRj?=
 =?utf-8?B?ZVN2RlR0Q05CZlhsUnFzU1FOeEhjS0tjakdzaHo4Y0RkMjR0RlJUcEp5SjFO?=
 =?utf-8?B?MFNJaUh0eTBUdGpoOTRjblRreXpGblkvbTllNzlDVlpQYjJYY2JielF5Y2FY?=
 =?utf-8?B?S3BoS1doOGkvVlp4dFJSUjU2SDREZUlkOHQ3aStGSzJ0R1hiNUpTbjZDZG8y?=
 =?utf-8?B?MFQzZ2Y2dzBjT0cwd1Q0SGRKOGk0VXZ4THdQemhibEpDeDdHZHlMMml6cjNh?=
 =?utf-8?B?ZG9NbHJsWU1sQytFOVJvWExkQVViTlhvN3ErTkp5MTdGYzhyNmVCL2JuNVVP?=
 =?utf-8?B?VUt6bWc3WENFbGEzUFp6c29Rek40Z2dlM3hZaVhQaVNzRUFOcFhFNXZIQzMy?=
 =?utf-8?B?MkxVdC9hUGJjYk0wUjFIc1J1VmVqSWxKaEhYdG9iYytZZ1g0cmRvNHNQUzVP?=
 =?utf-8?B?UXkrcnRDVXFiZ0k4VWUvcjVBUUUzaGJNMUQzc1ZQcnE2dXl6TW1HS0dmUHlx?=
 =?utf-8?B?aHRmYlA5dWlGWFlaT1BxR2Fack80ZFlmSSttMGN3MXBTTXY0L2tZbVFBYnRw?=
 =?utf-8?B?TDFxQ1lvWnRBc2hBajBiSlczSWtUTUp4emNXS1p6SU1NSGxLd3pFREdnSjIy?=
 =?utf-8?B?THRyUFRUbjBvMFV3SWEvMmRNMy9ReE45b2k5Q2UxOFRMUkNvdWloREhCZ2pj?=
 =?utf-8?B?bW1RWXE4L1ZQdnhFc3c1NENxRHRITndCN3QvK1Z3b2ovaENoMTJINlF4blBj?=
 =?utf-8?B?S2VrOG8ycW1sNVphVndnL0UzUktPZ1pWMmlHWTJUcFA2VTB5VnJ4WlgzRm5n?=
 =?utf-8?B?N0hoTXordnJLQ1hob1oveFRpL3JONXRFSVlFYkZiK21GNXE2SDU4SG51alA3?=
 =?utf-8?B?c2NISmwyRjYrd1QzSVZRVHFSajZocW5ETmYwNTFGRitVWWFvajd2ZEg1VzFV?=
 =?utf-8?B?N0tpUTdGb3ZldzdBbXVTT1NkNzdOM3JQc1IrcUtIL0pENHF4eEFqeEF0S3V0?=
 =?utf-8?B?aXNvOW9jVmdycVoyRG1VZ2tFcTJKVlJyT0JIQXNDV2tOejIrUVdFaEE4S21K?=
 =?utf-8?B?T01adFlETWZyc1dvNUFZdUNaeGIyaC9lNlpsUzAxbGJTb1M0OThOemQzelRF?=
 =?utf-8?B?dFRvSEIzRUY1VU9BQ0loZldWWjBWSUt6ZFVzSStuRVN5cGxPbW56SW9sSEhi?=
 =?utf-8?B?d2g0akpHWDBCSEJSSWkxbjhVUmJlbTFTWkJhdTdJcWJ5aWpKc2JwZDg4eTF2?=
 =?utf-8?B?UHVEYmFQTzVEK2FhbEZ3bzNjQ2RseXBqc252K1cwd0hXVFY4UC85VkpMdHo5?=
 =?utf-8?B?TExpdHBlQ0ExSnBEaXpQUTBLWENUb3kvYmpqRDJaZEVacjZ4SENYOExBMTlK?=
 =?utf-8?Q?qvW4Z+7+eKmEzCHg8Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4265.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fa140269-e7f6-4f74-9fb4-08ddd1250f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 17:58:45.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8774

KEJlZm9yZSByZW5hbWUgY29tbWFuZCk6IFRoZSAuZ2l0L2NvbmZpZyBmaWxlOgoKPHNuaXA+Clty
ZW1vdGUgIm9yaWdpbiJdCuKAguKAguKAguKAguKAguKAgnVybCA9IGh0dHBzOi8vZ2l0aHViLmNv
bS9Ta3lidWNrRmx5aW5nL1JhbURpc2tTdXBwb3J0VXRpbGl0eS5naXQK4oCC4oCC4oCC4oCC4oCC
4oCCZmV0Y2ggPSArcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy9vcmlnaW4vKiDigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigII7
IEFsbCByZW1vdGUgYnJhbmNoZXMK4oCC4oCC4oCC4oCC4oCC4oCCZmV0Y2ggPSArcmVmcy90YWdz
Lyo6cmVmcy90YWdzLyog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCOyBBbGwgcmVtb3RlIHRhZ3MK
4oCC4oCC4oCC4oCC4oCC4oCCZmV0Y2ggPSArcmVmcy9ub3Rlcy8qOnJlZnMvcmVtb3Rlcy9vcmln
aW4vbm90ZXMvKiDigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gII7IEFsbCByZW1vdGUgbm90ZXMgKG1hcCB0byByZW1vdGUtdHJhY2tpbmcgbm90ZXMpCuKAguKA
guKAguKAguKAguKAgmZldGNoID0gK3JlZnMvcHVsbC8qL2hlYWQ6cmVmcy9yZW1vdGVzL29yaWdp
bi9wdWxsLyovaGVhZCDigILigILigILigILigILigILigILigII7IEdpdEh1Yi9HaXRMYWIgUFIg
aGVhZHMK4oCC4oCC4oCC4oCC4oCC4oCCOyBmZXRjaCA9ICtyZWZzL2NoYW5nZXMvKjpyZWZzL3Jl
bW90ZXMvb3JpZ2luL2NoYW5nZXMvKiDigILigILigILigILigILigILigILigILigILigII7IEdl
cnJpdCBjaGFuZ2VzIChjb21tZW50ZWQgb3V0IGFzIHBlciB5b3VyIHJlcXVlc3QpCuKAguKAguKA
guKAguKAguKAgjsgZmV0Y2ggPSArcmVmcy9tZXRhL2NvbmZpZzpyZWZzL3JlbW90ZXMvb3JpZ2lu
L21ldGEvY29uZmlnIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgjsgVmVyc2lv
bmVkIHJlbW90ZSBjb25maWcgKGlmIGFwcGxpY2FibGUp4oCCCjxzbmlwPgoKKFRoZW4gcmVuYW1l
IGNvbW1hbmQpOgoKZ2l0IHJlbW90ZSByZW5hbWUgb3JpZ2luIHNreWJ1Y2tfcmVwb3NpdG9yeQoK
KEFmdGVyIHJlbmFtZSBjb21tYW5kKToKClRoZSAuZ2l0L2NvbmZpZyBmaWxlOgoKPHNuaXA+Clty
ZW1vdGUgInNreWJ1Y2tfcmVwb3NpdG9yeSJdCuKAguKAguKAguKAguKAguKAgnVybCA9IGh0dHBz
Oi8vZ2l0aHViLmNvbS9Ta3lidWNrRmx5aW5nL1JhbURpc2tTdXBwb3J0VXRpbGl0eS5naXQK4oCC
4oCC4oCC4oCC4oCC4oCCZmV0Y2ggPSArcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy9za3lidWNr
X3JlcG9zaXRvcnkvKgrigILigILigILigILigILigIJmZXRjaCA9ICtyZWZzL3RhZ3MvKjpyZWZz
L3RhZ3MvKgrigILigILigILigILigILigIJmZXRjaCA9ICtyZWZzL25vdGVzLyo6cmVmcy9yZW1v
dGVzL3NreWJ1Y2tfcmVwb3NpdG9yeS9ub3Rlcy8qCuKAguKAguKAguKAguKAguKAgmZldGNoID0g
K3JlZnMvcHVsbC8qL2hlYWQ6cmVmcy9yZW1vdGVzL3NreWJ1Y2tfcmVwb3NpdG9yeS9wdWxsLyov
aGVhZArigILigILigILigILigILigII7IGZldGNoID0gK3JlZnMvY2hhbmdlcy8qOnJlZnMvcmVt
b3Rlcy9vcmlnaW4vY2hhbmdlcy8qIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgjsgR2Vy
cml0IGNoYW5nZXMgKGNvbW1lbnRlZCBvdXQgYXMgcGVyIHlvdXIgcmVxdWVzdCkK4oCC4oCC4oCC
4oCC4oCC4oCCOyBmZXRjaCA9ICtyZWZzL21ldGEvY29uZmlnOnJlZnMvcmVtb3Rlcy9vcmlnaW4v
bWV0YS9jb25maWcg4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCOyBWZXJzaW9u
ZWQgcmVtb3RlIGNvbmZpZyAoaWYgYXBwbGljYWJsZSnigIIKPHNuaXA+CgpOb3RpY2UgaG93IHRo
ZSBnaXQgcmVuYW1lIGNvbW1hbmQgcmVtb3ZlZCB0aGUgY29tbWVudHMsIHRoaXMgaXMgc29tZXdo
YXQgdW5mb3J0dW5hdGVseS4KRm9ydHVuYXRlbHkgYSBjb3B5IG9mIHRoZSBvcmlnaW5hbCBpcyBz
dGlsbCBhdmFpbGFibGUuCgpGdXJ0aGVyIHRpbnkgbGl0dGxlIGlzc3VlLCB0aGUgY29tbWFuZCBp
biBjb21tZW50cyBub3QgY2hhbmdlZCwgYnV0IEkgY2FuIGRvIHRoYXQgbWFudWFsbHksIGxlYXZl
IGFzIGlzLCBzaW5jZSBpdCBtaWdodCBjb250YWluIGluZm8gaW4gY2FzZSBzb21lYm9keSB3YW50
cyB0byByZXZlcnQgdGhpbmdzIDspCgpCeWUgZm9yIG5vdywKwqAgU2t5YnVjayBGbHlpbmcgIQ==
