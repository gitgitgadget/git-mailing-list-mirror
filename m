Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2137.outbound.protection.outlook.com [40.107.249.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964841C64
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197041; cv=fail; b=WZ0c60HH97fYfxxkCK9ChJHS7E44NZbaeu23T+BWwl/dyD4YVSTVPBxsoStOoqqAaKY0fVsW93QAex77ouhmGtpbnfL83Xx29N4FlDv/kp7K+Q3olYW9+ck6DmHiXiV6uhfMDAwowyJTBzaPD+KTuEV5UlbWxkhPeqV9y3LDbhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197041; c=relaxed/simple;
	bh=fd188dgmdKk3gWChHTUnRHQrnDqlmjy/cBAbBONslEE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qNIgoHesGoUIhl2/i+9mbN4yoHapFjignyEAlkws+ejswnzbaakvuoKw8X4Tfef9fBz3gNyI77Pk56H5PNEZpaABOao8Fsp6r+Jc800/CB8miSemlwODFFKT+RiXZIgGei6EDOCX/HR5egWm7Hwz7Gh9i8bN/may/Baye1FGr0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee; spf=fail smtp.mailfrom=proekspert.ee; dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b=GWOIGoEg; arc=fail smtp.client-ip=40.107.249.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b="GWOIGoEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i635TLgZUR0ZOZ1aWJmBtlwyVOrS+/4E9noOeygh73jyNHLYd2VMrt7b0RLh8TnvgWuyD9JyNY8zbYMA5gsnosqZpnwW0iXKz2VLLz6R2J3N3FOqrbFF76XOfbZGwTkJlbwBhqPVq6sI9WkpEz3CBhFbsAT1DFEkp0ddG0ZagShIi07NxgXjPX0l7fE1/1BdrFY8+efyyjWUpTQAPUGBJmCLUSgxy1aVb3+J53/F7ExJPgcQeN1oL7YayLWA26NTF4sf7ZbaDW27hGcBUM6xerpYt/3AZ50kA3eyLDPb66WvhCMFIRz5HUiu5iTVS6NsDAAlaLfK4mLend6gSUunAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+NSnNXArWYIG5g+3HNE3IQsZcI7YrI8PBVliDih9U4=;
 b=Ql4uMb9nv341MOxQCtXCPx6x0BZtgyPHQc4uR91O7g0+ZoMsuvzOmqKnW4gBXrFf4GamIR5+lNSFtQJsnOzDA+lLTvbdoFeJOmU04GDWQAYpeXurRCzjUhHDczLzrABWqg1ykBC43uNmC7tu6NiQsqOdhMCmMpOiJ0WiuXGS6pNjUu70YFi96TegimzlhbRGEpNIpm/jbS6sg58kngmD/I5NfQu9ONpO+rPpL3I6h+JzrAPREfdATd6VNypJAzFKJrFEeiYwFC0GKiDTsHWRrXln2nzzG4xSKyzKYrhVJA+Q3YCUo6Hw7T6uTDePyhFMhzYggyNFybcBenGX2+ss5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=proekspert.ee; dmarc=pass action=none
 header.from=proekspert.ee; dkim=pass header.d=proekspert.ee; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proekspert.ee;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+NSnNXArWYIG5g+3HNE3IQsZcI7YrI8PBVliDih9U4=;
 b=GWOIGoEg2Aa0AhJZAD6Okx2ucU03VhaY46Vl4iSUArv+qkIdV8IyHqAP6g+y47WVKHSIAHnlh0nvNTXv9sImzbkCA/i4crAPITLWxl+LiWCChyKo1FmFlAEhJTr/NsUp31iDlYVPEE+TBU0phdntljOx7p2dxov2uNnZiN6SvcQ=
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:539::16)
 by VI0P191MB2628.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:218::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 11:10:33 +0000
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a]) by AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 11:10:33 +0000
From: Lauri Reilson <Lauri.Reilson@proekspert.ee>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Possible git-gui bug
Thread-Topic: Possible git-gui bug
Thread-Index: AdupPkrODeM5biBoRQ6P7hGlivxuEA==
Date: Wed, 9 Apr 2025 11:10:33 +0000
Message-ID:
 <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=proekspert.ee;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P191MB2174:EE_|VI0P191MB2628:EE_
