Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2019.outbound.protection.outlook.com [40.92.91.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068B2D7D27
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277410; cv=fail; b=I4X6c0gqlWT45kehuyAHRH4Lf3okdqswhycruwT164YxTCyRTlldtzcFUTviWffvpBmi59lliIUw/uOtgHGrfnfuSlXCH9jsUJXNADqf1bib7CaJpzan8gi8lfrO6z7RxhiOSk2vPe+791QiFiATL5Dfm2b/LbaJFsT6vwTlSF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277410; c=relaxed/simple;
	bh=DNBgwUowtOo9vgIBE4OXrfqk3PyIJ9WJc5KKW/SsE6I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=d88GHxx5SMNg0X9v+SZSkCyY/uzqtO5v5G3bxF5vq+mW7Z6tKyEN1cWe6OIRwC8mS+3lLYQVmeJMiLPV8dy4eZWNuzAriz5EWUN+eTiA5cn/NTZkZIJbxOva80+ICF6mOEGSIPlbtyKq5RNUfpY1BEyoUYkQ1nll8abX3UHGF4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=DKcN8CxG; arc=fail smtp.client-ip=40.92.91.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="DKcN8CxG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9utG2cr2OWA/7Flf5Qyqu82fF0uJAcEwBmJA0p4SAiJXFadR6asROf1vDO4OHaxprLAn0JwiRifikGILDjrjG6hp+0VlHahWiBnGE1zpPoOqqkb7mWZqqLkcWBzRWFAc1LNEGi7Y5sDYWyW3v+/YOf82n2Nj71tIVVmdA8d7bNl5+57FA7Dw3yTJlF5FCCyxmjtxCzqD6TJRf6mAg3hJM+4bcQjch9A4GHgMaUd3f+sc9gN0DQRn8knCKjZfuI8YAS7LXRg5Hf+xIqZSbSURMhDQUJ2XLxN9JwVhUSHeLWqhXSr75LxgKY4qYKMlqALqsj3NUd39quUkKC4ml6I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeJ0HHIKioxN3JnDdLC+4cTyjSiJvr4LLLJ2IIFQWuU=;
 b=ptCBMaJPcuzNa+qz4eSt4rMDrtEIDxj2w3hPOjKngrvJjkdLGnVnMInoPcJxu+9W0/0CDQrfoWMj8v/AsOePfKby8Yi3cPegd6pbERHwYx9xHG7uf+oEViNi6115nlBrY9J2jytcSYIKp65E7S+7NHEv0eWJFThcT281M+MubBrkEOs5vDiOw1sXtSmK10rB62UmdQKI0S7Jov9P9qIaByuz77/zEyMzxrVJYvSIHf2TNLKydGRYZZlOF9EZ2j56MgSI7CW5PNbABT/6uugtjffWZCIfKFkw1xw6w5JgBDyvJbPnKEjsRzi4JH8zbyls+F8elf+ajzGqJuuBle7CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeJ0HHIKioxN3JnDdLC+4cTyjSiJvr4LLLJ2IIFQWuU=;
 b=DKcN8CxGSEoUPTlIEiUhE/8dV8kFk/eJr5TSvzItosOpiKlZS8b4bL4RF9vhdYsFwyUzqMV4cR/iw9WD5L5tnT1T+36UZTrMd8lR4CKMf1rY1WQAfGmChizm6beLo79qiocCeOzzacldoltaz+hK54BzF4cO3jaYCManfLaMlQ3MRiqHLdk0j6yqL5RNbxBDamlAk5Y6qVwpwLp/2DZ59N3SYC5Hf3kyDYU5FLdnI2dNsYkaQiVddFkjDS7X/hhkc693empx+ycpfS0O23m2/DYrxbtNDt1UbaFbsac/tjeE7anj1AmDLo9ZsMEthbIsdi/Z75TBgfXZcIrRuwR/OQ==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AM8P250MB0357.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:328::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 17:03:25 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9031.012; Fri, 15 Aug 2025
 17:03:25 +0000
Date: Fri, 15 Aug 2025 19:03:17 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Eli Schwartz <eschwartz@gentoo.org>, 
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, 
    Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Ben Knoble <ben.knoble@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/17] doc: add a policy for using Rust
