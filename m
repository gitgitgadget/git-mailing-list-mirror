Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AFD2021E
	for <e@80x24.org>; Tue, 22 Nov 2016 19:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933484AbcKVTXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:23:19 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34897 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbcKVTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:23:01 -0500
Received: by mail-pg0-f41.google.com with SMTP id p66so10491075pga.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=l2MaSIAjkYT9CjYb+8oEaXgySZn8aB4OQKA4eF04WjA=;
        b=czvdsJLmZP7fi1ItmWtQGJZm2efKJzqAI4DO/Oq87l2l7rqCOhYk/Yh4AdPmLnTH2t
         FnDXsViZoLEmWSpl1kZmQK92CpXCgQsa665966zODFrgE2DScj5pHVtOPbXxuV5DEsU0
         jfl9Inefz4dcP/JkWOhSrA8+kh/gQnZykcP53MgoAQni4iawIDAEOx05cUya7gr03yXe
         z3xngobdTdAMqT7CLlGINupP6uQMvjTZHXUuWwxl79g97A0lY6p7kMl6fdGeLUlthI14
         mwnTHShVa+GeeR14TiztbOV89hxAHhj2aCYS//F2g/58arojXfkR//nLAaCc+VM6MrX6
         qhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l2MaSIAjkYT9CjYb+8oEaXgySZn8aB4OQKA4eF04WjA=;
        b=BCMcYksAV9x64dxEcQyeFrKuZgZLI6oF3USfDEDqc8JGVPu90pPW9W3URv2Al8Fopi
         K5rf8tHp4bnnz7U+guBKl++R9kYe4erDEcs4SOKo6YbYkNoa3Wz1FYwBA4qmiNohpX3p
         hI6IpsOZXDusSVUlJKjeG+P3ek7hOMI/sZCEQRtpOCjhauO+g3axDMfMZ0YhJeBzv1gW
         +XxIeIDm7yYPv899mnbC2TkmgsyVyxeHXkcnBs+Gv5Eh7TeIeFHglSnlBSkwtgVA7Bpg
         zUfi9lk+rWGLxmOSA8P8LRdwHwSj3dgc9akj06IpgOoA0Dyywwyo64C/8CV7tgA/BbQc
         +lbA==
X-Gm-Message-State: AKaTC01dz0S7aiL6i7S9Rwdk7/kOZ3AMO3EQymVEP2FDue+3mz0e5wfqAkyWW0i1i2N3VNKb
X-Received: by 10.84.209.143 with SMTP id y15mr2706985plh.96.1479842564087;
        Tue, 22 Nov 2016 11:22:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id a66sm46978725pfa.64.2016.11.22.11.22.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:22:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] `submodule embedgitdirs` [was: Introduce `submodule interngitdirs`]
Date:   Tue, 22 Nov 2016 11:22:31 -0800
Message-Id: <20161122192235.6055-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* fixed commit message for patch:
 "submodule: use absolute path for computing relative path connecting"
* a new patch "submodule helper: support super prefix"
* redid the final patch with more tests and fixing bugs along the way
* "test-lib-functions.sh: teach test_commit -C <dir>" unchanged

diff to v1 below.

Stefan Beller (4):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  submodule: add embed-git-dir function

 Documentation/git-submodule.txt   | 14 +++++++
 builtin/submodule--helper.c       | 62 +++++++++++++++++++++++++------
 git-submodule.sh                  |  7 +++-
 git.c                             |  2 +-
 submodule.c                       | 77 +++++++++++++++++++++++++++++++++++---
 submodule.h                       |  2 +
 t/t7412-submodule-embedgitdirs.sh | 78 +++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh           | 20 +++++++---
 8 files changed, 239 insertions(+), 23 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh

v1:
The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory.

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan

diff to v1:
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 80d55350eb..34791cfc65 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -22,7 +22,8 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
-'git submodule' [--quiet] interngitdirs [--] [<path>...]
+'git submodule' [--quiet] embedgitdirs [--] [<path>...]
+
 
 DESCRIPTION
 -----------
@@ -245,18 +246,18 @@ sync::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
-interngitdirs::
+embedgitdirs::
 	Move the git directory of submodules into its superprojects
 	`$GIT_DIR/modules` path and then connect the git directory and
 	its working directory by setting the `core.worktree` and adding
 	a .git file pointing to the git directory interned into the
 	superproject.
 +
