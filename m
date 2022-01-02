Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CFC433EF
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiABRQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiABRP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB7C061784
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so17229977wme.4
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZseRlkeqhvefzV48rq9H7//0CvPXn6/dac9K0bmAGEY=;
        b=NrVgAVyh4xd8OAxv/wBc3o//3Ae8sOULzTXVLbn/Hu5gDY/GqCgOI6yAbOTy9lJl+D
         GIjsmZiAxo78JtlUeTw8VMvLUCyd279BGYQ/5L0USOaNXEai6VO0M+DU3hQbEk0Vgk1d
         wYTImo4wdjb+sbA9E5yQ1fZlpFwyBWIid63QyqUfYVS7KcYg88Qmq30FQ2hBeLdWm/ah
         TP4XsKK0gP++3OQfMdW1EwDw58LXiQnde8RV4uI3IYStRBW5UTdU1AmtCJZOVzjqpKkY
         xDkpLUGTsHvL/JWfwCEF/dVQ7rm+YSZA7GaWE5qjTSEvd26LS1NTdxX0zMDJgO7T3rEr
         rWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZseRlkeqhvefzV48rq9H7//0CvPXn6/dac9K0bmAGEY=;
        b=JlmFtJ+c4CbtueSo3XG+S8iSK8oUyRNvjun7T2thPo2I6jncyFkW9Z2L6UPtkW07BX
         Q40RUiTWbihqBd7e+YST9AMihH7SC7+FLVaWnCxTSo/Lp/Ad3F9x1INGbvkCCkP5oAGL
         r+lHCKP7q4shGv819KIzRIt5HBvBna06szuWS+7d5MbxhgKFRF/748+OqbcTK26ujbya
         RIrFfld251VPH+IvXAe8EplFDBztPqrNsCT05skgy8HakerqYcvX8QfjdHMrxrgWtNNA
         nT9HBQB9rN8LYnmr9In3n1fxgVq0y/1Wb6Kd4MWCFHyk2ZzWQ5ni5QKt9FbGx3z2LX8U
         kWUA==
X-Gm-Message-State: AOAM530ynI2HNEdPbgjlwuhFCooUhOcRRliHyyFtx0hOo+Y/pYI+GNjx
        D9awRBfjEK9N0OHsxv4N3pbry1JPpNA=
X-Google-Smtp-Source: ABdhPJwuk3Kes5jZxdhWOJR20fHAxX52moRS1HbhO1DD6hp4GsiHsZkX1EgeAZGgxchi5dIIdxym4w==
X-Received: by 2002:a05:600c:4f83:: with SMTP id n3mr35481995wmq.129.1641143757716;
        Sun, 02 Jan 2022 09:15:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm32929480wrf.93.2022.01.02.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:57 -0800 (PST)
Message-Id: <4fab0db3cc472f456655e574eb9c67a6c4c4df2b.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:45 +0000
Subject: [PATCH v4 11/11] i18n: turn even more messages into "cannot be used
 together" ones
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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
 builtin/am.c                              |  6 +++---
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        |  6 +++---
 builtin/clone.c                           |  4 ++--
 builtin/commit.c                          |  9 +++++----
 builtin/describe.c                        |  4 ++--
 builtin/rebase.c                          |  4 ++--
 builtin/reset.c                           |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/rm.c                              |  2 +-
 builtin/stash.c                           |  2 +-
 diff.c                                    | 12 ++++++++----
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
 23 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 067ec53d69f..84dff3e7969 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -566,7 +566,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
 				    PATHSPEC_PREFER_FULL |
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..68a190dd9f5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2230,9 +2230,9 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	}
 
 	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
