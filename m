Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E987325705
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972283; cv=fail; b=Q8QN15WOEAARAh6H9KJ22PP95kTBTz1Mq9d9WuJRufAwPe5mwn2X066j1J5QTlt0haqIm7SD8b4+S85y5Y5CFqXPz8wcyyG0WSbeQ7MqO1nlH6Z5yElDjEICRDfwN6xvoHf6a/Tle2HzmagAbem/ndJHnXtZBeDZdVCnD+RJ/C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972283; c=relaxed/simple;
	bh=rgUca4tMBRhJrobBus/rgrgK9qgrT5Tu1tXIF6s4xLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6rg/AmgiuAYYoCWg27I4hLQVZ+QLQIX20HAVUfJLkq4M8FduSbAieDyvt9fY5SsAgry44iaFNoJpHeMjpd2f3r4vjsgrBtRpJNVmD1Xg8q532rH8M4uIyTQ6i4UEQV55yzyEcKJBk2GlmyxrBhOZG6NeQ4fCkN1pQ9yJdTdXRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DvBR5zI9; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DvBR5zI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpSjrptUe5XMYjn65kxf1UpDx6y15Ecrkxkxuo49wFKRiJVXpGbqGFP7VdjzEl/Yw7+QLoSQMrr4F+j1wKoBWbY2PXCq93/+LC8eLFFECg/LDn36q0PuhA/AxYPgZ1zbwbQERoiNdQapntiFxdpn9tDCDju5xblYF3vgvyd5kfklSZATO9ZLoqQkYlJ6xfO5y+3mTXEjK36zqKlyc8pBmV1yYIpKagRNGHuRk0DkcKKiNeISBv1ZkPS+nHuZuLvyQIWkykW0iHs3IGjxuFrXUf0Of78GDzD220gSf3nMiffcj+mX+TgqUYwG/U8OIkz1OgKOc/df9TwMQxW7np/hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7zXNH0u//3TxO5XQ5LwcC9IqH60M+pPAuKqjaHaNTo=;
 b=JSYbpmetvgYOrvFP3/Mus9nncGu1vr+QNTfAzSMJ+0uJQgLP2V0OHOBpBFh26yOfO+QW9k8VOr99bPB0SfbNmiIMIilXaPSHNp1WEmco9QEaITERCNDjmvqh/tOiMVCD1klbrK/G1BuMaRzOOyF2i4hyz8QkVOENpDC6xw7ljW7Zc4XTATvgEVw+jr4/HWdqgM8WTVCOSZuv24hbkJO7jwhdpVbZpjWvTCr+eSLNqCpmxN3KgsbXy0al22x3sMLLFdjzWEOgLJXoF9vl3cSZSh08i/P6MW48yusiSRJlZeEN1+tOxRCQIOSMEOQBReRHZSbXHVKFVQJ3xXRvDvV3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7zXNH0u//3TxO5XQ5LwcC9IqH60M+pPAuKqjaHaNTo=;
 b=DvBR5zI9fFOd4mlbsWNJBK9C1dYRXvox8twV3+1/r9J1+3BVZMS/7F8q7wTvxVprbOaJTUoKsCOnfm0SoV5gWnZKZrhWIFfr/r5YXWpvF81P14+2cPP6AUc09x/5XY2UTBS4IuOX2hgeHO8LObEfIRRXPA4X/PTS+36/V887kkghB8re+QmaU+iGiZ7Y/8mmW4SwdAcPDA6eAC3tMAvBnLmvdqPnBY49C3cHXUtuXrU6jrW/55lsA9cbilsSB8kGP00JsEPheN6eMvUFoBfZvNWhhRITPllmi0tVA5AmgGAyYdwpEIH0/F8iCTYVt14l3KgutD1DBcEw5pWlGX999g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:57 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:57 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 5/5] help: add tests for subcommand autocorrection
Date: Sun,  8 Mar 2026 21:17:25 +0900
Message-ID:
 <SY0P300MB08015B9BA815B2C4F6CDC639CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-6-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0080:EE_
