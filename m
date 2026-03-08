Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA428469A
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011845; cv=fail; b=J+qVNUoxSDVHcyME8zi6u16nBxXaNfxfAhXHnqxn/IXPZenJFYczzRh0i+RqAj3K+Q+uNWgp/nqBDmBreiX1wNllkJ+KEY0w97aRJ3A89gIbTv94uyOD0LNYRx5Z8aQBpOcOT5Tyr77j2LSWrLzf5pMurvhniwHHY2wam5+Du40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011845; c=relaxed/simple;
	bh=kQdqwTFbHVuCmR9V+Gpaylop7KEQtxLlAknPc3OVqL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qylGUenqclCHBBLB1CniusSE/rpDuN2b0CO/Psg5fIgBUsvEGJhxqSERbc89xwra12YeSHJYdxDhYHgkFm6eaf2NQHOvtWe9ApgaU3AqdrqOo2TuD7WsJ0/46TD7/6wRyTvrSbrfrThVLjbirnqBD47qFi9IJNo7SQ1QO8sXB+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JgAQFkHr; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JgAQFkHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djzskoagc3M9X7hRsBnHlQdqbPOsg8/4I6yUHB0v3ZF9HvsqqfPUmTYN0UCJsAyuSoFjHgkjGm59Svnc0dYpM7wjAMXrEY4sGEWbpDNcF124I7/jfv2z3yY1j3liQ0d5kk19Zt40yxg3CgIM7o9B4UjUU4tPShwLrCO3xVxk8d6JGTF6r8gUfrJz2BTZXsmEkfrmj1IxQDH2AN7dgeP9q8YL+s0g4ldLnvjVmjiIGrc7rtAhPgS3bdzn1X7W2of6GIr7JDg9HE++eCWhIOmXCWggre1uhcsoiaykU0sqBJNKw/mQiVwvYV79o7LKZh35SMMyWbtz1mNqNtb1WcLHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM55LwZfmNWWkkCokseA5XSO7EyQUZpvmmg3TSU9Ido=;
 b=VIIwzzYnbg7WrQDtbpUjEQuqO269X0PVT50EhTcq7RhegLAs7iWyxZKEYbZ+QkUMpakVtKjc4mIP/z8Ar4/19oo+baVgEd9/DoNBGg4+nz/Unt9zOPSqE2zXJcQDmCwLc4gNwesQjl0vfgrqfpUT4n7ad6NcDaQljgfhgVi3ACl1L9ng5lymHlrimPSenmPz/LP61ajkDoF7zZe696teTlRufCRMChOlkrUAgrfF5aj65A/NMseJ3wg+Rglr7HqhHtpLQzBKJPIby5VEegXECNB2giC1lKLkZ/cg4fUtUj1HfzejcO61FWJA3bcc1dbRmx0B+t9JuEO3pu4YoaCd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM55LwZfmNWWkkCokseA5XSO7EyQUZpvmmg3TSU9Ido=;
 b=JgAQFkHr2yZ69NC7Mi/HRowBJYJvVq/DkW5kJAcZGb/MTp2hvYhMz31CSO0YzV7pmMREZp4ZB0pvYUug8MGpP38jdhqKY35aZEg+iYM9IxeyhnBpfBoZHH3STV6+hlptAUYbyu0K28TvYTthUosTMDjZkN2RuixsnexZpSR+HGovF340IqhQHjUcnA+nNC/F2apk8Qiyo5mXHUryQsbrcUySLogPoMcNtN2RBmN/KcMpGeVuELD6AxER7kbM0HfeO5docuJlcQcfpxE8z8gzlAZlmhIyX3brDZa9udYmgzeFa0+8iURtvGPrNRot2ktqp2V9oeYNWEL2X8sHJhCglg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:19 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:19 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 3/5] parseopt: autocorrect mistyped subcommands
