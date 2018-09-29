Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A951F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeI2V7U (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:59:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38445 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeI2V7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:59:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so8451467ljc.5
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obzqILY1jSXaRgnlPClulAmNzoajnaQjhnHkrh/DY4c=;
        b=n7JXEZODVRzhAbSVYlaZyNQhqz6WybPABGj+vuR8MFVbSZJqjB/ZBt8xnuhu+1KZyb
         dchChQGWuPQyQWiG9yPxREjZPHs0EDVhTUEz/bJ2YQvdrOAHkLQqyXO34UoLZoDEQwQV
         gX9ceXLvf56rX4rgmSKJafEPC0t90m6m3aK26lbs9uzmzR/KWqeyDLVYNB5O1CqdxhoV
         J8TeyWjFEV0gkHRG/81NOUwPKXvfMphSxbd9F7w3bGHKpJl56H7NXZZKoOFCqafXgSZk
         ANKLFpWzAkFeyobfAutEH/R8KDmrT13bmwFQA/w82QrN55fjEE7rQqCkTK4TqAfqcfE/
         9EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obzqILY1jSXaRgnlPClulAmNzoajnaQjhnHkrh/DY4c=;
        b=js+Er1zcEUDjwqDeDoXTDj7HrZdR/Yxjj3yve24x3GO8AQKwqB3a9xeNpw0ff+VgBj
         lbz7+qYZgtZcu2iJGZ21295WfDzlyAPzRllVpVtU/lxcrrh9lcO8G0JWLq4WqYxlDbev
         qvuCE9wcMoO8Czk96B8LpU2MZx+Jk5TzXTIp8+EDzXJVDDcRReAaANvyy6oZR5YqbMVX
         UgadB5IrQ/6sDeB2ahlbKts+rXm/AqqcEmT4CE+2ESJpFhOEMxgNfjM/Rz59p/8AYuiG
         9+23MrhEknqJE/O/lb2EdyKWJGs+TbNLM2k1XeFrYUzdh2CawP8rvQWHBH5kge8NT+wo
         aQvg==
X-Gm-Message-State: ABuFfoiAtC52T8iEMKmipKS7GVrHywZGllB6WbRAlS1WozgrFmGiEO7T
        NnSJ3csCkfbVI5zaf1594M8=
X-Google-Smtp-Source: ACcGV63k6rqpkAxLBlii82TEO7SmlTeAeo2eHqiH3ZNFozn41yPQd5EvZax+tUKUWI9PMuztk8xi3Q==
X-Received: by 2002:a2e:20da:: with SMTP id g87-v6mr1771006lji.88.1538235025541;
        Sat, 29 Sep 2018 08:30:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1600899lfj.39.2018.09.29.08.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:30:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 2/2] worktree: add per-worktree config files
Date:   Sat, 29 Sep 2018 17:30:05 +0200
Message-Id: <20180929153005.10599-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929153005.10599-1-pclouds@gmail.com>
References: <20180923170438.23610-1-pclouds@gmail.com>
 <20180929153005.10599-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new repo extension is added, worktreeConfig. When it is present:

 - Repository config reading by default includes $GIT_DIR/config _and_
   $GIT_DIR/config.worktree. "config" file remains shared in multiple
   worktree setup.

 - The special treatment for core.bare and core.worktree, to stay
   effective only in main worktree, is gone. These config settings are
   supposed to be in config.worktree.

This extension is most useful in multiple worktree setup because you
now have an option to store per-worktree config (which is either
.git/config.worktree for main worktree, or
.git/worktrees/xx/config.worktree for linked ones).

This extension can be used in single worktree mode, even though it's
pretty much useless (but this can happen after you remove all linked
worktrees and move back to single worktree).

"git config" reads from both "config" and "config.worktree" by default
(i.e. without either --user, --file...) when this extension is
present. Default writes still go to "config", not "config.worktree". A
new option --worktree is added for that (*).

Since a new repo extension is introduced, existing git binaries should
refuse to access to the repo (both from main and linked worktrees). So
they will not misread the config file (i.e. skip the config.worktree
part). They may still accidentally write to the config file anyway if
they use with "git config --file <path>".

