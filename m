Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2102.outbound.protection.outlook.com [40.107.21.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BB1C3C16
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087034; cv=fail; b=GWY0016Qms5oc+xrsrprcd11d7Ftl+LciCrqydVVzQv/jAE4MLqeXsF8Zz1pZ121CQXPegyrsW8qwHtq4TSKR9TZpNtppu+DPugNoqIct2hy5tbmtZGtAeMiB+dQUtDhANZ2crbihNSNqTDOGfocCC5+8QhKSiVczQJFCFXkMGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087034; c=relaxed/simple;
	bh=eSn1iGVHnU8Y68rhh04tQlmzkGUgYJf+cdhfx4yCtJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcD2PsKJ56N4z2vDoRP42LirD5zUZT1iDC9AluUSDhgZLXtuhljAosqImUgpu8eLf3kxK1D+wKYJZ57JAQBCzwHl8yS4LQf1vo7nPv4rn1G4SqtAKI9djtWQ2xUmaZXHIN+EO2WL7GE1FZc1oP6PjYo2li/dcmX9CQeIvYvIXZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tracsis.com; spf=pass smtp.mailfrom=tracsis.com; dkim=pass (1024-bit key) header.d=tracsisplc.onmicrosoft.com header.i=@tracsisplc.onmicrosoft.com header.b=o2IzeJny; arc=fail smtp.client-ip=40.107.21.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tracsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tracsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tracsisplc.onmicrosoft.com header.i=@tracsisplc.onmicrosoft.com header.b="o2IzeJny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pURcAiXvQjhBeuXoM4MG0IiaBK5br4s1bsVW93ZrzovuI6xfpzsTPPoJu4GsULwOkoHikrsh8rIhkVBu+bGHLHX5BGr8WfeFBbJYlrK1VWoGlJ8YQhYV9rncN23fVI/MJmLk7yIz8eXMFlUITfropVWUYwO6lOO5hy8cC1UccbHiCgxDmFrDj2w/ozVPnPj4POT106dpc39+fReMwOfE4SuZ3ZP/e4Ly7YbaGoz05vY1P8xcAtMd9QLtT4+XzVphEqLDCgI7Mr2MyP3Si/LFRdtAEPC7i9pr4FMu2GFi4G1Y4asW8N+2N08CsuNUnixr/8to3MqphFD8a00M9FmgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSn1iGVHnU8Y68rhh04tQlmzkGUgYJf+cdhfx4yCtJQ=;
 b=YCm4ICl6U4I4r//oy+HGavsXRmKV2FMZ90G447DTtkeGlNdstfpGhnem5fzO+AvdQqaVkHnVAautdARs+kRZ+cOZyChbfmSF7KD0JU+Q1DOWs7sI+gblSvlIEZsWMnm4/Tal9TMrxE7Vi+IrixJGsB9jb64CL0nvOaP2PGcMC5JRNAXHQ/rlC6tLA3fJ14klPomLoW80dOd7MR6gPAgrb9biT+sm8JFlNjiCIjM8AEn5gMHUKcauYASdEwv19dYDEtDMF/NEeLPcumRahT4QiFlxV+Ywwwxn1bkdNARktuygeGGzFOuazRKChy+qwXk+Ej5tJrNYG4BTB8ply86Xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tracsis.com; dmarc=pass action=none header.from=tracsis.com;
 dkim=pass header.d=tracsis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tracsisplc.onmicrosoft.com; s=selector2-tracsisplc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSn1iGVHnU8Y68rhh04tQlmzkGUgYJf+cdhfx4yCtJQ=;
 b=o2IzeJnyColp11f2Z/H4bLWJgIvu3fkcMFNEYCUxgebRTSi7mFio61ul5x0uf4Zr/8VgkTGrqg2/dAViXlSNM593Y8iPnO+QjAiDKalLIKE7nZRGTde/lFSIkaxMTiED9y+pyEiGHj73610rXatmprUAkf2CM6mzaGjGGNVHAIc=
Received: from DB9PR08MB7194.eurprd08.prod.outlook.com (2603:10a6:10:2cd::21)
 by DB9PR08MB8698.eurprd08.prod.outlook.com (2603:10a6:10:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 10:50:28 +0000
Received: from DB9PR08MB7194.eurprd08.prod.outlook.com
 ([fe80::add6:5598:f30f:fd6f]) by DB9PR08MB7194.eurprd08.prod.outlook.com
 ([fe80::add6:5598:f30f:fd6f%3]) with mapi id 15.20.8230.010; Fri, 13 Dec 2024
 10:50:27 +0000
From: Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: New checkout --track behaviour?
Thread-Topic: New checkout --track behaviour?
Thread-Index: AQHbTIBrkyO6uFJSqk+vXLc0lrp5MLLiaE87gAEijgCAAGVzMA==
Date: Fri, 13 Dec 2024 10:50:27 +0000
Message-ID:
 <DB9PR08MB7194FF8C95C92AF26E1B8F1F90382@DB9PR08MB7194.eurprd08.prod.outlook.com>
References:
 <DB9PR08MB7194822B81F17420B2D3C149903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
 <DB9PR08MB71949D21F5F0E81911F0D50F903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
 <Z1uuqKI_2rb0HXhP@tapette.crustytoothpaste.net>
In-Reply-To: <Z1uuqKI_2rb0HXhP@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tracsis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7194:EE_|DB9PR08MB8698:EE_
x-ms-office365-filtering-correlation-id: 7af14975-48af-4501-72e0-08dd1b63f48d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3uGtTJnMEFbq8oy73YpinjICHWjfNhM0hpy2O8WpDrzHkMkwKzYuMMNLmP?=
 =?iso-8859-1?Q?W9qcDpBiWuZFqcYg6LiZfc3oU9E3jbIc/7CaVX5TVsbdJnbmM6JSF//2Gk?=
 =?iso-8859-1?Q?iUSJ993NzCaFoIM8iBnnYfDYLvMfWsNEvyBtedlY3EIfhIfpmC8LVeGBoI?=
 =?iso-8859-1?Q?bLRW130tzkkcNHSn/OTRPPlMtZQYzv7ekgygV2Zs0GO8sBQvvkut837ZF8?=
 =?iso-8859-1?Q?YUZ4CUWr72CmAmsg/eqW51C2CiJeadyeq8oizDFDP5PnWfD+bbdFPtYMiu?=
 =?iso-8859-1?Q?IBDqdcYICzatLIcyIhQB+a9ALFqjjLY89l6OKX18jh4Y7YNBPL/uF8JMGJ?=
 =?iso-8859-1?Q?ohX29X+0dT3Q9ibLyKD65+EsP5MA71KYji6QbXtZB4DTk87mUq1TJN8OjR?=
 =?iso-8859-1?Q?etrKbOT2BsrAbj0vtsscoM2z1mrg/xBgK0rPqQLiRQZNqn+mcprFqko/OV?=
 =?iso-8859-1?Q?BHTtXwpbJKR6O6lfiJIIklprzy1ClR1jMCuuD+PhiWq+9zKSnWH7qpHItp?=
 =?iso-8859-1?Q?ZBrJ61anJF6MkefvJPSf+trgPCkvIWKPNicSYx00yZDXqCRnNf4yahDQ3U?=
 =?iso-8859-1?Q?iYiyiTFJOSTcp0QCdk24hk43tuf1RiyETVYmzo5PetNQPkONN81lGrSSYO?=
 =?iso-8859-1?Q?vWYzhGuUJWVEGJI3oJYRwhnxe8Ol/EIXdhtGWgkHoGSPM0gH98AhTBdhpX?=
 =?iso-8859-1?Q?lPWwWebC3SdPfYHU5cEN4ny/a0y6WSlSIDdNdYF+89C3a3IoNiyiH9UhI5?=
 =?iso-8859-1?Q?IdnQL4GhVnnbUJLdYePubHRfY0YLhBCdqDV1akXgUijWjjhhPeyry6/uZi?=
 =?iso-8859-1?Q?mysqS5Zw2HBwHqa1n6LlVvKfajBlISyDF6AP3hJQBGH/zxyCoHJHrUpPiY?=
 =?iso-8859-1?Q?QYNY0NNM3mkj/VmSZVBfzLzuPs5/rtzVwwN1hJ6fRFgPVFJlPJkKBTrUQZ?=
 =?iso-8859-1?Q?k+m/qk1rd5rIac21nmJnJ7xGa7yjlGbi6GsZvP4jv+Q181XKrQ5kbpc+TN?=
 =?iso-8859-1?Q?zwuoh+ILVGhpdlm1xRtwljIHW/7BRzpmPhxmoXxWjo5RgeDeXWZ9xv59sP?=
 =?iso-8859-1?Q?FlDy1Go6qlUkU7gyYzqTbZBJK/XVq6P5W4XNYXJiufPN+/iIMp3ksc2aIc?=
 =?iso-8859-1?Q?QsnunYgoLBZfFMtPwwyj+WTMkdFBY8/WC/NnrI/TJ6lvtc0c4S8nxO/tPl?=
 =?iso-8859-1?Q?YBX/e+w/YJY/i7XUOd6mQtFGLHdolSiIS/FToUznrVnSEV4puTE6XJMcCO?=
 =?iso-8859-1?Q?Z/J34Pv7g+xEjP50eMJ7WyS9/DJq8oCn2BlEGyjoEjN7LhrToAEiFxpO9x?=
 =?iso-8859-1?Q?LVIWSICnVJ435q2CupU8+i9P5DIusqdratp4Us5w5p7lEwnaXy3fr+xxVL?=
 =?iso-8859-1?Q?PFYJ1q0uZKCGFn7Mk4his9kY18T90lHztlZg05tVCd/xPaDEhiCmYqefxN?=
 =?iso-8859-1?Q?H23N4jxs13X4bppTdKdzCjbAfps87EnpXSk+pw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7194.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6F7yyyKGgNcy/snM1KfHnAwZZxPCeCNRTeabHJ6+l+3wU/d4QdW5gTfqP/?=
 =?iso-8859-1?Q?paPGM4MiEhMi2afEVPO+nshLXEiiY83Tse9ERnGvI2PR0eIW64O/6usmq6?=
 =?iso-8859-1?Q?vM5Snm5Io9EYgaLGVUQtcQbNBmWDaC4wVY22FxUw2SZa/qiatDQDwqjSgw?=
 =?iso-8859-1?Q?s/QejrqDZFCRy2qQVZ7J2JU8bHB+CUGc2msDaP6tnNGFeOMHOA5hJT989I?=
 =?iso-8859-1?Q?cqETyrgFuiqGlrqMRNS81POwxVpf0/6zL5kYnAkZ60/4G4rCjIayvJPkwO?=
 =?iso-8859-1?Q?ALsMKoNFLY0LpAFJBELX3Oxx/oFT9Kz9cd/I/mP0wD4WCbNRNQ01hnfNgJ?=
 =?iso-8859-1?Q?kdEOtQS6Ig3tmiW0R+5ijx37hC3Btn3zsnjG1ArdhG3XCfSnxsJKIwN1oX?=
 =?iso-8859-1?Q?riNFkAiLPYKmX6DyDpPGmgA+R29aJxjnKQg+K/2jndhCStRxRvIgy58XSx?=
 =?iso-8859-1?Q?riQ1CKjE4++M46c8dY7nACGZchzZ8WO2C6zgXQtxPMH/HHtwc25drOSJl9?=
 =?iso-8859-1?Q?EQOCcx4Et2NDSNz4+0V5x5xD63Zi4C5+Lld7xERCBrw06UgRSr84DhGEbi?=
 =?iso-8859-1?Q?lY70/7luNNoWf+v4KTOCASb95/so3EzOBjxSbBXtxExWqJl93Ttlq5k30c?=
 =?iso-8859-1?Q?kVyhvczV32mCXFeGb81p30zPbc/eVFpk/bmDyWAcMEFQK2K89iSsGE5CV8?=
 =?iso-8859-1?Q?uZHejg0eyEAWOhvdYNod+6hY1+TIZkR9BUW652X9CQubdJYY2e8oWxI1LG?=
 =?iso-8859-1?Q?Pf7OrAQPci3dOp9JmXe39BeihbYyCPXBnTDzDy+sQG9ye8khfKMFVcX2Tv?=
 =?iso-8859-1?Q?KtLdNr2OyzwjcGyob0wqoSrQ9nVYrFHhiJPPIqUf3X3E1FpnC2pPIG41Y4?=
 =?iso-8859-1?Q?b5H4hNphWFryANuZnmcqaO2QZQjWxc1NH/jaFhfoxtNASOHW+RlxTJ2GuP?=
 =?iso-8859-1?Q?WhjryBhKq0qwXpli73xGl4SbROXCdnkpeUfGDmhsZu7a0fxFPXGh+Sswne?=
 =?iso-8859-1?Q?WFJRh1IYuPqCAZ7EMk+gNph2eUXBEC8FJEpg33lQLmdOSyZyqbH9G9CFXw?=
 =?iso-8859-1?Q?PKqCMvZGdNcG4EtsCt3hhCo144oevbO5loVM0S/2KQ4KLHJFcs23nX/IUO?=
 =?iso-8859-1?Q?My8nn6w7/t7zvHZ3fqyJ0nNCqp7viwYlnNj5oprYwA2wJjy8QQ0FLgr4q7?=
 =?iso-8859-1?Q?SVsNFJNRCJlhKHgztoJKY6ARCxhuHtbvPCUVqmwaekuhQd5chDQXEoITeL?=
 =?iso-8859-1?Q?wu0I8cHG3AW6EatZp6UkycNJRICL1ePbmcFWryUBQ81ITkUWrQgQXGvXPm?=
 =?iso-8859-1?Q?dDVNugqZ/LZiH6bNBiTRJxrgIRxgS1FU9ogqzLTL1J9M3hduYDpB+X1+1c?=
 =?iso-8859-1?Q?1YS014UFlp4ZRpx4E1TiCpsl5qEwc+9NKEYbzDJmNaVZpigndN2rv2Rb4c?=
 =?iso-8859-1?Q?OG5+EnOzcjJrpPOSwcHMsTr45LwknWJi/kjuGe1RLjxR6dyA73hVLSAY/1?=
 =?iso-8859-1?Q?H81xWHDaRNTepH0t77B+FvljT+z5zgNdGv0HWaCefXdoio48JV1XYAOmi+?=
 =?iso-8859-1?Q?+u24w7iMFNjgN54JH03K1QeyN3zglSv3eUiIYfiMgYoqr/SJVzJIhP/mis?=
 =?iso-8859-1?Q?aFl3jlTEYugMV4iiXaDQYoLPTAU7aIMlGqhNmQQgh7RwXSug9s1xmbNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tracsis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7194.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af14975-48af-4501-72e0-08dd1b63f48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 10:50:27.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b98f266-7d23-4d0a-8b8a-7e4cf7fded86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13optDZ2/ow8G9aYtdDTlUo0GRiFjCZlVte+OwrFPKb4NeR3keKGK3GS556QVYQxO7kYk6Yu17UV5TatFBOr58v0MmOEazgi1JAT5WAEgp0ON2UrCDJwJ0ac0XfMKia5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8698

Yes, that works! Thanks Brian=0A=
=0A=
________________________________________=0A=
From:=A0brian m. carlson <sandals@crustytoothpaste.net>=0A=
Sent:=A0Friday, December 13, 2024 4:48 AM=0A=
To:=A0Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>=0A=
Cc:=A0git@vger.kernel.org <git@vger.kernel.org>=0A=
Subject:=A0Re: New checkout --track behaviour?=0A=
=A0=0A=
[You don't often get email from sandals@crustytoothpaste.net. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification=A0]=0A=
=0A=
CAUTION: This email originated from outside of the organisation. Do not cli=
ck links or open attachments unless you recognise the sender and know the c=
ontent is safe.=0A=
