Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340BE1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbeCYRdO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:33:14 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36564 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbeCYRdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:33:13 -0400
Received: by mail-wr0-f169.google.com with SMTP id d10so16631690wrf.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+32hFlUtKtVCxq/sZmdFXh/tznx/T7pjzyDXLAHSOc0=;
        b=iJlZFuIOvcb+pJ/Jm8r9K9nnUfdB1ej82dYt17STbZ320Mp1/HDc8t2z5LV5S7f2e0
         hmEaCZ/Yi58Rr9gldy9CIodAuyHz1gEzvwcCQyHu2RwP3REkn7eQSZE4efeCxqb2HyRn
         EzCJymMgXbvP+B9cPY7qtq5GyXexQzfWF77B2ZBojfxGDFLFOht6KaEurGN2Os89Qv7P
         7bH824ixd9ccDv3HVMEW3iMp6BkmG0AT88iGPkxTS5YWllDgGQQJyW9r94kXR7q3dlxE
         GVcfcKTui3sSu/1D49tgS1EKRy4tPrv2OpaXXM5VmmEmKOC8FihOAB97yyVq1W+wuUWH
         oeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+32hFlUtKtVCxq/sZmdFXh/tznx/T7pjzyDXLAHSOc0=;
        b=hPcP5Ow7igpQgNflvH3tUG04ysGIDRQ4g5fMRIf/FVRibjbODjc2d+DhFC7S5aVEcq
         hlOZr0aB1Y8AMR1qDlJ9sfyYm1CdLJFBcUisk05d7K60kc8FmM8f3+CcR2HSR6alAn+4
         Ca0BvbM6EamIaw0QJx11xxyQCjigCFSl8NNa1hW62v/wwWw2hxI2YtZjReekSkxI9XW/
         wHpwu/Dguzma6G0TG6xp+9y14Gcsi5gZecibEn0NCWdOgYO6RZPobCALjIrdfuIunVSz
         gzSlDQ/jM8LxrsjVKoLZpMKePhgnusVXKWphhnwgXCgkp/lonlODIeqsu8igPah6wlvo
         EGyw==
X-Gm-Message-State: AElRT7F75aimPHZ3Kg0xzrlfuBGsg69H2Ep6YhfkgL3eVKX1f/VdZYhJ
        /7nUqThqBF6dhoYN39T97kEgkuH2
X-Google-Smtp-Source: AG47ELvmLph+azbDMwijvp39wABeeJEspcqRYxpzx8J+2wf07jQVBVHFnPNVyLm64LjLUZaWHgjmBw==
X-Received: by 10.223.156.210 with SMTP id h18mr6016278wre.109.1521999192208;
        Sun, 25 Mar 2018 10:33:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o70sm13715248wmg.3.2018.03.25.10.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 10:33:11 -0700 (PDT)
Date:   Sun, 25 Mar 2018 18:36:35 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] stash: convert pop to builtin
Message-ID: <20180325173635.GD10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net>
 <20180324173707.17699-5-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324173707.17699-5-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Joel Teichroeb wrote:
> ---
>  builtin/stash--helper.c | 38 ++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |  3 ++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 1598b82ac2..b912f84c97 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -12,6 +12,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
> +	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
> @@ -23,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_pop_usage[] = {
> +	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
>  static const char * const git_stash_helper_apply_usage[] = {
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
>  	NULL
> @@ -402,6 +408,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return do_drop_stash(prefix, &info);
>  }
>  
> +static int pop_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int index = 0;
> +	const char *commit = NULL;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_BOOL(0, "index", &index,
> +			N_("attempt to ininstate the index")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_helper_pop_usage, 0);
> +
> +	if (argc == 1)
> +		commit = argv[0];
> +
> +	if (get_stash_info(&info, commit))
> +		return -1;
> +
> +	if (!info.is_stash_ref)
> +		return error(_("'%s' is not a stash reference"), commit);

The pattern above appears twice now, is it worth factoring it out into
a separate function, similar to 'assert_stash_ref'?

> +
> +	if (do_apply_stash(prefix, &info, index))
> +		return -1;

If we fail, currently we print "The stash entry is kept in case you
need it again", which we are loosing here.  I think that's useful
output in case the 'apply' command fails, especially in the case of a
merge conflict, where I think the 'apply' will fail as well, and the
user may be confused whether/why the stash is not dropped.

> +
> +	return do_drop_stash(prefix, &info);
> +}
> +
>  static int branch_stash(int argc, const char **argv, const char *prefix)
>  {
>  	const char *commit = NULL, *branch = NULL;
> @@ -464,6 +500,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		result = clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		result = drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "pop"))
> +		result = pop_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "branch"))
>  		result = branch_stash(argc, argv, prefix);
>  	else {
> diff --git a/git-stash.sh b/git-stash.sh
> index 54d0a6c21f..d595bbaf64 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -732,7 +732,8 @@ drop)
>  	;;
>  pop)
>  	shift
> -	pop_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper pop "$@"
>  	;;
>  branch)
>  	shift
> -- 
> 2.16.2
> 
