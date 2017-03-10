Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF761FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbdCJTnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:43:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:42224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755385AbdCJTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:43:29 -0500
Received: (qmail 29332 invoked by uid 109); 10 Mar 2017 19:42:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 19:42:48 +0000
Received: (qmail 27815 invoked by uid 111); 10 Mar 2017 19:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 14:42:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 14:42:45 -0500
Date:   Fri, 10 Mar 2017 14:42:45 -0500
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
Message-ID: <20170310194245.p37w6mew4que6oya@sigill.intra.peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <eec5ab2a-7fe7-b47f-8073-a8212a9634f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eec5ab2a-7fe7-b47f-8073-a8212a9634f1@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 08:34:45PM +0100, Vegard Nossum wrote:

> > That's something I guess, but I'm not enthused by the idea of just
> > dumping a bunch of binary test cases that nobody, not even the author,
> > understands.
> 
> I understand your concern. This is how I see it:
> 
> Negatives:
> 
>  - 'make test' takes 1 second longer to run
> 
>  - 548K data added to git.git

My real concern is that this is the tip of the ice berg. So we increased
coverage in one program by a few percent. But wouldn't this procedure be
applicable to lots of _other_ parts of Git, too?

IOW, I'm worried about a day when we've added dozens or hundreds of
seconds to the test suite. Sure, we can quit adding at any time, but I
feel like it's easier to make a decision from the outset.

I'm tempted to say these should go into a different test-suite, or be
marked with a special flag or something. But then I guess nobody runs
them.

-Peff
