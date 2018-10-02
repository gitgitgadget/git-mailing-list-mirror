Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249101F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJCDtn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:49:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41773 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCDtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:49:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so3757206wru.8
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hy3eKKuK3v+j3ZRfkFJ/DK6xVem/n5AJm1k8BLc8mc8=;
        b=c/8e3g+r3yFtIMQ8aQbJuNHu8bbpR1By2U8SyIieHrI7y3G2qpBuMouKOfy0BXMzyb
         ovl/lJA6EEsR1YT+/Gu/ie/Eg4sHgjMc3efdtjBVX0F7hXPlxzFbIJ54a77bFzpVvFYu
         5fEnsNt7wFuiGsOQSbmaX/03mVJVt817se4qbpC7Vg9lKYxJMoWl7/Y453h8Cr71TMWN
         D0JNI3ozua0o0weNMB2lRZqf4WZIa4UedPqzQcQLb89mFnsS12JcwY0WZ4JUfpbB5xc3
         2k6CEG+ZAZLEyZlVY4EzcvU+dY2LNoE0LGp2Q/2NRy18i416VfGKYA0EjJlQTbHd/H/b
         GMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hy3eKKuK3v+j3ZRfkFJ/DK6xVem/n5AJm1k8BLc8mc8=;
        b=pr17r6terfrIVdSpEprajJMHv0GLuSS1i7OPy4PZWjA5WXAVVqQBDZq7Fyk8Oa6R4g
         tojRbkpI+zAGjdi0VoQTyaJH8xhDh6IKPNIj5BgCm03WfF6nxaqOzHbCrLvlQkTcQ1vH
         EDfkE5DeA6MogjkjuvZvkOBq6cxSKNqm+1Jr9ragZc6DmB2OpWNwfulyzLrg0HtuhX4F
         CdoJXbWmA9GdqL3Jlt1LGdNxTBkbShTGRwj+4xCff/woeErFWQX1ouEhHO8mGeY+3uVy
         TQ2brU3xE+xpNHN3IWUTSG8sXUhfgoTBfynAnRjHMdEjOFdbXDUPqRlx7HVkLntDDAHJ
         B8Rw==
X-Gm-Message-State: ABuFfoiG4D4dgBWA83FPqOO1sRUyB+7pGl0QKS6sEMdn7BloGu9F7rLa
        ycfGhB/p+LquPT9gWXGZpY6fj3Vh
X-Google-Smtp-Source: ACcGV60np2C3t8QEMI1zypLogmMZn07FxK+Pge143Rftit9lTf7pACyHa+//A1vmAuRXJUxjoVDYyg==
X-Received: by 2002:adf:b2d7:: with SMTP id g81-v6mr12437905wrd.48.1538514266565;
        Tue, 02 Oct 2018 14:04:26 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id y203-v6sm12220660wmd.1.2018.10.02.14.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 14:04:25 -0700 (PDT)
Date:   Tue, 2 Oct 2018 22:04:24 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 19/21] stash: convert `stash--helper.c` into `stash.c`
Message-ID: <20181002210424.GJ2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <2e6b0734c0185053733c0aa47d4a618cf054c67e.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6b0734c0185053733c0aa47d4a618cf054c67e.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Paul-Sebastian Ungureanu wrote:
> The old shell script `git-stash.sh`  was removed and replaced
> entirely by `builtin/stash.c`. In order to do that, `create` and
> `push` were adapted to work without `stash.sh`. For example, before
> this commit, `git stash create` called `git stash--helper create
> --message "$*"`. If it called `git stash--helper create "$@"`, then
> some of these changes wouldn't have been necessary.
> 
> This commit also removes the word `helper` since now stash is
> called directly and not by a shell script.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  .gitignore                           |   1 -
>  Makefile                             |   3 +-
>  builtin.h                            |   2 +-
>  builtin/{stash--helper.c => stash.c} | 162 ++++++++++++++++-----------
>  git-stash.sh                         | 153 -------------------------
>  git.c                                |   2 +-
>  6 files changed, 98 insertions(+), 225 deletions(-)
>  rename builtin/{stash--helper.c => stash.c} (90%)
>  delete mode 100755 git-stash.sh
>
> [...]
>
> @@ -1571,7 +1562,44 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!push_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "save"))
>  		return !!save_stash(argc, argv, prefix);
> +	else if (*argv[0] != '-')
> +		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> +			      git_stash_usage, options);
> +
> +	if (strcmp(argv[0], "-p")) {
> +		while (++i < argc && strcmp(argv[i], "--")) {
> +			/*
> +			 * `akpqu` is a string which contains all short options,
> +			 * except `-m` which is verified separately.
> +			 */
> +			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
> +			    strchr("akpqu", argv[i][1]))
> +				continue;
> +
> +			if (!strcmp(argv[i], "--all") ||
> +			    !strcmp(argv[i], "--keep-index") ||
> +			    !strcmp(argv[i], "--no-keep-index") ||
> +			    !strcmp(argv[i], "--patch") ||
> +			    !strcmp(argv[i], "--quiet") ||
> +			    !strcmp(argv[i], "--include-untracked"))
> +				continue;
> +
> +			/*
> +			 * `-m` and `--message=` are verified separately because
> +			 * they need to be immediately followed by a string
> +			 * (i.e.`-m"foobar"` or `--message="foobar"`).
> +			 */
> +			if ((strlen(argv[i]) > 2 &&
> +			     !strncmp(argv[i], "-m", 2)) ||
> +			    (strlen(argv[i]) > 10 &&
> +			     !strncmp(argv[i], "--message=", 10)))

These 'strlen && !strncmp' calls could be replaced with
'starts_with()'.

> +				continue;
> +
> +			usage_with_options(git_stash_usage, options);
> +		}
> +	}

This is a bit more complex than what we used to have, which was just
"if it starts with a "-" it's an option", but I don't think it hurts
being more explicit here either.

>  
> -	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> -		      git_stash_helper_usage, options);
> +	argv_array_push(&args, "push");
> +	argv_array_pushv(&args, argv);
> +	return !!push_stash(args.argc, args.argv, prefix);
>  }
