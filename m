Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6B71F453
	for <e@80x24.org>; Tue, 25 Sep 2018 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeIYXEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 19:04:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40168 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeIYXEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 19:04:21 -0400
Received: by mail-it1-f193.google.com with SMTP id h23-v6so16182073ita.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQwH0Ogp1S2X43CVUTREVbtoU4Mu33H2fxhp/ICB69I=;
        b=TT+Ar3IQ4OkVvJFuOnvk/sqV1IaaHgiORldopUYr8wi6chPfOYzq6BPSCqMBbjFos1
         Y/d1eV67JB4KttOvxMNYHYck791RQ3zVPhCzqNeNdFXAXC12SMDtHf8Q/2AOc221JEqI
         H0I3aOxcNR+0hI9BWb/7Akqla+N9Yr6PX6Mx7f7EO716JAQiRwP3E5jugju9dXcSFvx9
         E7n5ZPmb50qxGKQ5Le5CG43wCl2fuAs2cZunUNeCDGDN96QGtSfnSuVSGKMpF7uwNyxD
         Kw2fPYlz+T0mn0HZZFf0wAI7Kwz6Qo1zt3HvvDPxrqef0dtqpHjp/GLblDCOfj7v1ytB
         P/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQwH0Ogp1S2X43CVUTREVbtoU4Mu33H2fxhp/ICB69I=;
        b=h2lfetepfW6Uu5FePgD6/3quWsyLmN4W536v0K8V3Cgz2flcO4hAWE5qdCdw4LezW+
         zTaYHszkHLBja8TjVZlq6QxrIQf8FwQfzb2zsCvAfq7DIAoqpgE5ExZZo7xTMMrCzkp4
         yxSDFwYJtPx3aD74P1WLCZIzVeCvjOq4q00/YoPE0UyJNX1JqSZsELaMpkc57YGH3N3w
         XKorB8S1bMeOp9kKjlDpA2tggFIeR5ULyhfp0Y3IkMvXTDfeuV2K67q9GkYJdkhWJvlL
         5ircgNTTXV4SdTa88dI8uomhXx5CyTFdiOOUAQX3le/gwKkNypJgNUlrvNhjY98D+qtu
         lEgQ==
X-Gm-Message-State: ABuFfoi7SJh7Tcz5HQ0FJYDcWd45EkLthdIQK6mHZXST0WcQdz1SLM6a
        u99ShY2Wf6MXQ6+0RemoR4nvyHs9XtCrhBjZlnE=
X-Google-Smtp-Source: ACcGV61Ldvg5xsXJa033zE0yMV1Y4KsAy9fpKYUVwCatQqV9OdaeLIw+2POx7+G/sMs4gwUIpCq+j8z0ox5QXUVW67k=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr1603357ita.5.1537894557941;
 Tue, 25 Sep 2018 09:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
 <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com>
 <CACsJy8BKTkbc=ZgMnO7Yuk0eaqzZnifo80tnR872_T8b02biqg@mail.gmail.com> <CAGZ79kZw8-BiW5VE_YN5X2E07FeMA=XtHpjcUoSFtWNRu44fAQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZw8-BiW5VE_YN5X2E07FeMA=XtHpjcUoSFtWNRu44fAQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 18:55:31 +0200
Message-ID: <CACsJy8BRv1wb7urzriaj9AceZh-Ot1Tsb2w9rExRXkoHFn7_hw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 6:24 PM Stefan Beller <sbeller@google.com> wrote:
> > > That sounds dangerous to me. There is already a concept of
> > > local and remote-tracking branches. So I would think that local
> > > may soon become an overused word, (just like "index" today or
> > > "recursive" to a lesser extend).
> > >
> > > Could this special area be more explicit?
> > > (refs/worktree-local/ ? or after peeking at the docs below
> > > refs/un-common/ ?)
> >
> > refs/un-common sounds really "uncommon" :D. If refs/local is bad, I
> > guess we could go with either refs/worktree-local, refs/worktree,
> > refs/private, refs/per-worktree... My vote is on refs/worktree. I
>
> refs/worktree sounds good to me (I do not object), but I am not
> overly enthused either, as when I think further worktrees and
> submodules are both features with a very similar nature in that
> they touch a lot of core concepts in Git, but seem to be a niche
> feature for the masses for now.

I think the similarity is partly because submodule feature also has to
manage worktrees. My view is at some point, this "git worktree" would
be good enough that it can handle submodules as well (for the worktree
part only of course)

> For example I could think of submodules following this addressing
> mode as well: submodule/<path>/master sounds similar to the
> originally proposed worktree/<name>/<branch> convention.
> For now it is not quite clear to me why you would want to have
> access to the submodule refs in the superproject, but maybe
> the use case will come later.

Yeah. In theory we could "mount" the submodule ref store to a
superproject's ref store. I think it may be needed just for the same
reason it's needed for worktree: error reporting. If you peek into a
submodule and say "HEAD has an error", the user will get confused
whether it's superproject's HEAD or a submodule's HEAD.

> And with that said, I wonder if the "local" part should be feature agnostic,
> or if we want to be "local" for worktrees, "local" for remotes, "local"
> for submodules (i.e. our own refs vs submodule refs).

You lost me here.

>
> > think as long as the word "worktree" is in there, people would notice
> > the difference.
>
> That makes sense. But is refs/worktree shared or local? It's not quite
> obvious to me, as I could have refs/worktree/<worktree-name>/master
> instead when it is shared, so I tend to favor refs/local-worktree/ a bit
> more, but that is more typing. :/

OK I think mixing the two patches will different purposes messes you
(or me) up ;-)

refs/worktrees/xxx (and refs/main/xxx) are about visibility from other
worktrees. Or like Eric put it, they are simply aliases. These refs
are not shared because if they are, you can already see them without
new "ref mount points" like this.

refs/worktree (previously refs/local) is also per-worktree but it's
specifically because you can't have per-worktree inside "refs/" (the
only exception so far is refs/bisect which is hard coded). You can
have refs outside "refs/" (like HEAD or FETCH_HEAD) and they will not
be shared, but they cannot be iterated while those inside refs/ can
be. This is more about deciding what to share and I believe is really
worktree-specific and only matters to _current_ worktree.

Since refs/worktree is per-worktree, you can also view them from a
different worktree via refs/worktrees/. E.g. if you have
refs/worktree/foo then another worktree can see it via
refs/worktrees/xxx/refs/worktree/foo (besides pseudo refs like
refs/worktrees/xxx/HEAD)

> As we grow the worktree feature, do we ever expect the need to
> reference the current worktree?
>
> For example when there is a ref "test" that could be unique per
> repo and in the common area, so refs/heads/test would describe
> it and "test" would get there in DWIM mode.
>
> But then I could also delete the common ref and recreate a "test"
> ref in worktree A, in worktree B however DWIMming "test" could still
> refer to A's "test" as it is unique (so far) in the repository.
> And maybe I would want to check if test exists locally, so I'd
> want to ask for "self/test" (with "self" == "B" as that is my cwd).

You probably lost me again. In theory we must be able to detect
ambiguity and stop DWIMing. If you want to be ambiguity-free, you
specify full ref name, starting with "refs/" which should function
like "self/" because worktree design so far is always about the
current worktree's view.
-- 
Duy