Date: Mon,  9 Mar 2026 08:16:57 +0900
Message-ID:
 <SY0P300MB0801FB07C6D570E19243A99DCE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-4-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 7900c266-b5e6-463f-0e23-08de7d68d805
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|41001999006|8060799015|25031999004|23021999003|15080799012|12121999013|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhdPjuFC28ke4nTbIkG8ue14FW55jKOsKYs0aqbotGhHehMCb2bgh6HSTP2w?=
 =?us-ascii?Q?aYlx6amyoPxTrIJfEl6PmaVvmktELjCjBsY2hAK7My3HUvcr6ARjWipApii/?=
 =?us-ascii?Q?cUErLwAtEoT5eMZrJ8ZtFB/+RlUF+r3d80+xgxpcoUuAP1fAuvEh5Lmqs/3Z?=
 =?us-ascii?Q?U8eYp2SZu5dvMYgzQyOkqz7yYxeMZebKlPfmVIQj28c62YcUxO4Vj5lqxu/g?=
 =?us-ascii?Q?PZsrIPbkhXni47kSpjTtUttF6p3k4pj+ZaGjtDcsJZF8puz2BDmlmiw9hW7i?=
 =?us-ascii?Q?Wtrk0FBk9TYuDIGRyLhPAiG1E5isB5bkNKxznuSjy48cLPASKbrnEfgPXh0y?=
 =?us-ascii?Q?/HnrL+zpyMeI1hXgXckYOiNZzZEC2O3dJ0JSCLI6yDSm8qbQszsgHb/3Bh8Z?=
 =?us-ascii?Q?2TRjnT/66ga8avIZGpe4FWNmFt4tFiKBlJquNSFH1AC6BHxzwkMWXMVeMk0u?=
 =?us-ascii?Q?rj3dbsRFey0xMIl3i22K/E6fOrnfuH2KK0X3yWOlVe1H8DXN5XU6iBwUgKbD?=
 =?us-ascii?Q?OlYZj1C4DH1Z8PVx92gUhYtvH+WPwQjE0rsE7uKgT9t+eGi4s+MoYwLm5EVi?=
 =?us-ascii?Q?YJbyJlT/LR44NEFk/VXjifBtv31J0VTwfIhdGiSLP3bknCl/ZnkEX5jzXyCk?=
 =?us-ascii?Q?+yHE0AZhnBREKidelWNEaMWuFkCERJu54ZkPgqOdOd6raPV2YL2ykb2q0qeW?=
 =?us-ascii?Q?rEtjuES1sQJr6iQvHR0072DwZIF3/pxx2BZ61pOERZMRZFfmyMRKfsDghJnB?=
 =?us-ascii?Q?wzJ1O0H2L7DFdTXEdwQAAwhgZ14mnLGRLAIHa3CS+e6lqy1pSefLRCncbT4T?=
 =?us-ascii?Q?71fKb0nFJIVspN1ZGYOgqMRgv7G4RAR1jwpEVz/yzQ0YYHrl1FeUrvWDuPUM?=
 =?us-ascii?Q?L94m/WV9AoYDM8Yh1NgNOJPbWI52qMAjIQo6fgdBEKZaYdSXs2Is8LfuHLNa?=
 =?us-ascii?Q?rxiWpLjgHOQ+cQxkd1+8+gnxrjLL7qYBLYl57X7YJ3VdNOyZzN+nhEY8w4Je?=
 =?us-ascii?Q?2TYUwZCFCTruTBYkWszmnZJAlMUuUQ6vYg3SCmA86LzaARQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEDA9n/6+w19ENvDRCxjMXoGovo3++jylOrW8TuX2Za1PSyu4Sz3kkpe9QKa?=
 =?us-ascii?Q?z+8GPS09PpcLYcsZ61IsiXCHl/VYTFbW8i5p8WD7mWwpIWMM4Yo62qdB8iZX?=
 =?us-ascii?Q?hvESVklaHHxMr+k88D8WglDjZk8tiVorG+QCLP1/zY8s+Jkp2kxkf58rmfzI?=
 =?us-ascii?Q?R/2bg1TxlTUkXTNQq6JpeQ91Q5+KdWnlgHeyWnLzPfiH0PsA0lRg41jkfc7c?=
 =?us-ascii?Q?ArL3tkF/6PsUeS+B8imATK5sIrykC+g0jRoZL83RXJsPF3hcyC69lEQyNdg0?=
 =?us-ascii?Q?YEZHo7HrQUhWSiJzyGlj0nSAZGqckMbYVm6WfHeAsAEFNFmlNkizeKYWYI/b?=
 =?us-ascii?Q?/GgEMRzBpMuVAmScgUPLRGZoXUkfEZJxToOGOB5jeAf4e/EEuSvv3irQj1DC?=
 =?us-ascii?Q?hKkx+9XWzyHdr7fiPxU9PVaQIzizBxYTGv0dqXRjHG+Ld+jPL4lL/dxQg1Zo?=
 =?us-ascii?Q?oeJkbn+wR8ghKnemD1ykv2+FGY17wsse3P2j7OdPCRLcuLYRTXfcI1Mr2U0l?=
 =?us-ascii?Q?aDQrsa2BKptGLedgQ7I8Rc7O0go4Rnz9PbQ5bZqjjVLZaQ3gh7wDatcq3hmK?=
 =?us-ascii?Q?mgj2J7yIpBTVuG5zFQQjswHcDJCe7MmvsmCCZeMveWZyqFSVytUqdsKF3P1u?=
 =?us-ascii?Q?Ut8msU6NgLTUEpBnR+/mpaAVj63biK7+oLyt+VI2wL3CuIyf76Gg7Hau1cvk?=
 =?us-ascii?Q?NXZ6sF3HoOxeN/AoqmRJbJqmoDf+5g4IMaDMzYmhzITMiZMFiw43BEYWII/2?=
 =?us-ascii?Q?fY7Uchza2+2kQQn5G1XZakpeFZGcc0KzTgljJcrIzV2NdPhRc3TrytuQLf9p?=
 =?us-ascii?Q?vBjntOwW2DBW3G+SSIovUcrfB7BvIr27vyINAtAOuB35zrwn9PCpWmHjmcd5?=
 =?us-ascii?Q?dBRlLjelwa+Ur5Qp4TE4I4RDxqa+y05MR/hINpROQlgQXheU0GHK5oDMrfk/?=
 =?us-ascii?Q?yi4ACYdUHZo8Wi6u/LyfWupMC/KGL6/kHmR5xC52lhv2bSXsGPFhMpyeOn2F?=
 =?us-ascii?Q?rclapmttHI6LA5EJ3oCJ2cMjvzgOczVuWkP+0wdSXq8grzr0Gnxk91654+6h?=
 =?us-ascii?Q?00WLXahgAjIcPU3y7gxRyNTZ1CydAdVYPz0CiR7WHj7454VLsWluVcw66ds0?=
 =?us-ascii?Q?uuIDNPCVZMXUgRk5A0GzpDvkDwxfqxRPnfYlpKzsGd5A9VuMYc/JE3B0JdMb?=
 =?us-ascii?Q?oydVHu8lP0MZ/DlZxtvMK8SyEZU1QfRdfPweqQVV3SMfCk+D+MGwxL0PcGJ8?=
 =?us-ascii?Q?nrR/kAhXIX10qX85pKpePvusaRxKS+VUZt882hgU3F7I/6NpYywszJNI+9+r?=
 =?us-ascii?Q?NT8XO/2E6jvvgtz0jFyMAiAuBdYev20dB+uSjfRFpcFw3HoN0NBgFkecY4Wh?=
 =?us-ascii?Q?k7b7bEINbopziX/ML8VIXzcPshaS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900c266-b5e6-463f-0e23-08de7d68d805
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:19.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

