Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A503C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378781AbhLCHFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378755AbhLCHFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212EC061759
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j3so3718732wrp.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=enOe15eSMg6JX5SgjnrRCkB3LSYBx2v2eUJQC0Qr678=;
        b=WO04sDRWg7mwCvTQrA3jTEFLlFEHS6bwbx0sSmURA+4L3Ymb8UlFz6Eje6SmD1hnKP
         /FtDjYPueYmaxOnWJP2CiKN7K5UWbvoZpfjnnqmkQpV1kILY+f60y6vPvhvnNMcjYvez
         kI+6Pd2SQXb5OFmHSxJ8HgPkw6oJfPaXzps+iBTx/idR6k3+qvEvi8KYhURXt1OH1+4N
         +BGosCK5CNMJWMlf405PIBKWXeJjDnmxFQPsDwoJXOiNThZTRGxOAxBfD563AubUR2td
         9BuXwR733PmgWWtXMD5wJVD7CbF00xQqc535Aled7w/6dcOuyq2MDrC4fh7bEpjN2oWp
         B91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=enOe15eSMg6JX5SgjnrRCkB3LSYBx2v2eUJQC0Qr678=;
        b=Cv1Uz6fHWpPqLc3hYbTzAdU4rqPM9HFcEI5zF05kk5GS3F9Z7ytuC0GV1SLWkFkUYV
         OnPuW+8+7DclyzVLWbM+HH+wlm/6hYddRoLLubI5J9f8sr1qeeWn22S17ex0sp2lId2z
         wRL5ckEbnuqFMzqtZaPNw53n2nrfNt33hhp9L/gvkxOuRmdj6v3Awf5kjtiEjNftWM0u
         K/rZMjGiNjvkSE6mEx5WpWfB4KM6MwUnKXh4HMr112s3kNHToHnzvVsDXBt73IPhHuPz
         ItMu0R8h2E8LAdlNQV8yRKnpyQpcYunTOG3GDjp0LyrhxnBoRw/EShBeNnGr7eRe8wJK
         A/cg==
X-Gm-Message-State: AOAM530FUpCIEeDV9cMtYQftHxuLFPhe1tE8k6t6MnW9SrJN4dhgr/nj
        wtddiprRIDSMjLioW/cGv6bxDcoj5V0=
X-Google-Smtp-Source: ABdhPJwFuIfXeuC+31rSCHmnbkE6ZSjpohsPbTD54TqHyUwu3DgnIgY1+YQZBcwl9ZEjRch1ansg7w==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr19909347wry.394.1638514914656;
        Thu, 02 Dec 2021 23:01:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m36sm1784095wms.25.2021.12.02.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:54 -0800 (PST)
Message-Id: <46e94ef3ac9378f934cd4e2bd00e390978fda05a.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:42 +0000
Subject: [PATCH 03/10] i18n: turn "options are incompatible" into "are
 mutually exclusive"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 apply.c                           |  2 +-
 archive.c                         |  2 +-
 builtin/add.c                     |  8 ++++----
 builtin/branch.c                  |  2 +-
 builtin/checkout.c                |  4 ++--
 builtin/clone.c                   |  2 +-
 builtin/commit.c                  |  4 ++--
 builtin/describe.c                |  2 +-
 builtin/difftool.c                |  2 +-
 builtin/fast-export.c             |  2 +-
 builtin/index-pack.c              |  2 +-
 builtin/pack-objects.c            |  2 +-
 builtin/push.c                    |  8 ++++----
 builtin/repack.c                  |  4 ++--
 builtin/reset.c                   |  4 ++--
 builtin/stash.c                   |  2 +-
 builtin/tag.c                     |  2 +-
 revision.c                        | 22 +++++++++++-----------
 t/t2026-checkout-pathspec-file.sh |  4 ++--
 t/t2072-restore-pathspec-file.sh  |  2 +-
 t/t3704-add-pathspec-file.sh      |  6 +++---
 t/t3909-stash-pathspec-file.sh    |  2 +-
 t/t5606-clone-options.sh          |  2 +-
 t/t7107-reset-pathspec-file.sh    |  2 +-
 t/t7526-commit-pathspec-file.sh   |  4 ++--
 25 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4ee..fefec23f1ec 100644
