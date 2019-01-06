Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5D6211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 22:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfAFW7m (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 17:59:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39027 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfAFW7m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 17:59:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so41438874wra.6
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 14:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRI4nLODbQyQfNgHGoku3kPp4qGRXMlw9dgw5U20AiU=;
        b=m7074l1UTbrEbyYMp86oWWRHr/3l58PSpL8UKYJUsxpv583WrsECiKBJckn5tMt87X
         KMW16ti5azk3NRIJcnymgkkLytlhNzKLvHA8uw/Bp0zMdBgbUoHtH5cWIcjkco1tMo8V
         gTQzk0nzLFx9jGT2tUVQG7lsjUfEu34NvEBlFQ8f+/JbqmiHcpzQE0+7V0Q0HlrE8E+5
         bngJq4FvBVitkat0Bc0ZOLANDRixMkcmfFnfohV3v8je5E46dv36FtP+TtivvfdgwcB7
         W5QV4QSz5JZ+XTkStpxyglSHvGjvsZjv9awy1fGDZNYQh00qhJJtHX2DtZHQaxK9FfzL
         aSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRI4nLODbQyQfNgHGoku3kPp4qGRXMlw9dgw5U20AiU=;
        b=kdPUnfAp8JLXRAZktQoazTAo6tI4y7wj4xIE8yPjio+3vV4YI1Ms/9PupvBz9zhZYx
         Y8m/Lhgfg8QRbvykXywoLlbGhKopLcZ43E2UbsQcOPktnpElCj+Vt/WNQEdVL8v7FmHM
         zEapkJGEJlUG7dKqwBn9gKFLhF1J38EwQOTLU97xlqXptCeZCFLJnFyISNF6k5eYtQkD
         y8yFqJsmyi13ixNp/wR3nViu/1Z7OSBPJ/qv81BSqBP4F6MSEqtaJ/UYBzz4OoOt0OZm
         r6fTXbgUoIy29BwrhTTHebd/2xqrrNfkDR2KwKIwk4/92nz2K39IGl32DfdjeZsZoK81
         VbQw==
X-Gm-Message-State: AJcUukcN9DLJtRhC4tIHTr6ZI1u+dl2XeI4be6kQfp1k19uihJOPQQ6Q
        acvxGQe5Os4gG1P3y9A0lpE=
X-Google-Smtp-Source: ALg8bN555MhleDAvGxOGgiO4hsbEm3t+FcNPwofIetES0jFbZZS22ppN1XsulLHsNlbE+ADqnVt0TA==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr53533307wrr.326.1546815579964;
        Sun, 06 Jan 2019 14:59:39 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id h1sm5509454wmb.0.2019.01.06.14.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 14:59:38 -0800 (PST)
Date:   Sun, 6 Jan 2019 22:59:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 25/26] stash: optionally use the scripted version
 again
Message-ID: <20190106225938.GJ25639@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <c05bb05e6eb40af1921e02711ff96350c8165cf2.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05bb05e6eb40af1921e02711ff96350c8165cf2.1545331726.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20, Paul-Sebastian Ungureanu wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We recently converted the `git stash` command from Unix shell scripts
> to builtins.
> 
> Let's end users a way out when they discover a bug in the

s/Let's/& give/ maybe?

The rest of the patch looks good to me.

