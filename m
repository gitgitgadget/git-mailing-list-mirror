Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE9C1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFNP3O (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:29:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725780AbfFNP3O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:29:14 -0400
Received: (qmail 16993 invoked by uid 109); 14 Jun 2019 15:29:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 15:29:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27842 invoked by uid 111); 14 Jun 2019 15:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 11:30:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 11:29:12 -0400
Date:   Fri, 14 Jun 2019 11:29:12 -0400
From:   Jeff King <peff@peff.net>
To:     Karen Arutyunov <karen@codesynthesis.com>
Cc:     git@vger.kernel.org
Subject: Re: advertised commit fetch using commit id fails
Message-ID: <20190614152911.GC22984@sigill.intra.peff.net>
References: <38030a81-73bc-f877-362a-3fd8018b5977@codesynthesis.com>
 <20190614152710.GB22984@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614152710.GB22984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 11:27:10AM -0400, Jeff King wrote:

> So in short, it was never supposed to work, but between bugs and
> protocol vagaries, there are a few version and protocol combinations
> where it did.

I'd add that in protocol v2, the reachability restrictions are lifted
(i.e., every server behaves as if uploadpack.allowAnySHA1InWant is
enabled). So you could probably just set protocol.version=2 on your
client. This will eventually becomes the default, too.

-Peff
