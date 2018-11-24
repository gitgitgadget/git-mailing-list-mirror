Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B266B1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 12:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeKXXDF (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 18:03:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:49974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726170AbeKXXDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 18:03:05 -0500
Received: (qmail 2085 invoked by uid 109); 24 Nov 2018 12:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Nov 2018 12:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1413 invoked by uid 111); 24 Nov 2018 12:14:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 24 Nov 2018 07:14:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2018 07:14:45 -0500
Date:   Sat, 24 Nov 2018 07:14:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: do not reuse output files
Message-ID: <20181124121445.GD19257@sigill.intra.peff.net>
References: <20181124070428.18571-1-max@max630.net>
 <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
 <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 04:47:19PM +0900, Junio C Hamano wrote:

> I do agree that forcing the parent to wait, like you described in
> the comment, would be far more preferrable, [...]

Stray processes can sometimes have funny effects on an outer test
harness, too. E.g., I think I've seen hangs running t5562 under prove,
because some process is holding open a pipe descriptor. This would
probably fix that, too.

> but until that happens,[...]

But if we can't do that immediately for some reason, I do agree with
everything else you said here. ;)

-Peff
