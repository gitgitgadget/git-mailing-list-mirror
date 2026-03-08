Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E463368AD
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011839; cv=fail; b=hbdMRwMhgrhZ4xy3+F1m6lB5RTxtorY+hNPVBkMyq2xA41QEtYXJKl6UvqWmGzhUMfDZLnbVsbRaFo3RE42Ze72XnhqNmL+TNr+whzYLh9dywtdZj5fayQ13OsiSsyEtW49woe9ws5+wk4zkOVb86kVdk3pCxz+cx696ZJwEclc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011839; c=relaxed/simple;
	bh=mJrs9zjcRX8PP0u4e4J6cZ4RagMfivcOIFyCE+DhOJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sRuhHNfTZXNzGw+USuuYjtpB1zADCXGcpJ42kHwsKYd2hu6uro+9JB0QuhF0dnkfjMAMeDcQ8PpKBXyT+Nb8C3OE8KCzIcqCXU/i9Cm4m7BaN1zTKwW/2/obC8RrySDzqond8Jqoa9+L+ot2ajPqt/Kp9lYB/4bAUkKvMywNyuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i7RNm6lw; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i7RNm6lw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOP0MvzkaAwsRmNO/GJ+m3Vv6QSeAeaEkpJAq25CiQ3ewyiluWjjm59N2KC7xvAVSg35tQSK1P/Rru6Ou2lbTBtR0Ob4rCh3/dSWpXZ50KezOsna5KtRxLq1h0jRyU3pQ5SquRZfHdCKczaHUFxz7h8jzEpfWbihhJUZLR4M5c+jiOTMNeh86XYu49p2goqq61kJIrzbOlMTEeTG7leMhLI7dthUEf9yqcXQ09DZJGiF6VCmGFuBmDstI796DoiulJq78gEcIMgjfYRl7tmAh0y/dqzil8s7mPvW/Ku+IIUyVQbvfdDo2bJkcox+Qp0OjgSmBnuyzdME2Bqx1LD6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmNEF6W4493UfzfdpVr0WysY4Y1MpfuAe6RqdM82rCY=;
 b=kvmy+9qd2x/XiRgqdj1gX8G/j1LyHcUXCQ+fWF3+B6KYFByWG6ei6jwQe+k9GudctUOW+QVKQnotfkQM+pckaoOIKifk/ndy9QjEL6hxXsP+vQ07lcAXzubNfe/mI2Xd8/vzSPnmENiGAfd5Eu6eFNE8JwEYC3aRdRzgHJ3xd/v6HW64GFNt2trlXvMeoVKTi2gCKECEM/4WYDC9GNa5brqlCPDyTxm0goBdPnPbBhnKAQx/YofQWGKuOltO5ns0gDq1DnI2wGMBKJH58OZtwzUIsvvtgVBdO2nHKXfWL0EUcgPhh/mzPasiaMbTVe+lraBD4qTxb91e3nmdQBDxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNEF6W4493UfzfdpVr0WysY4Y1MpfuAe6RqdM82rCY=;
 b=i7RNm6lwOHtYanOmm+l8/vnkZ4VXrVhY7MSRlxb98bIDOQl4dr1XnEdJ8tzxa+A3I9+vVHJibXTAmQqxxF+rlrcp/OOiRArPGKq0R1u/ZXOluBxmmhvJGdbzgr6pb/H/tPvD0qDoVjlOqVuc1nk7Q5wCQsBmdeXgKS3h+5VTabIjBSyyxhOrvAhAti8hvV0ME1shEJpvlccIH9SNPJAz8YyrE+O2akx8CYeNaetLGGpq5Lq3YMVXiM31wG4zavoKoq6tvm09SMYgw+q1cUFqOOhEmPOLj3sx1ptZ5nZZyPZtxGMCaUaPpdbauNy7Zorw5ydv7/UTJw19P8PpsX1n7Q==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:12 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:12 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 0/5] parseopt: add subcommand autocorrection