> builtin command: `stash.useBuiltin`.
> 
> As the file name `git-stash` is already in use, let's rename the
> scripted backend to `git-legacy-stash`.
> 
> To make the test suite pass with `stash.useBuiltin=false`, this commit
> also backports rudimentary support for `-q` (but only *just* enough
> to appease the test suite), and adds a super-ugly hack to force exit
> code 129 for `git stash -h`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore                          |  1 +
>  Makefile                            |  1 +
>  builtin/stash.c                     | 35 +++++++++++++++++++++++++++++
>  git-stash.sh => git-legacy-stash.sh | 34 +++++++++++++++++++++++++---
>  git-sh-setup.sh                     |  1 +
>  git.c                               |  7 +++++-
>  6 files changed, 75 insertions(+), 4 deletions(-)
>  rename git-stash.sh => git-legacy-stash.sh (97%)
> 
> diff --git a/.gitignore b/.gitignore
> index 0d77ea5894..7b0164675e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -82,6 +82,7 @@
>  /git-interpret-trailers
>  /git-instaweb
>  /git-legacy-rebase
> +/git-legacy-stash
>  /git-log
>  /git-ls-files
>  /git-ls-remote
> diff --git a/Makefile b/Makefile
> index 8cee2731aa..810231a0b5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -617,6 +617,7 @@ SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
>  SCRIPT_SH += git-quiltimport.sh
>  SCRIPT_SH += git-legacy-rebase.sh
> +SCRIPT_SH += git-legacy-stash.sh
>  SCRIPT_SH += git-remote-testgit.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-submodule.sh
> diff --git a/builtin/stash.c b/builtin/stash.c
> index fe32ff42fd..346c9d2bb1 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -13,6 +13,7 @@
>  #include "revision.h"
>  #include "log-tree.h"
>  #include "diffcore.h"
> +#include "exec-cmd.h"
>  
>  #define INCLUDE_ALL_FILES 2
>  
> @@ -1513,6 +1514,26 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int use_builtin_stash(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&cp.args,
> +			 "config", "--bool", "stash.usebuiltin", NULL);
> +	cp.git_cmd = 1;
> +	if (capture_command(&cp, &out, 6)) {
> +		strbuf_release(&out);
> +		return 1;
> +	}
> +
> +	strbuf_trim(&out);
> +	ret = !strcmp("true", out.buf);
> +	strbuf_release(&out);
> +	return ret;
> +}
> +
>  int cmd_stash(int argc, const char **argv, const char *prefix)
>  {
>  	int i = -1;
> @@ -1524,6 +1545,20 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> +	if (!use_builtin_stash()) {
> +		const char *path = mkpath("%s/git-legacy-stash",
> +					  git_exec_path());
> +
> +		if (sane_execvp(path, (char **)argv) < 0)
> +			die_errno(_("could not exec %s"), path);
> +		else
> +			BUG("sane_execvp() returned???");
> +	}
> +
> +	prefix = setup_git_directory();
> +	trace_repo_setup(prefix);
> +	setup_work_tree();
> +
>  	git_config(git_diff_basic_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
> diff --git a/git-stash.sh b/git-legacy-stash.sh
> similarity index 97%
> rename from git-stash.sh
> rename to git-legacy-stash.sh
> index 789ce2f41d..8a8c4a9270 100755
> --- a/git-stash.sh
> +++ b/git-legacy-stash.sh
> @@ -80,6 +80,28 @@ clear_stash () {
>  	fi
>  }
>  
> +maybe_quiet () {
> +	case "$1" in
> +	--keep-stdout)
> +		shift
> +		if test -n "$GIT_QUIET"
> +		then
> +			eval "$@" 2>/dev/null
> +		else
> +			eval "$@"
> +		fi
> +		;;
> +	*)
> +		if test -n "$GIT_QUIET"
> +		then
> +			eval "$@" >/dev/null 2>&1
> +		else
> +			eval "$@"
> +		fi
> +		;;
> +	esac
> +}
> +
>  create_stash () {
>  
>  	prepare_fallback_ident
> @@ -112,15 +134,18 @@ create_stash () {
>  	done
>  
>  	git update-index -q --refresh
> -	if no_changes "$@"
> +	if maybe_quiet no_changes "$@"
>  	then
>  		exit 0
>  	fi
>  
>  	# state of the base commit
> -	if b_commit=$(git rev-parse --verify HEAD)
> +	if b_commit=$(maybe_quiet --keep-stdout git rev-parse --verify HEAD)
>  	then
>  		head=$(git rev-list --oneline -n 1 HEAD --)
> +	elif test -n "$GIT_QUIET"
> +	then
> +		exit 1
>  	else
>  		die "$(gettext "You do not have the initial commit yet")"
>  	fi
> @@ -315,7 +340,7 @@ push_stash () {
>  	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
>  
>  	git update-index -q --refresh
> -	if no_changes "$@"
> +	if maybe_quiet no_changes "$@"
>  	then
>  		say "$(gettext "No local changes to save")"
>  		exit 0
> @@ -370,6 +395,9 @@ save_stash () {
>  	while test $# != 0
>  	do
>  		case "$1" in
> +		-q|--quiet)
> +			GIT_QUIET=t
> +			;;
>  		--)
>  			shift
>  			break
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 378928518b..10d9764185 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -101,6 +101,7 @@ $LONG_USAGE")"
>  	case "$1" in
>  		-h)
>  		echo "$LONG_USAGE"
> +		case "$0" in *git-legacy-stash) exit 129;; esac
>  		exit
>  	esac
>  fi
> diff --git a/git.c b/git.c
> index 8a20909eae..591ebe9409 100644
> --- a/git.c
> +++ b/git.c
> @@ -554,7 +554,12 @@ static struct cmd_struct commands[] = {
>  	{ "show-index", cmd_show_index },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> -	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
> +	/*
> +	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
> +	 * longer needs redirection to the stash shell script this is kept as
> +	 * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
> +	 */
> +	{ "stash", cmd_stash },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
> -- 
> 2.20.1.441.g764a526393
> 
