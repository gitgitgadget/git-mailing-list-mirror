Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C9F1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHPAUy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:20:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36183 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeHPAUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:20:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so2490095wmc.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T3Dq4CKMdDd7XnUVgKVyvGKluIu7gc6zb1enByR8g0g=;
        b=muMpsGrkrMHfoIvpPO1NCbRtbD0g78xd+Zrk12mLuwaYfn7ekP+F5dG2vfWqzj9nmr
         28M/DEt+Jub1qox7hGqjDfBCi3ZCYz/CqttRiwHkj1w0gCNHR+431QxO0VLc08FtBb/2
         GFgzgQAXCzoYYy8bP0LnoOUTC+PSDCoGPmbT+g+XAFC4rLa8/AmKL+1KsuDKaA16vpwD
         STutCjiK0NXT2/k6AQM8Wo9vnEdi5uUGmlsoL4FVgA9auKOVC572pVUeTQmIdslIkMZc
         1Xfe7yAexFX3JnI7rZ+ryNbwMo6jsbs6ogwLjjMRqJKJHADnNyvd1/xy2ZjOuKY2+RPL
         2z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3Dq4CKMdDd7XnUVgKVyvGKluIu7gc6zb1enByR8g0g=;
        b=XKhAbFOpsrGGXb8qT52G2UUp7kXU81QDZzfc+t6Zv1s5f9Wh0DNmZc+qnk63RntB9W
         3kpy67FvFXH/zgvfFgvO+nUpwWL+zMm+pU6t2dayewmh8LOOCv+tNKGnBRNmf4PSOjDj
         QhgReb7XUbsetNIJ7QjXm3AIVMmnOv26OfvcdFeakLRMeh+wvG9qFdQfM5TtKkSvUtPc
         ROgylFiF78lvYE1sXjkB9mYPetbXpdtyqtLQjappYxREDy/ieyp3P1KBxtALtNmXEA5x
         u/ZzB0jrCWcZtheNELP7wwDOHh4WwgMsAVo/k//SSqt+/+flOmoIrxmlAunsQH5qmkVI
         dSIA==
X-Gm-Message-State: AOUpUlFGuuHwOOKOb0bUP0Pp9ISfqzGzFlx5Rftm9Xv6E81rauvQu37g
        rSzYiN+S0c/4bj7n6eUKiWv0U5ia
X-Google-Smtp-Source: AA+uWPyjbb2lohGIJTTwGLj2bpZVEj3+vzUZg40xZsTeTrTy/td6zPzg7d01onnAkvYsiye0NyEcuA==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr13744224wmh.103.1534368417035;
        Wed, 15 Aug 2018 14:26:57 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1727043wmh.41.2018.08.15.14.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:26:56 -0700 (PDT)
Date:   Wed, 15 Aug 2018 22:26:55 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 14/26] stash: convert store to builtin
Message-ID: <20180815212655.GP2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <84b0086287c683d33bd456957700199b22fd1c49.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b0086287c683d33bd456957700199b22fd1c49.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash store to the helper and delete the store_stash function
> from the shell script.
> 
> Add the usage string which was forgotten in the shell script.

I think similarly to 'git stash create', which also doesn't appear in
the usage, this was intentionally omitted in the shell script.  The
reason for the omission is that this is only intended to be useful in
scripts, and not in interactive usage.  As such it doesn't add much
value in showing it in 'git stash -h'.  Meanwhile it is in the
synopsis in the man page.

If we want to add it to the help output, I think it would be best to
do so in a separate commit, and for 'git stash create' as well.  But
I'm not sure that's a good change.

> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 52 +++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            | 43 ++--------------------------------
>  2 files changed, 54 insertions(+), 41 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index ec8c38c6f..5ff810f8c 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -20,6 +20,7 @@ static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
> +	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
>  	NULL
>  };
>  
> @@ -58,6 +59,11 @@ static const char * const git_stash_helper_clear_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_store_usage[] = {
> +	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
> +	NULL
> +};
> +
>  static const char *ref_stash = "refs/stash";
>  static int quiet;
>  static struct strbuf stash_index_path = STRBUF_INIT;
> @@ -731,6 +737,50 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static int do_store_stash(const char *w_commit, const char *stash_msg,
> +			  int quiet)
> +{
> +	int ret = 0;
> +	struct object_id obj;
> +
> +	if (!stash_msg)
> +		stash_msg  = xstrdup("Created via \"git stash--helper store\".");

I assume we're going to s/--helper// in a later commit?  Not sure
adding the '--helper' here is necessary, as a user would never invoke
'git stash--helper' directly, so they would expect the stash to be
created by 'git stash store'.  Anyway that's fairly minor, as I assume
this is going to change by the end of the patch series.

> +
> +	ret = get_oid(w_commit, &obj);
> +	if (!ret) {
> +		ret = update_ref(stash_msg, ref_stash, &obj, NULL,
> +				 REF_FORCE_CREATE_REFLOG,
> +				 quiet ? UPDATE_REFS_QUIET_ON_ERR :
> +				 UPDATE_REFS_MSG_ON_ERR);
> +	}
> +	if (ret && !quiet)
> +		fprintf_ln(stderr, _("Cannot update %s with %s"),
> +			   ref_stash, w_commit);
> +
> +	return ret;
> +}
> +
> +static int store_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *stash_msg = NULL;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_store_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (argc != 1) {
> +		fprintf(stderr, _("\"git stash--helper store\" requires one <commit> argument\n"));
> +		return -1;
> +	}
> +
> +	return do_store_stash(argv[0], stash_msg, quiet);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -765,6 +815,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!list_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "show"))
>  		return !!show_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "store"))
> +		return !!store_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 0d05cbc1e..5739c5152 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -191,45 +191,6 @@ create_stash () {
>  	die "$(gettext "Cannot record working tree state")"
>  }
>  
> -store_stash () {
> -	while test $# != 0
> -	do
> -		case "$1" in
> -		-m|--message)
> -			shift
> -			stash_msg="$1"
> -			;;
> -		-m*)
> -			stash_msg=${1#-m}
> -			;;
> -		--message=*)
> -			stash_msg=${1#--message=}
> -			;;
> -		-q|--quiet)
> -			quiet=t
> -			;;
> -		*)
> -			break
> -			;;
> -		esac
> -		shift
> -	done
> -	test $# = 1 ||
> -	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
> -
> -	w_commit="$1"
> -	if test -z "$stash_msg"
> -	then
> -		stash_msg="Created via \"git stash store\"."
> -	fi
> -
> -	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
> -	ret=$?
> -	test $ret != 0 && test -z "$quiet" &&
> -	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
> -	return $ret
> -}
> -
>  push_stash () {
>  	keep_index=
>  	patch_mode=
> @@ -308,7 +269,7 @@ push_stash () {
>  		clear_stash || die "$(gettext "Cannot initialize stash")"
>  
>  	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
> -	store_stash -m "$stash_msg" -q $w_commit ||
> +	git stash--helper store -m "$stash_msg" -q $w_commit ||
>  	die "$(gettext "Cannot save the current status")"
>  	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
>  
> @@ -468,7 +429,7 @@ create)
>  	;;
>  store)
>  	shift
> -	store_stash "$@"
> +	git stash--helper store "$@"
>  	;;
>  drop)
>  	shift
> -- 
> 2.18.0.573.g56500d98f
> 
