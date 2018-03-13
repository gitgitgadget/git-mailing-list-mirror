Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0CB21FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 00:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCMAFP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:05:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:54822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751333AbeCMAFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:05:14 -0400
Received: (qmail 14781 invoked by uid 109); 13 Mar 2018 00:05:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Mar 2018 00:05:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19290 invoked by uid 111); 13 Mar 2018 00:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 20:06:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 20:05:12 -0400
Date:   Mon, 12 Mar 2018 20:05:12 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Make cvs tests pass with '-x' tracing and /bin/sh
Message-ID: <20180313000512.GH1968@sigill.intra.peff.net>
References: <20180308123844.15163-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308123844.15163-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 08, 2018 at 01:38:42PM +0100, SZEDER Gábor wrote:

> > I installed 'cvs' and whatnot to run t94* and t96* tests, and sure
> > enough, 5 tests in 2 test scripts fail with '-x' tracing and /bin/sh.
> > I think I will be able to get around to send v2 during the weekend.
> 
> Well, I wasn't able to get around to it, and in the meantime
> 'sg/test-x' got merged into 'next'.  So here are the updates for those
> two test scripts.
> 
> The commit message of the first patch is perhaps unnecessary long, but
> it's mostly about explaining why the affected test was working
> reasonably well despite the rather weird 'test_cmp this that >>out
> 2>&1' thing.

You know I would never complain about a long commit message. :)

Both patches look OK to me. My only comment on the first one was "you
should just use 'return'", but I see Eric beat me to it.

I do think the postimage of the second one is a little less readable.
That's not a big deal to me, but I'm pretty sure I would intentionally
write it the "original" way if I found myself in a similar situation.
Which makes me wonder whether we'll end up accidentally re-introducing
these kinds of "-x" failures. But as I said before, I'm willing to wait
and see.

-Peff
