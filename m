Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com [52.103.73.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742527816B
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733722; cv=fail; b=KaLsHu21FBDK86K89wxtUukD0f4boA7KHwoNvXYjXmzr4tw2UYbmw0xC/7C+rH2C9QEObBbdu7H59Dry7J+djtFNedjcLZYq6THouZLoBXJUt5s7UNsd28xYrr4eS07A+1z1iDyYLiQQKugfOvDoMxBkkT2HCLLUWqMCZyCBkRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733722; c=relaxed/simple;
	bh=KoegwRMxNPps3C/XvLwwF5fRuq0mm1KG5hGRozWxRPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V21vdDwoRu4TuvC8A/Bu5BPrYveAKRTnJAI7lytrQUo1u/OyoTIDQinLz88abSPwFn2HRafVbElOdAm7H4bZ46Ij8XQAV9XLxK4VPmxXRzdIzKQ52C46xw3iH50Hz1jeXHZJhJRsm37RydAGvCHF1rFSSdPeHJvq0aeZhFF1fK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au; spf=pass smtp.mailfrom=live.com.au; dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b=cNzJAnVV; arc=fail smtp.client-ip=52.103.73.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b="cNzJAnVV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veMkay+9he6QwAGhuZQB3WYlFmlM0vX3pAjkbWa1UFxFexCT89LOv+6hNlE5bOQkG8czK9yNJxLIeTbohKrcfhE5mXr83TrhRrovguWn9vb16gGnyHqa8Ud5VJFUAYf5EgV9dhTsyemLQBVv1XcPnfnKvuiZTn+gSn9CTETIzCfK1UqnB/8i9kB6oIymn1u8Hol4ow4WH4FXOP1SPwW+JzXbvPe2zrNe0JcH2kK8RDIuXD7tsxOQNwBlM9LbtKxj1bfnY1LLsaQUnQ3c7tThhvKATsrAsTakVbgoqUMCztNI0Z+MilwKq5YA9Z+M+J+lnGpynSEsm0CbWeVIaJk6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoegwRMxNPps3C/XvLwwF5fRuq0mm1KG5hGRozWxRPc=;
 b=Q9EygUW3wXDTrA8PdC2vW4G/GQKNeMPblnju5aWzi7LzQQxyBE6SS+cBXiACqrJY6xynzbLIrcqkD8V94lXiDmsJcCBkP6CAhtNxVqyhefAQpgylP3d4cU6hgEeWcC73AEQ3EJDkp3r950MJtYGjUFc0cyzqgDSPRuak06T5lJINrZzEA061FUVc3mQGM7PVoaVRer6u3cIr3sA9e9TdA7tkh2em9NKL0GwnEzbkQP+fMCM30JqiMr9cP1PE0IQ0BIaWXbyD+asxVBsANUWQg0rdfSOfTFuC1iOCgTKDCXj9xm2q+tM6hioGYp9UlBc0miva533dCdYd9kp+vS84SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoegwRMxNPps3C/XvLwwF5fRuq0mm1KG5hGRozWxRPc=;
 b=cNzJAnVVKZika4WZjgsVQszTF8zLCzn1sv8fKwJSrDvASi6YziWccXulyO6v/xhUv/hJb6q3PThNDDFNqUhOkwP4Iw9FQxifbYj8mOCbsrOoDxuwDdW3R+XwIeQXwDX7wFCyuoTE7W6dQcU4QCgMy2TJi6VvvoK42h9aa2Mb8UTS4FYv9Lpf3YEu1sCI8vZ4RFmeEKsVluRx2wXZx74DW+OrHnBaEM4c8wDHIaaJcM4x7qoAajfmaab8Ip+d/B11bdKSWWWa1RTHc6R1opS3RmOL+t3gh7FTrnL1yXqSg0IT4SBnK7fseyu4QvRq8M95pOKD0DbA3Cdp/1sJdK6Btw==
Received: from SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::12)
 by SY4P282MB3777.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:19b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 23:48:36 +0000
Received: from SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM
 ([fe80::96ea:6ee:6820:6f1f]) by SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM
 ([fe80::96ea:6ee:6820:6f1f%6]) with mapi id 15.20.9052.014; Wed, 20 Aug 2025
 23:48:36 +0000
From: Isaac Oscar Gariano <IsaacOscar@live.com.au>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Some subcommands ignore color.diff and color.ui in --patch
 mode
Thread-Topic: [BUG] Some subcommands ignore color.diff and color.ui in --patch
 mode
