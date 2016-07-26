Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56480203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 00:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcGZA7I (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 20:59:08 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33073 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbcGZA7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 20:59:05 -0400
Received: by mail-io0-f176.google.com with SMTP id 38so185938721iol.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 17:59:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ymYMC6s1lLoMqfm+SWuYGRWo037qWr1HuSs+dncL9TA=;
        b=WY9XNg4oCzpzZB409CNpGVCr7/CapE7ful1jzCo26iDyWoSYth3n3FAUjsceisWKf4
         UEhlVejrpOz629/SzDASVcfzWVnjVXtpybuypsYRt3Hr+nvnp3+M+BVNTX9WER3q9ZMl
         ij+ucLAIF3uEIi+Q/qxEy62BiObW8RKXKRzuVMMwrQmhpVqbUmUlawGpTCuQ2qRIlfsl
         SmiyQBCXv3A3RBUJy586gFD+R4qgZc6fXA90n7RQOBYARErrOx5pj55fZJ4J6eqD6rSE
         qUgBLvCEKYnuamriBtxYY/Mtb84SwJ9dv+0yH6J2eZAYyFEarhQT3+FiykpQ1Zvim1Lc
         K3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ymYMC6s1lLoMqfm+SWuYGRWo037qWr1HuSs+dncL9TA=;
        b=Z+k8IpZqURXvkzJuHh3NclI08MQ/bfn2Vmq2azpiYLF2oPIEtSnW17sihN9Ol0hAKC
         9/NM5Cm5Vj3hW7TWW1Im7JPSjtSegZNmOpXivoXDyjyvP/AQM5433Cj8eR479UEQakPq
         +s22QTDMcT9Ew+GunE1GtS9PCwkB6qO1WvnAjZ1nprEad2DVNnJVspp81LHXZE3U/7Qg
         UArC7Cy/Q+vJHgrBsW8p4euEvGp8IaHlPnb34xHVlw6As8o5Cdw1eRLK3MJhBjXTyPyN
         k7CNt/OwMUm9NGS/38r3OasR6cnAh5VOjvJjN+ntbDSnJhxBylghJPb1uzW0OeftwK5N
         eMJg==
X-Gm-Message-State: AEkoousNwQSs7oCo76ijAdIS7hWUMJevWC21y5Gz+xhvghVLofbskVLHSUNtjOg6doNrlV2+YVTeeLpyzF42faRa
X-Received: by 10.107.144.10 with SMTP id s10mr22387623iod.165.1469494744485;
 Mon, 25 Jul 2016 17:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 25 Jul 2016 17:59:03 -0700 (PDT)
In-Reply-To: <20160720172419.25473-2-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-2-pclouds@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 25 Jul 2016 17:59:03 -0700
Message-ID: <CAGZ79kYET=z-b+U-JN+H5jkRTGHR0oMdTfUZPMRJx50aH-idbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] worktree: add per-worktree config files
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:24 AM, Nguyễn Thái Ngọc Duy
<pclouds@gmail.com> wrote:
> A new repo extension is added, worktreeConfig. When it is present:
>
>  - Repository config reading by default includes $GIT_DIR/config _and_
>    $GIT_DIR/config.worktree. "config" file remains shared in multiple
>    worktree setup.
>
>  - The special treatment for core.bare and core.worktree, to stay
>    effective only in main worktree, is gone. These config files are
>    supposed to be in config.worktree.
>
> This extension is most useful in multiple worktree setup because you
> now have an option to store per-worktree config (which is either
> .git/config.worktree for main worktree, or
> .git/worktrees/xx/config.worktree for linked ones).
>
> This extension can be used in single worktree mode, even though it's
> pretty much useless (but this can happen after you remove all linked
> worktrees and move back to single worktree).
>
> "git config" reads from both "config" and "config.worktree" by default
> (i.e. without either --user, --file...) when this extension is
> present. Default writes still go to "config", not "config.worktree". A
> new option --worktree is added for that (*).
>
> Since a new repo extension is introduced, existing git binaries should
> refuse to access to the repo (both from main and linked worktrees). So
> they will not misread the config file (i.e. skip the config.worktree
> part). They may still accidentally write to the config file anyway if
> they use with "git config --file <path>".
>
> This design places a bet on the assumption that the majority of config
> variables are shared so it is the default mode. A safer move would be
> default writes go to per-worktree file, so that accidental changes are
> isolated.
>
> (*) "git config --worktree" points back to "config" file when this
>     extension is not present so that it works in any setup.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

I like the user facing design, but how am I supposed to use it internally?

Say I want to read a value preferably from the worktree I'd do a
    /*
     * maybe I don't even have to set it to 1 as
     * the user is supposed to do that?
     */
    repository_format_worktree_config = 1;
    git_config_get_{string,bool,int} (... as usual ...)

