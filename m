Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0651FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbcKWWDT (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:03:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:50294 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbcKWWDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:03:17 -0500
Received: from virtualbox ([89.204.155.1]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHso5-1cB3ju3PBN-003bM9; Wed, 23
 Nov 2016 23:03:11 +0100
Date:   Wed, 23 Nov 2016 23:03:10 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 0/1] Show Git Mailing List: a builtin difftool
In-Reply-To: <cover.1479834051.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1479938494.git.johannes.schindelin@gmx.de>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eCZ0XWuEi8nT3zSfRLgOMD3Z0ndM8RZe5w3ikGWWu1wQXTuxjIl
 BVbSL3QKGsiWeaJalgV8GItB3+3eheX5S05yoprX/yXNuari7/CDKYFLDosRv05bQEVpalK
 br5f1cq40mXDN9oabEE+l6HF80g/fpc8/Yup9W+JMClZ4wKYJpRFTv7ENp1m+BbXcTgGDyp
 9OYX/SOX3BJMe0nJV8vYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LiIvl0h5D7c=:/jUqQ5MKx6AIogP7EY0nyU
 Ge0eTWHbBTXumEPFC+spZEoubWKvfBZpRf4RVQ7bNPz4M6WTcjqaFLsknt+e5Uo8vK491pti0
 wjU9ksXUsybB9aSX3IUCkP+vZQNFzYPzBB3KJRW8xX1hq5Y8SSLC38KDI7os47sjEJrRLkYPu
 t2YxKwMKyWMx3Yx6x872qVUeO1sTTujGLKJaIQl6j/qVRdVZBB8terfm7hpEnC9rcccbHFKwB
 XxdWuRP5rdaT3hRWvSpC9MbW+69WyOiuO48mNRXZzkDrpEbitJU2UUb3j7P5y4Rts3yDPhtAx
 B5GydachEKyKTuC22Eg/XQx2F+yUSTfbZHDqEZtxI3DIin+weneD22wHnxOzuS5N91gXeRHuY
 uAWZN8svadJxR199ccJGCoR8za9WG0UfKYYU3oy4DKTCF9kQrdzUGIc/rQ6XwdameT/ewMfqM
 YBT6Netw3Gz8feH2s/ut5iuf0NHH5aDAXSL+WTKdsyEg7rkJjmhDZWjtzM85UkeLQsHwajClu
 nAf1SK6WOg3TyN2vIKDC/LbU69Il9ZcJAvt82B9W2S3jxIpLGVZMpzZF4PbmGW3ty4FlwhjGh
 AavKlXyupKO4nI6LC329HCR1G9hmpL9sNRgrPSE83feLZolZo7c/uQep+zdVfwBDhUZceMJmi
 evsiR58HW9KCPvtyq7ZfrG9ce4RmRKqSWC/4AQEG1rDeamUQsjBWHzhBd58FMaTe8PR2U47/u
 GcODEvdd4FxySeEbVRUMvh6584stKJwymODwLvlVHiQCa5OG9dOv/cnOLVU8OPDe7zgIWHDgb
 tbx0FYz
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

Changes since v1:

- fixed the usage (pointed out by David Aguilar)

- moved the stray #include "dir.h" to cuddle with the other #include's
  (also pointed out by David Aguilar)

- changed the `sprintf()` call to a much safer `xsnprintf()` call
  (again, pointed out by David Aguilar)

- changed an error message to include the offending path (need I say,
  pointed out by David Aguilar?)

- used more restrictive permissions for the temporary directories (once
  again, David Aguilar's suggestion)

- fixed a comment that lacked a space after a period (another fix thanks
  to David Aguilar).

- switched the opt-in feature flag triggering the use of the builtin
  difftool to a config variable (this suggestion came from Junio
  Hamano).

- made difftool respect core.symlinks by moving the usage of
  has_symlinks after the config was parsed.


Johannes Schindelin (1):
  difftool: add the builtin

 .gitignore                                    |   1 +
 Makefile                                      |   3 +-
 builtin.h                                     |   1 +
 builtin/difftool.c                            | 692 ++++++++++++++++++++++++++
 git-difftool.perl => git-legacy-difftool.perl |   0
 git.c                                         |   1 +
 6 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)


base-commit: 1e37181391e305a7ab0c382ca3c3b2de998d4138
Published-As: https://github.com/dscho/git/releases/tag/builtin-difftool-v2
Fetch-It-Via: git fetch https://github.com/dscho/git builtin-difftool-v2

Interdiff vs v1:

 diff --git a/.gitignore b/.gitignore
 index 91bfd09..f96e50e 100644
 --- a/.gitignore
 +++ b/.gitignore
 @@ -1,4 +1,3 @@
 -/use-builtin-difftool
  /GIT-BUILD-OPTIONS
  /GIT-CFLAGS
  /GIT-LDFLAGS
 @@ -52,7 +51,6 @@
  /git-diff-tree
  /git-difftool
  /git-difftool--helper
 -/git-builtin-difftool
  /git-describe
  /git-fast-export
  /git-fast-import
 @@ -78,6 +76,7 @@
  /git-init-db
  /git-interpret-trailers
  /git-instaweb
 +/git-legacy-difftool
  /git-log
  /git-ls-files
  /git-ls-remote
 diff --git a/Makefile b/Makefile
 index f764174..7863bc2 100644
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
 @@ -888,7 +888,7 @@ BUILTIN_OBJS += builtin/diff-files.o
  BUILTIN_OBJS += builtin/diff-index.o
  BUILTIN_OBJS += builtin/diff-tree.o
  BUILTIN_OBJS += builtin/diff.o
 -BUILTIN_OBJS += builtin/builtin-difftool.o
 +BUILTIN_OBJS += builtin/difftool.o
  BUILTIN_OBJS += builtin/fast-export.o
  BUILTIN_OBJS += builtin/fetch-pack.o
  BUILTIN_OBJS += builtin/fetch.o
 diff --git a/builtin.h b/builtin.h
 index 409a61e..67f8051 100644
 --- a/builtin.h
 +++ b/builtin.h
 @@ -60,7 +60,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
  extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
  extern int cmd_diff(int argc, const char **argv, const char *prefix);
  extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 -extern int cmd_builtin_difftool(int argc, const char **argv, const char *prefix);
 +extern int cmd_difftool(int argc, const char **argv, const char *prefix);
  extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
  extern int cmd_fetch(int argc, const char **argv, const char *prefix);
  extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 diff --git a/builtin/builtin-difftool.c b/builtin/difftool.c
 similarity index 95%
 rename from builtin/builtin-difftool.c
 rename to builtin/difftool.c
 index 9feefcd..f845879 100644
 --- a/builtin/builtin-difftool.c
 +++ b/builtin/difftool.c
 @@ -18,12 +18,15 @@
  #include "argv-array.h"
  #include "strbuf.h"
  #include "lockfile.h"
 +#include "dir.h"
 +#include "exec_cmd.h"
  
  static char *diff_gui_tool;
  static int trust_exit_code;
 +static int use_builtin_difftool;
  
 -static const char * const builtin_difftool_usage[] = {
 -	N_("git add [<options>] [--] <pathspec>..."),
 +static const char *const builtin_difftool_usage[] = {
 +	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
  	NULL
  };
  
 @@ -39,6 +42,11 @@ static int difftool_config(const char *var, const char *value, void *cb)
  		return 0;
  	}
  
 +	if (!strcmp(var, "core.usebuiltindifftool")) {
 +		use_builtin_difftool = git_config_bool(var, value);
 +		return 0;
 +	}
 +
  	return git_default_config(var, value, cb);
  }
  
 @@ -227,8 +235,6 @@ static void changed_files(struct hashmap *result, const char *index_path,
  	strbuf_release(&buf);
  }
  
 -#include "dir.h"
 -
  static NORETURN void exit_cleanup(const char *tmpdir, int exit_code)
  {
  	struct strbuf buf = STRBUF_INIT;
 @@ -282,16 +288,16 @@ static int run_dir_diff(const char *extcmd, int symlinks,
  
  	/* Setup temp directories */
  	tmp = getenv("TMPDIR");
 -	sprintf(tmpdir, "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
 +	xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
  	if (!mkdtemp(tmpdir))
 -		return error("could not create temporary directory");
 +		return error("could not create '%s'", tmpdir);
  	strbuf_addf(&ldir, "%s/left/", tmpdir);
  	strbuf_addf(&rdir, "%s/right/", tmpdir);
  	strbuf_addstr(&wtdir, workdir);
  	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
  		strbuf_addch(&wtdir, '/');
 -	mkdir(ldir.buf, 0777);
 -	mkdir(rdir.buf, 0777);
 +	mkdir(ldir.buf, 0700);
 +	mkdir(rdir.buf, 0700);
  
  	memset(&wtindex, 0, sizeof(wtindex));
  
 @@ -606,12 +612,11 @@ static int run_file_diff(int prompt, int argc, const char **argv)
  	exit(ret);
  }
  
 -int cmd_builtin_difftool(int argc, const char ** argv, const char * prefix)
 +int cmd_difftool(int argc, const char ** argv, const char * prefix)
  {
  	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
  	    tool_help = 0;
  	static char *difftool_cmd = NULL, *extcmd = NULL;
 -
  	struct option builtin_difftool_options[] = {
  		OPT_BOOL('g', "gui", &use_gui_tool,
  			 N_("use `diff.guitool` instead of `diff.tool`")),
 @@ -638,9 +643,16 @@ int cmd_builtin_difftool(int argc, const char ** argv, const char * prefix)
  		OPT_END()
  	};
  
 +	git_config(difftool_config, NULL);
  	symlinks = has_symlinks;
 +	if (!use_builtin_difftool) {
 +		const char *path = mkpath("%s/git-legacy-difftool", git_exec_path());
  
 -	git_config(difftool_config, NULL);
 +		if (sane_execvp(path, (char **)argv) < 0)
 +			die_errno("could not exec %s", path);
 +
 +		return 0;
 +	}
  
  	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
  			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
 @@ -670,7 +682,7 @@ int cmd_builtin_difftool(int argc, const char ** argv, const char * prefix)
  
  	/*
  	 * In directory diff mode, 'git-difftool--helper' is called once
 -	 * to compare the a / b directories.In file diff mode, 'git diff'
 +	 * to compare the a / b directories. In file diff mode, 'git diff'
  	 * will invoke a separate instance of 'git-difftool--helper' for
  	 * each file that changed.
  	 */
 diff --git a/git-difftool.perl b/git-legacy-difftool.perl
 similarity index 98%
 rename from git-difftool.perl
 rename to git-legacy-difftool.perl
 index 28e47d8..a5790d0 100755
 --- a/git-difftool.perl
 +++ b/git-legacy-difftool.perl
 @@ -23,13 +23,6 @@ use File::Temp qw(tempdir);
  use Getopt::Long qw(:config pass_through);
  use Git;
  
 -if (-e Git::exec_path() . '/use-builtin-difftool') {
 -	unshift(@ARGV, "builtin-difftool");
 -	unshift(@ARGV, "git");
 -	exec(@ARGV);
 -	die("Could not execute builtin difftool");
 -}
 -
  sub usage
  {
  	my $exitcode = shift;
 diff --git a/git.c b/git.c
 index 7a0df7a..0e6bbee 100644
 --- a/git.c
 +++ b/git.c
 @@ -2,7 +2,6 @@
  #include "exec_cmd.h"
  #include "help.h"
  #include "run-command.h"
 -#include "dir.h"
  
  const char git_usage_string[] =
  	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 @@ -425,7 +424,7 @@ static struct cmd_struct commands[] = {
  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
  	{ "diff-index", cmd_diff_index, RUN_SETUP },
  	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 -	{ "builtin-difftool", cmd_builtin_difftool, RUN_SETUP | NEED_WORK_TREE },
 +	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
  	{ "fast-export", cmd_fast_export, RUN_SETUP },
  	{ "fetch", cmd_fetch, RUN_SETUP },
  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 @@ -543,22 +542,6 @@ static void strip_extension(const char **argv)
  #define strip_extension(cmd)
  #endif
  
 -static int use_builtin_difftool(void)
 -{
 -	static int initialized, use;
 -
 -	if (!initialized) {
 -		struct strbuf buf = STRBUF_INIT;
 -		strbuf_addf(&buf, "%s/%s", git_exec_path(),
 -			    "use-builtin-difftool");
 -		use = file_exists(buf.buf);
 -		strbuf_release(&buf);
 -		initialized = 1;
 -	}
 -
 -	return use;
 -}
 -
  static void handle_builtin(int argc, const char **argv)
  {
  	struct argv_array args = ARGV_ARRAY_INIT;
 @@ -568,9 +551,6 @@ static void handle_builtin(int argc, const char **argv)
  	strip_extension(argv);
  	cmd = argv[0];
  
 -	if (!strcmp("difftool", cmd) && use_builtin_difftool())
 -		cmd = "builtin-difftool";
 -
  	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
  	if (argc > 1 && !strcmp(argv[1], "--help")) {
  		int i;

-- 
2.10.1.583.g721a9e0

