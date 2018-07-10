Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141CC1F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 21:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGJViq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:38:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43952 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJViq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:38:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so16093734wrv.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4YDhGqe+Ve+uN2rSkrjbzuD9Nd5CWq5ktkKz3qmb2HY=;
        b=JapTEDyTwDvg04aaNC3FyC+HjGEGo6OQLo+00M/PxKxuA25xIx7PpE/jdK/5LCm4oo
         Pcw6AnCFnXkkT1jgxL7m07vwiAKOZPk1ELLLPBkmgFCNsHzqArAPonxoBK3+IdFb4x96
         PZ2EzEKUlqbfdaafgfVs4m8gDRnI+TmQn6l8IzxR7MNuwhyTHsYPzdDQvsn/d9RVjmBL
         MkNdNrRhwHV5hZLXhoah/CM3Q0hLpyAB0O+eUBlzfUNLrbe4ahCM+iZ3DIMiUzW0d7eZ
         yGCa9Vbnzt8CoqvPi2sXgZAEXXI+iPRLMs64anpPP0hWqZNvP4Af9kWAjxiK+mdjFr2W
         cP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4YDhGqe+Ve+uN2rSkrjbzuD9Nd5CWq5ktkKz3qmb2HY=;
        b=rJXham7wRGiyXe0q5S+BJ99oKzuOTvJL/5oWAi5BkoYIbr7PnSSZB/ZlOaeieWwx1E
         18QuhR1lWpEHlQyiuiB9Ye2nXtK/M+19v1IexqeYZUVtEqxsqYf8zxc4Lyo/xL7YBEKT
         eNvzgTBJVCtPpgqO1TXz6IBepcMcn67YDH8WZTJl0IRsOOZ8ob9KnfjtbDFyBVOcCyKU
         EUmhkNnF4YqT5FB75APKN7XtO0IJTN85RKYMqGPwY/UShGm4GGKzxRdTuWsAYxI1LfPe
         qb++UQsJZSQ+FWlqV4u+api2WPadoSu74lub14pc3/fYpti5pk+3imd5mAVkjHoL6+BA
         htrQ==
X-Gm-Message-State: APt69E35OVtDmENKOYiBGGpmLCBjh2kvYwiqSaQuEHxNfSmz6mnK7FKK
        ACwvg3BdokYgtQWoumtKulE/JB7Y
X-Google-Smtp-Source: AAOMgpeDRmSvrCuAwZ8HNyE5kjz4HjBsHt8mwX13hkL+TE0RGS2+qbiBtCNhKQoGZOVroX00A3JhEg==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr20873940wrq.8.1531258664960;
        Tue, 10 Jul 2018 14:37:44 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 11-v6sm21420053wrw.67.2018.07.10.14.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:37:43 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:37:42 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/10] rerere: handle nested conflicts
Message-ID: <20180710213742.GA2186@hank.intra.tgummerer.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180703210515.GA31234@hank.intra.tgummerer.com>
 <xmqq1scgmemy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1scgmemy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 06/05, Thomas Gummerer wrote:
> >> The previous round was at
> >> <20180520211210.1248-1-t.gummerer@gmail.com>.
> >> 
> >> Thanks Junio for the comments on the previous round.
> >> 
> >> Changes since v2:
> >>  - lowercase the first letter in some error/warning messages before
> >>    marking them for translation
> >>  - wrap paths in output in single quotes, for consistency, and to make
> >>    some of the messages the same as ones that are already translated
> >>  - mark messages in builtin/rerere.c for translation as well, which I
> >>    had previously forgotten.
> >>  - expanded the technical documentation on rerere.  The entire
> >>    document is basically rewritten.
> >>  - changed the test in 6/10 to just fake a conflict marker inside of
> >>    one of the hunks instead of using an inner conflict created by a
> >>    merge.  This is to make sure the codepath is still hit after we
> >>    handle inner conflicts properly.
> >>  - added tests for handling inner conflict markers
> >>  - added one commit to recalculate the conflict ID when an unresolved
> >>    conflict is committed, and the subsequent operation conflicts again
> >>    in the same file.  More explanation in the commit message of that
> >>    commit.
> >
> > Now that 2.18 is out (and I'm caught up on the list after being away
> > from it for a few days), is there any interest in this series? I guess
> > it was overlooked as it's been sent in the rc phase for 2.18.
> 
> I deliberately ignored, not because I wasn't interested in it, but
> because I'd be distracted during the pre-release feature freeze as
> I'd be heavily intereseted in it.
> 
> Now is a good time to repost to stir/re-ignite the interest from
> others, possibly after rebasing on v2.18.0 and polishing further.

I sometimes find it hard to gauge whether there are no replies because
nobody is interested in the series, or if it is because it was ignored
or slipped to the cracks.  I guess I could have inferred it from your
replies to the previous iteration though :)

I'll go back and polish my patches, and then send a new iteration,
thanks! 

> Thanks.
> 
> >
> > I think the most important bit here is 6/10 which fixes a crash that
> > can happen in "normal" usage of git.  The translation bits are also
> > nice to have I think, but I could send them in a different series if
> > that's preferred.
> >
> > The other patches would be nice to have, but are arguably less
> > important.
> >
> >> range-diff below.  A few commits changed enough for range-diff
> >> to give up showing the differences in those, they are probably best
> >> reviewed as the whole patch anyway:
> >>
> >> [snip]
> >> 
> >> Thomas Gummerer (10):
> >>   rerere: unify error messages when read_cache fails
> >>   rerere: lowercase error messages
> >>   rerere: wrap paths in output in sq
> >>   rerere: mark strings for translation
> >>   rerere: add some documentation
> >>   rerere: fix crash when conflict goes unresolved
> >>   rerere: only return whether a path has conflicts or not
> >>   rerere: factor out handle_conflict function
> >>   rerere: teach rerere to handle nested conflicts
> >>   rerere: recalculate conflict ID when unresolved conflict is committed
> >> 
> >>  Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
> >>  builtin/rerere.c                   |   4 +-
> >>  rerere.c                           | 246 ++++++++++++++---------------
> >>  t/t4200-rerere.sh                  |  67 ++++++++
> >>  4 files changed, 372 insertions(+), 127 deletions(-)
> >>  create mode 100644 Documentation/technical/rerere.txt
> >> 
> >> -- 
> >> 2.18.0.rc1.242.g61856ae69
> >> 
