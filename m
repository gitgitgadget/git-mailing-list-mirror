Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643B22055E
	for <e@80x24.org>; Tue, 31 Oct 2017 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdJaRLC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:11:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:41486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751884AbdJaRLB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:11:01 -0400
Received: (qmail 32658 invoked by uid 109); 31 Oct 2017 17:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Oct 2017 17:11:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3298 invoked by uid 111); 31 Oct 2017 17:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Oct 2017 13:11:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Oct 2017 13:10:59 -0400
Date:   Tue, 31 Oct 2017 13:10:59 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com, chriscool@tuxfamily.org, t.gummerer@gmail.com,
        l.s.r@web.de, jsorianopastor@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
Message-ID: <20171031171058.vs5aau5x26ebx7kq@sigill.intra.peff.net>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <20171024144544.7544-1-benpeart@microsoft.com>
 <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
 <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
 <alpine.DEB.2.10.1710301727160.10801@alexmv-linux>
 <f671ea09-d4aa-64aa-8225-c1fbf2eac175@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f671ea09-d4aa-64aa-8225-c1fbf2eac175@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 09:01:45AM -0400, Ben Peart wrote:

> > > But what we probably _do_ need is to make sure that "git fsck" would
> > > detect such an out-of-order index. So that developers and users alike
> > > can diagnose suspected problems.
> > 
> > Agree -- that seems like a better home for this logic.
> 
> That is how version 1 of this patch worked but the feedback to that patch
> was to remove it "not only during the normal operation but also in fsck."

Sorry for the mixed messages (I think they are mixed between different
people, and not mixed _just_ from me ;) ).

For what it's worth, I like your v1, but can live with either approach.

-Peff
