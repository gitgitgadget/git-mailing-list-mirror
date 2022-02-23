Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbiBWHrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbiBWHr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A835848
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so9595702wrb.6
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lUeMBI0VGqVpVf36mWn+Z0nc/oxflgv+ptH2bmFaszA=;
        b=bmnClPBCIZxTAddL+o6Nsrox85++kGr+0P+kB3NDR1lIKj2nRWJreoBmw/UNOZQYfD
         NRF8NljKzlr0/DgErOiZ1+PKEDz1CQla9uaS8aWBCCCJnJZMx9mCI1LziGDjWSNOxYtF
         hXyYmjQGaRFDbvy4c0PIvLaO8diS892wNbMykXxw2Yuqe52aEOjRO3utYWUod3hBpOQu
         tfGDIzggIuvXSa/6OZOchFcoojSQgInKvUps0jlvSXpL+4oPD19HpE+rw6RNV51v0b4x
         PtNC+e1nzpv9FQTGxcW79Lc0nt7SQ+bleYZWdtX7V0XWCz/jusHyEHoY2c8gKXrYbW+g
         KGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lUeMBI0VGqVpVf36mWn+Z0nc/oxflgv+ptH2bmFaszA=;
        b=aU8EQ1XH6QvzgF5UzW0HKSZB5lYmThjQVBZRCkyd9sdPYkW7JS7Mw7xlVsBt2vr1ja
         /jdEsXRtF7p57VjbL5/X7pYq7oBnw1FNYl1ubZvBD5QxgH7JNAHQl51Arf1BBCE+kk/l
         Ks+adffK1qNeLNeDXszW0uwglkw6NnT6T8aG3xe6d4QCTQs4XlE8nPC1vwHL1FCJFxgs
         e730vlaMiZPK3XS5ioHQA1oKpiz3vQwe3kiwp/qP/x42gsfKwDUEhGCxnG+lqqD8PLR1
         GcV7DEYWVsJcX+ACNFAfRWKkRKhl9pRUg3g/jyfNB4b8GR/1a7VjS1pd99rWFycTAPhq
         cDbA==
X-Gm-Message-State: AOAM5325QUGL3UzO1UxEqA0JuuGJuJiC0ha8ifRKrzUN2ZDkOv7u3Ykj
        a8Ynnhv93G9Wu7TQyAHgXWG6qS7P7YY=
X-Google-Smtp-Source: ABdhPJwqsub8qjTmr87L1RMBeP6r4V+pG8ht81yGrxOR9BTWKduQza0huTScHpaLwBLdPIz5upNslA==
X-Received: by 2002:a5d:630c:0:b0:1e3:3e4c:c5cc with SMTP id i12-20020a5d630c000000b001e33e4cc5ccmr21735310wru.612.1645602417664;
        Tue, 22 Feb 2022 23:46:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm67886591wrs.18.2022.02.22.23.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:46:57 -0800 (PST)
Message-Id: <60253745f5c59ac4c75d46df1f98ee722523f166.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:44 +0000
Subject: [PATCH v6 03/12] merge-tree: add option parsing and initial shell for
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

