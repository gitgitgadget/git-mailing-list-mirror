Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AB41F453
	for <e@80x24.org>; Thu,  2 May 2019 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBOwh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:52:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50252 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:52:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so3252837wmc.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5ER9SbnGUd65bGyA0dc6A0xEZyVNvbAvgzRTMe+Z9pw=;
        b=lP5JOXKcf5F2jzPRVlXZeU+apJLYtw/VuAwSBnM2YBifTYG+57Vg9G/Qgf2729c02I
         uLgZ3gfEO3zV9zO0eksj6th6ps+6up6U9Rlvp29A/hOZyIk7yUj04xtAVsG3EUi65Wpb
         C5uAM4YiJ0lwZ1UqnGXxpny887iFZL2PPA1FjLgNcDVSri/2v6DtQcvPuDr0MvCAoTmr
         LfkyHR4o/MmXylP0ypa6IhLrHKyL99LCx4JLBxvfXu+rkUFsBuNTchOJRJJbMRCYQXZU
         T31EX6Sl2kgiEdK4jUzlqLcZzXN6YSI4VTZCcgnlPdyhhpI+jfoqkTgdTPo2cMoAhsf/
         f9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5ER9SbnGUd65bGyA0dc6A0xEZyVNvbAvgzRTMe+Z9pw=;
        b=FZmNiuX//EPalDaLhNmnilIPdA9xDspw6vRlu0xkwVWwtr2EzXLkV4IJRvqys2EiLx
         6e5OGmp4NqkQFhIxpuI6l9NvhD+8y7oEwb1BEyGiC4oh7pt0aGuGdW5eczKBIcwZaXPr
         FA/+IiXEkoTtKDhhtltoiV8PqzBGGmyz3p3BzD6pEa9KSl5JK3QS4wkzPH6ZeH/RcxVH
         Nb7W85CjQbyzqGtFKzN3xJySawdm2hjNaVeg0fDDBG5z9VvYCcSWbH0tzLV6Pb+VhYKS
         3yr3HGR9XZZ51ETyGrm+2rj2k8Wg4sOjblFrMl9uCkHBhT+sYb/gWE9HqG5wxrCUBqli
         jAyA==
X-Gm-Message-State: APjAAAV/oqxLNttGXXs1PQVz1Ukf5t0OdZob0Pog3EnwIkCMzQg8C+VO
        0qNjMq385EHdFzSZSN1LUghTDYxf
X-Google-Smtp-Source: APXvYqyuyL3LcI3PJcpfk8y124BYMo1mZ5irNCRCDD6dShDPp4RNLZhxrdD4xRSmYohmvFa/tWF/2g==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr2698276wmc.149.1556808754012;
        Thu, 02 May 2019 07:52:34 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u11sm10547216wrg.35.2019.05.02.07.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 07:52:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] rebase: deprecate --preserve-merges
