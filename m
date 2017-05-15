Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B885201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbdEOSeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:34:11 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33945 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758256AbdEOSeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:34:09 -0400
Received: by mail-pg0-f46.google.com with SMTP id u28so64114408pgn.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztTK/nKAjxOoEL+mm24kJxMVaPbRcvLDTjocroU94TE=;
        b=i9EWVkTWcw0QxG6dCERMdqf5MvdnppxpJV0wAhYHDFZCnnwo4F2GSgBI3JuyG+sJ1L
         c+4hkDv8BxfGQxQJS9OyhWiZN3k7hf2eUTU+EQSE2EwCijjSphSBIa9lMj3+iH1p6Z4R
         m3IKrBAIBuGLzzCJk8ZEhBo6CI2czjM1ptpmyZy8AOvPNhAYsIIrICuF8N5vuFjWczfG
         UbbWRbE8wE/4qeK1gMkr0mwJac0soCEGd1vMDo51Z0x0HzCHphDlaj4GooDwY/9nYYOO
         +yiA8xRHu2J63XvD5nbQMWUThQs5PRWRue/0dpWESjDWOB58ZYJtoIi2zRAh8LRIXO7v
         Q+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztTK/nKAjxOoEL+mm24kJxMVaPbRcvLDTjocroU94TE=;
        b=XdEF5KNdl1IPs/37zeZdqECFGlA6PnctQDfs6eh5E+2pFhst1evdiLVf1ASdJwm2rK
         /L3zykwzpQJP1RpKQoXt0vQJxcjTuNMcy0q3b8bLxnsgWB6DF8cOQkTRFjmEauZ8HA9v
         CEjQGj18eYccXCrXG0XGXZYo64H+q9V0U4cehK6hckFsKldWypECmjwRmHuKp3re1HlZ
         Z4Hb778T0+KWNi1Eu2bkuLe7NjjUxWD8VeMNjt0OHbOE3a7AdZqogi+Ou7Igdxihxi6x
         3Ys7/joqtXkDGSws8XVOx9iLjzcr+3FUWp2q2O/ryA17tArd+TgIPlIys2iy5D0tswG0
         UaQg==
X-Gm-Message-State: AODbwcDJbxi6dZVkJPbd1h9XIaWlqvURLjaPLlxtpUm5XtfSSRoBxqG8
        lyVMJY1wSvg0TbFo
X-Received: by 10.99.97.83 with SMTP id v80mr7916053pgb.94.1494873248472;
        Mon, 15 May 2017 11:34:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id p10sm21054124pgf.63.2017.05.15.11.34.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 11:34:07 -0700 (PDT)
Date:   Mon, 15 May 2017 11:34:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     ramsay@ramsayjones.plus.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [GSoC][RFC/PATCH v3 2/2] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170515183405.GA79147@google.com>
References: <c3b724d8-bb9b-b63b-0105-8c1e22b120be@ramsayjones.plus.com>
 <20170512114404.10008-1-pc44800@gmail.com>
 <20170512114404.10008-2-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512114404.10008-2-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, Prathamesh Chavan wrote:
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
> for $name value and then later prepends name=sub->name and other
> value assignments to the env argv_array structure of a child_process.
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
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> 
> In this new version of patch, following changes were added:
> 
> foreach_submodule was renamed to runcommand_in_submodule
> 
> We module_foreach into two parts, such that, module foreach
> generates the list of submodules present in the cwd. And later
> calls for_each_submodule_list which basically loops through the
> list of submodule and calls the passed function fn.
> 
> Additionally, this patch also pass all those test, which it
> failed earlier.
> 
> Since in the run-command API errors out when child
> process with no arguments is passed, for test #10
> from t7407-submodule-foreach, additional condition
> was added in runcommand_in_submodule funciton to
> handle this case instead of modifying the run-command.
> 
> Complete build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> branch: foreach
> build #52
> 
> It can been seen that the patch fails in test #9
> of t7407-submodule-foreach, which is the newly added
> test to that suite. The main reason of adding this test
> was to bring the behavior of $path for the submodule
> foreach --recursive case.
> 
> The observation made was as follows:
> 
> For a project - super containing dir (not a submodule)
> and a submodule sub which contains another submodule
> subsub. When we run a command from super/dir:
> 
> git submodule foreach "echo \$path-\$sm_path"
> 
> actual results:
> Entering '../sub'
> ../sub-../sub
> Entering '../sub/subsub'
> ../subsub-../subsub
> 
> ported function's result:
> Entering '../sub'
> sub-../sub
> Entering '../sub/subsub'
> subsub-../sub/subsub
> 
> This is occurring since in cmd_foreach of git-submodule.sh
> when we use to recurse, we call cmd_foreach
> and hence the process ran in the same shell.
> Because of this, the variable $wt_prefix is set only once
> which is at the beginning of the submodule foreach execution.
> wt_prefix=$(git rev-parse --show-prefix)
> 
> And since sm_path and path are set using $wt_prefix as :
> sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
> path=$sm_path
> It differs with the value of displaypath as well.
> 
> This make the value of $path confusing and I also feel it
> deviates from its documentation:
> $path is the name of the submodule directory relative
> to the superproject.
> 
> But since in refactoring the code, we wish to maintain the
> code in same way, we need to pass wt_prefix on every
> recursive call, which may result in complex C code.
> Another option could be to first correct the $path value
> in git-submodule.sh and then port the updated cmd_foreach.
> 
>  builtin/submodule--helper.c | 145 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  39 +-----------
>  2 files changed, 146 insertions(+), 38 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 566a5b6a6..1a5b26c22 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,10 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
> +
> +
> +