-	A repository that was cloned independently and later added
-	as a submodule or old setups have the submodules git directory
-	inside the submodule instead of the
+A repository that was cloned independently and later added as a submodule or
+old setups have the submodules git directory inside the submodule instead of
+embedded into the superprojects git directory.
 +
-	This command is recursive by default.
+This command is recursive by default.
 
 OPTIONS
 -------
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 256f8e9439..75cdbf45b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,22 +1076,25 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
-static int intern_git_dir(int argc, const char **argv, const char *prefix)
+static int embed_git_dir(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
-	struct option intern_gitdir_options[] = {
+	struct option embed_gitdir_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper intern-git-dir [<path>...]"),
+		N_("git submodule--helper embed-git-dir [<path>...]"),
 		NULL
 	};
 
-	argc = parse_options(argc, argv, prefix, intern_gitdir_options,
+	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
 	gitmodules_config();
@@ -1101,27 +1104,30 @@ static int intern_git_dir(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	for (i = 0; i < list.nr; i++)
-		migrate_submodule_gitdir(list.entries[i]->name);
+		migrate_submodule_gitdir(prefix, list.entries[i]->name, 1);
 
 	return 0;
 }
 
+#define SUPPORT_SUPER_PREFIX (1<<0)
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
+	int option;
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list},
-	{"name", module_name},
-	{"clone", module_clone},
-	{"update-clone", update_clone},
-	{"relative-path", resolve_relative_path},
-	{"resolve-relative-url", resolve_relative_url},
-	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init},
-	{"remote-branch", resolve_remote_submodule_branch},
-	{"intern-git-dir", intern_git_dir}
+	{"list", module_list, 0},
+	{"name", module_name, 0},
+	{"clone", module_clone, 0},
+	{"update-clone", update_clone, 0},
+	{"relative-path", resolve_relative_path, 0},
+	{"resolve-relative-url", resolve_relative_url, 0},
+	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"init", module_init, 0},
+	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
@@ -1131,9 +1137,15 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
-		if (!strcmp(argv[1], commands[i].cmd))
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (!strcmp(argv[1], commands[i].cmd)) {
+			if (get_super_prefix() &&
+			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
+				die("%s doesn't support --super-prefix",
+				    commands[i].cmd);
 			return commands[i].fn(argc - 1, argv + 1, prefix);
+		}
+	}
 
 	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
diff --git a/git-submodule.sh b/git-submodule.sh
index 747e934df2..b7e124f340 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,9 +1131,9 @@ cmd_sync()
 	done
 }
 
-cmd_interngitdirs()
+cmd_embedgitdirs()
 {
-	git submodule--helper intern-git-dir "$@"
+	git submodule--helper embed-git-dirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
@@ -1145,7 +1145,7 @@ cmd_interngitdirs()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync | interngitdirs)
+	add | foreach | init | deinit | update | status | summary | sync | embedgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/git.c b/git.c
index efa1059fe0..98dcf6c518 100644
--- a/git.c
+++ b/git.c
@@ -493,7 +493,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
diff --git a/submodule.c b/submodule.c
index 99befdba85..d330b567a3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1269,22 +1269,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void migrate_submodule_gitdir(const char *path)
+void migrate_submodule_gitdir(const char *prefix, const char *path,
+			      int recursive)
 {
 	char *old_git_dir;
 	const char *new_git_dir;
 	const struct submodule *sub;
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-	cp.dir = path;
-	argv_array_pushl(&cp.args, "submodule", "foreach", "--recursive",
-			"git", "submodule--helper" "intern-git-dir", NULL);
-
-	if (run_command(&cp))
-		die(_("Could not migrate git directory in submodule '%s'"),
-		    path);
 
 	old_git_dir = xstrfmt("%s/.git", path);
 	if (read_gitfile(old_git_dir))
@@ -1295,14 +1285,46 @@ void migrate_submodule_gitdir(const char *path)
 	if (!sub)
 		die(_("Could not lookup name for submodule '%s'"),
 		      path);
+
 	new_git_dir = git_common_path("modules/%s", sub->name);
-	mkdir_in_gitdir(".git/modules");
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+
+	if (!prefix)
+		prefix = get_super_prefix();
+	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
+		prefix ? prefix : "", path,
+		real_path(old_git_dir), new_git_dir);
 
 	if (rename(old_git_dir, new_git_dir) < 0)
 		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
 			old_git_dir, new_git_dir);
 
 	connect_work_tree_and_git_dir(path, new_git_dir);
