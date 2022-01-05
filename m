Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C6DC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiAEUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbiAEUCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D8C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so468305wrc.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jCapsCpZFk+R0JG47DyovAoee0CIflSNKqzQVDTSobs=;
        b=me+XDIxruVQVmQH/JSHNIJAxv8FOOsEzOjRQKTdUn3ZXwGY+3x4XlbegeOk0j/dMgd
         KEI9U1VsbyFdJI1ZeqZ9qiZa2QMkmUoY+5g+VrcN7sZ/3p0aeU62lQez4XOIyRPNkj1C
         atJZ4+qI2I9PirA9xIqDxGwMzzTurdh+Ls7z0HfkBj5oIv3rw5B3LmCWVH9jjbaG5Hkw
         COmR8sS5CKIUelaY8xHleID/tvDGKeTCX17QdyZdaq8fIRMkD5yuaXtDY0ULS+FDFPSg
         RuRWVh9fYmhk9v58FbaL4eERqKpE4sLSsRQJSkYMABJ5YrYaNp4PP/wx2x9Kqpwp7676
         rjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jCapsCpZFk+R0JG47DyovAoee0CIflSNKqzQVDTSobs=;
        b=ILTqIKpqIHhBXQPXkF8/ICgFqKs50T61Z9ul44DBA1xN8nhnjk/PvYxZJ9R+vwho66
         WoJ07VnExe44iNVLNWGCTOHfbxyYvfvx19eFmes6Lngf5TlLzxKV6vN7LG1fjmp2jYYa
         sddl4be6o48y34KqNttgBXMDAKo2rCgczliv2vr/PXRw0c5n6S2d6Y0f5+nc8+pKsKBd
         K/oMKszkZ49jGAsOdky/2J6GLUBxjdMfYD0E50cFMdCl2m94wgHlZZzuq3G95DqnSoAi
         OuKp09eyx7L1PoKvkhYxDv3MatmC2Pj419BM1qH3fzHIBXssGT86ubPCo66igk1Wmq6w
         sxlA==
X-Gm-Message-State: AOAM530WKlpuvL4lbfKtkN00OnekE/G2fwCJJK9ww1yUdJ80hGGL3cFA
        Y6bk568n+/zzzkMSZ4l2j+1cvRr8gDA=
X-Google-Smtp-Source: ABdhPJzFjwv3t/jRnX72zoQHiUOnZK5hKNsiEU2iO9bgFxyUQ3k9FVMXU7X2NZEIK68LZG8HB+dQLw==
X-Received: by 2002:a05:6000:180c:: with SMTP id m12mr1639530wrh.494.1641412948274;
        Wed, 05 Jan 2022 12:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm3704690wms.4.2022.01.05.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:27 -0800 (PST)
Message-Id: <80390ce08edbade5acc62439fdcdc02b905b152c.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:16 +0000
Subject: [PATCH v5 03/11] i18n: turn "options are incompatible" into "cannot
 be used together"
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 apply.c                           |  2 +-
 archive.c                         |  2 +-
 builtin/add.c                     |  8 ++++----
 builtin/branch.c                  |  2 +-
 builtin/checkout.c                |  8 ++++----
 builtin/clone.c                   |  2 +-
 builtin/commit.c                  |  6 +++---
 builtin/describe.c                |  2 +-
 builtin/difftool.c                |  2 +-
 builtin/fast-export.c             |  2 +-
 builtin/index-pack.c              |  2 +-
 builtin/ls-files.c                |  2 +-
 builtin/merge.c                   |  4 ++--
 builtin/pack-objects.c            |  2 +-
 builtin/push.c                    |  8 ++++----
 builtin/rebase.c                  |  6 +++---
 builtin/repack.c                  |  4 ++--
 builtin/reset.c                   |  4 ++--
 builtin/rev-list.c                |  2 +-
 builtin/show-branch.c             |  4 ++--
 builtin/stash.c                   |  4 ++--
 builtin/tag.c                     |  4 ++--
 revision.c                        | 20 ++++++++++----------
 t/t2026-checkout-pathspec-file.sh |  4 ++--
 t/t2072-restore-pathspec-file.sh  |  2 +-
 t/t3431-rebase-fork-point.sh      |  2 +-
 t/t3704-add-pathspec-file.sh      |  6 +++---
 t/t3909-stash-pathspec-file.sh    |  2 +-
 t/t5606-clone-options.sh          |  2 +-
 t/t7107-reset-pathspec-file.sh    |  2 +-
 t/t7526-commit-pathspec-file.sh   |  6 +++---
 31 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/apply.c b/apply.c
