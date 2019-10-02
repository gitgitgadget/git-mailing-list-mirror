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
	by dcvr.yhbt.net (Postfix) with ESMTP id 131841F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfJBQqh (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 12:46:37 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44640 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJBQqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 12:46:36 -0400
Received: by mail-vk1-f193.google.com with SMTP id j21so4462789vki.11
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgT/zTwS5bpkl3WYsYiaWYwKjmpSUTcCrhH5a8z2VX8=;
        b=fZVEWizxD7L4EgtUcxXaGV7CG0gVSl2s3HtPZ1NiP19vaMS+0GN2mtcuj7Wy99w1Yz
         TnVO1Atz89dXQVMOXgAPRKRVmW0eMYZzdMRFCI43p/AKchSW+k53QarkEEeZlA3pbJud
         ZsC7qIfB1surSf5CiRdrZnT0l0PbW5q4VYmrjybdcfni2Q3J83TG4wvueJ/C1nGohfqy
         B47hSL68Knc0j0mT4R0w1fHcRfLbRBzlaxlsFbHrOlhgSv6vkplLtq4GqV1f0B1Nra+2
         jmDdV0muRqml+Yq+lfu6I+rgqWTZ3RlJq/U9zjUN/lgJlUDe0EtKlG745XWiU2otZynL
         NXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgT/zTwS5bpkl3WYsYiaWYwKjmpSUTcCrhH5a8z2VX8=;
        b=F+8aH7RAyqtTL1dd01KOaS4z4LYlhqGysZJEHdpzyF4LVMyYndlX/N5vbrzqZx+mMw
         xhKVSW7JRx595ZIj95DRIxfevjKWKCIpLjN+jbRfV+4kVUBJfDGH3aaGWymYqC5xjlzF
         btX00Fo7Khmn66fKCq03hIfGvZB7y+XiPhE2lCMNjbiN6AMk0efdNrwj+Jz8Piu7VnMB
         9LkikS/O68XZKT7lgZosXysM3Ybnr+zmfvHp3iAo56+boLAbF7v1iWOvaZAcIrqXYmZ+
         n9RPV4oZU3+z9t49QJ0jfbFiAtp0fU/LvCuRgYyDQDx9cbjj6gTPaUj0KbmhzulGhF+g
         n4+Q==
X-Gm-Message-State: APjAAAUr/qO5A6FoSNUE2/Fcc8CYu6gyHN6sb5Y9LnFGbNEQ6M/beOE1
        SmDVavKWUsjfAAXzfLv14jfkYDi5O3piKj2xj1g=
X-Google-Smtp-Source: APXvYqzGAcizhdJcjx/vwTA5ejsKE1/jNLUOsqfTLWTIgTrpi00Uv8K8gO3N9nzhEzNQlXYnq8jqD02C9Xu2A416rO8=
X-Received: by 2002:a1f:2192:: with SMTP id h140mr2375287vkh.92.1570034795130;
 Wed, 02 Oct 2019 09:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
 <CAKPyHN3G-j6p8YZmk+07Sb3tL9vua_R-hJ=W81O7vCYr07AkxA@mail.gmail.com>
 <CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com> <xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Oct 2019 09:46:23 -0700
Message-ID: <CABPp-BE6w_GJ6+N0PJBpJh=pguM85izUYCfFy=AoE53OiifAUg@mail.gmail.com>
Subject: Re: git-grep in sparse checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 11:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > * other commands (archive, bisect, clean?, gitk, shortlog, blame,
> > fsck?, etc.) likely need to pay attention to sparsity patterns as
> > well, but there are some special cases:
>
> "git archive" falls into the same class as fast-(im|ex)port; it
> should ignore the sparse cone by default.  I suspect you threw
> "fsck" as a joke, but I do not think it should pay attention to the
> sparse cone, either (besides, most of the time in fsck the objects
> subject to checking do not know all the paths that reach them).

archive in the same category as fast-(im|ex)port makes sense.  I'm not
sure if "ignore the sparse cone" by default makes sense or if it
should be a case where we error out if --ignore-sparsity-patterns
isn't specified, especially if history is also sparse.

In terms of fsck, I agree that if history is dense and the worktree is
sparse that you want to walk all history.  I was thinking further
along the lines when partial clones and sparse checkouts are combined
so that history is also sparse.  In cases where a partial clone is in
use, rather than download everything in order to walk it, wouldn't it
make more sense to have fsck walk over the bits that are already
downloaded?  I don't really know how that'd all work, but it seems
that if fsck walked over all history it'd be treated as a
useless/dangerous command by those who are doing partial clones
because the repo is just too big.

> > * merge, cherry-pick, and rebase (anything touching the merge
> > machinery) will need to expand the size of the non-sparse worktree if
> > there are files outside the sparsity patterns with conflicts.  (Though
> > merge should do a better job of not expanding the non-sparse worktree
> > when files can cleanly be resolved.)
>
> I think the important point is what is done to the result of
> operation.  Result of these operations that create new commits are
> meant to be consumed by other people, who may not share your
> definition of sparse cone.  And such a command (i.e. those whose
> results are consumed by others who may have different sparse cone)
> must be full-tree by default.
>
> > * fast-export and format-patch are not about viewing history but about
> > exporting it, and limiting to sparsity patterns would result in the
> > creation of an incompatible history.
>
> I agree with the conclusion; see above.
>
> > * New worktrees, by default, should copy the sparsity-patterns of the
> > worktree they were created from (much like a new shell inherits the
> > current working directory of it's parent process)
>
> Sorry, but I do not share this view at all.
>
> In my mental model, "worktree new" is to attach a brand-new worktree
> to a bare repository that underlies the existing worktree I happen
> to be in, and that existing worktree that I happen to type "worktree
> new" in is no more or no less special than other worktrees.
>
> The above isn't to say that I'd veto your "a new worktree inherits
> traits from an existing worktree that 'git worktree add' was invoked
> in" idea.  I am just saying that I have a problem with that mode of
> operation and mental model being the default.

If worktrees are the only area we disagree on, then I'll happily take
the stuff we agree on and can overlook this piece.

But, perhaps some further explaining on worktrees might help us reach
some middle ground. If worktrees are dense by default and folks have
not only sparse checkouts but sparse history, then creating a new
worktree would suddenly mandate downloading a lot more of history --
which could be prohibitively expensive, forcing people to instead have
N clones without any shared history.  That may be fine (I tend to not
be a heavy worktree user, I just support some users who are), but is
it the route we want to push people with big repos towards?


Thanks for the feedback on the ideas,
Elijah
