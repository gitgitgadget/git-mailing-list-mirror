Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB57520248
	for <e@80x24.org>; Thu,  7 Mar 2019 16:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGQZu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 11:25:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37609 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 11:25:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so18142642wrs.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rafaKYcSNan9o41CqiAgrcsc7G/8ziVpdJI0YmU+2CY=;
        b=XktS9/tU1Bkh51zy61OH3fBXCaA0JT/KCNR+7Y94oXfuVAZ8vXMwKPijH137KnTVdr
         prhK5hah01UqEtQ4FM/VQ69SL3SC6P65P8jIScBsvodpBZ4BJWpzbi/iNDXHaoJn8i9e
         VHfnnlvqzPggNm1P5v7nVly+9q+Y1NvTZDEtpQ0Pc/FF4hXJNM7HJZFIL1R31yYMHAez
         9Fgunid55/Pksvvvn7W0liIS1i7l6ujeESxJI9D3KCzdzSyCJ5MStvkIaz1c1RMAyRPx
         3yMgMcbnubvNgb/pKfM5+KFmbKgz6sGvxsWUd0rJo3X0RyX+LJGpwGXmy9tKz+rBLWgl
         uLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rafaKYcSNan9o41CqiAgrcsc7G/8ziVpdJI0YmU+2CY=;
        b=smpWksK9932YxEOeagXP8DpjedQ+/a9/TGnN97PMSkkryssiFLO9Y/UsIL6beyV9RA
         b+TVUtYGHg3F4W0fGdZRJVB7o14RpCmYlkHtDIkFcGW94dRsv7z+tIfxZrhqLJ+khpkq
         Q0XiaT6pvYnDbC13FZaxA7M+YcY7XSVFg2lcqx83VDOX9jlnltUdA6c2Elb363nIlYcH
         hEqWjZtHdQ/0hbXckOMJhbcigLDjVgtmSTbM5FhpzS4U55UCcxum7h4EegkKc52CMkD2
         8AEABBIurYt7GBMXMVEaQGJCwQNOl+1ORHxU6+3F5Qf+uYfD94faTCR/bgN16lK/hBLY
         HaUQ==
X-Gm-Message-State: APjAAAWnwMZJV8hiqEbFGSbPRGKcLJo8oVmtmjMXksaoteoAneEMkiTr
        3jaYBzW9kZ2UMkMFNmTZBpPBkvQa+vU=
X-Google-Smtp-Source: APXvYqxeoh04nw9ysxyO8Rxfk5OESJ50FD9RGLhYe4fy2Zv9PjGC2INeGyJqHWzEZ2AAg89l3NoIug==
X-Received: by 2002:adf:b651:: with SMTP id i17mr2570279wre.108.1551975948032;
        Thu, 07 Mar 2019 08:25:48 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id 132sm6948355wmd.30.2019.03.07.08.25.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:25:47 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] rebase: deprecate --preserve-merges
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.158.git.gitgitgadget@gmail.com>
 <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3a418266-6506-d2c0-45d3-5f1c6f0375c6@gmail.com>
Date:   Thu, 7 Mar 2019 16:25:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

It's great to see this. Do we need the deprecation warning in both 
builtin/rebase.c and rebase--preserve-merges.sh? Won't that end up 
warning twice - maybe that's a good thing but if we go for only one I 
prefer the wording in rebase--preserve-merges.sh

Best Wishes

Phillip