x-ms-office365-filtering-correlation-id: 60c1fcd2-a173-4012-ec88-08dd77572594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/nYfclwagIBBAYzspwG7W+qlHYOXNETLYfYNioT5yup28J9sVsqivAchXJ?=
 =?iso-8859-1?Q?frkrnRZ/O+/wewSwjYMzM/vfpaXoEiOuMt9vnLsZ/XpQRgACvIL7mnxjRN?=
 =?iso-8859-1?Q?p/HO74aNhfYUmQwwgtAyUf49fYD/D23JEus0DU/rEI9x5gHtNgVsduR8jr?=
 =?iso-8859-1?Q?5qORrKCj//DCBhtpBCCQpY1hN41dX2f+oguc2wX33K3HQas8SR+Nxg04pA?=
 =?iso-8859-1?Q?qUCYfRy8p0MlCEI40uwMoWhOk4h+TH84OdkhlhK5P9zcLETmzxmtTad6UZ?=
 =?iso-8859-1?Q?kKWumjaoi/h5SjsOSbAasxA5sPqdyik9vpxlW3YlVkT1pcsthC1IDp1M5g?=
 =?iso-8859-1?Q?zDs/YJMu619Qth1dRRzw5qZWfnRk9/bnQ07NKSJR7yjGw3PM9fnVgmtGud?=
 =?iso-8859-1?Q?klXsbmarVOPEIe8X4v4kR7YTsSMq66CA1UfVQrYpq7CN8O7Jc5Luows0pV?=
 =?iso-8859-1?Q?j1c4SQ1NJjwwKEtxqWhNKTTXrBs9SA0YFhWPyMqWCGamG0nSHdu+sn3k5x?=
 =?iso-8859-1?Q?3cmaZ1oawNfcWjW9zcEDkWxAOzswz8vXil9yw+C3CYXXPw5REdHF6tY8M6?=
 =?iso-8859-1?Q?fvNDGD3ew44OKbgMUSAvpM/9Rd/VWUM1ri5RzU5mKM9rfBKr//q4c1wyf1?=
 =?iso-8859-1?Q?zXguk/tb9lMGBwuVvsbkBCoIJ8/Y8QgeV8OLTBy8rScUNUZo03KYNXtF3E?=
 =?iso-8859-1?Q?+yN6oY4QZVuJfp9bfBgwQPw3Cce97EtFnixEkqMYvO5RV9Pf7EvHom7Uli?=
 =?iso-8859-1?Q?0Cf7dw/UgdlTam09PJkgWb7kRa47HU42MRmTHKopvR+TKFbBOkTI1uJrFR?=
 =?iso-8859-1?Q?Jd5/HgbcCSRVLEZ9RIYCqMKDLCihu2tEJzybR+9piaFPLv/q3QgaRcnWpU?=
 =?iso-8859-1?Q?v3uG5RvoF+EBqH/T10YVG52Lr96Lx2NLzj2n+X1gnos3d+B6sLqWNhJMFf?=
 =?iso-8859-1?Q?CCC28ac93aWO3n9flO5uL86Fy59o1njKNewDJADaDnOLhNhxAPrUzjFhuu?=
 =?iso-8859-1?Q?xKHf5OqoU+0N6gIDsp+6EsE8TKntL+9EKeKsSosjhYfO6+mQtV/XjqyHyg?=
 =?iso-8859-1?Q?ifwRPykRKFHvXZevDVhyalbrdkYaLSJJP9iW97wHV4dqOYkKq3HeeIy6F8?=
 =?iso-8859-1?Q?5G0K+gawaoyNzM3/4DPqm3adnQB3Cfkt+ZSRqx9thdgiuzh9GMY7AtZs1X?=
 =?iso-8859-1?Q?k1Egawfg2QDUHUtAVrUGkz68uFr10VEAQ7CEiG+DieXhehIEOYvM0BEt3B?=
 =?iso-8859-1?Q?HD2PChnF0Fnekfq1yscnr06R/MYF5WL+KyJKJvSgai/G438iGgrVspE7je?=
 =?iso-8859-1?Q?nJJKrAmJMHg5Ixil/vSI39Av9iAw9rH1OsSrqt7Km2cbcMJm1hUlBo5rBq?=
 =?iso-8859-1?Q?Sd4/Ai4GFK5u6pFrML07QxcaX3Mwmug2VJKCVSJVe5CNhPSia/8e9Zaa+Q?=
 =?iso-8859-1?Q?isS0xjQHRuUI2jnx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P191MB2174.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rDGjz6GGAZlTS0HoFn9KsR8FCkku6mWMnZWcLmUfEmH0ujCHO3kzXVlGJf?=
 =?iso-8859-1?Q?NqsR0lfsL36cpEZvcMUYR30VfIxjcnTimMbIyWhQqog2cxv/XhpJ3FGKuP?=
 =?iso-8859-1?Q?XLWQQkEfpwAyX1ucC/AAhpEkA/oBpYEVF80DfpXQ/TRAVt1TBgT9Rh+Uji?=
 =?iso-8859-1?Q?LGmkcWqMcuT/upV5jUjuYlc370lBoqCjpk4jp5Q3pGhvUK05y7K6OvyavH?=
 =?iso-8859-1?Q?hxxKJr5vVMoZbCVKPFl1GKg38Q1KxUbEiIDw6GP2rWnaqIQbnEhAVXLtwd?=
 =?iso-8859-1?Q?64sBICCRYpqDth7L+eOyom7QkRxitNPzitVHHVQLTBKnhvEZVRyZSe/UDV?=
 =?iso-8859-1?Q?Msx7+C7TtM3mA5ntqKkKOdrbbXVtGiqlr8RLUTm6rBl5VTYcaeAtwct3LD?=
 =?iso-8859-1?Q?kL4gPe51ZobVKNy785Go0U291B89UYV2/mhugywbjSqTFTLvI25RW+WCcz?=
 =?iso-8859-1?Q?/tGRsUYXfYf3KLb7O2S4uhIL5M5DkeiIrj14nLwfTg7EFhZhK9SPtJLjYg?=
 =?iso-8859-1?Q?pMLhsbBEMGMwQk1tW+lOcNqvgETPVMBlyubkQ/u2zYa4TQFJkyvV/qBNYP?=
 =?iso-8859-1?Q?UOu3TOXJetXPEDqERB42/TId8yMPKyelh8FNaf7bUdTuKXuBlmRt1JqihW?=
 =?iso-8859-1?Q?h5gwM7PeUB9hugPekfKansCedE2OLRjHjBjzaLGKohL0NdocMwL13lqdS+?=
 =?iso-8859-1?Q?ZKvkHu9+D0tFWfunktQW9xtCg6tHCFc+8SPgXf+Nt4hKv/fiUVD4jMZmjU?=
 =?iso-8859-1?Q?SMsyPPcEkSEyNRSenrx4KyI8bhatXsb6kiLO6K9/HUrUk8ApbH7S44pPz3?=
 =?iso-8859-1?Q?bSaqyVRn1JuvV6OowOB2Tc3dPL7VODEVcsRhxit5ZQCd4rXGNdVTFLTy3P?=
 =?iso-8859-1?Q?51tE+qYQVYu0kNNpswDcNng0fFIvTCZcQtpCwCC5FxFtQ6qEOQa1Gnyips?=
 =?iso-8859-1?Q?kzZzVBHwStE6U8nPJ9DfM8dhS4p6+uv1n1zLNIGziwhRwqYK0rEapl3GjJ?=
 =?iso-8859-1?Q?K8FrHJRrsyQeL7ScCjSjnZbkhvc6wNvZZrgQKSeK8dqSxLJ8kVswodppAO?=
 =?iso-8859-1?Q?RFz79lrlwWqxbOu2uXHvgUyla3dNEMM9TwaELsOqMpoGIRmN53BIM4E9Vr?=
 =?iso-8859-1?Q?ojslTXCSIKCswlXpunwwyB0hVaHCeLTTUvexk6X4V3nMgHEQbJlWs/I4az?=
 =?iso-8859-1?Q?lrTtPPkzk0X2C0+Bt3PXXcYQ8UY+r1f8rhVCNJhz43wJbAR5OAVwHYheRl?=
 =?iso-8859-1?Q?VtQbdehO7I88kjQ6CTz9rjEtEn16oTSmjh8Bo5cef56lkcyvCRLigyvFXq?=
 =?iso-8859-1?Q?vlPD9kcmJij+uOndVNsOMP9qc6BV3PGsQq9OfRmy1kNaOQJ0396lKXxF5W?=
 =?iso-8859-1?Q?aFunyOA7viFg88gCwyU3QBNxXpBpSYPjEM8vr+v050XnIcheZ6dsbig2ej?=
 =?iso-8859-1?Q?CCJkeA8cwofHgzq93kQRLGjRmgYC82oWgWdO+NYox4vVm+jc26bHp/OuPQ?=
 =?iso-8859-1?Q?OpcSCyQ4XONg25hnZXvGnUmC6/FdxViOjmBKmBBaDq+BZzomd5cjTLI6Ju?=
 =?iso-8859-1?Q?Avsiq97pomaVvc1wd9RYDuNQ2ONjoinSDc0SJebWoILLQS5ey6CU15c/2J?=
 =?iso-8859-1?Q?eF2BLoYNL3cta32ihZ5Y01Mcse1hplmLNN?=
