Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B97C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhL0XYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhL0XYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBFCC061759
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso9230474wmc.3
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fwYyPd3q8rouX4ieA3N1jpXvYi3CdJKqnyScInHyszc=;
        b=MFqEbR+a7SQkLVAgy2nE/MYoieV8IqVPgQt6GWVxgbfYGHtFOMf94Cw97WsPQ1QUZX
         9IQZ9ihjFPPIlaQXrtvAYltQ99T9a/BnBeMZQHF7V65U2+OANa4MDoAaqWxNOi4fb7Sc
         WE9ovEqKZGDv4lFpZHO+mAuhB/W4JkaGHCVHcjfwO619JoGe6tTlraSBVDwP/vuAR4+s
         18cml5n7IZEhVRgsXgMFiD2CBUMZX+lu0f4YHWUlCsrIqaLRQIpSgnyjy6+jsELb7s1+
         tWaO8Yc0B+1ZQpnOjbjBB+hZleE8FdBqCpbt1vEgseI5/dUEkfdg9Us4G7mvPy8kbJOR
         TN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fwYyPd3q8rouX4ieA3N1jpXvYi3CdJKqnyScInHyszc=;
        b=y/ZuKg+vLkVAbCtVgXSLMgg4j53BsOGqB1kACBAI+3KkNajH3gYIMFlCzF3uVMQWjz
         AR9cFutbtYFV3dpwoTiQikjBFe8tMHDBHPfRgLPHHanc0fqQb7kOGxm2UEvl62a7g2jt
         bKMUUoTnY+I62rMh/sIb/gZP58lziMxthjQS55pfbz2itSmtndonhjR5yycb/0NVJDA/
         7HDVS0BjLEdUEiUpRIdrLiuBQrg5ig2l3fZ91U/eQnhsNMSdYZsFCdnoNim+esp++NyU
         4ZWpolU3NM2X5MwtCmy2C1fEAfs0ZXNk30TOyABnTQsSMMXEeMW7cU19Q6yd28wHeETq
         1V6g==
X-Gm-Message-State: AOAM53369w2lZLr5ANQnBcZ+0CfWYadJZ29dvw41fTLx4kJg3lfI12+V
        fgSkjtP2yT4RSfDcNt8XP/w3+++w49Q=
X-Google-Smtp-Source: ABdhPJxo01n3+kGN3GHnpVeRcTuTn2zUFOFCMoOwTH5zrBRSrgfE6pTM++PWmLDY1DYZ2uJJZEq6uA==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr15136254wme.117.1640647443100;
        Mon, 27 Dec 2021 15:24:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm20100228wmp.9.2021.12.27.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:02 -0800 (PST)
Message-Id: <f83ed5cb7995e2ce3c9aac9eb4971f45bcf94e89.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:52 +0000
Subject: [PATCH v2 06/11] i18n: factorize "--foo requires --bar" and the like
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c             | 2 +-
 builtin/add.c         | 4 ++--
 builtin/checkout.c    | 2 +-
 builtin/commit.c      | 2 +-
 builtin/fast-export.c | 2 +-
 builtin/index-pack.c  | 2 +-
 builtin/log.c         | 2 +-
 builtin/reset.c       | 4 ++--
 builtin/rm.c          | 2 +-
 builtin/stash.c       | 2 +-
 builtin/worktree.c    | 2 +-
 fetch-pack.c          | 2 +-
 http-fetch.c          | 4 ++--
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/archive.c b/archive.c
index 78d35467008..6fd4d951bd9 100644
--- a/archive.c
+++ b/archive.c
@@ -577,7 +577,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (remote)
 		die(_("Unexpected option --remote"));
 	if (exec)
-		die(_("Option --exec can only be used together with --remote"));
+		die(_("%s requires %s"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
diff --git a/builtin/add.c b/builtin/add.c
index 4b2754345ad..b505eca3d4d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -541,7 +541,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-run"));
+		die(_("%s requires %s"), "--ignore-missing", "--dry-run");
 
 	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
@@ -573,7 +573,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d7bfbd0f1a..d005aaad9f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1758,7 +1758,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				    0,
 				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index 5c1aaa42131..eb803a96ae3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -367,7 +367,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr && (also || (only && !allow_empty &&
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1f8fe7b3ac1..a1eba9298a4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1254,7 +1254,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (anonymized_seeds.cmpfn && !anonymize)
-		die(_("--anonymize-map without --anonymize does not make sense"));
+		die(_("%s requires %s"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
 		int i;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 30ce2ac746d..6845bcb41af 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1845,7 +1845,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
-		die(_("--fix-thin cannot be used without --stdin"));
+		die(_("%s requires %s"), "--fix-thin", "--stdin");
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/builtin/log.c b/builtin/log.c
index 705d58110b0..8fe51bc8afb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2112,7 +2112,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
+		die(_("%s requires %s"), "--creation-factor", "--range-diff");
 
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
diff --git a/builtin/reset.c b/builtin/reset.c
index 248998fd6fa..25f52ea99f6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -432,7 +432,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
@@ -490,7 +490,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		    _(reset_type_names[reset_type]));
 
 	if (intent_to_add && reset_type != MIXED)
-		die(_("-N can only be used with --mixed"));
+		die(_("%s requires %s"), "-N", "--mixed");
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..38ac3c71252 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_CWD,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr)
diff --git a/builtin/stash.c b/builtin/stash.c
index 4d793bd0b52..7ad2f9aca87 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1712,7 +1712,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b5ef19b2dda..bce01c8a671 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -505,7 +505,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
-		die(_("--reason requires --lock"));
+		die(_("%s requires %s"), "--reason", "--lock");
 	if (lock_reason)
 		opts.keep_locked = lock_reason;
 	else if (keep_locked)
diff --git a/fetch-pack.c b/fetch-pack.c
index 34987a2c30d..0a5dfea9377 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -297,7 +297,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct packet_reader reader;
 
 	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
+		die(_("%s requires %s"), "--stateless-rpc", "multi_ack_detailed");
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
diff --git a/http-fetch.c b/http-fetch.c
index c7c7d391ac5..eab45d2cc07 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -141,7 +141,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("--packfile requires --index-pack-args"));
+			die(_("%s requires %s"), "--packfile", "--index-pack-args");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -150,7 +150,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("--index-pack-args can only be used with --packfile"));
+		die(_("%s requires %s"), "--index-pack-args", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
-- 
gitgitgadget