In-Reply-To: <75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com>
Message-ID:
 <DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <e81cd942-1b81-e998-cba1-41a98acfb882@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AM8P250MB0357:EE_
X-MS-Office365-Filtering-Correlation-Id: 701f9603-d41e-443f-6485-08dddc1da5cb
X-MS-Exchange-SLBlob-MailProps:
	ymJijV9pwJnsDYGz0mLrWyrSs4NoxzoSO73yy7E1T58ehxJiDC/HceiG8wUUOgdPpR9EPZ64rQ4X95uLbcsBDb8+/CaL4g90M9bW8ZJlBn9GtiiQwAc5IOOylg9/kvpVdNJretN8Gi0RjBqNsccQuS9YQCpSdn3L0Inaqeeavm1bfTJalE0QOKirPi5bUJNmvkHoR1m74lwPekVMYP8hfQzdYr4/YHcFULoJJrIcp2LJTIfBobYSlSYH8SiitbYOwk6Gfi8NA8lx3GKmGJ/sLSZ6XiTlLDl8bjI6P6Du8KYdFvdVziqpufIEW8LtYKAm0gx4d3JbyaxZzJSak0BdwHO9Pn8Bk5xsTrZO3oVlBnhJmVj4Ts8NYGode/OrFAxrkEr3Z2gkTbPwPdwAkEtTMuctVtLqiCR/0pPLiNUVx+eGZA/TzrFTR+RkkksQAuAPKqHFDpzuUAWNAntQgOfLwfjv57t1AMGaDQkZv5Wybbb1YgA9pdAb8Xi9h0+7qmbtz9aAhFErp4bFNYQHElR3sIJlcGgYENBZ9NpcftUNSAypQj5+Bn81oldGB8+DWuPNpB85tRRSeJNCiw0ixMVW1q7APyJAJwMlAZRxA3PWJe257/xSKbeVSqXtweJ7xUsqDwenS+Sr7SU79STX3CG+KA3bfNf2OMXXR6kcMtdud7cbDEr5ssZbRWHs6+CV/PIzcuqE/NIX2/Jg6jgB0DFTxcfydyMmCcdzEMJXjYM2H+ua4/A2nUyTZb9uZO7CWiAxiaxCdiLskSVmRM9nElL6jf5OGA28w9N2TorhzQeq/i7e06jDPtyCaOk9IQWcpH64
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|8060799015|23021999003|5072599009|19110799012|15080799012|3412199025|52005399003|440099028|40105399003|10035399007|26104999006|56899033|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JappzA0fcKMjbeP2/UpGZHakvx02R4DRo9XePQT65fd0gcJXnbDHDdhEIVA2?=
 =?us-ascii?Q?5mIKA7UkgEwb2xeiy21m+jZB1opEF620zC/UpAoZOzhFgDW2our/F2WbofLI?=
 =?us-ascii?Q?nUI2QG9YbFPnLuK94sEXAFCa76JxuckVVLpdZ7eIEsclTCS0eFMqgQQ5hkEc?=
 =?us-ascii?Q?fWGhabinIMhJUkklujB47EZQnQ/cXlsqV3RXHzDDiy1GjsyQnxvoJQfRxYvB?=
 =?us-ascii?Q?CxP0IATqcOqZCrqDaBmuLFgNKlS5tq8pEKuVEV+1TAJsmmGvyTxvitiY53aC?=
 =?us-ascii?Q?rfuCF1czpDhaVr6WXj1LKjqnwZCs54KDVRxHFMJ1b/pi+OWSzXmtrrfNzuQy?=
 =?us-ascii?Q?a5EmD5OTOOgH9DiZ4DBYAhufDIkavOxnG/bYvflkT5O0/AWoBVAsGepOjTSV?=
 =?us-ascii?Q?+dx6NiLzK9aohv/HXexw9fKQcz6WZxD6GS/zA4n3jY3Wxl5SDL/tqRy+7kuS?=
 =?us-ascii?Q?NpObJmtR17W6A3ceieLbrXf3dY4F+qRkkuEFDSXx6ZysHMQXiPvmP9wOhbsH?=
 =?us-ascii?Q?Ogyjk35a46nXEgWa6LFnDiSJxWx10+qQ3CGElSEONFXjAeKh6pclFuognJqA?=
 =?us-ascii?Q?r+AlypZJv2ZxiF2zC17IsFPmMOYnp1jIr1loYhM0JuClOPG1IYKoy5uQeVMw?=
 =?us-ascii?Q?W0YnumXANVhml6iREF2s0EaYLUxQIfqvsSTEp+p2qAuXXZxc1XQrBbIAUp5w?=
 =?us-ascii?Q?ecHlkL3FPr93HxbIq3w/GdEI9Vvc8J+5+bzTaWXy21WeaboxKjxcdu8LH32D?=
 =?us-ascii?Q?i0/p/dFS0Rux7XtcdE9yNpLpUPrCJZGq/RjaXEjykUde1onMLlU0Fq6GV0Bx?=
 =?us-ascii?Q?N1hBeK2TfYU88cnKBk+uKdEnbPsipeAJNLCTHidVos+/EURfFnD6CgPnM6KX?=
 =?us-ascii?Q?bF18YGgywgvksXwlEnOe/WtV6yKoJspv1H4qme4LCCkBKkLxTE7P1mFQWgU0?=
 =?us-ascii?Q?gYnXEwMV/DRd3JpTUw0DLinP5P2oRAdWtkLOck679TGsPenuB94yvAY9Yqt0?=
 =?us-ascii?Q?EyoxPB1eNdpVCz0gy9DrIY4Vo+H3iL25kFmncfX0cr3yujlU7b76IcFM9TPO?=
 =?us-ascii?Q?J2ZpdoVzI6Y2Mz9oXU9NSwqgrBEFTGKHMquJ7OI3UtWuLACph1i/2Ijv0+UH?=
 =?us-ascii?Q?2QHYpVTWxAp/J36EAcS9XrsdDOZSeR+3OENq1/6sNwH6surejsCrvuSzDFpw?=
 =?us-ascii?Q?nQJFR/23mgMu3lCBgGyH9saIkmw6PdQ1PN80uNLdUa+5Hwu5Lk6LNWr/DTRc?=
 =?us-ascii?Q?LS2BpcdSDBJaVLtknZsntAFi/EzXJfcLfTIXJFBIFTlTzRs+XIhPi2wuapDN?=
 =?us-ascii?Q?Lwk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqfC5j11UAzWS00mA2n2qsxqxwhaxNupVjDIcLNKOJRjk0LeiCTYOFr1go/p?=
 =?us-ascii?Q?B0BxqwNJrV7fCV9ZkGs52hgkd9J9Zl+jmbFG6UibXICUyub5oTN4vMvUzjGB?=
 =?us-ascii?Q?oR0KCG6TpN5cCLJiSWiPEt1bMLkqi1QPbCZ1RPBVNqOLZtHfyrbhHMHrmLqF?=
 =?us-ascii?Q?czxPqGnGoY5djfMYuxYpIVqoJJ0VQL7RLi1HydlJ5JYwu0e99lWG9SC16xFv?=
 =?us-ascii?Q?cwEefRZsIyHNkCoxlMoAjh8VO45CLa7fLR3+27AhQ7+rXxGiq+J8UIbXOhxP?=
 =?us-ascii?Q?0CO6wMGWfpzZKshNOHbJbP6K3V2JxyFF8+EsnkBZIKiYCtW0KCo4q7a77c6S?=
 =?us-ascii?Q?3juN5Ls7JLm7rGcCkgokKKbu7P+beXKVO9BvpqeWaeqqxCjtnm8YQFPj9409?=
 =?us-ascii?Q?XPqTK8uZzPI29T7JpyayzJJRsFAXUZPrIpkiOxc8BnMsB8EM146DlbPjDkdu?=
 =?us-ascii?Q?Akk4MJIlAwNYOLeJkcoJ3AVWQfRu4fQHckcEAKPgHImWw4SRjHxE4E6Pt8Q8?=
 =?us-ascii?Q?85iqHpYZOSkldMvmTJbQs/FLUzKchvGchkcv1wj3spl/D7kSYUP1/C6RVx27?=
 =?us-ascii?Q?2pCKRk4efikjsJAuTOd/Zwx4YCgBLbLYHSGOnR97hJoZy5kxiD4WxAD9QdoW?=
 =?us-ascii?Q?vofODlZC0W02MyyQVMAfaNyEJ4rJSwFddynyf2taHAff25VjTa6mKhSU917d?=
 =?us-ascii?Q?WagL+W5EqfL9tKNEZkTQ6SAseFpk0Wa4Dvses9UFt7lQCGpqNtcTixA22bOk?=
 =?us-ascii?Q?RD1R5qf1aqPM5p61K/trM9/WThQxL8L/xDKnNbiXjUpqDllqcT91D9BoXdXn?=
 =?us-ascii?Q?k2pJWMbUPWGQHhvI0+CdJrPJvp0dYGntSwnaBqBqtKazy4tCRI2jghWRB/4s?=
 =?us-ascii?Q?jP9UYvlJGf3vCt/Z70lzybODTV1eZTHSj5giVkZf8ZvoqbyTXMXmQw/Dd/qn?=
 =?us-ascii?Q?e+tjrySpL3mJRfAXJj2RWv2VABrnGGBRjOyb+Fhg4Ouaq2C8adPEh7O540gV?=
 =?us-ascii?Q?NW/MEnPR/m65ZWWVVVkKC5MxUNTCF6anX11243M8kC6kPA2tnVfw2Jy8XMXw?=
 =?us-ascii?Q?6D3un67oYZ49hWOaBGNwG9CtTDVR/u4xeEKGT67129V2c5+fkQnWL2MGzX6g?=
 =?us-ascii?Q?Hnifcs9y/ndXaQvZrEFlkxtpZUTC4UShjhQOqQNZwXVJq6xjjssabJSdtlKJ?=
 =?us-ascii?Q?ka1eFB3aw30EMN083gz0N+dIoGxuZ8C5bny9UiCUoh9JDbCJmLmpArxEy6o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 701f9603-d41e-443f-6485-08dddc1da5cb
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 17:03:25.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0357



