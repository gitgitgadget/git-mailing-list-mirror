Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAC4200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEDPev (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:36851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeEDPet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:49 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LyzW8-1eJRbv0aI4-014CY6; Fri, 04 May 2018 17:34:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/18] branch-diff: also show the diff between patches
Date:   Fri,  4 May 2018 17:34:42 +0200
Message-Id: <12d9c7977fdf9cc73c810d2ca31d86a4971cf7f4.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tf+PdQnz40rPziTauvLmwnNU16EnZhPpeW+IE6l5jyTYLAmAoOI
 N5z4NObRf12AmfhqT7BLJey2/QE2D/tLlYzgt7dktBj9n5xIat8YyrYgGO1k2pWdA03Xkn/
 Uol0w+50ugmJNJFWp/4phYkNd9CiSy16G63u9ajiURnfmQdj1SVp+CxZ4zTi0DiYhtjaE15
 ZQS6PO7fZI3ETKBbUHTFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qXyq/H2RPGg=:LSKCCm5giV4y6OxsTG/+Vf
 KFvKYfLHSllfhCpgaVAy1V98vG2ZFPcblfJH0gDgoAB6WfqI7euMJTPbg5g86eRcqwKlOj2/9
 dTmCm6gAbotEJtutsWjt0o0N8Wh+YFfeNGn1WsykDff42nH7ezB8q09kyhYb61U9LolIlHbLL
 dDDh2fgG6z/7hZGJcxIeD5WdhV04FjXnrp/7Vhzs0meMHsTFEeuXGuHuIjPZMs0V1yJt67lpN
 4iYfCevB3z5aSMMrMi+Z7kTtbK/jHHA6lSkWXNn4whZ6EGaSQb+P/fNSG+VP/qAgwWZQ4CfiS
 1RUYxgVqNlqE+F03ouX6Q1oYcG9zo3Vc8qhQZHpeo3BPRXYSXFgGGm5to3nkSGrU5yLWRh98R
 tRR1CGAgCQ9+bO0r375c7Tjveksk+644G/zCWOdkpcghzBOHj4ujgy34i1c+M2L9ZchJfuW2U
 AYjaZzwNnRPNgpnEq1PMXNH0Ltwqh9bX2ZWWuZfpQZmhnTj/rXPS+aUmFgF6Lb7szUoztRSxZ
 wEO6MgYmf1J3cP57dQJPQbitxQdRFKj3v+lo8rVA5e0qNH9mNbVGc0Wha6Raa4gCphUkurr2l
 SH/umIyDBmiL1gGt6ClMaHvu+zQmkyWoQZa1nkn7Msg1nPB4tk0A5fzJAVv2K/Y3vKw82vGIp
 ECQu2HlOMx+qr4n1VcyvVTzY8OYCXtV7Qo8KvWysE0d2AjBnGsN5ceulLDM4jofSWGi7Ow5Ub
 rBsek0aKR4XJZpfuTfi8WETJX6MPiORqCkAiGV4cvdMW1mXEyH8rlV+Zgzddk6FyW7+jtx/b9
 1maiX4D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like tbdiff, we now show the diff between matching patches. This is
a "diff of two diffs", so it can be a bit daunting to read for the
beginner.

And just like tbdiff, we now also accept the `--no-patches` option
(which is actually equivalent to the diff option `-s`).

This brings branch-diff closer to feature parity with regard to tbdiff.

An alternative would be to display an interdiff, i.e. the hypothetical
diff which is the result of first reverting the old diff and then
applying the new diff.

Especially when rebasing often, an interdiff is often not feasible,
though: if the old diff cannot be applied in reverse (due to a moving
upstream), an interdiff can simply not be inferred.

Note: while we now parse diff options such as --color, the effect is not
yet the same as in tbdiff, where also the commit pairs would be colored.
This is left for a later commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 53 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 92302b1c339..b23d66a3b1c 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -7,6 +7,8 @@
 #include "hashmap.h"
 #include "xdiff-interface.h"
 #include "hungarian.h"
+#include "diff.h"
+#include "diffcore.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -272,7 +274,31 @@ static const char *short_oid(struct patch_util *util)
 	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
 }
 
-static void output(struct string_list *a, struct string_list *b)
+static struct diff_filespec *get_filespec(const char *name, const char *p)
+{
+	struct diff_filespec *spec = alloc_filespec(name);
+
+	fill_filespec(spec, &null_oid, 0, 0644);
+	spec->data = (char *)p;
+	spec->size = strlen(p);
+	spec->should_munmap = 0;
+	spec->is_stdin = 1;
+
+	return spec;
+}
+
+static void patch_diff(const char *a, const char *b,
+			      struct diff_options *diffopt)
+{
+	diff_queue(&diff_queued_diff,
+		   get_filespec("a", a), get_filespec("b", b));
+
+	diffcore_std(diffopt);
+	diff_flush(diffopt);
+}
+
+static void output(struct string_list *a, struct string_list *b,
+		   struct diff_options *diffopt)
 {
 	int i = 0, j = 0;
 
@@ -314,6 +340,9 @@ static void output(struct string_list *a, struct string_list *b)
 			printf("%d: %s ! %d: %s\n",
 			       b_util->matching + 1, short_oid(a_util),
 			       j + 1, short_oid(b_util));
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
+				patch_diff(a->items[b_util->matching].string,
+					   b->items[j].string, diffopt);
 			a_util->shown = 1;
 			j++;
 		}
@@ -322,21 +351,37 @@ static void output(struct string_list *a, struct string_list *b)
 
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
+	struct diff_options diffopt = { NULL };
 	double creation_weight = 0.6;
 	struct option options[] = {
+		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
+			    N_("short format (no diffs)"),
+			    DIFF_FORMAT_NO_OUTPUT),
 		{ OPTION_CALLBACK,
 			0, "creation-weight", &creation_weight, N_("factor"),
 			N_("Fudge factor by which creation is weighted [0.6]"),
 			0, parse_creation_weight },
 		OPT_END()
 	};
-	int res = 0;
+	int i, j, res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
+	diff_setup(&diffopt);
+	diffopt.output_format = DIFF_FORMAT_PATCH;
+
 	argc = parse_options(argc, argv, NULL, options,
-			builtin_branch_diff_usage, 0);
+			builtin_branch_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	for (i = j = 0; i < argc; i++) {
+		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+
+		if (!c)
+			argv[j++] = argv[i];
+	}
+	argc = j;
+	diff_setup_done(&diffopt);
 
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
@@ -380,7 +425,7 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 		find_exact_matches(&branch1, &branch2);
 		res = get_correspondences(&branch1, &branch2, creation_weight);
 		if (!res)
-			output(&branch1, &branch2);
+			output(&branch1, &branch2, &diffopt);
 	}
 
 	strbuf_release(&range1);
-- 
2.17.0.409.g71698f11835


