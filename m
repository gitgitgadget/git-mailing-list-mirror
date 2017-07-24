Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03808203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 23:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757048AbdGXXEI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 19:04:08 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37270 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757007AbdGXXDj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 19:03:39 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so62976325pgy.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6zEZotaLEXIDoeUxn34B1E2AaSz6BByXGz9M6bixyR8=;
        b=oBrSrH4t1Dt4p2qG72/VehFAlJ2xYuD5q6zeoy3n2IrYScM4Hrm+c8l8m3ikYsFuz1
         VTsEtn5UOKmWF1Kd/amCbiP/xR765oIkQ4DlflD7qiejzixZc+HY00xu6W4cc9xcVrBA
         GlyRnTBg6E7rIm4NZlmR01v22Mfi12z+87BgZexAMM7vLEMWRev4qmgjd7M7otk5QX+R
         KpBHK2/4W7jqz4YxZyw/tE37va6Mxit4gGiHO4tHOxUaHwcl2oQUApOmPhAeeG9BlnJw
         QmyB2CUDGrw4UxA7FLiucOs377380bWckkLDHByzszbDjN10ONw5UI0RnlLOhrn1N5wn
         rOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6zEZotaLEXIDoeUxn34B1E2AaSz6BByXGz9M6bixyR8=;
        b=OYNgLaLCUZpCHH6me+GFrdVZgapq3L7Xs/WQuzK6aJEvIoP43MvkBTYZpkZoZoOszC
         al23iPzRJ2NrYbpV4h5IrsA4WRue5S0AI6k2gysTCUZu6s6Whjqxm4fXvT8GX+5KJUTt
         Hyl09VQr37bMLHugLPa/7wDf/aJVfLvTIxF7k0WKUx5wfIzrVDRibDr1L8iUkhPVco/4
         SA7XzrU4UqgPCo9zlzM68zMuVgEHoouEOEjuHZdrxo3Vdh3+8szWWHee7S9Fu0brkY84
         dTcmKhD29slGv3lGZrRrmySKV93v4fLLCpkIS2x2GWYbA1FCi1Detc9a5QK7Rn2O+wiu
         40jQ==
X-Gm-Message-State: AIVw112Zdd6ZbWSMJbkoJEETi96p7z79xu7xwNkduzudOJCK0nLW7ydT
        EvZC7MGz/JolIX7k
X-Received: by 10.84.209.204 with SMTP id y70mr13226332plh.170.1500937417536;
        Mon, 24 Jul 2017 16:03:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id n11sm22882190pgr.76.2017.07.24.16.03.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 16:03:36 -0700 (PDT)
Date:   Mon, 24 Jul 2017 16:03:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 06/13] submodule: port submodule subcommand
 'deinit' from shell to C
