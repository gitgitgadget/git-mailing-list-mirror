Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBF71F453
	for <e@80x24.org>; Sun, 30 Sep 2018 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeJAAbS (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 20:31:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJAAbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 20:31:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so11323026wrw.6
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qWP6ZlehAb8d2eTgfpQPMudmoD4PqOqd/GzpeJau3Q=;
        b=BOQ7kWQAKXfLNbAuDWIphJpEPp//eFwMfq6M1rrp1aUUVpCRRSg7h2jyckCiXlE6CH
         583uHfyhg/oaAUQ7K6iWBXR+Ql3groV//lqEG6g1q01Lmb7UO1s72WojQktyWkiopVu6
         CVqIPmGClG5WfWF+It5Pc7s/f/BQ98XN7x2bzV1sWshwN21ItBAI9B61LC9W3EbAR03i
         3xk+mdNYr0yrYsCluxx3Lh3iD1t2mEKgl7TSJ05Zj5tGVyW08l68sQObz27pq+VE+xaq
         uyYrCYMjW5uV1hUeKQrJ22aoPRu9xurhI7+iolU8YTtm+4NG7mCkEyO4/xZ5DQqY4Q3N
         YnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qWP6ZlehAb8d2eTgfpQPMudmoD4PqOqd/GzpeJau3Q=;
        b=r1RbQHKscjyauAnGETxGEyeyUDeSP+3aHttPs92TZ45TTX/VtLKnB7GFa8RsgLWFPF
         O4sx9Zyi9UfnTFKH2uDHCbTteUs+DXq5o0Ucfklz8DrzU1etTdWAgdoeS7ROExBZhc7c
         ky4XQyQIu5DqXZJgaNFBnT4aDSkdxNh9BVd7PmvtJXYrhAPvvmrH/yXNmhYOTHH76gMV
         706oIRyPBlU3x63ZidzlwHGFXuMT3dELwPDXjET6FHEA4OC/H5u7vKPrYmU3G4iybctZ
         XwhJ96UiXtjqQSXVv9aQnfgWTxLf0fCF1yh8JwnjRiDjT9hXle2saN0dU98g1EKMCTKH
         v5Tw==
X-Gm-Message-State: ABuFfoh+80zottAlHw27jUxlgT5NseuxmoJBV11/eWZ2x504h6jGNSKM
        r7Clh10L94DKJKsXNEy+2i0=
X-Google-Smtp-Source: ACcGV63BWZ5DP/mq1ELjAuHRJgGDMooUiAqWjL9Zdl/kGAPJedzJD7UuL7f6t8PIkNrfRq/10GwM4g==
X-Received: by 2002:adf:8322:: with SMTP id 31-v6mr4615314wrd.285.1538330236361;
        Sun, 30 Sep 2018 10:57:16 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id z10-v6sm7851554wrv.22.2018.09.30.10.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 10:57:15 -0700 (PDT)
Date:   Sun, 30 Sep 2018 18:57:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 09/21] stash: convert branch to builtin
Message-ID: <20180930175714.GF2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <f7b639a7b4da943884f7a4960d06ec4d2344a119.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b639a7b4da943884f7a4960d06ec4d2344a119.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Paul-Sebastian Ungureanu wrote:
> From: Joel Teichroeb <joel@teichroeb.net>
> 
> Add stash branch to the helper and delete the apply_to_branch
> function from the shell script.
> 
> Checkout does not currently provide a function for checking out
> a branch as cmd_checkout does a large amount of sanity checks
> first that we require here.
> 
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            | 17 ++-------------
>  2 files changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 72472eaeb7..5841bd0e98 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -14,6 +14,7 @@
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
>  	NULL
>  };
> @@ -28,6 +29,11 @@ static const char * const git_stash_helper_apply_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_branch_usage[] = {
> +	N_("git stash--helper branch <branchname> [<stash>]"),
> +	NULL
> +};
> +
>  static const char * const git_stash_helper_clear_usage[] = {
>  	N_("git stash--helper clear"),
>  	NULL
> @@ -536,6 +542,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int ret;
> +	const char *branch = NULL;
> +	struct stash_info info;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_branch_usage, 0);
> +
> +	if (!argc) {
> +		fprintf_ln(stderr, "No branch name specified");

This should be marked for translation.

> +		return -1;
> +	}
> +
> +	branch = argv[0];
> +
> +	if (get_stash_info(&info, argc - 1, argv + 1))
> +		return -1;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
> +	argv_array_push(&cp.args, branch);
> +	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
> +	ret = run_command(&cp);
> +	if (!ret)
> +		ret = do_apply_stash(prefix, &info, 1, 0);
> +	if (!ret && info.is_stash_ref)
> +		ret = do_drop_stash(prefix, &info, 0);
> +
> +	free_stash_info(&info);
> +
> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -562,6 +606,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		return !!drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "branch"))
> +		return !!branch_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index a99d5dc9e5..29d9f44255 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -598,20 +598,6 @@ drop_stash () {
>  	clear_stash
>  }
>  
> -apply_to_branch () {
> -	test -n "$1" || die "$(gettext "No branch name specified")"
> -	branch=$1
> -	shift 1
> -
> -	set -- --index "$@"
> -	assert_stash_like "$@"
> -
> -	git checkout -b $branch $REV^ &&
> -	apply_stash "$@" && {
> -		test -z "$IS_STASH_REF" || drop_stash "$@"
> -	}
> -}
> -
>  test "$1" = "-p" && set "push" "$@"
>  
>  PARSE_CACHE='--not-parsed'
> @@ -673,7 +659,8 @@ pop)
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
> 2.19.0.rc0.23.g1fb9f40d88
> 