This design places a bet on the assumption that the majority of config
variables are shared so it is the default mode. A safer move would be
default writes go to per-worktree file, so that accidental changes are
isolated.

(*) "git config --worktree" points back to "config" file when this
    extension is not present and there is only one worktree so that it
    works in any both single and multiple worktree setups.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt               | 12 +++-
 Documentation/git-config.txt           | 26 ++++++---
 Documentation/git-worktree.txt         | 30 ++++++++++
 Documentation/gitrepository-layout.txt |  8 +++
 builtin/config.c                       | 19 ++++++-
 cache.h                                |  2 +
 config.c                               | 11 ++++
 environment.c                          |  1 +
 setup.c                                | 40 ++++++++++---
 t/t2029-worktree-config.sh             | 79 ++++++++++++++++++++++++++
 10 files changed, 210 insertions(+), 18 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d85d1a324..44407e69db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,8 +2,9 @@ CONFIGURATION FILE
 ------------------
 
 The Git configuration file contains a number of variables that affect
-the Git commands' behavior. The `.git/config` file in each repository
-is used to store the configuration for that repository, and
+the Git commands' behavior. The files `.git/config` and optionally
+`config.worktree` (see `extensions.worktreeConfig` below) in each
+repository is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
@@ -371,6 +372,13 @@ advice.*::
 		editor input from the user.
 --
 
+extensions.worktreeConfig::
+	If set, by default "git config" reads from both "config" and
+	"config.worktree" file from GIT_DIR in that order. In
+	multiple working directory mode, "config" file is shared while
+	"config.worktree" is per-working directory (i.e., it's in
+	GIT_COMMON_DIR/worktrees/<id>/config.worktree)
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8e240435be..4870e00b89 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -45,13 +45,15 @@ unset an existing `--type` specifier with `--no-type`.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-`--system`, `--global`, `--local` and `--file <filename>` can be
-used to tell the command to read from only that location (see <<FILES>>).
+`--system`, `--global`, `--local`, `--worktree` and
+`--file <filename>` can be used to tell the command to read from only
+that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
 configuration file by default, and options `--system`, `--global`,
-`--file <filename>` can be used to tell the command to write to
-that location (you can say `--local` but that is the default).
+`--worktree`, `--file <filename>` can be used to tell the command to
+write to that location (you can say `--local` but that is the
+default).
 
 This command will fail with non-zero status upon error.  Some exit
 codes are:
@@ -131,6 +133,11 @@ from all available files.
 +
 See also <<FILES>>.
 
+--worktree::
+	Similar to `--local` except that `.git/config.worktree` is
+	read from or written to if `extensions.worktreeConfig` is
+	present. If not it's the same as `--local`.
+
 -f config-file::
 --file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
@@ -281,6 +288,10 @@ $XDG_CONFIG_HOME/git/config::
 $GIT_DIR/config::
 	Repository specific configuration file.
 
+$GIT_DIR/config.worktree::
+	This is optional and is only searched when
+	`extensions.worktreeConfig` is present in $GIT_DIR/config.
+
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
@@ -299,9 +310,10 @@ configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
 You can override these rules either by command-line options or by environment
-variables. The `--global` and the `--system` options will limit the file used
-to the global or system-wide file respectively. The `GIT_CONFIG` environment
-variable has a similar effect, but you can specify any filename you want.
+variables. The `--global`, `--system` and `--worktree` options will limit
+the file used to the global, system-wide or per-worktree file respectively.
+The `GIT_CONFIG` environment variable has a similar effect, but you
+can specify any filename you want.
 
 
 ENVIRONMENT
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e2ee9fc21b..aa88278dde 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -204,6 +204,36 @@ working trees, it can be used to identify worktrees. For example if
 you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.
 
