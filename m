Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8AC20248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCHKRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42500 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCHKRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so13790623pgl.9
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn8n5IG9NYC3/TaRM95ov/lXkrPLzuG0QVmFzYMbtTw=;
        b=OF8pJV+2Vg60g8k1Xdj/ILBR7EYWN3pmH4tlVUcxOzDyhs4cbIuLgFHoy912+Imouo
         mfupvhY3hqggluRH5Pu0Q1ZnsfVPUdwAuM3TiL1FsHFQ5a7e008liW2zNgDLnS4JESXP
         EBaa/b/M93bUTiFKFAQgClIRCJ3rgPPhg+tiPQXaN6hAgCvPBW2FNu6shqvNDUzYDoeR
         KhGN6h6jWWMUMj2svBP7WBqsKUGGDOw0SetqZ92V9+zBHrJQdyYPm8NyFX99d+QFhMjV
         MPdy/no1p8bjLUaFU0aZ+DMhwU5XE+AaxqS23qxjphB5gv6yJ6WxBxX96BSPWAIWG0r7
         TN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn8n5IG9NYC3/TaRM95ov/lXkrPLzuG0QVmFzYMbtTw=;
        b=WBq5diQ7pGkRSXNfmzjA3oYk8TVke+AqK3VKfWymVL2Dw88J7I59fRz1M7Vi6zgGlw
         MOZhkSCeNBCkrZkAmkkxEn5kJlHn36XCrISaDEckV5UXpL9s+SZbdSYGu0Gsuqm9ESHz
         0i33qcxpw4tEGl6prL0vBnvHGJ0fLBrN9lnES1ePNJ46d3sAlApO22DlaKCBs4r/I4EG
         GlGAb3dayrLIdDzjYJL5ZE2FOg5fFkOEV5fTf+eKADncbBIXJ3J5W5d6Qo7TjAzrJn8B
         dn5GkAZ0xmat8yOSQHCT/sDs9eYPWDqp+JooJ05W/H9WEfUZMpl4l6Qq0Yy0Cy+vGmi2
         nXGQ==
X-Gm-Message-State: APjAAAUVXZY+0NVlp2QsEDL4KrqDPoPv+kSRQSk+IJSEHyUI54I6OKz9
        kNkcSSmgSHY36nQQDIuBzXraMrtU
X-Google-Smtp-Source: APXvYqyCadaLE9PVvdDJ4ucBdI25hWxfWcbtpi6MEYHAH4K1hHheYYhfM9Sd3FudhZ7LX7RiwxUzfg==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr16125007pgv.416.1552040229672;
        Fri, 08 Mar 2019 02:17:09 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z7sm15742141pfl.4.2019.03.08.02.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
Date:   Fri,  8 Mar 2019 17:16:45 +0700
Message-Id: <20190308101655.9767-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the switching branch business of 'git checkout' becomes a
new command. This adds restore command for the checking out
paths path.

Similar to switch, a new man page is added to describe what the
command will become. The implementation will be updated shortly to
match the man page.

A couple of differences from 'git checkout' worth highlighting:

- 'restore' by default will only update worktree. This matters more
  when --source is specified ('checkout <tree> <paths>' updates both
  worktree and index).

- 'restore --index' can be used to restore the index. This command
  overlaps with 'git reset <paths>'.

- both worktree and index could also be restored at the same time
  (from a tree). This overlaps with 'git checkout <tree> <paths>'

- default source for restoring worktree and index is the index and
  HEAD respectively. A different (tree) source could be specified as
  with --source (*).

- when both index and worktree are restored, --source must be
  specified since the default source for these two individual targets
  are different (**)

- --no-overlay is enabled by default, if an entry is missing in the
  source, restoring means deleting the entry

(*) I originally went with --from instead of --source. I still think
  --from is a better name. The short option -f however is already
  taken by force. And I do think short option is good to have, e.g. to
  write -s@ or -s@^ instead of --source=HEAD.

(**) If you sit down and think about it, moving worktree's source from
  the index to HEAD makes sense, but nobody is really thinking it
  through when they type the commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore                           |   1 +
 Documentation/config/interactive.txt |   3 +-
 Documentation/git-checkout.txt       |   1 +
 Documentation/git-restore.txt (new)  | 172 +++++++++++++++++++++++++++
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/checkout.c                   |  26 ++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 9 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index c687b92b1c..fb377106be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,7 @@
 /git-request-pull
 /git-rerere
 /git-reset
+/git-restore
 /git-rev-list
 /git-rev-parse
 /git-revert
diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index ad846dd7c9..a2d3c7ec44 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -2,7 +2,8 @@ interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used by the `--patch` mode of
-	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
+	linkgit:git-add[1], linkgit:git-checkout[1],
+	linkgit:git-restore[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
 	setting is silently ignored if portable keystroke input
 	is not available; requires the Perl module Term::ReadKey.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2b776c1269..e107099c8c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -571,6 +571,7 @@ $ git add frotz
 SEE ALSO
 --------
 linkgit:git-switch[1]
+linkgit:git-restore[1]
 
 GIT
 ---
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
new file mode 100644
index 0000000000..a667a5ced4
--- /dev/null
+++ b/Documentation/git-restore.txt
@@ -0,0 +1,172 @@
+git-restore(1)
+==============
+
+NAME
+----
+git-restore - Restore working tree files
+
+SYNOPSIS
+--------
+[verse]
+'git restore' [<options>] [--source=<revision>] <pathspec>...
+'git restore' (-p|--patch) [--source=<revision>] [<pathspec>...]
+
+DESCRIPTION
+-----------
+Restore paths in the working tree by replacing with the contents in
+the restore source or remove if the paths do not exist in the restore
+source. The source is by default the index but could be from a commit.
+The command can also optionally restore content in the index from a
+commit.
+
+When a `<revision>` is given, the paths that match the `<pathspec>` are
+updated both in the index and in the working tree.
+
+OPTIONS
+-------
+-s<tree>::
+--source=<tree>::
+	Restore the working tree files with the content from the given
+	tree or any revision that leads to a tree (e.g. a commit or a
+	branch).
+
+-p::
+--patch::
+	Interactively select hunks in the difference between the
+	`<revision>` (or the index, if unspecified) and the working
+	tree. See the ``Interactive Mode'' section of linkgit:git-add[1]
+	to learn how to operate the `--patch` mode.
+
+-W::
+--worktree::
+-I::
+--index::
+	Specify the restore location. If neither option is specified,
+	by default the working tree is restored. If `--index` is
+	specified without `--worktree` or `--source`, `--source=HEAD`
+	is implied. These options only make sense to use with
+	`--source`.
+
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+--progress::
+--no-progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
+-f::
+--force::
+	If `--source` is not specified, unmerged entries are left alone
+	and will not fail the operation. Unmerged entries are always
+	replaced if `--source` is specified, regardless of `--force`.
+
+--ours::
+--theirs::
+	Check out stage #2 ('ours') or #3 ('theirs') for unmerged
+	paths.
++
+Note that during `git rebase` and `git pull --rebase`, 'ours' and
+'theirs' may appear swapped. See the explanation of the same options
+in linkgit:git-checkout[1] for details.
+
+-m::
+--merge::
+	Recreate the conflicted merge in the specified paths.
+
+--conflict=<style>::
+	The same as `--merge` option above, but changes the way the
+	conflicting hunks are presented, overriding the merge.conflictStyle
+	configuration variable.  Possible values are "merge" (default)
+	and "diff3" (in addition to what is shown by "merge" style,
+	shows the original contents).
+
+--ignore-skip-worktree-bits::
+	In sparse checkout mode, by default update only entries
+	matched by `<pathspec>` and sparse patterns in
+	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	patterns and unconditionally restores any files in `<pathspec>`.
+
+--recurse-submodules::
+--no-recurse-submodules::
+	Using `--recurse-submodules` will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
+	is used, the work trees of submodules will not be updated.
+	Just like linkgit:git-submodule[1], this will detach the
+	submodules HEAD.
+
+--overlay::
+--no-overlay::
+	In overlay mode, `git checkout` never removes files from the
+	index or the working tree. In no-overlay mode, files that
+	appear in the index and working tree, but not in `--source` tree
+	are removed, to make them match `<tree-ish>` exactly. The
+	default is no-overlay mode.
+
+EXAMPLES
+--------
+
+The following sequence checks out the `master` branch, reverts
+the `Makefile` to two revisions back, deletes hello.c by
+mistake, and gets it back from the index.
+
+------------
+$ git switch master
+$ git restore --source master~2 Makefile  <1>
+$ rm -f hello.c
+$ git restore hello.c                   <2>
+------------
+
+<1> take a file out of another commit
+<2> restore hello.c from the index
+
+If you want to check out _all_ C source files out of the index,
+you can say
+
+------------
+$ git restore '*.c'
+------------
+
+Note the quotes around `*.c`.  The file `hello.c` will also be
+checked out, even though it is no longer in the working tree,
+because the file globbing is used to match entries in the index
+(not in the working tree by the shell).
+
+To restore all files in the current directory
+
+------------
+$ git restore .
+------------
+
+or to restore all working tree files with 'top' pathspec magic (see
+linkgit::gitglossary[7])
+
+------------
+$ git restore :/
+------------
+
+To restore a file in the index only (this is the same as using
+"git reset")
+
+------------
+$ git restore --index hello.c
+------------
+
+or you can restore both the index and the working tree
+
+------------
+$ git restore --source=HEAD --index --worktree hello.c
+------------
+
+SEE ALSO
+--------
+linkgit:git-checkout[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 8e91db73ad..ffe7e4f58f 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
+BUILT_INS += git-restore$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/builtin.h b/builtin.h
index c64e44450e..6830000e14 100644
--- a/builtin.h
+++ b/builtin.h
@@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repack(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_restore(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4903359b49..11dd2ae44c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,11 @@ static const char * const switch_branch_usage[] = {
 	NULL,
 };
 
+static const char * const restore_files_usage[] = {
+	N_("git restore [<options>] [<branch>] -- <file>..."),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1528,3 +1533,24 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	FREE_AND_NULL(options);
 	return ret;
 }
+
+int cmd_restore(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.accept_pathspec = 1;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, restore_files_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 13317f47d4..b9eae1c258 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -151,6 +151,7 @@ git-replace                             ancillarymanipulators           complete
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
+git-restore                             mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
diff --git a/git.c b/git.c
index 39582cf511..6d439e723f 100644
--- a/git.c
+++ b/git.c
@@ -558,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
+	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
 	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
 	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-- 
2.21.0.rc1.337.gdf7f8d0522

