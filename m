Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024F3D3328
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860405; cv=fail; b=BSyoEIUrzZpUfpB3ft6iiTZLRYCl8CAgYn+yrzwazLqn5RhcImUwf7yJfnAYSH7IlfLv+iV0OdIpgQOULFlyNEAXIIahiLb+QHGgTRxG+bNDA3fHr8exh36Oz/MIzePa5C40akOcTGh2p69SRcS7lUqD+MadnKzBhgAI4YpFmag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860405; c=relaxed/simple;
	bh=o8fMbA43yx5MpfYQl24LjIEn/NGDzdOOG+CloXTzZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rAdvkOCABJBkI8pU3sXouac4d2nVG39INTO5DcSlHYnMHYOltw5YUz5JXd4riJxKDPZuN2citZ81Ys8nnYwM7rBXVW7PagTM6vDffQjAm1QaJkCOiVxpbPaf7KSj0VZQ/RboHHfIFmuvmJDEf5AlejFn8TESgL9jCMI6tgsmn3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gcmGi8Cc; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gcmGi8Cc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPR4+WMiuwDmXANDzcu9LN309cTnwFpmkUBwoNucf+LxQol1deM1dDsZe+g7ETF1aDktKbKaLlxjNsW1cjnJXHiLlYdSIzdKzZpm+NhChSpDMnUhgcpXznuz/O1fbc0O741691HfiIF3BSgtVqXQjaLZ91wH+zQAZ68Iqk+NB61huBICzMcJAL3q+uwyjwharslgJlK2hkYj5APMzsWm7OaOCxGhtNO9kghkFOLlzkb6+Kvs4zfwK3ilhmFQrbag55B4AM4ApXCWvE0z4sECt4s5E7K96cAaHRh/ZEGBlOlNB7aMgG4R4/bthau57qVNennBSnit+Vv0qio5qK0W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGfV0Ft/ITQ5YGY5oOZFvgaUcX0Yd7FK+48X+Q3cc+Q=;
 b=nFK0lb7fSxlle2exqulpsD1y83NQA3StLIE+TpZc55bNu9ErReflsznjK1cYIHF+3NfIFDgfx9BvoS/Ni+wq8TV/lyGCDkp2NTi51fBo8q4nsTaDyhp4QfM69tc9LUT0pq5xYhT52981+zbaYKeVFcOB+d3uXhYkq4R1GUyjqbiilD66MbRurSooUB7khySQdPeWmp+CKv6fvBDMsPQNSccAuuGoFzO2AzB5A4ZOaFanlmXkYY7fjZ+Z6jNvyMaAN6fo+rQgvMd8mvCA2QlGhIVvGdentdtXspBVMOWQyvEAbamRL4WRp5LHPkionpUBEf8+mrItrNhm48i7aVs0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGfV0Ft/ITQ5YGY5oOZFvgaUcX0Yd7FK+48X+Q3cc+Q=;
 b=gcmGi8CctDUe9JoLv0FzGaMzIunOt3cbp8VgEb/b5qFtgHpeG9lzV7eb6XRLQi1ewBi98rrWSRCODHXU9hlrn6TwrSnF+a9e0xF9Hgq+76+G0bLFey1+f3/RUWKQlJqJ4Ba9u+DMHAX/h44HdCS4mjds/mfv7GY9cVOsFH9cLrqNIHg1EmssCv8eUAD+oS3cPqjf1aJnC4pwUC94+of/PvVNPa/c02oeigeDh++8Sie3gt7weJZEZwZzcZEgnNGBx0trqFgcZHeTUH+NKIbgapxHPbj3ERu5l0KPq2I/hklSB3HgA0he7tWnAO/ejQB4Z2f/WsKfos1sHZ8PQbFRow==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:58 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:58 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 09/10] parseopt: add tests for subcommand autocorrection
Date: Wed, 22 Apr 2026 21:18:09 +0900
Message-ID:
 <SY0P300MB08018E1D69CECC5CD4098BABCE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-10-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0530:EE_
