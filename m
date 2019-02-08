Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595C41F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBHWhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:37:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:38216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726020AbfBHWhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 17:37:23 -0500
Received: (qmail 27781 invoked by uid 109); 8 Feb 2019 22:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 22:37:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27946 invoked by uid 111); 8 Feb 2019 22:37:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 17:37:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 17:37:21 -0500
Date:   Fri, 8 Feb 2019 17:37:21 -0500
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v2] t5562: remove dependency on /dev/zero
Message-ID: <20190208223720.GB2135@sigill.intra.peff.net>
References: <20190208220751.9936-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208220751.9936-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 05:07:51PM -0500, randall.s.becker@rogers.com wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
> with yes and a translation of its result to a stream of NULL. This is
> a more portable solution.

They're NULs, not NULLs. :)

I think in this case, though, we don't actually care about the bytes,
and you can drop the "tr" invocation entirely.

-Peff
