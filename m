Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FF91FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 03:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754929AbdD0DUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:20:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40960 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdD0DUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:20:40 -0400
Received: (qmail 13475 invoked by uid 109); 27 Apr 2017 03:20:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:20:40 +0000
Received: (qmail 20809 invoked by uid 111); 27 Apr 2017 03:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:21:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:20:38 -0400
Date:   Wed, 26 Apr 2017 23:20:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: accept --threads=<n> and pass it down to
 pack-objects
Message-ID: <20170427032037.em2qvju5pdf2dbbl@sigill.intra.peff.net>
References: <xmqqr30er9tk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr30er9tk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 05:08:39PM -0700, Junio C Hamano wrote:

> We already do so for --window=<n> and --depth=<n>; this will help
> when the user wants to force --threads=1 for reproducible testing
> without getting affected by racing multiple threads.

Seems reasonable. I usually just do this with:

  git -c pack.threads=1 repack ...

but it does not hurt to have a real command line option.

> ---
>  Documentation/git-repack.txt | 5 ++++-
>  builtin/repack.c             | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

The patch itself looks obviously correct.

-Peff
