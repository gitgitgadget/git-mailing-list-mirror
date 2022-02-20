Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C5C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiBTGzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiBTGzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C123E3586F
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so9233365wmb.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lUeMBI0VGqVpVf36mWn+Z0nc/oxflgv+ptH2bmFaszA=;
        b=RRLHYxV2Y0Pl8Oqy/iw+dqffT0fXNuUU44KUnuz+kYc0BBYEhiIo8DTho9SFOhs/Fk
         MbfEO+ar73tfOc+rvrfSc94J2sZCFezPDflgrcPC1pUOduy2MtEQgvZwB3c3jc5yTRdx
         Y8c4dLQ9wHd/1Ge82OZOS+qL80I2nlOIDrqVWDtY1xotZD1X2KaX8bROcMHiwxtmPnMR
         ILn7QcM6RR+Wp8UTwvIk6/TZZvruBekefkqwt9HJemNoiKRKcQKUNu/NJtbnmdlGOwA6
         7pp9DALKj4JrTDtWUL5H+HTo66x4T84Hr6VRAWX4sY4eXagv5ttPjhFfyiUQRUzDrcGr
         abAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lUeMBI0VGqVpVf36mWn+Z0nc/oxflgv+ptH2bmFaszA=;
        b=rX+y54WABmzrokm2nVnbHPT7icysGOy7cNGF9+Ebmg52vsKK81HRMMaTZjL2DXe9i8
         CSSmB0ZUYahjvnKzXuH+qlCdKoegxHBis8KNHiNGG37H6WRKJlB4GWp7I+1MpjFd9MkZ
         w6YfmPL7YrLpjQgRJBLSh+CK7luGkNOOywEKmHC5NxgsoNvFRCzwUD8uj7z+J4cNxWAU
         Sx/gjTZI/QLrvG0MQaw5ZVXzmEIgX2YGN8w+zA0flJoYEY6wmJdObK0Ia1yteyqw5xRL
         VdScWOORoJjBY/QCKzAlJ1RSgjVe5an7eJgcmsDkNFDOlWyszcQaGbeYa6rI/t9bacQk
         NLyw==
X-Gm-Message-State: AOAM533GS6MDGpdnD4r3FnaHKHmvYDIhJJVbFrP4LdLbBJjsRBbGZPYR
        cHzjUXA1O2OyzHPCrcxz0FDPi3m49Ys=
X-Google-Smtp-Source: ABdhPJzZOP7tNxVU5bO/+ukhAm70XVFOWU2tF3KZZrXjHO0nO582QRtlqsLRIrj7qQi34SU4HEk70A==
X-Received: by 2002:a1c:7216:0:b0:37b:f84d:d56e with SMTP id n22-20020a1c7216000000b0037bf84dd56emr16656709wmc.177.1645340085999;
        Sat, 19 Feb 2022 22:54:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm20377996wrz.84.2022.02.19.22.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:45 -0800 (PST)
Message-Id: <60253745f5c59ac4c75d46df1f98ee722523f166.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:33 +0000
Subject: [PATCH v5 03/12] merge-tree: add option parsing and initial shell for
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
index 5ff21be21f3..6090a1289db 100644
--- a/git.c
+++ b/git.c
@@ -558,7 +558,7 @@ static struct cmd_struct commands[] = {
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