Enable autocorrection for mandatory subcommands parsed through
parse-options.

AUTOCORR_HINTONLY is equivalent to AUTOCORR_NEVER here, because builtins
have a limited number of subcommands. They are currently small enough.
Therefore, displaying all subcommands via usage_with_options() is
good enough. This keeps the autocorrection handling simple, too.

Also, use a dynamic threshold for similar_enough(), which can yield more
accurate typo correction results. Although subcommands are often short,
they can still vary across builtins. And a fixed threshold won't do
better on both short and long subcommands at the same time.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
Changes in v2:
  - Minor rewording in the commit message regarding AUTOCORR_HINTONLY.

 parse-options.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6bb0c5697099..cbbb04b9997a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -621,6 +623,64 @@ static int parse_subcommand(const char *arg, const struct option *options)
 	return -1;
 }
 
+static void find_subcommands(struct string_list *list,
+			     const struct option *options)
+{
+	for (; options->type != OPTION_END; options++) {
+		if (options->type == OPTION_SUBCOMMAND)
+			string_list_append(list, options->long_name);
+	}
+}
+
+static int similar_enough(const char *cmd, unsigned int dist)
+{
+	size_t len = strlen(cmd);
+	unsigned int threshold = len < 3 ? 1 : len < 6 ? 3 : 6;
+
+	return dist < threshold;
+}
+
+static const char *autocorrect_subcmd(const char *cmd,
+				      struct string_list *cmds)
+{
+	struct autocorr autocorr = { 0 };
+
+	autocorr_resolve(&autocorr);
+
+	if (autocorr.mode == AUTOCORR_NEVER ||
+	    autocorr.mode == AUTOCORR_HINTONLY)
+		return NULL;
+
+	unsigned int min = -1;
+	unsigned int ties = 0;
+	struct string_list_item *cand;
+	struct string_list_item *best = NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		unsigned int dist = levenshtein(cmd, cand->string, 0, 2, 1, 3);
+
+		if (dist < min) {
+			min = dist;
+			best = cand;
+			ties = 0;
+
+		} else if (dist == min) {
+			ties++;
+		}
+	}
+
+	if (ties == 0 && similar_enough(cmd, min)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorr_prompt_or_delay(&autocorr, best->string);
+		return best->string;
+	}
+
+	return NULL;
+}
+
 static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 					       const char *arg,
 					       const struct option *options,
@@ -640,8 +700,20 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
 		return PARSE_OPT_DONE;
 
-	error(_("unknown subcommand: `%s'"), arg);
-	usage_with_options(usagestr, options);
+	struct string_list cmds = STRING_LIST_INIT_NODUP;
+
+	find_subcommands(&cmds, options);
+
+	const char *cmd = autocorrect_subcmd(arg, &cmds);
+
+	if (!cmd) {
+		error(_("unknown subcommand: `%s'"), arg);
+		usage_with_options(usagestr, options);
+	}
+
+	string_list_clear(&cmds, 0);
+	parse_subcommand(cmd, options);
+	return PARSE_OPT_SUBCOMMAND;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.53.0

