Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C516C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhL0XYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhL0XYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4CC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so34861484wrg.11
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=s4gO+nDpM5UBlN8gg+47JlrdBzaim4GQc6jkFe07im8=;
        b=qAyw2WwmLR9ZDeqt+R3mMAfMozfuETW2CJLk3T65tfLH1KH+alLYZPXlYMRGOXUFUa
         qqsFUO/jPT77xqMiYIvOXgSKGgVJnkP/EcFyI/Fckr830dgNoftKh/92fWgM0M/BPWX7
         QBRYgVo3zTWgHuDznSsPzO7TjyY3Dt/19RLXVYdEK6HB1OPfeW7Gt59odCCzg5J3BtwU
         25h3tkmrlnlL/CDDdLRH4AsWcJeyv0NlA2ygKzmgXmJYwMTdHH/DwlWQ932SgEtswT6f
         qkGYvujZpEQQC/EKDb82xBy8qD4/KrmpKhmMKZARiihdjsFDCw67nuS5i7SNfSOmBNLZ
         ABow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=s4gO+nDpM5UBlN8gg+47JlrdBzaim4GQc6jkFe07im8=;
        b=BMVh7abk0Tw0mAOB3adRq6Il2s23hF4QoshNkSdwsYV0f6UAOMTjhEoWS9NyrtZdei
         4x3ByDwkettCbj24iyspOlN68cpvgLnfAyzuekynbx74dwK6cCg1hKxNaijLbzLS0O7T
         +yzXUgNvPBksOF4Vj+zPXp0JTIIH+ixTXAaBLmkE7Wk6HROvere5DmcXcHp4xUrxdKAC
         nMJqnE0kP9V9sKfhNREyRpM4XkUP72zeNmGMvRcKBg3b+wq2hacoa9ohS1H+m1TdEPQC
         Lr3rHtorRd4WBut9xRt1LlEwaq7b9EeHe0ggbQ9exF+lE0oYebeqv5sSBOEdBOTMw8Ss
         O7Vw==
X-Gm-Message-State: AOAM530tHmut4M0L1fQyVmddw10ICEmA4mF1oc/3d+ycVc2/3DilEFR8
        hY0r9zxzrxiC9DmLmrrfjdkb7MKp7MM=
X-Google-Smtp-Source: ABdhPJxhhsQ2Ffa7UWSJf4pVQRkcGLrup6qcL2+8mKwYMas0eB5AW4K/7PZH9QqlQ+/2n0nj+F/4AQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr13612672wrj.688.1640647440076;
        Mon, 27 Dec 2021 15:24:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm16540129wrg.105.2021.12.27.15.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:23:59 -0800 (PST)
Message-Id: <71699eaa27b7144df5277fa9a8867915db27f0a2.1640647437.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:47 +0000
Subject: [PATCH v2 01/11] i18n: refactor "foo and bar are mutually exclusive"
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

Use static strings for constant parts of the sentences. They are all
turned into "cannot be used together".

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/checkout.c             | 2 +-
 builtin/diff-tree.c            | 2 +-
 builtin/fetch.c                | 4 ++--
 builtin/init-db.c              | 2 +-
 builtin/log.c                  | 4 ++--
 builtin/submodule--helper.c    | 4 ++--
 builtin/worktree.c             | 2 +-
 range-diff.c                   | 2 +-
 t/t0001-init.sh                | 2 +-
 t/t2025-checkout-no-overlay.sh | 2 +-
 t/t4209-log-pickaxe.sh         | 6 +++---
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 72beeb49aa9..79014e1cb6c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1639,7 +1639,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				cb_option, toupper(cb_option));
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
-		die(_("-p and --overlay are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
 
 	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
 		if (opts->checkout_index < 0)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index f33d30d57bf..0e0ac1f1670 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -152,7 +152,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_stdin && merge_base)
-		die(_("--stdin and --merge-base are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "--stdin", "--merge-base");
 	if (merge_base && opt->pending.nr != 2)
 		die(_("--merge-base only works with two commits"));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f1fe73a3e0f..2c584c85812 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2028,12 +2028,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (deepen_relative < 0)
 			die(_("negative depth in --deepen is not supported"));
 		if (depth)
-			die(_("--deepen and --depth are mutually exclusive"));
+			die(_("options '%s' and '%s' cannot be used together"), "--deepen", "--depth");
 		depth = xstrfmt("%d", deepen_relative);
 	}
 	if (unshallow) {
 		if (depth)
-			die(_("--depth and --unshallow cannot be used together"));
+			die(_("options '%s' and '%s' cannot be used together"), "--depth", "--unshallow");
 		else if (!is_repository_shallow(the_repository))
 			die(_("--unshallow on a complete repository does not make sense"));
 		else
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2167796ff2a..546f9c595e7 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -557,7 +557,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && is_bare_repository_cfg == 1)
-		die(_("--separate-git-dir and --bare are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
diff --git a/builtin/log.c b/builtin/log.c
index 93ace0dde7d..fad93ad2fc1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1943,9 +1943,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 0;
 
 	if (numbered && keep_subject)
-		die(_("-n and -k are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
 	if (keep_subject && subject_prefix)
-		die(_("--subject-prefix/--rfc and -k are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc", "-k");
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9b25a508e6a..c5d3fc3817f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1313,7 +1313,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 
 	if (files) {
 		if (cached)
-			die(_("--cached and --files are mutually exclusive"));
+			die(_("options '%s' and '%s' cannot be used together"), "--cached", "--files");
 		diff_cmd = DIFF_FILES;
 	}
 
@@ -2972,7 +2972,7 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		die(_("--branch or --default required"));
 
 	if (opt_branch && opt_default)
-		die(_("--branch and --default are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "--branch", "--default");
 
 	if (argc != 1 || !(path = argv[0]))
 		usage_with_options(usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a396cfdc64e..9a520485769 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -699,7 +699,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else if (verbose && porcelain)
-		die(_("--verbose and --porcelain are mutually exclusive"));
+		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f2..30a4de5c2d8 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -556,7 +556,7 @@ int show_range_diff(const char *range1, const char *range2,
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
-		res = error(_("--left-only and --right-only are mutually exclusive"));
+		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
 	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7603ad2f82b..3235ab4d53c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -331,7 +331,7 @@ test_expect_success 'init with separate gitdir' '
 
 test_expect_success 'explicit bare & --separate-git-dir incompatible' '
 	test_must_fail git init --bare --separate-git-dir goop.git bare.git 2>err &&
-	test_i18ngrep "mutually exclusive" err
+	test_i18ngrep "cannot be used together" err
 '
 
 test_expect_success 'implicit bare & --separate-git-dir incompatible' '
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index fa9e0987063..8f13341cf8e 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -25,7 +25,7 @@ test_expect_success 'checkout --no-overlay removing last file from directory' '
 
 test_expect_success 'checkout -p --overlay is disallowed' '
 	test_must_fail git checkout -p --overlay HEAD 2>actual &&
-	test_i18ngrep "fatal: -p and --overlay are mutually exclusive" actual
+	test_i18ngrep "fatal: options .-p. and .--overlay. cannot be used together" actual
 '
 
 test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 75795d0b492..4f820f8597d 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -63,13 +63,13 @@ test_expect_success 'usage' '
 	test_i18ngrep "switch.*requires a value" err &&
 
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	grep "mutually exclusive" err
-- 
gitgitgadget