index fed195250b6..cabcdbe425a 100644
--- a/apply.c
+++ b/apply.c
@@ -133,7 +133,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		return error(_("--reject and --3way cannot be used together."));
+		return error(_("options '%s' and '%s' cannot be used together"), "--reject", "--3way");
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
diff --git a/archive.c b/archive.c
index a3bbb091256..e85ba169088 100644
--- a/archive.c
+++ b/archive.c
@@ -581,7 +581,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
-		die(_("Options --add-file and --remote cannot be used together"));
+		die(_("options '%s' and '%s' cannot be used together"), "--add-file", "--remote");
 
 	if (!base)
 		base = "";
diff --git a/builtin/add.c b/builtin/add.c
index a010b2c325f..4b2754345ad 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -507,9 +507,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		add_interactive = 1;
 	if (add_interactive) {
 		if (show_only)
-			die(_("--dry-run is incompatible with --interactive/--patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
-			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
 	if (legacy_stash_p) {
@@ -526,7 +526,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
-			die(_("--pathspec-from-file is incompatible with --edit"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
 		return(edit_patch(argc, argv, prefix));
 	}
 	argc--;
@@ -538,7 +538,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		addremove = 0; /* "-u" was given but not "-A" */
 
 	if (addremove && take_worktree_changes)
-		die(_("-A and -u are mutually incompatible"));
+		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
diff --git a/builtin/branch.c b/builtin/branch.c
index 6c8b0fcc11f..0e93865371c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -722,7 +722,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {
 		if (explicitly_enable_column(colopts))
-			die(_("--column and --verbose are incompatible"));
+			die(_("options '%s' and '%s' cannot be used together"), "--column", "--verbose");
 		colopts = 0;
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 79014e1cb6c..73f5a6fbfa1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -464,10 +464,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s' cannot be used with updating paths"), "--detach");
 
 	if (opts->merge && opts->patch_mode)
-		die(_("'%s' cannot be used with %s"), "--merge", "--patch");
+		die(_("options '%s' and '%s' cannot be used together"), "--merge", "--patch");
 
 	if (opts->ignore_unmerged && opts->merge)
-		die(_("'%s' cannot be used with %s"),
+		die(_("options '%s' and '%s' cannot be used together"),
 		    opts->ignore_unmerged_opt, "-m");
 
 	if (opts->new_branch)
@@ -1749,10 +1749,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
 		if (opts->force_detach)
-			die(_("--pathspec-from-file is incompatible with --detach"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
 
 		if (opts->patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 
 		parse_pathspec_file(&opts->pathspec, 0,
 				    0,
diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..13bdbe14b2f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -903,7 +903,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
 		if (real_git_dir)
-			die(_("--bare and --separate-git-dir are incompatible."));
+			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
 		option_no_checkout = 1;
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 883c16256c8..067c795ca4b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -355,10 +355,10 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	if (pathspec_from_file) {
 		if (interactive)
-			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
 
 		if (all)
-			die(_("--pathspec-from-file with -a does not make sense"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "-a");
 
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
@@ -1193,7 +1193,7 @@ static void finalize_deferred_config(struct wt_status *s)
 		    status_format == STATUS_FORMAT_UNSPECIFIED)
 			status_format = STATUS_FORMAT_PORCELAIN;
 		else if (status_format == STATUS_FORMAT_LONG)
-			die(_("--long and -z are incompatible"));
+			die(_("options '%s' and '%s' cannot be used together"), "--long", "-z");
 	}
 
 	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
diff --git a/builtin/describe.c b/builtin/describe.c
index e912ba50d7b..fd5ba1fc604 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -590,7 +590,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 
 	if (longformat && abbrev == 0)
-		die(_("--long is incompatible with --abbrev=0"));
+		die(_("options '%s' and '%s' cannot be used together"), "--long", "--abbrev=0");
 
 	if (contains) {
 		struct string_list_item *item;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 5beadc07ccd..c79fbbf67e5 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -730,7 +730,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 	} else if (dir_diff)
-		die(_("--dir-diff is incompatible with --no-index"));
+		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
 		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e2caf72819..1f8fe7b3ac1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1269,7 +1269,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		printf("feature done\n");
 
 	if (import_filename && import_filename_if_exists)
-		die(_("Cannot pass both --import-marks and --import-marks-if-exists"));
+		die(_("options '%s' and '%s' cannot be used together"), "--import-marks", "--import-marks-if-exists");
 	if (import_filename)
 		import_marks(import_filename, 0);
 	else if (import_filename_if_exists)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7dc..30ce2ac746d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1849,7 +1849,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
-		die(_("--object-format cannot be used with --stdin"));
+		die(_("options '%s' and '%s' cannot be used together"), "--object-format", "--stdin");
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 031fef1bcaa..9c80cdae951 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -767,7 +767,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 * would not make any sense with this option.
 		 */
 		if (show_stage || show_unmerged)
-			die("ls-files --with-tree is incompatible with -s or -u");
+			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
 		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 5f0476b0b76..6db961e9d34 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1396,9 +1396,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (squash) {
 		if (fast_forward == FF_NO)
-			die(_("You cannot combine --squash with --no-ff."));
+			die(_("options '%s' and '%s' cannot be used together"), "--squash", "--no-ff.");
 		if (option_commit > 0)
-			die(_("You cannot combine --squash with --commit."));
+			die(_("options '%s' and '%s' cannot be used together"), "--squash", "--commit.");
 		/*
 		 * squash can now silently disable option_commit - this is not
 		 * a problem as it is only overriding the default, not a user
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b36ed828d8d..ba2006f2212 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4070,7 +4070,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		die(_("--thin cannot be used to build an indexable pack"));
 
 	if (keep_unreachable && unpack_unreachable)
-		die(_("--keep-unreachable and --unpack-unreachable are incompatible"));
+		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
diff --git a/builtin/push.c b/builtin/push.c
index 4b026ce6c6a..359db90321c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -589,7 +589,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-		die(_("--delete is incompatible with --all, --mirror and --tags"));
+		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--mirror/--tags");
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
@@ -627,18 +627,18 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (flags & TRANSPORT_PUSH_ALL) {
 		if (tags)
-			die(_("--all and --tags are incompatible"));
+			die(_("options '%s' and '%s' cannot be used together"), "--all", "--tags");
 		if (argc >= 2)
 			die(_("--all can't be combined with refspecs"));
 	}
 	if (flags & TRANSPORT_PUSH_MIRROR) {
 		if (tags)
-			die(_("--mirror and --tags are incompatible"));
+			die(_("options '%s' and '%s' cannot be used together"), "--mirror", "--tags");
 		if (argc >= 2)
 			die(_("--mirror can't be combined with refspecs"));
 	}
 	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
-		die(_("--all and --mirror are incompatible"));
+		die(_("options '%s' and '%s' cannot be used together"), "--all", "--mirror");
 
 	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
 		cas.use_force_if_includes = 1;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 34b4744e5f3..16e6053b14a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1190,13 +1190,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (keep_base) {
 		if (options.onto_name)
-			die(_("cannot combine '--keep-base' with '--onto'"));
+			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
 		if (options.root)
-			die(_("cannot combine '--keep-base' with '--root'"));
+			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
 	}
 
 	if (options.root && options.fork_point > 0)
-		die(_("cannot combine '--root' with '--fork-point'"));
+		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
 
 	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
diff --git a/builtin/repack.c b/builtin/repack.c
index 9b0be6a6ab3..b7b54781bd2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -681,7 +681,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (keep_unreachable &&
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
-		die(_("--keep-unreachable and -A are incompatible"));
+		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
 
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
@@ -712,7 +712,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (geometric_factor) {
 		if (pack_everything)
-			die(_("--geometric is incompatible with -A, -a"));
+			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
 		init_pack_geometry(&geometry);
 		split_pack_geometry(geometry, geometric_factor);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index b1ff699b43a..248998fd6fa 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (pathspec_from_file) {
 		if (patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
@@ -459,7 +459,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (patch_mode) {
 		if (reset_type != NONE)
-			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 36cb909ebaa..c1a3b0b3591 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -538,7 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (skip_prefix(arg, "--missing=", &arg)) {
 			if (revs.exclude_promisor_objects)
-				die(_("cannot combine --exclude-promisor-objects and --missing"));
+				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
 			if (parse_missing_action_value(arg))
 				break;
 		}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f1e8318592c..e12c5e80e3e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -707,8 +707,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 *
 			 * Also --all and --remotes do not make sense either.
 			 */
-			die(_("--reflog is incompatible with --all, --remotes, "
-			      "--independent or --merge-base"));
+			die(_("options '%s' and '%s' cannot be used together"), "--reflog",
+				"--all/--remotes/--independent/--merge-base");
 	}
 
 	/* If nothing is specified, show all branches by default */
diff --git a/builtin/stash.c b/builtin/stash.c
index 18c812bbe03..4d793bd0b52 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1700,10 +1700,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
 	if (pathspec_from_file) {
 		if (patch_mode)
-			die(_("--pathspec-from-file is incompatible with --patch"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 
 		if (only_staged)
-			die(_("--pathspec-from-file is incompatible with --staged"));
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--staged");
 
 		if (ps.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
diff --git a/builtin/tag.c b/builtin/tag.c
index 41863c5ab77..dfdcfd37956 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -522,7 +522,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&colopts, -1);
 	if (cmdmode == 'l' && filter.lines != -1) {
 		if (explicitly_enable_column(colopts))
-			die(_("--column and -n are incompatible"));
+			die(_("options '%s' and '%s' cannot be used together"), "--column", "-n");
 		colopts = 0;
 	}
 	sorting = ref_sorting_options(&sorting_options);
@@ -564,7 +564,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-			die(_("only one -F or -m option is allowed."));
+			die(_("options '%s' and '%s' cannot be used together"), "-F", "-m");
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
 		else {
diff --git a/revision.c b/revision.c
index 5390a479b30..d28b63a3253 100644
--- a/revision.c
+++ b/revision.c
@@ -2300,11 +2300,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
-			die("--right-only is incompatible with --left-only");
+			die(_("options '%s' and '%s' cannot be used together"), "--right-only", "--left-only");
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--cherry")) {
 		if (revs->left_only)
-			die("--cherry is incompatible with --left-only");
+			die(_("options '%s' and '%s' cannot be used together"), "--cherry", "--left-only");
 		revs->cherry_mark = 1;
 		revs->right_only = 1;
 		revs->max_parents = 1;
@@ -2313,12 +2313,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-mark")) {
 		if (revs->cherry_pick)
-			die("--cherry-mark is incompatible with --cherry-pick");
+			die(_("options '%s' and '%s' cannot be used together"), "--cherry-mark", "--cherry-pick");
 		revs->cherry_mark = 1;
 		revs->limited = 1; /* needs limit_list() */
 	} else if (!strcmp(arg, "--cherry-pick")) {
 		if (revs->cherry_mark)
-			die("--cherry-pick is incompatible with --cherry-mark");
+			die(_("options '%s' and '%s' cannot be used together"), "--cherry-pick", "--cherry-mark");
 		revs->cherry_pick = 1;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
@@ -2524,7 +2524,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
-		die("--show-linear-break and --graph are incompatible");
+		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
 
 	return 1;
 }
@@ -2867,22 +2867,22 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
-		die("cannot combine --reverse with --walk-reflogs");
+		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--walk-reflogs");
 	if (revs->reflog_info && revs->limited)
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
-		die("cannot combine --parents and --children");
+		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
 
 	/*
 	 * Limitations on the graph functionality
 	 */
 	if (revs->reverse && revs->graph)
-		die("cannot combine --reverse with --graph");
+		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--graph");
 
 	if (revs->reflog_info && revs->graph)
-		die("cannot combine --walk-reflogs with --graph");
+		die(_("options '%s' and '%s' cannot be used together"), "--walk-reflogs", "--graph");
 	if (revs->no_walk && revs->graph)
-		die("cannot combine --no-walk with --graph");
+		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 9db11f86dd6..fbe26de2f90 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -149,10 +149,10 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
 
 	test_must_fail git checkout --pathspec-from-file=list --detach 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --detach" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--detach. cannot be used together" err &&
 
 	test_must_fail git checkout --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git checkout --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index b48345bf95f..ad1fc0ed071 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -152,7 +152,7 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git restore --pathspec-from-file=list --patch --source=HEAD^1 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4c98d99e7e8..1d0b15380ed 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -83,7 +83,7 @@ test_expect_success 'git rebase --fork-point with ambigous refname' '
 
 test_expect_success '--fork-point and --root both given' '
 	test_must_fail git rebase --fork-point --root 2>err &&
-	test_i18ngrep "cannot combine" err
+	test_i18ngrep "cannot be used together" err
 '
 
 test_expect_success 'rebase.forkPoint set to false' '
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 5d5164d1fc6..7e17ae80229 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -138,13 +138,13 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git add --pathspec-from-file=list --interactive 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
 
 	test_must_fail git add --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
 
 	test_must_fail git add --pathspec-from-file=list --edit 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --edit" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--edit. cannot be used together" err &&
 
 	test_must_fail git add --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 55e050cfd4d..aae2b25f766 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -88,7 +88,7 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
 
 	test_must_fail git stash push --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git stash push --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index d822153e4d2..3af3577af0b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -54,7 +54,7 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
 	test_debug "cat err" &&
-	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
+	test_i18ngrep -e "options .--bare. and .--separate-git-dir. cannot be used together" err
 
 '
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 15ccb14f7e2..b211fbc0a52 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -160,7 +160,7 @@ test_expect_success 'error conditions' '
 	git rm fileA.t &&
 
 	test_must_fail git reset --pathspec-from-file=list --patch 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
 
 	test_must_fail git reset --pathspec-from-file=list -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index dca62fc48e5..574cf30285c 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -141,13 +141,13 @@ test_expect_success 'error conditions' '
 	>empty_list &&
 
 	test_must_fail git commit --pathspec-from-file=list --interactive -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
 
 	test_must_fail git commit --pathspec-from-file=list --patch -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
 
 	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
+	test_i18ngrep -e "options .--pathspec-from-file. and .-a. cannot be used together" err &&
 
 	test_must_fail git commit --pathspec-from-file=list -m "Commit" -- fileA.t 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
-- 
gitgitgadget

