Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3155F1FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944267AbdEZQpE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:45:04 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34995 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940899AbdEZQpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:45:02 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so16355147pfb.2
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqO0/qi3A5UYNV/PiX8gOm009pdeFUfRGckhxpP7yns=;
        b=T2Rqy7dj3/1yIKCGpxUvmaU+nC6e/uWOMn/sKIdPm+c9xANpfVHvkkCI84aU9lB19u
         dr1tEC9YeSwTpxXjzvBTzUucXsm3YWBnr2wsShKu/ASVUJX2w8ZzKautjmdQZt7Ykpr5
         eVZDIfvJIH/K0kmz/X4BkusYIzvLrXtBZFXcc64ZgSc0moRGp0p6NhNQNVKXPBEShTlm
         ew7P00/YiAfG6niF/oDWeoZBCoRfG0YgLlIXhEVX6LlwHx88EbTOIiQfNb3RpSXXUEIk
         XC1sAKTkKRgpLRpTVDLPaex9lIKxywGam+TpLWB7M8zsiOn4x20ssr4Sm0CKlDLDVWx8
         lxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqO0/qi3A5UYNV/PiX8gOm009pdeFUfRGckhxpP7yns=;
        b=BLa63JZ+Q7Cm/m5z1tLdQ9IMGlTV+Ozhr/Zp8uwpD30XBKOG4ts2NnHeGuF0KSqGZX
         xJNcRbE2+D4q+f7bs6/k+hP87mXhaQrQkZy6le8kLG5RIGAUt6TDrm4+Ys5XgE/xCxXz
         EmzLAMb54Sv3BVwbpqOnPPxUp05C6iIHjEzt9mwk/1vKkwvtOwo3vy7ruu9uBhnOwvC4
         iLM+PNX4zI3yf7xQ1DOJUko4ZbwdU/Bihk0SksObhR5i9xiCdPJlHgTj8cG7Pg4RtqYd
         zFgmqu8ZYV+uzHEO98uUCB/5uekNs3bKvdrVnsmRJaFxZ0xLkWEdbXtxs3lcXeUW4Ifo
         0kvw==
X-Gm-Message-State: AODbwcAxV1F7ojbND5X6wfLb/EanP/qFAQPSgEmSf3ZLdWoyHkzhgP1d
        zoMF3BZPRb0+gTgU5sEHHw==
X-Received: by 10.101.85.69 with SMTP id t5mr3476231pgr.201.1495817101772;
        Fri, 26 May 2017 09:45:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:56f:46ea:751:c7c2])
        by smtp.gmail.com with ESMTPSA id u194sm3681289pgc.2.2017.05.26.09.45.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 09:45:00 -0700 (PDT)
Date:   Fri, 26 May 2017 09:44:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170526164459.GB4592@google.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170526151713.10974-3-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/26, Prathamesh Chavan wrote:
> This aims to make git-submodule foreach a builtin. This is the very
> first step taken in this direction. Hence, 'foreach' is ported to
> submodule--helper, and submodule--helper is called from git-submodule.sh.
> The code is split up to have one function to obtain all the list of
> submodules. This function acts as the front-end of git-submodule foreach
> subcommand. It calls the function for_each_submodule_list, which basically
> loops through the list and calls function fn, which in this case is
> runcommand_in_submodule. This third function is a calling function that
> takes care of running the command in that submodule, and recursively
> perform the same when --recursive is flagged.
> 
> The first function module_foreach first parses the options present in
> argv, and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
> 
> The second function for_each_submodule_list traverses through the
> list, and calls function fn (which in case of submodule subcommand
> foreach is runcommand_in_submodule) is called for each entry.
> 
> The third function runcommand_in_submodule, generates a submodule struct sub
> for $name, value and then later prepends name=sub->name; and other
> value assignment to the env argv_array structure of a child_process.
> Also the <command> of submodule-foreach is push to args argv_array
> structure and finally, using run_command the commands are executed
> using a shell.
> 
> The third function also takes care of the recursive flag, by creating
> a separate child_process structure and prepending "--super-prefix displaypath",
> to the args argv_array structure. Other required arguments and the
> input <command> of submodule-foreach is also appended to this argv_array.
> 
> The commit 1c4fb136db (submodule foreach: skip eval for more than one
> argument, 2013-09-27), which explains that why for the case when argc>1,
> we do not use eval. But since in this patch, we are calling the
> command in a separate shell itself for all values of argc, this case
> is not considered separately.
> 
> Both env variable $path and $sm_path were added since both are used in
> tests in t7407.
> 
> Helped-by: Brandon Williams <bmwill@google.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> These series of patches passes the complete test suite.
> Its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds
> Branch: submodule-foreach
> Build #71
> 
>  builtin/submodule--helper.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  39 +-----------
>  2 files changed, 149 insertions(+), 38 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 566a5b6a6..343b6269c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,8 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -219,6 +221,26 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		char *displaypath;
> +		displaypath = xstrdup(relative_path(path, prefix, &sb));

These can probably go on the same line:
  
  char *displaypath = xstrdup(relative_path(path, prefix, &sb));

