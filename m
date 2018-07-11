Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BF31F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeGKPE6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:55344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726340AbeGKPE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:04:58 -0400
Received: (qmail 11818 invoked by uid 109); 11 Jul 2018 15:00:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 15:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7744 invoked by uid 111); 11 Jul 2018 15:00:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 11:00:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 11:00:13 -0400
Date:   Wed, 11 Jul 2018 11:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] has_uncommitted_changes(): fall back to empty tree
Message-ID: <20180711150012.GD15269@sigill.intra.peff.net>
References: <87k1q2c9zq.fsf@evledraar.gmail.com>
 <20180711133402.GD23835@sigill.intra.peff.net>
 <20180711141406.GE23835@sigill.intra.peff.net>
 <87in5ldedd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in5ldedd.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 04:41:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > [From upthread]: It took me a minute to reproduce this. It needs "pull
> > --rebase" if you don't have that setup in your config.
> 
> Yeah, sorry about that. I tested without --rebase while simplifying the
> testcase, but forgot that I have pull.rebase=true in my ~/.gitconfig, so
> of course that didn't imply --no-rebase.

In the grand scheme of things, it was still a pretty good bug report. :)

Having the stack trace meant that the head-scratching was "why am I not
calling the problem function", rather than "why am I not reproducing",
which is much easier to track down.

-Peff
