Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C001F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHQSap (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:30:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:58692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeHQSao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:30:44 -0400
Received: (qmail 28928 invoked by uid 109); 17 Aug 2018 15:26:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 15:26:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24815 invoked by uid 111); 17 Aug 2018 15:27:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 11:27:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 11:26:56 -0400
Date:   Fri, 17 Aug 2018 11:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
Message-ID: <20180817152655.GA4816@sigill.intra.peff.net>
References: <20180816183117.13716-1-pclouds@gmail.com>
 <20180817064734.GB131749@aiede.svl.corp.google.com>
 <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 04:33:30PM +0200, Duy Nguyen wrote:

> On Fri, Aug 17, 2018 at 8:47 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Nguyễn Thái Ngọc Duy wrote:
> >
> > > --- a/builtin/commit.c
> > > +++ b/builtin/commit.c
> > > @@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> > >                           STATUS_FORMAT_LONG),
> > >               OPT_BOOL('z', "null", &s.null_termination,
> > >                        N_("terminate entries with NUL")),
> > > -             OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
> > > +             OPT_BOOL('j', "amend", &amend, N_("amend previous commit")),
> > [...]
> > > Thoughts?
> >
> > I'm not a fan.  I would have trouble remembering what the short option
> > name means, and it matches the common --jobs option for parallelism
> > that many commands use.  "git commit --am" works today already and
> > doesn't run into those problems.
> 
> The alternative is -A or -M which may be easier associated with
> --amend. That "--am" also would break the moment somebody adds
> --amsomething.

I think "-A" has been considered as possibility for matching "commit -a"
/ "add -A" in the past, but I had trouble finding past discussion
(searching for "A" in the mailing list is not very productive). It was
mentioned in 3ba1f11426 (git-add --all: add all files, 2008-07-19), but
that was quite a while ago.

Not necessarily a blocker, but something to consider.

Like Jonathan, I do find "-j" a little non-intuitive, but I agree that
most of the intuitive ones are taken. :)

-Peff