X-MS-Office365-Filtering-Correlation-Id: 955501f8-2b9f-47b4-81b5-08de7d0cbb9d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|15080799012|23021999003|19110799012|8060799015|461199028|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKatlrXz0/NUEN2EAmeSFHHu9drWSVZdqg+M9piqJBlACWvyZJSsgy49D31j?=
 =?us-ascii?Q?Zq7Nnwh88WDn3j0GVYHD6y2ugNrZn07zrzrmO3FGbfKkvzNo3DKCua+Al8lg?=
 =?us-ascii?Q?yU3yNs346QnCvxrtNjcwXAW0NWyOJMyvpUhMaA/V/Z9KNEn4xuaQZWJS9YiE?=
 =?us-ascii?Q?iigfM+/T1rsNCinhZl4Bg4TWC7uBAsgEvJMADKruX5U/mOxPgS1kL1VmvSmg?=
 =?us-ascii?Q?175hBPppT+g36R+UCGdox6QnzTgfqtMPb7CwsmxTAf3vfbPtUTlbvEJa7pxo?=
 =?us-ascii?Q?64b0UPcb2B3ZcaNGKes96twCqfVTLX724JKeVWIcpnWAD/BqNN0AIb80VdHI?=
 =?us-ascii?Q?Oa6suPsAQuzl+Wt9n7bkkPmoWn/f/5HnbL4VPz1+d+N2pnv3HeaU9VS+usb5?=
 =?us-ascii?Q?zkzq2mhAI2TA1pRW9k1BYZVAWYy+gWEZeaV6vFkOS4ZO6JVxiOwNYUiAna4m?=
 =?us-ascii?Q?ggiVvOpJZZneGGGKIHrOGL1Q5dmUIw7RyX8kY7++JyW+29Ssdod5YFHNA6sa?=
 =?us-ascii?Q?bAgx6IPqGFUWPTq3bbbZA0MOFrxoFLQJQCVWBg+D1mqA6UAFvx6WD6Q/iwwY?=
 =?us-ascii?Q?6kC9F39LqLqN9eMIr32/x7z9rXdZ2/vXJXh+fj2Pbmxsvy3mGTFmUNeZNbDb?=
 =?us-ascii?Q?7/rr+5/Bt2SncwRRKJV2Nqw92rnQelEi65eal1082rS0vVfvL+082nhbiw2t?=
 =?us-ascii?Q?IXkBaa3WSMJs5ZjI8JuP8SLNXGSO8VoRRpp5VXnrZDJ1fOQsVHhufNebT/nA?=
 =?us-ascii?Q?CJsncThWU4yUswFJ+3vz3ZWCZKW2qquDYlpeHWjjc+RV2E1CsKIDmFATgPQs?=
 =?us-ascii?Q?sUtDqxvIqmv+1Fat8Av7+oQ8A1/rkxwtUxAm/mplF4TEIh9l6qFMPdF5KMIh?=
 =?us-ascii?Q?m4zEfxdO/xK/0LbTG72yfZL6o1Av4QABfzi8LdoVUSLTosmziBxPQMr6mV6q?=
 =?us-ascii?Q?zoXVx7dLKGyTDtR4zTZkrQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bR4tB47CTg0ZOFeSWnkkpZAiWwKR9YBxTaf+JX3rzcPQ0SCspjE6VMJU59wM?=
 =?us-ascii?Q?EkPH6CWeMu5l3ytIqeF5HofoqZ51kksh8K/ZnnW2TgxZYQ2nvQoBu58eoLbm?=
 =?us-ascii?Q?SY9XIoH3XFwxnoM7SZXTJlehSVdPKbEsF2QRm1506aICbgCYbkj79cca1CKJ?=
 =?us-ascii?Q?uTgG6mvQBksnDsVY1LeLCm0HBqLTHtiszF/wy4slbeCNQQoCLgYr09oj5KV8?=
 =?us-ascii?Q?m6ky5+C7VfAorMS9QVkdrgsA9Jg0LKuZQeNDW+STsqxLMuttAjl4Z3qKXCX4?=
 =?us-ascii?Q?EwEiudGFGTdgGl26YMZy6tnpdPYfqnFJMHUU3FVqcfaxg+/3UjhCsbS6UyDx?=
 =?us-ascii?Q?1ZW73oFH2xmoZBEXsgnaMVhiEkLSiDlr2mHazFMnJt2mWi+982LByQW9eCjx?=
 =?us-ascii?Q?Nh32arJKlv0ovAC/jnP2G5q4B0DiW3xBYD35Tr7wHM3/bUbi6RdJWCfl5imf?=
 =?us-ascii?Q?91Lpac+4Eygt0bZkbS2U5c5lBpyvNuYVaK/KvGXGLZBXqRgSb9m49bL+5ydV?=
 =?us-ascii?Q?MYBkIInais9bLhUW/mS0A+MUQ5Dui2b/PdBkorunYus3SvUiWfnr2Dw2G+7t?=
 =?us-ascii?Q?NDPOHeleKIT96UlrrOo0EuVMkfqQAZRPHplYNCPSitr1ari3wiMrjkDO604K?=
 =?us-ascii?Q?1zehNRtrCW7o8CFxZm5x52QmIPCn+jHJsMFP7E1sJbEKZ7LCAqE5WvqU7+4Y?=
 =?us-ascii?Q?AsNM0Q4hc9zWEq47sdPXlLbXsnzO4TGJTtKGA9xhwnRr4qWkP/75AdX3uPyd?=
 =?us-ascii?Q?+Z2DXqwXmKw8jCL7uNAiOEovzZLpFWU49BKtGk6m1t5rZlUQAWhCHwYZpp+W?=
 =?us-ascii?Q?J4z+kIb1+zlDH7JDXN/g8zp5vkof3yrpzC8mdDM6tX5hd11RB3eKRN9WKa0a?=
 =?us-ascii?Q?DcOIG0aJQoS2L96Hb5IWDee66SOvkWdbFmqTYIjzEJuReL4XJFTDGwT7c9Vy?=
 =?us-ascii?Q?ZkeTiwlrhPdV428/ubgGbCI9DZPXQ3k+NYD3cctyMBAN6tPsLFHgaHtluOdX?=
 =?us-ascii?Q?JSXewGBPm1L38O+fK3/f/HYmlS73c5wbKqmhe1Wrmk+5vsdB1U29/8Cm2GET?=
 =?us-ascii?Q?HUHIgeyEPfq3SQXjdM17sKRSIgtdgjwhdunjKyvjXEIJXQdscmbriXD8Iejp?=
 =?us-ascii?Q?q7fInBFoHhDGPAJiV1mWpBTxn4OXpYO2TAynZUY6KU7wqKhGuKXvMZ/M7jGI?=
 =?us-ascii?Q?EiEuyJr3tsqfyP7cb3ipqKNu+PpDYyZzmwiAjXBlJUEwo4i/uCTVtQLs9pCp?=
 =?us-ascii?Q?IVvR6NrPmY1wAs1E91ZE2TXQyHha0W+fvAEBQEqhWu4g6YPJaxpvIT/4E0qw?=
 =?us-ascii?Q?mjsbIW7w/PXXyDMVRPGtCUQ2Y2JrRgPd/RFCLw+Pg0ZfCZnTUkM/OcWowj3k?=
 =?us-ascii?Q?bQO+ppE37pVrmGOaft7Q+qUzR16G?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955501f8-2b9f-47b4-81b5-08de7d0cbb9d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:57.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

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