and if I want to read the value globally I would set the variable to 0
and read? (I would need to restore it, so I'll have a temporary variable
to keep the original value of repository_format_worktree_config)

Thanks,
Stefan


> ---
>  Documentation/config.txt               | 11 ++++-
>  Documentation/git-config.txt           | 26 ++++++++----
>  Documentation/git-worktree.txt         | 31 ++++++++++++++
>  Documentation/gitrepository-layout.txt |  8 ++++
>  builtin/config.c                       | 18 +++++++-
>  cache.h                                |  2 +
>  config.c                               |  7 ++++
>  environment.c                          |  1 +
>  setup.c                                |  5 ++-
>  t/t2028-worktree-config.sh (new +x)    | 77 ++++++++++++++++++++++++++++++++++
>  10 files changed, 175 insertions(+), 11 deletions(-)
>  create mode 100755 t/t2028-worktree-config.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 16dc22d..7d64da0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2,8 +2,9 @@ CONFIGURATION FILE
>  ------------------
>
>  The Git configuration file contains a number of variables that affect
> -the Git commands' behavior. The `.git/config` file in each repository
> -is used to store the configuration for that repository, and
> +the Git commands' behavior. The files `.git/config` and optionally
> +`config.worktree` (see `extensions.worktreeConfig` below) are each
> +repository is used to store the configuration for that repository, and
>  `$HOME/.gitconfig` is used to store a per-user configuration as
>  fallback values for the `.git/config` file. The file `/etc/gitconfig`
>  can be used to store a system-wide default configuration.
> @@ -264,6 +265,12 @@ advice.*::
>                 show directions on how to proceed from the current state.
>  --
>
> +extensions.worktreeConfig::
> +       If set, by default "git config" reads from both "config" and
> +       "config.worktree" file in that order. In multiple working
> +       directory mode, "config" file is shared while
> +       "config.worktree" is per-working directory.
> +
>  core.fileMode::
>         Tells Git if the executable bit of files in the working tree
>         is to be honored.
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index f163113..9dfdb6a 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -47,13 +47,15 @@ checks or transformations are performed on the value.
>
>  When reading, the values are read from the system, global and
>  repository local configuration files by default, and options
> -`--system`, `--global`, `--local` and `--file <filename>` can be
> -used to tell the command to read from only that location (see <<FILES>>).
> +`--system`, `--global`, `--local`, `--worktree` and
> +`--file <filename>` can be used to tell the command to read from only
> +that location (see <<FILES>>).
>
>  When writing, the new value is written to the repository local
>  configuration file by default, and options `--system`, `--global`,
> -`--file <filename>` can be used to tell the command to write to
> -that location (you can say `--local` but that is the default).
> +`--worktree`, `--file <filename>` can be used to tell the command to
> +write to that location (you can say `--local` but that is the
> +default).
>
>  This command will fail with non-zero status upon error.  Some exit
>  codes are:
> @@ -133,6 +135,11 @@ from all available files.
>  +
>  See also <<FILES>>.
>
> +--worktree::
> +       Similar to `--local` except that `.git/config.worktree` is
> +       read from or written to if `extensions.worktreeConfig` is
> +       present. If not it's the same as `--local`.
> +
>  -f config-file::
>  --file config-file::
>         Use the given config file instead of the one specified by GIT_CONFIG.
> @@ -253,6 +260,10 @@ $XDG_CONFIG_HOME/git/config::
>  $GIT_DIR/config::
>         Repository specific configuration file.
>
> +$GIT_DIR/config.worktree::
> +       This is optional and is only searched when
> +       `extensions.worktreeConfig` is present in $GIT_DIR/config.
> +
>  If no further options are given, all reading options will read all of these
>  files that are available. If the global or the system-wide configuration
>  file are not available they will be ignored. If the repository configuration
> @@ -268,9 +279,10 @@ configuration file. Note that this also affects options like `--replace-all`
>  and `--unset`. *'git config' will only ever change one file at a time*.
>
>  You can override these rules either by command-line options or by environment
> -variables. The `--global` and the `--system` options will limit the file used
> -to the global or system-wide file respectively. The `GIT_CONFIG` environment
> -variable has a similar effect, but you can specify any filename you want.
> +variables. The `--global`, `--system` and `--worktree` options will limit
> +the file used to the global, system-wide or per-worktree file respectively.
> +The `GIT_CONFIG` environment variable has a similar effect, but you
> +can specify any filename you want.
>
>
>  ENVIRONMENT
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 7c4cfb0..41350db 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -111,6 +111,37 @@ OPTIONS
>  --expire <time>::
>         With `prune`, only expire unused working trees older than <time>.
>
> +CONFIGURATION FILE
> +------------------
> +By default, the repository "config" file is shared across all working
> +directories. If the config variables `core.bare` or `core.worktree`
> +are already present in the config file, they will be applied to the
> +main working directory only.
> +
> +In order to have configuration specific to working directories, you
> +can turn on "worktreeConfig" extension, e.g.:
> +
> +------------
> +$ git config extensions.worktreeConfig true
> +------------
> +
> +In this mode, specific configuration stays in the path pointed by `git
> +rev-parse --git-path config.worktree`. You can add or update
> +configuration in this file with `git config --worktree`. Git before
> +version XXX will refuse to access repositories with this extension.
> +
> +Note that in this file, the exception for `core.bare` and
> +core.worktree` is gone. If you have them before, you need to move them
> +to the config.worktree of the main working directory. You may also
> +take this opportunity to move other configuration that you do not want
> +to share to all working directories:
> +
> + - `core.worktree` and `core.bare` should never be shared
> +
> + - `core.sparseCheckout` is recommended per working directory, unless
> +   you are sure you always use sparse checkout for all working
> +   directories.
> +
>  DETAILS
>  -------
>  Each linked working tree has a private sub-directory in the repository's
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index 577ee84..6cfdb4c 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -143,6 +143,11 @@ config::
>         if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
>         used instead.
>
> +config.worktree::
> +       Working directory specific configuration file for the main
> +       working directory in multiple working directory setup (see
> +       linkgit:git-worktree[1]).
> +
>  branches::
>         A slightly deprecated way to store shorthands to be used
>         to specify a URL to 'git fetch', 'git pull' and 'git push'.
> @@ -276,6 +281,9 @@ worktrees/<id>/link::
>         file. It is used to detect if the linked repository is
>         manually removed.
>
> +worktrees/<id>/config.worktree::
> +       Working directory specific configuration file.
> +
>  SEE ALSO
>  --------
>  linkgit:git-init[1],
> diff --git a/builtin/config.c b/builtin/config.c
> index 1d7c6ef..535707c 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -4,6 +4,7 @@
>  #include "parse-options.h"
>  #include "urlmatch.h"
>  #include "quote.h"
> +#include "worktree.h"
>
>  static const char *const builtin_config_usage[] = {
>         N_("git config [<options>]"),
> @@ -23,6 +24,7 @@ static char key_delim = ' ';
>  static char term = '\n';
>
>  static int use_global_config, use_system_config, use_local_config;
> +static int use_worktree_config;
>  static struct git_config_source given_config_source;
>  static int actions, types;
>  static const char *get_color_slot, *get_colorbool_slot;
> @@ -57,6 +59,7 @@ static struct option builtin_config_options[] = {
>         OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
>         OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
>         OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> +       OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
>         OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
>         OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
>         OPT_GROUP(N_("Action")),
> @@ -491,6 +494,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>
>         if (use_global_config + use_system_config + use_local_config +
> +           use_worktree_config +
>             !!given_config_source.file + !!given_config_source.blob > 1) {
>                 error("only one config file at a time.");
>                 usage_with_options(builtin_config_usage, builtin_config_options);
> @@ -525,7 +529,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 given_config_source.file = git_etc_gitconfig();
>         else if (use_local_config)
>                 given_config_source.file = git_pathdup("config");
> -       else if (given_config_source.file) {
> +       else if (use_worktree_config) {
> +               if (repository_format_worktree_config)
> +                       given_config_source.file = git_pathdup("config.worktree");
> +               else {
> +                       struct worktree **worktrees = get_worktrees();
> +                       if (worktrees[0] && worktrees[1])
> +                               die(_("Per-worktree configuration requires extensions.worktreeConfig\n"
> +                                     "Please read section CONFIGURATION in `git help worktree` before\n"
> +                                     "enabling it."));
> +                       free_worktrees(worktrees);
> +                       given_config_source.file = git_pathdup("config");
> +               }
> +       } else if (given_config_source.file) {
>                 if (!is_absolute_path(given_config_source.file) && prefix)
>                         given_config_source.file =
>                                 xstrdup(prefix_filename(prefix,
> diff --git a/cache.h b/cache.h
> index f1dc289..606500e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -757,10 +757,12 @@ extern int grafts_replace_parents;
>  #define GIT_REPO_VERSION 0
>  #define GIT_REPO_VERSION_READ 1
>  extern int repository_format_precious_objects;
> +extern int repository_format_worktree_config;
>
>  struct repository_format {
>         int version;
>         int precious_objects;
> +       int worktree_config;
>         int is_bare;
>         char *work_tree;
>         struct string_list unknown_extensions;
> diff --git a/config.c b/config.c
> index bea937e..99ff6be 100644
> --- a/config.c
> +++ b/config.c
> @@ -1254,6 +1254,13 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
>         if (repo_config && !access_or_die(repo_config, R_OK, 0))
>                 ret += git_config_from_file(fn, repo_config, data);
>
> +       if (repository_format_worktree_config) {
> +               char *path = git_pathdup("config.worktree");
> +               if (!access_or_die(path, R_OK, 0))
> +                       ret += git_config_from_file(fn, path, data);
> +               free(path);
> +       }
> +
>         current_parsing_scope = CONFIG_SCOPE_CMDLINE;
>         if (git_config_from_parameters(fn, data) < 0)
>                 die(_("unable to parse command-line config"));
> diff --git a/environment.c b/environment.c
> index ca72464..b4d56ef 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -26,6 +26,7 @@ int warn_ambiguous_refs = 1;
>  int warn_on_object_refname_ambiguity = 1;
>  int ref_paranoia = -1;
>  int repository_format_precious_objects;
> +int repository_format_worktree_config;
>  const char *git_commit_encoding;
>  const char *git_log_output_encoding;
>  const char *apply_default_whitespace;
> diff --git a/setup.c b/setup.c
> index 6d0e0c9..75c784f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -389,6 +389,8 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
>                         ;
>                 else if (!strcmp(ext, "preciousobjects"))
>                         data->precious_objects = git_config_bool(var, value);
> +               else if (!strcmp(ext, "worktreeconfig"))
> +                       data->worktree_config = git_config_bool(var, value);
>                 else
>                         string_list_append(&data->unknown_extensions, ext);
>         } else if (strcmp(var, "core.bare") == 0) {
> @@ -432,8 +434,9 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>         }
>
>         repository_format_precious_objects = candidate.precious_objects;
> +       repository_format_worktree_config = candidate.worktree_config;
>         string_list_clear(&candidate.unknown_extensions, 0);
> -       if (!has_common) {
> +       if (!has_common || repository_format_worktree_config) {
>                 if (candidate.is_bare != -1) {
>                         is_bare_repository_cfg = candidate.is_bare;
>                         if (is_bare_repository_cfg == 1)
> diff --git a/t/t2028-worktree-config.sh b/t/t2028-worktree-config.sh
> new file mode 100755
> index 0000000..34067df
> --- /dev/null
> +++ b/t/t2028-worktree-config.sh
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +test_description="config file in multi worktree"
> +
> +. ./test-lib.sh
> +
> +cmp_config() {
> +       if [ "$1" = "-C" ]; then
> +               shift &&
> +               GD="-C $1" &&
> +               shift
> +       else
> +               GD=
> +       fi &&
> +       echo "$1" >expected &&
> +       shift &&
> +       git $GD config "$@" >actual &&
> +       test_cmp expected actual
> +}
> +
> +test_expect_success 'setup' '
> +       test_commit start &&
> +       git config --worktree per.worktree is-ok &&
> +       git worktree add wt1 &&
> +       git worktree add wt2 &&
> +       test_must_fail git config --worktree per.worktree is-not-ok &&
> +       git config extensions.worktreeConfig true
> +'
> +
> +test_expect_success 'config is shared as before' '
> +       git config this.is shared &&
> +       cmp_config shared this.is &&
> +       cmp_config -C wt1 shared this.is &&
> +       cmp_config -C wt2 shared this.is
> +'
> +
> +test_expect_success 'config is shared (set from another worktree)' '
> +       git -C wt1 config that.is also-shared &&
> +       cmp_config also-shared that.is &&
> +       cmp_config -C wt1 also-shared that.is &&
> +       cmp_config -C wt2 also-shared that.is
> +'
> +
> +test_expect_success 'config private to main worktree' '
> +       git config --worktree this.is for-main &&
> +       cmp_config for-main this.is &&
> +       cmp_config -C wt1 shared this.is &&
> +       cmp_config -C wt2 shared this.is
> +'
> +
> +test_expect_success 'config private to linked worktree' '
> +       git -C wt1 config --worktree this.is for-wt1 &&
> +       cmp_config for-main this.is &&
> +       cmp_config -C wt1 for-wt1 this.is &&
> +       cmp_config -C wt2 shared this.is
> +'
> +
> +test_expect_success 'core.bare no longer for main only' '
> +       git config core.bare true &&
> +       cmp_config true core.bare &&
> +       cmp_config -C wt1 true core.bare &&
> +       cmp_config -C wt2 true core.bare &&
> +       git config --unset core.bare
> +'
> +
> +test_expect_success 'config.worktree no longer read without extension' '
> +       git config --unset extensions.worktreeConfig &&
> +       cmp_config shared this.is &&
> +       cmp_config -C wt1 shared this.is &&
> +       cmp_config -C wt2 shared this.is
> +'
> +
> +test_expect_success 'config --worktree fails in multi worktree without extension' '
> +       test_must_fail git config --worktree foo.bar true
> +'
> +
> +test_done
> --
> 2.9.1.566.gbd532d4
>
