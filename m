Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022085.outbound.protection.outlook.com [40.107.193.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46D241C89
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067196; cv=fail; b=ajQuUEVdyGa6K+AzvA+fx/UOooRDUOIp5KtczW10V93RgFUgsjUKRXCPQQc+ewpeWW0ThvhDPxWtopaMPjBrSbbj/6NG8qU0ZEfwjfAzprXnxvf3WQKxxsWsxfPicRypUuhJ1O26hQs1kbqSv0IMlxeyj4ULJgFJxm0wpuQBswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067196; c=relaxed/simple;
	bh=DSxMirM8kFl2nmudR1sXWkd5NzpN9/+IIhsa566blpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVAAnxDV5m5VYhLdAnQ4s+dCNpZ9oFI7xvHL8euhlMBQb/YHjSYu3GshVD4XNplQxg7rZFe5nW6bF8iu6z7JTwig8TtJNrmqOvYPnnRsgfx7ismsAvy9y4n28dH6rCFE6ZL6mnakDzxspmZ0AoJVfjglM2u11hme/T3z87eNiCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com; spf=pass smtp.mailfrom=kaimaging.com; dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b=YJlgMgpM; arc=fail smtp.client-ip=40.107.193.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b="YJlgMgpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD64TBCF4Fwq1te7gSvmErX0NCUkjqihWACHfGBrWzv43TIm8VxTMnVI+FgXZ72UrEpfeElW1bIbo9Lf1XTSRK10fnkGEznzQTW5VIbyIsdHtrjKineKxNbxowS8a68+uQ6vW/7FT3mYiiTQNKo7wScgWuUydu9W5cbf32O/Pb3W5vDaHQWR6GT3Z499J5su9JFkWoAZL9IUiNRT3s1+4fl1aEaYfDZHzUQq/weCDI5OamWkdKuhfgz40Zm9JJlFXmzVp3o8SIPkuQjtuMXWBa1H7NRygLgOmrfhR8aanEMEUMYUfKxMy39jG5vWvVjMYfhupR3HZwdor2sh/VHCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSxMirM8kFl2nmudR1sXWkd5NzpN9/+IIhsa566blpg=;
 b=umUo8lXBvkDWY7Hrbm6wRH7E5y460e1tYhpLYb3jR2eF+7Ev40UYfDf1jdpbdel3EY44lNiaCJQ4sWVx0SOv506jntpI4l4M3CjDLUDYak1xaAjR4cvS7h9S2/MHZupldHRXEihHLpw64yyxm76lcym0QDasn53eXINyzken2U6ENaHz0lowq4/lDAoVchY2/TGztho5VflLo2WT2FP1/uBxOjpIA/cWhQTIGyigof4mrpeCRJUeUyVhoVUfL/NEue4ScS6fD7+dMR79dyUkUIe8y6SpxQuanIGDN+TQuA8q7jN/htLTj6/4J0guXBvjunR8jrGtGF1zJhgwlHgVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kaimaging.com; dmarc=pass action=none
 header.from=kaimaging.com; dkim=pass header.d=kaimaging.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaimaging.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSxMirM8kFl2nmudR1sXWkd5NzpN9/+IIhsa566blpg=;
 b=YJlgMgpMwNaX2m86WXZtXVKAJ8tq/xN85uMbwao/MDBYB4QEnUbO0/uRlbMDmWXxXauXT9HMTqPsapHiyQlEhNqJ4QRs+cAz1nv1QnAZ5xU40H3IRLPk78cXfbzEF+t9K7LQdcMJ8mwGSOI5dNvsOmarQ9mFfw5ZCoURwZVSoYo=
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::626)
 by YQBPR0101MB5261.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:26:23 +0000
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e]) by TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e%8]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:26:23 +0000
From: Stuart MacDonald <SMacDonald@kaimaging.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Re [BUG] git stash incorrectly showing submodule branch instead
 of superproject branch