X-MS-Office365-Filtering-Correlation-Id: 0965a83c-c871-46a4-9fe8-08dea0697832
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Gurw4ZgVEifgjHEOnrmQbvHoZm6bIPEgv2HGA5YXSbUxujtIIKp0DSB6byR?=
 =?us-ascii?Q?fNX00fGc0JAAjitNP8Vg8w/RDRq+ehDQbyy7EPXDlxX3MSpnK/vsIWzeTK+m?=
 =?us-ascii?Q?R6oJ0FpCYcDKTEAYvGpkcVAxOmQ813pK0n9gjGpMsAc3c16eVkBA5TrhG4r6?=
 =?us-ascii?Q?36P2aZxNXzM7YIM86FbPkd1bwSOTLCjU1bND4Pa0I9LKAHtLQoSGG7+90upT?=
 =?us-ascii?Q?6FfrWU/oH3R1L+z2q8eaU3OIfCt3ycJCQwzYSEnguMutxTsxzPtJpOGliVP7?=
 =?us-ascii?Q?uCA7uHLyLthwXlkHZaVJUw23d8jMriU/Ox9Oo8bNpBS0uBo1q3IuX2/O7Tsn?=
 =?us-ascii?Q?NhyWc1d1yZ/CCHwf54j9I6U5BgUtAMMJzy3V2QLdyspkvIkKGc/4bWFTZ7f4?=
 =?us-ascii?Q?ILldUSsOCT9jTQpfAPrRMaOM+l0wNjxv6QRlbr79+l9ZiL/v3ARiLyPulr2w?=
 =?us-ascii?Q?nfNPovUqDQYVp7F8dYv5K22HnyRuJO+GwpQvYbBYd+VYCJE/9KEgRYTL5zcj?=
 =?us-ascii?Q?8rKDfV8tJuDnwTOuq8cmbBFUxvE4WxPXrGeaTiAKcTsbyZ6/UZAPUzqW/MlN?=
 =?us-ascii?Q?HAgkBoOMiCShUHRJuUh9cEPoAWKY1orfGoKcr87DZXIHgzsyZFSYXW8JfjS3?=
 =?us-ascii?Q?ilIOrsYOsw485yslDRqLus1l4RPoO/o2Adbooa9CjiIJDf+U99xtV8vVLt8G?=
 =?us-ascii?Q?ZGAKqY3HHj1udfK9NgUPrXqgU1+Ps2RiKVG477MeF3XdMB5FTnkKKtS56mV3?=
 =?us-ascii?Q?fpLVNrGykUJv4siEQuwZEX2z6/Z5DAiK229EooaAZsV038kdTkJAL9yC7aI/?=
 =?us-ascii?Q?V3urDBmWpvaZw5/vPfX05eVFZ8Qtk9ijgUt4caBnt6K7GP84GB/FzXz3wO+M?=
 =?us-ascii?Q?ZGUh+e66b0SUuF8WYnyArfxmhGPFU999Ipvot8gFVHE3kHpHAnYqqQ83Iebf?=
 =?us-ascii?Q?qa0UCGfPyOrtOC2qufm9X5ZxW5T3//Pfw76HJJ1UrJ+veFEy0rSqicq+eGDz?=
 =?us-ascii?Q?R7iW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8nqkTUIEKtD4A91ppOoZ7Wt0GzVEzj4qKBh5g0hrxfj6zo52Fj3l43RJfex?=
 =?us-ascii?Q?6bvetrjcq3GjrEpcjLqYOTCkG2RjzY+VVDV3uHXxFEGD46C1uVb6oJlugGYL?=
 =?us-ascii?Q?hxtu90nowu56RvuHpg4jwcSaEqzeabf+sI9C6cS7NHpz5Bdy9THeLZq9O5WC?=
 =?us-ascii?Q?Bbd2U5pLV9YWifgsMAC/DOhinQTmt/TGKQwGRt8/Gm3FFgIYCto6hqRk8GQS?=
 =?us-ascii?Q?wGCx+m91WcousFsi5F53qgRqZFw6GfHXd+FHlMcHVOC7kqVJCcxa0Ed3+9Jn?=
 =?us-ascii?Q?+4eDHfJVdouffOEv/8YeQs/ddZdXGKIYBdKMZi2vrSLony4FP0AlIRPNwHly?=
 =?us-ascii?Q?/YR3z3yieYUKzrNei5bo8QeVMHQaHY73uuML6ZKY9Hvk+wgrmhaGIGKmQxGp?=
 =?us-ascii?Q?a3KfC0EPkjL7Af/J7obVCZfveIxc7iOYE2NG/JLIthndpW/oiYO1BljLyaxB?=
 =?us-ascii?Q?0hGyXFnrYb6FJdVbelO2iBL84PZqr21MMMM+ygNHs2StveVCzQ2JDCF2lTH7?=
 =?us-ascii?Q?ZJlwH813kIrGdR8PxwwpTWbU/WdH7pd9G6+pVnVo0pXSvAQeeWzYcqnavK7+?=
 =?us-ascii?Q?tCrptuyPot4UGAo+7GUhKRa4gXZho12gBaFRuuMcU4ZrK5TOv7SCu0iP6zMc?=
 =?us-ascii?Q?eseWYjB+ljqCgf21jJB3H6JcJmXI04Kqaj5DJ6I9WOyMgAWDdoPhQRey1O4f?=
 =?us-ascii?Q?Ff885xRdW+vLgxy+cYs4Sfmkk6GlyjDqPiXk949C5YID5/lECPbSmQ6YsmrQ?=
 =?us-ascii?Q?H8vUDrRu2hcTxWEaHLZ8IsdMEmws242vVHjIfr4R8Cjbo7nSYOjts2LVxN4w?=
 =?us-ascii?Q?pOtOdIYAYYJwscpxXlaNUMsKmt5l57X506C4kD3AvmKA4+V9upBDEeuUVLRU?=
 =?us-ascii?Q?oyKB81ckL4VTvDP7m4T5vd+GjMdU/fW7YZvzmEbtYFb+vdn6lcMNAP26btw3?=
 =?us-ascii?Q?TJuhIAmP9k5w5Cbt/u/bVryQJ6JP5ALPhmejfx0zj0HIa0cJpsV5HiM/9RHz?=
 =?us-ascii?Q?bmPWStX2edqjipqiDN4gZ9PCUbZMfPohm3MS0lhVHx8ozsdIqFaAIuH7RoOT?=
 =?us-ascii?Q?1gm88CfgC8z8bw+AnTDOLjJl/pENL9TrmGY+Iwcse88EsfEX4tUMcyWpbq2R?=
 =?us-ascii?Q?K8n3MYabItLSZ14xSUbdJkY2HN3i0rBBq0U8LOkB2Fa6LYCeIRMOKq6a5byg?=
 =?us-ascii?Q?ZgsvmvCDco7ew8BAbQyyCAU9OqQ082jvk6KGG1KXBKGQvIcHpha3X8JG0lxO?=
 =?us-ascii?Q?grVHs7hYwIsPBgVHrDe2VJQZqo4p6SPS7A//9UqBVozDdugCLuHqZrIBLPc+?=
 =?us-ascii?Q?BJ98j6Yq7TME5Dcg4DwjYbIcBHO+XKkjqlcUW0UDxs/Uruafm7z++gERQFcQ?=
 =?us-ascii?Q?jdJsZ2XBQVOn7vi6k4Iygt0N6BVq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0965a83c-c871-46a4-9fe8-08dea0697832
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:58.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

