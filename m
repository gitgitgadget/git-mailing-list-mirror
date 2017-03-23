Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A6920958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756064AbdCWUlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:50590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbdCWUlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:41:18 -0400
Received: (qmail 18771 invoked by uid 109); 23 Mar 2017 20:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:41:16 +0000
Received: (qmail 11090 invoked by uid 111); 23 Mar 2017 20:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 16:41:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 16:41:14 -0400
Date:   Thu, 23 Mar 2017 16:41:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323204114.ui7jqrd3guwc3sgl@sigill.intra.peff.net>
References: <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
 <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
 <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
 <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
 <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
 <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
 <xmqq7f3fbury.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f3fbury.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 01:30:41PM -0700, Junio C Hamano wrote:

> >> We can blacklist these branches with a regex in the travis.yml:
> >> https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Branches
> >
> > I had a feeling it might be something like that. So we would all need to
> > agree on the convention for WIP branch names. If other people like the
> > idea, I'm happy to make a patch, but I don't want to impose my own weird
> > conventions on everyone else.
> 
> I can go with any convention, but I'd be more pleased if you made
> sure that "do not build this with CI" and "this is WIP" are kept as
> two separate concepts, as I can see having some WIP that I do want
> to get tested.
> 
> Perhaps a substring "/noci-" anywhere in the branch name, or
> something silly like that?

Hrm, most of the point for me was _not_ having to define the two
concepts separately. Let me try it for a while with "[ci skip]" in the
tip commit subject, and see how painful I find that. My goal is
eventually to turn on notifications, so I'd quickly be reminded if I
forgot such a marker.

-Peff
