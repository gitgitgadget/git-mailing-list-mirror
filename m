Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B89203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbdGXVxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:53:01 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35400 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXVwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:52:23 -0400
Received: by mail-pf0-f181.google.com with SMTP id h29so16590922pfd.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C9lg/JnuDEQhx9YecSIe0TXOX+ktkvtXm0/wgNkVnYY=;
        b=X3iNNeEsVoeCMwvphUfYnntngd3O6l8hm7XKC2KbGJHzsRQxhPUnvwHvWjtGFQxYHG
         KO+U2ZrkI2b3JiFTm2yFDsnsLL5+OGMjflDXIXY+2JBjzpnYKbn7w1JJTcVLW+zU4nXz
         K8DG6TSvPZiYwTrM0NxpmIoyjmmmFO+T4EbvQEHWFLWszxpXakZ2zsOvqvEYIzfmscKE
         kDB0mF2xJNVDY1Grc2cX50exaUqbpdD6kAJwWe5rXmb+sDPZfDvBYKmYwSVI2YlMT3HQ
         8KmaqEFVgsV6u1ZbG5O2oaI8gwC1Ijc2NhEStZwNhaQB+t0SInp495rE9fgP6q56uMLi
         Agrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9lg/JnuDEQhx9YecSIe0TXOX+ktkvtXm0/wgNkVnYY=;
        b=CgkXnDM2xyJCN4zvFntbDgil8Yj5xDqSw5MorCUhf8uzbeRdGm695WAhBnz3u+zEWP
         I9dqXz7sJG2bbA+ocISRpcHZVuOHnNcjQcn181/HzPGGU1mJ7YFMCI4+T6SzonCUCixi
         1XW80kkDZdQoFaa2I8nxvzEYKKEqM/r5EOQxdG0Cgp9Kq3WtczvHej6RUejhSEzFrrBT
         jpo+KHX0PiDVzyrILFeXhdtd9EL/QupVRJbTQVwA2sFHAKCMte9v285cXNlk4dXnCogg
         rMI/3iuCSwwGjDBWS84+wK9jTf4T/2UFzXt3Y3c45TP8xCT+mw+ct8Fg/IL7Dqhj9rHE
         8FbA==
X-Gm-Message-State: AIVw112kKWbbHwo/3O31bwlJG766P6eq+UtsXxIPazSag/n0Yc1tIR8c
        /1mK+fdH/obYmhye
X-Received: by 10.84.237.2 with SMTP id s2mr19076452plk.70.1500933142485;
        Mon, 24 Jul 2017 14:52:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id q3sm22241436pgf.69.2017.07.24.14.52.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 14:52:21 -0700 (PDT)
Date:   Mon, 24 Jul 2017 14:52:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 05/13] submodule: port submodule subcommand 'sync'
 from shell to C
