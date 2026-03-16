Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935A3A1D10
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675412; cv=fail; b=eDHqZIQCUnmrBAcPqOsyb+dCsZ952yLHkt8DWTWudiZGdCSaNeMJGCbDn5Q+5hCllnPRhnmwFRa/X9Xvb75LcvGLYsI4yrSlhPTK9iJ04DdYSwUYPX+LKBYDcwbZB4jFYZf1wMeBQs3pTw62aFZovk4j12ByqMF8yxVjABcXwGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675412; c=relaxed/simple;
	bh=e0/fT4pYwMwuKNDNPMkHVEV5Rnrkk0SfUgO/1Eel9bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGbmL6/nMQSrlDCqakP0tfs7l7OJlcokJ2E6Ql6rRmMaEP6m2KHFhCzxe+egYwzO/PmiNVYIoZfvFst0cAWuseCEsv5WBkozZuDYCwFWG8tuH8KTsvw4hIWjR+M9lTlvxG7noaagtxybej3a5sevvLXPe6t7JMuwNsZ0U0niNpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N4r06TFa; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N4r06TFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1m7orN0ahwAToC2UW1urlXxUgGpDEssW/xGGRxCH6pLt1M+8WN9FCPSaOlMB3KW9cwU2DAuWNa8S8KYE6vyejcejnIhjY7e7ZVVIoj8Vmbmq09HfgUnKgi0/yuTbncBK9d5BIkJujKq64lAfDj8kuS6PgAtXTZEYjXJKduTIwvKnzkWLgriQEMLDh6krSR2liuNYlB+XZHg3FROVIFGLhSpbptJx08NXYb9oLYJ/Sp8FUQoryBlWFUgtQ+6PsKJx1Mgotosw7aUynZHnkc1OWO2Ste/j6L/3Ld6KkBKKd+a8Am1ni17JbLpO0SKsfVu6lPs3VIrwpKHFEAHSBzRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os5yeKeptukIkR5bgcC1/C3GEYgdPjMoLl6f8GAZmp8=;
 b=IS74fMJHJG84v3lrm67NC8ruarnjf9/XO99EWHVsuUDrUxyYYgEYa1SWtXIr/YcYJb+HOPFeBzPeK21jk+LNyKJan/5VbrVNydrHq7bdXfjeJr2lhT90yDG/SGiSnx4t6nx+j2WQAwPgbwH0Eflur5za1z2b5lMzw6v04xi8UwWvVhkPQP0PmGPtEGP4phRiYtsEIsOxc7MEyzo/bu6hxRvKFnb4cfyqbFXj8vXbUGXT0tBiRUySua75/2J+vOYfnpKAA+L35X0MD7JwiY4ul/fOIkVkeQMacrv5BiWhI0C8npjW7bQr/3ztysN64YSP7Ki3efA//zhAokOjnIjTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os5yeKeptukIkR5bgcC1/C3GEYgdPjMoLl6f8GAZmp8=;
 b=N4r06TFaNDQrJ40O3biW7smKo/GySrfzrwAPvF90neHmuBhyIeADlsmINW7/pv/WSCFJYyHrZOvtGK4CEmXJslY7IK787kT5tTUSGQkDm+jAURKxS3chybZM0g4q7RpL95y2xEfhv+5GXUVw54Xz79i6MEOcanqk+iIuQQVZsDXUDm15SL/brBgY1S9Khf+1lqfaeOd+emVjadNAF0Ig7OOccINHfAGS+tkrlJ0+VPHVGrHXiJyt4xOV7ehDAn8ugCnWvCNVS2TtSD/BB0kAup8RrbP/OZ2PJpIbk3d7mmN80b4KpgDxumbOw+17m2HYaWzpONWVgv0DvgHgBxI+XQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:42 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:42 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 07/10] parseopt: autocorrect mistyped subcommands
