Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2C9202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 19:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935941AbdIYTRa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 15:17:30 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:51189 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935482AbdIYTR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 15:17:29 -0400
Received: by mail-pg0-f47.google.com with SMTP id p5so4534667pgn.7
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xasI13KHtwfur+tZL4O7JIIZ4rTbVb9oqNPw64PmPtc=;
        b=W+Zs5RhVpMWgqe3Syxz9DlGrCO+kzKsqqb6M9tor43ZbFcyfpOWhDWiC9i6ogN4IXY
         S8PxEtTXPuK+EMUmRR81dTcqUA5sQQoat+hte9a4BK+bJdN8JfutNJE5kvJLTmUczBcm
         MLFB8GMUg4LW/z3u6mGPNcV4ycZwTmcgYjOWy7OQ1uiIDMC37sDIUbP2YVtJse/swarX
         9F83lmJa6r12hDh8i2XxRwdDj6fOzvRAN8+aHyI8F9aOVXPjtIpMRH4t6dvLBkOHFp8V
         jlvr/3388SXXK3yPxCIK6WQGEc24m95wKO9GzI91yyU1FjUjeljTqYERk+BlmaPVT5G8
         RqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xasI13KHtwfur+tZL4O7JIIZ4rTbVb9oqNPw64PmPtc=;
        b=GsZCzdDVVwzLmvb97D0ElDD2lGX1oRNvJ1uU40kQUZGPYgL4BgEbHWGAn/Rl/FRf33
         LqLp2hJVc/6EDyiiJZHs2NpN+vgmE91R0EX8HZXbNOEgbPZhubhUEGtwSaCPh2VatJVF
         nls4B74rO0TQ+fwtOVfDQMfpVaigB27EAJ1c/HiRkcyekPc6XrSNA1J67ctGSrkFqdw3
         q0AgAwep7nP+6plcpOqznIHAoR4gGaEc6VWlbD5H+dF4dGWda8g+ZTbVlAebLup+7q7z
         wiHsofNJu00/JareIsCVK+JHhZcYFlYrQ8/s2B2c/706LRkrMdMIkXLvwrYuXcjQw3J2
         qF/w==
X-Gm-Message-State: AHPjjUg1wCsVPHs1DI+e08sbdOugh6Q0iKQsnBfMv4sSC19GEDX2UJLd
        azUr2rrEpv0xULgwyOp2MmZN+g==
X-Google-Smtp-Source: AOwi7QApZw3xLBQnWODVifk+CgXeQiud9b6uxaBOTXZtyF0xnamyCgKgFejk9Yg6O0e5QmHPy0URcQ==
X-Received: by 10.84.211.144 with SMTP id c16mr8692608pli.233.1506367048557;
        Mon, 25 Sep 2017 12:17:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d6e:b6b:1517:59cb])
        by smtp.gmail.com with ESMTPSA id z24sm13567612pfk.3.2017.09.25.12.17.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 12:17:27 -0700 (PDT)
Date:   Mon, 25 Sep 2017 12:17:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
Message-ID: <20170925191726.GE35385@google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
 <20170925191011.29863-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925191011.29863-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Stefan Beller wrote:
> Have one place to explain the effects of setting submodule.<name>.update
> instead of two.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> >> I disagree.  Actually, I think the git-config(1) blurb could just
> >> point here, and that the text here ought to be clear about what
> >> commands it affects and how an end user would use it.
> >
> > I tend to agree with the consolidation.
> 
> Something like this?

I like the consolidation, its easier to keep up to date when its only in
one place.

> 
>  Documentation/config.txt     |  9 +--------
>  Documentation/gitmodules.txt | 20 +++++++++++---------
>  2 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1ac0ae6adb..0d5a296b6c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3085,14 +3085,7 @@ submodule.<name>.url::
>  	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>  
>  submodule.<name>.update::
> -	The method by which a submodule is updated by 'git submodule update',
> -	which is the only affected command, others such as
> -	'git checkout --recurse-submodules' are unaffected. It exists for
> -	historical reasons, when 'git submodule' was the only command to
> -	interact with submodules; settings like `submodule.active`
> -	and `pull.rebase` are more specific. It is populated by
> -	`git submodule init` from the linkgit:gitmodules[5] file.
> -	See description of 'update' command in linkgit:git-submodule[1].
> +	See `submodule.<name>.update` in linkgit:gitmodules[5].
>  
>  submodule.<name>.branch::
>  	The remote branch name for a submodule, used by `git submodule
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index db5d47eb19..d156dee387 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -38,15 +38,17 @@ submodule.<name>.url::
>  In addition, there are a number of optional keys:
>  
>  submodule.<name>.update::
> -	Defines the default update procedure for the named submodule,
> -	i.e. how the submodule is updated by "git submodule update"
> -	command in the superproject. This is only used by `git
> -	submodule init` to initialize the configuration variable of
> -	the same name. Allowed values here are 'checkout', 'rebase',
> -	'merge' or 'none'. See description of 'update' command in
> -	linkgit:git-submodule[1] for their meaning. Note that the
> -	'!command' form is intentionally ignored here for security
> -	reasons.
> +	The method by which a submodule is updated by 'git submodule update',
> +	which is the only affected command, others such as
> +	'git checkout --recurse-submodules' are unaffected. It exists for
> +	historical reasons, when 'git submodule' was the only command to
> +	interact with submodules; settings like `submodule.active`
> +	and `pull.rebase` are more specific. It is copied to the config
> +	by `git submodule init` from the .gitmodules file.
> +	Allowed values here are 'checkout', 'rebase', 'merge' or 'none'.
> +	See description of 'update' command in linkgit:git-submodule[1]
> +	for their meaning. Note that the '!command' form is intentionally
> +	ignored here for security reasons.

This probably needs to be tweaked a bit to say that the '!command' form
is ignored by submodule init, in that it isn't copied over from the
.gitmodules file, but if it is configured in your config it will be
respected by 'submodule update'.

>  
>  submodule.<name>.branch::
>  	A remote branch name for tracking updates in the upstream submodule.
> -- 
> 2.14.0.rc0.3.g6c2e499285
> 

-- 
Brandon Williams