Message-ID: <20170724215220.GC92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-6-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-6-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> Port the submodule subcommand 'sync' from shell to C using the same
> mechanism as that used for porting submodule subcommand 'status'.
> Hence, here the function cmd_sync() is ported from shell to C.
> This is done by introducing three functions: module_sync(),
> sync_submodule() and print_default_remote().
> 
> The function print_default_remote() is introduced for getting
> the default remote as stdout.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version of patch, following changes were made:
> * the code use to die when sub->url was found to be NULL. This was not a
>   correct translation of code. It was corrected by using an empty string
>   instead of sub->url.
> * a process was used in the previous patch for registering the submodule
>   url. This was avoided by the suggested changes on the previous patch.
> * some nits were also corrected.
>  
>  builtin/submodule--helper.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  56 +-------------
>  2 files changed, 184 insertions(+), 55 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b39828174..2d1d3984d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -44,6 +44,20 @@ static char *get_default_remote(void)
>  	return ret;
>  }
>  
> +static int print_default_remote(int argc, const char **argv, const char *prefix)
> +{
> +	const char *remote;
> +
> +	if (argc != 1)
> +		die(_("submodule--helper print-default-remote takes no arguments"));
> +
> +	remote = get_default_remote();
> +	if (remote)
> +		puts(remote);

Any reason why puts is used instead of a printf function?

> +
> +	return 0;
> +}
> +
>  static int starts_with_dot_slash(const char *str)
>  {
>  	return str[0] == '.' && is_dir_sep(str[1]);
> @@ -379,6 +393,25 @@ static void module_list_active(struct module_list *list)
>  	*list = active_modules;
>  }
>  
> +static char *get_up_path(const char *path)
> +{
> +	int i;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	for (i = count_slashes(path); i; i--)
> +		strbuf_addstr(&sb, "../");
> +
> +	/*
> +	 * Check if 'path' ends with slash or not
> +	 * for having the same output for dir/sub_dir
> +	 * and dir/sub_dir/
> +	 */
> +	if (!is_dir_sep(path[strlen(path) - 1]))
> +		strbuf_addstr(&sb, "../");
> +
> +	return strbuf_detach(&sb, NULL);
> +}
> +
>  static int module_list(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> @@ -729,6 +762,154 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct sync_cb {
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +	unsigned int recursive: 1;
> +};
> +#define SYNC_CB_INIT { NULL, 0, 0 }
> +
> +static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct sync_cb *info = cb_data;
> +	const struct submodule *sub;
> +	char *sub_key, *remote_key;
> +	char *sub_origin_url, *super_config_url, *displaypath;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sub_repo_path = STRBUF_INIT;

Not the most important but you could be a lot more efficient here with
your variables.  You could allocate a single strbuf and reuse it for
'sub_key'. 'remote_key', 'sb', and 'sub_repo_path' as it doesn't look
like you need any of those two at the same time.

> +	char *sub_config_path = NULL;
> +
> +	if (!is_submodule_active(the_repository, list_item->name))
> +		return;
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);

Since is_submodule_active also calls into the submodule-config subsystem
to retrieve a submodule this call should never return a NULL ptr...so it
may be safer to return instead of proceeding if 'sub' ends up being null
here.

> +
> +	if (sub && sub->url) {
> +		if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {
> +			char *remote_url, *up_path;
> +			char *remote = get_default_remote();
> +			char *remote_key = xstrfmt("remote.%s.url", remote);
> +
> +			if (git_config_get_string(remote_key, &remote_url))
> +				remote_url = xgetcwd();
> +
> +			up_path = get_up_path(list_item->name);
> +			sub_origin_url = relative_url(remote_url, sub->url, up_path);
> +			super_config_url = relative_url(remote_url, sub->url, NULL);
> +
> +			free(remote);
> +			free(remote_key);
> +			free(up_path);
> +			free(remote_url);
> +		} else {
> +			sub_origin_url = xstrdup(sub->url);
> +			super_config_url = xstrdup(sub->url);
> +		}
> +	} else {
> +		sub_origin_url = "";
> +		super_config_url = "";
> +	}
> +
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +	if (!info->quiet)
> +		printf(_("Synchronizing submodule url for '%s'\n"),
> +			 displaypath);
> +
> +	sub_key = xstrfmt("submodule.%s.url", sub->name);
> +	if (git_config_set_gently(sub_key, super_config_url))
> +		die(_("failed to register url for submodule path '%s'"),
> +		      displaypath);
> +
> +	if (!is_submodule_populated_gently(list_item->name, NULL))
> +		goto cleanup;
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.dir = list_item->name;
> +	argv_array_pushl(&cp.args, "submodule--helper",
> +			 "print-default-remote", NULL);
> +
> +	if (capture_command(&cp, &sb, 0))
> +		die(_("failed to get the default remote for submodule '%s'"),
> +		      list_item->name);
> +
> +	strbuf_strip_suffix(&sb, "\n");
> +	remote_key = xstrfmt("remote.%s.url", sb.buf);
> +	strbuf_release(&sb);
> +
> +	submodule_to_gitdir(&sub_repo_path, list_item->name);

This function (submodule_to_gitdir) has some poor characteristics in
that it will succeed even if there isn't a configured submodule but
there just happens to be a submodule at the provided path...but it looks
like none of them will affect this as the fist thing this function does
is check if the submodule is active before preceding.

