Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2104.outbound.protection.outlook.com [40.92.50.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC4146D7F
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732956112; cv=fail; b=oBNqsOsG6qv4LbOgtAGB7cQVj6lzZVRQTh7u7cH4OP+OENhMfvmnjkm/uUBzNnAXWgUy83VoTxoiBsacspX2Z341aQrKS1KnBKJOwwToS0qR8QUEOYgs5iMei1E5+4LSHBomtOvlbUUfvKxRPkOt3F1mSlFk/G4VJq/LwQDYGEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732956112; c=relaxed/simple;
	bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lCRFxSTJpXM/i89H337TXbnCS3glcoUafPmY55B8Hqx0ios9ceC28UKz6VBH9hkTN4eht8klsEANsQj+sz5WQMujZr7ZPgeCoxxTle3rD/YyY1pBai5CUalVLNtDaS5T+eHm5v7eR9Cu+GBUYDzLBlmUMRsksskcFW8/Q9H2cjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=H2NomDC/; arc=fail smtp.client-ip=40.92.50.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="H2NomDC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQWFp032vxo1vC3IAd4b4bSJHwi1n9h4ApIEfus5iTofcDoX1kCxia0mJeGibE4Q/0xnft1OyBf0SH7dxt+S43YSV6DO6i14im2utUvnT+f2em5dmN+dMhzW9pZzwagTJiMrk5PJUOLphu2gXDnl6QLXM9Tn1/RVii7nfawFN9aekJKoXxexit4DaF3+WaadGbJY82gOKt5CXsAz0Dkd/DJu6++ZJ9DRDZp3PDW423OAt5uMniHfl/JbkJ1couCLZ2f9SpiTrdcnijh3p5j2DrYHBOQU2AAXlT/LUpmwa70MR6QZIXmLiHP8v9cZM0MPt33ZRXVmG1mF6MWlp3E3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=;
 b=M+Np7lntlur+ZeA5+lhMXd0/Hl5fNiA51p049loI73WEK1kXWXtjS0ihbx3OK2qpCbQBmzOeTejR82muCNF3eiRV7dpm86QFSLLbblTAwN1vMz73nS1xxQ7aBKVLwyIMIP8ULmPHeHPBRLOUtwKPT2lFPOTjCqsUl4sTzCBcPPKBSQ7w3VgfHffTjRc1NCQLOGQ6Fs/f8ZLuYVKEWxtL0ymkVmP1UuiBx5TMRCucKLW4eJ39ODAefTw22rDUyVYPfIrJ8HCgm7hyjs7/iP7QSDcoR6N9rfEljhWDY8pVWYqEWkLNszNtJeDbZYOjTH51juwXXyKTjbKXFNooidzaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=;
 b=H2NomDC/o7DptMjsNlptt07mfUF+0iaGkvg5+wHM/xon+475KWIfvdYnPy26iMOEcp1z4rkfJ4FPAMWtxv1D3iG3gEepjbR94Ol2vz7LNiIcsazupuWaTGBAXOVnna4nBm9EOvFA4M39PKjGfxP8ob7vzMBOiB+OhWwR3otpRlVIPT7HDvdQeTSPKqh8hOdiogy3xl7FZ0blMFYeAifWw8pvE+/ekjt5Rv+zWIUIiVv/Sp11XSA/s8bKz0PgYkTYGkqVoHAdKN6XFAGaKkUEON0MXxtCizNIX9ZasxNUhEmNIy/XUcQKzrY8YtWNoP4HDGV7sNCdx4un9eWXIQDEWA==
Received: from PAXP195MB1279.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1ad::11)
 by DB9P195MB1163.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 08:41:47 +0000