--- a/apply.c
+++ b/apply.c
@@ -133,7 +133,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		return error(_("--reject and --3way cannot be used together."));
+		return error(_("%s and %s are mutually exclusive"),"--reject",  "--3way");
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
diff --git a/archive.c b/archive.c
index a3bbb091256..10376be7161 100644
--- a/archive.c
+++ b/archive.c
@@ -581,7 +581,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
-		die(_("Options --add-file and --remote cannot be used together"));
+		die(_("%s and %s are mutually exclusive"), "--add-file", "--remote");
 
 	if (!base)
 		base = "";
diff --git a/builtin/add.c b/builtin/add.c
index ef6b619c45e..de1547b3dcd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -510,9 +510,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		add_interactive = 1;
 	if (add_interactive) {
 		if (show_only)
-			die(_("--dry-run is incompatible with --interactive/--patch"));
+			die(_("%s and %s are mutually exclusive"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
-			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--interactive/--patch");
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
 	if (legacy_stash_p) {
@@ -529,7 +529,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
-			die(_("--pathspec-from-file is incompatible with --edit"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--edit");
 		return(edit_patch(argc, argv, prefix));
 	}
 	argc--;
@@ -541,7 +541,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		addremove = 0; /* "-u" was given but not "-A" */
 
 	if (addremove && take_worktree_changes)
-		die(_("-A and -u are mutually incompatible"));
+		die(_("%s and %s are mutually exclusive"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
diff --git a/builtin/branch.c b/builtin/branch.c
index 7a1d1eeb070..50d99fa6fd4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -717,7 +717,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {
 		if (explicitly_enable_column(colopts))
-			die(_("--column and --verbose are incompatible"));
+			die(_("%s and %s are mutually exclusive"), "--column", "--verbose");
 		colopts = 0;
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4bd8a57f190..ca444e9c177 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1731,10 +1731,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
 		if (opts->force_detach)
-			die(_("--pathspec-from-file is incompatible with --detach"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file",  "--detach");
 
 		if (opts->patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
 
 		parse_pathspec_file(&opts->pathspec, 0,
 				    0,
diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..b8c3f072bae 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -903,7 +903,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
 		if (real_git_dir)
-			die(_("--bare and --separate-git-dir are incompatible."));
+			die(_("%s and %s are mutually exclusive"), "--bare", "--separate-git-dir");
 		option_no_checkout = 1;
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 883c16256c8..cb7b9a38daa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -355,7 +355,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	if (pathspec_from_file) {
 		if (interactive)
-			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--interactive/--patch");
 
 		if (all)
 			die(_("--pathspec-from-file with -a does not make sense"));
@@ -1193,7 +1193,7 @@ static void finalize_deferred_config(struct wt_status *s)
 		    status_format == STATUS_FORMAT_UNSPECIFIED)
 			status_format = STATUS_FORMAT_PORCELAIN;
 		else if (status_format == STATUS_FORMAT_LONG)
-			die(_("--long and -z are incompatible"));
+			die(_("%s and %s are mutually exclusive"), "--long", "-z");
 	}
 
 	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
diff --git a/builtin/describe.c b/builtin/describe.c
index e912ba50d7b..26da61a216f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -590,7 +590,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 
 	if (longformat && abbrev == 0)
-		die(_("--long is incompatible with --abbrev=0"));
+		die(_("%s and %s are mutually exclusive"), "--long", "--abbrev=0");
 
 	if (contains) {
 		struct string_list_item *item;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 61ebfa9c68c..ab8f06c991d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -736,7 +736,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 	} else if (dir_diff)
-		die(_("--dir-diff is incompatible with --no-index"));
+		die(_("%s and %s are mutually exclusive"), "--dir-diff", "--no-index");
 
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
 		die(_("%s, %s and %s are mutually exclusive"), "--gui", "--tool", "--extcmd");
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e2caf72819..31157e966d6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1269,7 +1269,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		printf("feature done\n");
 
 	if (import_filename && import_filename_if_exists)
-		die(_("Cannot pass both --import-marks and --import-marks-if-exists"));
+		die(_("%s and %s are mutually exclusive"), "--import-marks", "--import-marks-if-exists");
 	if (import_filename)
 		import_marks(import_filename, 0);
 	else if (import_filename_if_exists)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7dc..f9b40349f41 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1849,7 +1849,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
-		die(_("--object-format cannot be used with --stdin"));
+		die(_("%s and %s are mutually exclusive"), "--object-format", "--stdin");
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f83..a5e674894f0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4070,7 +4070,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		die(_("--thin cannot be used to build an indexable pack"));
 
 	if (keep_unreachable && unpack_unreachable)
-		die(_("--keep-unreachable and --unpack-unreachable are incompatible"));
+		die(_("%s and %s are mutually exclusive"), "--keep-unreachable", "--unpack-unreachable");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
diff --git a/builtin/push.c b/builtin/push.c
index 4b026ce6c6a..ba55e07a678 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -589,7 +589,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-		die(_("--delete is incompatible with --all, --mirror and --tags"));
+		die(_("%s and %s are mutually exclusive"), "--delete", "--all/--mirror/--tags");
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
@@ -627,18 +627,18 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (flags & TRANSPORT_PUSH_ALL) {
 		if (tags)
-			die(_("--all and --tags are incompatible"));
+			die(_("%s and %s are mutually exclusive"), "--all", "--tags");
 		if (argc >= 2)
 			die(_("--all can't be combined with refspecs"));
 	}
 	if (flags & TRANSPORT_PUSH_MIRROR) {
 		if (tags)
-			die(_("--mirror and --tags are incompatible"));
+			die(_("%s and %s are mutually exclusive"), "--mirror", "--tags");
 		if (argc >= 2)
 			die(_("--mirror can't be combined with refspecs"));
 	}
 	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
-		die(_("--all and --mirror are incompatible"));
+		die(_("%s and %s are mutually exclusive"), "--all", "--mirror");
 
 	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
 		cas.use_force_if_includes = 1;
diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82b..8e92943f871 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -679,7 +679,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (keep_unreachable &&
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
-		die(_("--keep-unreachable and -A are incompatible"));
+		die(_("%s and %s are mutually exclusive"), "--keep-unreachable", "-A");
 
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
@@ -710,7 +710,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (geometric_factor) {
 		if (pack_everything)
-			die(_("--geometric is incompatible with -A, -a"));
+			die(_("%s and %s are mutually exclusive"),"--geometric", "-A/-a");
 		init_pack_geometry(&geometry);
 		split_pack_geometry(geometry, geometric_factor);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 73935953494..6e80e5c5a51 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -328,7 +328,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
 
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
@@ -364,7 +364,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (patch_mode) {
 		if (reset_type != NONE)
-			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+			die(_("%s and %s are mutually exclusive"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..080572cc608 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1644,7 +1644,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
 	if (pathspec_from_file) {
 		if (patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
 
 		if (ps.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
diff --git a/builtin/tag.c b/builtin/tag.c
index 6fe646710d6..41941d5129f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -522,7 +522,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&colopts, -1);
 	if (cmdmode == 'l' && filter.lines != -1) {
 		if (explicitly_enable_column(colopts))
-			die(_("--column and -n are incompatible"));
+			die(_("%s and %s are mutually exclusive"), "--column", "-n");
 		colopts = 0;
 	}
 	if (!sorting)
diff --git a/revision.c b/revision.c
index 1981a0859f0..58a1a0e66c6 100644
--- a/revision.c
+++ b/revision.c
@@ -2295,11 +2295,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
-			die("--right-only is incompatible with --left-only");
+			die(_("%s and %s are mutually exclusive"), "--right-only", "--left-only");
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--cherry")) {
 		if (revs->left_only)
-			die("--cherry is incompatible with --left-only");
+			die(_("%s and %s are mutually exclusive"), "--cherry", "--left-only");
 		revs->cherry_mark = 1;
 		revs->right_only = 1;
 		revs->max_parents = 1;
@@ -2308,12 +2308,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-mark")) {
 		if (revs->cherry_pick)
-			die("--cherry-mark is incompatible with --cherry-pick");
+			die(_("%s and %s are mutually exclusive"), "--cherry-mark", "--cherry-pick");
 		revs->cherry_mark = 1;
 		revs->limited = 1; /* needs limit_list() */
 	} else if (!strcmp(arg, "--cherry-pick")) {
 		if (revs->cherry_mark)
-			die("--cherry-pick is incompatible with --cherry-mark");
+			die(_("%s and %s are mutually exclusive"), "--cherry-pick", "--cherry-mark");
 		revs->cherry_pick = 1;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
@@ -2519,7 +2519,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
-		die("--show-linear-break and --graph are incompatible");
+		die(_("%s and %s are mutually exclusive"), "--show-linear-break", "--graph");
 
 	return 1;
 }
@@ -2862,24 +2862,24 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
-		die("cannot combine --reverse with --walk-reflogs");
+		die(_("%s and %s are mutually exclusive"), "--reverse", "--walk-reflogs");
 	if (revs->reflog_info && revs->limited)
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
-		die("cannot combine --parents and --children");
+		die(_("%s and %s are mutually exclusive"), "--parents", "--children");
 
 	/*
 	 * Limitations on the graph functionality
 	 */
 	if (revs->reverse && revs->graph)
-		die("cannot combine --reverse with --graph");
+		die(_("%s and %s are mutually exclusive"), "--reverse", "--graph");
 
 	if (revs->reflog_info && revs->graph)
-		die("cannot combine --walk-reflogs with --graph");
+		die(_("%s and %s are mutually exclusive"), "--walk-reflogs", "--graph");
 	if (revs->no_walk && revs->graph)
-		die("cannot combine --no-walk with --graph");
+		die(_("%s and %s are mutually exclusive"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
-		die("cannot use --grep-reflog without --walk-reflogs");
+		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 43d31d79485..88e00203df6 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -148,10 +148,10 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
 
 	test_must_fail git checkout --pathspec-from-file=list --detach 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --detach" err &&
+	test_i18ngrep -e "--pathspec-from-file and --detach are mutually exclusive" err &&
 
 	test_must_fail git checkout --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
 
 	test_must_fail git checkout --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index b48345bf95f..2e918daa225 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -152,7 +152,7 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git restore --pathspec-from-file=list --patch --source=HEAD^1 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
 
 	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 9e35c1fbca6..4e5cdabc97f 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -137,13 +137,13 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git add --pathspec-from-file=list --interactive 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
 
 	test_must_fail git add --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
 
 	test_must_fail git add --pathspec-from-file=list --edit 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --edit" err &&
+	test_i18ngrep -e "--pathspec-from-file and --edit are mutually exclusive" err &&
 
 	test_must_fail git add --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 55e050cfd4d..b7e6c89682b 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -88,7 +88,7 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
 
 	test_must_fail git stash push --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
 
 	test_must_fail git stash push --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index d822153e4d2..dec92ff0a75 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -54,7 +54,7 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
 	test_debug "cat err" &&
-	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
+	test_i18ngrep -e "--bare and --separate-git-dir are mutually exclusive" err
 
 '
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 15ccb14f7e2..b8a3e2e2a9d 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -160,7 +160,7 @@ test_expect_success 'error conditions' '
 	git rm fileA.t &&
 
 	test_must_fail git reset --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
 
 	test_must_fail git reset --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 5fbe47ebcd0..8ef1c8d941c 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -140,10 +140,10 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git commit --pathspec-from-file=list --interactive -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
 
 	test_must_fail git commit --pathspec-from-file=list --patch -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
 
 	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
 	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
-- 
gitgitgadget