> +	sub_config_path = xstrfmt("%s/config", sub_repo_path.buf);
> +	strbuf_release(&sub_repo_path);
> +
> +	if (git_config_set_in_file_gently(sub_config_path, remote_key, sub_origin_url))
> +		die(_("failed to update remote for submodule '%s'"),
> +		      list_item->name);
> +
> +	if (info->recursive) {
> +		struct child_process cpr = CHILD_PROCESS_INIT;
> +
> +		cpr.git_cmd = 1;
> +		cpr.dir = list_item->name;
> +		prepare_submodule_repo_env(&cpr.env_array);
> +
> +		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,

Same comment as the previous patch here.

> +				 "submodule--helper", "sync", "--recursive",
> +				 NULL);
> +
> +		if (info->quiet)
> +			argv_array_push(&cpr.args, "--quiet");
> +
> +		if (run_command(&cpr))
> +			die(_("failed to recurse into submodule '%s'"),
> +			      list_item->name);
> +	}
> +
> +cleanup:
> +	free(sub_key);
> +	free(super_config_url);
> +	free(displaypath);
> +	free(sub_config_path);
> +	free(sub_origin_url);
> +}
> +
> +static int module_sync(int argc, const char **argv, const char *prefix)
> +{
> +	struct sync_cb info = SYNC_CB_INIT;
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int recursive = 0;
> +
> +	struct option module_sync_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output of synchronizing submodule url")),
> +		OPT_BOOL(0, "recursive", &recursive,
> +			N_("Recurse into nested submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_sync_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +		return 1;
> +
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +	info.recursive = !!recursive;
> +
> +	gitmodules_config();
> +	for_each_submodule_list(list, sync_submodule, &info);
> +
> +	return 0;
> +}
> +
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>  			   const char *depth, struct string_list *reference,
>  			   int quiet, int progress)
> @@ -1457,6 +1638,8 @@ static struct cmd_struct commands[] = {
>  	{"print-name-rev", print_name_rev, 0},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"status", module_status, SUPPORT_SUPER_PREFIX},
> +	{"print-default-remote", print_default_remote, 0},
> +	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 51b057d82..6bfc5e17d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1037,63 +1037,9 @@ cmd_sync()
>  			;;
>  		esac
>  	done
> -	cd_to_toplevel
> -	{
> -		git submodule--helper list --prefix "$wt_prefix" "$@" ||
> -		echo "#unmatched" $?
> -	} |
> -	while read -r mode sha1 stage sm_path
> -	do
> -		die_if_unmatched "$mode" "$sha1"
> -
> -		# skip inactive submodules
> -		if ! git submodule--helper is-active "$sm_path"
> -		then
> -			continue
> -		fi
> -
> -		name=$(git submodule--helper name "$sm_path")
> -		url=$(git config -f .gitmodules --get submodule."$name".url)
> -
> -		# Possibly a url relative to parent
> -		case "$url" in
> -		./*|../*)
> -			# rewrite foo/bar as ../.. to find path from
> -			# submodule work tree to superproject work tree
> -			up_path="$(printf '%s\n' "$sm_path" | sed "s/[^/][^/]*/../g")" &&
> -			# guarantee a trailing /
> -			up_path=${up_path%/}/ &&
> -			# path from submodule work tree to submodule origin repo
> -			sub_origin_url=$(git submodule--helper resolve-relative-url "$url" "$up_path") &&
> -			# path from superproject work tree to submodule origin repo
> -			super_config_url=$(git submodule--helper resolve-relative-url "$url") || exit
> -			;;
> -		*)
> -			sub_origin_url="$url"
> -			super_config_url="$url"
> -			;;
> -		esac
>  
> -		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> -		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> -		git config submodule."$name".url "$super_config_url"
> -
> -		if test -e "$sm_path"/.git
> -		then
> -		(
> -			sanitize_submodule_env
> -			cd "$sm_path"
> -			remote=$(get_default_remote)
> -			git config remote."$remote".url "$sub_origin_url"
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
>  
> -			if test -n "$recursive"
> -			then
> -				prefix="$prefix$sm_path/"
> -				eval cmd_sync
> -			fi
> -		)
> -		fi
> -	done
>  }
>  
>  cmd_absorbgitdirs()
> -- 
> 2.13.0
> 

-- 
Brandon Williams