Thread-Topic: Re [BUG] git stash incorrectly showing submodule branch instead
 of superproject branch
Thread-Index: AQHbw1B4HYk/J1c6sUuEX9hsh2ifmbPPKssAgAABOAM=
Date: Mon, 12 May 2025 16:26:23 +0000
Message-ID:
 <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
References:
 <TO1PPF29324B4CE6D3518208073452C3C51CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
 <20250512161253.58427-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250512161253.58427-1-jayatheerthkulkarni2005@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kaimaging.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TO1PPF29324B4CE:EE_|YQBPR0101MB5261:EE_
x-ms-office365-filtering-correlation-id: f3990d83-eb9b-43ed-1103-08dd9171bc48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?dGdGwRMRmHD9Fj/6OntP6ySRd7XP5zqtyzWgEIQU1dzlsZiUl4GPspLr?=
 =?Windows-1252?Q?S8crA029GZFHUwK64e3CJgVr1Lc/Ntck8Cnvu9QJ993BbsSZgRdmYIkn?=
 =?Windows-1252?Q?8pMB7gK1Imz9t6K16JXKUszyCuk0r6iCaSnNLYPl63fI2IwwrE5ttb1u?=
 =?Windows-1252?Q?CTmo0XR7CigMoUZ4XNfltiHUxEP4L28eafAU/Mw7GHfUB8eknWPeQD7e?=
 =?Windows-1252?Q?ymt0Rk1uloce8ctM/xIxXKCNSYx3U2l81uy5D4SBnDioWFSVEng0mx+0?=
 =?Windows-1252?Q?dD10H4J+uAM2v+qQdxKi2qMcNy+LINumgt+Gx7whHTu3IfMs8Ka3IJj9?=
 =?Windows-1252?Q?z0CcpUz3DaQfK5XGYmARdHwlRJUFgTH2LYkPx+yJmC3FAJe9Nle/EqJr?=
 =?Windows-1252?Q?4Jiw44QwIXGhC9wUHJXGLvhCKSpT2XelI7qcJP4JlUCpKNw0D6tMWTtH?=
 =?Windows-1252?Q?mgwnhfDCWU3JIhG6KlIa1i1bzFilVmjdojjz/irwAXzdGgzYeaIRswDy?=
 =?Windows-1252?Q?ga9H7UCqt36YQRPw4cHnUIdfeyefyyEacW+JgylH4+W1HsnFhEL/VHBl?=
 =?Windows-1252?Q?xzYo+Fn7NM2pZA6CfXuarFrTD6dRKyaVycExOTTBCuY72LTlkkxESQnv?=
 =?Windows-1252?Q?hCgJ1Nx5/slJ5bDWqVnSgnoM0MdYqFgvUrWK8Aaokk+xAShbY7ETK2CP?=
 =?Windows-1252?Q?5TODlCSFFyVx5v+KnqqyAMDMyMpM2Knvi9ZYPCDarVjrHDK8ToqYoFGO?=
 =?Windows-1252?Q?K+lVqMiCfcKSDHDsqgWEpcgnWnYajK0+Iu5NQTjOf7/MjG69qNXUG4SJ?=
 =?Windows-1252?Q?gpTG5OBZhccSYA8TLr+eNrkH11Ivtl9Oy6KcuM7ndzNY1qYHArWbeehr?=
 =?Windows-1252?Q?MH+SUj2egJJcCMC7ZaV4RhKNqYZLNkUtc/fFlMpHTJAFXXvn0Amw0xEb?=
 =?Windows-1252?Q?y7lbxDe6B9m/vb+dvVux4UlBaGvnzht6OC2mlQLV9mao8YOXw6/J2z4M?=
 =?Windows-1252?Q?jgMcT6yXCbCCR3vD7BoIOSkOJ38Iut2fK5XtNs8lL7WcBQO3EXfiuqAu?=
 =?Windows-1252?Q?IoKryg5BOH/ONc4O1XfUSFuU3ZgTXg0HhBVIERLsMP7/Nigi+7s6USXb?=
 =?Windows-1252?Q?Ox1A4WexYAA46PqCCp6YIEoZJ6BjYOL6oIHghkQeqAZtlWsrGWkboQK7?=
 =?Windows-1252?Q?Wlyphhx1jHSzwSpvslOBRPZ5Cbw5h91CsXn/ZGbqpRkity2JNbWzklPD?=
 =?Windows-1252?Q?ShEoSlEXzV7VnG3d3nuSjSA2g1GFFEtr+iVDAr/iL0GAlQlli/ee09tI?=
 =?Windows-1252?Q?nGqwbajA/SgJ3Bw8/lEBmJxbd1kisVHvoWYPW5OmumxiiL3q9d3fBPcU?=
 =?Windows-1252?Q?QgLp4hUpsb/TCOVsxG74jrYbptxpuKmqlAM1nBgpqw/ksNAEVnMd98SX?=
 =?Windows-1252?Q?h7onFWI0PKiWFykGfwHL1fOyLrInPCFh56gxUZNWZLa6T779lNCiQBzv?=
 =?Windows-1252?Q?7MnMjqTQ+BB/I+UVVg615yRXnvSV9j4RSUh4nAInWWhLDdqg43xa2nfm?=
 =?Windows-1252?Q?Ok2hl6wUUPOJRC8awQG+4d2fdfBuA1g34MIWFg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?ySg4ukVeX3GypcgTW4gjZ6o/dJgv9x0FFTaT8fCaCjJN/K5ypCc5g7Em?=
 =?Windows-1252?Q?oW8rV1pcVnhMphQWFkK3MC0FjJfrnuZYFk/ir7yr3MOSZi7wMoAZkRGD?=
 =?Windows-1252?Q?KjJ+TZCR+rPWMPHxpMFVl5RHkV5in3p8ghZs3yaSWZZkGnc8kNLjUIvL?=
 =?Windows-1252?Q?fnrQc8nLmzXf0vYA4LTXrGVV0oO3RH0me67z80mD27oHTHHyO/4RCr94?=
 =?Windows-1252?Q?zkYFO0lejbIj755JBpttx/IZTi7ZxT00PwSrbLLvkEuN7AzkLxHKwlVJ?=
 =?Windows-1252?Q?B+0xjv9qvRh0ZTlgBCz8aVqjcqb91dmyTxEDLlr/VA01Rw+lt1sL0gCZ?=
 =?Windows-1252?Q?UvMUSNCorWDC/dKram/Ssv5u9X+RiDP1Wd0mOhRRYgdyCMgJygd6VWcr?=
 =?Windows-1252?Q?xuYtKN4ri82GUyfryEWdFWQdMoJ+8/DNpNPa/Pm8BEpARzitYIkpO4mX?=
 =?Windows-1252?Q?+4Ki36dWb7may28a1QAYTlpYP5HfwLfpf/zFBMDzOZB2MWN/zVx3RrUm?=
 =?Windows-1252?Q?NXeMaSY/Ztw2W7a1sspzQN8LF2UoVfjyyqjpuRygCphskdRCvTtMK8mM?=
 =?Windows-1252?Q?8Pp65A9P2E8Aosz27mtcAG4WP6QQWDBRFoZL01nkYfeqd4K7aY7ZB5vm?=
 =?Windows-1252?Q?Ugua4EeAoSXhddvVGtt643QGHBYSUfGXCDxzkE+Li5o27ShzSiUadVNc?=
 =?Windows-1252?Q?JyHv7Oe0Rf3mOBvgGkY7e4bn0NfTtHRnZ3DeSQOp+hMorFLMP77ad18a?=
 =?Windows-1252?Q?GUGy9t2l9/03BtBeLzO1WD8UaPSuNFHgvjKG5zY/WJfiafgnpGvgbvt3?=
 =?Windows-1252?Q?lIZ3lv0tbGlqjlNyID6uLmMJC8H6vMlapWOjcIcp8knXmyDGTmV4mNji?=
 =?Windows-1252?Q?hvcHcvGR9053Sm/b1DFr2xktCDrmLx2RKH6xn/RhoQyykx1qBu82S9g1?=
 =?Windows-1252?Q?2g3mZriGuXCKpAz+/tRvaFZi1iqRJf6ozBq8P8dmNvoMXq/9BM5mFcPg?=
 =?Windows-1252?Q?sMIFN+fDvhQQKraEta6eb5bcOnX3JRJuqvijNE9NKIB2Wt7ajCM2FphW?=
 =?Windows-1252?Q?Ab4X9iCKOqK7IuowltD07g9AaLT3W728wk3fHg/sfAd9b9BMYm4dtH4i?=
 =?Windows-1252?Q?+FnuRI0TqUDf83hBedcmjMOSWEUm6/su5BewqAnGpGHa5zz6QNHRHuT1?=
 =?Windows-1252?Q?AgDGzOvzolBvTjXQdDR/a70AyRj66NCRlZiEDpU/uQgw9fTyxEL9vsYG?=
 =?Windows-1252?Q?j/DAgJ7ICTYoXK/WIdz6Nh+SeChiM46ZpW87A21wkiZbVzE/O6vmmFV7?=
 =?Windows-1252?Q?18Sj4Ygh/6+6OdFtKDLZ8OI4UPvgTwvbvrQ77mTNek1GIS0jvSYseFUc?=
 =?Windows-1252?Q?CiD/t03O2ieOPPU87OEL9Tp3JRj5Tcz29uSd8SQFkLvED6gpxAKvG8A/?=
 =?Windows-1252?Q?bj+UB66w/+MFWt10paKdRmf9HDiPOFBjjUvaN6PpiOC+3IaNxPbFAu+i?=
 =?Windows-1252?Q?/7td8QLG9+VKperv+rti3F0epDtAbF8EzDCbO3v7UyZMAOm0VXY+1w2i?=
 =?Windows-1252?Q?g8Bzu7rOrWdZxjw6/u3FVMOK9PruMjnAiGkd1h+T/73B4m5nmmRqu7LO?=
 =?Windows-1252?Q?9wpuvZa2WyvD14S4KQJ4U6vjienMY1dd5nxcwcLZfxZKS0JQBIn/mx9Y?=
 =?Windows-1252?Q?EnF88QtO/344EVGF62U5lLrszvgeCWvN?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kaimaging.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f3990d83-eb9b-43ed-1103-08dd9171bc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 16:26:23.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd646163-ccd8-44eb-b4ed-abc194a640ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c89a777z8dYDiNqzP01G05WtbN0xGjSkmcATWvygU1rpeqJQsZotEBPwLtgK0aRZrdwHzj9ML8pF/HD8WaJIipuQ2FUNISCp3lQpMAX86Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5261

> This is genuinely one of the most interesting Git bugs I=92ve seen in a w=
hile

Thanks. I think. :-)

> The historical detail you shared (that this used to work fine around 2021=
) is helpful.

I said I _think_ it used to work; I am not 100% on this.
I can say 100% that
- I've been stashing for a long time; 2016 or before
- the repo with the submodules was in the Apr 2021 - Apr 2022 window
- I don't recall seeing this bug at that time, BUT, I may have just not sta=
shed anything in a way that triggered it

So it feels like a regression but I am not 100% certain.
CONFIDENTIALITY NOTICE: The contents of this email, including any attachmen=
ts, may contain private and confidential information intended to be reviewe=
d only by the individual(s) or organization to whom it is addressed and may=
 be legally protected from disclosure. If you are not the intended recipien=
t or an authorized representative of the intended recipient, please be noti=
fied that any review, distribution, copying, saving or disclosure is strict=
ly prohibited. If you have received this email in error, please immediately=
 notify the sender by return email and delete this email from your system, =
including from the deleted items folder. Thank you for your cooperation.
