Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1408F1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeKAQOp (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 12:14:45 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:46954 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKAQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 12:14:44 -0400
Received: by mail-ua1-f51.google.com with SMTP id z8so6889425uap.13
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iTrtyMTe2Dmd45YfPaQmlF+xWsLa3RvxILfxKnt5/g=;
        b=n/Jb6uLT+WnPhGjH4Z1JvJWw73Uq62tGt9NvvMDYnXE4/zNXe7wVZp0TrPaEvQ+gl/
         f+kMBX7qDeFxLvVNpQvW8d4WkW8FEANtwa4ajybKXbeduluUtVPUa+eQpVPYOQqOYDzx
         62ooMQKwLIz1+bIa7POskHkCTyf0mly5dCl7Ysd94tsy4W7ADfZlaEZp8jtD+rNjJd81
         sdXDm5zjzw50Gt0uIV6OFxamQ9AoVy2uLbcLG+syckWNFUNZYyDj9pIC8n0Vzwr478bB
         uD/ZpqMa+LXXrlD2KHtJV4EnkIcYFg/XV6LMAjSnSTpCEHL/VeqA/CTidyIVgqjp9FF+
         2llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iTrtyMTe2Dmd45YfPaQmlF+xWsLa3RvxILfxKnt5/g=;
        b=phzp81BsLAv5NLj2KvC+KV6rgsITjVGnkDqf7lcz14P/Qll6IpBPGKkfUWI/fYjcDo
         KlRacTdCNsDz71b3ILrm67McHBWtWyRW1QcJXqxrf4OnjlpAUUkzuhViR+VouaQ3mca+
         qAvlGRPh1JN/L0EYDLAFo89RJaH1+VaeX4G1igcBmgX+TFztW7BGBFrZ+v/OR27dY1ky
         2wg7pxi+YTCuzbpu3jPnpiQIa8jA0TM8Pc2wfNtmlc2BmUg0xjmObdZr5fAHk5A2X0gf
         3526u3G/DP6pnRD7XTnPrrlmfykka+Ic29K/hUy7yqKwmW4y18C+xOHcDRg76D9sp97J
         T+gw==
X-Gm-Message-State: AGRZ1gJffl6rZPjr1f2opsCK89bqSkK2mUuk/Uk+kSdT54rN42s6TcQf
        VOshOw3yqyoXBMm9/p/raC9tfSpRsQDu0Ly1suvcnQ==
X-Google-Smtp-Source: AJdET5emi3kY8xgY+sSIiz48zq2HkW2pGrFheb+ehSS4Ib7YHp2wwi5gV0nUmAPdqbq6Lef2v7Tzd7/yJzKl8nerHRA=
X-Received: by 2002:ab0:465:: with SMTP id 92mr33987uav.28.1541056379071; Thu,
 01 Nov 2018 00:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
 <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com> <91771D9B-166D-403F-BB20-7E574444BB3B@gmail.com>
In-Reply-To: <91771D9B-166D-403F-BB20-7E574444BB3B@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Nov 2018 00:12:48 -0700
Message-ID: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 12:16 PM Lars Schneider
<larsxschneider@gmail.com> wrote:
> > On Sep 24, 2018, at 7:24 PM, Elijah Newren <newren@gmail.com> wrote:
> > On Sun, Sep 23, 2018 at 6:08 AM Lars Schneider <larsxschneider@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> I recently had to purge files from large Git repos (many files, many commits).
> >> The usual recommendation is to use `git filter-branch --index-filter` to purge
> >> files. However, this is *very* slow for large repos (e.g. it takes 45min to
> >> remove the `builtin` directory from git core). I realized that I can remove
> >> files *way* faster by exporting the repo, removing the file references,
> >> and then importing the repo (see Perl script below, it takes ~30sec to remove
> >> the `builtin` directory from git core). Do you see any problem with this
> >> approach?
> >
> > It looks like others have pointed you at other tools, and you're
> > already shifting to that route.  But I think it's a useful question to
> > answer more generally, so for those that are really curious...
> >
> >
> > The basic approach is fine, though if you try to extend it much you
> > can run into a few possible edge/corner cases (more on that below).
> > I've been using this basic approach for years and even created a
> > mini-python library[1] designed specifically to allow people to create
> > "fast-filters", used as
> >   git fast-export <options> | your-fast-filter | git fast-import <options>
> >
> > But that library didn't really take off; even I have rarely used it,
> > often opting for filter-branch despite its horrible performance or a
> > simple fast-export | long-sed-command | fast-import (with some extra
> > pre-checking to make sure the sed wouldn't unintentionally munge other
> > data).  BFG is great, as long as you're only interested in removing a
> > few big items, but otherwise doesn't seem very useful (to be fair,
> > it's very upfront about only wanting to solve that problem).
> > Recently, due to continuing questions on filter-branch and folks still
> > getting confused with it, I looked at existing tools, decided I didn't
> > think any quite fit, and started looking into converting
> > git_fast_filter into a filter-branch-like tool instead of just a
> > libary.  Found some bugs and missing features in fast-export along the
> > way (and have some patches I still need to send in).  But I kind of
> > got stuck -- if the tool is in python, will that limit adoption too
> > much?  It'd be kind of nice to have this tool in core git.  But I kind
> > of like leaving open the possibility of using it as a tool _or_ as a
> > library, the latter for the special cases where case-specific
> > programmatic filtering is needed.  But a developer-convenience library
> > makes almost no sense unless in a higher level language, such as
> > python.  I'm still trying to make up my mind about what I want (and
> > what others might want), and have been kind of blocking on that.  (If
> > others have opinions, I'm all ears.)
>
> That library sounds like a very interesting idea. Unfortunately, the
> referenced repo seems not to be available anymore:
>     git://gitorious.org/git_fast_filter/mainline.git

Yeah, gitorious went down at a time when I was busy with enough other
things that I never bothered moving my repos to a new hosting site.
Sorry about that.

I've got a copy locally, but I've been editing it heavily, without the
testing I should have in place, so I hesitate to point you at it right
now.  (Also, the old version failed to handle things like --no-data
output, which is important.)  I'll post an updated copy soon; feel
free to ping me in a week if you haven't heard anything yet.

> I very much like Python. However, more recently I started to
> write Git tools in Perl as they work out of the box on every
> machine with Git installed ... and I think Perl can be quite
> readable if no shortcuts are used :-).

Yeah, when portability matters, perl makes sense.  I thought about
switching it over, but I'm not sure I want to rewrite 1-2k lines of
code.  Especially since repo-filtering tools are kind of one-shot by
nature, and only need to be done by one person of a team, on one
specific machine, and won't affect daily development thereafter.
(Also, since I don't depend on any libraries and use only stuff from
the default python library, it ought to be relatively portable
anyway.)