On 07/03/2019 10:00, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We have something much better now: --rebase-merges (which is a
> complete re-design --preserve-merges, with a lot of issues fixed such as
> the inability to reorder commits with --preserve-merges).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Documentation/config/branch.txt |  6 +++---
>   Documentation/config/pull.txt   |  6 +++---
>   Documentation/git-rebase.txt    | 23 ++++++++++++-----------
>   builtin/rebase.c                |  8 ++++++--
>   git-rebase--preserve-merges.sh  |  2 ++
>   5 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
> index 019d60ede2..8f4b3faadd 100644
> --- a/Documentation/config/branch.txt
> +++ b/Documentation/config/branch.txt
> @@ -85,9 +85,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
>   so that the local merge commits are included in the rebase (see
>   linkgit:git-rebase[1] for details).
>   +
> -When preserve, also pass `--preserve-merges` along to 'git rebase'
> -so that locally committed merge commits will not be flattened
> -by running 'git pull'.
> +When `preserve` (deprecated in favor of `merges`), also pass
> +`--preserve-merges` along to 'git rebase' so that locally committed merge
> +commits will not be flattened by running 'git pull'.
>   +
>   When the value is `interactive`, the rebase is run in interactive mode.
>   +
> diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
> index bb23a9947d..b87cab31b3 100644
> --- a/Documentation/config/pull.txt
> +++ b/Documentation/config/pull.txt
> @@ -18,9 +18,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
>   so that the local merge commits are included in the rebase (see
>   linkgit:git-rebase[1] for details).
>   +
> -When preserve, also pass `--preserve-merges` along to 'git rebase'
> -so that locally committed merge commits will not be flattened
> -by running 'git pull'.
> +When `preserve` (deprecated in favor of `merges`), also pass
> +`--preserve-merges` along to 'git rebase' so that locally committed merge
> +commits will not be flattened by running 'git pull'.
>   +
>   When the value is `interactive`, the rebase is run in interactive mode.
>   +
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 5629ba4c5d..89202dbb93 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -415,9 +415,9 @@ i.e. commits that would be excluded by gitlink:git-log[1]'s
>   the `rebase-cousins` mode is turned on, such commits are instead rebased
>   onto `<upstream>` (or `<onto>`, if specified).
>   +
> -The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
> -in contrast to that option works well in interactive rebases: commits can be
> -reordered, inserted and dropped at will.
> +The `--rebase-merges` mode is similar in spirit to the deprecated
> +`--preserve-merges`, but in contrast to that option works well in interactive
> +rebases: commits can be reordered, inserted and dropped at will.
>   +
>   It is currently only possible to recreate the merge commits using the
>   `recursive` merge strategy; Different merge strategies can be used only via
> @@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>   
>   -p::
>   --preserve-merges::
> -	Recreate merge commits instead of flattening the history by replaying
> -	commits a merge commit introduces. Merge conflict resolutions or manual
> -	amendments to merge commits are not preserved.
> +	[DEPRECATED: use --rebase-merges instead] Recreate merge commits
> +	instead of flattening the history by replaying commits a merge commit
> +	introduces. Merge conflict resolutions or manual amendments to merge
> +	commits are not preserved.
>   +
>   This uses the `--interactive` machinery internally, but combining it
>   with the `--interactive` option explicitly is generally not a good
> @@ -1020,11 +1021,11 @@ merge cmake
>   
>   BUGS
>   ----
> -The todo list presented by `--preserve-merges --interactive` does not
> -represent the topology of the revision graph.  Editing commits and
> -rewording their commit messages should work fine, but attempts to
> -reorder commits tend to produce counterintuitive results. Use
> -`--rebase-merges` in such scenarios instead.
> +The todo list presented by the deprecated `--preserve-merges --interactive`
> +does not represent the topology of the revision graph (use `--rebase-merges`
> +instead).  Editing commits and rewording their commit messages should work
> +fine, but attempts to reorder commits tend to produce counterintuitive results.
> +Use `--rebase-merges` in such scenarios instead.
>   
>   For example, an attempt to rearrange
>   ------------
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7c7bc13e91..c5f5edf321 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1092,8 +1092,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>   			parse_opt_interactive },
>   		OPT_SET_INT('p', "preserve-merges", &options.type,
> -			    N_("try to recreate merges instead of ignoring "
> -			       "them"), REBASE_PRESERVE_MERGES),
> +			    N_("(DEPRECATED) try to recreate merges instead of "
> +			       "ignoring them"), REBASE_PRESERVE_MERGES),
>   		OPT_BOOL(0, "rerere-autoupdate",
>   			 &options.allow_rerere_autoupdate,
>   			 N_("allow rerere to update index with resolved "
> @@ -1204,6 +1204,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		usage_with_options(builtin_rebase_usage,
>   				   builtin_rebase_options);
>   
> +	if (options.type == REBASE_PRESERVE_MERGES)
> +		warning(_("--preserve-merges is deprecated in favor of "
> +			  "--rebase-merges"));
> +
>   	if (action != NO_ACTION && !in_progress)
>   		die(_("No rebase in progress?"));
>   	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
> index afbb65765d..eab2e40dc6 100644
> --- a/git-rebase--preserve-merges.sh
> +++ b/git-rebase--preserve-merges.sh
> @@ -105,6 +105,8 @@ warn () {
>   	printf '%s\n' "$*" >&2
>   }
>   
> +warn "git rebase --preserve-merges is deprecated. Use --rebase-merges instead."
> +
>   # Output the commit message for the specified commit.
>   commit_message () {
>   	git cat-file commit "$1" | sed "1,/^$/d"
> 
