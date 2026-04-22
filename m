Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119A3CF663
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860402; cv=fail; b=FZ3eY77Ci2OhDP8G8csDDFqjag1AXIUu9qc59LNgOZsY0L1kXRQhKdmnmIiME3TVaP5flZMl7gUhGsVPFa/5nV6UQjAgAg0Cs19yeX7+/09UqwkyYEMuabwzUPeln5aP9KjY2LQyJwfDGq0o+zSAZ+fvFjnI6yaqxX2aJF0UKdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860402; c=relaxed/simple;
	bh=ooNaqs/PGgKqVNFJF0CF4AUcm5FWxbIvxWlWMcts9qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9R1qfaVjciQ+nYoYX3qJI358TbVi26qEYdHsuJx1DtW9+ixRMW003wXjeUGem3qGDHO2fbBqniRoxpNdrbp4mRGEA9McVUKJfMdgZuVUuZM88S57SuZpvASZ30yoEAnIW5rYYiU9hi9Zv5n84ueiYGzTS96aMpkBi7bRvU7LYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WxnVJidT; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WxnVJidT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUC0ElDO4hKLGtGEEh6zy14x5oaI3U+6tDCVs1wBviL0247OHAz7OSywP6xW5X2cZ6RhZUsNsOsejPN6t8s9l1+RjM2waIhCTovgkkLONze6KmWNJUhOBX2tWTpUEXFn7V6YncyXnhlGzhA3JTjDnUCwLKGoUjTn2edHg/PAk4PWrSzmkxDcFzG+uOuNZ2Imgd5p1xW32l1emmyfO2V0NQ7f126UwnpG376DLl8FH28LG3HKClRcYNPJ9swNeaiKVHlSn4h3/3HWp8vAQoMX85sYy8A2XJO07ovpUtLAIy/HSxFUUvEtnXA3Z7HWLxUIclfk0+de5/HsrOLBln3Pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2DPK9N8VMtf1TjiB50KiZxnQaeDK/Gy/dy54YKGKPM=;
 b=eYk+HVR3V8aFzYq3dujy7KcqFtOA4vLbPByM/VHh0pBYraUv8EiJfQ6TGsRs/Yz0qc0aJXDi47Nrr4DkSIQIpPh6rgPMLZ/GYPJVK3iT00bpmEgY0gW4xGie5kvdT1yv/xzVK3NGtiFfhzrHqEIKOuJtzl763z001sNvfqsOZoMSOz/e0TIguJWRXyLDpYdvBnD0Dgqi/DCCqzMV4mSNQL5BM+P9mtGHmg1E1ZJdNzHVQ6KJKqjOOZ9SPlHSyb6YexbBy7RIr9jrw7p+Dvr3CQIbaD7Dx832a/vg+/NDLO5bmIKViImoFuBVL3SsvZHEi6O+UvjyewsMKIGtApk25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2DPK9N8VMtf1TjiB50KiZxnQaeDK/Gy/dy54YKGKPM=;
 b=WxnVJidTKMIz1DI/00S/iRgl8VQ0e5rZfdZpA642+Ied20dbcpVosgJ9dVjj6TbVnXqtt6i7FXl2OGF+5aU+Hd7meoDztNRbUtrx1QpsINft83HMQEpUE9cQnCTXtf/q5+/2yHvolGcrRxVsz925RTdM9j9HGsjWJoJABnV3k+DsivHUw6s927GgjzIZQKD+7/NmAJUuFihA6H4df/egzvCPTUhLIvUqsRdTWysAUo5Qu7spRZQabNezHlQ6IHMDq5ebdUpMZoY8CP7SOuMYTf46piPQJP0mwGP2t4vvk0Qige+xuvTxTFGVZgY70shETyeg3hnEn+Nt2CdP4v9f1w==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:56 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:56 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 07/10] parseopt: autocorrect mistyped subcommands