-		return error(_("--show-current-patch=%s is incompatible with "
-			       "--show-current-patch=%s"),
-			     arg, valid_modes[resume->sub_mode]);
+		return error(_("options '%s=%s' and '%s=%s' "
+					   "cannot be used together"),
+					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
 
 	resume->mode = RESUME_SHOW_PATCH;
 	resume->sub_mode = new_value;
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
index af5fa8228eb..eb3a69c2120 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1635,8 +1635,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("-%c, -%c and --orphan are mutually exclusive"),
-				cb_option, toupper(cb_option));
+		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
+			cb_option, toupper(cb_option), "--orphan");
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
@@ -1746,7 +1746,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	if (opts->pathspec_from_file) {
 		if (opts->pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		if (opts->force_detach)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
diff --git a/builtin/clone.c b/builtin/clone.c
index 13bdbe14b2f..8b79666e3a7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -900,8 +900,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_bare) {
 		if (option_origin)
-			die(_("--bare and --origin %s options are incompatible."),
-			    option_origin);
+			die(_("options '%s' and '%s %s' cannot be used together"),
+			    "--bare", "--origin", option_origin);
 		if (real_git_dir)
 			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
 		option_no_checkout = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index 49e7477747f..b9ed0374e30 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,7 +361,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "-a");
 
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL,
@@ -799,7 +799,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		if (!strcmp(fixup_prefix, "amend")) {
 			if (have_option_m)
-				die(_("cannot combine -m with --fixup:%s"), fixup_message);
+				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
 			prepare_amend_commit(commit, &sb, &ctx);
 		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
@@ -1229,9 +1229,10 @@ static void check_fixup_reword_options(int argc, const char *argv[]) {
 			die(_("You are in the middle of a cherry-pick -- cannot reword."));
 	}
 	if (argc)
-		die(_("cannot combine reword option of --fixup with path '%s'"), *argv);
+		die(_("reword option of '%s' and path '%s' cannot be used together"), "--fixup", *argv);
 	if (patch_interactive || interactive || all || also || only)
-		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
+		die(_("reword option of '%s' and '%s' cannot be used together"),
+			"--fixup", "--patch/--interactive/--all/--include/--only");
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
index 16e6053b14a..36490d06c8a 100644
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
index 4779e70dfbe..b97745ee94e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -426,7 +426,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1a3b0b3591..777558e9b06 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -676,7 +676,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.count &&
 	    (revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	    (revs.left_right || revs.cherry_mark))
-		die(_("marked counting is incompatible with --objects"));
+		die(_("marked counting and '%s' cannot be used together"), "--objects");
 
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
diff --git a/builtin/rm.c b/builtin/rm.c
index cfdf24cf49a..127a6f0220c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -272,7 +272,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_CWD,
diff --git a/builtin/stash.c b/builtin/stash.c
index 3e3743fd5a3..7b1876b3e31 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1706,7 +1706,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--staged");
 
 		if (ps.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
 
 		parse_pathspec_file(&ps, 0,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
diff --git a/diff.c b/diff.c
index 02ce779e43a..da5fc81a543 100644
--- a/diff.c
+++ b/diff.c
@@ -4639,16 +4639,20 @@ void diff_setup_done(struct diff_options *options)
 		options->set_default(options);
 
 	if (HAS_MULTI_BITS(options->output_format & check_mask))
-		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
+		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
+			"--name-only", "--name-status", "--check", "-s");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
-		die(_("options '%s', '%s', and '%s' cannot be used together"), "-G", "-S", "--find-object");
+		die(_("options '%s', '%s', and '%s' cannot be used together"),
+			"-G", "-S", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
-		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
+		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
+			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
-		die(_("--pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
+		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
+			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
 
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
index 8dd0f988129..91964653a0b 100755
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
+		echo 'fatal: reword option of '\''--fixup'\'' and' \
+			''\''--patch/--interactive/--all/--include/--only'\' \
+			'cannot be used together' >expect &&
 		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
 		test_cmp expect actual
 	"
@@ -435,7 +436,7 @@ done
 
 test_expect_success '--fixup=reword: give error with pathsec' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: cannot combine reword option of --fixup with path '\''foo'\''" >expect &&
+	echo "fatal: reword option of '\''--fixup'\'' and path '\''foo'\'' cannot be used together" >expect &&
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
