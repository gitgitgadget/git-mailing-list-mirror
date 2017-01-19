Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F1D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbdASUWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:22:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:41726 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754507AbdASUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:22:08 -0500
Received: (qmail 11137 invoked by uid 109); 19 Jan 2017 20:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 20:22:07 +0000
Received: (qmail 8623 invoked by uid 111); 19 Jan 2017 20:23:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 15:23:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 15:22:05 -0500
Date:   Thu, 19 Jan 2017 15:22:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170119202205.qtrbiexuisiy4vfa@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
 <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701181334040.3469@virtualbox>
 <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701181700020.3469@virtualbox>
 <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net>
 <xmqq4m0u24hs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m0u24hs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 12:12:47PM -0800, Junio C Hamano wrote:

> > The config-scope thing above would allow "remote.svn.vcs" in
> > ~/.gitconfig. But I don't think the test script actually checks that; it
> > checks for the repo-level config. And we would continue to do the right
> > thing there.
> 
> I am not "you" you are addressing to, but I think tying it to where
> the variable came from makes quite sense.  
> 
> Because it makes it no longer possible to just inspect the
> configured result to answer "is the remote configured?",
> introduction of the configured field also needs to be preserved from
> the original by Dscho, so does reading from historical non-config
> sources like $GIT_DIR/remotes/*, which are by definition
> per-repository thing.
> 
> IOW, with this tweak (and not setting ->configured based on what
> keys are set), I think Dscho's patch makes sense.

Yeah, worry if that wasn't clear: the hunk I posted was a just a
partial. The actual thing I built and ran against the test suite was
exactly as you described.

-Peff
