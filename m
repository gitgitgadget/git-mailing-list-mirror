Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BD720248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCYXgr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:36:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726061AbfCYXgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:36:47 -0400
Received: (qmail 5580 invoked by uid 109); 25 Mar 2019 23:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 23:36:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13455 invoked by uid 111); 25 Mar 2019 23:37:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 19:37:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 19:36:45 -0400
Date:   Mon, 25 Mar 2019 19:36:45 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
Message-ID: <20190325233644.GC23728@sigill.intra.peff.net>
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net>
 <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
 <20190325144930.GA19929@sigill.intra.peff.net>
 <CAGyf7-EOrCgPY19jgwRd5H-0ADMX9WtLUuACmTAANnNVW-K-_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-EOrCgPY19jgwRd5H-0ADMX9WtLUuACmTAANnNVW-K-_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 11:43:52AM -0700, Bryan Turner wrote:

> > I don't think I've ever seen a tag-to-a-tag in the wild, but I wouldn't
> > be surprised if somebody has found a use for it. For example, because
> > tags can be signed, I can make a signature of your signature, showing a
> > cryptographic chain of custody.
> 
> For a while the Atlassian Bamboo team followed a workflow where they
> would do a build in CI, tag that build and then deploy it to a sandbox
> environment for smoke testing. If it passed the smoke tests, it would
> get "promoted" from the sandbox environment to internal instances used
> by the various teams to do their builds. When a sandbox build was
> "promoted", they'd create a tag of the sandbox build's tag to have
> traceability between the two environments.
> 
> I'm not advocating for or judging that workflow one way or another,
> and the Bamboo team has since moved on to a different workflow. I just
> thought I'd share it as a tag-of-tag workflow that I've seen a real
> team using. (There was one place in Bitbucket Server's code where we
> didn't handle recursive tags correctly, so their workflow caused some
> errors that I needed to make some adjustments for. As a result,
> Bitbucket Server's test suite now includes tests that cover tag-of-tag
> behaviors.)

Thanks, I always like hearing these kinds of data points. If nothing
else, it's a good reminder that if Git has behaved some way for many
years, then _somebody_ is likely to have taken advantage of it, whether
we considered it a possibility or not. :)

-Peff
