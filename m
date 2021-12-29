Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACEFC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhL2Sz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhL2SzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13AC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w20so37129020wra.9
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8vCw+msCUdGkO8RKci+FiTKp6OStsjyJofeSakFzgDQ=;
        b=aAa8qo3iLLec8xTXFmtoJ17ktvUwoqv5Jn0N/ULbGMR1tk5BMe4RiA/XeGIEuUuu00
         vWD80pJVnyHvEfkA0qi3rBZ73ti/jTvWrnew1rzZ9oljc1QYPY948VNJ/xBbpPXUwJ7R
         pNgwdE/d8ObMDPujvsOepxVqUpIRvlc6A7dK7Tb+C7ojKDMp4RYXodURRljqFHAA5Npn
         oskKkVyRpW9XADTHFsDAP150mnQICxAXy3AU7ksoTcllp0QaKhBRNvYLnrcDPPwOUAp+
         UGtRASZIT1cyEa5+QmB4hM1Y5Zn3SBnsHDnS6Aptn45CuSKaZtY6A2Rfgg2dGUOw/Q8L
         EdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8vCw+msCUdGkO8RKci+FiTKp6OStsjyJofeSakFzgDQ=;
        b=MXc2+32GnyPzEDzLAorU7S1UqmGJKvE/4usC6TNRVaty4TA3i1TOpEf6YW5UBfoZiF
         2RCD7S/9DpBTQLethB9bg4vTkciMrJrqZGAEQxtpbsZRdeDIHZVRPsibqo9vzy7T3DCO
         Zpm+OG9283hxL4TFYfsTqhhLu8flQYygvKpkr297NIpK3HZCaMcQpLMhZAH2wkZ/MwEj
         jsw9Xn70HbPpx6qvem5vjafc161/xlJnbLJgZMqd4nhyHw19e2Bk5J0rSJdJ+FvC1v/g
         fg3snSpwAgklqLxagkCl5kyVd/n2Xt8dVmkBbcvjx5GMTm58vBd+s5s4jh9UeVAwcrGl
         napg==
X-Gm-Message-State: AOAM533noWOUBY0IXEz6YXiIBCE609V//Ngtm/v4PdRHYZ5ePceGpzT6
        gZJYu0ZX/WtjdLvHrXgWMs3HdffP5bw=
X-Google-Smtp-Source: ABdhPJzbGhLUgO1It8Lxhrdvrpbjm4kDwjg6TIZh9tQzEK5RMh60Lz+I3ysVbzVHf5i2SBbJBS0Giw==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr21221990wrz.666.1640804113388;
        Wed, 29 Dec 2021 10:55:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm19374018wml.14.2021.12.29.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:13 -0800 (PST)
Message-Id: <1097cc7d6d1a8cac884f22d962edb51c5ae0d28f.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:02 +0000
Subject: [PATCH v3 06/11] i18n: factorize "--foo requires --bar" and the like
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

They are all replaced by "the option '%s' requires '%s'", which is a
new string but replaces 17 previous unique strings.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c                         | 2 +-
 builtin/add.c                     | 4 ++--
 builtin/checkout.c                | 2 +-
 builtin/commit.c                  | 2 +-
 builtin/fast-export.c             | 2 +-
 builtin/index-pack.c              | 2 +-
 builtin/log.c                     | 2 +-
 builtin/reset.c                   | 4 ++--
 builtin/rm.c                      | 2 +-
 builtin/stash.c                   | 2 +-
 builtin/worktree.c                | 2 +-
 fetch-pack.c                      | 2 +-
 http-fetch.c                      | 4 ++--
 revision.c                        | 2 +-
 t/t2026-checkout-pathspec-file.sh | 2 +-
 t/t2072-restore-pathspec-file.sh  | 2 +-
 t/t3601-rm-pathspec-file.sh       | 2 +-
 t/t3704-add-pathspec-file.sh      | 2 +-
 t/t3909-stash-pathspec-file.sh    | 2 +-
 t/t7107-reset-pathspec-file.sh    | 2 +-
 t/t7526-commit-pathspec-file.sh   | 2 +-
 21 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/archive.c b/archive.c