Thread-Index: AQHcEb5ZxYQ0R/oHaEqDs/7wbWpO3LRsGVuAgAAcURw=
Date: Wed, 20 Aug 2025 23:48:36 +0000
Message-ID:
 <SY4P282MB2965003F2D5DF18C6252978A8C33A@SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM>
References:
 <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <20250820220439.GA1668511@coredump.intra.peff.net>
In-Reply-To: <20250820220439.GA1668511@coredump.intra.peff.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4P282MB2965:EE_|SY4P282MB3777:EE_
x-ms-office365-filtering-correlation-id: dfb17d58-9b6e-4ebd-d609-08dde0441499
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|15030799006|8060799015|8062599012|461199028|31061999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iPMO05xxg9pMWVvTV1lMbLPSBgJ1z+dflMCU23PcoduV/7UFIsigGLOdUG?=
 =?iso-8859-1?Q?R+5dqodzG9ASft2j7pqlZgoB9oIHMmsZ89LcoiodhGuS5dGENcotSxbdUd?=
 =?iso-8859-1?Q?rh/7lOPL8H/osJOWjQbFkKmsdvMZEP1CboBgLAN5wJRTSTPZeChzxJLZDW?=
 =?iso-8859-1?Q?biQWlWzhXV+wH2O4+E0SY2xQIo/nliljhj3WzYQp4lAcn2xwCxH5uiyqGk?=
 =?iso-8859-1?Q?gfHhu+ACZFsfxCNveS4o6ZujxwjvazmOuAdPX9VbK4hzGcXI8pcRvjho6I?=
 =?iso-8859-1?Q?i/0Cf/toFDnjlwKdkckM9CLqRey/xisXGBObpNWOFBRRSlsERi7+v7blOk?=
 =?iso-8859-1?Q?3nlGbCQL1/X+h07jjr7e7gfoCXPELS57b8UGerAFKpaFfTe5l6UhwYqCQb?=
 =?iso-8859-1?Q?MfblIQWpcHJ5DEATLF2KvA/CKYrgINR+an5ZwZ4PtZTueT2K7n7HzwwsgN?=
 =?iso-8859-1?Q?18y7OLb9A8WwvJ8zi4XOPYShaz46G2DoDFLE5/KgqRKp2wsvlEmLzvh8T9?=
 =?iso-8859-1?Q?FIKiwWdPHUKSe2E3uFtKc75ADqhkxFqbRfc/aO7gNTZE1bCfIN9hNil52/?=
 =?iso-8859-1?Q?nihmgZLKdoIJHhIfTHBHppfx/UPfgEOOdI6keWKL3ch4WDJk3QljJNxEx9?=
 =?iso-8859-1?Q?t+5ENYLc46H5WYlZB/jVf32h7pii/u5Szz0kgf2RNILDbqwJb2MEgcUyUf?=
 =?iso-8859-1?Q?FulT9NsiG7kNskzGaz2HQmwsQUPboq6dHzSU776O3NJve/vwBo6UPmP6Dj?=
 =?iso-8859-1?Q?YGnSZlv02Z3nPYRZCcLd9TtT5JfATzs5AV31li/IndbjiFSgmQ7kO6eOEm?=
 =?iso-8859-1?Q?pAE8Aso71Nvhl9evcKdHVo9CYf46L0R5NdUobps8a0A8Pd0BUkEr5LGzA3?=
 =?iso-8859-1?Q?M/L7mS1pDjLTVMdQN3HIEjGrG32hcWS4OyTYiR01qoym5Mk0UoxhlQoX5L?=
 =?iso-8859-1?Q?Vl6XPapUbQVQqW7f3wnWx+1R/9BVLpsd/pjGK0GVNeZgWb22qJ4e/wCkWV?=
 =?iso-8859-1?Q?kv2938kYNgP7jgqzPRX9ApG3J2Y81iTOem0z/XR9dB4aUay5og6j0yt0PP?=
 =?iso-8859-1?Q?tyrLf15XQGbwCYQEzSAUoLxs8X54UW+DTGWurmmtgkoHYF4dJ53srwLl0e?=
 =?iso-8859-1?Q?dZSR+2kcQ41+b7B53p+octLbS06bT75bNElNp+PGG56ByEuCyOxcX+wsPj?=
 =?iso-8859-1?Q?H8Gjk1EJ+uJRjy9JFw1JAi4+eHm83vEXwe3rB+d5fSaBuLh9u5tfiUaq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ysFvOhakqt9EZMp6U0VFeYAsDFCqty6ozn2odWxMzXjs7M0lagjk6ZPxsG?=
 =?iso-8859-1?Q?nGNR9iQ5+G+VTA1nko9dt0MWfTBzl8+rdiy11XHmzfP/m+3/ZOQOXCDwsX?=
 =?iso-8859-1?Q?SKlncqzdIaZ68WSPsrNRA1MXGRawAB0HU7HEGf3awJ8aALBi0NeRZqbe57?=
 =?iso-8859-1?Q?RM/zTjdN7M0ePjxwXQnQvysp81Pmx620Y5NOjrXHyE90Y+ARGFVpNXhRI2?=
 =?iso-8859-1?Q?JgtqfPqE2iQSQnfVtvrFqWQKjE9ajPY0NRgVfMd5OfFp+FsJ3sO6p2PdL2?=
 =?iso-8859-1?Q?TQQDcvGOQLUcbI6Phnh8lYV+E1vQ9BFEqtIEaIZRfJLyZyt11OM132R+U6?=
 =?iso-8859-1?Q?WWunR0jOHuUTCH2aHLx31PKd3uqrqi4/CN8sC3iiVSb2b5sGf/WYKPB7R6?=
 =?iso-8859-1?Q?CQJSIz/XkOCbdF6qmwwBFTC4XW4SunwEePK9RusJZxZVC4wnPLi9d0pWRw?=
 =?iso-8859-1?Q?rdvLHf+wik8/S9zDbr9XkVty8eddvDFUmkbTgmRqi4vJpyW9YjYrwxW+d5?=
 =?iso-8859-1?Q?sXCA6f8OREmyhdNphlcDf0rj2ifCpqdH7t6t/BbSu6L2LbJIgd6bh69Ict?=
 =?iso-8859-1?Q?Suuh5qf2YRXiTQ7kM8W3xOcu6AWTaowHZvXxKe6AbYV31JGhI12bNRafxD?=
 =?iso-8859-1?Q?ho+i86MTZfcY7BsAVIAdmDGvE3w98duc14WxhW5k6cOd21F1OraeySgMQ0?=
 =?iso-8859-1?Q?p1cDdH3nFPyGo6qu4vD+PY4uDncfnM2K2J3+wb9+cWbiAjX/2zld93TagV?=
 =?iso-8859-1?Q?/nAlgdOlOrZw9Av68BMc3kgpz5lKXqNzK9pCumCEidSJ8pf6+2l3mXgSY9?=
 =?iso-8859-1?Q?gbLkSLI1iH9cyj84AvOjsYeCVPzMH7WwWjKuYhYq9MZLsCjmXnnFt6mazR?=
 =?iso-8859-1?Q?p+LmXAwiodHzfmfJ6JxANzPON/jzhCbzYSn9qBDZ5ElWiatb9LL6WuOLid?=
 =?iso-8859-1?Q?DPoXS8NQwnmDJa5TfF6lhJ6UVZ2FzeU5TpifmDs/OqZcrjbyS9OpWymJMG?=
 =?iso-8859-1?Q?hJafCuzYQGelfZAAEAqjqgUr/822Bo+cqm1qJPv1tksqzSfPW2xhgCYTiv?=
 =?iso-8859-1?Q?Kwvh+QZVW0l6FhodZ52DvFfkkF019Bqp7gIhsHw9zCmUDggiKhmivFNnMw?=
 =?iso-8859-1?Q?tvAghNFEgfQJzN11n1DIQSJ7PgAgUiwdrxlaM02vXnVuurL9yradUB6WYx?=
 =?iso-8859-1?Q?4rTf43XyY8cYEZcYUNC4dVKHehToPRSVQ07MsZXve2xEwVvg6e/RL6UqdJ?=
 =?iso-8859-1?Q?IAuWOx+xmGLSIlXXnGAPmT8OwpMR7Sw44CeLiHywaQRL2kRDSfBGmE5oeJ?=
 =?iso-8859-1?Q?v3t87J7kN6NY9DoTTnnogBc/jTzuuXPnU3vOcBUfDUjZKI8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb17d58-9b6e-4ebd-d609-08dde0441499
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 23:48:36.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3777

> Have you tried setting interactive.diffFilter to "diff-highlight"?=0A=
> That's what it was designed for.=0A=
Wow thanks! that worked perfectly. You really should put that in the Readme=
 (it only tells you to set pager.<cmd>).=
