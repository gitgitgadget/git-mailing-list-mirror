Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8E71F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 17:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbeKNDJt (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 22:09:49 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43800 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKNDJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 22:09:48 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so2959357vke.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKFiI9Iu6bZ48AsNljlZ+JUtrXeodxGbOkQ07C/SKFA=;
        b=VCdIV0iM1jCvRG5Blxrkib90JtI4JlECxfG1u8QoGU8d80XWLsjDAmq0B/qDwhPo3l
         9oIWrNOMwNU3e0/mqCg/tV6MZfODenRyaEcUpFr6kQyWFe00Mnw/QCdyS6gdHBDOIiwi
         E10pcXQwHRae6x79FcwDHF63Sy1+xqx/R8mYp1sNMqXeJa3zado7vlo5D1SLruLomy6N
         cy75548yfPlloeP0w/L0nmfMsDapgnG0bd96x2oroDV1GdGdgvbYDfGig9qh8T8GAyXQ
         RKtVUJZ9KZAxz8kxdkejzF1Z4E48CYKA0Tya3u8HBBnH4b7k/ZL3SsdSpqCO+PIdHDi5
         9QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKFiI9Iu6bZ48AsNljlZ+JUtrXeodxGbOkQ07C/SKFA=;
        b=jbZ8uzOOlexMlhZ+QpRZTjJhf4cIIYZ3PjzSIZJeAV0mpKePMWRPPZEOadZJdz1frM
         IMZAKuiuKOO1leWQJuIfSB5AgFLJIx/Aen/QK43JkogBI1BxYnLXKzSEl1G8dlMkQ2LA
         R8B1Rfqk4SPDdGeom0ZP/FOISbU1FJyROjZI+6Na2PVfZMCZPXnsbHF/yiNrY2Fe040F
         y+j3qixzc9ZWDnxtleito0nkd5ur0ha3Gm7mk0d0PpNi0wYXjbM5K55IkZ0mNwTcUtDu
         jtl4WeR2UTDMezJY/F2ADgdAWuHNdpEVHPNejk9L1uhlrC0t61rPWQVhsTowgPogmAmv
         nCcQ==
X-Gm-Message-State: AGRZ1gLtJ9BR+3FolwVn0fhLz3kFBOvBu8Fh4ooQRXyCUyewjLUGAh+A
        PCqw7CflPYLVku3ZYXhOiJ60DSQ3fS26i+nXm2E=
X-Google-Smtp-Source: AJdET5eUVifv4TEFA1DvUKvP/93GzO1CxWJ4nLUxt90cqwBUhAl01ZZPDjML5f6s2Js45/E+h/WqMuLFyhDcW3xYYu4=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr2643363vkd.15.1542129048972;
 Tue, 13 Nov 2018 09:10:48 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net> <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
 <20181112125847.GI3956@sigill.intra.peff.net> <CABPp-BHjPq-2JoeXur+FMs+T==arqvMaAW1uLKMSHKBKBS60rA@mail.gmail.com>
 <20181113144554.GB17454@sigill.intra.peff.net>
In-Reply-To: <20181113144554.GB17454@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Nov 2018 09:10:36 -0800
Message-ID: <CABPp-BFbtusiT30_gU7SgmmMg25NCdgNTSEEJJysoT-1MwSnkA@mail.gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 6:45 AM Jeff King <peff@peff.net> wrote:
> It is an expensive log command, but it's the same expense as running
> fast-export, no? And I think maybe that is the disconnect.

I would expect an expensive log command to generally be the same
expense as running fast-export, yes.  But I would expect two expensive
log commands to be twice the expense of a single fast-export (and you
suggested two log commands: both the --find-object= one and the
--diff-filter one).

> I am looking at this problem as "how do you answer question X in a
> repository". And I think you are looking at as "I am receiving a
> fast-export stream, and I need to answer question X on the fly".
>
> And that would explain why you want to get extra annotations into the
> fast-export stream. Is that right?

I'm not trying to get information on the fly during a rewrite or
anything like that.  This is an optional pre-rewrite step (from a
separate invocation of the tool) where I have multiple questions I
want to answer.  I'd like to answer them all relatively quickly, if
possible, and I think all of them should be answerable with a single
history traversal (plus a cat-file --batch-all-objects call to get
object sizes, since I don't know of another way to get those).  I'd be
fine with switching from fast-export to log or something else if it
met the needs better.

As far as I can tell, you're trying to split each question apart and
do a history traversal for each, and I don't see why that's better.
Simpler, perhaps, but it seems worse for performance.  Am I missing
something?

> > > There I think you'd want to assemble the list with something like "git
> > > log --follow --name-only paths-of-interest" except that --follow sucks
> > > too much to handle more than one path at a time.
> > >
> > > But if you wanted to do it manually, then:
> > >
> > >   git log --diff-filter=R --name-only
> > >
> > > would be enough to let you track it down, wouldn't it?
> >
> > Without a -M you'd only catch 100% renames, right?  Those aren't the
> > only ones I'd want to catch, so I'd need to add -M.  You are right
> > that we could get basic renames this way, but it doesn't cover
> > everything I need.  Let's use this as a starting point, though, and
> > build up to what I need...
>
> No, renames are on by default these days, and that includes inexact
> renames. That said, if you're scripting you probably ought to be doing:
>
>   git rev-list HEAD | git diff-tree --stdin
>
> and there yes, you'd have to enable "-M" yourself (you touched on
> scripting and formatting below; diff-tree can accept the format options
> you'd want).

Ah, I didn't know renames were on by default; I somehow missed that.
Also, the rev-list to diff-tree pipe is nice, but I also need parent
and commit timestamp information.

....
> Yeah, I think "-t" would help your tree deletion problem.

Absolutely, thanks for the hint.  Much appreciated.  :-)

> > At this point, let's remember that we had another full git-log
> > invocation for mapping object sizes to filenames.  We might as well
> > coalesce the two log commands into one, by extending this latest one
> > to:
> >
> >   git log -M --diff-filter=RAMD --no-abbrev --raw
>
> What is there besides RAMD? :)

