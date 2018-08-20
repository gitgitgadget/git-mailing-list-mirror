Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137EB1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeHTVdd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:33:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44274 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:33:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id k25-v6so10276124uao.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfpIr2q/YIYMM8MZrdeD51plSWWfai3yAm9Rzk4RK38=;
        b=ZGWWf9gtyLF2B/5FIKBeS6wWNLJlUT6Lrrz8Rx4EA2lW2ktlqJjOGWPl/U0m5OR3f7
         zMm36AJ0YN70YKMd2v222hEr5hYVFtTDs/sTGbCCwweebvbQjlq3dCwhu1QB/fA2/d0O
         pN35osfKqWTYc7Jfyaa0/gmvF52FiSu+5UKmmRPaZT0Xr4Hi1BvQ/hZ+Q+A4s+IkgtD0
         30LQnQAAsYSjpRqJUKfq8vTVnEOYUR0YMAFUCdI00vedBRzfk754Z6YTxuL0Vc5C2mxU
         AJn99J2bMT7b72du8cx1U5TmqEHwa2pFT2ppNWpVJJRInvF1xNH/GC6S6TBb/29nYVZG
         iGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfpIr2q/YIYMM8MZrdeD51plSWWfai3yAm9Rzk4RK38=;
        b=D3d5PJoiiHQPhF5/+uUot7qDcM4HM0piKEXL2Lu3IJM75XSLK4ARSUknNZwyWWnZUg
         atJlVb6IEuLPPfOvhEz7O9Sy+G1Q0aHnlahcu2hrHmaOhpzQjOIZapIs3D85Dju314Fw
         UBW/ZBleOBHFe8jWI2wAmJ1kWbNhm8wQmNd1xzhyBbq0i6jM6CANfHsiHIm4ZzdN8gsy
         nkB1YZX7BX/1/AFibFaSrw29Pt+wGr176iSGIbkG+HDpRlFwx8aMgVWlulbu7JGSU5xl
         76OzwLLRTnSbtQ+H6Jpxrs0ZR9AhRryuaof7c14LOE+gkC9B7H2bWZbYUemrsZCG1J8w
         vtdg==
X-Gm-Message-State: AOUpUlE6x7jPlGTNxQFaByEeB53W2AMc73m9ayMMg8NvJQtRS9tcIxiS
        +p7zWELhkCmTzpC3PgzcwxiiCS/RWzMN0wTuqG0=
X-Google-Smtp-Source: AA+uWPyYauTHQwg98SP5nON6a9zpjk2GQmbLUIw3IqZ4E5whsTZg+ecebBHrNDxmz3mYlECyTWXtpnKmvMFquBi1X+o=
X-Received: by 2002:a9f:3acc:: with SMTP id q12-v6mr30760969uag.178.1534789010762;
 Mon, 20 Aug 2018 11:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com> <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com> <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
 <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com>
In-Reply-To: <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Aug 2018 11:16:39 -0700
Message-ID: <CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 6:40 AM Ben Peart <peartben@gmail.com> wrote:
> On 8/18/2018 9:44 PM, Elijah Newren wrote:
...
> > == My opinions ==
> > - The performance wins are big enough that I can see why Ben is pushing this.
> > - I totally see Duy's point that more general optimizations would be
> > really nice.
> > - I really dislike the "giant list of checks" and the ongoing
> > maintenance burden it implies.
> >
> > Overall, I have to side with Duy and say I don't think we should take
> > the patch as-is.  Since that'll be frustrating for Ben to hear, I've
> > tried to come up with some additional alternatives:
>
> Thank you for the thorough review and summary.  From my perspective, it
> is both fair and accurate.
>
...
> > - Rewrite this patch so it instead does a very small set of checks at
> > the beginning of cmd_checkout(); e.g. check if argc == 3 and argv[1]
> > == "-b" and if so then perform the minimum operations needed to create
> > and checkout the new branch (maybe even calling in to cmd_branch() and
> > cmd_symbolic_ref() and calling some reflog update function).  Preface
> > it with a comment that it's a performance hack that might eventually
> > be able to go away.
>
> I'm happy to do this if it would make the patch better/more acceptable
> to the community.

