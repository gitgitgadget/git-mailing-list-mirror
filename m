Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B366D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 00:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeLKAzI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 19:55:08 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39374 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeLKAzI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 19:55:08 -0500
Received: by mail-ed1-f44.google.com with SMTP id b14so11097893edt.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 16:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S93NkvyKnzCUpRpYGrViy+Q57V6yYW4f92bW8nuHdeg=;
        b=G6GWyj8MSmD/i+HzTakWND0KATlHkgnmGtb3Lfj9l/5TJAa3ZYgvIgHrvdMQz3aCkq
         0dPSXKpjf5x9QNNlLKrmzqMDgytykJdRUyr3qR0t3NhJ+bBVPtiZeE9GApLoMLZgXV5J
         lu1x48sdZM6uOX1RaoYgNb+vzN1O4L6UOeZhQWuc0/38MdyxEh/gXMhzWc8CIbA+p22B
         bgCivvvKtP4S822hscc7kTsQOw2OsxhbijEb4spjf6uIhrk47uvMg/BUCOc9J8KiV9v5
         uvM0mRo5X6Ol97XvmlD5iz7YcU9odRPfLsErlGluhqlS5jNjLXSYw0Ab169/TlIJWP7J
         heCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S93NkvyKnzCUpRpYGrViy+Q57V6yYW4f92bW8nuHdeg=;
        b=fKGdUThyN0ANuFw6cUD7WpBoT7hiHyCq6Y9Pst0vSE7di0cCsLmXu/EgHJntpMq9dh
         KHj0wXlGfqWuDNyISoswEbN3b906drggCmDqQB0nUVXQ0dKPeaqbq1ArVjInhxUiV4C1
         qqN/kCTWzS3qeFPGIJsJHoug1oLD6CBfCQ7GJNhMgNtrLyAyBDPihP7bB4uHP2Byn5U5
         GPOKq07/ShUsrHMS4MDw1/znDBLJrU2Sg4NnA84pnxpfaGOKKpTXF2g9H5z2UnWi383o
         RyffHdaN8sXgct4yePRCFmC13GE21iNggWm3Rlv2hf+cpjhXfAE09GGQULExUpLKfVqf
         7EuA==
X-Gm-Message-State: AA+aEWa3VhFfHCErP2CkPmX4ksINJpl2dfgrtv7XX21bMOAyqMYMn6HY
        DC/L0Ve/ApIXS3UlNCP3c1gAuHCwcryxiFCNpx1U/I8zbngR2Q==
X-Google-Smtp-Source: AFSGD/XO2kOehJZ7w7fBUBrOYD8LXSsRdPa05DcRdHlkwWmIlzv5eJpYbYYcLbeNREfISecZbLsccWmrcTmjeFBZgug=
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr10881832ejc.126.1544489705999;
 Mon, 10 Dec 2018 16:55:05 -0800 (PST)
MIME-Version: 1.0
References: <87zhtiyd45.fsf@evledraar.gmail.com> <b23422fa-8a1d-e508-a008-a2fe27b7b49f@talktalk.net>
 <CAGZ79kZVfMNELXuir+t9U8bSg2PVF=oX8aya-OqmRaP0gHRgFw@mail.gmail.com> <70f4fab1-9352-49ac-f911-da3e5a0ca172@talktalk.net>
In-Reply-To: <70f4fab1-9352-49ac-f911-da3e5a0ca172@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 16:54:54 -0800
Message-ID: <CAGZ79kap2Mja61tktcR+cKU589vFKU6jp3pBFoUrhAv1Oi3=Qg@mail.gmail.com>
Subject: Re: A case where diff.colorMoved=plain is more sensible than
 diff.colorMoved=zebra & others
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 6:43 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> On 06/12/2018 18:11, Stefan Beller wrote:
> > On Thu, Dec 6, 2018 at 6:58 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> >
> >>> So is there some "must be at least two consecutive lines" condition for
> >>> not-plain, or is something else going on here?
> >>
> >> To be considered a block has to have 20 alphanumeric characters - see
> >> commit f0b8fb6e59 ("diff: define block by number of alphanumeric chars",
> >> 2017-08-15). This stops things like random '}' lines being marked as
> >> moved on their own.
> >
> > This is spot on.
> >
> > All but the "plain" mode use the concept of "blocks" of code
> > (there is even one mode called "blocks", which adds to the confusion).
> >
> >> It might be better to use some kind of frequency
> >> information (a bit like python's difflib junk parameter) instead so that
> >> (fairly) unique short lines also get marked properly.
> >
> > Yes that is what I was initially thinking about. However to have good
> > information, you'd need to index a whole lot (the whole repository,
> > i.e. all text blobs in existence?) to get an accurate picture of frequency
> > information, which I'd prefer to call entropy as I come from a background
> > familiar with https://en.wikipedia.org/wiki/Information_theory, I am not
> > sure where 'frequency information' comes from -- it sounds like the
> > same concept.
> >
> > Of course it is too expensive to run an operation O(repository size)
> > just for this diff, so maybe we could get away with some smaller
> > corpus to build up this information on what is sufficient for coloring.
> >
> > When only looking at the given diff, I would imagine that each line
> > would not carry a whole lot of information as its characters occur
> > rather frequently compared to the rest of the diff.
>
> I was thinking of using lines rather than characters as the unit of
> information (if that's the right phrase). I was hoping that seeing how
> often a given line occurs within the set of files being diffed would be
> good enough to tell is if it is an "interesting" move or not.

That sounds reasonable. We should try that.

> In the
> mean time I wonder if decreasing the block limit to 10 alphanumeric
> characters would be enough to prevent too much noise in the output
> without suppressing matches that it would be useful to highlight.

Jonathan elegantly deferred the need to come up with data on why 20
is a good choice, but rather claimed previous art in git-blame, see
f0b8fb6e59 (diff: define block by number of alphanumeric chars,
2017-08-15), which seems to say we'd want to follow the
model of having a blame_entry_score (that counts the number
of alnum() characters per line) and the
BLAME_DEFAULT_MOVE_SCORE, which came into existence in
4a0fc95f18 (git-pickaxe: introduce heuristics to avoid "trivial" chunks,
2006-10-20), simply stating

    The current heuristics are quite simple and may need to be
    tweaked later, but we need to start somewhere.

so I guess replacing 20 by 10 is totally doable, but the proof on
why 10 is better than 20 is on you. ;-(
Probably it doesn't need to be as fancy as in 433860f3d0
(diff: improve positioning of add/delete blocks in diffs, 2016-09-05)
but we'd need to gather *some* data to convince
(s/convince/fool/)  ourselves that it is better.

It could also be the case that we need to fine tune differently
for blame as for move detection, but we could still reuse
some code to process it.
