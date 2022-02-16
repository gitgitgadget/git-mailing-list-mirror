Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634AAC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiBPEV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbiBPEVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:21:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EFFE098
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v12so1355452wrv.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JUZpigJx7CL2piKB9j7OB1j0JGFx2ejxjC82vGxYfAY=;
        b=Zzi3GBWFj3h/9OY2jINiH9e0RoHzwzw7wABYxvUU2++xpXoc/v35uPDkPaK7e3SVue
         oVrfnHV+A5jLv6RoN+P/dUb/TE23WbIpUxayPD1v8zVcoLivfdGSuvahNDTbsz29f1Zm
         ID+9vJ+nA6Hi05va4EGk0GlovdZRfGRdF0sFpL9e8AwsoTX/Rj34zpPaKJmWEyL+VR9X
         l+O9VZZQbLoEFMWzE68zmAurYhsBskIPCcGGRc4dB0R9zVKIxc/vf0wMeCOXCHFL+fSh
         /lVnWzcOjCNQen46SFRr3Lskh85ZuaAr30etijTtpMvKP6OeMtGv4o8rvEPBie8me+4z
         8g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JUZpigJx7CL2piKB9j7OB1j0JGFx2ejxjC82vGxYfAY=;
        b=IW8DGD0GhIwq7KgXXweG32tx4nRLM6h+D6b8yEAq4N1bqTQ2SnWTfL9OBO3AyGM3rr
         yzU+hOet6LVE/HbUsKCsYDaufPtblEbNiPSkz/g0//NE9Ca+gTfO/vow2nyRsTSPYQwk
         BHUdVH4vSvMGi7+Dr7A3WqBN2lbJ6cRLtM/YxAnYDCkGEEWG3LtnA2Gd4ejdCx5ihTzn
         pfxn5RR/cOHtrirEB+R2VW/wljFcyRcIugwvJfEIg4TE5yiq0G5WbmSzgGIHmkfhs1MF
         FhO1Us7pOb9Ca8SoFPLbn3H6PXCUCpFyCKbaUCHBgGH5jjGgtG4y5Q/WG8ar2aR1KYk+
         3EnQ==
X-Gm-Message-State: AOAM532zKTOH+tSrNaWC0+4GSAXLgRE98nRjqZugsYHYPXOyo2OqwQyH
        rpgEylysmaEaVJGZrBwilw2pmT2HO4w=
X-Google-Smtp-Source: ABdhPJzib6uW0dM98Ooyj5Q+Wqarw4bSN56O6rOa6A360OIV8jslBkzFTfbnYxhbPjxS4ocgB1rBlw==
X-Received: by 2002:adf:e185:0:b0:1e2:6421:f2d0 with SMTP id az5-20020adfe185000000b001e26421f2d0mr723829wrb.703.1644985287470;
        Tue, 15 Feb 2022 20:21:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p32sm17525463wms.1.2022.02.15.20.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:21:27 -0800 (PST)
Message-Id: <1fdebc1953fcc30a6a08b3efd62dcdb31f7e4704.1644985283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 04:21:22 +0000
Subject: [PATCH v3 4/5] sparse-checkout: error or warn when given individual
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The set and add subcommands accept multiple positional arguments.
The meaning of these arguments differs slightly in the two modes:

Cone mode only accepts directories.  If given a file, it would
previously treat it as a directory, causing not just the file itself to
be included but all sibling files as well -- likely against users'
expectations.  Throw an error if the specified path is a file in the
index.  Provide a --skip-checks argument to allow users to override
(e.g. for the case when the given path IS a directory on another
branch).

