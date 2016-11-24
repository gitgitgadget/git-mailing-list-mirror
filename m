Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5163E1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965201AbcKXUzL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 15:55:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:49702 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933643AbcKXUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 15:55:09 -0500
Received: from virtualbox ([95.208.59.199]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld0fQ-1caaM31KDo-00iCJp; Thu, 24
 Nov 2016 21:55:03 +0100
Date:   Thu, 24 Nov 2016 21:55:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3 0/2] Show Git Mailing List: a builtin difftool
In-Reply-To: <cover.1479938494.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1480019834.git.johannes.schindelin@gmx.de>
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lm9AYg6gtFX/c+2gg5OLnj/0oIdDoj83/ChxOQ5oX9N95hGC1D3
 BIOZ109x54iu6S/GZPhielD+scMRpvnXw9wwUFnmWPM4N4+v/oENC6+2QTceWXdhY1oVMa0
 ib+jLZUB5AKZVrEI4ZPyvcVLzj0e5w1jQtI3z5b0SgF0YHNZPRiWIlHIxK7UitiYDz/tSH6
 NALDu/stKqV15zw7E4hXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MG68d44D0v4=:WTKvnexLpXeVqCJA0a+Au8
 kT+Jj8Jks0WS504GJDVk84nRh0Tk2lnidWRwbspYWmaxGd5ZwEsq8eOApefmQoIJu0A7i6Ll4
 QB97ERVWRzWOBqU7RWdLRUxgk2wUFrwu20ImveU4w2j/mWmj7MdU5eAEogYABmGzVGnyDuNK1
 Lcc4rHAgQOFffhQ+26I+XO6wOs/CZOfNv2Z2QBHw2C+neFjLYMUjNXAZAEm8MWROjvao8L9eg
 WIWkwix8XQzQA5tDjwwKuBrlNCyjQD8RedtVDlF5RS6pd3sR9C/W/Dhmn75+YaB/8abnVwPfP
 Sf5Es5kT8SUx0gEVw5o7mV9vqNnYRvtIsjnBPhWZR2xqYO1lPWrvEddyHa0bYqLXmlxf3BwCu
 2RUFjRaY7KZb9VK3V4vEDmUf/Th54g0EmA8O24pa5x02wKi38RTQktj32dcqV4ZzJozugoWjS
 AIDpqWkoeHMJ2zulSQizIB/6+EnFjLRfoInw1Jj6PQp+KwygDzGEY3CDNhHSENbt6XtKJ6kzH
 HxL3+2GUA/X6yFfFdOqjrY8MjZha5/Z51cC8Iejb1qGNJKByBN06iuUVzKlwJgUeAXF0owv6O
 /l2ITwZ6YiuSMitPewI5LcF3fu0OlQ3DSi4nFZ0XPkwSt7FFPQ2HHjnYWbNb6CIbDmAefhxYE
 A/PujkP0cY4GYqRSsLs9kHUArU/78xVbt6VdOG9B4qSMgKN31CdQ4IOfX/rkxHx362NIuUeKu
 jrLP0I7nII8qjLaWsRtkCB2IBWQzaCaqOcRMvcarhvy2gbFqGo3JwdrF5SI/iwhN9eozIwOcT
 8EWURsj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been working on the builtin difftool for almost two weeks,
for two reasons:

1. Perl is really not native on Windows. Not only is there a performance
   penalty to be paid just for running Perl scripts, we also have to deal
   with the fact that users may have different Perl installations, with
   different options, and some other Perl installation may decide to set
   PERL5LIB globally, wreaking havoc with Git for Windows' Perl (which we
   have to use because almost all other Perl distributions lack the
   Subversion bindings we need for `git svn`).

2. Perl makes for a rather large reason that Git for Windows' installer
   weighs in with >30MB. While one Perl script less does not relieve us
   of that burden, it is one step in the right direction.

This patch serves two purposes: to ask for reviews, and to show what I
plan to release as part of Git for Windows v2.11.0 (which is due this
coming Wednesday, if Git v2.11.0 is released on Tuesday, as planned).

Changes since v2:

- adjusted the config setting's name according to Junio's concerns

- fixed launching difftool in a subdirectory