+
 out:
+	if (recursive) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (get_super_prefix())
+			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, path);
+		strbuf_addch(&sb, '/');
+
+		cp.dir = path;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
+					    "submodule--helper",
+					   "embed-git-dirs", NULL);
+		prepare_submodule_repo_env(&cp.env_array);
+		if (run_command(&cp))
+			die(_("Could not migrate git directory in submodule '%s'"),
+			    path);
+
+		strbuf_release(&sb);
+	}
+
 	free(old_git_dir);
 }
diff --git a/submodule.h b/submodule.h
index 859026ecfa..e5975d1f3d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -75,5 +75,6 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
-extern void migrate_submodule_gitdir(const char *path);
+extern void migrate_submodule_gitdir(const char *prefix,
+				     const char *path, int recursive);
 #endif
diff --git a/t/t7412-submodule-embedgitdirs.sh b/t/t7412-submodule-embedgitdirs.sh
new file mode 100755
index 0000000000..3153dbc069
--- /dev/null
+++ b/t/t7412-submodule-embedgitdirs.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='Test submodule embedgitdirs
+
+This test verifies that `git submodue embedgitdirs` moves a submodules git
+directory into the superproject.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a real submodule' '
+	git init sub1 &&
+	test_commit -C sub1 first &&
+	git submodule add ./sub1 &&
+	test_tick &&
+	git commit -m superproject
+'
+
+test_expect_success 'embed the git dir' '
+	>expect.1 &&
+	>expect.2 &&
+	>actual.1 &&
+	>actual.2 &&
+	git status >expect.1 &&
+	git -C sub1 rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
+	git fsck &&
+	test -f sub1/.git &&
+	test -d .git/modules/sub1 &&
+	git status >actual.1 &&
+	git -C sub1 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup nested submodule' '
+	git init sub1/nested &&
+	test_commit -C sub1/nested first_nested &&
+	git -C sub1 submodule add ./nested &&
+	test_tick &&
+	git -C sub1 commit -m "add nested" &&
+	git add sub1 &&
+	git commit -m "sub1 to include nested submodule"
+'
+
+test_expect_success 'embed the git dir in a nested submodule' '
+	git status >expect.1 &&
+	git -C sub1/nested rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
+	test -f sub1/nested/.git &&
+	test -d .git/modules/sub1/modules/nested &&
+	git status >actual.1 &&
+	git -C sub1/nested rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup a gitlink with missing .gitmodules entry' '
+	git init sub2 &&
+	test_commit -C sub2 first &&
+	git add sub2 &&
+	git commit -m superproject
+'
+
+test_expect_success 'embedding the git dir fails for incomplete submodules' '
+	git status >expect.1 &&
+	git -C sub2 rev-parse HEAD >expect.2 &&
+	test_must_fail git submodule embedgitdirs &&
+	git -C sub2 fsck &&
+	test -d sub2/.git &&
+	git status >actual &&
+	git -C sub2 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_done
+
diff --git a/t/t7412-submodule-interngitdirs.sh b/t/t7412-submodule-interngitdirs.sh
deleted file mode 100755
index 709359155d..0000000000
--- a/t/t7412-submodule-interngitdirs.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
-
-test_description='Test submodule interngitdirs
-
-This test verifies that `git submodue interngitdirs` moves a submodules git
-directory into the superproject.
-'
-
-. ./test-lib.sh
-
-test_expect_success 'setup a real submodule' '
-	git init sub1 &&
-	test_commit -C sub1 first &&
-	git submodule add ./sub1 &&
-	test_tick &&
-	git commit -m superproject
-'
-
-test_expect_success 'intern the git dir' '
-	git submodule interngitdirs &&
-	test -f sub1/.git &&
-	test -d .git/modules/sub1 &&
-	# check that we did not break the repository:
-	git status
-'
-
-test_expect_success 'setup a gitlink with missing .gitmodules entry' '
-	git init sub2 &&
-	test_commit -C sub2 first &&
-	git add sub2 &&
-	git commit -m superproject
-'
-
-test_expect_success 'intern the git dir fails for incomplete submodules' '
-	test_must_fail git submodule interngitdirs &&
-	# check that we did not break the repository:
-	git status
-'
-
-test_done



-- 
2.11.0.rc2.4.g3396b6f.dirty

