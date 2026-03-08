Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012067.outbound.protection.outlook.com [52.103.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910303368AD
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011849; cv=fail; b=Dp4a5Xeq3ipzy/PM3bblZAVCEBt4Fnp2QUkJwpR6W+pnz8CUvB/OXcYWsr9vdoa1y+sxdahxlrkbAlDQm++DqP0ZU3mmvdabjMj5H8qr2GLeo2PFBQ8e+ez5srkqQlR8ATq3etv0BNjQco+FNKvWOAcHel7xMWQCO+KCpAJzPGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011849; c=relaxed/simple;
	bh=rgUca4tMBRhJrobBus/rgrgK9qgrT5Tu1tXIF6s4xLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jtf5ptuY3h5jh763XOR8MBaWWnPMIkabzAkiEcbsC0qfchwJCUQ7F4Mi+/nupdsSxpDi0hHdP6/P5ZlE0amGVX0fX3yZR2cqxAOAWimJqdqcJBFehKAylXAzbaB0omV6E0e+Om0NC78I5I/Qe2LI33EXB5JH3g7IWQ85EQlVCY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sniqUsIf; arc=fail smtp.client-ip=52.103.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sniqUsIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwKSPFiDTjIFzAyEBCWPStyx7wZNn8CZmGpCYif72LyntU0l9T6rE1kQW65USe+I99+mw2fmFERvJbbe62kGW1122VA2pgW8WzF9FToXGiMTdEStwAh+Uzv/bjaXaQp8z42gjcf9dLqIZHJGU6bDzW7OhvpoHQAmH+ptHKG532vYGg44kNxZ603U6MlSKvUR+M9UHnQVGArKtV2A4zvi4boCGInUDnCHUJmNmdg0mnNe8yvVxU/GTITTbRqJMLmp2IP0sCMbnjuTSNufaGHP2/5FZkhYWfH/wqj1XNkuPQYPNkehXQ1dPO3PHlQHGC+c00cSdzPGpKRpVhaVGPZqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7zXNH0u//3TxO5XQ5LwcC9IqH60M+pPAuKqjaHaNTo=;
 b=fXpcU0RucErJWMObQNwCcfpuEVe/5Gu6ohBiv2+m0pPY/Cqjn22hRX3liZBY25yyFutJzLD4Gni68iBuLIygBA3n8tVXj1iaDpSD+bWQrtglu1aPhzKaXinXmVqlOKE1ThnZ7+/CHAg9ANSGLd7JcJ43tZa06iXtdQnoXVByZmxKCvRUd0rTyYFp3IpD4SkEuXZ1P0+fern3VTttvbIy4obAm5vC7JcpNRL8YaS0nd8E+UvrWpehV6/R+/KP17cfhuEpGh3HeTys3V8VnVasSLy3F/HDeU0mK7OsdMMX0cFdO3Zt/uKWvkkycCU07YbXhEug6JxNcZCk/lSAhwgaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7zXNH0u//3TxO5XQ5LwcC9IqH60M+pPAuKqjaHaNTo=;
 b=sniqUsIfLkM3Hi6q+xMku4HdgdUgwDIaFCvzBFAa/Oe4fj3Znh5vG9NRzLDxKPm8949/+WdT4GXZ/UxlkNQJca8LN6L+1CQYheB7BQEOvJUNd08wegCzLnWwFtmmD/AT9gJPeGStxxkDU46f2yX5kun3bgqTO1dT0nqPegzGNQFESXlg9uSM1cek7mQQYothkLXtOjFmg3ljv1d8MEj5kzht7lgRMY2T1H6/kJNLxRryikA+Cxtg1QzLWFT1f3c4xEqClcSEOm4qU1MElatKeFqR8C2CGTggjYWRROuR0w8O3IfJuzThj1UN4RnStIPITUy/HjaautezQ/b0QKa5RA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:23 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:23 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 5/5] help: add tests for subcommand autocorrection
