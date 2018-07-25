Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5BE1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeGYSvz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:51:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40920 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbeGYSvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:51:55 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so9777746ita.5
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeVKQAm6yuSXR83ICvKdUEseT6p/YRcKtWx6/pqIJ9s=;
        b=dO0/r3i7sAYTN2KwFSRxP8vpTyfk90zRARRFaXLDVkuRVhRNPfy5ZnTb168CQaYAlX
         MbRY32Bz2vQrrNXnf2BaL7b1voAHmWMt98iQHGghbUQ8adcuKQ0odlpx7DgaXaUbBXKD
         e8Z4fvC+tj0OwUPVlVSNAe5lrx5JXBGHvxL1MnXUu5faReNCngmr+zcwVSjSK+OKKGWp
         0l0o0FCrvl7/7ONecVXbo5a5tmibvqsaU6yj2OFkXnUzpK9jaghAWG4s/MFRrAoE393g
         IN0MowF/5WF+S6X64FXoz773l349bfJ9EyV3gCzjbGoyjEeyASIY/qp4jAXSqd389cze
         uU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeVKQAm6yuSXR83ICvKdUEseT6p/YRcKtWx6/pqIJ9s=;
        b=seXum5QqcLrAiaaPkynlo4YAX9oVH+cKOnaOt77vZGRLq9IXF6928LM72yevdrw/Sl
         dovhwRa3sz7gC2/WECQDwkzZWu60v0ai02+WWkCbq1ITFU+C/OhYayZ8h+7yzKzsYrxM
         XeI7D4WWBoic/+4tEK4rJf4QxVYoWvxDxVl/MjGROXZwpgn9+kpOOUg9ZE5smZem5kcW
         V1TBlYIA9ripn2uVT561Ai9Yl1H8MuWjcLfWjopHD2mD/Yup3CuQG5rAmdGRs/mC0ChV
         JnGI+8cx97uPahyYbZJ2RPeF4hNBngKIMzh8EbYZc9tqr1sDDrCWMxesA1znZ1ULnBL0
         vU8A==
X-Gm-Message-State: AOUpUlGNKqp3RUWrTzXXZ7A4gvvvxmeiVwJNsEN1THgSNiFHuxTk8bjg
        pkAg4UfkwSx+AD9Z5EsDMqumEFKJt48oY/cd10U=
X-Google-Smtp-Source: AAOMgpe4aJ7lob8egR/0RyoQG5pJ9CVn3Yal3EMybOzh5ipOGKicgVamyb5hsGGJHLTeW4SO2p7gG6FcOEpePeo8fbQ=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6803482itf.121.1532540354082;
 Wed, 25 Jul 2018 10:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-11-sunshine@sunshineco.com> <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
 <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
In-Reply-To: <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 25 Jul 2018 19:38:47 +0200
Message-ID: <CACsJy8BKa0WXGUo0LXF7fGGfHJMFmS_5YTT_QpOmGjdRBuYHog@mail.gmail.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff
 in cover letter
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 9:59 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Jul 23, 2018 at 12:28 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> > > index f8a061794d..e7f404be3d 100644
> > > --- a/Documentation/git-format-patch.txt
> > > +++ b/Documentation/git-format-patch.txt
> > > @@ -24,6 +24,7 @@ SYNOPSIS
> > >                    [--to=<email>] [--cc=<email>]
> > >                    [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
> > >                    [--interdiff=<previous>]
> > > +                  [--range-diff=<previous>]
> >
> > I wonder if people will use both --interdiff=<rev> and
> > --range-diff=<rev> often enough to justify a shortcut
> > "--all-kinds-of-diff=<rev>" so that we don't have to type <previous>
> > twice. But I guess we don't have to worry about this right now.
>
> My original thought was that --interdiff and --range-diff would be
> mutually exclusive, however, I quickly realized that some people might
> like to use both options together since each format has its strengths
> and weaknesses. (I've used both types of diffs together when preparing
> rerolls of my own series and found that, together, they provided a
> better picture of the reroll than either would have alone.)

I actually had another question that I answered myself: how do I know
which one to choose? There's no preview option (and I'm lazy, I don't
want to do separate diff commands myself). So my answer was "choose
both, then delete the one that does not look good (and explain it in
the cover too when I delete it)"

> And, as you note, it's something that can be added later if
> warranted (plus, this series is already long and I'd like to avoid
> making it longer for something like this whose value is only
> speculative).

Yes of course. We can revisit this later.
-- 
Duy