Date: Wed, 22 Apr 2026 21:18:07 +0900
Message-ID:
 <SY0P300MB080136CB238AAA21CB36153DCE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-8-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 52b28605-6229-4815-b68f-08dea069767c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|12121999013|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPsZuvlqVl+McjAe8x4sbo05VT8zOE0t7+Ie3zX8o3/uwHpDohmuxU9AaUjf?=
 =?us-ascii?Q?/1HdDXjAzWg6OJzQIc1bd3MCiRo7b5Ag+hulMUwV9tU7HrDmVBqIIDDNOClf?=
 =?us-ascii?Q?HayKTqNBJX1NXb8W7xOJOHMKjrKTsOsTr21gCF4fe9b7i4b3+qTZzPGO5ki3?=
 =?us-ascii?Q?CMbkxlNhy24PzeKG7xb1wRByOAuGXwpaBRy7YWm7Npbx8XG5wlAUPGX8RQIc?=
 =?us-ascii?Q?FDOErfToaJRVOpXcygapVSEOA9zcBnCoWAcRMWgajtlZyPIZTOKUuhRusX1r?=
 =?us-ascii?Q?67JcceZ0TWhTJtZX5dwV/W66gtNFNKG1/DqiWjavQBtL2CA5Sm/36RVvIlc8?=
 =?us-ascii?Q?R7xU/6+kyxxVte6r4GjfQy3x5OCTfQ7bDRGawamTlW3mSBJYgnHViOysoTBd?=
 =?us-ascii?Q?hW9WszQiFzo93su1SDe+KtqBe0CXgwAl/MjUXDk+pY7FKAFdpcTS4DHyUgaH?=
 =?us-ascii?Q?/ZJAboaWkw9fnfb9ZUbZz5IYAhQ/HKM9LY4MH/2r+fwXxblOx077QUDDlbWz?=
 =?us-ascii?Q?EotE5Ya9DghSDi0G1/WkIQvSDcEfw5ZiPPsRh1Kaz3naU/t8nBoZsfzgG0LH?=
 =?us-ascii?Q?dNYUsdyN/i7eUSztbwGer60ix/mD2sL7BTPU3LasLBgzuXKV3l2EC46FAdFS?=
 =?us-ascii?Q?t/BbTXqXCUdryirkW+gPyPGxZtpzWS33s8eh1TwiAB+MmPoHFj1dlA4/kP9y?=
 =?us-ascii?Q?XUmtop9bih/z5DMCJ7WFn4UFO6tEFx20BRlyxzrWGbqSa4ZYvW30kGGyWrOf?=
 =?us-ascii?Q?OcyrnrDCLGB10dVTF7kqqIersA4lvnLNsAFL9Z7/R0aaoD2PohCfkfTbei6s?=
 =?us-ascii?Q?rZiGh7Yh8zVdsXUuk8b1bnwtTUUwrt2fuV97fZOJcgmFG7LuhM7QGs3t6jse?=
 =?us-ascii?Q?HEzsQuTxBDyBR4moQ35cmcrtWw4Itr0/s8hu58ycyo7TYN8Zmf6Os7K9tXGq?=
 =?us-ascii?Q?YkolLf+5QkuKQIrC0Biwr6aufEaROK4jHSHK7j9djX6eJ139eVUooKfT3rAf?=
 =?us-ascii?Q?X3PlOyeN/+3EKexJTcqFDMQAlfSim/Ie7kyoK9JhArBfRvLJ+Xj4ZK19AgrT?=
 =?us-ascii?Q?OLNlPz4E?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGKgAg34gsN7HjtGrzFNgJ3pXOHWd60u5Z408jclpbTzf11uhlYAh+24dwxK?=
 =?us-ascii?Q?od1h0mnU06cNQjixhxWE4IDo672aDfxucyhTnTFZ+yKhhlMe4ycnEL48B9aQ?=
 =?us-ascii?Q?qJRLL9haoa1FBLXZL+DWgBfBMYT8A9WzLQEi6oAuqUbUtWIDksfaRM2cZP9y?=
 =?us-ascii?Q?WlH/kAP5k8SHpvToG26a5u5pbG43Dg7jUmLwZwKSKrFA/6NKd3a39GporOFT?=
 =?us-ascii?Q?MziCR/Z2/fh7Z0Jbhgm+qzsgjs5VkNTA1Ho5yc9OE5jVhESixrF3anCrp7iK?=
 =?us-ascii?Q?6FdygDDmwrsXZSQ+3c8DIeeitWUhXyRyLbFWRIVskoVZouMw7zjQf3YdkKWS?=
 =?us-ascii?Q?FgSKzqhS3sVBx1aCEJMzInEkDboHw/5vwXkpNe6q4yuYaQaQuUp3DORkftFi?=
 =?us-ascii?Q?hWXNF2X9aDHbP/3IQ7myH8trRY2lftBPIH/3uQhgm+lnoXvAPmHPXLUq7CHu?=
 =?us-ascii?Q?EA6E/GfiEpkOZB4kl7LiShno6ItNbG/KExXZ0HkTbwpLVDgwEpgTxtsshbI0?=
 =?us-ascii?Q?nd96mORy8gjOPZo6hTgzhS4SpRDzYxf1B5Q3K5l9QE9XTY0gFn9C2sgZQMmP?=
 =?us-ascii?Q?mZ3A/fjoZL5vCcCyzcLkGbMKi8QatHMUIK8V6/8Y96s61uqk17o9g6PA/hIP?=
 =?us-ascii?Q?fDRGD572JTPV5VW3CVPTKs+Xo7qkfFQyTEeduNBY0LMYyNT6LlEH3syGQO8w?=
 =?us-ascii?Q?GWq2K7Dg29AhlDD2k92uG2oE8LWWpx9vwgjy2vhjVZURWPpXkQuzF14lMBX3?=
 =?us-ascii?Q?+a3KiS2Yfl1u6TjJoa+ggh/cYZULMpfij/cCEaibj13uudlwBszqGY6zNY6t?=
 =?us-ascii?Q?8rgjkbsqgf/oNw7KSSCC6JqvqpaivnzKtqbWahBhAkpjI0n02Vz0gpxsBeRH?=
 =?us-ascii?Q?7h3mgju233shH6lOtqtttuz8ZkRq5iD+9IklR4UnS+JWBaKZOswYPZYZTpup?=
 =?us-ascii?Q?CAFUPD8ayCWuumAjic5p8LXWNtucVwNDq0MnnfEMmqr+/LinXjqfiD8pXNU9?=
 =?us-ascii?Q?hb1ligfS7g7UaLcun3ocD0FKk7CVm48NDgg2FMr8Gp36nzPto0OwwG6EL/q3?=
 =?us-ascii?Q?rRUsFZecr0KHwOSFNBwqsmvs+iHnC2tzF79trpdOoiizOT1gJO8EdFSZAw8f?=
 =?us-ascii?Q?tIGZRD6Pa7WZFCpMO8Gz7ZnyHfkZoIoeuodLLky2HI4EhAqX5AB4rJYbIQ8S?=
 =?us-ascii?Q?iLHRIk875e+SE6Z0+rmOaZWbllTz6OtGksXRN9RD9+l95i680ctfSgJhBmbl?=
 =?us-ascii?Q?YMmpub/c9ljw3NYk/j/uBo1HvqkpWhEQJSp5Uarob6cN6WrpzPoWRRk0swNL?=
 =?us-ascii?Q?ncGyeezdkxmoLAxzxHFrV9LRNgCQfFVIAuqTDCyAN3YQTYgZRf6Kvrc1ybBV?=
 =?us-ascii?Q?WrEtVZ6Wcu5R5HkUIV02rp66cLUV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b28605-6229-4815-b68f-08dea069767c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:55.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