For whatever it's worth, it'd change my vote.  While I would like
general optimizations more, I do think that's overall a longer term
prospect, and the wins here are big enough to justify a performance
hack -- if the amount of new code and added maintenance overhead is
minimized.  I think that checking for the args matching checkout -b
rather than checking all flags that might imply something other than
args being checkout -b would be a good way to help minimize both.

> One other change I could do would be to address Duy's concern about the
> config option would be to remove that entirely.  That means those using
> sparse-checkout don't have the option of getting the performance win but
> the benefit is that there isn't any documentation or behavior changes
> that need to be made - things just get a lot faster if you happen to use
> the (rather common) "checkout -b" option.

Playing with sparse-checkout, it feels to me like a half-baked
feature.  It seems like it required too much manual work, and it was
sometimes hard to tell if I was misunderstanding configuration rules
or I was just running into bugs in the code.  I think I hit both but I
didn't really want to get side-tracked further, yet.  (I do want to
eventually come back to it.)  The only reason someone would go through
that pain is if it provided massive performance benefits.

Viewing things when-in-doubt through the lens of strict backwards
compatibility may inadvertently mean enforcing buggy and/or slow
behavior with sparse-checkouts.  So, while git usually focuses
strongly on backwards compatibility (which is a good thing), that
might actually be wrong in the specific case of the sparse-checkout
feature.  In particular, since the whole point of the feature is
essentially a performance hack, if the initial implementation has ways
in which it really hurts performance, it seems like it'd be more in
keeping with the point of the feature to take performance fixes and
swallow subtle behavioral changes than to require special flags to get
decent performance.

That might sound like a long winded way of saying I'm totally in favor
of dropping the config option in this case, but I'm also trying to
build a case that I think there will be other situations where we want
to subtly and maybe even not-so-subtly change behavior of
sparse-checkouts to make them both more performant and far nicer for
end users.  I'm not sure others will agree with me on this argument,
but sparse checkouts felt painful to me and I think we need something
better.

> If making these two changes would resolve the remaining concerns, I'm
> happy to make them and send another patch series.  If it will just
> result in another round of "I'm still not comfortable with this" then
> I'd rather spend my time elsewhere. :)

That's fair.  The first change would be enough to resolve the concern
for me if others strongly push back on the second
(config-option-removal) change, but I'd definitely prefer both changes
-- fewer options means less code, less ongoing maintenance work, and
less manual setup needed by users.

> > - Possibly crazy idea for massive global performance win: modify how
> > the cache works so that it can have tree entries instead of just file
> > entries; make use of that with sparse checkouts (and partial clones?)
> > so that the cache only stores a tree when that entire tree is
> > "unwanted".  Suddenly, git status, git add, git checkout, etc., etc.
> > are all much faster.  merge needs some special work to operate,
> > though.
>
> Not crazy at all!  It's something we've investigated and discussed
> several times over the past couple of years.  This is the largest
> potential optimization that I am aware of as it has the potential to
> dramatically speed up most git operations as they become O(what I care
> about) vs O(size of repo/tree) - especially when paired with partial clone.
>
> The downside is pretty obvious, pulling this off means rewriting an
> awful lot of the code!  The index is central to so much of git and the
> assumption is everywhere that the index is simply a (global) array of
> cache entries to be looped through and manipulated at will.
>
> There would be a lot of refactoring work, creating a new index
> abstraction API, updating the code to utilize it, then updating the
> internal representation of the index to optimize it around the concept
> of being sparse/partial.  Likely, we'd want/need a new on disk format
> that would support the new structures in an optimal way.  Finally, the
> various algorithms (like unpack_trees()) could be rewritten to take
> advantage of the sparseness.
>
> Not something that can be taken on lightly - but certainly something
> that has huge potential to enable git to scale to much larger repos.

Well, the amount of work involved might qualify it as a "crazy" idea.
:-)  But, I'm glad others think it sounds like a useful path to purse.
Not only would it be a tremendous help performance-wise, it might also
be beneficial for another actually-crazy feature idea of mine.