Date: Mon,  9 Mar 2026 08:16:59 +0900
Message-ID:
 <SY0P300MB080113CA2B4CF17AE6BEDD43CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-6-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 1375986d-d04d-4b3f-34f6-08de7d68dab7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|8060799015|25031999004|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?500mBk7daY0lFm+VS8Wwae1Qmij3RGahBGiHqUQ+tpeu/scrCkCQ+3IR8X3K?=
 =?us-ascii?Q?xoRBmbd5FzxzfkXNCdxZReyMD7S3R5eLBOkPL0sVEX/HdT3b1ZPx+Jl5Biuu?=
 =?us-ascii?Q?E5lyyl05eiXlEV1rEyjQHuR5k2S/j++kTjwFTrtqurAoahd+B73d3m8HRIIZ?=
 =?us-ascii?Q?t2GbikCE+wQe9+xrOrivCk758arsRFinsHw27hyz5ekFUt+5ctFQc6wEMFRz?=
 =?us-ascii?Q?2yRsvyIY/xwYyLjF1MvHv4zVjjPJO5UfkPho5ccwhgDZPK7vzeIdw4wot/3i?=
 =?us-ascii?Q?DOXmbiEaWhXf4ghBid+N7A8TzLn6lAaWABeSZkk1Z8Gi5xpHdXOlEWu9a18C?=
 =?us-ascii?Q?+vddm9DPlCjckJ7rrLLQP3HBbKgTuC5kvpb+o6JB6TRPnhZ7oHz2OeSiEtXp?=
 =?us-ascii?Q?ffSOi7R/qYbRR84EieRhXjGn2u7MFiKCJGJ9KDlvX/rDakz4fxiYKWJkmgpu?=
 =?us-ascii?Q?F9OCrdKNxByTFPKzcY/TR4c9aIC7BmjG98Czoj9niQlhXlya2G8WowpvTjhd?=
 =?us-ascii?Q?fJRL37nkgCmXZ/VAhkQl4Fn2prfBdXoHkYvlIPc/cYXINjYLGb+WulsOTVEf?=
 =?us-ascii?Q?J+M5K0EV6MmKLtu6NPYyBMiXivgIfRAAihsIuIGZFW6pLfar9KdSCrGg3qch?=
 =?us-ascii?Q?xWFmncFgJaf/qdfvB8u55/2S0BzRpNMLSkK+TACXk5KZYrEdw60fczI8dIfO?=
 =?us-ascii?Q?1bmfCU+Q0KFoHfdVNhEegzcffSm+pB74qD0ce1MfmgdMdBROhbnooo3rKXrq?=
 =?us-ascii?Q?XW0LwNmMvvMbNzM6Ecf6eUJ1qP7yY63qeo11uBEzLhX3YKPVVJqmnjVd/fbX?=
 =?us-ascii?Q?+5ULOh40vdbwhoXlW85tRQXo4UmD8k96LkPum6LJ2If3H7CUo8rTXtU9w46O?=
 =?us-ascii?Q?3Y3QCEQFOVUKO25z8xCOdi+d35sQ4YvcfzyyWY0wOO0a9K1FvuuRuqlygadt?=
 =?us-ascii?Q?4XdzC2XFQgfWFbpVB9COww=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LO+GmflY+YYtG3XmzfrWFoORj8m8y61U2LA98F2yCdVvkRM8jY0b/8kRs38+?=
 =?us-ascii?Q?B1NvBuKmE4Aizz7NHMKpCz4s3TblWIYZr/OgUrO0B9y/VseQFfFphmN/Hc2P?=
 =?us-ascii?Q?d2XWmsA8HambYfidDz2OI6PtVokvo+9HQfm2ZDtG453jCdSVpzxhvkvSHjw/?=
 =?us-ascii?Q?fssS4HWaYOwHqqb1pYtEG4CPm4+jaTmK1DZubfmn7SMxUWd3L30IkDcr2pv+?=
 =?us-ascii?Q?CEbedjyUpC8ntbrjzdRazIheeM7cHwyFGUo1ycyPIi4WPhzUul1Zk9xNuA8L?=
 =?us-ascii?Q?P0Y0wWb7iwF1b1izsjFlXtaxhsPvK3ni9KjICcXRmQ5+VamO2YUbh+UD/UrV?=
 =?us-ascii?Q?M/JKLw0R/k48dnSXxuEesZmZmwRRCf55jVdKVKQqzPnEZXoXHU2gKkPJTw/d?=
 =?us-ascii?Q?3ryM7nqKytzSWvt7LUaquUWzax0wAwn4VBVv0Fzltt5Sc98Pe/S0D2ywTgxX?=
 =?us-ascii?Q?Hdnw3jwuSpLpHTuFHvGg8J7MqjU++6uelJvBqvT3/hwd2RFH5v6NcqVBVADQ?=
 =?us-ascii?Q?8Zr4LEDcCGdIgq3sz/iTyVx/NP1Dm4hFmLGkZ3fCTyfoyhi5n4uu+NZrEQ8c?=
 =?us-ascii?Q?2hOo1b8R6wUviy/q9QbL9syO1La1JMmhfCynthunwE/RFRjteEgxiYoaryYK?=
 =?us-ascii?Q?Wk9VMp22vh6OPe8+snG02tBMbLD53nPwTzvJlkRvAvk43qbzeqVe5KUQhjg0?=
 =?us-ascii?Q?NmeoXCAjLkaraWiZaXNowkUxyOnrcTRUmPfUscYx6vWTOH3IJNwVw5/O9vkd?=
 =?us-ascii?Q?zU0IioHhmBjuynK7mE6u5+ky/FtU8yclsUf1yTrlzkRWaf3I0Yv5uB0CC1Dq?=
 =?us-ascii?Q?+UezGpOBdB4ynoHjTgYkvsdH/ASGr0S2y+qH2EKe/28EMKAcX8wr70xww1em?=
 =?us-ascii?Q?L4B9O3CmLoM7n0L4tzbADXwDT6x+wxN3JAyozt4z5334KUQN3YRpXI8VBnKM?=
 =?us-ascii?Q?bFqOSfpwxaqaqGsWqCrhfd+rYdRegb9xW5YLKeoXdd4avwJHyu0N+G2j0ubB?=
 =?us-ascii?Q?WbvzvdZS/JPeRBMkNroFl1z9/lBx3dRBr0Z1Aw9HGmfAEtQTpvup7Myv+5pL?=
 =?us-ascii?Q?8YMFeVlY2rucd3QDmi6/dN3NNULoZogkfgCJvmo/x8RMPZU1hKyXctie3OB3?=
 =?us-ascii?Q?74zaU2EBfYm3sfmO27D+LWfPveDHlshE50bFOnSYCasdfiNHXdTLGbtg242K?=
 =?us-ascii?Q?belDz8mGwwKXw1ixsy4b3TsgaRbC5trHcXApWvtvfTdCATP+LMZuxXxhMYly?=
 =?us-ascii?Q?hRFiQaZ6d0Mt4Nxst3rBonxEiIXKgZUVXTMM/dxup4Vay21eoV+O6EfG6hjj?=
 =?us-ascii?Q?IXsLqq233l9C3RfzRTbnjfM6R/KLv0FGLJkYkr4kTdEMvsb44fdORJoAfezx?=
 =?us-ascii?Q?EvTWhxlnK0QbbweOu3mawcNmo7nV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1375986d-d04d-4b3f-34f6-08de7d68dab7
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:23.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

