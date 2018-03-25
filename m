Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3A81F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeCYQ7P (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:59:15 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45597 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbeCYQ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:59:15 -0400
Received: by mail-wr0-f180.google.com with SMTP id u11so4279012wri.12
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxKRbVpJ4wi73Qu59b0qh1SQ3/BhuKD7eo9YCFwhCJQ=;
        b=FPZwMs25jHC71RM0bqrjzS/COHfCVpNH6v5/9GyoEOTiVjCkWiQrNjA8aKBJs08AtQ
         xYrYrhTWjbk7O71xSfbLW36nfyigVrYDzeoMwPbvo/n4+6GbLo33xLCMLTGH28yQGLr3
         7PhnOj+qCai8hO9QpM6dH/250JYaILyD1GgyrynWpPPo25zuWA00Ty7xYiHZKVLVnc+A
         wsW5GvGJVfIYDtyElOP2/EY2TsWpKka9Z3UMBxFe6CZkb7O5SM9BW9Zo9wh/f8B9wAFc
         4Ww4KPQNrJap1bZRu38PV+z6A1oz3fd0i/JGmmnm309L4tiH8G+EKSDhQQwzVTP+9RK7
         nudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxKRbVpJ4wi73Qu59b0qh1SQ3/BhuKD7eo9YCFwhCJQ=;
        b=kKXSWUhCphUkXleZPFvqwtjH/nIduh93KYwChFNDsSdCPcXTholOl0aJaCPxhNJoZp
         i94Hw70SG6XhLcwk9xqfdAynlv0FR6tE5d+2zisJ4VolExQGTu5bVduFjq+mgF+Rko53
         MwR335sL+AypcQ0eXOXVIm1jLthmr1NXxmEIcy/MCp5QHIpFD31IMFzCR/ndv/dDd8gl
         7MnkR20CNnwCh9Kli/kJoluloA+C0baispOsqJ/5u2DBkxly7lvEH8Su037Fs72yFX4w
         IMCjsVRlnJWJLq0QGFNZ9ePNDIsKTkns9t5zKckRYU4rMeH7OlaXszkUsSECJmAq6ASh
         nfxA==
X-Gm-Message-State: AElRT7E7bKUJ4lXz5pIlgCF6qDY406knFgx0KQ3m8qW/ZQebP34FRj2M
        wEby69WNGZd10mNQUA7Fu3Rindem
X-Google-Smtp-Source: AG47ELvA3oemROazHGRQbYqI8oSc/cALOcVHZuGHM/l+u8+hGwnSJmMNGYAqTHkkNPf/awWnmm+vKA==
X-Received: by 10.223.157.135 with SMTP id p7mr28218653wre.253.1521997153539;
        Sun, 25 Mar 2018 09:59:13 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y68sm18036945wrb.73.2018.03.25.09.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:59:12 -0700 (PDT)
Date:   Sun, 25 Mar 2018 18:02:36 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] stash: convert branch to builtin
Message-ID: <20180325170236.GB10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net>
 <20180324173707.17699-3-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324173707.17699-3-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Joel Teichroeb wrote:
> ---
>  builtin/stash--helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |  3 ++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index e9a9574f40..18c4aba665 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -12,6 +12,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	N_("git stash--helper branch <branchname> [<stash>]"),
>  	NULL
>  };
>  
> @@ -20,6 +21,11 @@ static const char * const git_stash_helper_apply_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_branch_usage[] = {
> +	N_("git stash--helper branch <branchname> [<stash>]"),
> +	NULL
> +};
> +
>  static const char *ref_stash = "refs/stash";
>  static int quiet;
>  static char stash_index_path[PATH_MAX];
> @@ -307,6 +313,42 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
>  	return do_apply_stash(prefix, &info, index);
>  }
>  
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *commit = NULL, *branch = NULL;
> +	int ret;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_helper_branch_usage, 0);
> +
> +	if (argc != 0) {
> +		branch = argv[0];
> +		if (argc == 2)
> +			commit = argv[1];
> +	}
> +
> +	if (get_stash_info(&info, commit))
> +		return -1;

I see this is supposed to do something similar to what
'assert_stash_like' was doing.  However we never end up die'ing with
"... is not a a stash-like commit" here from what I can see.  I think
I can see where this is coming from, and I missed it when reading over
1/4 here.  I'll go back and comment there, where I think we're going
slightly wrong.

Either way while I tripped over the 'get_stash_info' call here, I
think it's the right thing to do.

> +	argv_array_pushl(&args, "checkout", "-b", NULL);
> +	argv_array_push(&args, branch);
> +	argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
> +	ret = cmd_checkout(args.argc, args.argv, prefix);
> +	if (ret)
> +		return -1;
> +
> +	ret = do_apply_stash(prefix, &info, 1);
> +	if (!ret && info.is_stash_ref)
> +		ret = do_drop_stash(prefix, &info);

'do_drop_stash' is only defined in the next patch.  Maybe maybe 2/4
and 3/4 need to swap places?

All patches should compile individually, and all tests should pass for
each patch, so we maintain bisectability of the codebase.

> +
> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	int result = 0;
> @@ -329,6 +371,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		usage_with_options(git_stash_helper_usage, options);
>  	else if (!strcmp(argv[0], "apply"))
>  		result = apply_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "branch"))
> +		result = branch_stash(argc, argv, prefix);
>  	else {
>  		error(_("unknown subcommand: %s"), argv[0]);
>  		usage_with_options(git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 92c084eb17..360643ad4e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -736,7 +736,8 @@ pop)
>  	;;
>  branch)
>  	shift
> -	apply_to_branch "$@"
> +	cd "$START_DIR"
> +	git stash--helper branch "$@"
>  	;;
>  *)
>  	case $# in
> -- 
> 2.16.2
> 
