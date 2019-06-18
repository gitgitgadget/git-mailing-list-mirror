Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BAC1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 02:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFRCmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 22:42:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61518 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFRCmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 22:42:07 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x5I2fuVf015260
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:41:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x5I2fuVf015260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560825717;
        bh=Y55/H7jPP63m1m5AfK5AG4A9bgpt7HAK35yoXyZRrcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YHeiHx/ZN1oMftYOnpWKVCR88kzeTH3telpXs23vdTHcGiKm/ZLQCdtka8mMph0QW
         5C7uYEHjl2T0mXmjIVB2NTeOsFuEURut2NzlUfI7v2zg0XV776YZv2wGUakmBYeUWj
         qaKeKHE//K571IUhnGpsQunl6pw2xgbz0RH/WScEy4DI1fToABo4wcnN7eG26aVePS
         qcjdJ/3CKN7N0i9yjkQ3wmVPLyuiuP/UoazyOxUsAKMI5jhHcEU0pYO8uYymJgQo8o
         WDokCcwhuzowRlFa1tyZFeBpv192rrEX2L4K62aLlAv9PvcOwzLW7OMCFQV/sZrOmZ
         fZ9bCByzPLHkg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id k9so7616950vso.5
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 19:41:57 -0700 (PDT)
X-Gm-Message-State: APjAAAVeeYk98MPVKYq6SYZ/21eYpfm3qIoCpYGS+dhDy5rMQtez06lC
        dxVLpcpTJpR5NkJ65V/BDwoWcfCzg+6k+88le18=
X-Google-Smtp-Source: APXvYqzVT3XQYGxm6kmwjq5QMZ5CsWaW7N3bUFmpbeRDceh09piXXI+eXwrgUeh/wNl62k1piTyitUzzoiQX4eFnC5U=
X-Received: by 2002:a67:de99:: with SMTP id r25mr62315591vsk.215.1560825715984;
 Mon, 17 Jun 2019 19:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net> <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
 <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
 <CAP8UFD3_kKvBs=rMvBp-K-UPD5mCqVsHRZ1VqGYY7uR8G+H8SQ@mail.gmail.com>
 <xmqqtvcoruda.fsf@gitster-ct.c.googlers.com> <CAP8UFD3EaR=PRsN9sEEAOOdqQxPeZ1wiiWrVeBKQv8AW1zY1ig@mail.gmail.com>
In-Reply-To: <CAP8UFD3EaR=PRsN9sEEAOOdqQxPeZ1wiiWrVeBKQv8AW1zY1ig@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Jun 2019 11:41:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd7AeaBqFh3AgfbcjcgjGsGpK=0xK_bgpbe9FevA6qHA@mail.gmail.com>
Message-ID: <CAK7LNARd7AeaBqFh3AgfbcjcgjGsGpK=0xK_bgpbe9FevA6qHA@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 5:08 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Jun 17, 2019 at 7:31 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > On Mon, Jun 17, 2019 at 6:33 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >>
> > >> On Sat, Jun 15, 2019 at 5:41 PM Christian Couder
> > >> <christian.couder@gmail.com> wrote:
> > >> >
> > >> > > I do wonder if the trailer code is correct to always respect it, though.
> > >> > > For example, in "git log" output we'd expect to see commit messages from
> > >> > > people with all sorts of config. I suppose the point is that their
> > >> > > comment characters wouldn't make it into the commit object at all, so
> > >> > > the right answer there is probably not to look for comment characters at
> > >> > > all.
> > >> >
> > >> > Would you suggest an option, maybe called `--ignore-comments` to ignore them?
> > >>
> > >> Since 'git interpret-trailers' already ignores lines starting with '#',
> > >> is this option true by default?
> > >
> > > Sorry, I should have suggested something called --unstrip-comments or
> > > --ignore-comment-char that would make 'git interpret-trailers' stop
> > > stripping lines that start with the comment character.
> >
> > So, to summarize:
> >
> >  - As the traditional behaviour is to strip comment, using the
> >    hardcoded definition of the comment char, i.e. '#', we do not
> >    switch the default.  Instead, a new command line option makes
> >    it pretend there is no comment char and nothing get stripped.
>
> Yeah, that's the idea of --unstrip-comments (or
> --ignore-comment-char). I am ok with preparing and sending a patch to
> add that, though it is not urgent and it would be nice if we could
> agree with the name first.
>
> >  - But the core.commentchar that does not override hardcoded
> >    definition is a bug, so we'd fix that along the lines of what
> >    Peff's patch outlined.
>
> Yeah, not sure if Peff wants to resend his patch with a proper commit
> message. I would be ok with doing it if he prefers.


Sounds good to me.

These are separate works.

Since the second one is a bug-fix, it can go in first.
(Peff's patch works for me)


The first one is a new feature, so we can take our time
to decide a preferred option name.




IMHO, --unstrip-* is a little bit confusing.

interpret-trailers does not strip anything from the output.

It is just like interpret-trailers does not take comment lines
into account when it determines the boundary between the commit
message body and trailers.


Just a idea:

--[no-]ignore-comments

   By default, comments (i.e. lines starting with '#' or a character
specified core.commentChar)
   are not taken into consideration when interpret-trailers determines which
   parts are trailers.
   Pass --no-ignore-comments if you want to treat all lines as the message body.
   --ignore-comments is the default.



Please feel free to put your ideas on the table!


-- 
Best Regards
Masahiro Yamada
