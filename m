Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184BE1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeCYSjm (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:39:42 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36142 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeCYSjl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:39:41 -0400
Received: by mail-wm0-f50.google.com with SMTP id x82so11572357wmg.1
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASL/OM0DSHho9dYLP0NKDIsvaMNMwSyhGKK4IqObahI=;
        b=dXcvTfm7BUuVNfaDzUstupj2TN4VE20XjXQgUAljqSwKRo+1Cww0ZTObFXpRJ3LWBy
         g9i4Ql9t7aH10Vm2LONc2JgeagFj3RMho6E76kTgl5JA7SPjRuP4TWMcDSjvEY5ngtts
         40uWRVwqSIadSmoHdFQe3QBWM7nJPU7tXL/E/cSVvBbSsONFqnDt1pkP7gmqDJClUV91
         epKOtdy9kByv82vqU3Hlabe+1rdhPp7NgS4cGgPhcMySGZcgzHfyNppGQHwaQOSRXtmN
         I7tPiFzA2AZNpZIq4ZJGF0TexI/ktnjt9nhkANKT2M2krXKiAjNyHMpbCbyR406nI8FM
         mKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASL/OM0DSHho9dYLP0NKDIsvaMNMwSyhGKK4IqObahI=;
        b=M9ngj0FQUOm+wjvvUNBmmKy7n9QNo2Sm0tSM5ijZq9GDHkB/PxKzUPEyAFlqrE4kcq
         YpqfwFCoN80YvYUjVrFcSHnN7ooyl3i+pBKAOFZQYWcipIpn/61vbDj+2GpnPXcFnZsO
         G+u4O5u0gsmsxLX+uB/7T8oClMeN/qp+XOSebnSgR+cuIeXD072RYDrM9eIRs7blPuxa
         +Co/T7/+3C38LzzCGndWkbyx8TcnLpH8ZGXrwoD3ROqs7a79lZrkeAvOA+VzS1keHpU3
         6erH+4OjeIW2gZsnltN5cbm/TRmXnW0iWrBsEJ7clh6oIvsYKTUktzJX2TZhauY9P5TC
         7CHg==
X-Gm-Message-State: AElRT7FCA0LesIx7Zd6bkP8sHpjKbHeYHQTk4jgrP6VZ/N1CQjhmYYmv
        TSPQV6e2TpHj0uMrkf4txxI=
X-Google-Smtp-Source: AIpwx48InCzgwjP6mXpnNdmT8iIkRuBAX9XF0/S7uwNhv2fUts2aAHvrsDSK1IbVj8u3Ll45CrEhHg==
X-Received: by 10.28.153.215 with SMTP id b206mr5895383wme.91.1522003180299;
        Sun, 25 Mar 2018 11:39:40 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q9sm12564993wrf.11.2018.03.25.11.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 11:39:39 -0700 (PDT)
Date:   Sun, 25 Mar 2018 19:43:03 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
Message-ID: <20180325184303.GF10909@hank>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Paul-Sebastian Ungureanu wrote:
> Currently, because git stash is not fully converted to C, I
> introduced a new helper that will hold the converted commands.

Missing sign-off?  I think it's a good idea to sign off your work even
for RFC patches that you don't expect to be applied.  If for nothing
else, it helps people not wonder whether you just forgot the sign-off
or if you intentionally didn't add it.

> ---
>  Makefile                |  1 +
>  builtin.h               |  1 +
>  builtin/stash--helper.c | 52 +++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |  7 +-----
>  git.c                   |  1 +
>  5 files changed, 56 insertions(+), 6 deletions(-)
>  create mode 100644 builtin/stash--helper.c
> 
> diff --git a/Makefile b/Makefile
> index a1d8775ad..8ca361c57 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1020,6 +1020,7 @@ BUILTIN_OBJS += builtin/send-pack.o
>  BUILTIN_OBJS += builtin/shortlog.o
>  BUILTIN_OBJS += builtin/show-branch.o
>  BUILTIN_OBJS += builtin/show-ref.o
> +BUILTIN_OBJS += builtin/stash--helper.o
>  BUILTIN_OBJS += builtin/stripspace.o
>  BUILTIN_OBJS += builtin/submodule--helper.o
>  BUILTIN_OBJS += builtin/symbolic-ref.o
> diff --git a/builtin.h b/builtin.h
> index 42378f3aa..2ddb4bd5c 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -220,6 +220,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
>  extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
>  extern int cmd_status(int argc, const char **argv, const char *prefix);
>  extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
> +extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
>  extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
>  extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_tag(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> new file mode 100644
> index 000000000..61fd5390d
> --- /dev/null
> +++ b/builtin/stash--helper.c
> @@ -0,0 +1,52 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "argv-array.h"
> +
> +enum {
> +	LIST_STASH = 1
> +};
> +
> +static const char * ref_stash = "refs/stash";
> +
> +static const char * const git_stash__helper_usage[] = {
> +	N_("git stash--helper --list [<options>]"),
> +	NULL
> +};
> +
> +static int list_stash(int argc, const char **argv, const char *prefix)
> +{
> +	struct object_id obj;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +
> +	if (get_oid(ref_stash, &obj))
> +		return 0;
> +
> +	argv_array_pushl(&args, "log", "--format=%gd: %gs", "-g", "--first-parent", "-m", NULL);
> +	argv_array_pushv(&args, argv);
> +	argv_array_push(&args, ref_stash);

This is missing the final '--' argument to 'git log'.  It's needed to
disambiguate the ref from paths.  If we don't have that, this git log
call will fail when a "refs/stash" directory exists.

> +	return !!cmd_log(args.argc, args.argv, prefix);
> +}
> +
> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int cmdmode = 0;
> +
> +	struct option options[] = {
> +		OPT_CMDMODE(0, "list", &cmdmode,
> +			 N_("list stash entries"), LIST_STASH),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash__helper_usage, PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (!cmdmode)
> +		usage_with_options(git_stash__helper_usage, options);
> +
> +	switch (cmdmode) {
> +		case LIST_STASH:
> +			return list_stash(argc, argv, prefix);
> +	}
> +	return 0;
> +}
> diff --git a/git-stash.sh b/git-stash.sh
> index fc8f8ae64..a5b9f5fb6 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -380,11 +380,6 @@ have_stash () {
>  	git rev-parse --verify --quiet $ref_stash >/dev/null
>  }
>  
> -list_stash () {
> -	have_stash || return 0
> -	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
> -}
> -
>  show_stash () {
>  	ALLOW_UNKNOWN_FLAGS=t
>  	assert_stash_like "$@"
> @@ -695,7 +690,7 @@ test -n "$seen_non_option" || set "push" "$@"
>  case "$1" in
>  list)
>  	shift
> -	list_stash "$@"
> +	git stash--helper --list "$@"
>  	;;
>  show)
>  	shift
> diff --git a/git.c b/git.c
> index 96cd734f1..6fd2ccd9a 100644
> --- a/git.c
> +++ b/git.c
> @@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
>  	{ "show-branch", cmd_show_branch, RUN_SETUP },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "stash--helper", cmd_stash__helper, RUN_SETUP },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
> -- 
> 2.16.2.647.gb9d10dde1
> 
