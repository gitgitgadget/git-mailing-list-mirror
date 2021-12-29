Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D637C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhL2Sz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhL2SzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D6C061756
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so46139815wrw.10
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eIdxjx1Ob3SzbyOqrC0xbGP/32oCAzZdQAyvBo0lgnw=;
        b=P2JyzMrQ6Sn6crQtsbBhGg38aQ/JvORD9aYYLAp+RonrRrIt5muglSgOrIL5AR/qX2
         khOf8IOdYQ7wWqNqKcS8uTS3f/GyoD0TMPx5DOhr+kaNo8JzpvFJYPayP9q1LGsBmLlu
         MRZdQdnBG85wsGqjXVeKQKWqXHnvDze59ZracFogvB2CxC9wt/jRx9iJq0qFpwHBmfZA
         ZTJFtQO0f+0YasamliPR4biNugwmsP/jdTozIzKiq++0iLXtvJHIpw2nGPJKLhjEYDsg
         ooznzpsjo1pnGMEm5K1YjJc81cP9T/4Nb3WavA2eI2KNmVxGAxzOUXlYrpG9tvPxlcUM
         t7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=eIdxjx1Ob3SzbyOqrC0xbGP/32oCAzZdQAyvBo0lgnw=;
        b=hchiNsChOLNPBOc0MDtQP3AM90UNJx5jlzcAu4DxL6Ytr9oKCjGPAqa3CWrDz+P3b6
         srBWemUDsaVucy78T4KKl5XvgIUxV7yy4Or6p9pTceMBX3zh/5aFpBXV9WeUQfRluUoz
         +FMwxeRmnF6Kute5zbq4yT/uvbLZhWtXS/C7hc1k7hkQ8w35Ex7svzSQzfIr6trhOeIi
         pQ+/QneYryLihXDAv89xzKLAZZ1sStQPLX9T8ZxEGW5JklprQTMEylqw/hAaTJ1wUc7U
         giD0T0qaZuc9FA57/QPJJIoa81VcB/ucXjIZJxMI3/pTcI4bNl/ErpCFrHDRHQu07Uw1
         fwig==
X-Gm-Message-State: AOAM532solHZ2I+9VXaUs6GhkGW2A+o5ZlstJHuKVcnBwgixlT1R4IwV
        9wFccIwH1uIcigpUexy29XVeThqiCUY=
X-Google-Smtp-Source: ABdhPJwgm4dNZnKTwewSAooXHri0W5I8GW1uauwddyUu9a/Mv0i9vjIqmjJPHNf4sDCefiRLd2+bxA==
X-Received: by 2002:adf:fd02:: with SMTP id e2mr21726230wrr.139.1640804116630;
        Wed, 29 Dec 2021 10:55:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm21660943wrg.15.2021.12.29.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:16 -0800 (PST)
Message-Id: <12c5da8108752cd70b5b0147fd58c7280ebb3099.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:07 +0000
Subject: [PATCH v3 11/11] i18n: turn even more messages into "cannot be used
 together" ones
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Even if some of these messages are not subject to gettext i18n, this
helps bring a single style of message for a given error type.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/add.c                             |  2 +-
 builtin/am.c                              |  4 ++--
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        |  4 ++--
 builtin/clone.c                           |  2 +-
 builtin/commit.c                          | 10 ++++++----
 builtin/describe.c                        |  4 ++--
 builtin/rebase.c                          |  4 ++--
 builtin/reset.c                           |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/rm.c                              |  2 +-
 builtin/stash.c                           |  2 +-
 diff.c                                    |  6 +++---
 t/t2026-checkout-pathspec-file.sh         |  2 +-
 t/t2072-restore-pathspec-file.sh          |  2 +-
 t/t3601-rm-pathspec-file.sh               |  2 +-
 t/t3704-add-pathspec-file.sh              |  2 +-
 t/t3909-stash-pathspec-file.sh            |  2 +-
 t/t4209-log-pickaxe.sh                    |  4 ++--
 t/t5606-clone-options.sh                  |  2 +-
 t/t7107-reset-pathspec-file.sh            |  2 +-
 t/t7500-commit-template-squash-signoff.sh | 11 ++++++-----
 t/t7526-commit-pathspec-file.sh           |  2 +-
 23 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 067ec53d69f..dcaa3b5f395 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -566,7 +566,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
 				    PATHSPEC_PREFER_FULL |
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..c9665866651 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2230,8 +2230,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	}
 
 	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
