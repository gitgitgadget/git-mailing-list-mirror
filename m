Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB531FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755787AbcKWWDn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:03:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:56493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcKWWDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:03:41 -0500
Received: from virtualbox ([89.204.155.1]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqzEB-1ceJUH3XD1-00eYoB; Wed, 23
 Nov 2016 23:03:31 +0100
Date:   Wed, 23 Nov 2016 23:03:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 1/1] difftool: add the builtin
In-Reply-To: <cover.1479938494.git.johannes.schindelin@gmx.de>
Message-ID: <3e9a2f31c779476c7524849a2e5307f2d3396fe8.1479938494.git.johannes.schindelin@gmx.de>
References: <cover.1479834051.git.johannes.schindelin@gmx.de> <cover.1479938494.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4zYCH2AWWGHbCo7j5SX1SSGyTVNzclCopsV0iZkMnTF23eg7FSW
 xqjshQrmkUdfXhLZSf6JHmV+vQaNM8+ieCn3xAIOyhTJChoOFiQMNvnbTO6oxlR9iTfUpda
 oPI6Wacp0drsCYnfSzj81xYpzAuMsTIqqPHHmCrjwavQsJ3Lnfp6rPYeDWKmvvcxTq58+Ni
 fPJoq2FULMhZstRLQh66Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tdtOTOZGlaE=:4LIcMT06SL2PXvVBfqKhQ5
 kycTQ2GH+QDDqyDNhLX3XD7PNzlGGBgKbwEW+JOznUfmjGGyHcnou/ZoGc2ZcxGI6a4h4vuTt
 DQMBLONF1EKc6jdGCY3rF0BwVrr+pXHsZ1Vv/vQjsWray6nLWJh/RrrGfIE+XBgsiRHRkswZQ
 xOdeX0VQJ/dspFMXs3T/hquGV8AQmiR4gaBPN0ecSlotkrycl3jBSxrnqemm3uVuQ1WSe6+kC
 SWCrJQ/LYLCbdVP+7mR9OxaGQYjnC7Q/hr1awQjupKTbLjbZSqaB+Iv35qAr+aK9RJ+Mziva/
 FWTl243So91bOe+L2DdNS5G0DK7WbYnL3pS1H1gKaWytfnvC9kkhHsW8V22ZOYCAn25zjGbGj
 yk0ULhY14S9UijWXLCbFBJtwakeSNqUXDalcfJY1swNOFfvXyjbA6i1VwqS5b/C/8bGZKizDG
 l2xmwTkF/dog71nVDOtY+PASQUrVqONcrA9DXfMqiOALiFFQdmsQ1ICbT+y8TuaZt4p0z9JbB
 lRLU5oEKpWY0UAuyzbylIi9Ozh8vwziyi5cjLwLpTmwL3e2mC5LOm0ATDnBxxGad8rWoCMBcf
 3FDqkqiDBWby0HkVs6TkCcAhxb7Xm80kotdVXQrIOYszvQ/l6d1aLBfuqgd+VOac3GU3TrAtP
 JkhkEHgw3JUlx2kWaedT6lL563cW/qTeNLyFp2bVdf2+tdqsrEkXoOP/D6Gw7sLIQshydgc5c
 gJ2lj+pc3PGZke6yWVFjf5RoHTpDkDZZw5Hpq9mgGvazoaMwCUxg13GnoyI2wQ0die/+UQiTq
 D0BZTBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a builtin difftool that represents a conversion of the current
Perl script version of the difftool.

The motivation is that Perl scripts are not at all native on Windows,
and that `git difftool` therefore is pretty slow on that platform, when
there is no good reason for it to be slow.

In addition, Perl does not really have access to Git's internals. That
means that any script will always have to jump through unnecessary
hoops.

The current version of the builtin difftool does not, however, make full
use of the internals but instead chooses to spawn a couple of Git
processes, still, to make for an easier conversion. There remains a lot
of room for improvement, left for a later date.

Note: the original difftool is now called `git legacy-difftool`, but to
play it safe, it is still called by difftool unless the config setting
core.useBuiltinDifftool=true.

