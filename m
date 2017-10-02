Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26ECD202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 08:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdJBIUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 04:20:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750927AbdJBIUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 04:20:22 -0400
Received: (qmail 14275 invoked by uid 109); 2 Oct 2017 08:20:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 08:20:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27020 invoked by uid 111); 2 Oct 2017 08:21:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 04:21:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 04:20:20 -0400
Date:   Mon, 2 Oct 2017 04:20:20 -0400
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
Message-ID: <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 30, 2017 at 05:51:01PM +0000, Olga Telezhnaya wrote:

> Simplify mru.[ch] and related code by reusing the double-linked list
> implementation from list.h instead of a custom one.
> This commit is an intermediate step. Our final goal is to get rid of
> mru.[ch] at all and inline all logic.

Thanks, this version looks correct to me.

I do think there are a few ugly bits in the result (like that
initializer for packed_git_mru :) ), so I'd prefer not to merge this
down until we do that final step.

So the big question is: who wants to do it?

I think you've done a good job here, and this would count for your
Outreachy application's contribution. But if you'd like to do that next
step, you are welcome to.

We could also consider it a #leftoverbits that perhaps some other
Outreachy candidate would pick up[1].

In the meantime, Junio, I think we'd want to queue this with the intent
to graduate it to "pu" or possibly "next", but not "master". Then if
somebody (Olga or another applicant) produces the endgame patch, we can
queue it on top and move it further. And if nobody does, I can pick it
after the application period is over.

-Peff

[1] For those who find this mail through the archive, there's more
    discussion in this thread:

      https://public-inbox.org/git/CAL21BmnvJSaN+Tnw7Hdc5P5biAnM5dfWR7gX5FrAG1r_D8th=A@mail.gmail.com/
