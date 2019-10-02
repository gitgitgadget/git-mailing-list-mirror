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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C731F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfJBPvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:51:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37533 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfJBPvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:51:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id p13so12259698vsr.4
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjINSseH7dd4bRuFe/HhJcLzpmaJWwJbDZmde0mJp+Y=;
        b=FwuI7nrIaHiT9Uqd/GMO0j0l8seZpqSKjF+XLG5sZlSlcxE379ttLUe1Qyy0qpTyXG
         jMJxveHy8rajuTjcRjKPZ6EPVWNAVA6N7coATMT1L6pRt/UUVuPbuFvkM/87zWcAjwPk
         6pZn1Y5uxuD8ZABn7czD2M0WtAOylUaFzeDZybf3ZZpixmh/eC4Vvb5xd4+oTDn8KF2S
         ftUSZTlHZ9361aof2SvTDdTdaOfHo7f4Ob6Thsk7sdMuNdUPhgGwk7nfk9s3Scoro+g9
         BH4Ppl7bW4iB1L+X6aDpTLxyPwhWPW9OBex5aqRAEZ1iERt54wFVIheBEo0fqQKeY7rJ
         CFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjINSseH7dd4bRuFe/HhJcLzpmaJWwJbDZmde0mJp+Y=;
        b=a7NIhZf8yD1a3al+/5O6K8VBo/0YZ5lK3GOTFgzNUNRQ87KzauoYR3nff+Jgq/mUYm
         ZP+JrQC8YCPHPnQ0QTHJy1j/Vy7OjOAUxkBIH2ja661DYujwwVR9WYiUseSDTP8pI0mK
         DXi1wiyO4gIJ5JoD/PLQHaH8knm4JLCetiz5tCC8DPzqv6NPZ3l+T8dgEa41L7HGssvL
         jyK24QPDjXF2wVOWJSnJBK27A9HtpmbZt04QmiHZfANY5GI6jlyROQNShcRlb7Rsz1IJ
         HdLDUM9Yp0+iZkEwzkjyJdFF/AaS23ItVBQppOC56EQPndyPQAMLiljXrNY7pl5Wll+A
         BjMw==
X-Gm-Message-State: APjAAAWbaqNHShEkaxTCV3fLANR8JMuZnbrRrcBbJT3iAR+V/KhXkfGQ
        DxBCkohSLRqq52t/ubMbQiTl/3irfZz65f7PDRI=
X-Google-Smtp-Source: APXvYqwBXpgyZVW7CCNZJj6a2AtKnOfL/caOAwm3tksxBwRPgugGvRmVZyXuQLSiDsB+JeQFLA4PH8Q1Cm8TQv+sa+U=
X-Received: by 2002:a67:1bc2:: with SMTP id b185mr2343183vsb.116.1570031481708;
 Wed, 02 Oct 2019 08:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191001184049.GA30113@generichostname> <20191001185524.18772-1-newren@gmail.com>
 <20191001193510.GA43899@generichostname> <CABPp-BEMNbnncJ=Zv7q+PoMrt7yN0ZxaUVW-rEyjZ9vvXxMHLQ@mail.gmail.com>
In-Reply-To: <CABPp-BEMNbnncJ=Zv7q+PoMrt7yN0ZxaUVW-rEyjZ9vvXxMHLQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Oct 2019 08:51:10 -0700
Message-ID: <CABPp-BEwopZr9NRQ51mpd1Ym4q_DT1qsefPS4PBr=8j-C03w=Q@mail.gmail.com>
Subject: Re: [PATCH v3] dir: special case check for the possibility that
 pathspec is NULL
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 12:39 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 12:35 PM Denton Liu <liu.denton@gmail.com> wrote:
> >
> > Hi Elijah,
> >
> > Sorry for dragging out this thread for so long...
> >
> > On Tue, Oct 01, 2019 at 11:55:24AM -0700, Elijah Newren wrote:
> >
> > [...]
> >
> > > diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> > > index 192c94eccd..a840919967 100755
> > > --- a/t/t0050-filesystem.sh
> > > +++ b/t/t0050-filesystem.sh
> > > @@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '
> >
> > I had to change the 25 to a 24 for this to apply cleanly.
> >
> > >       git merge topic
> > >  '
> > >
> > > +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> > > +     git init repo &&
> > > +     (
> > > +             cd repo &&
> > > +
> > > +             >Gitweb &&
> > > +             git add Gitweb &&
> > > +             git commit -m "add Gitweb" &&
> > > +
> > > +             git checkout --orphan todo &&
> > > +             git reset --hard &&
> > > +             mkdir -p gitweb/subdir &&
> > > +             >gitweb/subdir/file &&
> > > +             git add gitweb &&
> > > +             git commit -m "add gitweb/subdir/file" &&
> > > +
> > > +             git checkout master
> > > +     )
> > > +'
> > > +
> > >  test_done
> >
> > Just wondering, how did you generate this patch? Did you manually edit
> > the last patch and resend it or is this a bug in our diff machinery?
>
> I manually edited because it "was so simple" and of course just
> compounded the problem because I didn't fix the count, as you pointed
> out.  Gah.  Thanks for checking.  Clearly, I'm bouncing between too
> many things this morning, and need to wait until I'm not so distracted
> and rushing so I don't mess things up.  I'll sound out a v4 in a few
> hours when I've cleaned a few other things off my plate.

I was going to send out a new version this morning, but it looks like
Junio already picked up the patch and fixed it up (the tip of
en/clean-nested-with-ignored already has what we want), so I won't
resend after all.  Thanks Denton, SZEDER, and Junio.
