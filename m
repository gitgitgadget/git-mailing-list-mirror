Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B804D2023F
	for <e@80x24.org>; Thu,  3 May 2018 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeECPav (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:33901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeECPas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:48 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LjLwB-1edGgN2pBf-00dX1f; Thu, 03 May 2018 17:30:44 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/18] branch-diff: also show the diff between patches
Date:   Thu,  3 May 2018 17:30:43 +0200
Message-Id: <141e5b63e4511c13380216fad9b8601d2bc6051e.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0roZLWMZnVKwEUdgFxlmTHtxg3ZY+0Iotj0olh3pyWukkZPMJVN
 nhYO9YifufZXSWeIzWGg/5S+Bn4/IxksU+Z2yJVIURO8/gqRrgoa/4SEdsxvRcDzmETxtUm
 DqL8dwOM/dj0ZapAoMJNjZdvGNcXZTGwC92D0YdZMKLnmXI5kiYhOzC51iKUrBNLFo8oLdU
 HlBZlZd/kMCkhloQmabBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wt0/8XecBB0=:IJqmKmSgEWyJ/YZeQf0dYi
 FiF86QNj6dEY8dsWl1hZsjD69u33sJ36mEWXG1KePybRSUMIyfxvmORUJ83trTV7wMdRx2npi
 1fTBJCzFpcJsjWePoVDS8K9CbJ0C+rvnyyfE5g8UjOUcF11PXXuE9v5OHZQ1ufEuJlfSNQYnL
 M9AntJ/38Fe7LL+VJQjX0U1Lz7l2iJ7VgRzOd/UYZ+Q8kpZmdklMC7zHGrxCp8XGL490kf9ZZ
 NXlX1LQNLtsiVn6EXQF+J2RX8hwoKACNQa0XeuSJLzbe81hx+8+JucfOwa/vAtLPNJmkYsLTg
 SMZMwgsZwSNgSQxEFsoCxOmvt5tCvXZeOB6ALFQQubiQucTeNqB5W0LlqCNUNu6vwGnuTmBFB
 yKUgRVsH+pWwTAjY3nrQBM4I9NQ+etLV+Wi8fMUBaHiPS/thp+k6P1Pevaimcg9jdBVS4ZK7a
 b/oLGWx2P1FlD8KwcAJjiMMqnuIpqIsye0heihxr6fWn4bvXItv1M21UU6H5hsFGO3lL/kDrH
 ARSg7Ai10QvnKXu10Z87ZLd5U0TCVg5SkXnsRiHjZHVTZoKm1eY07pobt0suuy++DvBFQPWtG
 hY2MJq8aIyaysPRO6f39w0OBd4g5bsH1ImJq3OuONhYlTc2Qi6sNIA4GeJ0lzzz5Ijc2F6+e8
 /Fmoie2uLirVGbvjCCXzCx3eRIjXPe0h5KvOceFx7/au6LtcKsT1SxVl0S5xueQYPFuZUQdMN
 Pvk3G2ruLmZIqtcu83KvKsoOW1Kysi4ecy4O0UchRJAPjDakNeit8g5OIe6CrDQwEk2S+6miq
 GLC0la+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like tbdiff, we now show the diff between matching patches. This is
a "diff of two diffs", so it can be a bit daunting to read for the
beginnger.

This brings branch-diff closer to be feature-complete with regard to
tbdiff.

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
 builtin/branch-diff.c | 56 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 59423498194..3b565a37492 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -6,6 +6,8 @@
 #include "hashmap.h"
 #include "xdiff-interface.h"
 #include "hungarian.h"
+#include "diff.h"
+#include "diffcore.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
@@ -269,7 +271,31 @@ static const char *short_oid(struct patch_util *util)
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
 
@@ -311,6 +337,9 @@ static void output(struct string_list *a, struct string_list *b)
 			printf("%d: %s ! %d: %s\n",
 			       b_util->matching + 1, short_oid(a_util),
 			       j + 1, short_oid(b_util));
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
+				patch_diff(a->items[b_util->matching].string,
+					   b->items[j].string, diffopt);
 			a_util->shown = 1;
 			j++;
 		}
@@ -319,24 +348,37 @@ static void output(struct string_list *a, struct string_list *b)
 
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
-	int no_patches = 0;
+	struct diff_options diffopt = { 0 };
 	double creation_weight = 0.6;
 	struct option options[] = {
-		OPT_BOOL(0, "no-patches", &no_patches,
-			 N_("short format (no diffs)")),
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
@@ -380,7 +422,7 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 		find_exact_matches(&branch1, &branch2);
 		res = get_correspondences(&branch1, &branch2, creation_weight);
 		if (!res)
-			output(&branch1, &branch2);
+			output(&branch1, &branch2, &diffopt);
 	}
 
 	strbuf_release(&range1);
-- 
2.17.0.395.g6a618d6010f.dirty