Try to autocorrect the mistyped mandatory subcommand before showing an
error and exiting. Subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL
are skipped.

The subcommand autocorrection behaves the same as the command
autocorrection.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.h   |   4 ++
 help.c          |  13 ++----
 parse-options.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/autocorrect.h b/autocorrect.h
index 0d3e819262ed..14ee7c4548d3 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,6 +1,10 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
+/* An empirically derived magic number */
+#define AUTOCORRECT_SIMILARITY_FLOOR 7
+#define AUTOCORRECT_SIMILAR_ENOUGH(x) ((x) < AUTOCORRECT_SIMILARITY_FLOOR)
+
 enum autocorrect_mode {
 	AUTOCORRECT_HINT,
 	AUTOCORRECT_NEVER,
diff --git a/help.c b/help.c
index 0fff43545cc1..ecc5673b7243 100644
--- a/help.c
+++ b/help.c
@@ -580,10 +580,6 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->cnt = 0;
 }
 
-/* An empirically derived magic number */
-#define SIMILARITY_FLOOR 7
-#define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
-
 static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
@@ -659,7 +655,7 @@ char *help_unknown_cmd(const char *cmd)
 
 	if (main_cmds.cnt <= n) {
 		/* prefix matches with everything? that is too ambiguous */
-		best_similarity = SIMILARITY_FLOOR + 1;
+		best_similarity = AUTOCORRECT_SIMILARITY_FLOOR + 1;
 	} else {
 		/* count all the most similar ones */
 		for (best_similarity = main_cmds.names[n++]->len;
@@ -670,7 +666,7 @@ char *help_unknown_cmd(const char *cmd)
 	}
 
 	if (autocorrect.mode != AUTOCORRECT_HINT && n == 1 &&
-	    SIMILAR_ENOUGH(best_similarity)) {
+	    AUTOCORRECT_SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
@@ -687,11 +683,10 @@ char *help_unknown_cmd(const char *cmd)
 
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
-	if (SIMILAR_ENOUGH(best_similarity)) {
+	if (AUTOCORRECT_SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
 			   Q_("\nThe most similar command is",
-			      "\nThe most similar commands are",
-			   n));
+			      "\nThe most similar commands are", n));
 
 		for (i = 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
diff --git a/parse-options.c b/parse-options.c
index 803ce2ba4443..a488f9a41df8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -7,6 +7,8 @@
 #include "string-list.h"
 #include "strmap.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -623,13 +625,98 @@ static int parse_subcommand(const char *arg, const struct option *options)
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
+static int levenshtein_compare(const void *p1, const void *p2)
+{
+	const struct string_list_item *i1 = p1, *i2 = p2;
+	const char *s1 = i1->string, *s2 = i2->string;
+	int l1 = (intptr_t)i1->util;
+	int l2 = (intptr_t)i2->util;
+
+	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+}
+
+static const char *autocorrect_subcommand(const char *cmd,
+					  struct string_list *cmds)
+{
+	struct autocorrect autocorrect = { 0 };
+	unsigned int n = 0, best = 0;
+	struct string_list_item *cand;
+
+	autocorrect_resolve(&autocorrect);
+
+	if (autocorrect.mode == AUTOCORRECT_NEVER)
+		return NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		if (starts_with(cand->string, cmd)) {
+			cand->util = 0;
+		} else {
+			int edit = levenshtein(cmd, cand->string,
+					       0, 2, 1, 3) + 1;
+
+			cand->util = (void *)(intptr_t)edit;
+		}
+	}
+
+	QSORT(cmds->items, cmds->nr, levenshtein_compare);
+
+	/* Match help.c:help_unknown_cmd */
+	for (; n < cmds->nr && !cmds->items[n].util; n++);
+
+	if (n == cmds->nr)
+		/* prefix matches with every subcommands */
+		best = AUTOCORRECT_SIMILARITY_FLOOR + 1;
+	else
+		for (best = (intptr_t)cmds->items[n++].util;
+		     (n < cmds->nr && best == (intptr_t)cmds->items[n].util);
+		     n++);
+
+	if (autocorrect.mode != AUTOCORRECT_HINT &&  n == 1 &&
+	    AUTOCORRECT_SIMILAR_ENOUGH(best)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorrect_confirm(&autocorrect, cmds->items[0].string);
+		return cmds->items[0].string;
+	}
+
+	if (AUTOCORRECT_SIMILAR_ENOUGH(best)) {
+		error(_("'%s' is not a subcommand."), cmd);
+
+		fprintf_ln(stderr,
+			   Q_("\nThe most similar subcommand is",
+			      "\nThe most similar subcommands are",
+			   n));
+
+		for (unsigned int i = 0; i < n; i++)
+			fprintf(stderr, "\t%s\n", cmds->items[i].string);
+
+		exit(1);
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
 
@@ -642,8 +729,17 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
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