Non-cone mode accepts general gitignore patterns.  There are many
reasons to avoid this mode, but one possible reason to use it instead of
cone mode: to be able to select individual files within a directory.
However, if a file is passed to set/add in non-cone mode, you won't be
selecting a single file, you'll be selecting a file with the same name
in any directory.  Thus users will likely want to prefix any paths they
specify with a leading '/' character; warn users if the patterns they
specify exactly name a file because it means they are likely missing
such a missing leading slash.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 43 +++++++++++++++++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 16 ++++++++++-
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a2192a69219..64583fa704f 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "parse-options.h"
@@ -684,8 +685,11 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static void sanitize_paths(int argc, const char **argv, const char *prefix)
+static void sanitize_paths(int argc, const char **argv,
+			   const char *prefix, int skip_checks)
 {
+	int i;
+
 	if (!argc)
 		return;
 
@@ -694,7 +698,6 @@ static void sanitize_paths(int argc, const char **argv, const char *prefix)
 		 * The args are not pathspecs, so unfortunately we
 		 * cannot imitate how cmd_add() uses parse_pathspec().
 		 */
-		int i;
 		int prefix_len = strlen(prefix);
 
 		if (!core_sparse_checkout_cone)
@@ -703,20 +706,44 @@ static void sanitize_paths(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < argc; i++)
 			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
 	}
+
+	if (skip_checks)
+		return;
+
+	for (i = 0; i < argc; i++) {
+		struct cache_entry *ce;
+		struct index_state *index = the_repository->index;
+		int pos = index_name_pos(index, argv[i], strlen(argv[i]));
+
+		if (pos < 0)
+			continue;
+		ce = index->cache[pos];
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+
+		if (core_sparse_checkout_cone)
+			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
+		else
+			warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
+	}
 }
 
 static char const * const builtin_sparse_checkout_add_usage[] = {
-	N_("git sparse-checkout add (--stdin | <patterns>)"),
+	N_("git sparse-checkout add [--skip-checks] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_add_opts {
+	int skip_checks;
 	int use_stdin;
 } add_opts;
 
 static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_add_options[] = {
+		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
+			   N_("skip some sanity checks on the given paths that might give false positives"),
+			   PARSE_OPT_NONEG),
 		OPT_BOOL(0, "stdin", &add_opts.use_stdin,
 			 N_("read patterns from standard in")),
 		OPT_END(),
@@ -732,19 +759,20 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	sanitize_paths(argc, argv, prefix);
+	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
 
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
+	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] [--skip-checks] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_set_opts {
 	int cone_mode;
 	int sparse_index;
+	int skip_checks;
 	int use_stdin;
 } set_opts;
 
@@ -758,6 +786,9 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			 N_("initialize the sparse-checkout in cone mode")),
 		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
 			 N_("toggle the use of a sparse index")),
+		OPT_BOOL_F(0, "skip-checks", &set_opts.skip_checks,
+			   N_("skip some sanity checks on the given paths that might give false positives"),
+			   PARSE_OPT_NONEG),
 		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
 			   N_("read patterns from standard in"),
 			   PARSE_OPT_NONEG),
@@ -786,7 +817,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		argv = default_patterns;
 		argc = default_patterns_nr;
 	} else {
-		sanitize_paths(argc, argv, prefix);
+		sanitize_paths(argc, argv, prefix, set_opts.skip_checks);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c1f86b0e02e..3b39329266b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -562,7 +562,7 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 '
 
 test_expect_success 'set using filename keeps file on-disk' '
-	git -C repo sparse-checkout set a deep &&
+	git -C repo sparse-checkout set --skip-checks a deep &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -839,4 +839,18 @@ test_expect_success 'set from subdir in non-cone mode throws an error' '
 	grep "run from the toplevel directory in non-cone mode" error
 '
 
+test_expect_success 'by default, cone mode will error out when passed files' '
+	git -C repo sparse-checkout reapply --cone &&
+	test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
+
+	grep ".gitignore.*is not a directory" error
+'
+
+test_expect_success 'by default, non-cone mode will warn on individual files' '
+	git -C repo sparse-checkout reapply --no-cone &&
+	git -C repo sparse-checkout add .gitignore 2>warning &&
+
+	grep "pass a leading slash before paths.*if you want a single file" warning
+'
+
 test_done
-- 
gitgitgadget