On Fri, 15 Aug 2025, brian m. carlson via GitGitGadget wrote:

> From: "brian m. carlson" <sandals@crustytoothpaste.net>
>
> Git has historically been written primarily in C, with some shell and
> Perl.  However, C is not memory safe, which makes it more likely that
> security vulnerabilities or other bugs will be introduced, and it is
> also more verbose and less ergonomic than other, more modern languages.
>
> One of the most common modern compiled languages which is easily
> interoperable with C is Rust.  It is popular (the most admired language
> on the 2024 Stack Overflow Developer Survey), efficient, portable, and
> robust.
>
> Introduce a document laying out the incremental introduction of Rust to
> Git and provide a detailed rationale for doing so, including the points
> above.  Propose a design for this approach that addresses the needs of
> downstreams and distributors, as well as contributors.
>
> Since we don't want to carry both a C and Rust version of code and want
> to be able to add new features only in Rust, mention that Rust is a
> required part of our platform support policy.
>
> It should be noted that a recent discussion at the Berlin Git Merge
> Contributor Summit found widespread support for the addition of Rust to
> Git.  While of course not all contributors were represented, the
> proposal appeared to have the support of a majority of active
> contributors.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> Documentation/Makefile                        |   1 +
> Documentation/technical/platform-support.adoc |   2 +
> Documentation/technical/rust-support.adoc     | 119 ++++++++++++++++++
> 3 files changed, 122 insertions(+)
> create mode 100644 Documentation/technical/rust-support.adoc
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b109d25e9c80..066b761c01b9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -127,6 +127,7 @@ TECH_DOCS += technical/parallel-checkout
> TECH_DOCS += technical/partial-clone
> TECH_DOCS += technical/platform-support
> TECH_DOCS += technical/racy-git
> +TECH_DOCS += technical/rust-support
> TECH_DOCS += technical/reftable
> TECH_DOCS += technical/scalar
> TECH_DOCS += technical/send-pack-pipeline
> diff --git a/Documentation/technical/platform-support.adoc b/Documentation/technical/platform-support.adoc
> index 0a2fb28d6277..42b04b186105 100644
> --- a/Documentation/technical/platform-support.adoc
> +++ b/Documentation/technical/platform-support.adoc
> @@ -33,6 +33,8 @@ meet the following minimum requirements:
>
> * Has active security support (taking security releases of dependencies, etc)
>
> +* Supports Rust and the toolchain version specified in link:rust-support.txt[].

