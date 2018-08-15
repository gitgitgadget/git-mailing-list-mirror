Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D574E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeHOXNy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:13:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39788 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeHOXNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:13:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so2367491wmq.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nchSyZ6K3Te5kjjD5FON92HLuqqTLR6v7rRFKa2Bxjw=;
        b=bG02MGiMrmty0zPcG3q9ffHjK8uZrzzFpWFfoVTh2JIRaA8uFhW5YxR5eocO3enQdN
         DL3/GZoEc5BLakk/dFalhI612jdtf679qLmqq5ZuRqqaqsQapVh0DSLlTVOUbyd5Y70b
         y3bK1wL2VizoZqjmlG1v/Sz9v6vd/Es0xl13RrcDH79ylUwsWRCmGlwaLmT1HS8nKpsq
         B4bzXhy5t+yoZulBoJB4eF4z2e2RgCl/THS5Ea3vzLDoFw7kwYqWJuXM5mcbZCJEr7xk
         zq6/2fZQ1Kgsgdyap66eq9D4pzJKGZikace/iRdwpDy2dS7rWCazrx+fMQMRosEo0PO4
         DjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nchSyZ6K3Te5kjjD5FON92HLuqqTLR6v7rRFKa2Bxjw=;
        b=Nyf5CaWrZEkqKBx+7ffWFaZOGLrWhdTVw8Tn2yAGg+vJQRLoboECK+ImoTPMXwiBMS
         InQ9TtN7MOGtCi85AcOiNp+dyeIyvNbqIijj6tXf8mvZhVWfpesBoIar0o3S++X+ouD1
         SSy0w9ipyh5ZIdNh5iMnitayKaBbVW8BVZd1Xrf2dGedeWxcb49lwBNsGLE2YWMPmw2m
         STVzgA7v+ZaHNn9W7X/19dlkLfs+nBYoN/wsbSYkb8kIF6y33Zv+GPcZgdYSNm3pb6WJ
         xISoRHMOeEQ4/AaueWS0anFsWji4FNxylsyncz/TXC6lHgLPT8mKNBfWMKY4h7PaDUgx
         xMNw==
X-Gm-Message-State: AOUpUlHlDM86w3FpKwMlrrvvybYWBURusIw80LdWWvszUmikpfZdAoyd
        uK93C44PfAQMQNl+yq3dksg=
X-Google-Smtp-Source: AA+uWPxJ5Xj/rkChJdO4wIeIEtTVci1w5HEy//KTKKYzOEGDD7Ga/jbCbrLwEVKAHnIjIK4erAT14Q==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr14537990wmb.14.1534364411966;
        Wed, 15 Aug 2018 13:20:11 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id a12-v6sm25510912wru.61.2018.08.15.13.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:20:10 -0700 (PDT)
Date:   Wed, 15 Aug 2018 21:20:10 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 10/26] stash: convert show to builtin
Message-ID: <20180815202010.GL2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <05246e813c810156c07385052ec59d6dec34623e.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05246e813c810156c07385052ec59d6dec34623e.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash show to the helper and delete the show_stash, have_stash,
> assert_stash_like, is_stash_like and parse_flags_and_rev functions
> from the shell script now that they are no longer needed.
> 
> Before this commit, `git stash show` would ignore `--index` and
> `--quiet` options. Now, `git stash show` errors out on `--index`
> and does not display any message on `--quiet`, but errors out
> if the stash is not empty.

I think "errors out" is slightly misleading here.  Maybe "but exits
with an exit code similar to 'git diff'" instead?

Looking at why we ignored them before, it's because we filtered them
out in 'parse_flags_and_rev', which looks more accidental than
intentional, and I think we could consider a bug, so this change in
behaviour here is okay.

'--quiet' doesn't make too much sense to use with 'git stash show', so
I'm not sure whether or not it makes sense to support it at all.  But
we do promise to pass all options through to in our documentation, so
the new behaviour is what we are documenting.

> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c |  78 ++++++++++++++++++++++++
>  git-stash.sh            | 132 +---------------------------------------
>  2 files changed, 79 insertions(+), 131 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index daa4d0034..e764cd33e 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -13,6 +13,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper list [<options>]"),
> +	N_("git stash--helper show [<stash>]"),
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
> @@ -25,6 +26,11 @@ static const char * const git_stash_helper_list_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_show_usage[] = {
> +	N_("git stash--helper show [<stash>]"),
> +	NULL
> +};
> +
>  static const char * const git_stash_helper_drop_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	NULL
> @@ -638,6 +644,76 @@ static int list_stash(int argc, const char **argv, const char *prefix)
>  	return run_command(&cp);
>  }
>  
> +static int show_stat = 1;
> +static int show_patch;
> +
> +static int git_stash_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "stash.showStat")) {
> +		show_stat = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "stash.showPatch")) {
> +		show_patch = git_config_bool(var, value);
> +		return 0;
> +	}
> +	return git_default_config(var, value, cb);
> +}
> +
> +static int show_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int i, ret = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct argv_array args_refs = ARGV_ARRAY_INIT;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_show_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "diff");
> +
> +	/* Push arguments which are not options into args_refs. */
> +	for (i = 0; i < argc; ++i) {
> +		if (argv[i][0] == '-')
> +			argv_array_push(&cp.args, argv[i]);
> +		else
> +			argv_array_push(&args_refs, argv[i]);
> +	}
> +
> +	if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
> +		child_process_clear(&cp);
> +		argv_array_clear(&args_refs);
> +		return -1;
> +	}
> +
> +	/*
> +	 * The config settings are applied only if there are not passed
> +	 * any flags.
> +	 */
> +	if (cp.args.argc == 1) {
> +		git_config(git_stash_config, NULL);
> +		if (show_stat)
> +			argv_array_push(&cp.args, "--stat");
> +
> +		if (show_patch)
> +			argv_array_push(&cp.args, "-p");
> +	}
> +
> +	argv_array_pushl(&cp.args, oid_to_hex(&info.b_commit),
> +			 oid_to_hex(&info.w_commit), NULL);
> +
> +	ret = run_command(&cp);
> +
> +	free_stash_info(&info);
> +	argv_array_clear(&args_refs);
> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -670,6 +746,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!branch_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "list"))
>  		return !!list_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "show"))
> +		return !!show_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 6052441aa..0d05cbc1e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -378,35 +378,6 @@ save_stash () {
>  	fi
>  }
>  
> -have_stash () {
> -	git rev-parse --verify --quiet $ref_stash >/dev/null
> -}
> -
> -show_stash () {
> -	ALLOW_UNKNOWN_FLAGS=t
> -	assert_stash_like "$@"
> -
> -	if test -z "$FLAGS"
> -	then
> -		if test "$(git config --bool stash.showStat || echo true)" = "true"
> -		then
> -			FLAGS=--stat
> -		fi
> -
> -		if test "$(git config --bool stash.showPatch || echo false)" = "true"
> -		then
> -			FLAGS=${FLAGS}${FLAGS:+ }-p
> -		fi
> -
> -		if test -z "$FLAGS"
> -		then
> -			return 0
> -		fi
> -	fi
> -
> -	git diff ${FLAGS} $b_commit $w_commit
> -}
> -
>  show_help () {
>  	exec git help stash
>  	exit 1
> @@ -448,107 +419,6 @@ show_help () {
>  #   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
>  #
>  
> -parse_flags_and_rev()
> -{
> -	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
> -	PARSE_CACHE="$*"
> -
> -	IS_STASH_LIKE=
> -	IS_STASH_REF=
> -	INDEX_OPTION=
> -	s=
> -	w_commit=
> -	b_commit=
> -	i_commit=
> -	u_commit=
> -	w_tree=
> -	b_tree=
> -	i_tree=
> -	u_tree=
> -
> -	FLAGS=
> -	REV=
> -	for opt
> -	do
> -		case "$opt" in
> -			-q|--quiet)
> -				GIT_QUIET=-t
> -			;;
> -			--index)
> -				INDEX_OPTION=--index
> -			;;
> -			--help)
> -				show_help
> -			;;
> -			-*)
> -				test "$ALLOW_UNKNOWN_FLAGS" = t ||
> -					die "$(eval_gettext "unknown option: \$opt")"
> -				FLAGS="${FLAGS}${FLAGS:+ }$opt"
> -			;;
> -			*)
> -				REV="${REV}${REV:+ }'$opt'"
> -			;;
> -		esac
> -	done
> -
> -	eval set -- $REV
> -
> -	case $# in
> -		0)
> -			have_stash || die "$(gettext "No stash entries found.")"
> -			set -- ${ref_stash}@{0}
> -		;;
> -		1)
> -			:
> -		;;
> -		*)
> -			die "$(eval_gettext "Too many revisions specified: \$REV")"
> -		;;
> -	esac
> -
> -	case "$1" in
> -		*[!0-9]*)
> -			:
> -		;;
> -		*)
> -			set -- "${ref_stash}@{$1}"
> -		;;
> -	esac
> -
> -	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
> -		reference="$1"
> -		die "$(eval_gettext "\$reference is not a valid reference")"
> -	}
> -
> -	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
> -	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
> -	s=$1 &&
> -	w_commit=$1 &&
> -	b_commit=$2 &&
> -	w_tree=$3 &&
> -	b_tree=$4 &&
> -	i_tree=$5 &&
> -	IS_STASH_LIKE=t &&
> -	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
> -	IS_STASH_REF=t
> -
> -	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
> -	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
> -}
> -
> -is_stash_like()
> -{
> -	parse_flags_and_rev "$@"
> -	test -n "$IS_STASH_LIKE"
> -}
> -
> -assert_stash_like() {
> -	is_stash_like "$@" || {
> -		args="$*"
> -		die "$(eval_gettext "'\$args' is not a stash-like commit")"
> -	}
> -}
> -
>  test "$1" = "-p" && set "push" "$@"
>  
>  PARSE_CACHE='--not-parsed'
> @@ -573,7 +443,7 @@ list)
>  	;;
>  show)
>  	shift
> -	show_stash "$@"
> +	git stash--helper show "$@"
>  	;;
>  save)
>  	shift
> -- 
> 2.18.0.573.g56500d98f
> 