References: <pull.158.git.gitgitgadget@gmail.com> <pull.158.v2.git.gitgitgadget@gmail.com> <f6990f28c028e04c5d237878d7fbb2160dd7dac9.1552334254.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <f6990f28c028e04c5d237878d7fbb2160dd7dac9.1552334254.git.gitgitgadget@gmail.com>
Date:   Thu, 02 May 2019 16:52:32 +0200
Message-ID: <87imusj4cv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 11 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We have something much better now: --rebase-merges (which is a
> complete re-design --preserve-merges, with a lot of issues fixed such as
> the inability to reorder commits with --preserve-merges).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/config/branch.txt |  6 +++---
>  Documentation/config/pull.txt   |  6 +++---
>  Documentation/git-rebase.txt    | 23 ++++++++++++-----------
>  builtin/rebase.c                |  8 ++++++--
>  4 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
> index 019d60ede2..8f4b3faadd 100644
> --- a/Documentation/config/branch.txt
> +++ b/Documentation/config/branch.txt
> @@ -85,9 +85,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
>  so that the local merge commits are included in the rebase (see
>  linkgit:git-rebase[1] for details).
>  +
> -When preserve, also pass `--preserve-merges` along to 'git rebase'
> -so that locally committed merge commits will not be flattened
> -by running 'git pull'.
> +When `preserve` (deprecated in favor of `merges`), also pass
> +`--preserve-merges` along to 'git rebase' so that locally committed merge
> +commits will not be flattened by running 'git pull'.
>  +
>  When the value is `interactive`, the rebase is run in interactive mode.
>  +
> diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
> index bb23a9947d..b87cab31b3 100644
> --- a/Documentation/config/pull.txt
> +++ b/Documentation/config/pull.txt
> @@ -18,9 +18,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
>  so that the local merge commits are included in the rebase (see
>  linkgit:git-rebase[1] for details).
>  +
> -When preserve, also pass `--preserve-merges` along to 'git rebase'
> -so that locally committed merge commits will not be flattened
> -by running 'git pull'.
> +When `preserve` (deprecated in favor of `merges`), also pass
> +`--preserve-merges` along to 'git rebase' so that locally committed merge
> +commits will not be flattened by running 'git pull'.
>  +
>  When the value is `interactive`, the rebase is run in interactive mode.
>  +
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6363d674b7..44e00329e1 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -415,9 +415,9 @@ i.e. commits that would be excluded by linkgit:git-log[1]'s
>  the `rebase-cousins` mode is turned on, such commits are instead rebased
>  onto `<upstream>` (or `<onto>`, if specified).
>  +
> -The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
> -in contrast to that option works well in interactive rebases: commits can be
> -reordered, inserted and dropped at will.
> +The `--rebase-merges` mode is similar in spirit to the deprecated
> +`--preserve-merges`, but in contrast to that option works well in interactive
> +rebases: commits can be reordered, inserted and dropped at will.
>  +
>  It is currently only possible to recreate the merge commits using the
>  `recursive` merge strategy; Different merge strategies can be used only via
> @@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>
>  -p::
>  --preserve-merges::
> -	Recreate merge commits instead of flattening the history by replaying
> -	commits a merge commit introduces. Merge conflict resolutions or manual
> -	amendments to merge commits are not preserved.
> +	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
> +	instead of flattening the history by replaying commits a merge commit
> +	introduces. Merge conflict resolutions or manual amendments to merge
> +	commits are not preserved.
>  +
>  This uses the `--interactive` machinery internally, but combining it
>  with the `--interactive` option explicitly is generally not a good
> @@ -1020,11 +1021,11 @@ merge cmake
>
>  BUGS
>  ----
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
>  For example, an attempt to rearrange
>  ------------
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 52114cbf0d..21ac10f739 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1100,8 +1100,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>  			parse_opt_interactive },
>  		OPT_SET_INT('p', "preserve-merges", &options.type,
> -			    N_("try to recreate merges instead of ignoring "
> -			       "them"), REBASE_PRESERVE_MERGES),
> +			    N_("(DEPRECATED) try to recreate merges instead of "
> +			       "ignoring them"), REBASE_PRESERVE_MERGES),
>  		OPT_BOOL(0, "rerere-autoupdate",
>  			 &options.allow_rerere_autoupdate,
>  			 N_("allow rerere to update index with resolved "
> @@ -1212,6 +1212,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>
> +	if (options.type == REBASE_PRESERVE_MERGES)
> +		warning(_("git rebase --preserve-merges is deprecated. "
> +			  "Use --rebase-merges instead."));
> +
>  	if (action != NO_ACTION && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);

An internal user reported the following "bug" they ran into:

 1. They ran "git pull --rebase=preserve"
 2. warning: git rebase --preserve-merges is deprecated. Use --rebase-merges instead.

This is very confusing, since the user issued "--rebase=preserve", *not*
"--preserve-merges".

We could detect that we came from "git pull" and pass down the argv we
used blah blah, but how about just describing things a bit more in the
warning, e.g.:

    warning: the "preserve" backend for 'git rebase' has been
    deprecated. You invoked git with "rebase --preserve-merges", either
    directly, or via "pull --rebase=preserve".

    Use the new "rebase merges" backend of "git rebase" instead, invoked
    via "rebase --rebase-merges" or "pull --rebase=merges". Note that
    the new backend may yield different results, see the "git rebase"
    documentation for details.