Content-Type: multipart/mixed;
	boundary="_004_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: proekspert.ee
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c1fcd2-a173-4012-ec88-08dd77572594
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 11:10:33.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4fc69ca6-ce6b-4059-8ad9-2049c3c135b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koDj1gVugzm4dhmCLntYnJvRQt3VgP1h7tSxqQdFZqQqQDXoL0I1hCejzFveRY3VZ5OrHNjbCMeOc91LVagNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P191MB2628

--_004_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_
Content-Type: multipart/alternative;
	boundary="_000_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_"

--_000_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello to all!

I have a small issue with git-gui. I added the git-bugreport to the attache=
ment.

Warm regards,

Lauri Reilson * Software Engineer
lauri.reilson@proekspert.ee<mailto:lauri.reilson@proekspert.ee>
PROEKSPERT<https://www.proekspert.ee/> * S=F5pruse pst 157, 13417 Tallinn, =
Estonia, EU


--_000_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hello to all!<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have a small issu=
e with git-gui. I added the git-bugreport to the attachement.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Warm regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><b><span style=3D"font-=
size:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333;mso-=
ligatures:none">Lauri Reilson</span></b><span style=3D"font-size:10.5pt;fon=
t-family:&quot;Helvetica&quot;,sans-serif;color:#333333;mso-ligatures:none"=
>&nbsp;</span><span style=3D"font-size:10.5pt;font-family:&quot;Helvetica&q=
uot;,sans-serif;color:#A3A3A3;mso-ligatures:none">&#8226;&nbsp;</span><span=
 style=3D"font-size:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;col=
