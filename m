Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E812381AF8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142883; cv=fail; b=rG0uQxQ4EgWKcMJikembrwvc3XfdqkayQV24F6kh3rnJrJA03lXy+Mb5sTgPevadE4HY1keqTOF1Y1McsoEVVJI1KhPyi2AsjckOV0GuMRGJnETHC1SgUd1F2SMlp5GTEdfKtcLQ6bkQn01CeeeUkVlNG+5iwjkURl1h1gsrEbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142883; c=relaxed/simple;
	bh=K1e04ElrneODHVF2lbVmGXZA7NZnFCUbpsBznczwtXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjK5De/b/p0DXulc6LL7J/oq3iQOnaulcZ2D4wAer2QLwyHBLkZX4B+plVfl0Hlw7XAkTXAPFDF2UessUOfqwQv/WB2qzAoueckInI0J94wOtHRBbtYCS+eYaI1H807Ks8gc0YXqLrvCet2xllwaJut6jdXiGTDiU1mJwFySw/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fyhv6t1o; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fyhv6t1o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjtxOpUKJA5oOj6DdnlpQUwtF3nZGnadYY/hx53hwz9MFMaUwJMF1OeDpWIXczOLpGvUhckI/YpLZtJa2S4L+Bp30Ogn2wJYJHTez/jZwtaNtvupWLyKTgvJJQfoj7qCERFM8a67p4d9qktjR7zfTYwc9pn742qTeSURTD0zE7BlBQHLUg64M+f27cXFMTH3Hu58NO2QQOq+og7ZWcGx8Ptdeb3BCoiK2rqXyTjGv5kJbpM1VYkxtmqfCZyC++jYQJCJQRkqWA0bNn94UZnjGkuD9dT75Cu/QwfJi1RLtLQHwu34E41Lh2uFtpy7CPz+DdNNol0iZ5MpubMWOg8nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z02XZNn4uCZOjh/jWBLUVwAYY8t8PpFvaAJCeUJ0cVk=;
 b=ELqgpRhZl8AukM2v7KQ/wIxtMEfva9lQO4TeOZzIlfP9Apa70+hZhTI30ynoEzoz0By13IKNNE8gFfVGDfcB87YTdEPq65TovRts8/ODjURqG0oPE3wj6Z/WaoxFRnopwA3sM/4pCL0EYFzTH31flJqC2WxQMc1Op09vUQcP/8Ph85jdfk45oEJCldErXx1vO2ham7ArKs7959xjmFyIfcPolp42LLchHBR+QPuiTPhqn4mhB1udOUDzw1BgoyoIDyQzVG16kLnd+f9DG/HU9MQewuQbLp15G0FsOpOpz2+H0NoHf+D6XnPLfMww/C2yeOGydfbSVZMf53Opl3YpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z02XZNn4uCZOjh/jWBLUVwAYY8t8PpFvaAJCeUJ0cVk=;
 b=fyhv6t1oKUe1XoZ1BHK7AcT880saQl4XaQM/1cty0jW2ap/7t8zbqdFZOTq8ZDgm86/FMRT2zozip/yqwc7J1FEJPIf4gEbfaS6+oslynswFO9O5x1vP00sjW4ot8h1EdolpSlWRKdGkaLEMrXcWHJQC8vpqHBCcoS7mHyPdX7n+eYT8sHrNGSyiKfS8J020wc0yiudRn3uFlz+DZSA4Iv62Qge3n7v7zz3yUdyXTQz+ObVZJa9AJ6w4Iv+vUvpmHEMVvFIyXaUrSuWAGvsq59Eu/ZfA2k/isjI8T0QSmR1q7BA77jBuJG14gJIK+RAM3Ive0/N2SR1bcdZphjusTw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:18 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:18 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 0/8] parseopt: add subcommand autocorrection