Date: Tue, 17 Mar 2026 00:36:20 +0900
Message-ID:
 <SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-8-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd971cc-f999-456c-7a59-08de8371d2b1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|12121999013|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPOQm5k3JJXxvgz33jpWearTlxNrBmuatqUPCpZU+c6Ew7yusvXyma0YufL/?=
 =?us-ascii?Q?TizND8M1E0Zn05kNfUD5RRj7dqYVeYzHc4pLOR6c3arVlHNccQb4h8ATDadd?=
 =?us-ascii?Q?0eMJvjWjzvbEaHjmQuVojWxfjgOcUt1ITOUH6clvvE6YdOeztM0MwqBfDJiV?=
 =?us-ascii?Q?CKFY2huYwBBSBeMfBhnj+aSZP3FxeI121K9O8/kOm+XvYCQyxSgPZGyL8b6H?=
 =?us-ascii?Q?qk7udLKue+65QpQ0T57xFCZwCEkekgCqViZ28boxMA66W50DZJ3wNqlZvy2X?=
 =?us-ascii?Q?7DegeiK2YFosE65gi8X+yel4nNhjrMezoUbKrq/tvYzeT2+7vcK+gXqeX0qf?=
 =?us-ascii?Q?CrBcJpjGwZEdVwoTBOK/CBGqY7S81oSI7R/BfzGz7OZSbhwFMBxVRnf7IwOU?=
 =?us-ascii?Q?XizMjzpBvnYz73UTWPTK6Ud4z0fDJdcP2kZ7QI8lnyJRCY0Q1JtL96DSh2aa?=
 =?us-ascii?Q?9S5nRIfWjwX+PADqSk+5KnQduZ3rNnvHYlWBdm+lcJJYbVtHV3B/3qLXbF/2?=
 =?us-ascii?Q?FymgnC/GdgDYEv0napldzLW+wzjZs8d7VXUcqFSCrGhc8UyZF2L6PPvIDjXp?=
 =?us-ascii?Q?JhR4g3w/y0h5Ec7MxergK0DiYo/h8Mf37qFQrK1W9LDIpGALmn5qjG6LtUMM?=
 =?us-ascii?Q?SKA6iPk3etm4eWRhMpytn2TqLTwNHr2/TBQZm29hQWcqo8F4jvCdMrVUZ8d1?=
 =?us-ascii?Q?N0ksoajnLZwCJz7uSSkHaPqk01Ce5NfzGw7JsVvLz5Ja/D781mdljvJmqvsL?=
 =?us-ascii?Q?z2a3CLkX1/UXK6kEwISnb37r4z0JH2+H8NBEkzx/fUCMBhNsRbigKPY4DRXA?=
 =?us-ascii?Q?CGVR3MeNJf+t/e8sMKZeLgE9toQF9tZxvDoiyYESdNwNuBt+40SCwZC9pMXu?=
 =?us-ascii?Q?MDF4k+CnbToiUMnYY09STXYbVXkEhm4jhXgx0loXRwUkbWlGbw9I3R3F4Hed?=
 =?us-ascii?Q?+i+K7Ar0QdnrrnEhId5GLJUlgu3x6GxgMJHOI6lxHL6oiRLiRbB0w8fQDVU0?=
 =?us-ascii?Q?tw5tcVZEIHQA9Lmm/8RSzfXx63lfObYn+NfN+KHVtG4547s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oY95dl3p03+ZkMGxaJ3J864tK+vnzCHkFLwY+9U8Vl2nvgVTxjL+hvx5kAu?=
 =?us-ascii?Q?qoc+OCA+Hu1jm2lt53cJJcklVTGC1O+a7CQhFvauPYrwFc5aG3Dg7SHAB7g1?=
 =?us-ascii?Q?WfF879kPNwrvUZFOeOmeTqoFep56y4lvodQWxYjv/YHIUc5Kih2gsO+Nq4dh?=
 =?us-ascii?Q?aBmw+bgfctdbFfhmaNsI+s85ui3CuDNDtNpgRZyt3hK2MJ15c7hUGf4+Ofg7?=
 =?us-ascii?Q?PC5vWMXw627bjsIVJ+1ugB1iSJn9BB1Vtl3s+/X+o90Hyrs5ybX1sInCX3Da?=
 =?us-ascii?Q?/DNN/Vn5xXvK5Rk2JQu/78p7Jz1q0FGTgjSn18bOVX+2xq2y7J62m8kbbioA?=
 =?us-ascii?Q?ByQj4sUy2LjMI3NhKwI2MPGPSkIe8tc7UhYPyNLicNA2mRe1+wObO9YsjLqa?=
 =?us-ascii?Q?yvuznrrNgljX0cQsy21nlY93XbVkxml5CTk68Tm4qPXLckKE/s9PJpdLQxVG?=
 =?us-ascii?Q?CXbscUqiBY6uB3rZX0q7AhtANzG1juy3u3VF1vbtIzwiowIjGi3zrMBTdaH+?=
 =?us-ascii?Q?l/JX0Mhddao9JUtd2/vNqOKIU+Ec0FGcRhE6WSZGE4F7OPrRGJQzlxMK92+l?=
 =?us-ascii?Q?jpQxQUHgwt7ZRVh2s3i0gTOylShyPJTgWxkY1wclope4A/UmQtgRULKlMCGI?=
 =?us-ascii?Q?+7mGUFU9eZeJQJ31LGO2FF77GBvFH3QYZNXfBf1YFYilUuK+gMjD/7rWpDWn?=
 =?us-ascii?Q?sFpA71C13woUGAngu1UlZJPiCAhxiIe+i6rDX7Bc7SmZfNtTS8GgOF1+r8tO?=
 =?us-ascii?Q?PURC+LQW8zNMeDpD937bu7h/4+zHkh3wcc0ouVnuA7cXFozPJ0ftB3w+LZZW?=
 =?us-ascii?Q?xZasXnG4ma0HIiXhAxdb3iwg8OFX/xra4wgiNwH3d/kl8jkJq5d9s55MNzm9?=
 =?us-ascii?Q?rowkVmuSHaG6jb1mPHahOAZgtO3X0noQRIjPr3rJ5+SQtCzgLOdrVgaf4hLq?=
 =?us-ascii?Q?Vsskt9FTqbZi09Y0BCGocmekhDFbl8rYGv0yDAUMFH5q8MEXuXXKbyGGzhAm?=
 =?us-ascii?Q?7u8blPWa4qw9MXVm+oFus16ZYK4WlRP3QOqWN/RBu1sdtK52GU1pr/6dROSD?=
 =?us-ascii?Q?e1PMaW5pyNToZ65JD7yE/M5r+zY2wDzBhYFY8iDZac6btAtDNxFWQdqOgduh?=
 =?us-ascii?Q?72v9s9429gejlEkXmIA331LukuRDpKkBH+F0PSRYFR0Yeds21xex+DNk+YMA?=
 =?us-ascii?Q?QeA031al6ywxMlJMYnGST0Stb9frUBV2I5AgFctz2kOvNm42uz04LELRry2N?=
 =?us-ascii?Q?NXjt1xc+3pqKnkn9T2TIIeCi4i6JpUuQ2mfwDG9SVrOuol0wwgBykeLCCbI2?=
 =?us-ascii?Q?PDlaF7+A/ET3uPeQClXw3V13SytxXteuYbqjZWR5sUmwBsf0+JPz9Fxio+eq?=
 =?us-ascii?Q?GH/F8xQQ4i1fVWDpVQskvVVb2bua?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd971cc-f999-456c-7a59-08de8371d2b1
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:42.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Try to autocorrect the mistyped mandatory subcommand before showing an
error and exiting. Subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL
are skipped.

