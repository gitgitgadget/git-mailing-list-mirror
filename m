Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EC91F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfIIR3z (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:29:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:44398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726931AbfIIR3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:29:55 -0400
Received: (qmail 20723 invoked by uid 109); 9 Sep 2019 17:29:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 17:29:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10983 invoked by uid 111); 9 Sep 2019 17:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 13:31:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 13:29:54 -0400
From:   Jeff King <peff@peff.net>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] test_date.c: Remove reference to GIT_TEST_DATE_NOW
Message-ID: <20190909172954.GC30470@sigill.intra.peff.net>
References: <20190909014711.3894-1-ischis2@cox.net>
 <20190909014711.3894-3-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909014711.3894-3-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 06:47:11PM -0700, Stephen P. Smith wrote:

> Remove the reference to the GIT_TEST_DATE_NOW which is done in date.c.
> The intialization of variable x with the value from GIT_TEST_DATE_NOW
> is unneeded since x is initalized by skip_prefix().

It took me a minute to understand what this second sentence meant. I'd
have actually expected "x" to go away, looking at the diff context.

Maybe a more clear explanation would be: We can't get rid of the "x"
variable, since it serves as a generic scratch variable for parsing
later in the function.

(I'd also probably have just rolled this into patch 1, but I'm OK with
it either way).

-Peff
