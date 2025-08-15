Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2074.outbound.protection.outlook.com [40.92.89.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C230FF05
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277995; cv=fail; b=PaxEuSsCaXFc/YdmTD/clHGVn+b1sJjC1NIZ/eb+hOdcu9HuccIDmNPuDUaR1ZRQTbOyhGcOywhlKQP2OdsTq1eDqwi7bE9++k0m7Yg8WQWjAZswaPuM+sWJAY5vdlWmpPEh3Qoh/2DtzlNED3aZF48Jr3HJm0HyBKSKcNnUg5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277995; c=relaxed/simple;
	bh=h1GPpo0wcFo+kmr9h4AgJrE9MVogi/7E3KW/nF2+vo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=W8mQmwORd83Z5FQZIJU+AxISjXluRBTC+X2SMulmKmnvNPdADJoUlJ5hRU0r40OXa6O87uDDq5FFpK/WAOgqNZBTuIYZ7mrn2nAw12mphMxkcfXERgV9IM5A4hoHEW1xhj0MorjGWD6mhzA95kbSsixqNmchG1CQTUbhY9WR7q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=FGGPCiC2; arc=fail smtp.client-ip=40.92.89.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="FGGPCiC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPYPfTQnJCbPUYhZwQ1xTUAT3gG1p2IiNQ2PxMLhfdDHjgGArNCF6y/zfIMOt7lUeUvFXaUzyurWuC0b2IX/VDUjPQnnyBfG0/d9BkGtbpCIfpRCQbc4mM0zCtBIVx9YUUMF12Z0ESeCU3zavmoj48aGS/ILBLlhp0kglbtwn8i+TIqPbSZDilC7ApHJ7PhqVsvWBlM6+9MiBFul5U9tSlDwtpGUCi2kIgEV5V0IUsZWb7isuVZDnJ2WkirSmWkQdglyYVwXqDHXosQvyxjeNcAl6nzexAn5FfUszoGrLox84GujTCCxbQkJf9p305VNxOOzq5UZPWSd54tljXLyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvuAQhcEreHxrbPZUZV0UAgZmtHgg3l58tsNxGBa8c4=;
 b=YTv6ZRU34QSOSVnR9m5fmZttm2PQVNBmjujE42wwHt6LFRoZXPveFwnO1JN2049+veFMWSYj4iaQHL0S+A3ksm0FmwkqfXuHM8dOr0fnKJBlqJ8Ov0G07iK/V1b4XlM8UAsredNdwJcvQsfJh4hUEozI1MeVti1h1hYGJY+21hvCuCwGlMFJUF/ZzpaYk2t+9A6NQp1QtRZQlb0wKfu3+pGBHnIYpNIGE4xJ48dIhR1VWHCIYJgPij2IdVXMT6A6EGpTzMSHRHSo909RL2LDzHssVpNSPma9JytvGeoCM8AUwYzJoJ6/0YyloI0A/XfbJ3m3qg5MWy9zOK7LwtkGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvuAQhcEreHxrbPZUZV0UAgZmtHgg3l58tsNxGBa8c4=;
 b=FGGPCiC2o91q1IjVbNPi+o+DISmwMXdYjXYXHx0GT+m6JT553qvDeQ4YOvq86TkOOHQu/ikGuuYOLc6kWqJiasDZ3JV2O8bTVOwkQUHsHEwvQVMMofH3XyvjOXT2nF00NP6xCuszDz0oPdNqCNzMUPmZ5bhCukwchIurBvLeetYnoy0RO3r3gVfG8xg54T6px6a6ruktBgvMZSg6maWy4mYWMvydBy0c1YYBWdkrDQvtoT7XDsGYKS58OAPsgVqPkASxG6QsmjZBICzsHiwxsEqQWxI3R4/+6cSXuXOzw3KuiH8WGfO7V01Vypiw/JGg1pZcKwRGdZ8phegAnxu9Ow==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AS8P250MB0039.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:35a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 17:13:05 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9031.012; Fri, 15 Aug 2025
 17:13:04 +0000
Date: Fri, 15 Aug 2025 19:12:56 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
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
    Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
Message-ID:
 <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <4cb73628-eff5-47d0-a602-c6a37cd0ab4a@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AS8P250MB0039:EE_
X-MS-Office365-Filtering-Correlation-Id: f63ddf0d-b760-4a57-498d-08dddc1eff01
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|15080799012|23021999003|19110799012|8060799015|41001999006|4302099013|440099028|3412199025|40105399003|26104999006|1602099012|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?822Y7/3N2K9WO7dS0imadCDXGUMLvekhMQD5O4Ltg2f2Sp8lXw1/4Bm1DWIP?=
 =?us-ascii?Q?KpYtDp8vxsH8ybEvze7q7Eaq/dUhh1OtdCSl8SBuTM1jPNF506LZsJpuaobb?=
 =?us-ascii?Q?DKPyXCwQfx9WYT4KPCsXFpzUWczpHypA071k39n4ttVMf1DnLezNiFQoOknp?=
 =?us-ascii?Q?FkGzLiwRN9jH4VYrWLfWsTCITQNmphCdjhphGhCXoH1PUd8+P3GgxsWYKaAB?=
 =?us-ascii?Q?mvDdHqS7BUOEWG4QN+gkPUier4jdjXJ1RLDpwNG+dUfKSo9lDzUc7vgXvMFd?=
 =?us-ascii?Q?2wrOkCqKFSLk65dbqL7Ml6e+l3HxjCg43QzBInS91c371svRMW/lopXZVKrK?=
 =?us-ascii?Q?yiisctB/Xa8DHhPbGUCi/bNX+bvdUGceUxgeqikAwRqa1xt1Q3lZknhoFLb1?=
 =?us-ascii?Q?HDJZO6HpWl9AunVdmEnZBr5B5Q3/S1v3cozdBS+oREufwTZHO6P5ko3CHzf0?=
 =?us-ascii?Q?PAvuLBCV6Q4W6mxnmPGI/3o8D2AdXhBGolywXZ+HI6okykuJBCSi7X86aAo/?=
 =?us-ascii?Q?FH3qW5f4JILhKRDxQpuvnQ2tId2rOC5jrdpA0mo5gNC+N/2hkiO38BugzGNS?=
 =?us-ascii?Q?cB8zuED1ekjKjxYzkP3+mN1AYeWvU+Xdt8XN2vr9oHFylvWQqB8+b5Y6ZXZ3?=
 =?us-ascii?Q?aYYFH1/Ga9UWulVl0s3MinP7vv3ePeu+yaC8mHKBZQtpwUD+R5v0e/WbROSV?=
 =?us-ascii?Q?O6K3jyRfrL9afd7ucxCpFUnwl6iIgGyFsfV4HUFWq38FbOHVV85Rr0sI7FOe?=
 =?us-ascii?Q?aV3HkckLXXQffeJFWzx+vclULeYVa1qguWabj7yKQGbcwJK/N+PPxOuZFcB0?=
 =?us-ascii?Q?XQcRttd3J3PDe6ttHoc3NLnRMcR3tXZlfzxBkfTXkcJ8bmc1T3amXA0Rsh+a?=
 =?us-ascii?Q?Y0Wb9dCpY+hUOSqNPsyHUqtoycDMVSp5LNi4h1/L3eYIqI5/QWTxmadErZkX?=
 =?us-ascii?Q?MmiCr18oih4Rg219NSV7a6PkrbvJOTddMzew1FXEXc7972i0c8DFyao2MDYl?=
 =?us-ascii?Q?atRWo5Q1nniYsHQafKCCxJeBm+6/4wUEgctYPaNf6zJPq7+cMN1CHUPh0RQv?=
 =?us-ascii?Q?+w26CvnhwR5UorEGJarfSVDpQcTyrHxqhBXVKmeH9TKauWjJCkiX50653o8N?=
 =?us-ascii?Q?+XA7AVn6C7B4KLtDo2rAGxDoE7Xyg7Nq0c33Fxl7oOqYaApIWxdjALx25cKf?=
 =?us-ascii?Q?MPqunN8AzhxNcemv4WOcP/Zh7iBn+vQrtOMVTGhKeuzoxuqcyaSMW5rZqfnV?=
 =?us-ascii?Q?NSZOyjC/6eFVcIwBglC7m79tvloql3Q4oogIFhbl44giTbcQp9FbSPH+f5mr?=
 =?us-ascii?Q?x/da7ThtP4BR/8BBfyAQwS+B?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wn0nilT45Sqie8PHBJVJj1KmRfsfkmcYdV3jFHndNKbUQ8/59BijbJc47CX2?=
 =?us-ascii?Q?ynObRcFGJ50Kw3WwYzsxBTDKraI47QaMhQEZRJGTu5WdmuNxqwHbSolQwvow?=
 =?us-ascii?Q?dyqw3wJAtCTp076jCW5lesjQyD0APHYvHn04Dg6/xJxONVk4ZkV4bSCBt0Lc?=
 =?us-ascii?Q?kqDqV+qNJCtGM0sJr4Ve9d2uNiGr082rlKi37/B0pUSwM8BXGrDMSbIdpYs4?=
 =?us-ascii?Q?grvQr3P8Gjn74cGps2wva9aRRdJlJje4Q4eZ1oWy2hcGit+/K1GRx6HTIcY0?=
 =?us-ascii?Q?7WHveeFe+F+p0AMYZx6cw1QEeuQvYL6EEo+UkS1+ypzcxAiaLova0SZokYdL?=
 =?us-ascii?Q?wJ+G/PWrgfVZeGKeVBS+5sbYnnXLwpYeL/FxM3mF4BWtRBoox37Q1dFdAZVd?=
 =?us-ascii?Q?7wDFxW2Z3AWKW6dRwC/8Wh7QmcXzGCurKPkSCPtxq4AeLJcy1mfig4oYsN7X?=
 =?us-ascii?Q?Cyj5tANauBSQG6EXqPVBaesRP6ua5ZYLqPyL1OC31p7wRv4GcXZ2v8xnjtPB?=
 =?us-ascii?Q?D07r/iz6rPJDanBUv+QdPZ/jW/r9+aQZ8jLH+CVGAOFL0N+5S6/96m5nAAdf?=
 =?us-ascii?Q?F+h60istqF1FxIp4oYRuCCK/Hvr3NNxXQp84RPlseu9o7SiX8ICNf5rwoG9o?=
 =?us-ascii?Q?DPMPO7Vaf9O+RmQsh6GdXSRNALRQcqkXVVH3E+W0+9diMFMXQOqQY+VPY8Yw?=
 =?us-ascii?Q?UdwHZ2xiRoYO8pCxjNnxe72vCS//Ds7iyFS1wM0+d3isTFxd6cyTo1+/6IdB?=
 =?us-ascii?Q?IO+P8ipv5ygZtX1YOh4FHdS5znws20xf9nQs7p3IcEOTy9DBdiZOccduOGNY?=
 =?us-ascii?Q?KhatwqPTUq/flFKgFp+6GEFVNSGisqgNcJJ8C5CUMOKeYSr6ha2jVuelsFg3?=
 =?us-ascii?Q?rVVo92wZ+0WiAmHpk1xeiM1309VS5MaD2vNxUw5h1Rtb2Zq60sGr/p5K3JWF?=
 =?us-ascii?Q?kSTKSOuwNCyQrS8U2c9Fmc+MG/dcSt9N0PZU0DhkFta+1oikwY2x1s8Glx9m?=
 =?us-ascii?Q?0DFDOxjkUNNd9lba75FKNkneXdLWSZKiuPK4gWIQlaH2w86CUiCzLetR1Rca?=
 =?us-ascii?Q?jI5PLZNDmNWRyGS7FI2aehG6bWNMLKjwrlEFJh4EosSicCDsbbVrql/CzwRq?=
 =?us-ascii?Q?rvNGyfnR/H9Oujte6gl1LfYMdEpbdfrmSwnzEPsx646ktTradIaTG3BuiO+g?=
 =?us-ascii?Q?55gOM14sCNbldlYei+OOeAUILgm3P4CqEok92H1LufcafDnoPpv8nFUMrMQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ddf0d-b760-4a57-498d-08dddc1eff01
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 17:13:04.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0039



On Fri, 15 Aug 2025, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> By default, Rust wants to build MS Visual C-compatible libraries on
> Windows, because that is _the_ native C compiler.
>
> Git is historically lacking in its MSVC support, and the official Git
> for Windows versions are built using GCC instead. As a consequence, a
> (subset of a) GCC toolchain is installed as part of the `windows-build`
> job of every CI build.
>
> Naturally, this requires adjustments in how Rust is called, most
> importantly it requires installing support for a GCC-compatible build
> target.
>
> Let's make the necessary adjustment both in the CI-specific code that
> installs Rust as well as in the Windows-specific configuration in
> `config.mak.uname`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> [en: Moved lib userenv handling to a later patch]
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> ci/install-rust.sh | 3 +++
> config.mak.uname   | 7 +++++++
> 2 files changed, 10 insertions(+)
>
> diff --git a/ci/install-rust.sh b/ci/install-rust.sh
> index 141ceddb17cf..c22baa629ceb 100644
> --- a/ci/install-rust.sh
> +++ b/ci/install-rust.sh
> @@ -28,6 +28,9 @@ if [ "$BITNESS" = "32" ]; then
>   $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
> else
>   $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
> +  if [ "$CI_OS_NAME" = "windows" ]; then
> +    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
> +  fi
> fi
>
> . $CARGO_HOME/env
> diff --git a/config.mak.uname b/config.mak.uname
> index 3e26bb074a4b..a22703284b56 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -727,19 +727,26 @@ ifeq ($(uname_S),MINGW)
> 		prefix = /mingw32
> 		HOST_CPU = i686
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
> +		CARGO_BUILD_TARGET = i686-pc-windows-gnu
>         endif
>         ifeq (MINGW64,$(MSYSTEM))
> 		prefix = /mingw64
> 		HOST_CPU = x86_64
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> +		CARGO_BUILD_TARGET = x86_64-pc-windows-gnu

I've said it when Johannes originally sent this patch[1], but it bears 
repeating: The *-pc-windows-gnu targets will pass CI, but would mean 
raising the required Windows version from 8.1 to 10. We'd want to use
the *-win7-windows-gnu targets[2] to keep Windows 8.1 supported.

[1] 
https://lore.kernel.org/git/pull.1980.git.git.1752784344.gitgitgadget@gmail.com/T/#ma10be2ed0a0e776b0af2fdd0de63d51ba51609e4
[2] 
https://doc.rust-lang.org/nightly/rustc/platform-support/win7-windows-gnu.html

>         else ifeq (CLANGARM64,$(MSYSTEM))
> 		prefix = /clangarm64
> 		HOST_CPU = aarch64
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> +		CARGO_BUILD_TARGET = aarch64-pc-windows-gnu

As I've also mentioned before [1], this target doesn't seem to exist. The 
correct target seems to be aarch64-pc-windows-gnullvm. [3]

[3] https://doc.rust-lang.org/rustc/platform-support/windows-gnullvm.html

>         else
> 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
> 		BASIC_LDFLAGS += -Wl,--large-address-aware
>         endif
> +
> +	export CARGO_BUILD_TARGET
> +	RUST_TARGET_DIR = rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
> +
> 	CC = gcc
> 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
> 		-fstack-protector-strong
> -- 
> gitgitgadget

Best regards

Matthias
