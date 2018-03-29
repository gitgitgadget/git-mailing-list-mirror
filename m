Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF231F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2RzE (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:55:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750866AbeC2RzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:55:03 -0400
Received: (qmail 18219 invoked by uid 109); 29 Mar 2018 17:55:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 17:55:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20755 invoked by uid 111); 29 Mar 2018 17:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 13:56:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 13:55:01 -0400
Date:   Thu, 29 Mar 2018 13:55:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] credential: cred helper fast exit can cause SIGPIPE,
 crash
Message-ID: <20180329175501.GE31833@sigill.intra.peff.net>
References: <20180328222051.23684-1-brady@cisco.com>
 <20180329111915.GA30797@sigill.intra.peff.net>
 <330BFBFA-6B9E-456D-A9B3-2D0EF5383A57@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <330BFBFA-6B9E-456D-A9B3-2D0EF5383A57@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:25:04PM +0000, Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco) wrote:

> OK, will retry on the comment.  I guess I misunderstood the guidelines
> a bit on the signoff as well (ie: non-optional), apologies.  Will
> resubmit via 'git send-email' after adjusting the comment and
> recommitting with the -s option.  First time for everything I suppose,
> doh.

The signoff (for our project) is all about the "yes, this contribution
can go under the gpl". So that part is very non-optional. :)

> As to your comment suggestion, appreciated, looks good.  I might
> reword the #1 item you have just a bit (I removed the host specific
> stuff since I think the race can occur regardless of host specific or
> not... but I might be missing something there?).  Anyhow, how about
> something like this:

Yeah, it can definitely occur regardless. It was just the plausible
reason to have a handler which does not bother to look at the incoming
data (since otherwise you are spewing your password to any host you
connect to; maybe that's OK if you configure it only inside a specific
repo and only fetch from one server).

Your update looks fine to me.

Thanks.

-Peff
