Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FE11F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGPWhA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:37:00 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46567 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbeGPWg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:36:59 -0400
Received: by mail-ua0-f196.google.com with SMTP id r18-v6so25834690ual.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1V0wyubf16Ki6wGvDVQavin5i/XaY5pC2YBvJb8yEy0=;
        b=im5X0qXT/dhrldVeVGZd3R1HgV6hIYpiS2AippQd0p8J29TmQhAQmasWg2tR85bvJP
         6GFivne8+oMB141NErt/L1QlGx/ibUpM74mLuqtcApzTHMC7HZ14J8YlVi1F7UOO8eMk
         m1tIkBfQAM1Yb/dH7yxF+zA7Nk9jiD3b61yLnQV3Lq1Cm57ujArafXKwKzJ0o2eWgjXO
         6mc+9aX1cSysaKt1hgnpn1XquNIoq8EMLWhSjfAi1j8P4BW1Jbq8Hd6zNZ/d3cVd6amU
         dyCTUCEM1DB4ULBjqQffOMZqrNuMMQ23FB7QmIDMw/k5TPpE77z+KIeKOky9bigA5X46
         GhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1V0wyubf16Ki6wGvDVQavin5i/XaY5pC2YBvJb8yEy0=;
        b=R00/lXJreST8stBP707UGjCzQXQKzqraGOrkY2xA2q4fdiWo7/ns6ZcLefUCbfPg1a
         wP+L3aJEWq+bajX2pD3GNS248VdJdSO+/n0kK+XRHzHj0MVjDR+a1yGigqF9p/HolVX7
         yU8XSs5draa9H9O7wGnJqpHUw3WgwW/1DcvE22Bz5x70J9afMkH4L1iBF84iYwsY7PG6
         r6VcpYnBD703Pp54O9Wy9yrfoxT7NoCRMypLLrR0Q41jRYlXY5XjsZiw8ZOb1ZYLxta2
         QFYNuvaSK41jX3GtlyHi1wFwtCEKl/RFyZq2Ut3PCZZxbR65CjZ25PUbQ60JsMpNeOGS
         X+GA==
X-Gm-Message-State: AOUpUlFB7iWsh2dYxF+UIqi7DHnzmLoZ+u8Pez0PkqxVdLsWqDy0M2Uz
        7X92GKBNEQk1YYuM2V2cSv2hEUPRrv2SGft/YIvSKw==
X-Google-Smtp-Source: AAOMgpdXkIc2YKaGcFJ/h+1/kOvOKQ+QX9TBL3ua1U4Y5+Lkt9LiFRbU17W63c7arr0TyDBuBUjByQszhcyMl8plA/s=
X-Received: by 2002:ab0:66d4:: with SMTP id d20-v6mr6285615uaq.112.1531778855293;
 Mon, 16 Jul 2018 15:07:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 15:07:34
 -0700 (PDT)
In-Reply-To: <20180716212159.GH25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com> <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
 <20180716203847.GE25189@sigill.intra.peff.net> <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
 <20180716212159.GH25189@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Jul 2018 15:07:34 -0700
Message-ID: <CABPp-BHFinoE1=1bOhiwOrYpLB+kB3yAKbNg77K9kqKDH_1JLA@mail.gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 2:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 02:09:43PM -0700, Elijah Newren wrote:

>> The point of gc is to: expire reflogs, repack referenced objects, and
>> delete loose objects that (1) are no longer referenced and (2) are
>> "old enough".
>>
>> The "old enough" bit is the special part here.  Before the gc, those
>> objects were referenced (only by old reflog entries) and were found in
>> a pack.  git currently writes those objects out to disk and gives them
>> the age of the packfile they are contained in, which I think is the
>> source of the bug.  We have a reference for those objects from the
>> reflogs, know they aren't referenced anywhere else, so those objects
>> to me are the age of those reflog entries: 90 days.  As such, they are
>> "old enough" and should be deleted.
>
> OK, I see what you're saying, but...
>
>> I never got around to fixing it properly, though, because 'git prune'
>> is such a handy workaround that for now.  Having people nuke all their
>> loose objects is a bit risky, but the only other workaround people had
>> was to re-clone (waiting the requisite 20+ minutes for the repo to
>> download) and throw away their old clone.  (Though some people even
>> went that route, IIRC.)
>
> If we were to delete those objects, wouldn't it be exactly the same as
> running "git prune"? Or setting your gc.pruneExpire to "now" or even "5
> minutes"?  Or are you concerned with taking other objects along for the
> ride that weren't part of old reflogs? I think that's a valid concern,

Yes, I was worried about taking other objects along for the ride that
weren't part of old reflogs.

> but it's also an issue for objects which were previously referenced in
> a reflog, but are part of another current operation.

I'm not certain what you're referring to here.

> Also, what do you do if there weren't reflogs in the repo? Or the
> reflogs were deleted (e.g., because branch deletion drops the associated
> reflog entirely)?

Yes, there are issues this rule won't help with, but in my experience
it was a primary (if not sole) actual cause in practice.  (I believe I
even said elsewhere in this thread that I knew there were unreachable
objects for other reasons and they might also become large in number).
At $DAYJOB we've had multiple people including myself hit the "too
many unreachable loose objects" nasty loop issue (some of us multiple
different times), and as far as I can tell, most (perhaps even all) of
them would have been avoided by just "properly" deleting garbage as
per my object-age-is-reflog-age-if-not-otherwise-referenced rule.

>> With big repos, it's easy to get into situations where there are well
>> more than 10000 objects satisfying these conditions.  In fact, it's
>> not all that rare that the repo has far more loose objects after a git
>> gc than before.
>
> Yes, this is definitely a wart and I think is worth addressing.
>
>> I totally agree with your general plan to put unreferenced loose
>> objects into a pack.  However, I don't think these objects should be
>> part of that pack; they should just be deleted instead.
>
> I assume by "these objects" you mean ones which used to be reachable
> from a reflog, but that reflog entry just expired.  I think you'd be
> sacrificing some race-safety in that case.

Is that inherently any more race unsafe than 'git prune
--expire=2.weeks.ago'?  I thought it'd be racy in the same ways, and
thus a tradeoff folks are already accepting (at least implicitly) when
running git-gc.  Since these objects are actually 90 days old rather
than a mere two weeks, it actually seemed more safe to me.  But maybe
I'm overlooking something with the pack->loose transition that makes
it more racy?

> If the objects went into a pack under a race-proof scheme, would that
> actually bother you? Is it the 10,000 objects that's a problem, or is it
> the horrible I/O from exploding them coupled with the annoying auto-gc
> behavior?

Yeah, good point.  It's mostly the annoying auto-gc behavior and the
horrible I/O of future git operations from having lots of loose
objects.  They've already been paying the cost of storing those
objects in packed form for 90 days; a few more won't hurt much.  I'd
be slightly annoyed knowing that we're storing garbage we don't need
to be, but I don't think it's a real issue.
