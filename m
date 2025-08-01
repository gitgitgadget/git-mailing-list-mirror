Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011038.outbound.protection.outlook.com [52.103.33.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B4214A93
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079882; cv=fail; b=rKV0luKz1E2s1GJFTl/VowLU9XDgvwW63TmbQcfGj008PkFkFoo6URxWAMu1dyJkbGddBPqL8lferXvChcmmaYd239onhDC7PJb0n2ZdWHZ1zlB/gJ+Lb5L8lLWf5S14Xd7xEJTiVJYqNmfinvorMisXY0HWPjuyyeg37mOsBDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079882; c=relaxed/simple;
	bh=XzbEoAIDXs3MUJ6KOd5VgTDpFNr3lHRosVPcFUjH5Zs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcghAaKrIxDHtRKtW0xUGy9wufoIAa4B1ymlJvQaJ8csSm1IOeslJ13i+BneTzPLxybFbNk52MTK8WzYnGZHvVL/BE2vRxX7IIvZ8shjyRHKKMv/AhZ95y7nFiIZJTWLjgC/y1lSoUHAKiU+unMjjFlSNtUIAXdas0OaXAcSFBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=prFSQyiC; arc=fail smtp.client-ip=52.103.33.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="prFSQyiC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8GnHDxdzzK8vWBj6eBovrs6WL2wkC8yjThArdSIkq44HMA5x0jOpQLDO+ngwDk9fXfaiDP8XPJgsbcOVlMuCOpOH6cW9MCDu71QwKIrJT9+7Zejxppd6n8p0Nfz2UpSHxJp3cqVkEivtQxQvhiNHmhUA4kFAw7NJ3g80jepSAESrbrtvpU1fmfbyqvoUUPuVa3w0y4DW17WzV6av22+OO6UsVnOIYMeuzeZAojym/wYA9ND+he/lCwwL6nW3KRL3VmNpcIhx6geDqBWOtGSgeVenNQYjhKDL+d+6hrWobd2mwPWvykzN6ptqhhxpcPklnTuWTs8mLqYS3/g8cATSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzbEoAIDXs3MUJ6KOd5VgTDpFNr3lHRosVPcFUjH5Zs=;
 b=zDerdp5EhtPfBJe7ciTvKnRxZ5GI6q+u1Vx5roshfcGRGuUKYJSWCJ4fOjs46QcJ8u/IvwbTHgmXGKhJlWbTtdY4OcSQrEQLHvOGfbHxLofsOeHreVBjAA8xX72yumZ+sOLpApHip6ys+kO6bKHHvO4CKlb9xEcBCI4ILFJU+DRt0ed4HXZuj4Sq8IYMw6T33B1sgP9o995QaA6cfoEZzEtB9mS309zKQQqtvMwkilO2KgEKq829f7Jd4q1hwSkmCVg2Aqfd6HCqPl1mPnsdXm+0+U0Udw8wlprApoSFUbxpNiS/3w0L7vr6JuTh3LgQdXVQOoS2Xckztk0x3vYnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzbEoAIDXs3MUJ6KOd5VgTDpFNr3lHRosVPcFUjH5Zs=;
 b=prFSQyiCj7MoYWzcccTkyz3LvbfuTCVo92+FjfHG6i91uPEcwy+4cYbRUjhgk5Noa406Pb3e21y7pATZAISVSUXaVOkcgy6jXMDyK2XHer/Li7imayDWio216wWkUIaGVgV8QxmmCMo3KSiHfF9/ySmFJveBeYQ85IK/jTz7sL2Hs6qOhG111S2HAPFL2hpWEo0S0X1Byrcnns/icVoIbGkR2dOK+r/eVdgsZLqfZBxSWOjuUThYO4UetQ6nu4dTvQ8fDO79Ivwjs2fbQW3n9G/LUn2UUP7h4kEF+OESPvKXe8K0pStiQpxqd6K/Z2AOTuMaQ2kzWjYW/bfa0YatMA==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by GV2PR02MB11323.eurprd02.prod.outlook.com (2603:10a6:150:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 20:24:36 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Fri, 1 Aug 2025
 20:24:36 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .env is not being ignored by this .gitignore file.
Thread-Topic: .env is not being ignored by this .gitignore file.
Thread-Index: AQHcAyBpdtcVSzZQpkWdqQxZo3scO7ROPdBX
Date: Fri, 1 Aug 2025 20:24:36 +0000
Message-ID:
 <DB7PR02MB4265CD53B0FAC6F2AC7EC02FB326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB426582D352EC00FDCDC5CD45B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
In-Reply-To:
 <DB7PR02MB426582D352EC00FDCDC5CD45B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|GV2PR02MB11323:EE_
x-ms-office365-filtering-correlation-id: e283f735-fc69-41c8-b98b-08ddd1396ee7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|8060799015|8062599012|31061999003|15030799006|461199028|40105399003|3412199025|440099028|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AdK0MJs+BMKI9cma5yu9QQZYk4cxaBytNGlRmYHJDvvLJlyvIs5OCrEI7a?=
 =?iso-8859-1?Q?ENCbpi2ImIaq+kZ5Cu/+cXrk9MljoVHdHwbTFcRpA69oNxbFbFDbbAwf4Y?=
 =?iso-8859-1?Q?Ao/BbTKkEXf8qycbxNVRNgyWalJWQoY5Nb/wqhSX8dIl+wpELUKHh5sO/k?=
 =?iso-8859-1?Q?6GyRyxae7RWY+W6CKxBP43fyQi893zIV65TD9+/kmiV0X13m/d+wlJdofL?=
 =?iso-8859-1?Q?5eJnTkXQUDb6zLCr198yKpMd4yFdhDzdOgfxGT9Y8oi+CVa8gdsijFMKRJ?=
 =?iso-8859-1?Q?wmdyM2zAVY84w7PUe5jh1w/pW4fHSXFNdJrNSa6FxnZHCooU8bMtackH61?=
 =?iso-8859-1?Q?p7Rm0LDyrII83dy6NH5lH/prWU8PSQ6m7AsxGUU7zI0sLbSZ1XpV4SO3Y+?=
 =?iso-8859-1?Q?4sNgGfB+lQRt4mdxKRrZGG2+BTEaXBQiTrYaitnFbmGyWz6Hzwv422cbuH?=
 =?iso-8859-1?Q?s95yeh9Inr8uM4fa2mxbosrNow+vFCvhpv8esrff5DE4aM9AFnFACqdpwc?=
 =?iso-8859-1?Q?EhSNZtDP2P3vF7znU/0IcfFRlMBfFRW2pq0XGjmmI7VkDO47II8gIV/sow?=
 =?iso-8859-1?Q?pxZhPCKrGwe/ipw0RdeBMxQv/q8yVuc+xV6pp83h/G9VXBfHtUGP67wGKQ?=
 =?iso-8859-1?Q?IKa+3ad6KHWNH8SQ+K2aFTFwm8RMrbU/Xk0Lg27xUh7n0Ezz4cpecah7CD?=
 =?iso-8859-1?Q?+OyIOQyCPEYcGD4iT5KpwpbMXb7ZkqcozCuA8boHiAg6IDpu8oRrc6fQIl?=
 =?iso-8859-1?Q?cwBHB6M/aaw2x2VRER1GluWvRAU2LsLESiZGbq4so/7VvjDyyM/9Hpw9Wj?=
 =?iso-8859-1?Q?43GU6v61oBb5WbuwPrdcy4wkA6E27CCXHqY1xHvGOSULcrmARlD/LdAx9v?=
 =?iso-8859-1?Q?Q+1GV6466+83YqFmp8+Df/7PURhBiM+j2Fvt8Ecklr7q62kBvHNhXHS9kA?=
 =?iso-8859-1?Q?/AQ15zcpmO+jWSu2+Jt+G8lKg0UtqnohLX9kvoUPMj9v1tXRyHqTq/PHMD?=
 =?iso-8859-1?Q?oZC8Mn/4N90iHUU75SkHQ7jF+sVfbvwxGWQ+QijXdz9eFivryTdXUcmfJf?=
 =?iso-8859-1?Q?qKg7Ba4aCtSfOwxiNjHl7KrP4JpuVqDS26eV2+OOnJ85nqsNpOlFaWClUC?=
 =?iso-8859-1?Q?hNtZXxeufkMCwyGMMZSKwBK0B36DqlRgdBB3ZOeYG8rE+MNNCBTKk1Tjmx?=
 =?iso-8859-1?Q?xAldobWH9UzoZRLsQVcYNX90tOYHCGiYSgDx8oGJWbhtBpyOwjjNi3u0jS?=
 =?iso-8859-1?Q?IcqeKBxUMy+Iui9Lu47w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?58TbIHo++NRZxT1MckuYHD7ENJqBqwmm4IOI388g3+kKe/71p+AKGU2ULi?=
 =?iso-8859-1?Q?Xqk38WnFdfppBxtvd1j0QwnD5onCIV/lEHoNAG+8FuFdy+j+8Vxsjuk61r?=
 =?iso-8859-1?Q?oVUbTKm2EvUzDXxoHgfh8PsH7b2Ok+aPD02qXfXQlmg80dsoJQTwc0G8c6?=
 =?iso-8859-1?Q?untYJCNnRtjhQO+9MplPyHz/u7SD4EhWY3ZT4ODPJBmfd/Smd0K7arsLvi?=
 =?iso-8859-1?Q?SXQOb2Xf+kQqF9qdfV9yUhgY7F3n9XS1m6nnwb1ifSi7++f32bk43IjHqd?=
 =?iso-8859-1?Q?ZwSVYf+l83HDoQPRSgkJ2o0WTqAKzYZnJlM8Sd+Epg5H7lfI1T0b/uJGSH?=
 =?iso-8859-1?Q?//4sghXMrJYmCQM/tEyBzjaGi5M6CKImq8hL9jvu7QdzCdzKyg9WcaS/cK?=
 =?iso-8859-1?Q?3uAnTANjeP+KWtvJ34+mhy4149JzZg60PrXsSjGAn9t8iBRXkepWri2L68?=
 =?iso-8859-1?Q?TNAdUM6S4E84c3RrJEpA+Bbn96tzTQZgBTe9DIWXf5+MR3PPgzEYd1dkX6?=
 =?iso-8859-1?Q?Rbzf6nq1x3Fpe6itcVghHNxMG6jDbtsZ8Fog6L/giBpqtiQ5GstVHAbkc8?=
 =?iso-8859-1?Q?mWUnlB2JbuxLhCNNtXmdvf62OS2A0yjXtLNkoKeUDJgnwtDluVwTbdvo1Q?=
 =?iso-8859-1?Q?3x6xHGkdfpEUJWowG5AeCh9wVPBmIDl8hOiX7+MB80oVL2D40qi5VJuNwC?=
 =?iso-8859-1?Q?wXkZq/T72e3QB2eXMDdSH4oPW0mL6O6I0S2dghV1FSGj71G/aYekV9b0Kv?=
 =?iso-8859-1?Q?4kFASzJd+YXSY4JJUc8l7AejymGIZCTCVHoo8WJvsgf0hNlOiorjxrkxsT?=
 =?iso-8859-1?Q?2KIHFB0xSt6tej/TczKaNS9x0n9T/EhWhpOW+vcChjzLo4jF289JlfsyvF?=
 =?iso-8859-1?Q?Wy+8ChaTZSljkMDXrcsCZAVQAtcPL9T0qAzAbfBEtBFK73S1WN2ORO99w5?=
 =?iso-8859-1?Q?ehmkD+8AhPU2oCR/eT6YaKbojoyZZIFVuyl3oeNP1sZJIwp13+LWK8JCVq?=
 =?iso-8859-1?Q?Lh29AZrktbFhxD9KGVQqOYG7AG+JATqh2HM8pdvUU3LVd6Ae6AV2jJoUNI?=
 =?iso-8859-1?Q?EQBXekM28NqYJ7i15xYxfHRZOyntCwRCn2J2BpzYS/WywRqEbNTT6zjEdw?=
 =?iso-8859-1?Q?TWfBuXhqOZIAjXUhtwbU/lRauodHKbtODDO2dvnn6bAYOWXGGBHmoKGI2A?=
 =?iso-8859-1?Q?dadgsjmAwIl5FA0KAGgZKPgd1kET9P1vGRqO3pnHTXkTmfxA83Glf9FtxP?=
 =?iso-8859-1?Q?31uhBt3uU/r+yG2WsvQPwITXFFtIqO0QKKumgVlqTECnsK9bfi7f6G3vF7?=
 =?iso-8859-1?Q?1JFlrtMGqITdKeJmfAmGYynV1WIJPi4qkzbVAFQE6dKexk8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e283f735-fc69-41c8-b98b-08ddd1396ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 20:24:36.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11323

Tested it once more in a new repo, issue confirmed.=0A=
=0A=
As I suspected the problem seems to be with the comments at the end of the =
line (especially last line .env # problem comments)=0A=
=0A=
To be on the safe side, .gitignore updated to place all comments on a separ=
ate line, this should solve the problem.=0A=
=0A=
# Modern Delphi 12.3 .gitignore=0A=
#=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Delphi / C++Builder Compiled Output & Binaries=0A=
#--------------------------------------------------------------------------=
-----=0A=
*.exe=0A=
*.dll=0A=
*.so=0A=
*.a=0A=
*.lib=0A=
*.bpl=0A=
*.dcp=0A=
*.dcu=0A=
*.obj=0A=
*.o=0A=
=0A=
# Compiled resource files=0A=
*.res=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# IDE Generated, User-Specific & Intermediate Files=0A=
#--------------------------------------------------------------------------=
-----=0A=
*.~*=0A=
*.bak=0A=
*.old=0A=
=0A=
# General temporary files=0A=
*.tmp=0A=
=0A=
# General temporary files=0A=
*.temp=0A=
=0A=
*.local=0A=
*.dsk=0A=
*.cfg=0A=
*.map=0A=
*.tds=0A=
*.drc=0A=
*.rsm=0A=
*.log=0A=
*.pch=0A=
*.ipch=0A=
*.stat=0A=
*.identcache=0A=
*.dproj.local=0A=
*.dproj.user=0A=
*.groupproj.local=0A=
*.groupproj.user=0A=
=0A=
# Delphi IDE bookmarks=0A=
*.bkm=0A=
=0A=
# TestInsight configuration files=0A=
*.tvsconfig=0A=
=0A=
# Files with .history extension=0A=
*.history=0A=
=0A=
# Legacy project files=0A=
*.dof=0A=
*.kof=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# IDE History, Recovery & Autosave=0A=
#--------------------------------------------------------------------------=
-----=0A=
**/__history/=0A=
**/__recovery/=0A=
*.autosave=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Output Directories (using **/ to match at any depth)=0A=
#--------------------------------------------------------------------------=
-----=0A=
**/Win32/=0A=
**/Win64/=0A=
**/Debug/=0A=
**/Release/=0A=
=0A=
# Cross-platform output folders=0A=
**/Linux64/=0A=
**/OSX64/=0A=
**/OSXARM64/=0A=
**/Android/=0A=
**/Android64/=0A=
**/iOSDevice32/=0A=
**/iOSDevice64/=0A=
**/iOSSimulator/=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Common Temporary / Local / Sensitive Files (General)=0A=
#--------------------------------------------------------------------------=
-----=0A=
# General compressed archives (often backups or downloads)=0A=
*.zip=0A=
=0A=
# Environment variable files (CRITICAL for sensitive data)=0A=
*.env=0A=