index 78d35467008..d571249cf39 100644
--- a/archive.c
+++ b/archive.c
@@ -577,7 +577,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (remote)
 		die(_("Unexpected option --remote"));
 	if (exec)
-		die(_("Option --exec can only be used together with --remote"));
+		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
diff --git a/builtin/add.c b/builtin/add.c
index 4b2754345ad..067ec53d69f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -541,7 +541,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-run"));
+		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
 
 	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
@@ -573,7 +573,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d7bfbd0f1a..bc219317ff2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1758,7 +1758,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				    0,
 				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index 5c1aaa42131..91f685c5e71 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -367,7 +367,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr && (also || (only && !allow_empty &&
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1f8fe7b3ac1..f4d9aa1e8d1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1254,7 +1254,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (anonymized_seeds.cmpfn && !anonymize)
-		die(_("--anonymize-map without --anonymize does not make sense"));
+		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
 		int i;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 30ce2ac746d..3c2e6aee3cc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1845,7 +1845,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
-		die(_("--fix-thin cannot be used without --stdin"));
+		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/builtin/log.c b/builtin/log.c
index 705d58110b0..f88d03863a3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2112,7 +2112,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
+		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-diff");
 
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
diff --git a/builtin/reset.c b/builtin/reset.c
index 248998fd6fa..4779e70dfbe 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -432,7 +432,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
@@ -490,7 +490,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		    _(reset_type_names[reset_type]));
 
 	if (intent_to_add && reset_type != MIXED)
-		die(_("-N can only be used with --mixed"));
+		die(_("the option '%s' requires '%s'"), "-N", "--mixed");
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..cfdf24cf49a 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_CWD,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr)
diff --git a/builtin/stash.c b/builtin/stash.c
index 4d793bd0b52..3e3743fd5a3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1712,7 +1712,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b5ef19b2dda..d00078720d1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -505,7 +505,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
-		die(_("--reason requires --lock"));
+		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 	if (lock_reason)
 		opts.keep_locked = lock_reason;
 	else if (keep_locked)
diff --git a/fetch-pack.c b/fetch-pack.c
index 34987a2c30d..dd6ec449f2d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -297,7 +297,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct packet_reader reader;
 
 	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
+		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
diff --git a/http-fetch.c b/http-fetch.c
index c7c7d391ac5..58b394cd47f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -141,7 +141,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("--packfile requires --index-pack-args"));
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -150,7 +150,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("--index-pack-args can only be used with --packfile"));
+		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
diff --git a/revision.c b/revision.c
index fe445dd5d45..13ccc6829f1 100644
--- a/revision.c
+++ b/revision.c
@@ -2884,7 +2884,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
-		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
+		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index fbe26de2f90..9e6b17e2d23 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -158,7 +158,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git checkout --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
 '
 
 test_done
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index ad1fc0ed071..af67ca7d52b 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -158,7 +158,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git restore --pathspec-from-file=empty_list --source=HEAD^1 2>err &&
 	test_i18ngrep -e "you must specify path(s) to restore" err
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index b2a8db69afc..bbed67f8ef5 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -70,7 +70,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git rm --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	>empty_list &&
 	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 7e17ae80229..47ad96bf661 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -150,7 +150,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git add --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	# This case succeeds, but still prints to stderr
 	git add --pathspec-from-file=empty_list 2>err &&
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index aae2b25f766..fde4625cfcb 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -94,7 +94,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git stash push --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
 '
 
 test_done
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index b211fbc0a52..f753e3229e2 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -166,7 +166,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git reset --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git reset --soft --pathspec-from-file=list 2>err &&
 	test_i18ngrep -e "fatal: Cannot do soft reset with paths" err &&
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 574cf30285c..ea69e3a6ad1 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -153,7 +153,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git commit --pathspec-from-file=empty_list --include -m "Commit" 2>err &&
 	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
-- 
gitgitgadget

