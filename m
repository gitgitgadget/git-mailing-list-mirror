Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA4C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383679AbiFRAVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383234AbiFRAVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C059308
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e25so3651103wrc.13
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vEAtzJqQU86WTzAVqYZ5zRmNunliq8JAKiwDpJdSlvI=;
        b=pmCAuZ/+AqgBhGHFAyCW5q+8q1hFPiiPhSddrVztESPSSUzeOL1t61GmEn+Jy/Ecri
         gwa7LQvizTZ/FgUn5a5DJbdR7p7Wz30sKMMZ5KGncbU3Aty0qTRtQlliKA31hfqR9pmw
         rgzmWLadyJlfLB1VN//472BuF1OyHNZq8XZUVBSWtEVWrQPSZ7KbtZkOezTESX9xXLcx
         MfthMZiy5OLWEHdXaPubz5X0Hin1fngS9J3wU8uDmHvPmhhdEf84K1RvVpNrObBlIAwi
         lqItwLDsBNpowxkQEsXODqIusuzYOUuUBdNrKNwgMueM/LfFyGfRPiW2QM8tW9SLMdTB
         3yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vEAtzJqQU86WTzAVqYZ5zRmNunliq8JAKiwDpJdSlvI=;
        b=7JL0QsS9bKQe94l6J/C+JxpUTnUntE3B1ZiFQ0LuWZgqT62rnIeg+CVdS/yehWeDsF
         mbezW2vtLDfa/9UZLFWGKgh2PCyOUPlkKRh73uIPcRj5t4CJWo74OTLRxmvJVJTN5/o3
         tMZudKdQbRLS7Gl3RNqyj5M7BfznQaEU6Gvf0qjtfi/Fm1Y6AuLTZYwvzxVR4F6NpBZN
         qe+7ORND6ihV9XG9zUzXivm7MQY7HB68bc4/3XUXYXezBCUq6YbuC2jyFo3VA6193nlA
         fqy5qMVMzUyz6GqIODjqEqwIadyevzDamev4yfRXRMeBlO20K4twKpPeWzWKwX9A4qzC
         0O1g==
X-Gm-Message-State: AJIora8zCFiSV3O7yktUBPisfLUYB7Ca8fWwY3xFI4oaG8vw5QsSSOws
        ZyS4hrmS/OYgEmvz/nyMNZl6ngrHcr3Msw==
X-Google-Smtp-Source: AGRyM1tQVuCnM+pKJ3MPQSOTr9LCi5G4ocnsfYHFRFeaOUR8CbDnDHbLrYc+oQdTww0KvX3Woz3MoA==
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id g7-20020a5d64e7000000b0021856267e7fmr11379093wri.245.1655511665710;
        Fri, 17 Jun 2022 17:21:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm17047119wms.3.2022.06.17.17.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:05 -0700 (PDT)
Message-Id: <baf0950bcb61d22491fa015f5270eb49bf6d66a7.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:46 +0000
Subject: [PATCH v7 03/17] merge-tree: add option parsing and initial shell for
 real merge function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let merge-tree accept a `--write-tree` parameter for choosing real
merges instead of trivial merges, and accept an optional
`--trivial-merge` option to get the traditional behavior.  Note that
these accept different numbers of arguments, though, so these names
need not actually be used.

Note that real merges differ from trivial merges in that they handle:
  - three way content merges
  - recursive ancestor consolidation
  - renames
  - proper directory/file conflict handling
  - etc.
Basically all the stuff you'd expect from `git merge`, just without
updating the index and working tree.  The initial shell added here does
nothing more than die with "real merges are not yet implemented", but
that will be fixed in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 84 +++++++++++++++++++++++++++++++++++++++-----
 git.c                |  2 +-
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 914ec960b7e..0f9d928e862 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,13 +3,12 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "object-store.h"
+#include "parse-options.h"
 #include "repository.h"
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
 
-static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
-
 struct merge_list {
 	struct merge_list *next;
 	struct merge_list *link;	/* other stages for this object */
@@ -366,15 +365,17 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-static int trivial_merge(int argc, const char **argv)
+static int trivial_merge(const char *base,
+			 const char *branch1,
+			 const char *branch2)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	buf1 = get_tree_descriptor(r, t+0, argv[1]);
-	buf2 = get_tree_descriptor(r, t+1, argv[2]);
-	buf3 = get_tree_descriptor(r, t+2, argv[3]);
+	buf1 = get_tree_descriptor(r, t+0, base);
+	buf2 = get_tree_descriptor(r, t+1, branch1);
+	buf3 = get_tree_descriptor(r, t+2, branch2);
 	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
@@ -384,9 +385,74 @@ static int trivial_merge(int argc, const char **argv)
 	return 0;
 }
 
+enum mode {
+	MODE_UNKNOWN,
+	MODE_TRIVIAL,
+	MODE_REAL,
+};
+
+struct merge_tree_options {
+	int mode;
+};
+
+static int real_merge(struct merge_tree_options *o,
+		      const char *branch1, const char *branch2)
+{
+	die(_("real merges are not yet implemented"));
+}
+
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	if (argc != 4)
-		usage(merge_tree_usage);
-	return trivial_merge(argc, argv);
+	struct merge_tree_options o = { 0 };
+	int expected_remaining_argc;
+
+	const char * const merge_tree_usage[] = {
+		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
+		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
+		NULL
+	};
+	struct option mt_options[] = {
+		OPT_CMDMODE(0, "write-tree", &o.mode,
+			    N_("do a real merge instead of a trivial merge"),
+			    MODE_REAL),
+		OPT_CMDMODE(0, "trivial-merge", &o.mode,
+			    N_("do a trivial merge only"), MODE_TRIVIAL),
+		OPT_END()
+	};
+
+	/* Parse arguments */
+	argc = parse_options(argc, argv, prefix, mt_options,
+			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	switch (o.mode) {
+	default:
+		BUG("unexpected command mode %d", o.mode);
+	case MODE_UNKNOWN:
+		switch (argc) {
+		default:
+			usage_with_options(merge_tree_usage, mt_options);
+		case 2:
+			o.mode = MODE_REAL;
+			break;
+		case 3:
+			o.mode = MODE_TRIVIAL;
+			break;
+		}
+		expected_remaining_argc = argc;
+		break;
+	case MODE_REAL:
+		expected_remaining_argc = 2;
+		break;
+	case MODE_TRIVIAL:
+		expected_remaining_argc = 3;
+		break;
+	}
+
+	if (argc != expected_remaining_argc)
+		usage_with_options(merge_tree_usage, mt_options);
+
+	/* Do the relevant type of merge */
+	if (o.mode == MODE_REAL)
+		return real_merge(&o, argv[0], argv[1]);
+	else
+		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/git.c b/git.c
index 5ff4f3e25b7..861d966c374 100644
--- a/git.c
+++ b/git.c
@@ -565,7 +565,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
-- 
gitgitgadget