These tests cover default behavior (help.autocorrect is unset), no
correction, immediate correction, delayed correction, and rejection
when the typo is too dissimilar.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 t/meson.build                     |  1 +
 t/t9004-autocorrect-subcommand.sh | 58 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100755 t/t9004-autocorrect-subcommand.sh

diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5fe..871cd7ab0a08 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -980,6 +980,7 @@ integration_tests = [
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
+  't9004-autocorrect-subcommand.sh',
   't9100-git-svn-basic.sh',
   't9101-git-svn-props.sh',
   't9102-git-svn-deep-rmdir.sh',
diff --git a/t/t9004-autocorrect-subcommand.sh b/t/t9004-autocorrect-subcommand.sh
new file mode 100755
index 000000000000..09d281bd105b
--- /dev/null
+++ b/t/t9004-autocorrect-subcommand.sh
@@ -0,0 +1,58 @@
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
+test_expect_success 'default is show hint only' '
+	test_must_fail git worktree lsit 2>actual &&
+	test_grep "most similar subcommand" actual
+'
+
+test_expect_success "'never' disables autocorrection" '
+	test_config help.autocorrect never &&
+
+	test_must_fail git worktree lsit 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+'
+
+for mode in false no off 0 show
+do
+	test_expect_success "'$mode' disables autocorrection and shows hints" "
+		test_config help.autocorrect $mode &&
+
+		test_must_fail git worktree lsit 2>actual &&
+		test_grep 'most similar subcommand' actual
+	"
+done
+
+for mode in -39 immediate 1
+do
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