or:#333333;mso-ligatures:none">Software
 Engineer<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"font-siz=
e:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333;mso-lig=
atures:none"><a href=3D"mailto:lauri.reilson@proekspert.ee"><span style=3D"=
color:blue">lauri.reilson@proekspert.ee</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"font-siz=
e:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333;mso-lig=
atures:none"><a href=3D"https://www.proekspert.ee/" target=3D"_blank"><b><s=
pan style=3D"color:#1CCCCE">PROEKSPERT</span></b></a>&nbsp;</span><span sty=
le=3D"font-size:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#=
A3A3A3;mso-ligatures:none">&#8226;&nbsp;</span><span style=3D"font-size:10.=
5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333;mso-ligature=
s:none">S=F5pruse
 pst 157, 13417 Tallinn, Estonia, EU<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_--

--_004_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_
Content-Type: text/plain; name="git-bugreport-2025-03-25-1751.txt"
Content-Description: git-bugreport-2025-03-25-1751.txt
Content-Disposition: attachment; filename="git-bugreport-2025-03-25-1751.txt";
	size=1584; creation-date="Tue, 25 Mar 2025 15:51:09 GMT";
	modification-date="Wed, 09 Apr 2025 11:10:33 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkFkZGVkIGZpbGVzIGZvciBjb21taXRpbmcgdXNpbmcgZ2l0LWd1