-		return error(_("--show-current-patch=%s is incompatible with "
-			       "--show-current-patch=%s"),
+		return error(_("options '--show-current-patch=%s' and '--show-current-patch=%s' "
+					   "cannot be used together"),
 			     arg, valid_modes[resume->sub_mode]);
 
 	resume->mode = RESUME_SHOW_PATCH;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 86fc03242b8..d94050e6c18 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -729,7 +729,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	}
 
 	if (force_path && batch.enabled) {
-		error("--path=<path> incompatible with --batch");
+		error("options '--path=<path>' and '--batch' cannot be used together");
 		usage_with_options(cat_file_usage, options);
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc219317ff2..cfb2de5da89 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1635,7 +1635,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("-%c, -%c and --orphan are mutually exclusive"),
+		die(_("options '-%c', '-%c' and '--orphan' cannot be used together"),
 				cb_option, toupper(cb_option));
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
@@ -1746,7 +1746,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	if (opts->pathspec_from_file) {
 		if (opts->pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		if (opts->force_detach)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file",  "--detach");
diff --git a/builtin/clone.c b/builtin/clone.c
index 13bdbe14b2f..cc92393e4a5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -900,7 +900,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_bare) {
 		if (option_origin)
-			die(_("--bare and --origin %s options are incompatible."),
+			die(_("options '--bare' and '--origin %s' cannot be used together"),
 			    option_origin);
 		if (real_git_dir)
 			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
diff --git a/builtin/commit.c b/builtin/commit.c
index 91f685c5e71..bab7a7a298c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,7 +361,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("options '%s' and '%s' cannot be used together"),"--pathspec-from-file", "-a");
 
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL,
@@ -799,7 +799,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		if (!strcmp(fixup_prefix, "amend")) {
 			if (have_option_m)
-				die(_("cannot combine -m with --fixup:%s"), fixup_message);
+				die(_("options '-m' and '--fixup:%s' cannot be used together"), fixup_message);
 			prepare_amend_commit(commit, &sb, &ctx);
 		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
@@ -1229,9 +1229,11 @@ static void check_fixup_reword_options(int argc, const char *argv[]) {
 			die(_("You are in the middle of a cherry-pick -- cannot reword."));
 	}
 	if (argc)
-		die(_("cannot combine reword option of --fixup with path '%s'"), *argv);
+		die(_("reword option of --fixup and path '%s' cannot be used together"), *argv);
 	if (patch_interactive || interactive || all || also || only)
-		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
+		die(_("reword option of --fixup and "
+			  "--patch/--interactive/--all/--include/--only "
+			  "cannot be used together"));
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
diff --git a/builtin/describe.c b/builtin/describe.c
index fd5ba1fc604..42159cd26bd 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -670,9 +670,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
-		die(_("--dirty is incompatible with commit-ishes"));
+		die(_("option '%s' and commit-ishes cannot be used together"), "--dirty");
 	} else if (broken) {
-		die(_("--broken is incompatible with commit-ishes"));
+		die(_("option '%s' and commit-ishes cannot be used together"), "--broken");
 	} else {
 		while (argc-- > 0)
 			describe(*argv++, argc == 0);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed326b8aecc..d3ce0999786 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1460,8 +1460,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (i >= 0) {
 			if (is_merge(&options))
-				die(_("cannot combine apply options with "
-				      "merge options"));
+				die(_("apply options and merge options "
+					  "cannot be used together"));
 			else
 				options.type = REBASE_APPLY;
 		}
diff --git a/builtin/reset.c b/builtin/reset.c
index 4779e70dfbe..2db1012cbb1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -426,7 +426,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index de60cbdbc9d..0e3d93afed3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -676,7 +676,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.count &&
 	    (revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	    (revs.left_right || revs.cherry_mark))
-		die(_("marked counting is incompatible with --objects"));
+		die(_("marked counting and '--objects' cannot be used together"));
 
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
diff --git a/builtin/rm.c b/builtin/rm.c
index cfdf24cf49a..fdfe76dd742 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -272,7 +272,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_CWD,
diff --git a/builtin/stash.c b/builtin/stash.c
index 3e3743fd5a3..5afa48ef989 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1706,7 +1706,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--staged");
 
 		if (ps.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
 
 		parse_pathspec_file(&ps, 0,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
diff --git a/diff.c b/diff.c
index 8de1c49763c..ba2a886ec2c 100644
--- a/diff.c
+++ b/diff.c
@@ -4639,16 +4639,16 @@ void diff_setup_done(struct diff_options *options)
 		options->set_default(options);
 
 	if (HAS_MULTI_BITS(options->output_format & check_mask))
-		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
+		die(_("options '--name-only', '--name-status', '--check' and '-s' cannot be used together"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-G", "-S", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
-		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
+		die(_("-G and --pickaxe-regex cannot be used together, use --pickaxe-regex with -S"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
-		die(_("--pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
+		die(_("--pickaxe-all and --find-object cannot be used together, use --pickaxe-all with -G and -S"));
 
 	/*
 	 * Most of the time we can say "there are changes"
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 9e6b17e2d23..9c651aefbca 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -155,7 +155,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git checkout --pathspec-from-file=list -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git checkout --pathspec-file-nul 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index af67ca7d52b..c22669b39f9 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -155,7 +155,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index bbed67f8ef5..a2a0c820fe3 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -67,7 +67,7 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
 
 	test_must_fail git rm --pathspec-from-file=list -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git rm --pathspec-file-nul 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 47ad96bf661..4e6b5177c93 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -147,7 +147,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .--edit. cannot be used together" err &&
 
 	test_must_fail git add --pathspec-from-file=list -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git add --pathspec-file-nul 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index fde4625cfcb..dead9f18d93 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -91,7 +91,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git stash push --pathspec-from-file=list -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git stash push --pathspec-file-nul 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 4f820f8597d..7f6bb27f141 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -72,12 +72,12 @@ test_expect_success 'usage' '
 	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
-	grep "mutually exclusive" err
+	grep "cannot be used together" err
 '
 
 test_expect_success 'usage: --pickaxe-regex' '
 	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
-	grep "mutually exclusive" err
+	grep "cannot be used together" err
 '
 
 test_expect_success 'usage: --no-pickaxe-regex' '
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3af3577af0b..8f676d6b0c0 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -46,7 +46,7 @@ test_expect_success 'disallows --bare with --origin' '
 
 	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
 	test_debug "cat err" &&
-	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
+	test_i18ngrep -e "options .--bare. and .--origin foo. cannot be used together" err
 
 '
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index f753e3229e2..523efbecde1 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -163,7 +163,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git reset --pathspec-from-file=list -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git reset --pathspec-file-nul 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 8dd0f988129..653c0954753 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -359,14 +359,14 @@ test_expect_success '--fixup=reword: ignores staged changes' '
 
 test_expect_success '--fixup=reword: error out with -m option' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: cannot combine -m with --fixup:reword" >expect &&
+	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
 	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--fixup=amend: error out with -m option' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: cannot combine -m with --fixup:amend" >expect &&
+	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
 	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
 	test_cmp expect actual
 '
@@ -421,8 +421,9 @@ test_expect_success 'amend! commit allows empty commit msg body with --allow-emp
 
 test_fixup_reword_opt () {
 	test_expect_success "--fixup=reword: incompatible with $1" "
-		echo 'fatal: reword option of --fixup is mutually exclusive with'\
-			'--patch/--interactive/--all/--include/--only' >expect &&
+		echo 'fatal: reword option of --fixup and' \
+			'--patch/--interactive/--all/--include/--only' \
+			'cannot be used together' >expect &&
 		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
 		test_cmp expect actual
 	"
@@ -435,7 +436,7 @@ done
 
 test_expect_success '--fixup=reword: give error with pathsec' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: cannot combine reword option of --fixup with path '\''foo'\''" >expect &&
+	echo "fatal: reword option of --fixup and path '\''foo'\'' cannot be used together" >expect &&
 	test_must_fail git commit --fixup=reword:HEAD~ -- foo 2>actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index ea69e3a6ad1..ad011bb9f15 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -150,7 +150,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "options .--pathspec-from-file. and .-a. cannot be used together" err &&
 
 	test_must_fail git commit --pathspec-from-file=list -m "Commit" -- fileA.t 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
 
 	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
-- 
gitgitgadget
