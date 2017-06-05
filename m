Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44AC020D09
	for <e@80x24.org>; Mon,  5 Jun 2017 02:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdFECPW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 22:15:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36604 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdFECPU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 22:15:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so4785938pgb.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EYvtH8zzq+dslbe+bIvmOXzLHUkpZPR0ztrsDFC6Mw8=;
        b=HEKfxFxGuXeqt2eTr4lBIG9XY3Ffy3jBVL291zAnOGJ7tJy0ZNPVz/yoqPZLf5BmTL
         iYWA20Lc5l/a8Bor1zi/NKfbRsUnbYh7cxiy+GSZIQ6xndgsQH2jZiaaIvTzDWaUs76m
         93HXCndlpxAq9QgHDkHZk6fE2v5Sd/pzwo1JSCgOu10NbvwdNuFlDKTDpxVBOwSAUzwT
         lR8hfAktgzF9qo6q6KCoNn7mEW6oWnfFHhEdE72ucZFXHpBQ6B8eke6yarztIxHVNb3N
         LpMHfLfsy2LKuBtR5mFTKqytImIBHjyOiR+EUE+FOOJlXwdOMx2TBs0rcHL5e086gmYr
         KiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EYvtH8zzq+dslbe+bIvmOXzLHUkpZPR0ztrsDFC6Mw8=;
        b=JWOEo3sU6bffMsZLJauBqz6y8i50sP7MDDC6y+h1azsF+VSDGwfzFxuM8n+dTmgEuL
         pQ8mQUyPSwXjYi4fQFlo19EiF3xV23jpybxGu9DWQkbzbngrLOQuKhFOe+GoqdqlFTNP
         dhx1d+gh0/i+igKSO1Ob/TpY6fk2ZO4zowckWllfRwzQ3sw9Jz2JpPQuhH8nbTRXg2eU
         HHn+/GmmX6lrag+y+dwZZ+h78/pzBUyUl0cbxlAlsSm3P2SspACjzHNTUMIyN+VG0v7Q
         60zjEHx795g84rQlbyVJk8+oHkRb9yNv8h/LDL2iVpAF5/osDdaU4KpgsxewpojUFBC5
         AxvQ==
X-Gm-Message-State: AODbwcC9zKs5Vk0qjg69HNN9hnkMAVnTDHTgvrMSGPAIc23dmhNp4MwH
        T+YqnHkAjOrn2HLPNN8=
X-Received: by 10.98.66.131 with SMTP id h3mr5872908pfd.12.1496628919592;
        Sun, 04 Jun 2017 19:15:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id f1sm45384110pgc.8.2017.06.04.19.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 19:15:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] add setup step to filter-branch
References: <20170603101755.13619-1-asheiduk@gmail.com>
Date:   Mon, 05 Jun 2017 11:15:18 +0900
In-Reply-To: <20170603101755.13619-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Sat, 3 Jun 2017 12:17:54 +0200")
Message-ID: <xmqq1sqzuqmh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> A specific `--setup` step in `git filter-branch` makes it much easier
> to define the initial values of variables used in the real filters.
> Also sourcing/defining utility functions here instead of
> `--env-filter` improves performance and minimizes clogging the output
> in case of errors.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---

I was placed on To: line, but I do not have a strong opinion on this
change, either for or against.

"filter-branch" program itself may probably already be hard to port
to C, but I need to point out that this makes it even harder than it
currently is [*1*], and it is likely that it has to stay implemented
in shell forever, though.  I do not mind that future myself, but
those on platforms with weaker implementation of shells might.

[Footnote]

 *1* The issue is *not* that these individual filter commands expect
     <command> written as a shell scriptlet; it is that these
     scriptlets expect to be evaled inside a single shell process,
     making an update to a shell variable in one command visible to
     the next command that runs.


>  Documentation/git-filter-branch.txt | 16 +++++++++++-----
>  git-filter-branch.sh                | 18 +++++++++++++-----
>  2 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 6e4bb0220..45c849d8c 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -8,11 +8,11 @@ git-filter-branch - Rewrite branches
>  SYNOPSIS
>  --------
>  [verse]
> -'git filter-branch' [--env-filter <command>] [--tree-filter <command>]
> -	[--index-filter <command>] [--parent-filter <command>]
> -	[--msg-filter <command>] [--commit-filter <command>]
> -	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
> -	[--prune-empty]
> +'git filter-branch' [--setup <command>] [--env-filter <command>]
> +	[--tree-filter <command>] [--index-filter <command>]
> +	[--parent-filter <command>] [--msg-filter <command>]
> +	[--commit-filter <command>] [--tag-name-filter <command>]
> +	[--subdirectory-filter <directory>] [--prune-empty]
>  	[--original <namespace>] [-d <directory>] [-f | --force]
>  	[--] [<rev-list options>...]
>  
> @@ -82,6 +82,12 @@ multiple commits.
>  OPTIONS
>  -------
>  
> +--setup <command>::
> +	This is not a real filter executed for each commit but a one
> +	time setup just before the loop. Therefore no commit-specific
> +	variables are defined yet.  Functions or variables defined here
> +	can be used or modified in the following filter steps.
> +
>  --env-filter <command>::
>  	This filter may be used if you only need to modify the environment
>  	in which the commit will be performed.  Specifically, you might
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index aafaf708d..2758ae5eb 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -81,11 +81,12 @@ set_ident () {
>  	finish_ident COMMITTER
>  }
>  
> -USAGE="[--env-filter <command>] [--tree-filter <command>]
> -	[--index-filter <command>] [--parent-filter <command>]
> -	[--msg-filter <command>] [--commit-filter <command>]
> -	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
> -	[--original <namespace>] [-d <directory>] [-f | --force]
> +USAGE="[--setup <command>] [--env-filter <command>]
> +	[--tree-filter <command>] [--index-filter <command>]
> +	[--parent-filter <command>] [--msg-filter <command>]
> +	[--commit-filter <command>] [--tag-name-filter <command>]
> +	[--subdirectory-filter <directory>] [--original <namespace>]
> +	[-d <directory>] [-f | --force]
>  	[<rev-list options>...]"
>  
>  OPTIONS_SPEC=
> @@ -96,6 +97,7 @@ if [ "$(is_bare_repository)" = false ]; then
>  fi
>  
>  tempdir=.git-rewrite
> +filter_setup=
>  filter_env=
>  filter_tree=
>  filter_index=
> @@ -148,6 +150,9 @@ do
>  	-d)
>  		tempdir="$OPTARG"
>  		;;
> +	--setup)
> +		filter_setup="$OPTARG"
> +		;;
>  	--env-filter)
>  		filter_env="$OPTARG"
>  		;;
> @@ -317,6 +322,9 @@ else
>  	need_index=
>  fi
>  
> +eval "$filter_setup" < /dev/null ||
> +	die "filter setup failed: $filter_setup"
> +
>  while read commit parents; do
>  	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
