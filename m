Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B5A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC2TwV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 15:52:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:47840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751082AbeC2TwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 15:52:20 -0400
Received: (qmail 23763 invoked by uid 109); 29 Mar 2018 19:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 19:52:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21720 invoked by uid 111); 29 Mar 2018 19:53:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 15:53:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 15:52:18 -0400
Date:   Thu, 29 Mar 2018 15:52:18 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 4/9] t1300: remove unreasonable expectation from TODO
Message-ID: <20180329195218.GE2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <5801f7529465b7dbdfbe3c105e2a8212c253ba0d.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5801f7529465b7dbdfbe3c105e2a8212c253ba0d.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:18:50PM +0200, Johannes Schindelin wrote:

> In https://public-inbox.org/git/7vvc8alzat.fsf@alter.siamese.dyndns.org/
> a reasonable patch was made quite a bit less so by changing a test case
> demonstrating a bug to a test case that demonstrates that we ask for too
> much: the test case 'unsetting the last key in a section removes header'
> now expects a future bug fix to be able to determine whether a free-form
> comment above a section header refers to said section or not.
> 
> Rather than shooting for the stars (and not even getting off the
> ground), let's start shooting for something obtainable and be reasonably
> confident that we *can* get it.

As I said before, I'm fine with turning this test into something more
realistic.

An obvious question is whether we should preserve the original
unrealistic parts by splitting it: the realistic parts into one
expect_failure (that we'd switch to expect_success by the end of this
series), and then an unrealistic one to serve as a documentation of the
ideal, with a comment explaining why it's unrealistic.

I doubt the "unrealistic" half would be serving much purpose though, so
I'm OK to see it get eliminated here.

-Peff