The reason: this new, experimental, builtin difftool will be shipped as
part of Git for Windows v2.11.0, to allow for easier large-scale
testing, but of course as an opt-in feature.

Sadly, the speedup is more noticable on Linux than on Windows: a quick
test shows that t7800-difftool.sh runs in (2.183s/0.052s/0.108s)
(real/user/sys) in a Linux VM, down from  (6.529s/3.112s/0.644s), while
on Windows, it is (36.064s/2.730s/7.194s), down from
(47.637s/2.407s/6.863s). The culprit is most likely the overhead
incurred from *still* having to shell out to mergetool-lib.sh and
difftool--helper.sh.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                    |   1 +
 Makefile                                      |   3 +-
 builtin.h                                     |   1 +
 builtin/difftool.c                            | 692 ++++++++++++++++++++++++++
 git-difftool.perl => git-legacy-difftool.perl |   0
 git.c                                         |   1 +
 6 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)

diff --git a/.gitignore b/.gitignore
index 05cb58a..f96e50e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-legacy-difftool
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index f53fcc9..7863bc2 100644
--- a/Makefile
+++ b/Makefile
@@ -527,7 +527,7 @@ SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
 SCRIPT_PERL += git-add--interactive.perl
-SCRIPT_PERL += git-difftool.perl
+SCRIPT_PERL += git-legacy-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
@@ -888,6 +888,7 @@ BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
+BUILTIN_OBJS += builtin/difftool.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
diff --git a/builtin.h b/builtin.h
index b9122bc..67f8051 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_difftool(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/difftool.c b/builtin/difftool.c
new file mode 100644
index 0000000..f845879
--- /dev/null
+++ b/builtin/difftool.c
@@ -0,0 +1,692 @@
+/*
+ * "git difftool" builtin command
+ *
+ * This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
+ * git-difftool--helper script.
+ *
+ * This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
+ * The GIT_DIFF* variables are exported for use by git-difftool--helper.
+ *
+ * Any arguments that are unknown to this script are forwarded to 'git diff'.
+ *
+ * Copyright (C) 2016 Johannes Schindelin
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "strbuf.h"
+#include "lockfile.h"
+#include "dir.h"
+#include "exec_cmd.h"
+
+static char *diff_gui_tool;
+static int trust_exit_code;
+static int use_builtin_difftool;
+
+static const char *const builtin_difftool_usage[] = {
+	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
+	NULL
+};
+
+static int difftool_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "diff.guitool")) {
+		diff_gui_tool = xstrdup(value);
+		return 0;
+	}
+
+	if (!strcmp(var, "difftool.trustexitcode")) {
+		trust_exit_code = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.usebuiltindifftool")) {
+		use_builtin_difftool = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
+static int print_tool_help(void)
+{
+	const char *argv[] = { "mergetool", "--tool-help=diff", NULL };
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int parse_index_info(char *p, int *mode1, int *mode2,
+			    struct object_id *oid1, struct object_id *oid2,
+			    char *status)
+{
+	if (*p != ':')
+		return error("expected ':', got '%c'", *p);
+	*mode1 = (int)strtol(p + 1, &p, 8);
+	if (*p != ' ')
+		return error("expected ' ', got '%c'", *p);
+	*mode2 = (int)strtol(p + 1, &p, 8);
+	if (*p != ' ')
+		return error("expected ' ', got '%c'", *p);
+	if (get_oid_hex(++p, oid1))
+		return error("expected object ID, got '%s'", p + 1);
+	p += GIT_SHA1_HEXSZ;
+	if (*p != ' ')
+		return error("expected ' ', got '%c'", *p);
+	if (get_oid_hex(++p, oid2))
+		return error("expected object ID, got '%s'", p + 1);
+	p += GIT_SHA1_HEXSZ;
+	if (*p != ' ')
+		return error("expected ' ', got '%c'", *p);
+	*status = *++p;
+	if (!status || p[1])
+		return error("unexpected trailer: '%s'", p);
+	return 0;
+}
+
+/*
+ * Remove any trailing slash from $workdir
+ * before starting to avoid double slashes in symlink targets.
+ */
+static void add_path(struct strbuf *buf, size_t base_len, const char *path)
+{
+	strbuf_setlen(buf, base_len);
+	if (buf->len && buf->buf[buf->len - 1] != '/')
+		strbuf_addch(buf, '/');
+	strbuf_addstr(buf, path);
+}
+
+/*
+ * Determine whether we can simply reuse the file in the worktree.
+ */
+static int use_wt_file(const char *workdir, const char *name,
+		       struct object_id *oid)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct stat st;
+	int use = 0;
+
+	strbuf_addstr(&buf, workdir);
+	add_path(&buf, buf.len, name);
+
+	if (!lstat(buf.buf, &st) && !S_ISLNK(st.st_mode)) {
+		struct object_id wt_oid;
+		int fd = open(buf.buf, O_RDONLY);
+
+		if (!index_fd(wt_oid.hash, fd, &st, OBJ_BLOB, name, 0)) {
+			if (is_null_oid(oid)) {
+				oidcpy(oid, &wt_oid);
+				use = 1;
+			} else if (!oidcmp(oid, &wt_oid))
+				use = 1;
+		}
+	}
+
+	strbuf_release(&buf);
+
+	return use;
+}
+
+struct working_tree_entry {
+	struct hashmap_entry entry;
+	char path[FLEX_ARRAY];
+};
+
+static int working_tree_entry_cmp(struct working_tree_entry *a,
+				  struct working_tree_entry *b, void *keydata)
+{
+	return strcmp(a->path, b->path);
+}
+
+/*
+ * The `left` and `right` entries hold paths for the symlinks hashmap,
+ * and a SHA-1 surrounded by brief text for submodules.
+ */
+struct pair_entry {
+	struct hashmap_entry entry;
+	char left[PATH_MAX], right[PATH_MAX];
+	const char path[FLEX_ARRAY];
+};
+
+static int pair_cmp(struct pair_entry *a, struct pair_entry *b, void *keydata)
+{
+	return strcmp(a->path, b->path);
+}
+
+static void add_left_or_right(struct hashmap *map, const char *path,
+			      const char *content, int is_right)
+{
+	struct pair_entry *e, *existing;
+
+	FLEX_ALLOC_STR(e, path, path);
+	hashmap_entry_init(e, strhash(path));
+	existing = hashmap_get(map, e, NULL);
+	if (existing) {
+		free(e);
+		e = existing;
+	} else {
+		e->left[0] = e->right[0] = '\0';
+		hashmap_add(map, e);
+	}
+	strcpy(is_right ? e->right : e->left, content);
+}
+
+struct path_entry {
+	struct hashmap_entry entry;
+	char path[FLEX_ARRAY];
+};
+
+int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
+{
+	return strcmp(a->path, key ? key : b->path);
+}
+
+static void changed_files(struct hashmap *result, const char *index_path,
+			  const char *workdir)
+{
+	struct child_process update_index = CHILD_PROCESS_INIT;
+	struct child_process diff_files = CHILD_PROCESS_INIT;
+	struct strbuf index_env = STRBUF_INIT, buf = STRBUF_INIT;
+	const char *git_dir = absolute_path(get_git_dir()), *env[] = {
+		NULL, NULL
+	};
+	FILE *fp;
+
+	strbuf_addf(&index_env, "GIT_INDEX_FILE=%s", index_path);
+	env[0] = index_env.buf;
+
+	argv_array_pushl(&update_index.args,
+			 "--git-dir", git_dir, "--work-tree", workdir,
+			 "update-index", "--really-refresh", "-q",
+			 "--unmerged", NULL);
+	update_index.no_stdin = 1;
+	update_index.no_stdout = 1;
+	update_index.no_stderr = 1;
+	update_index.git_cmd = 1;
+	update_index.use_shell = 0;
+	update_index.clean_on_exit = 1;
+	update_index.dir = workdir;
+	update_index.env = env;
+	/* Ignore any errors of update-index */
+	run_command(&update_index);
+
+	argv_array_pushl(&diff_files.args,
+			 "--git-dir", git_dir, "--work-tree", workdir,
+			 "diff-files", "--name-only", "-z", NULL);
+	diff_files.no_stdin = 1;
+	diff_files.git_cmd = 1;
+	diff_files.use_shell = 0;
+	diff_files.clean_on_exit = 1;
+	diff_files.out = -1;
+	diff_files.dir = workdir;
+	diff_files.env = env;
+	if (start_command(&diff_files))
+		die("could not obtain raw diff");
+	fp = xfdopen(diff_files.out, "r");
+	while (!strbuf_getline_nul(&buf, fp)) {
+		struct path_entry *entry;
+		FLEX_ALLOC_STR(entry, path, buf.buf);
+		hashmap_entry_init(entry, strhash(buf.buf));
+		hashmap_add(result, entry);
+	}
+	if (finish_command(&diff_files))
+		die("diff-files did not exit properly");
+	strbuf_release(&index_env);
+	strbuf_release(&buf);
+}
+
+static NORETURN void exit_cleanup(const char *tmpdir, int exit_code)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr(&buf, tmpdir);
+	remove_dir_recursively(&buf, 0);
+	if (exit_code)
+		warning(_("failed: %d"), exit_code);
+	exit(exit_code);
+}
+
+static int ensure_leading_directories(char *path)
+{
+	switch (safe_create_leading_directories(path)) {
+		case SCLD_OK:
+		case SCLD_EXISTS:
+			return 0;
+		default:
+			return error(_("could not create leading directories "
+				       "of '%s'"), path);
+	}
+}
+
+static int run_dir_diff(const char *extcmd, int symlinks,
+			int argc, const char **argv)
+{
+	char tmpdir[PATH_MAX];
+	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
+	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;
+	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
+	struct strbuf wtdir = STRBUF_INIT;
+	size_t ldir_len, rdir_len, wtdir_len;
+	struct cache_entry *ce = xcalloc(1, sizeof(ce) + PATH_MAX + 1);
+	const char *workdir, *tmp;
+	int ret = 0, i;
+	FILE *fp;
+	struct hashmap working_tree_dups, submodules, symlinks2;
+	struct hashmap_iter iter;
+	struct pair_entry *entry;
+	enum object_type type;
+	unsigned long size;
+	struct index_state wtindex;
+	struct checkout lstate, rstate;
+	int rc, flags = RUN_GIT_CMD, err = 0;
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
+	struct hashmap wt_modified, tmp_modified;
+	int indices_loaded = 0;
+
+	setup_work_tree();
+	workdir = get_git_work_tree();
+
+	/* Setup temp directories */
+	tmp = getenv("TMPDIR");
+	xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
+	if (!mkdtemp(tmpdir))
+		return error("could not create '%s'", tmpdir);
+	strbuf_addf(&ldir, "%s/left/", tmpdir);
+	strbuf_addf(&rdir, "%s/right/", tmpdir);
+	strbuf_addstr(&wtdir, workdir);
+	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
+		strbuf_addch(&wtdir, '/');
+	mkdir(ldir.buf, 0700);
+	mkdir(rdir.buf, 0700);
+
+	memset(&wtindex, 0, sizeof(wtindex));
+
+	memset(&lstate, 0, sizeof(lstate));
+	lstate.base_dir = ldir.buf;
+	lstate.base_dir_len = ldir.len;
+	lstate.force = 1;
+	memset(&rstate, 0, sizeof(rstate));
+	rstate.base_dir = rdir.buf;
+	rstate.base_dir_len = rdir.len;
+	rstate.force = 1;
+
+	ldir_len = ldir.len;
+	rdir_len = rdir.len;
+	wtdir_len = wtdir.len;
+
+	hashmap_init(&working_tree_dups,
+		     (hashmap_cmp_fn)working_tree_entry_cmp, 0);
+	hashmap_init(&submodules, (hashmap_cmp_fn)pair_cmp, 0);
+	hashmap_init(&symlinks2, (hashmap_cmp_fn)pair_cmp, 0);
+
+	child.no_stdin = 1;
+	child.git_cmd = 1;
+	child.use_shell = 0;
+	child.clean_on_exit = 1;
+	child.out = -1;
+	argv_array_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
+			 NULL);
+	for (i = 0; i < argc; i++)
+		argv_array_push(&child.args, argv[i]);
+	if (start_command(&child))
+		die("could not obtain raw diff");
+	fp = xfdopen(child.out, "r");
+
+	/* Build index info for left and right sides of the diff */
+	while (!strbuf_getline_nul(&info, fp)) {
+		int lmode, rmode;
+		struct object_id loid, roid;
+		char status;
+		const char *src_path, *dst_path;
+		size_t src_path_len, dst_path_len;
+
+		if (starts_with(info.buf, "::"))
+			die(N_("combined diff formats('-c' and '--cc') are "
+			       "not supported in\n"
+			       "directory diff mode('-d' and '--dir-diff')."));
+
+		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
+				     &status))
+			break;
+		if (strbuf_getline_nul(&lpath, fp))
+			break;
+		src_path = lpath.buf;
+		src_path_len = lpath.len;
+
+		if (status != 'C' && status != 'R') {
+			dst_path = src_path;
+			dst_path_len = src_path_len;
+		} else {
+			if (strbuf_getline_nul(&rpath, fp))
+				break;
+			dst_path = rpath.buf;
+			dst_path_len = rpath.len;
+		}
+
+		if (S_ISGITLINK(lmode) || S_ISGITLINK(rmode)) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "Subproject commit %s",
+				    oid_to_hex(&loid));
+			add_left_or_right(&submodules, src_path, buf.buf, 0);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "Subproject commit %s",
+				    oid_to_hex(&roid));
+			if (!oidcmp(&loid, &roid))
+				strbuf_addstr(&buf, "-dirty");
+			add_left_or_right(&submodules, dst_path, buf.buf, 1);
+			continue;
+		}
+
+		if (S_ISLNK(lmode)) {
+			char *content = read_sha1_file(loid.hash, &type, &size);
+			add_left_or_right(&symlinks2, src_path, content, 0);
+			free(content);
+		}
+
+		if (S_ISLNK(rmode)) {
+			char *content = read_sha1_file(roid.hash, &type, &size);
+			add_left_or_right(&symlinks2, dst_path, content, 1);
+			free(content);
+		}
+
+		if (lmode && status != 'C') {
+			ce->ce_mode = lmode;
+			oidcpy(&ce->oid, &loid);
+			strcpy(ce->name, src_path);
+			ce->ce_namelen = src_path_len;
+			if (checkout_entry(ce, &lstate, NULL))
+				return error("could not write '%s'", src_path);
+		}
+
+		if (rmode) {
+			struct working_tree_entry *entry;
+
+			/* Avoid duplicate working_tree entries */
+			FLEX_ALLOC_STR(entry, path, dst_path);
+			hashmap_entry_init(entry, strhash(dst_path));
+			if (hashmap_get(&working_tree_dups, entry, NULL)) {
+				free(entry);
+				continue;
+			}
+			hashmap_add(&working_tree_dups, entry);
+
+			if (!use_wt_file(workdir, dst_path, &roid)) {
+				ce->ce_mode = rmode;
+				oidcpy(&ce->oid, &roid);
+				strcpy(ce->name, dst_path);
+				ce->ce_namelen = dst_path_len;
+				if (checkout_entry(ce, &rstate, NULL))
+					return error("could not write '%s'",
+						     dst_path);
+			} else if (!is_null_oid(&roid)) {
+				/*
+				 * Changes in the working tree need special
+				 * treatment since they are not part of the
+				 * index.
+				 */
+				struct cache_entry *ce2 =
+					make_cache_entry(rmode, roid.hash,
+							 dst_path, 0, 0);
+				ce_mode_from_stat(ce2, rmode);
+
+				add_index_entry(&wtindex, ce2,
+						ADD_CACHE_JUST_APPEND);
+
+				add_path(&wtdir, wtdir_len, dst_path);
+				add_path(&rdir, rdir_len, dst_path);
+				if (ensure_leading_directories(rdir.buf))
+					return error("could not create "
+						     "directory for '%s'",
+						     dst_path);
+				if (symlinks) {
+					if (symlink(wtdir.buf, rdir.buf)) {
+						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
+						goto finish;
+					}
+				} else {
+					struct stat st;
+					if (stat(wtdir.buf, &st))
+						st.st_mode = 0644;
+					if (copy_file(rdir.buf, wtdir.buf,
+						      st.st_mode)) {
+						ret = error("could not copy '%s' to '%s'", wtdir.buf, rdir.buf);
+						goto finish;
+					}
+				}
+			}
+		}
+	}
+	if (finish_command(&child)) {
+		ret = error("error occurred running diff --raw");
+		goto finish;
+	}
+
+	/*
+	 * Changes to submodules require special treatment.This loop writes a
+	 * temporary file to both the left and right directories to show the
+	 * change in the recorded SHA1 for the submodule.
+	 */
+	hashmap_iter_init(&submodules, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (*entry->left) {
+			add_path(&ldir, ldir_len, entry->path);
+			ensure_leading_directories(ldir.buf);
+			write_file(ldir.buf, "%s", entry->left);
+		}
+		if (*entry->right) {
+			add_path(&rdir, rdir_len, entry->path);
+			ensure_leading_directories(rdir.buf);
+			write_file(rdir.buf, "%s", entry->right);
+		}
+	}
+
+	/*
+	 * Symbolic links require special treatment.The standard "git diff"
+	 * shows only the link itself, not the contents of the link target.
+	 * This loop replicates that behavior.
+	 */
+	hashmap_iter_init(&symlinks2, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (*entry->left) {
+			add_path(&ldir, ldir_len, entry->path);
+			ensure_leading_directories(ldir.buf);
+			write_file(ldir.buf, "%s", entry->left);
+		}
+		if (*entry->right) {
+			add_path(&rdir, rdir_len, entry->path);
+			ensure_leading_directories(rdir.buf);
+			write_file(rdir.buf, "%s", entry->right);
+		}
+	}
+
+	strbuf_release(&buf);
+
+	strbuf_setlen(&ldir, ldir_len);
+	helper_argv[1] = ldir.buf;
+	strbuf_setlen(&rdir, rdir_len);
+	helper_argv[2] = rdir.buf;
+
+	if (extcmd) {
+		helper_argv[0] = extcmd;
+		flags = 0;
+	} else
+		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
+	rc = run_command_v_opt(helper_argv, flags);
+
+	/*
+	 * If the diff includes working copy files and those
+	 * files were modified during the diff, then the changes
+	 * should be copied back to the working tree.
+	 * Do not copy back files when symlinks are used and the
+	 * external tool did not replace the original link with a file.
+	 *
+	 * These hashes are loaded lazily since they aren't needed
+	 * in the common case of --symlinks and the difftool updating
+	 * files through the symlink.
+	 */
+	hashmap_init(&wt_modified, (hashmap_cmp_fn)path_entry_cmp,
+		     wtindex.cache_nr);
+	hashmap_init(&tmp_modified, (hashmap_cmp_fn)path_entry_cmp,
+		     wtindex.cache_nr);
+
+	for (i = 0; i < wtindex.cache_nr; i++) {
+		struct hashmap_entry dummy;
+		const char *name = wtindex.cache[i]->name;
+		struct stat st;
+
+		add_path(&rdir, rdir_len, name);
+		if (lstat(rdir.buf, &st))
+			continue;
+
+		if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
+			continue;
+
+		if (!indices_loaded) {
+			static struct lock_file lock;
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s/wtindex", tmpdir);
+			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
+			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
+				ret = error("could not write %s", buf.buf);
+				rollback_lock_file(&lock);
+				goto finish;
+			}
+			changed_files(&wt_modified, buf.buf, workdir);
+			strbuf_setlen(&rdir, rdir_len);
+			changed_files(&tmp_modified, buf.buf, rdir.buf);
+			add_path(&rdir, rdir_len, name);
+			indices_loaded = 1;
+		}
+
+		hashmap_entry_init(&dummy, strhash(name));
+		if (hashmap_get(&tmp_modified, &dummy, name)) {
+			add_path(&wtdir, wtdir_len, name);
+			if (hashmap_get(&wt_modified, &dummy, name)) {
+				warning(_("both files modified: '%s' and '%s'."),
+					wtdir.buf, rdir.buf);
+				warning(_("working tree file has been left."));
+				warning("");
+				err = 1;
+			} else if (unlink(wtdir.buf) ||
+				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
+				warning_errno(_("could not copy '%s' to '%s'"),
+					      rdir.buf, wtdir.buf);
+		}
+	}
+
+	if (err) {
+		warning(_("temporary files exist in '%s'."), tmpdir);
+		warning(_("you may want to cleanup or recover these."));
+		exit(1);
+	} else
+		exit_cleanup(tmpdir, rc);
+
+finish:
+	free(ce);
+	strbuf_release(&ldir);
+	strbuf_release(&rdir);
+	strbuf_release(&wtdir);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+static int run_file_diff(int prompt, int argc, const char **argv)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *env[] = {
+		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
+		NULL
+	};
+	int ret = 0, i;
+
+	if (prompt > 0)
+		env[2] = "GIT_DIFFTOOL_PROMPT=true";
+	else if (!prompt)
+		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
+
+	argv_array_push(&args, "diff");
+	for (i = 0; i < argc; i++)
+		argv_array_push(&args, argv[i]);
+	ret = run_command_v_opt_cd_env(args.argv, RUN_GIT_CMD, NULL, env);
+	exit(ret);
+}
+
+int cmd_difftool(int argc, const char ** argv, const char * prefix)
+{
+	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
+	    tool_help = 0;
+	static char *difftool_cmd = NULL, *extcmd = NULL;
+	struct option builtin_difftool_options[] = {
+		OPT_BOOL('g', "gui", &use_gui_tool,
+			 N_("use `diff.guitool` instead of `diff.tool`")),
+		OPT_BOOL('d', "dir-diff", &dir_diff,
+			 N_("perform a full-directory diff")),
+		{ OPTION_SET_INT, 'y', "no-prompt", &prompt, NULL,
+			N_("do not prompt before launching a diff tool"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		{ OPTION_SET_INT, 0, "prompt", &prompt, NULL, NULL,
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
+			NULL, 1 },
+		OPT_BOOL(0, "symlinks", &symlinks,
+			 N_("use symlinks in dir-diff mode")),
+		OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
+			   N_("use the specified diff tool")),
+		OPT_BOOL(0, "tool-help", &tool_help,
+			 N_("print a list of diff tools that may be used with "
+			    "`--tool`")),
+		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
+			 N_("make 'git-difftool' exit when an invoked diff "
+			    "tool returns a non - zero exit code")),
+		OPT_STRING('x', "extcmd", &extcmd, N_("<command>"),
+			   N_("specify a custom command for viewing diffs")),
+		OPT_END()
+	};
+
+	git_config(difftool_config, NULL);
+	symlinks = has_symlinks;
+	if (!use_builtin_difftool) {
+		const char *path = mkpath("%s/git-legacy-difftool", git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+
+		return 0;
+	}
+
+	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
+			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (tool_help)
+		return print_tool_help();
+
+	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
+		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
+	else if (difftool_cmd) {
+		if (*difftool_cmd)
+			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
+		else
+			die(_("no <tool> given for --tool=<tool>"));
+	}
+
+	if (extcmd) {
+		if (*extcmd)
+			setenv("GIT_DIFFTOOL_EXTCMD", extcmd, 1);
+		else
+			die(_("no <cmd> given for --extcmd=<cmd>"));
+	}
+
+	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
+	       trust_exit_code ? "true" : "false", 1);
+
+	/*
+	 * In directory diff mode, 'git-difftool--helper' is called once
+	 * to compare the a / b directories. In file diff mode, 'git diff'
+	 * will invoke a separate instance of 'git-difftool--helper' for
+	 * each file that changed.
+	 */
+	if (dir_diff)
+		return run_dir_diff(extcmd, symlinks, argc, argv);
+	return run_file_diff(prompt, argc, argv);
+}
diff --git a/git-difftool.perl b/git-legacy-difftool.perl
similarity index 100%
rename from git-difftool.perl
rename to git-legacy-difftool.perl
diff --git a/git.c b/git.c
index efa1059..0e6bbee 100644
--- a/git.c
+++ b/git.c
@@ -424,6 +424,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "diff-index", cmd_diff_index, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-- 
2.10.1.583.g721a9e0
