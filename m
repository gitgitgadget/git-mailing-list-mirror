Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	TVD_APPROVED shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A898A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCMTfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:35:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726938AbfCMTfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:35:54 -0400
Received: (qmail 20990 invoked by uid 109); 13 Mar 2019 19:35:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 19:35:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15076 invoked by uid 111); 13 Mar 2019 19:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 15:34:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 15:34:37 -0400
Date:   Wed, 13 Mar 2019 15:34:37 -0400
From:   Jeff King <peff@peff.net>
To:     Roberto Tyley <roberto.tyley@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190313193436.GA3400@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <CAFY1edYQcWzYJXF6f_TRk4=bEMVnFXTAp=5u=TJ4XZ3UUd4EmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFY1edYQcWzYJXF6f_TRk4=bEMVnFXTAp=5u=TJ4XZ3UUd4EmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 11:08:00PM +0000, Roberto Tyley wrote:

> On Tue, 12 Mar 2019 at 21:34, Jeff King <peff@peff.net> wrote:
> ...
> > We could continue to mention _both_ tools, but it's probably better to
> > pick one in order to avoid overwhelming the user with choice. After all,
> > one of the purposes here is to reduce friction for first-time or
> > infrequent contributors. And there are a few reasons to prefer GGG:
> 
> That's fair enough - I haven't committed to submitGit for 2 years
> (it's continued to work without incident for most of that time I
> think!).

Yeah, it has been working fine as far as I know. I was a little curious
about how often (and about my impression that GGG was replacing it), so
I did some quick mining of the list archive. Here are numbers of
messages each month (from the last ~100k messages) mentioning Amazon SES
(presumably submitGit) or GitGitGadget in the message-id. I omitted
months with no entries for either, so there are some gaps:

  ses ggg year-mo
  --- --- -------
    7   0 2015-07
    2   0 2015-08
    3   0 2015-09
    1   0 2015-11
    2   0 2016-01
    3   0 2016-02
   34   0 2016-03
   27   0 2016-04
    2   0 2016-05
    6   0 2016-06
   26   0 2016-07
   54   0 2016-08
    3   0 2016-09
   29   0 2016-10
    3   0 2016-12
    4   0 2017-01
    7   0 2017-03
    5   0 2017-04
    3   0 2017-05
   23   0 2017-06
    9   0 2017-07
   14   0 2017-09
    6   0 2017-10
    8   0 2017-11
    8   0 2017-12
   38   0 2018-01
   86   0 2018-02
   49   0 2018-03
    9   0 2018-04
    1   0 2018-05
    3   4 2018-06
    0  86 2018-07
   13 105 2018-08
    0  65 2018-09
   14 149 2018-10
    7 131 2018-11
    1  46 2018-12
   14  96 2019-01
   16 149 2019-02
    0  44 2019-03

That measures pure patches, so they tend to cluster as there are often
several patches in a series. Poking manually at the ses hits, submitGit
seems to have been often used by GSoC and Outreachy applicants and
interns.

I don't know if any of this really supports or refutes my earlier commit
message, but I just thought it was kind of neat to see the numbers, so I
thought I'd share.

> >   2. Subjectively, GGG seems to be more commonly used on the list these
> >      days, especially by list regulars.
> 
> That's probably true too, though my interest with submitGit was more
> driven by helping early/first-time contributors than regulars. Though
> I'm sure GGG works well, in an ideal world it would be interesting to
> get a perspective from a cohort of those kind of users about what kind
> of flow works best for them - although, as I haven't been following
> development, maybe this has already been done?

I think the flow is quite similar, and GGG is definitely geared at
helping infrequent contributors, too. Dscho might have more thoughts on
this.

The biggest friction is marking a user as allowed to send. I think in
submitGit you have to "OK" the submitGit app sending on your behalf.  In
GGG, somebody who already has been OK'd has to OK you with a comment in
the PR (after which you're approved for future PRs, too). It's possible
the approval could slow things down, but I think as long as users of the
tool are fairly prompt about approving non-spam PRs, it wouldn't be a
big deal.

> > I feel a little bad sending this, because I really value the work that
> > Roberto has done on submitGit. So just dropping it feels a bit
> > dismissive.
> 
> Oh, you're very kind, that's ok! Very glad submitGit could help for a
> while, sounds like it was a good proof that GitHub could become part
> of the contribution process.

Yes, I think it definitely was.

-Peff