+CONFIGURATION FILE
+------------------
+By default, the repository "config" file is shared across all working
+trees. If the config variables `core.bare` or `core.worktree` are
+already present in the config file, they will be applied to the main
+working trees only.
+
+In order to have configuration specific to working trees, you can turn
+on "worktreeConfig" extension, e.g.:
+
+------------
+$ git config extensions.worktreeConfig true
+------------
+
+In this mode, specific configuration stays in the path pointed by `git
+rev-parse --git-path config.worktree`. You can add or update
+configuration in this file with `git config --worktree`. Older Git
+versions may will refuse to access repositories with this extension.
+
+Note that in this file, the exception for `core.bare` and `core.worktree`
+is gone. If you have them in $GIT_DIR/config before, you must move
+them to the `config.worktree` of the main working tree. You may also
+take this opportunity to review and move other configuration that you
+do not want to share to all working trees:
+
+ - `core.worktree` and `core.bare` should never be shared
+
+ - `core.sparseCheckout` is recommended per working tree, unless you
+   are sure you always use sparse checkout for all working trees.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index e85148f05e..36fcca8087 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -143,6 +143,11 @@ config::
 	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
 
+config.worktree::
+	Working directory specific configuration file for the main
+	working directory in multiple working directory setup (see
+	linkgit:git-worktree[1]).
+
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -275,6 +280,9 @@ worktrees/<id>/locked::
 	or manually by `git worktree prune`. The file may contain a string
 	explaining why the repository is locked.
 
+worktrees/<id>/config.worktree::
+	Working directory specific configuration file.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/config.c b/builtin/config.c
index 97b58c4aea..84385ef165 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "worktree.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -24,6 +25,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
+static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
@@ -123,6 +125,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
@@ -602,6 +605,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + use_local_config +
+	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error(_("only one config file at a time"));
 		usage_builtin_config();
@@ -645,7 +649,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.file = git_etc_gitconfig();
 	else if (use_local_config)
 		given_config_source.file = git_pathdup("config");