Use standard Damerau-Levenshtein distance (weights 1, 1, 1, 1) to
establish a predictable, mathematically sound baseline.

Scale the allowed edit distance based on input length to prevent
false positives on short commands, following common practice for
fuzziness thresholds (e.g., Elasticsearch's AUTO fuzziness):
  - Length 0-2: 0 edits allowed
  - Length 3-5: 1 edit allowed
  - Length 6+:  2 edits allowed

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 02a4f00919f6..1f1b72762790 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -622,13 +624,77 @@ static int parse_subcommand(const char *arg, const struct option *options)
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
+static int similar_enough(const char *cmd, unsigned int edit)
+{
+	size_t len = strlen(cmd);
+	unsigned int allowed = len < 3 ? 0 : len < 6 ? 1 : 2;
+
+	return edit <= allowed;
+}
+
+static const char *autocorrect_subcommand(const char *cmd,
+					  struct string_list *cmds)
+{
+	struct autocorrect autocorrect = { 0 };
+	unsigned int min = UINT_MAX;
+	unsigned int ties = 0;
+	struct string_list_item *cand;
+	struct string_list_item *best = NULL;
+
+	autocorrect_resolve(&autocorrect);
+
+	/*
+	 * Builtin subcommands are small enough that printing them all via
+	 * usage_with_options() is sufficient. Therefore, AUTOCORRECT_HINT
+	 * acts like AUTOCORRECT_NEVER.
+	 */
+	if (autocorrect.mode == AUTOCORRECT_HINT ||
+	    autocorrect.mode == AUTOCORRECT_NEVER)
+		return NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		unsigned int edit = levenshtein(cmd, cand->string, 1, 1, 1, 1);
+
+		if (edit < min) {
+			min = edit;
+			best = cand;
+			ties = 0;
+		} else if (edit == min) {
+			ties++;
+		}
+	}
+
+	if (!ties && similar_enough(cmd, min)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorrect_confirm(&autocorrect, best->string);
+		return best->string;
+	}
+
+	return NULL;
+}
+
 static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 					       const char *arg,
 					       const struct option *options,
 					       const char * const usagestr[])
 {
-	int err = parse_subcommand(arg, options);
+	int err;
+	const char *assumed;
+	struct string_list cmds = STRING_LIST_INIT_NODUP;
 
+	err = parse_subcommand(arg, options);
 	if (!err)
 		return PARSE_OPT_SUBCOMMAND;
 
@@ -641,8 +707,17 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
 		return PARSE_OPT_DONE;
 
-	error(_("unknown subcommand: `%s'"), arg);
-	usage_with_options(usagestr, options);
+	find_subcommands(&cmds, options);
+	assumed = autocorrect_subcommand(arg, &cmds);
+
+	if (!assumed) {
+		error(_("unknown subcommand: `%s'"), arg);
+		usage_with_options(usagestr, options);
+	}
+
+	string_list_clear(&cmds, 0);
+	parse_subcommand(assumed, options);
+	return PARSE_OPT_SUBCOMMAND;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.53.0

