Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0D41FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeARQuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:50:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38208 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeARQuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:50:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so24104876wme.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qe0zYbGZvX7OSTDRTH62kNDbvl8LSK13zyrO75mcdgc=;
        b=CAPoEY5zBrGRXrEULclBZkPUZmLlwVbkmN6hHAONmdsIxIYTcpFxd2iV7lH6J6jgQc
         4m4wmYHnT4/7wPXjEHqrqP4LKHvtUYPSNMbfrU8xMmeQs/EZQLNW2eJQ1bqFcdazko5Z
         ckaOXsffmCZ2tZAqwhkb9ME37v9E4We6H+LLAdwqf3kJA5KCnGQbrPfqw6WCay+0FVwL
         MuBF3mnen9ao1wrHKjFMLT0Ew/AU0ouHU79OLEdAIfOIQH9fdXPQzrWkNjsDDEFqJPyh
         dqtr4Om0k4uS5IpNHV7GPLtXDY9410VZZvyK7qlrSKH/R+/y+GGIh+gcgToq+SWekr0q
         oaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qe0zYbGZvX7OSTDRTH62kNDbvl8LSK13zyrO75mcdgc=;
        b=oT5k8JKZ3ZTv2Gw2SV47hjfypId6o0Ds+Muk9K3lBtQslraqlQEvgrQDmSOAAVno6O
         VZdezgzuhwHtsQb2TlbGHOXK0PDfw6Id2IZsAlNLhAXHjzPgvhQgmUPMFRbQPjcauAyB
         WFj4zXTTzwE91fYvPRSlEw/rRsUQa2sUXi5cAmoy+5KwdeqfD8phspX09EK+i6Q94+9c
         cwKjpgdWdRdavEWhYLAi/yFuVQTPPhsGa73euQljRV6l3yH/v1dAZi57t2lD92iCgoo9
         n0dbvfA7RWWLb35qrKtFegkrsh94hcQLmqTWlJ4r6q0n2n0se+/XMqk5CxNzQJgKE+LP
         Ul9Q==
X-Gm-Message-State: AKwxytdzSXXSCrzQKAO3DJoU2BSR2I/3H2P/6iQxicmG7gepYRGW7EqA
        Uva67LGTjj2/LnGkStKdRvidJ1RSoU4eUczOpCGbJw==
X-Google-Smtp-Source: ACJfBotmPs36RiNe5kSrf616Ab1CCiFfsrVRP+CVzrSTZFk45vWMJpOwpt2nXDvcYLoDaIqdciagfh41+6t3rfBBhAo=
X-Received: by 10.80.164.233 with SMTP id x38mr8767500edb.293.1516294211282;
 Thu, 18 Jan 2018 08:50:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 08:49:50 -0800 (PST)
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 08:49:50 -0800
Message-ID: <CA+P7+xqJNVPVd22nCZqXc0r66NOZsOnvpKoL-WF8WZZUgdCOyw@mail.gmail.com>
Subject: Re: [PATCH 0/8] rebase -i: offer to recreate merge commits
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Once upon a time, I dreamt of an interactive rebase that would not
> flatten branch structure, but instead recreate the commit topology
> faithfully.
>
> My original attempt was --preserve-merges, but that design was so
> limited that I did not even enable it in interactive mode.
>
> Subsequently, it *was* enabled in interactive mode, with the predictable
> consequences: as the --preserve-merges design does not allow for
> specifying the parents of merge commits explicitly, all the new commits'
> parents are defined *implicitly* by the previous commit history, and
> hence it is *not possible to even reorder commits*.
>
> This design flaw cannot be fixed. Not without a complete re-design, at
> least. This patch series offers such a re-design.
>
> Think of --recreate-merges as "--preserve-merges done right". It
> introduces new verbs for the todo list, `label`, `reset` and `merge`.
> For a commit topology like this:
>
>             A - B - C
>               \   /
>                 D
>
> the generated todo list would look like this:
>
>             # branch D
>             pick 0123 A
>             label branch-point
>             pick 1234 D
>             label D
>
>             reset branch-point
>             pick 2345 B
>             merge 3456 D C
>
> There are more patches in the pipeline, based on this patch series, but
> left for later in the interest of reviewable patch series: one mini
> series to use the sequencer even for `git rebase -i --root`, and another
> one to add support for octopus merges to --recreate-merges.
>
>

I've been looking forward to seeing this hit the list! Overall I don't
think I have any major complaints, except to make sure the special
label "onto" is documented.

I think it's possible to "reword" or "edit" the merge commit by
inserting "x false" after the merge commnd to halt the rebase and let
the user perform commands to edit, so that should work well.

Thanks for taking the time to make this a reality!

Thanks,
Jake

> Johannes Schindelin (8):
>   sequencer: introduce new commands to reset the revision
>   sequencer: introduce the `merge` command
>   sequencer: fast-forward merge commits, if possible
>   rebase-helper --make-script: introduce a flag to recreate merges
>   rebase: introduce the --recreate-merges option
>   sequencer: handle autosquash and post-rewrite for merge commands
>   pull: accept --rebase=recreate to recreate the branch topology
>   rebase -i: introduce --recreate-merges=no-rebase-cousins
>
>  Documentation/config.txt               |   8 +
>  Documentation/git-pull.txt             |   5 +-
>  Documentation/git-rebase.txt           |  13 +-
>  builtin/pull.c                         |  14 +-
>  builtin/rebase--helper.c               |  13 +-
>  builtin/remote.c                       |   2 +
>  contrib/completion/git-completion.bash |   4 +-
>  git-rebase--interactive.sh             |   6 +
>  git-rebase.sh                          |  16 +
>  refs.c                                 |   3 +-
>  sequencer.c                            | 697 ++++++++++++++++++++++++++++++++-
>  sequencer.h                            |   9 +
>  t/t3430-rebase-recreate-merges.sh      | 208 ++++++++++
>  13 files changed, 977 insertions(+), 21 deletions(-)
>  create mode 100755 t/t3430-rebase-recreate-merges.sh
>
>
> base-commit: 2512f15446149235156528dafbe75930c712b29e
> Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v1
> --
> 2.15.1.windows.2.1430.ga56c4f9e2a9
>
