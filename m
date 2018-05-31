Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288B91F42D
	for <e@80x24.org>; Thu, 31 May 2018 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEaWWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 18:22:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52549 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeEaWWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 18:22:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id 18-v6so51093014wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=87pU53GacBUWXxTZg8oGzGadTG/lsKP3xpDs1+38aJc=;
        b=fE+N2IbH3nBexk9h4UMGUHSqIkOEkJKSxzTZYoag1OxoH2rr6EheuliqYVHkKHUQy2
         2sv/275JsrOeme1yErnlCcYXLjCY4movqozcqefPDE2xaUkQcfdzHgnJhDwiTt5V29ab
         BFxSlzo6dH6DITfX9m9+CDvdJXc+fHLrii2E3jI69ct4epE+bxJcE5EQAbv17WH6oxVr
         ZrqG+cPHog4Y0vgjSXv5M7CKppMRGTbpDhKgnnRkZ/7PlZygs3wNPeHW24ANH8SvAows
         Z55S37YN9vQH9FlSTQiNIqkdvN0XRvw0neY9wtqndonD717SqBYGdRNBDsK317XHS2sO
         z39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=87pU53GacBUWXxTZg8oGzGadTG/lsKP3xpDs1+38aJc=;
        b=VlrcQnTPvyAeXmNMS8p1nFTdTp9NwSga/NufHyIP2dpdJjQnxSd714ibrmmastH2Ud
         iAJJ7tirQi0IWzWt5bCbnYYzahj1ROI+FuUZ9fiASBMbTrHQVb/Nin13jttFGZUHejTM
         HC7oGCALZ2uj05EB+sGBS6EVHcHQF2EtzO1yKkPmOT0dTm/KuJVFSRec2wPoDAr7EQgh
         zBpE/vP4xpbKJiGXOjWH1gjOpYqqwgOnjDz8Fmgf51V3zD86WdnHJpO9qZOS7FmQD2up
         MmyWvh2Fii5xlnstE1AOwhbO4IjPH4dY0ujQF/+hUmPLzrsdcV72HNaohnFBMcNHr2mc
         nmuA==
X-Gm-Message-State: APt69E1AH4fHnz3gnfguhs3bqQTFFS+zTL4Iz4rhsZHPc0SPN9l6dWtS
        B+MuMKhweWF3pxI4q4VJlGI=
X-Google-Smtp-Source: ADUXVKI0QE5OcM03k2LtX7sB5P7uVtP5h8ZEsqfIkpDBWx3GzDKlNs6dVHtjwGZFZGhlRoGTZh40nA==
X-Received: by 2002:a1c:d7c3:: with SMTP id o186-v6mr952366wmg.67.1527805337966;
        Thu, 31 May 2018 15:22:17 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q81-v6sm465875wmd.14.2018.05.31.15.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 15:22:16 -0700 (PDT)
Date:   Thu, 31 May 2018 23:22:53 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 9/9] checkout & worktree: introduce
 checkout.defaultRemote
Message-ID: <20180531222253.GD26159@hank.intra.tgummerer.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
 <20180531195252.29173-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531195252.29173-10-avarab@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, Ævar Arnfjörð Bjarmason wrote:
