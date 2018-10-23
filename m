Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE70D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 17:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeJXBzM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:55:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45193 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXBzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 21:55:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id t10-v6so2408065eds.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P925LLFN0g5U1FBwLYl2pBnl+1x7n+WlXnQ2gAXAvM0=;
        b=pNVBKPfy/pzLgwYzuiz4m333qF8KO0r4e/1c+4fYhf2cR+4k7ftaGZipu4G0ceO/yZ
         vjRhsRGYw+7s+y5UVTXK/x97c7YryCGghvMaAcw5JN/J+meV2PYdXZFj8T5XYMBeQJes
         PNDlQEtGwwg6fPCucModfiq+mJ9AClrQ1jKih/yFlnIpOfW5rzLWKrLyimdg30htWwEp
         WstmHILZ/fxinxIUugmrPfHO40KhUcHaL+QrCASlssnZG0g5Zwm175ATOWvIhcyhjOM0
         c742mtcjI3CGjuJwsbI3V23FKioj/oBZRrPFdq/pA6EoSreS0KScd6Q7c85u31N3f44J
         OksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P925LLFN0g5U1FBwLYl2pBnl+1x7n+WlXnQ2gAXAvM0=;
        b=N096HnTwUqFl+SqSANAHFWu2DZklZ1tJ2beh3a1eMtBCyPDJruPv8HhCZSl6nT4kWO
         ls/sYHEqPoB+hnQrVeFFEaqsNTXpjHYaQibtpBUcbeV3LkG7oNETmQed5tQHpNX+mRhZ
         IxEq/Kx0IiH5cDrUfZQxhZtW/jgm9TQh+/fR+gxYcOwKI/qRFXqP4RJdG2VYeC0WNJ6N
         iHfzEMkFIy7dlO4RVgiXQ6iEnHnQ+phEZ0uoqqmhcnRVjDsB1jgzTf1ipc0vAj/YPkK4
         ul3YIGyBWa0knjiikCnVsQEjczigMvCf7ZR50jEHl/SnKXhebg5exH0diG30O1BD4Xlz
         Fknw==
X-Gm-Message-State: ABuFfog3uNj/Y4a9a61vvxCVuKlJxAXxM63G7roCWqRBmbTTou8jaqk8
        dOpQTvAs3w13dXhoK9jAUnB2mB9F3Dx7bhd1GoQW9Q==
X-Google-Smtp-Source: ACcGV62WK0n1sjYo3Dp2ltyE/ELItS8H3d38HCWTLPrd5Py+78xj2Nmh3lLwhlePA10YL9rfvC/+sKHN63apsR07LfQ=
X-Received: by 2002:a50:ba89:: with SMTP id x9-v6mr17728323ede.191.1540315851506;
 Tue, 23 Oct 2018 10:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181022173935.GG30222@szeder.dev>
 <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com> <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Oct 2018 10:30:40 -0700
Message-ID: <CAGZ79kZO6tAUOjO4YCostLmogGSwMmxGHj7g1kM1fNJWqJoFUA@mail.gmail.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 2:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I actually think this round does a far nicer job playing well with
> > other topics than any earlier series.  The pain you are observing I
> > think come primarily from my not making the best use of these
> > patches.
> >
> > Steppng back a bit, I'd imagine in an ideal world where "make
> > coccicheck" can be done instantaneously _and_ the spatch machinery
> > is just as reliable as C compilers....
> >
> > What I _could_ do (and what I did do only for one round of pushing
> > out 'pu') is to queue a coccinelle transformation at the tip of
> > integration branches.  If "make coccicheck" ran in subsecond, I
> > could even automate it in the script that is used to rebuild 'pu'
> > every day, ...
>
> Anyway, even though "make coccicheck" does not run in subsecond,
> I've updated my machinery to rebuild the integration branches so
> that I can optionally queue generated coccicheck patches, and what I
> pushed out tonight has one at the tip of 'pu' and also another at
> the tip of 'next'.  The latter seems to be passing all archs and
> executing Windows run.

That is pretty exciting!

Looking at the commit in next, you also included the suggestion
from [1] to use a postincrement instead of a preincrement and I got
excited to see how we express such a thing in coccinelle,
but it turns out that it slipped in unrelated to the coccinelle patches.

How would we go from here?
It is not obvious to me how such changes would be integrated,
as regenerating them on top of pu will not help getting these changes
merged down, and applying the semantic patch on next (once
sb/more-repo-in-api lands in next) would created the merge conflicts for
all topics that are merged to next after that series.

[1] https://public-inbox.org/git/xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com/