aS4gUHJvdmlkZWQgb25lIGxpbmUgY29tbWl0IG1lc3NhZ2UKCldoYXRkIGRpZCB5b3UgZXhwZWN0
IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpFeHBlY3RlZCB0byBjb21taXQgdXNpbmcg
Z2l0LWd1aS4gQ29tbWl0IG1lc3NhZ2Ugd2FzIGluIHRoZSBmb3JtYXQgPCN0YXNrLWlkIG1lc3Nh
Z2U+LiBJIHVzZSAiOyIgaW5zdGVhZCBvZiBjb21tZW50IHN5bWJvbCBhcyAiIyIgaXMgdXNlZCBh
cyBhIG1lYW5zCnRvIHRyYWNrIHRhc2sgaWQuCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1
YWwgYmVoYXZpb3IpCkdpdC1ndWkgZ2F2ZSBlcnJvciBtZXNzYWdlLCB0aGF0IEkgbmVlZCB0byBw
cm92aWRlIGNvbW1pdCBtZXNzYWdlLiBUcmllZCBvbmUgbGluZSwgZm9sbGVkIHRoZSBlcnJvciBt
ZXNzYWdlIChmaXJzdCBsaW5lLCBibGFuayBsaW5lLCByZW1haW5pbmcgbGluZXMpLgpBbHNvLCB3
aGVuIGFtbWVuZGluZywgZ2l0LWd1aSBtZXNzZWQgdXAgdGhlIG1lc3NhZ2UuIE1lc3NhZ2Ugd2Fz
IGluIHRoZSBmb3JtIG9mOgoKIzEyMzQ1NiBtZXNzYWdlCjxibGFuayBsaW5lPgotIFNvbWUgc21h
bGwgZGVzY3JpcHRpb24KCkFuZCBnaXQtZ3VpIHR1cm5lZCB0aGlzIGludG86Ci0gU29tZSBzbWFs
bCBkZXNjcmlwdGlvbgoKCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3Rl
ZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8KQ29tbWl0IG1lc3NhZ2Ugbm90IGJlaW5nIHdo
YXQgSSB3cm90ZSBhbmQgbm90IGJlaW5nIGFibGUgdG8gY29tbWl0LgoKCkFueXRoaW5nIGVsc2Ug
eW91IHdhbnQgdG8gYWRkOgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9y
dCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJl
LgoKCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjQ5LjAud2luZG93
cy4xCmNwdTogeDg2XzY0CnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgKc2hlbGwtcGF0
aDogRDovZ2l0LXNkay02NC1idWlsZC1pbnN0YWxsZXJzL3Vzci9iaW4vc2gKZmVhdHVyZTogZnNt
b25pdG9yLS1kYWVtb24KbGliY3VybDogOC4xMi4xCk9wZW5TU0w6IE9wZW5TU0wgMy4yLjQgMTEg
RmViIDIwMjUKemxpYjogMS4zLjEKdW5hbWU6IFdpbmRvd3MgMTAuMCAyNjEwMCAKY29tcGlsZXIg
aW5mbzogZ251YzogMTQuMiwgbXN2YwpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZh
aWxhYmxlCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IEM6XFByb2dyYW0g
RmlsZXNcR2l0XHVzclxiaW5cYmFzaC5leGUKCgpbRW5hYmxlZCBIb29rc10K

--_004_AS8P191MB2174CB58B1A29D1492EE7842FAB42AS8P191MB2174EURP_--