Date: Mon,  9 Mar 2026 08:16:54 +0900
Message-ID:
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB0653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9b90e6-2ae9-4e74-8c30-08de7d68d3fe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|8060799015|25031999004|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeHkCbkQWMZUQhjT6nINPGNV8+Vfzea6uWqhTaw3D/U6R0VTU0oeiwbnsf0t?=
 =?us-ascii?Q?zF7A4EikFF3zKIP2sf4nMeEK/3iiCRAYFS1vcp48feOZg+XZJoSEOlaj4Xkr?=
 =?us-ascii?Q?Ic//k9HewqAoeKQdNXwj7Qe9qic7KF3ePKHqDvG7s5kO1U3X801v8XxtCe0U?=
 =?us-ascii?Q?4CwMFM71j1BoByuRMU+XfFJs93rTgqeKrx4NU4+1lN8Ym8Q6yVbnCdrnu/aE?=
 =?us-ascii?Q?D0nVptXa+l2+k2iSe1/YPbV/HGWA4QhXn6YoO4NOxpBRblNr9dy2aLc+5+je?=
 =?us-ascii?Q?vqz9EAM8BW6fCXbYvBfLJTCIpn8MTMldHEWihTUFFPwwnAuch4A0Wz7igIuI?=
 =?us-ascii?Q?XcMV9Z3Yn76p8gFxiGBir/Aa9BUFJa3S6JQpZpk4Nl4oHaOEK9bqB2qAob4O?=
 =?us-ascii?Q?RyW4QHsUoDxNgPtBBm0aHhVdyzJcgX65SPcOlj/44xdGclIHmx7m24lVl8Wk?=
 =?us-ascii?Q?w13jZrpAtAWjEXzAkxzSG3STek+7YtPDURcdLame3A+2/toSiO0+jU/vc6yh?=
 =?us-ascii?Q?uEl3m9J6OXwart5VG8to18L28c5rUPussL6X2i5nDqxlMrNQEVg3Ku1rIkdb?=
 =?us-ascii?Q?SZVn0XjS6bcWoT+tlmODTuodOEYlR+GWJQKT4C2KQ1RUULs1WRdkC1Iikaeb?=
 =?us-ascii?Q?ZO5iobCpw8pJ438IDHkUhGsPbhVV5GgmY5u2DiWJ1wH5MnKswbeSDyRA217f?=
 =?us-ascii?Q?Mn++ovaQxLN+Kjy8nfHCZeJdT88jMzOxlNNL87kSyQ/+/MhVDPSaTVlREoMS?=
 =?us-ascii?Q?vF9ZSuVNoPAo0IDk+wL4u/Q3xw4JJzyc15KjcN23wJzRZFHMaFRpoBvUlEtD?=
 =?us-ascii?Q?B2IumU5P5hV+TLkzobyznaXDg8LDRdbMCM69XRkYrk5qLE2c3neB6mo2HrYF?=
 =?us-ascii?Q?A5RlRljX2B8TIoy2+R/NjOvY3i86kMS5dd8DIDb0eB2eYgPOeuCMAy5bhI3s?=
 =?us-ascii?Q?7ujKLJwDv5FGmIx8AYrm2A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q7RGymnRkalmVME1+b0cdHA+UOkRj2x+O1H1yvb65J8q0AjdMNpwv/h4GqUD?=
 =?us-ascii?Q?pxn5xBqzvwiJQUgS6BdjPpme1LKmy/R1am5sib12dNxUicGmYYzl6LCENEjP?=
 =?us-ascii?Q?6iZqUb1R1yey+stqmoD7H851RRj+gVDOa7tjKC55iKwQKtLuUz+uCCWmKe1U?=
 =?us-ascii?Q?sk8LhOcoRrVV/Z8d8WKpP1TYwnBA0NWJCT7MQ3Vd2NHBKnLKyqEbY1rPEnx2?=
 =?us-ascii?Q?wNGN3G89ck6/iKftO8hVaOc1gUTfalLgt/XD0NzQCVYWTn3tWd+/lXg5rZPA?=
 =?us-ascii?Q?gR4p3BREUMYoFAXsRnXGpgbMinJkSxc1rbkQDvquwPiQxdqD6jXdsKbZdGAm?=
 =?us-ascii?Q?rAAe14B0TIdrpD39Rt3FdQYRmhB8cvwow+KbDfWoUAhVAZQ/5sSyTVnHxTXy?=
 =?us-ascii?Q?5A1hxpU74OKAaG8eRZ89qZzbACXuCrR00xvdhziuuHLiUw/M1BDBO1OcI2E8?=
 =?us-ascii?Q?EuvRFrauvFI1vijJRA1k9cuTWxJRNPLe5BrCHuvlYpNNn0B5GLi3s/23KiyW?=
 =?us-ascii?Q?gx2iE5kmiK3OOEdFquLxvvQEl7pgB5VD5GEEvIEG3wiT/tYFMdZSHvEBr3jo?=
 =?us-ascii?Q?PApQpx0/ReQIe/i9pYndlShl5YFHoi7p7BhuZeONVRtaSqDDSBpxkMtSp1vP?=
 =?us-ascii?Q?YzfyvQef7/7mHIb28VEBWdouK0NFf/hvRyvFeTp5oYqRXhV0/eSEqXKqbHC+?=
 =?us-ascii?Q?mathS6oAAK9DakHZnZZgI1X0hHcf1OXlozgCshsXRgnVr2Ki8BiRLxyt5A/j?=
 =?us-ascii?Q?kL0GLOFasz+bmnl/kz6vVLuul3gIGakKbNe4Dzgen8fkn7ZgC9uLTs2J6vXq?=
 =?us-ascii?Q?fhCvbA1Pxo9teg6bl3JWv3LjFtRtWIaqNPj1QagRUgIceiDHDpMDCRJsP1SI?=
 =?us-ascii?Q?ucO7EAXgT+E2oyUNCTVwUVIWBLNt1ZYDhv311IFzOdzI9nT4ApV/GU//LwZn?=
 =?us-ascii?Q?ngs2cuVhqYDs2q7oTcStjCr9CBftdOO2Mg7FunrMyCbCWZSpmldVG6ApNMKt?=
 =?us-ascii?Q?qGKAadqAsSP0GsUngf0nSZjaIIiPwMxIWfm+dw5+bElfpO/EiOcF9fgImDW6?=
 =?us-ascii?Q?xLk2q8hVchHK4w5WRQ8ocVK5KVGXQihyBd3rYW7mFR/3MQYxhpFHvmwAwocg?=
 =?us-ascii?Q?MTSFqs4ONcAAOjsnZ1ZPDQPkpa11keSNRXMjWkq0kxJUIxEmOJ0UF8fD4JeV?=
 =?us-ascii?Q?0giNjZM1G0cKtN3B5O++yVI3Xlg0tPIUY8QFOQLtMgRYFpS902mXXVLvNZKN?=
 =?us-ascii?Q?mJVZERj9NblxGo8kS9cNSEnFFcdcrtZDLCNDFOwiRUeZPlMxJi+7i9l3hBXf?=
 =?us-ascii?Q?XuFaV6SXawRgGoW1qUYiVzo08Lkx7MT8P2YuH1Jxg6bb6A3xyn3141Xeqxmg?=
 =?us-ascii?Q?/alYegUrdDHAqfZE3L5R3xxFy7ME?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9b90e6-2ae9-4e74-8c30-08de7d68d3fe
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:12.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

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
is subsequently enabled for git remote and git notes.

Additionally, the existing autocorrection logic is extracted from
help.c so subcommand handling can reuse the same config parsing and
prompt/delay logic.

Changes in v2:
  - Reworded the explanation of default autocorrection behavior.

Jiamu Sun (5):
  parseopt: extract subcommand handling from parse_options_step()
  help: refactor command autocorrection handling
  parseopt: autocorrect mistyped subcommands
  parseopt: enable subcommand autocorrect for remote and notes
  help: add tests for subcommand autocorrection

 Makefile                          |   1 +
 autocorrect.c                     |  92 +++++++++++++++++++
 autocorrect.h                     |  23 +++++
 builtin/notes.c                   |  10 +-
 builtin/remote.c                  |  12 +--
 help.c                            | 106 ++++-----------------
 parse-options.c                   | 147 +++++++++++++++++++++++-------
 parse-options.h                   |   1 +
 t/t9004-autocorrect-subcommand.sh |  49 ++++++++++
 9 files changed, 306 insertions(+), 135 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
2.53.0