Message-ID: <20170724230335.GD92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-7-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-7-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> The same mechanism is used even for porting this submodule
> subcommand, as used in the ported subcommands till now.
> The function cmd_deinit in split up after porting into three
> functions: module_deinit(), for_each_submodule_list() and
> deinit_submodule().
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  55 +----------------
>  2 files changed, 142 insertions(+), 54 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2d1d3984d..5e84fc42d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -910,6 +910,146 @@ static int module_sync(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct deinit_cb {
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +	unsigned int force: 1;
> +	unsigned int all: 1;
> +};
> +#define DEINIT_CB_INIT { NULL, 0, 0, 0 }
> +
> +static void deinit_submodule(const struct cache_entry *list_item,
> +			     void *cb_data)
> +{
> +	struct deinit_cb *info = cb_data;
> +	const struct submodule *sub;
> +	char *displaypath = NULL;
> +	struct child_process cp_config = CHILD_PROCESS_INIT;
> +	struct strbuf sb_config = STRBUF_INIT;
> +	char *sub_git_dir = xstrfmt("%s/.git", list_item->name);
> +	struct stat st;
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);
> +
> +	if (!sub || !sub->name)
> +		goto cleanup;
> +
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +	/* remove the submodule work tree (unless the user already did it) */
> +	if (is_directory(list_item->name)) {
> +		/* protect submodules containing a .git directory */
> +		if (is_git_directory(sub_git_dir))

This may be too strict of a test.  The original code simply checks if
'submodule/.git' is a directory and dies if it is.  This adds additional
checks ensuring it is a gitdir.  If we want to have a straight
conversion from the shell code we should have this only check if it is a
directory.

> +			die(_("Submodule work tree '%s' contains a .git "
> +			      "directory use 'rm -rf' if you really want "
> +			      "to remove it including all of its history"),
> +			      displaypath);
> +
> +		if (!info->force) {
> +			struct child_process cp_rm = CHILD_PROCESS_INIT;
> +			cp_rm.git_cmd = 1;
> +			argv_array_pushl(&cp_rm.args, "rm", "-qn",
> +					 list_item->name, NULL);
> +
> +			if (run_command(&cp_rm))
> +				die(_("Submodule work tree '%s' contains local "
> +				      "modifications; use '-f' to discard them"),
> +				      displaypath);
> +		}
> +
> +		if (!lstat(list_item->name, &st)) {

What's the purpose of the lstat call here?

> +			struct strbuf sb_rm = STRBUF_INIT;
> +			const char *format;
> +
> +			strbuf_addstr(&sb_rm, list_item->name);
> +
> +			if (!remove_dir_recursively(&sb_rm, 0))
> +				format = _("Cleared directory '%s'\n");
> +			else
> +				format = _("Could not remove submodule work tree '%s'\n");
> +
> +			if (!info->quiet)
> +				printf(format, displaypath);
> +
> +			strbuf_release(&sb_rm);
> +		}
> +	}
> +
> +	if (mkdir(list_item->name, st.st_mode))

What should the mode be when making the empty directory? Right now you
have the potential for it to be garbage as 'st' has the potential of not
being set by the lstat call above (since it happens inside the above if
statement).  Also we may not want it to depend on what the permissions
were set as on the filesystem assuming the user didn't already remove
the submodule themselves.

> +		die(_("could not create empty submodule directory %s"),
> +		      displaypath);
> +
> +	cp_config.git_cmd = 1;
> +	argv_array_pushl(&cp_config.args, "config", "--get-regexp", NULL);
> +	argv_array_pushf(&cp_config.args, "submodule.%s\\.", sub->name);
> +
> +	/* remove the .git/config entries (unless the user already did it) */
> +	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
> +		char *sub_key = xstrfmt("submodule.%s", sub->name);
> +		/*
> +		 * remove the whole section so we have a clean state when
> +		 * the user later decides to init this submodule again
> +		 */
> +		git_config_rename_section_in_file(NULL, sub_key, NULL);
> +		if (!info->quiet)
> +			printf(_("Submodule '%s' (%s) unregistered for path '%s'\n"),
> +				 sub->name, sub->url, displaypath);
> +		free(sub_key);
> +	}
> +
> +cleanup:
> +	free(displaypath);
> +	free(sub_git_dir);
> +	strbuf_release(&sb_config);
> +}
> +
> +static int module_deinit(int argc, const char **argv, const char *prefix)
> +{
> +	struct deinit_cb info = DEINIT_CB_INIT;
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int force = 0;
> +	int all = 0;
> +
> +	struct option module_deinit_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
> +		OPT__FORCE(&force, N_("Remove submodule working trees even if they contain local changes")),
> +		OPT_BOOL(0, "all", &all, N_("Unregister all submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_deinit_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +		BUG("module_list_compute should not choke on empty pathspec");
> +
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +	info.all = !!all;
> +	info.force = !!force;
> +
> +	if (all && argc) {
> +		error("pathspec and --all are incompatible");
> +		usage_with_options(git_submodule_helper_usage,
> +				   module_deinit_options);
> +	}
> +
> +	if (!argc && !all)
> +		die(_("Use '--all' if you really want to deinitialize all submodules"));
> +
> +	gitmodules_config();
> +	for_each_submodule_list(list, deinit_submodule, &info);
> +
> +	return 0;
> +}
> +
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>  			   const char *depth, struct string_list *reference,
>  			   int quiet, int progress)
> @@ -1640,6 +1780,7 @@ static struct cmd_struct commands[] = {
>  	{"status", module_status, SUPPORT_SUPER_PREFIX},
>  	{"print-default-remote", print_default_remote, 0},
>  	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
> +	{"deinit", module_deinit, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6bfc5e17d..73e6f093f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -428,60 +428,7 @@ cmd_deinit()
>  		shift
>  	done
>  
> -	if test -n "$deinit_all" && test "$#" -ne 0
> -	then
> -		echo >&2 "$(eval_gettext "pathspec and --all are incompatible")"
> -		usage
> -	fi
> -	if test $# = 0 && test -z "$deinit_all"
> -	then
> -		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
> -	fi
> -
> -	{
> -		git submodule--helper list --prefix "$wt_prefix" "$@" ||
> -		echo "#unmatched" $?
> -	} |
> -	while read -r mode sha1 stage sm_path
> -	do
> -		die_if_unmatched "$mode" "$sha1"
> -		name=$(git submodule--helper name "$sm_path") || exit
> -
> -		displaypath=$(git submodule--helper relative-path "$sm_path" "$wt_prefix")
> -
> -		# Remove the submodule work tree (unless the user already did it)
> -		if test -d "$sm_path"
> -		then
> -			# Protect submodules containing a .git directory
> -			if test -d "$sm_path/.git"
> -			then
> -				die "$(eval_gettext "\
> -Submodule work tree '\$displaypath' contains a .git directory
> -(use 'rm -rf' if you really want to remove it including all of its history)")"
> -			fi
> -
> -			if test -z "$force"
> -			then
> -				git rm -qn "$sm_path" ||
> -				die "$(eval_gettext "Submodule work tree '\$displaypath' contains local modifications; use '-f' to discard them")"
> -			fi
> -			rm -rf "$sm_path" &&
> -			say "$(eval_gettext "Cleared directory '\$displaypath'")" ||
> -			say "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
> -		fi
> -
> -		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
> -
> -		# Remove the .git/config entries (unless the user already did it)
> -		if test -n "$(git config --get-regexp submodule."$name\.")"
> -		then
> -			# Remove the whole section so we have a clean state when
> -			# the user later decides to init this submodule again
> -			url=$(git config submodule."$name".url)
> -			git config --remove-section submodule."$name" 2>/dev/null &&
> -			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
> -		fi
> -	done
> +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} "$@"
>  }
>  
>  is_tip_reachable () (
> -- 
> 2.13.0
> 

-- 
Brandon Williams
