Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4886C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeH3BbG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:31:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:32920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727177AbeH3BbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:06 -0400
Received: (qmail 21215 invoked by uid 109); 29 Aug 2018 21:32:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 21:32:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19063 invoked by uid 111); 29 Aug 2018 21:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 17:32:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:32:17 -0400
Date:   Wed, 29 Aug 2018 17:32:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829213217.GB32400@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
 <20180829210913.GF7547@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829210913.GF7547@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 02:09:13PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:
> 
> >> Yeah, then let's just convert '/' with as little overhead as possible.
> >
> > Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> > colliding)?
> >
> > I'm OK if the answer is "no", but if you do want to deal with it, the
> > time is probably now.
> 
> Have we rejected the config approach?  I really liked the attribute of
> not having to solve everything right away.  I'm getting scared that
> we've forgotten that goal.

I personally have no problem with that approach, but I also haven't
thought that hard about it (I was mostly ignoring the discussion since
it seemed like submodule-interested folks, but I happened to see what
looked like a potentially bad idea cc'd to me ;) ).

-Peff