These tests cover default behavior (help.autocorrect is unset), no
correction, immediate correction, delayed correction, and rejection
when the typo is too dissimilar.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 t/t9004-autocorrect-subcommand.sh | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 t/t9004-autocorrect-subcommand.sh

diff --git a/t/t9004-autocorrect-subcommand.sh b/t/t9004-autocorrect-subcommand.sh
new file mode 100755
index 000000000000..760760c8851a
--- /dev/null
+++ b/t/t9004-autocorrect-subcommand.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='subcommand auto-correction test
+
+Test autocorrection for subcommands with different
+help.autocorrect mode.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	echo '^error: unknown subcommand: ' >grep_unknown
+"
+
+test_expect_success 'default is not to autocorrect' '
+	test_must_fail git worktree lsit 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+'
+
+for mode in false no off 0 show never; do
+	test_expect_success "'$mode' disables autocorrection" "
+		test_config help.autocorrect $mode &&
+
+		test_must_fail git worktree lsit 2>actual &&
+		head -n1 actual >first && test_grep -f grep_unknown first
+	"
+done
+
+for mode in -39 immediate 1; do
+	test_expect_success "autocorrect immediately with '$mode'" - <<-EOT
+		test_config help.autocorrect $mode &&
+
+		git worktree lsit 2>actual &&
+		test_grep "you meant 'list'\.$" actual
+	EOT
+done
+
+test_expect_success 'delay path is executed' - <<-\EOT
+	test_config help.autocorrect 2 &&
+
+	git worktree lsit 2>actual &&
+	test_grep '^Continuing in 0.2 seconds, ' actual
+EOT
+
+test_expect_success 'deny if too dissimilar' - <<-\EOT
+	test_must_fail git remote rensnr 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+EOT
+
+test_done
-- 
2.53.0

