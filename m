Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D9420248
	for <e@80x24.org>; Sun,  7 Apr 2019 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDGNlQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 09:41:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726362AbfDGNlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 09:41:16 -0400
Received: (qmail 17656 invoked by uid 109); 7 Apr 2019 13:41:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 07 Apr 2019 13:41:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9960 invoked by uid 111); 7 Apr 2019 13:41:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 07 Apr 2019 09:41:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Apr 2019 09:41:13 -0400
Date:   Sun, 7 Apr 2019 09:41:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 6/7] rev-list: let traversal die when --missing is not in
 use
Message-ID: <20190407134113.GA13417@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
 <20190405184111.GE2284@sigill.intra.peff.net>
 <20190406053648.GD37216@Taylors-MBP.hsd1.wa.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190406053648.GD37216@Taylors-MBP.hsd1.wa.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 10:36:48PM -0700, Taylor Blau wrote:

> > > Of those, I think (3) is probably the best path forward. However, this
> > > patch does none of them. In the name of expediently fixing the
> > > regression to a normal "rev-list --objects" that we use for connectivity
> > > checks, this simply restores the pre-7c0fe330d5 behavior of having the
> > > traversal die as soon as it fails to load a tree (when --missing is set
> > > to MA_ERROR, which is the default).
> >
> > I think this is worth doing, as it restores the earlier behavior. But a
> > few general thoughts (which I've shared already with you, but for the
> > benefit of the list):
> 
> I agree that it's worth doing. One question that I have is _when_ you
> feel it's good to do. I'm happy to write it and include the change in
> v2, but if others would be happy not to grow the series too much between
> re-rolls, I'd be just as pleased to send it in a new series after this
> one.

I'm not sure what "it" is here. My earlier message was admittedly
rambling, but I think I'm arguing that it's OK to continue to include
this patch that you already have, and punt further changes to make
"rev-list --objects" detect blob problems down the road. I.e., leave the
two expect_failures in place that your v1 series ends with.

-Peff