> +		strbuf_release(&sb);
> +		return displaypath;
> +	} else if (super_prefix) {
> +		return xstrfmt("%s/%s", super_prefix, path);
> +	} else {
> +		return xstrdup(path);
> +	}
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -331,6 +353,14 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void for_each_submodule_list(const struct module_list list,
> +				    submodule_list_func_t fn, void *cb_data)
> +{
> +	int i;
> +	for (i = 0; i < list.nr; i++)
> +		fn(list.entries[i], cb_data);
> +}
> +
>  static void init_submodule(const char *path, const char *prefix, int quiet)
>  {
>  	const struct submodule *sub;
> @@ -487,6 +517,123 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct cb_foreach {
> +	int argc;
> +	const char **argv;
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +	unsigned int recursive: 1;
> +};
> +#define CB_FOREACH_INIT { 0, NULL, NULL, 0, 0 }
> +
> +static void runcommand_in_submodule(const struct cache_entry *list_item,
> +				    void *cb_data)
> +{
> +	struct cb_foreach *info = cb_data;
> +	char *toplevel = xgetcwd();
> +	const struct submodule *sub;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char* displaypath = NULL;
> +	int i;
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);
> +
> +	if (!sub)
> +		die(_("No url found for submodule path '%s' in .gitmodules"),
> +		      displaypath);
> +
> +	if (!is_submodule_populated_gently(list_item->name, NULL))
> +		return;

I missed one other memory leak from the last round.  You should probably
call xgetcwd() to fill 'toplevel' here to avoid leaking the memory if
you do an early return.

> +
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.use_shell = 1;
> +	cp.dir = list_item->name;
> +
> +	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> +	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
> +	argv_array_pushf(&cp.env_array, "sha1=%s", oid_to_hex(&list_item->oid));
> +	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +	for (i = 0; i < info->argc; i++)
> +		argv_array_push(&cp.args, info->argv[i]);
> +
> +	if (!info->quiet)
> +		printf(_("Entering '%s'\n"), displaypath);
> +
> +	if (info->argv[0] && run_command(&cp))
> +		die(_("run_command returned non-zero status for %s\n."),
> +		      displaypath);
> +
> +	if (info->recursive) {
> +		struct child_process cpr = CHILD_PROCESS_INIT;
> +
> +		cpr.git_cmd = 1;
> +		cpr.dir = list_item->name;
> +		prepare_submodule_repo_env(&cpr.env_array);
> +
> +		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
> +				 "submodule--helper", "foreach", "--recursive",
> +				 NULL);
> +
> +		if (info->quiet)
> +			argv_array_push(&cpr.args, "--quiet");
> +
> +		for (i = 0; i < info->argc; i++)
> +			argv_array_push(&cpr.args, info->argv[i]);
> +
> +		if (run_command(&cpr))
> +			die(_("run_command returned non-zero status while"
> +			      "recursing in the nested submodules of %s\n."),
> +			      displaypath);
> +	}
> +
> +	free(displaypath);
> +	free(toplevel);
> +}
> +
> +static int module_foreach(int argc, const char **argv, const char *prefix)
> +{
> +	struct cb_foreach info;
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int recursive = 0;
> +
> +	struct option module_foreach_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
> +		OPT_BOOL(0, "recursive", &recursive,
> +			 N_("Recurse into nested submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_foreach_options,
> +			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
> +		BUG("module_list_compute should not choke on empty pathspec");
> +
> +	info.argc = argc;
> +	info.argv = argv;
> +	info.prefix = prefix;
> +	info.quiet = quiet;
> +	info.recursive = recursive;
> +
> +	for_each_submodule_list(list, runcommand_in_submodule, &info);
> +
> +	return 0;
> +}
> +
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>  			   const char *depth, struct string_list *reference,
>  			   int quiet, int progress)
> @@ -1212,6 +1359,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ea6f56337..032fd2540 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -322,45 +322,8 @@ cmd_foreach()
>  		shift
>  	done
>  
> -	toplevel=$(pwd)
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
>  
> -	# dup stdin so that it can be restored when running the external
> -	# command in the subshell (and a recursive call to this function)
> -	exec 3<&0
> -
> -	{
> -		git submodule--helper list --prefix "$wt_prefix" ||
> -		echo "#unmatched" $?
> -	} |
> -	while read -r mode sha1 stage sm_path
> -	do
> -		die_if_unmatched "$mode" "$sha1"
> -		if test -e "$sm_path"/.git
> -		then
> -			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> -			say "$(eval_gettext "Entering '\$displaypath'")"
> -			name=$(git submodule--helper name "$sm_path")
> -			(
> -				prefix="$prefix$sm_path/"
> -				sanitize_submodule_env
> -				cd "$sm_path" &&
> -				# we make $path available to scripts ...
> -				path=$sm_path &&
> -				sm_path=$displaypath &&
> -				if test $# -eq 1
> -				then
> -					eval "$1"
> -				else
> -					"$@"
> -				fi &&
> -				if test -n "$recursive"
> -				then
> -					cmd_foreach "--recursive" "$@"
> -				fi
> -			) <&3 3<&- ||
> -			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
> -		fi
> -	done
>  }
>  
>  #
> -- 
> 2.11.0
> 

Looking good!

-- 
Brandon Williams