Received: from PAXP195MB1279.EURP195.PROD.OUTLOOK.COM
 ([fe80::d88e:1fae:fb54:79c8]) by PAXP195MB1279.EURP195.PROD.OUTLOOK.COM
 ([fe80::d88e:1fae:fb54:79c8%4]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 08:41:47 +0000
From: saul cleto <cankossontjen@hotmail.com>
To: "jakesteward0916@gmail.com" <jakesteward0916@gmail.com>
CC: "ae@op5.se" <ae@op5.se>, "git@vger.kernel.org" <git@vger.kernel.org>,
	"junkio@cox.net" <junkio@cox.net>
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Thread-Topic: [PATCH] git-diff: Introduce --index and deprecate --cached.
Thread-Index: AQHbQwOx9LBHBawPa0W2bXSYXFIzIA==
Date: Sat, 30 Nov 2024 08:41:47 +0000
Message-ID:
 <PAXP195MB1279EB353A0A867E256449C1B32B2@PAXP195MB1279.EURP195.PROD.OUTLOOK.COM>
Accept-Language: es-MX, en-US
Content-Language: es-MX
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXP195MB1279:EE_|DB9P195MB1163:EE_
x-ms-office365-filtering-correlation-id: d1e0b284-7a1f-43c8-cfd2-08dd111ad3d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|3412199025|440099028|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c1ROzcO6ws2oSUIBS1bEyxcENOND9+YI5TrjudQiU2yvzrWCXNDwuIwibVqv?=
 =?us-ascii?Q?YtRf7lUgKrlGJ/OS2UaNaCo2Gg9f3DABi+gE2+h0l4qS1ayaETIZcFyMVdFF?=
 =?us-ascii?Q?w3ZBaGK+AyYXHJa2raKNAT3gj0KG1ousdtP+ISXTXuwJvNp6DnHb/NyhmQAv?=
 =?us-ascii?Q?YMwrInS8lPkPoWzaTTQtGSkJFcBa9BwqE5qBYFJdAVtFhoKc68x6ZRS7lh5B?=
 =?us-ascii?Q?umQtjAPnnMC0PTUt51aw4IO94dLb5PH8ltPF9V9j+vJp6bQRFSiuNan5st9c?=
 =?us-ascii?Q?Y96kscR6M2Ys5+TZzzuw83M7ye9uS8pThSb3S7GZzUulW6TFpfGdts3a247u?=
 =?us-ascii?Q?iQ8R7nmMkdqiB/l+CJhFsGhmLwzUIqCQ/Tzc1Y1cROKTGuB5yfOoeAzbEmlO?=
 =?us-ascii?Q?XHTD0gUgPkLDa5c7yXUHakHWcmuyCgsSwT3MkbUPOLkGP4e0m6ABPmD20E09?=
 =?us-ascii?Q?PjoSRejw4huiGtQTdbnyyEVE5XVds4hp9af2ODdL7kawPKA4rZWY/gN59Bse?=
 =?us-ascii?Q?CxJCWMtPl/QxA06yf82piGJ3Ct2dwmeyRiuQLMZiPj9U3LZj7npqhxwB/kr2?=
 =?us-ascii?Q?SoMig+lQUIyT51Rc8Vi4xs8DdHqGKo8/Ma4K/um5nczxfgoG02VnSVkUm0kF?=
 =?us-ascii?Q?eXgsgC5uIRDGQEhf3q+28Fcmr3aD852K505Sh2L7Bv83KTC8pyDsTFH2/925?=
 =?us-ascii?Q?QieT0rbjMuy0ebMMWVs2pGG2Y5adZBfZHaKgDc3O+c1VHHZwfzVO2zt61beC?=
 =?us-ascii?Q?cglTRQlUZsUCU5WVSQsCYblp/NQNo0O2VNd6go3GFa+ucKJ1ubXtWZEmt478?=
 =?us-ascii?Q?bmune0AOMeAamRe+Jw5hbjfydsOrZFp3nlCxWNy6Qx7H/vEvzgMTXlg2n8/s?=
 =?us-ascii?Q?jaNF77jLmC7bzRviwHpi9WCkAT3sZvsXjGokTXspyu4Jj1OxEg6nEPSC2ApG?=
 =?us-ascii?Q?n+c14hj3bQw/aWalolcT7xaB1NQNYVB3awoMt7qKzqUI6den3TseW6WHdjnZ?=
 =?us-ascii?Q?bvOGAgUqJlFH7Pr1fwVUR/pdbQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+E3Mt9Ce8BZXa+opRHfE7OpyL6bnrO6k6sc0PnXMYh/6B9s1anolRZY6xcun?=
 =?us-ascii?Q?H5u7aGz0Cz4BNufqMyHI1FKmsSlf2IDBNYssR9jWNqn2B2BRH8FIJiO2icCQ?=
 =?us-ascii?Q?IxxuSZZbm1K8+nTZwMWQSROrqhfglf9tKJ/S+xTV0GH+12tl66Xkkp+MaWCi?=
 =?us-ascii?Q?Ap8PS6N/LDU1i+PR2IfZ+KmfeRqa0llZtvCo3knrYH5l9mAKmS7ePL8dRz0S?=
 =?us-ascii?Q?k0Bjd+67y0a14G5LoAv1w25lt3hYcDBZAPkepHue4cdkE1unRU0+WtM6uMIR?=
 =?us-ascii?Q?ebWuPkMvZiA8s+vvIwNVOr+XU6MYoAyWRGN9z2RRgz2eYfu+RlwLNjz1+Fnv?=
 =?us-ascii?Q?wASBfnVjyf97ePrFaGLQxUPC+nbesAbBTpHSzXiSUEYdqT9IXA355mKC0QbG?=
 =?us-ascii?Q?lkydO4Li+8aKx4enLuFXyB6MTvFp6vZQPFPsyewKynpG2bcRlDpKwCZuypVB?=
 =?us-ascii?Q?UEwH9oLb+8G5nDsW3dOs9dUiJOdMi4EcCstGNvdnUEQGLQ+P/z0qTCjD79Tp?=
 =?us-ascii?Q?M1w/3qX4JBVQ93ZqdOYh3wZeL3yn+ZMmN3sLhmzWgU5Sguw8BaX4RRMbi9Bi?=
 =?us-ascii?Q?7VQaihUIlpxClOnKBPQS9L9p7ihnalhYqk2LDzoJk+f981hH+0vZ/e8uwgcj?=
 =?us-ascii?Q?cun8kSLCowPA9MVBx1BOw58Qd5wIJxt8WxxRIsMFIUUtwB3uh/MdZuleyn+X?=
 =?us-ascii?Q?PHRHnJjPnMGdTDpu3sR8pqoD3IYspw0mxdi2pNPrbyQbf9xSpv6hPFMImOe7?=
 =?us-ascii?Q?MzJYsjW2Bj7Y6hTseCE3MGct07tQpSgXhaz1ctEzmFWUNyjefOWEYY1IRm4Y?=
 =?us-ascii?Q?8+Xvo44PttADrMoy+cjjLsD+cb6GeCM0MPIAnv9L1/wzr9tvLv57eU3ImXjh?=
 =?us-ascii?Q?KbcTuRyZEcB/cWCEbVkHKCJR7vUnbDoItNwy3HLbd2URu2FeTW2N+mt+scxY?=
 =?us-ascii?Q?NPpkk1ZsDQyqs8uNeRMROOPILC9dggdwITF4YGw6XV9Nx2i9X4vxEqB/mzIZ?=
 =?us-ascii?Q?y+41nta9Zv1bwUcjunZQ3fY4mszjAfiFuHCRqdouQ3ar8k8Gc56l+ydBlm1p?=
 =?us-ascii?Q?nJokXFuIql94s+oZDC+EMGd5Mmtg9tPUyRHeFib61OS9XzKHYBdNnnPDPDr/?=
 =?us-ascii?Q?mkdokoEDCRDWxu+TgkMClORwDnCa3tHXlG7ScxxVK5/aukrc7izTC4CEZUZc?=
 =?us-ascii?Q?wntnXqwQh+b9hVB6ya7kYgxsOtoxxnBfzAQUM+doFBr/tYmwIib6s+TSd71y?=
 =?us-ascii?Q?tBZWCZznSg8h7weq2V3R?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <D4AE7777AB117C4A8FE2441B492EB8EE@sct-15-20-7719-20-msonline-outlook-1ed92.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-1ed92.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXP195MB1279.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e0b284-7a1f-43c8-cfd2-08dd111ad3d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2024 08:41:47.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1163


Enviado desde mi iPhone
