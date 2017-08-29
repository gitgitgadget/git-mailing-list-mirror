Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BA620285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdH2ITY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:19:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751275AbdH2ITV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 04:19:21 -0400
Received: (qmail 5012 invoked by uid 109); 29 Aug 2017 08:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 08:19:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7665 invoked by uid 111); 29 Aug 2017 08:19:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 04:19:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 04:19:19 -0400
Date:   Tue, 29 Aug 2017 04:19:19 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Kevin Willford <kewillf@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
Message-ID: <20170829081919.gvwdid6fcn7avbih@sigill.intra.peff.net>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-3-kewillf@microsoft.com>
 <8f1a7139-6f5b-eb47-ecb6-ded1d550b06a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f1a7139-6f5b-eb47-ecb6-ded1d550b06a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 06:45:29PM -0400, Ben Peart wrote:

> > Since the debug output has been removed and the caller isn't
> > checking the return value there is no reason to keep calulating
> > and returning a value.
> > 
> 
> Did a quick search and you're right, nothing is using the return value. No
> reason to spend time calculating it.  Looks good.

This is actually one we can reasonably trust the compiler to check for
us. Though of course it doesn't hurt to look at the callers and make
sure that it's sane that they do not care about this return value (I
don't know merge-recursive.c very well, but the current return value
does seem kind of useless).

-Peff
