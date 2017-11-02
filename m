Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4156120281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964937AbdKBVT6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 17:19:58 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:51278 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964935AbdKBVT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:19:57 -0400
Received: by mail-qt0-f173.google.com with SMTP id h4so1069438qtk.8
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pKjLn5W5s9eDw/GM7rx1Ke3mHWYpuyXFXkI1xbVp3Cw=;
        b=AUZ8FJWC1vvcZUFZnRy2uU5Ao/Je6Dja/P0Vh5k24YJ7sPfzRHDRn15JT88YjY2ELI
         WWYiI8BaEr38CvrG0WYhUJCvFbOPYpso0iwTD7U0o5LxNFduiyCbpqhhIuahTa1GN6fJ
         e+UvdJ5IzCyi5FmcuZVg0rgLjPmMAkeciam2HV0bipaUbP3uDiP7ybpmzK+Xfnu/FUUE
         V9hcMt9nWuh1KcrF3MerRaDhsLR9OvMgK+SoQX8v+mFtZCJpxTrU9jWZix0IODcwC6Xw
         Jk0rz2tc7bfJ32vcbZujTYeVmh4+PbShKPzz33+Oubpg+4RrqfGSIE+bVzxDeGc2wHnG
         3DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pKjLn5W5s9eDw/GM7rx1Ke3mHWYpuyXFXkI1xbVp3Cw=;
        b=R20edixVsWckYTeVBfXtj7TYjvETK1QXdODo561/AUg48LULRM3RwPaXUnE+hPzXtR
         TxSWUfTckcRqyCP1PTLUVMvWG7U9hx0+Obo33J1HekxJApW+V8xnfqskuph8pLJsNyR6
         8KnWGYS9Pm0k+tlMMRxHJ2u+jBsRB3iAOLhyaHuvWlgTWp7fTCe5sabnmXdorxYAuZwA
         Hr6odHAWeLNNyLIlxc19PV4EC3ugGPWPVLtrFnnpywSMsxdgH4128gIgJUE9WsyOXb+H
         UUhyo1oDA3/2Cey3w4LENQpTCG7hlKtu/WMlPZzSnPa584YbFTE6ykWi8sLHQGqT1RFy
         kTmA==
X-Gm-Message-State: AMCzsaUK+t+p4ktKp8o6oA5WliUrL/gIDgvF09idtS/jrYNcvAzQJVmL
        PgN5cfNNjw2tBX2+o+Ti39s7TGYLS+8TWDTfTPvVaQ==
X-Google-Smtp-Source: ABhQp+QNKknVC0SnaZhzJ16k21ecR0vXelG7NLR6rXE44dfD3vmyHDQ1FjAOaAqUAwIkzgPvVSR2mNYpndATMQVUq2g=
X-Received: by 10.237.37.132 with SMTP id x4mr6728647qtc.224.1509657596185;
 Thu, 02 Nov 2017 14:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 14:19:55 -0700 (PDT)
In-Reply-To: <CAFA_24JXc=qJw1-_aJJUMPhW9DaBofxSb6hkVD6n4MWyeT5UOQ@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
 <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
 <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com>
 <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com> <CAFA_24JXc=qJw1-_aJJUMPhW9DaBofxSb6hkVD6n4MWyeT5UOQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 14:19:55 -0700
Message-ID: <CAGZ79kbWEe=TyqPFSc+D8HCRh3cOkGbkqFKZbpkdisjvkfiaFg@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 1:25 PM, Max Rothman <max.r.rothman@gmail.com> wrote:
> No problem! Let me know if I've done something wrong with this patch,
> I'm new to git's contributor process.

Thanks for coming up with a patch!
Yeah, the contribution process has some initial road blocks;
I'll point them out below.

> completion: add missing completions for log, diff, show

I would think this is a good commit subject as it describes
the changes made superficially

> * Add bash completion for the missing --no-* options on git log
> * Add bash completion for --textconv and --indent-heuristic families to
>   git diff and all commands that use diff's options
> * Add bash completion for --no-abbrev-commit, --expand-tabs, and
>   --no-expand-tabs to git show

This describes what happens in this patch, but not why, which helps
future readers of commit message more than the "what".
I'm also just guessing but maybe:

    A user might have configured a repo to show diffs in a certain way,
    add the --no-* options to the autocompletion to override it easier
    from the command line.
    New in this patch is autocompletion for --textconv as well as abbreviation
    options as that needs to be flipped all the time in <example workflow>.

I wonder if we really want to expose indent-heuristic,
I guess by not having it experimental any more it makes sense to do so.
c.f. https://public-inbox.org/git/20171029151228.607834-1-cmn@dwim.me/

At the end of a commit message, the Git project requires a sign off.
(See section (5) in Documentation/SubmittingPatches;
tl;dr: add Signed-off-by: NAME <EMAIL> if you can agree to
https://developercertificate.org/)

> ---
>  contrib/completion/git-completion.bash | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 0e16f017a4144..252a6c8c0c80c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1412,6 +1412,8 @@ __git_diff_common_options="--stat --numstat
> --shortstat --summary
>                         --dirstat-by-file= --cumulative
>                         --diff-algorithm=
>                         --submodule --submodule=
> +                       --indent-heuristic --no-indent-heuristic
> +                       --textconv --no-textconv
>  "
>
>  _git_diff ()
> @@ -1752,6 +1754,10 @@ _git_log ()
>                 __gitcomp "$__git_diff_submodule_formats" ""
> "${cur##--submodule=}"
>                 return
>                 ;;
> +       --no-walk=*)
> +               __gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
> +               return
> +               ;;
>         --*)
>                 __gitcomp "
>                         $__git_log_common_options
> @@ -1759,16 +1765,19 @@ _git_log ()
>                         $__git_log_gitk_options
>                         --root --topo-order --date-order --reverse
>                         --follow --full-diff
> -                       --abbrev-commit --abbrev=
> +                       --abbrev-commit --no-abbrev-commit --abbrev=
>                         --relative-date --date=
>                         --pretty= --format= --oneline
>                         --show-signature
>                         --cherry-mark
>                         --cherry-pick
>                         --graph
> -                       --decorate --decorate=
> +                       --decorate --decorate= --no-decorate
>                         --walk-reflogs
> +                       --no-walk --no-walk= --do-walk
>                         --parents --children
> +                       --expand-tabs --expand-tabs= --no-expand-tabs
> +                       --patch
>                         $merge
>                         $__git_diff_common_options
>                         --pickaxe-all --pickaxe-regex
> @@ -2816,8 +2825,9 @@ _git_show ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "--pretty= --format= --abbrev-commit --oneline
> -                       --show-signature
> +               __gitcomp "--pretty= --format= --abbrev-commit
> --no-abbrev-commit
> +                       --oneline --show-signature --patch
> +                       --expand-tabs --expand-tabs= --no-expand-tabs
>                         $__git_diff_common_options
>                         "
>                 return
>

The patch looks good, but doesn't apply because the email contains
white spaces instead of tabs. Maybe try https://submitgit.herokuapp.com/
(or fix/change your email client to send a patch; the gmail web interface
doesn't work. I personally got 'git send-email' up and running;
The Documentation/SubmittingPatches has a section on email clients, too)

Thanks,
Stefan