Date: Tue, 10 Mar 2026 20:40:59 +0900
Message-ID:
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8652f4-bf90-4e54-4785-08de7e99f103
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|12121999013|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRMNFyebkFRRjYrFqmsApL37Zo8/AClmSrTFgz9dgxBIHjqt+xCX41lfkYBQ?=
 =?us-ascii?Q?Yn261/YEGDLq44QnY980T/dHhRN7ZXcjxa1U6Ia/VD/bpfRKO4G7w4VwBD9B?=
 =?us-ascii?Q?LH6XmjDtK+p3N+8lojIrupetUZWQD3VFlp+Au+XRyj7s7eBKB9IYZkjvAX1p?=
 =?us-ascii?Q?tYNhkTcIKIKJ8MQUl0e3nxPD+oIqXTptFUSIhsQWj8qNI/gH9nSh7iufAyG+?=
 =?us-ascii?Q?2p8QoQbpdl7fsReDe7dS53W6O6A1sdsOsvnjYH6KwnUINWUfZJj0npsyrKp+?=
 =?us-ascii?Q?wn5U2WXVk4D4JufORUZxKKQYDJgRzu+nzyisducZb6lX6SSxLvlWahQzzKQx?=
 =?us-ascii?Q?ZS24vDCcqkYtAbJmxvwNMm3W1WNZotYmZkRsGe/rIR7EUQNbEPCyN91Mlq6Z?=
 =?us-ascii?Q?vqzLznYSf9IFdO0NjsBF+wcWx1fX6JfKcZa+fisgQMjISL26xSfAr008TLgW?=
 =?us-ascii?Q?6T8grS2i7hNJ0J4lipEK+WZxzYpStKVoJ9ZM04OxfJ7b3LMJnS3CiFE3lVAn?=
 =?us-ascii?Q?aFACBMojht4+Xx2gkl1Nc5CyC3Okz0ft8hXEvMXUSKogFmWn3dX7g8bBD3pk?=
 =?us-ascii?Q?8WSuDyzvkw6YL7Qbfqd/kYO93PTKnEZVfx1DieSKIV8kKqWyv5Vocl2OA68f?=
 =?us-ascii?Q?AQSeIBia1pnQNOb/sRo1OF7VEVgagVep213xEJqQuhJLubw31Ya0bB8UNKv+?=
 =?us-ascii?Q?ZsNlwCQliqzwJaRS43MzTPz2WHfboSgeiM/FQa76P5jrZUYTalREb3KawjTF?=
 =?us-ascii?Q?wTVsw+gT2PkJCtpqU4yszqXjDRSCww6fyi3ecf+hzC5F6lo9wpuWhRZbQ+Vq?=
 =?us-ascii?Q?+TLMwcwonRICWjeV3m9b3j9QamLWnWlC0VQTu+KUhYNaf6fvtOn5gKHfAr0G?=
 =?us-ascii?Q?YjtBuLs32ZKSi0G9l9wgpugY8DfesXJtlWwv7xSS4NENaoDb+BTUrUZ+G107?=
 =?us-ascii?Q?R8FzS6horQV0y4JV7670TZ4noidrH4o0gzjJ5xskH0uXYNOyvIo/X7taA5Hg?=
 =?us-ascii?Q?8ODM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UIWwU6HifW2B4pw17Bic7TGxqRyohWxy5PhHmZKmb91kxPqFcDB0LJK8NKX?=
 =?us-ascii?Q?3NIiCsUdqvRGKhKMwmbCvh6Gq8pjJWe6TbJdkD5iNuaEXyQmqyEmj/c9Gvxp?=
 =?us-ascii?Q?SOpWCLljg7FFl+EDwIcE53CiM+HvMUIIWrh34vLYrl5Vd8+R6Ir0LU2f28tS?=
 =?us-ascii?Q?CjfjudtMmpAj7h/zEwc9WHEJPpJvgQvvhnSkVHTU+Gu0d0GUQYor/fIrBuLB?=
 =?us-ascii?Q?jIStuRR+n3kc+jPC9QfaosNLl0l62m5WEeSXwVXNmSnDDJJ78Ew4LfZdUjoQ?=
 =?us-ascii?Q?rWLx6ihPaUxkWWakrQJm3zFoHrDTZkV6CD3cm2O99IONLDftbTiFjPseyK3m?=
 =?us-ascii?Q?GaR+0T4OeCGciun/5d2rsHggNXi0Izwha4RkrAD5f0UImWsAfp3elMF71ZLu?=
 =?us-ascii?Q?OSqWAulXat9qVa/pCmkJN9gXF9egxAbtg+ZeX06zUL5pf7Vr6waevQf2scsI?=
 =?us-ascii?Q?SX85rcmOStoDDIKbIfF6gWkHh026/Wz6+fryj2UP0NZyM7XY8wsvAO22niKI?=
 =?us-ascii?Q?jB7CxQVkmlm+sXQutOZazLX97+PFzdkaho0ncik6LmOpfxc5U9GaQFM4XpPa?=
 =?us-ascii?Q?KPMTqBSo2WjhXVX6XiZ5i72jysyfZxZNY3ywLn4eFYj8CZQ222WJQb1mosIE?=
 =?us-ascii?Q?ZGjn2MPqobRNPa6mXCnch1ct5nlTn/md7qHjUj8JledwNskfnAhftIxAo9Bk?=
 =?us-ascii?Q?5WDhSJnmvy6h/z30eR5fROFbvZfE0hMH8mXwR8lisMn+sk0Rr7Tl174X24YJ?=
 =?us-ascii?Q?WgD7KdpLJckdK3IqgXPu2ojMRQzRa9KBoDpfeBCqP9/3ksAmmeVzTabScmnB?=
 =?us-ascii?Q?9eI1hLFydLUGYsFjBUvHesFVHq3RFTt+TKCU7EzkoNlUTF8v+Y+EiYEKoZBv?=
 =?us-ascii?Q?LBs8Bz9ZDkFIoiqI7NfBJmh+zv08B4CSxNvFhvszE9rDJPauHszsnOkTVuzn?=
 =?us-ascii?Q?tAyJa4QByGyWiHNQHcHyFqAl+LqZcVoBNyr6AjSwawKu7lodqhfxul8xOWoD?=
 =?us-ascii?Q?qr3D1Vx3XamRTkzsSBYVl0yNGD+XU+oxMco0ytPhgk2Jck5nMiD83LCef8cm?=
 =?us-ascii?Q?qvSRtOdNmQrTbhxIkBgU7itSzdQDMfyf7a+s8pxuYti/0Jz6OTLoUWZ32fUQ?=
 =?us-ascii?Q?nuOX7y5wC8bgtPdYmuJk1Ylnt3VjPVd9DUV9V1+P5z3DiAnObxilzVlCaWld?=
 =?us-ascii?Q?rSvBYgV7Oxi7I55pXsu6bUk4u4741RkRJO/OMgAgsesXCcNEYJKyuBTuvZD7?=
 =?us-ascii?Q?1eiBpP4hr8WJJhibkj3OKE4qpSSA5AGuTVNktWOb/1/mY4HPx8WcymHmI6xB?=
 =?us-ascii?Q?2TxXoPdZV0nUenMUxsvh1+WE3y76Hk/UuflhQq+mZhM4jAz+NCIoFfSJt7Y6?=
 =?us-ascii?Q?prfDG8gHQN+U6xW+g3zTlLTLiUDh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8652f4-bf90-4e54-4785-08de7e99f103
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:18.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