-	else if (given_config_source.file) {
+	else if (use_worktree_config) {
+		struct worktree **worktrees = get_worktrees(0);
+		if (repository_format_worktree_config)
+			given_config_source.file = git_pathdup("config.worktree");
+		else if (worktrees[0] && worktrees[1])
+			die(_("--worktree cannot be used with multiple "
+			      "working trees unless the config\n"
+			      "extension worktreeConfig is enabled. "
+			      "Please read \"CONFIGURATION FILE\"\n"
+			      "section in \"git help worktree\" for details"));
+		else
+			given_config_source.file = git_pathdup("config");
+		free_worktrees(worktrees);
+	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				prefix_filename(prefix, given_config_source.file);
diff --git a/cache.h b/cache.h
index d508f3d4f8..9e9b917e99 100644
--- a/cache.h
+++ b/cache.h
@@ -957,11 +957,13 @@ extern int grafts_replace_parents;
 extern int repository_format_precious_objects;
 extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
+extern int repository_format_worktree_config;
 
 struct repository_format {
 	int version;
 	int precious_objects;
 	char *partial_clone; /* value of extensions.partialclone */
+	int worktree_config;
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
diff --git a/config.c b/config.c
index 3461993f0a..b3025164d2 100644
--- a/config.c
+++ b/config.c
@@ -1695,6 +1695,17 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
+	/*
+	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
+	 * But let's not complicate things before it's actually needed.
+	 */
+	if (repository_format_worktree_config) {
+		char *path = git_pathdup("config.worktree");
+		if (!access_or_die(path, R_OK, 0))
+			ret += git_config_from_file(fn, path, data);
+		free(path);
+	}
+
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
 	if (git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
diff --git a/environment.c b/environment.c
index 3f3c8746c2..268310b3dc 100644
--- a/environment.c
+++ b/environment.c
@@ -33,6 +33,7 @@ int ref_paranoia = -1;
 int repository_format_precious_objects;
 char *repository_format_partial_clone;
 const char *core_partial_clone_filter_default;
+int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index b24c811c1c..1be5037f12 100644
--- a/setup.c
+++ b/setup.c
@@ -402,6 +402,20 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static int read_worktree_config(const char *var, const char *value, void *vdata)
+{
+	struct repository_format *data = vdata;
+
+	if (strcmp(var, "core.bare") == 0) {
+		data->is_bare = git_config_bool(var, value);
+	} else if (strcmp(var, "core.worktree") == 0) {
+		if (!value)
+			return config_error_nonbool(var);
+		data->work_tree = xstrdup(value);
+	}
+	return 0;
+}
+
 static int check_repo_format(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -423,16 +437,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else
+		} else if (!strcmp(ext, "worktreeconfig"))
+			data->worktree_config = git_config_bool(var, value);
+		else
 			string_list_append(&data->unknown_extensions, ext);
-	} else if (strcmp(var, "core.bare") == 0) {
-		data->is_bare = git_config_bool(var, value);
-	} else if (strcmp(var, "core.worktree") == 0) {
-		if (!value)
-			return config_error_nonbool(var);
-		data->work_tree = xstrdup(value);
 	}
-	return 0;
+
+	return read_worktree_config(var, value, vdata);
 }
 
 static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
@@ -466,7 +477,20 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 	repository_format_precious_objects = candidate->precious_objects;
 	repository_format_partial_clone = candidate->partial_clone;
+	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
+
+	if (repository_format_worktree_config) {
+		/*
+		 * pick up core.bare and core.worktree from per-worktree
+		 * config if present
+		 */
+		strbuf_addf(&sb, "%s/config.worktree", gitdir);
+		git_config_from_file(read_worktree_config, sb.buf, candidate);
+		strbuf_release(&sb);
+		has_common = 0;
+	}
+
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
 			is_bare_repository_cfg = candidate->is_bare;
diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
new file mode 100755
index 0000000000..286121d8de
--- /dev/null
+++ b/t/t2029-worktree-config.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description="config file in multi worktree"
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit start
+'
+
+test_expect_success 'config --worktree in single worktree' '
+	git config --worktree foo.bar true &&
+	test_cmp_config true foo.bar
+'
+
+test_expect_success 'add worktrees' '
+	git worktree add wt1 &&
+	git worktree add wt2
+'
+
+test_expect_success 'config --worktree without extension' '
+	test_must_fail git config --worktree foo.bar false
+'
+
+test_expect_success 'enable worktreeConfig extension' '
+	git config extensions.worktreeConfig true &&
+	test_cmp_config true extensions.worktreeConfig
+'
+
+test_expect_success 'config is shared as before' '
+	git config this.is shared &&
+	test_cmp_config shared this.is &&
+	test_cmp_config -C wt1 shared this.is &&
+	test_cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config is shared (set from another worktree)' '
+	git -C wt1 config that.is also-shared &&
+	test_cmp_config also-shared that.is &&
+	test_cmp_config -C wt1 also-shared that.is &&
+	test_cmp_config -C wt2 also-shared that.is
+'
+
+test_expect_success 'config private to main worktree' '
+	git config --worktree this.is for-main &&
+	test_cmp_config for-main this.is &&
+	test_cmp_config -C wt1 shared this.is &&
+	test_cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config private to linked worktree' '
+	git -C wt1 config --worktree this.is for-wt1 &&
+	test_cmp_config for-main this.is &&
+	test_cmp_config -C wt1 for-wt1 this.is &&
+	test_cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'core.bare no longer for main only' '
+	test_config core.bare true &&
+	test "$(git rev-parse --is-bare-repository)" = true &&
+	test "$(git -C wt1 rev-parse --is-bare-repository)" = true &&
+	test "$(git -C wt2 rev-parse --is-bare-repository)" = true
+'
+
+test_expect_success 'per-worktree core.bare is picked up' '
+	git -C wt1 config --worktree core.bare true &&
+	test "$(git rev-parse --is-bare-repository)" = false &&
+	test "$(git -C wt1 rev-parse --is-bare-repository)" = true &&
+	test "$(git -C wt2 rev-parse --is-bare-repository)" = false
+'
+
+test_expect_success 'config.worktree no longer read without extension' '
+	git config --unset extensions.worktreeConfig &&
+	test_cmp_config shared this.is &&
+	test_cmp_config -C wt1 shared this.is &&
+	test_cmp_config -C wt2 shared this.is
+'
+
+test_done
-- 
2.19.0.341.g3acb95d729