s/rust-support.txt/rust-support.adoc/

> +
> These requirements are a starting point, and not sufficient on their own for the
> Git community to be enthusiastic about supporting your platform. Maintainers of
> platforms which do meet these requirements can follow the steps below to make it
> diff --git a/Documentation/technical/rust-support.adoc b/Documentation/technical/rust-support.adoc
> new file mode 100644
> index 000000000000..a63327ebc575
> --- /dev/null
> +++ b/Documentation/technical/rust-support.adoc
> @@ -0,0 +1,119 @@
> +Usage of Rust in Git
> +====================
> +
> +Objective
> +---------
> +Introduce Rust into Git incrementally to improve security and maintainability.
> +
> +Background
> +----------
> +Git has historically been written primarily in C, with some portions in shell,
> +Perl, or other languages.  At the time it was originally written, this was
> +important for portability and was a logical choice for software development.
> +
> +:0: link:https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html
> +:1: link:https://www.cisa.gov/resources-tools/resources/product-security-bad-practices
> +
> +However, as time has progressed, we've seen an increased concern with memory
> +safety vulnerabilities and the development of newer languages, such as Rust,
> +that substantially limit or eliminate this class of vulnerabilities.
> +Development in a variety of projects has found that memory safety
> +vulnerabilities constitute about 70% of vulnerabilities of software in
> +languages that are not memory safe.  For instance, {0}[one survey of Android]
> +found that memory safety vulnerabilities decreased from 76% to 24% over six
> +years due to an increase in memory safe code.  Similarly, the U.S. government
> +is {1}[proposing to classify development in memory unsafe languages as a
> +Product Security Bad Practice"].
> +
> +These risks are even more substantial when we consider the fact that Git is a
> +network-facing service.  Many organizations run Git servers internally or use a
> +cloud-based forge, and the risk of accidental exposure or compromise of user
> +data is substantial.  It's important to ensure that Git, whether it's used
> +locally or remotely, is robustly secure.
> +
> +In addition, C is a difficult language to write well and concisely.  While it
> +is of course possible to do anything with C, it lacks built-in support for
> +niceties found in modern languages, such as hash tables, generics, typed
> +errors, and automatic destruction, and most modern language offer shorter, more
> +ergonomic syntax for expressing code.  This is valuable functionality that can
> +allow Git to be developed more rapidly, more easily, by more developers of a
> +variety of levels, and with more confidence in the correctness of the code.
> +
> +For these reasons, adding Rust to Git is a sensible and prudent move that will
> +allow us to improve the quality of the code and potentially attract new developers.
> +
> +Goals
> +-----
> +1. Git continues to build, run, and pass tests on a wide variety of operating
> +   systems and architectures.
> +2. Transition from C to Rust is incremental; that is, code can be ported as it
> +   is convenient and Git does not need to transition all at once.
> +3. Git continues to support older operating systems in conformance with the
> +   platform support policy.
> +
> +Non-Goals
> +---------
> +1. Support for every possible operating system and architecture.  Git already
> +   has a platform support policy which defines what is supported and we already
> +   exclude some operating systems for various reasons (e.g., lacking enough POSIX
> +   tools to pass the test suite).
> +2. Implementing C-only versions of Rust code or compiling a C-only Git.  This
> +   would be difficult to maintain and would not offer the ergonomic benefits we
> +   desire.
> +
> +Design
> +------
> +Git will adopt Rust incrementally.  This transition will start with the
> +creation of a static library that can be linked into the existing Git binaries.
> +At some point, we may wish to expose a dynamic library and compile the Git
> +binaries themselves using Rust.  Using an incremental approach allows us to
> +determine as we go along how to structure our code in the best way for the
> +project and avoids the need to make hard, potentially disruptive, transitions
> +caused by porting a binary wholesale from one language to another that might
> +introduce bugs.
> +
> +We will use the `bindgen` and `cbindgen` crates for handling C-compatible
> +bindings and the `rustix` crate for POSIX-compatible interfaces.  The `libc`
> +crate, which is used by `rustix`, does not expose safe interfaces and does not
> +handle differences between platforms, such as differing 64-bit `stat` call
> +names, and so is less desirable as a target than `rustix`.  We may still choose
> +to use it in some cases if `rustix` does not offer suitable interfaces.
> +
> +Rust upstream releases every six weeks and only supports the latest stable
> +release.  While it is nice that upstream is active, we would like our software
> +releases to have a lifespan exceeding six weeks.  To allow compiling our code
> +on a variety of systems, we will support the version of Rust in Debian stable,
> +plus, for a year after a new Debian stable is released, the version in Debian
> +oldstable.
> +
> +This provides an approximately three-year lifespan of support for a Rust
> +release and allows us to support a variety of operating systems and
> +architectures, including those for which Rust upstream does not build binaries.
> +Debian stable is the benchmark distribution used by many Rust projects when
> +determining supported Rust versions, and it is an extremely portable and
> +popular free software operating system that is available to the public at no
> +charge, which makes it a sensible choice for us as well.
> +
> +We may change this policy if the Rust project issues long-term support releases
> +or the Rust community and distributors agree on releases to target as if they
> +were long-term support releases.
> +
> +This version support policy necessitates that we be very careful about the
> +dependencies we include, since many Rust projects support only the latest
> +stable version.  However, we typically have been careful about dependencies in
> +the first place, so this should not be a major departure from existing policy,
> +although it may be a change for some existing Rust developers.
> +
> +We will avoid including the `Cargo.lock` file in the repository and instead
> +specify minimum dependency versions in the `Cargo.toml` file.  We want to allow
> +people to use newer versions of dependencies if necessary to support newer
> +platforms without needing to force upgrades of dependencies on all users, and
> +it provides additional flexibility for distribution maintainers.
> +
> +We do not plan to support beta or nightly versions of the Rust compiler.  These
> +versions may change rapidly and especially parts of the toolchain such as
> +Clippy, the lint tool, can have false positives or add additional warnings with
> +too great of a frequency to be supportable by the project.  However, we do plan
> +to support alternate compilers, such as the rust_codegen_gcc backend and gccrs
> +when they are stable and support our desired release versions.  This will
> +provide greater support for more operating systems and architectures.
> -- 
> gitgitgadget

best regards

Matthias
