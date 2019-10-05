Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3341F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfJETW0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 15:22:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34740 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJETW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 15:22:26 -0400
Received: by mail-vs1-f65.google.com with SMTP id d3so6373994vsr.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WYYKCDou2JWk+djrJzFOYcxS3Qt3TL2wEC8HVG1jVA=;
        b=i7Fa7mllqeVZ9AWjAsSvzH0wJpZ5On1fzbvs4ClgZ2hpR4NmwpK66INhmvWtJDGjUe
         2dCogb5a1hvH2W/iM5SrG+Ikihb2BXvX6I7Ax/n9QrfQZFeFuWXXVOubtHCwFiemgcLU
         LKUi12JvH7Hrs4NajTIqiADBk/8KkRtEL+ls9a/Ee9AeBF6LqjUvP7c9CRxZQ1QS5day
         JdOQsCBsbfvF6gE5Wtt3n/cULgJCdus7BCZCt9yjO35CCk+V72lHg2zPneEDKqFXvX6O
         3FYQ3W6099SBtBo08PMp5ceB7nIspGa+anVSjR02N13PZrY8cvE57YNglOtkL1DpRA6O
         s+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WYYKCDou2JWk+djrJzFOYcxS3Qt3TL2wEC8HVG1jVA=;
        b=Uo2yibg6uAGNqbYliq1YqlM57QFa/L4XOPBw5TZ7hL3zYrV46ywJlbU/wBcm0UrIAb
         q+JeWJolB/8Bl2dxGs2IcjLNF9HA8XSqUcmVBgZHh2uoxjD0Hztzx7a3m/lNbd36nWwp
         Ion8kSpXjWnYLHzPY8zLKZE12IKZwebiX9kpTCrMnktgS6tnWO6s0KoGpbljG/zseLC9
         9XoV14rUtCSJl+1ys3C3WiWj+cFZVP4JBG5fXCix2QKicVuwNEWzocVCRXeBuo8MwA/U
         NfnsyiKSu8UuvCL0Lq2DZZWc59FEaL4VbVdJpa/yH9Q/fIdt06upPgrcatnHRu0MBewB
         fWDw==
X-Gm-Message-State: APjAAAUtJoAtFJFuFA/4qx91enRIJCwiM5akOXIJoRPSbULY2Ah5nt7K
        8WsU7YuIqp5ONkGWwJNnWR6cYWGmsvKZ71fpHhQ=
X-Google-Smtp-Source: APXvYqxEZ3oDabW70J1WGgcpqvgafPdDPHLNJUxCxTSHZ8tiQWyuL9ClMnKM2KQbylogVkirWyqGKlvTRAk735e9Lqg=
X-Received: by 2002:a67:f502:: with SMTP id u2mr11283724vsn.117.1570303344203;
 Sat, 05 Oct 2019 12:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <dbaf3de88e036fb23d7760582030726f32581a4d.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <dbaf3de88e036fb23d7760582030726f32581a4d.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 12:22:13 -0700
Message-ID: <CABPp-BEb-C=M5FQ7DhXViSooyNeify5v_5v+n6QbqQZm64jMdg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] sparse-checkout: create builtin with 'list' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 1:45 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse-checkout feature is mostly hidden to users, as its
> only documentation is supplementary information in the docs for
> 'git read-tree'. In addition, users need to know how to edit the
> .git/info/sparse-checkout file with the right patterns, then run
> the appropriate 'git read-tree -mu HEAD' command. Keeping the
> working directory in sync with the sparse-checkout file requires
> care.
>
> Begin an effort to make the sparse-checkout feature a porcelain
> feature by creating a new 'git sparse-checkout' builtin. This
> builtin will be the preferred mechanism for manipulating the
> sparse-checkout file and syncing the working directory.

Sounds good.

> The `$GIT_DIR/info/sparse-checkout` file defines the skip-
> worktree reference bitmap. When Git updates the working
> directory, it updates the skip-worktree bits in the index
> based on this file and removes or restores files in the
> working copy to match.

Does this paragraph make sense in the commit message?  It's not
explaining anything new or changing with your patch, just pre-existing
behavior, but you don't seem to reference or expound on it.

> The documentation provided is adapted from the "git read-tree"
> documentation with a few edits for clarity in the new context.
> Extra sections are added to hint toward a future change to
> a more restricted pattern set.

I think it needs a few more adaptations, as noted below...

> +SPARSE CHECKOUT
> +----------------
> +
> +"Sparse checkout" allows populating the working directory sparsely.
> +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
> +Git whether a file in the working directory is worth looking at. If
> +the skip-worktree bit is set, then the file is ignored in the working
> +directory. Git will not populate the contents of those files, which
> +makes a sparse checkout helpful when working in a repository with many
> +files, but only a few are important to the current user.
> +
> +The `$GIT_DIR/info/sparse-checkout` file is used to define the
> +skip-worktree reference bitmap. When Git updates the working
> +directory, it resets the skip-worktree bit in the index based on this
> +file. If an entry
> +matches a pattern in this file, skip-worktree will not be set on
> +that entry. Otherwise, skip-worktree will be set.
> +
> +Then it compares the new skip-worktree value with the previous one. If
> +skip-worktree turns from set to unset, it will add the corresponding
> +file back. If it turns from unset to set, that file will be removed.

I know this was just copied from elsewhere, but I still have the same
problem I mentioned last time with these paragraphs: the double
negations just make it confusing to follow.  I'd prefer e.g. replacing
the last two paragraphs above with the following (which I think you
did take but accidentally placed in the commit message instead of
using it to replace these confusing paragraphs?):

The `$GIT_DIR/info/sparse-checkout` file is used to define the
skip-worktree reference bitmap. When Git updates the working
directory, it updates the skip-worktree bits in the index based on this
file and removes or restores files in the working copy to match.

It doesn't have to be this precise wording, but something like it
which is way easier to follow than those two paragraphs you were
copying.

> +Another tricky thing is fully repopulating the working directory when you
> +no longer want sparse checkout. You cannot just disable "sparse
> +checkout" because skip-worktree bits are still in the index and your working
> +directory is still sparsely populated. You should re-populate the working
> +directory with the `$GIT_DIR/info/sparse-checkout` file content as
> +follows:
> +
> +----------------
> +/*
> +----------------
> +
> +Then you can disable sparse checkout.

I would comment on this section, but it appears you remove this
section later in your series when you add 'sparse-checkout disable',
which addresses my concern.

> Sparse checkout support in 'git
> +read-tree' and similar commands is disabled by default. You need to
> +set `core.sparseCheckout` to `true` in order to have sparse checkout
> +support.

I see you change `git read-tree` to `git checkout` later in the
series, which is good.  However, you keep the second sentence which
seems unhelpful.  Why have a 'git sparse-checkout init' command if the
user still has to manually set `core.sparseCheckout`?  Also, if we're
going to mention that setting, we should mention
extensions.worktreeConfig at the same time.  Not sure whether it'd be
better to drop the second sentence or restructure it to let the user
know that it depends on the core.sparseCheckout setting which the init
command runs, but something should probably be done.


The rest of the patch looks good.