nit: You could probably get rid of 2 of these empty lines.

>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -331,6 +335,15 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
> +{
> +	int i;
> +	for (i = 0; i < list.nr; i++)
> +		fn(list.entries[i], cb_data);
> +
> +	return;
> +}
> +
>  static void init_submodule(const char *path, const char *prefix, int quiet)
>  {
>  	const struct submodule *sub;
> @@ -487,6 +500,137 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct cb_foreach {
> +	int argc;
> +	const char **argv;
> +	const char *prefix;
> +	int quiet;
> +	int recursive;
> +};
> +
> +static void runcommand_in_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct cb_foreach *info = cb_data;
> +	const char *toplevel = xgetcwd();

xgetcwd() returns a 'char *' so you own the memory for the string that
was returned.  This declaration should be changed to 'char *' and be
freed at the end before returning from this function.

> +	const struct submodule *sub;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf sub_sha1 = STRBUF_INIT;
> +	char* displaypath = NULL;
> +	int i;
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();
> +
> +	if (info->prefix && get_super_prefix()) {
> +		die("BUG: cannot have prefix '%s' and superprefix '%s'",
> +		    info->prefix, get_super_prefix());
> +	} else if (info->prefix) {
> +		displaypath = xstrdup(relative_path(list_item->name, info->prefix, &sb));

I would move the declaration of the strbuf to be inside this if block
since its not really used else where (except in the next if block but
I'll get to that).

> +	} else if (get_super_prefix()) {
> +		strbuf_addf(&sb, "%s/%s", get_super_prefix(), list_item->name);
> +		displaypath = strbuf_detach(&sb, NULL);

You don't really need to use a strbuf for this, you could just use
xfmtstr() instead and avoid needing to call detach.  Also with the
number of times you call 'get_super_prefix()' it may be worth while to
have a local 'const char *super_prefix' which you assign a single time
and reuse so that you don't waste time calling that function over and
over again.

> +	} else {
> +		displaypath = xstrdup(list_item->name);
> +	}
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);
> +
> +	if (!sub)
> +		die(_("No url found for submodule path '%s' in .gitmodules"),
> +		      displaypath);
> +
> +	strbuf_addstr(&sub_sha1, oid_to_hex(&list_item->oid));
> +
> +	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> +	argv_array_pushf(&cp.env_array, "path=%s", list_item->name); 

Trailing white space                                            ^ here

> +	argv_array_pushf(&cp.env_array, "sha1=%s", sub_sha1.buf);

You can remove the 'sub_sha1' strbuf.  Since  you are just using it this
once it makes more sense just substitute 'sub_sha1.buf' for the call to
'oid_to_hex()'

> +	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +	cp.use_shell = 1;
> +	cp.dir = list_item->name;
> +	prepare_submodule_repo_env(&cp.env_array);

I would probably hoist this call up before you start setting 'name',
'sm_path', 'path', etc.  That way you are certain that the call to
prepare_submodule_repo_env() doesn't mess with anything you've already
set.  Now in this context it doesn't and  you would be fine but this is
just to future proof any changes to that function.

> +	argv_array_pushf(&cp.env_array, "%s", GIT_SUPER_PREFIX_ENVIRONMENT);

I assume you are doing this to ensure that the super prefix environment
var is cleared in the child process?  Though you shouldn't have to
because this env var is covered in 'local_repo_env' and should already
be taken care of my the call to 'prepare_submodule_repo_env()'

> +
> +	for (i = 0; i < info->argc; i++)
> +		argv_array_push(&cp.args, info->argv[i]);
> +
> +	if (!is_submodule_populated_gently(list_item->name, NULL))
> +		return;
> +	

And trailing white space here ^

> +	if (!info->quiet)
> +		printf(_("Entering '%s'\n"), displaypath);
> +	if (info->argv[0] && run_command(&cp))
> +		die(_("run_command returned non-zero status for %s\n."), displaypath);
> +
> +	if (info->recursive) {
> +		struct child_process cpr = CHILD_PROCESS_INIT;

You don't need to use a new child_process struct here, you could reuse
'cp' since the call to run_command will free all the memory at the end
of the call....oh but you're not unconditionally running run_command
because of the check to argv[0]...

Maybe we want to do an early return if argv[0] is empty?  Not sure how
that would break tests though...

> +
> +		cpr.use_shell = 1;
> +		cpr.dir = list_item->name;
> +		prepare_submodule_repo_env(&cpr.env_array);
> +
> +		argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,
> +				 "submodule--helper", NULL);
> +
> +		argv_array_pushl(&cpr.args, "foreach", "--recursive", NULL);

since you're already using pushl, just combine these two function calls.

> +
> +		if (info->quiet)
> +			argv_array_push(&cpr.args, "--quiet");
> +
> +		for (i = 0; i < info->argc; i++)
> +			argv_array_push(&cpr.args, info->argv[i]);
> +
> +		run_command(&cpr);

Are you not going to do anything if the exit status was non-zero?

> +	}
> +
> +	strbuf_release(&sub_sha1);
> +	strbuf_release(&sb);
> +	free(displaypath);
> +
> +	return;

You don't need this return here.

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
> +	memset(&info, 0, sizeof(info));
> +
> +	argc = parse_options(argc, argv, prefix, module_foreach_options,
> +			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
> +			die("BUG: module_list_compute should not choke on empty pathspec");

nit: Indention looks off here.

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
> @@ -1212,6 +1356,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c0d0e9a4c..032fd2540 100755
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
> -				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
> -				# we make $path available to scripts ...
> -				path=$sm_path &&
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

-- 
Brandon Williams