Git currently provides auto-correction for builtins and aliases, but
lacks this functionality for subcommands parsed via the parse-options
API. Subcommands are also commands, and typos will occur, too. Like:

	git remote add-rul

So, this series introduces subcommand auto-correction.

By default, this implementation enables autocorrection for builtins
with mandatory subcommands. However, for those using
PARSE_OPT_SUBCOMMAND_OPTIONAL, autocorrection is skipped to avoid
misinterpreting legitimate unknown arguments as mistyped subcommands.

To allow builtins with optional subcommands to explicitly opt in,
this series adds the PARSE_OPT_SUBCOMMAND_AUTOCORR flag. This flag
is subsequently enabled for git-remote and git-notes.

Additionally, the existing autocorrection logic is extracted from
help.c so subcommand handling can reuse the same config parsing and
prompt/delay logic.

Some split string literals are also combined so the full text is easier
to grep for.

Changes in v3:
  - Align with the coding guildline

Changes in v2:
  - Reword the explanation of default autocorrection behavior

Jiamu Sun (8):
  parseopt: extract subcommand handling from parse_options_step()
  help: make autocorrect handling reusable
  help: move tty check for autocorrection to autocorrect.c
  autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINTONLY
  autocorrect: provide config resolution API
  parseopt: autocorrect mistyped subcommands
  parseopt: enable subcommand autocorrection for git-remote and
    git-notes
  help: add tests for subcommand autocorrection

 Makefile                          |   1 +
 autocorrect.c                     |  89 +++++++++++++++++
 autocorrect.h                     |  21 ++++
 builtin/notes.c                   |  10 +-
 builtin/remote.c                  |  12 +--
 help.c                            | 104 ++++----------------
 parse-options.c                   | 156 ++++++++++++++++++++++--------
 parse-options.h                   |   1 +
 t/t9004-autocorrect-subcommand.sh |  51 ++++++++++
 9 files changed, 305 insertions(+), 140 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
2.53.0