> Introduce a checkout.defaultRemote setting which can be used to
> designate a remote to prefer (via checkout.defaultRemote=origin) when
> running e.g. "git checkout master" to mean origin/master, even though
> there's other remotes that have the "master" branch.
> 
> I want this because it's very handy to use this workflow to checkout a
> repository and create a topic branch, then get back to a "master" as
> retrieved from upstream:
> 
>     (
>         cd /tmp &&
>         rm -rf tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git checkout master
>     )
> 
> That will output:
> 
>     Branch 'master' set up to track remote branch 'master' from 'origin'.
>     Switched to a new branch 'master'
> 
> But as soon as a new remote is added (e.g. just to inspect something
> from someone else) the DWIMery goes away:
> 
>     (
>         cd /tmp &&
>         rm -rf tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git remote add avar git@github.com:avar/tbdiff.git &&
>         git fetch avar &&
>         git checkout master
>     )
> 
> Will output (without the advice output added earlier in this series):
> 
>     error: pathspec 'master' did not match any file(s) known to git.
> 
> The new checkout.defaultRemote config allows me to say that whenever
> that ambiguity comes up I'd like to prefer "origin", and it'll still
> work as though the only remote I had was "origin".
> 
> Also adjust the advice.checkoutAmbiguousRemoteBranchName message to
> mention this new config setting to the user, the full output on my
> git.git is now (the last paragraph is new):
> 
>     $ ./git --exec-path=$PWD checkout master
>     error: pathspec 'master' did not match any file(s) known to git.
>     hint: The argument 'master' matched more than one remote tracking branch.
>     hint: We found 26 remotes with a reference that matched. So we fell back
>     hint: on trying to resolve the argument as a path, but failed there too!
>     hint:
>     hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
>     hint: instead of <name>?
>     hint:
>     hint: If you'd like to always have checkouts of 'master' prefer one remote,
>     hint: e.g. the 'origin' remote, consider setting checkout.defaultRemote=origin
>     hint: in your config. See the 'git-config' manual page for details.
> 
> I considered splitting this into checkout.defaultRemote and
> worktree.defaultRemote, but it's probably less confusing to break our
> own rules that anything shared between config should live in core.*
> than have two config settings, and I couldn't come up with a short
> name under core.* that made sense (core.defaultRemoteForCheckout?).

I agree that splitting this into two variables would be needlessly
confusing.  'checkout' and 'worktree add' are similar enough in
spirit, that users only setting one of the configuration variables
would end up confused at some point.  Because the commands are so
similar, I also feel like it would be okay to break our own rules
here, and use the 'core.defaultRemote' name you suggested (I also
can't come up with anything better in core.* right now).

> See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
> frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
> to begin with, and 4e85333197 ("worktree: make add <path> <branch>
> dwim", 2017-11-26) which added it to git-worktree.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt       | 21 ++++++++++++++++++++-
>  Documentation/git-checkout.txt |  9 +++++++++
>  Documentation/git-worktree.txt |  9 +++++++++
>  builtin/checkout.c             | 15 +++++++++++----
>  checkout.c                     | 21 ++++++++++++++++++++-
>  checkout.h                     |  5 ++++-
>  t/t2024-checkout-dwim.sh       | 12 ++++++++++++
>  t/t2025-worktree-add.sh        | 21 +++++++++++++++++++++
>  8 files changed, 106 insertions(+), 7 deletions(-)
>
> [snip]
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index ca5fc9c798..8cb77bddeb 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -38,6 +38,15 @@ equivalent to
>  $ git checkout -b <branch> --track <remote>/<branch>
>  ------------
>  +
> +If the branch exists in multiple remotes and one of them is named by
> +the `checkout.defaultRemote` configuration variable, we'll use that
> +one for the purposes of disambiguation, even if the `<branch>` isn't
> +unique across all remotes. Set it to
> +e.g. `checkout.defaultRemote=origin` to always checkout remote
> +branches from there if `<branch> is ambiguous but exists on the

s/`<branch>/&`/

> +'origin' remote. See also `checkout.defaultRemote` in
> +linkgit:git-config[1].
> ++
>  You could omit <branch>, in which case the command degenerates to
>  "check out the current branch", which is a glorified no-op with
>  rather expensive side-effects to show only the tracking information,
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index afc6576a14..6638d5ca3d 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -60,6 +60,15 @@ with a matching name, treat as equivalent to:
>  $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  ------------
>  +
> +If the branch exists in multiple remotes and one of them is named by
> +the `checkout.defaultRemote` configuration variable, we'll use that
> +one for the purposes of disambiguation, even if the `<branch>` isn't
> +unique across all remotes. Set it to
> +e.g. `checkout.defaultRemote=origin` to always checkout remote
> +branches from there if `<branch> is ambiguous but exists on the

s/`<branch>/&`/

> +'origin' remote. See also `checkout.defaultRemote` in
> +linkgit:git-config[1].
> ++
>  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
>  then, as a convenience, the new worktree is associated with a branch
>  (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
>
> [snip]
>
> -- 
> 2.17.0.290.gded63e768a
> 