- fixed dir-diff mode when there are no changes (it did not exit early
  but tried to diff two empty directories)


Johannes Schindelin (2):
  difftool: add a skeleton for the upcoming builtin
  difftool: implement the functionality in the builtin

 .gitignore                                    |   1 +
 Makefile                                      |   3 +-
 builtin.h                                     |   1 +
 builtin/difftool.c                            | 731 ++++++++++++++++++++++++++
 git-difftool.perl => git-legacy-difftool.perl |   0
 git.c                                         |   6 +
 t/t7800-difftool.sh                           |   2 +
 7 files changed, 743 insertions(+), 1 deletion(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)


base-commit: e2b2d6a172b76d44cb7b1ddb12ea5bfac9613a44
Published-As: https://github.com/dscho/git/releases/tag/builtin-difftool-v3
Fetch-It-Via: git fetch https://github.com/dscho/git builtin-difftool-v3

Interdiff vs v2:

 diff --git a/builtin/difftool.c b/builtin/difftool.c
 index f845879..3480920 100644
 --- a/builtin/difftool.c
 +++ b/builtin/difftool.c
 @@ -13,17 +13,16 @@
   */
  #include "cache.h"
  #include "builtin.h"
 -#include "parse-options.h"
  #include "run-command.h"
 +#include "exec_cmd.h"
 +#include "parse-options.h"
  #include "argv-array.h"
  #include "strbuf.h"
  #include "lockfile.h"
  #include "dir.h"
 -#include "exec_cmd.h"
  
  static char *diff_gui_tool;
  static int trust_exit_code;
 -static int use_builtin_difftool;
  
  static const char *const builtin_difftool_usage[] = {
  	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
 @@ -42,11 +41,6 @@ static int difftool_config(const char *var, const char *value, void *cb)
  		return 0;
  	}
  
 -	if (!strcmp(var, "core.usebuiltindifftool")) {
 -		use_builtin_difftool = git_config_bool(var, value);
 -		return 0;
 -	}
 -
  	return git_default_config(var, value, cb);
  }
  
 @@ -257,7 +251,7 @@ static int ensure_leading_directories(char *path)
  	}
  }
  
 -static int run_dir_diff(const char *extcmd, int symlinks,
 +static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
  			int argc, const char **argv)
  {
  	char tmpdir[PATH_MAX];
 @@ -283,7 +277,6 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  	struct hashmap wt_modified, tmp_modified;
  	int indices_loaded = 0;
  
 -	setup_work_tree();
  	workdir = get_git_work_tree();
  
  	/* Setup temp directories */
 @@ -323,6 +316,7 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  	child.git_cmd = 1;
  	child.use_shell = 0;
  	child.clean_on_exit = 1;
 +	child.dir = prefix;
  	child.out = -1;
  	argv_array_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
  			 NULL);
 @@ -333,6 +327,7 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  	fp = xfdopen(child.out, "r");
  
  	/* Build index info for left and right sides of the diff */
 +	i = 0;
  	while (!strbuf_getline_nul(&info, fp)) {
  		int lmode, rmode;
  		struct object_id loid, roid;
 @@ -353,6 +348,7 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  		src_path = lpath.buf;
  		src_path_len = lpath.len;
  
 +		i++;
  		if (status != 'C' && status != 'R') {
  			dst_path = src_path;
  			dst_path_len = src_path_len;
 @@ -456,11 +452,15 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  			}
  		}
  	}
 +
  	if (finish_command(&child)) {
  		ret = error("error occurred running diff --raw");
  		goto finish;
  	}
  
 +	if (!i)
 +		return 0;
 +
  	/*
  	 * Changes to submodules require special treatment.This loop writes a
  	 * temporary file to both the left and right directories to show the
 @@ -591,7 +591,8 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  	return ret;
  }
  
 -static int run_file_diff(int prompt, int argc, const char **argv)
 +static int run_file_diff(int prompt, const char *prefix,
 +			 int argc, const char **argv)
  {
  	struct argv_array args = ARGV_ARRAY_INIT;
  	const char *env[] = {
 @@ -605,14 +606,39 @@ static int run_file_diff(int prompt, int argc, const char **argv)
  	else if (!prompt)
  		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
  
 +
  	argv_array_push(&args, "diff");
  	for (i = 0; i < argc; i++)
  		argv_array_push(&args, argv[i]);
 -	ret = run_command_v_opt_cd_env(args.argv, RUN_GIT_CMD, NULL, env);
 +	ret = run_command_v_opt_cd_env(args.argv, RUN_GIT_CMD, prefix, env);
  	exit(ret);
  }
  
 -int cmd_difftool(int argc, const char ** argv, const char * prefix)
 +/*
 + * NEEDSWORK: this function can go once the legacy-difftool Perl script is
 + * retired.
 + *
 + * We intentionally avoid reading the config directly here, to avoid messing up
 + * the GIT_* environment variables when we need to fall back to exec()ing the
 + * Perl script.
 + */
 +static int use_builtin_difftool(void) {
 +	struct child_process cp = CHILD_PROCESS_INIT;
 +	struct strbuf out = STRBUF_INIT;
 +	int ret;
 +
 +	argv_array_pushl(&cp.args,
 +			 "config", "--bool", "difftool.usebuiltin", NULL);
 +	cp.git_cmd = 1;
 +	if (capture_command(&cp, &out, 6))
 +		return 0;
 +	strbuf_trim(&out);
 +	ret = !strcmp("true", out.buf);
 +	strbuf_release(&out);
 +	return ret;
 +}
 +
 +int cmd_difftool(int argc, const char **argv, const char *prefix)
  {
  	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
  	    tool_help = 0;
 @@ -643,16 +669,29 @@ int cmd_difftool(int argc, const char ** argv, const char * prefix)
  		OPT_END()
  	};
  
 -	git_config(difftool_config, NULL);
 -	symlinks = has_symlinks;
 -	if (!use_builtin_difftool) {
 -		const char *path = mkpath("%s/git-legacy-difftool", git_exec_path());
 +	/*
 +	 * NEEDSWORK: Once the builtin difftool has been tested enough
 +	 * and git-legacy-difftool.perl is retired to contrib/, this preamble
 +	 * can be removed.
 +	 */
 +	if (!use_builtin_difftool()) {
 +		const char *path = mkpath("%s/git-legacy-difftool",
 +					  git_exec_path());
  
  		if (sane_execvp(path, (char **)argv) < 0)
  			die_errno("could not exec %s", path);
  
  		return 0;
  	}
 +	prefix = setup_git_directory();
 +	trace_repo_setup(prefix);
 +	setup_work_tree();
 +	/* NEEDSWORK: once we no longer spawn anything, remove this */
 +	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 +	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 +
 +	git_config(difftool_config, NULL);
 +	symlinks = has_symlinks;
  
  	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
  			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
 @@ -687,6 +726,6 @@ int cmd_difftool(int argc, const char ** argv, const char * prefix)
  	 * each file that changed.
  	 */
  	if (dir_diff)
 -		return run_dir_diff(extcmd, symlinks, argc, argv);
 -	return run_file_diff(prompt, argc, argv);
 +		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
 +	return run_file_diff(prompt, prefix, argc, argv);
  }
 diff --git a/git.c b/git.c
 index e68b6eb..a8e6a15 100644
 --- a/git.c
 +++ b/git.c
 @@ -424,7 +424,12 @@ static struct cmd_struct commands[] = {
  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
  	{ "diff-index", cmd_diff_index, RUN_SETUP },
  	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 -	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
 +	/*
 +	 * NEEDSWORK: Once the redirection to git-legacy-difftool.perl in
 +	 * builtin/difftool.c has been removed, this entry should be changed to
 +	 * RUN_SETUP | NEED_WORK_TREE
 +	 */
 +	{ "difftool", cmd_difftool },
  	{ "fast-export", cmd_fast_export, RUN_SETUP },
  	{ "fetch", cmd_fetch, RUN_SETUP },
  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
 index 70a2de4..b6a6c30 100755
 --- a/t/t7800-difftool.sh
 +++ b/t/t7800-difftool.sh
 @@ -23,6 +23,8 @@ prompt_given ()
  	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
  }
  
 +# NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
 +
  # Create a file on master and change it on branch
  test_expect_success PERL 'setup' '
  	echo master >file &&

-- 
2.10.1.583.g721a9e0