Well, as you pointed out above, log detects renames by default,
whereas it didn't used to.
So, if someone had written some similar-ish history walking/parsing
tool years ago that didn't depend need renames and was based on log
output, there's a good chance their tool might start failing when
rename detection was turned on by default, because instead of getting
both a 'D' and an 'M' change, they'd get an unexpected 'R'.

For my case, do I have to worry about similar future changes?  Will
copy detection ('C') or break detection ('B') become the default in
the future?  Do I have to worry about typechanges ('T")?  Will new
change types be added?  I mean, the fast-export output could maybe
change too, but it seems much less likely than with log.

> > I could potentially switch to using this and drop patch 10/10.
>
> So I'm still not _entirely_ clear on what you're trying to do with
> 10/10. I think maybe the "disconnect" part I wrote above explains it. If
> that's correct, then I think framing it in terms of the operations that
> you'd be able to perform _without running a separate traverse_ would
> make it more obvious.

Let me try to put it as briefly as I can.  With as few traversals as
possible, I want to:
  * Get all blob sizes
  * Map blob shas to filename(s) they appeared under in the history
  * Find when files and directories were deleted (and whether they
were later reinstated, since that means they aren't actually gone)
  * Find sets of filenames referring to the same logical 'file'. (e.g.
foo->bar in commit A and bar->baz in commit B mean that {foo,bar,baz}
refer to the same 'file' so that a user has an easy report to look at
to find out that if they just want to "keep baz and its history" then
they need foo & bar & baz.  I need to know about things like another
foo or bar being introduced after the rename though, since that breaks
the connection between filenames)
  * Do a few aggregations on the above data as well (e.g. all copies
of postgres.exe add up to 20M -- why were those checked in anyway?,
*.webm files in aggregate are .5G, your long-deleted src/video-server/
directory from that aborted experimental project years ago takes up 2G
of your history, etc.)

Right now, my best solution for this combination of questions is
'cat-file --batch-all-objects' plus fast-export, if I get patch 10/10
in place.  I'm totally open to better solutions, including ones that
don't use fast-export.
