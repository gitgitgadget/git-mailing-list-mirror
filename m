Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BA920248
	for <e@80x24.org>; Mon,  1 Apr 2019 13:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDANIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 09:08:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:42848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726764AbfDANIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 09:08:07 -0400
Received: (qmail 24993 invoked by uid 109); 1 Apr 2019 13:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Apr 2019 13:08:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13146 invoked by uid 111); 1 Apr 2019 13:08:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Apr 2019 09:08:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2019 09:08:04 -0400
Date:   Mon, 1 Apr 2019 09:08:04 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v1 1/2] Documentation/rev-list-options: wrap
 --date=<format> block with "--"
Message-ID: <20190401130804.GA11664@sigill.intra.peff.net>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-2-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190330183001.16624-2-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 02:30:00PM -0400, Todd Zullinger wrote:

> Using "+" to continue multiple list items is more tedious and
> error-prone than wrapping the entire block with "--" block markers.
> 
> When using asciidoctor, the list items after the --date=iso list items
> are incorrectly formatted when using "+" continuation.  Use "--" block
> markers to correctly format the block.
> 
> When using asciidoc there is no change in how the content is rendered.

This seems like an asciidoctor bug, though I think this kind of
list-within-a-list stuff is inherently a bit heuristic-driven just due
to the syntax.

I do agree that the result after your patch is more readable, so I think
I prefer it even if the asciidoctor bug were fixed. I suspect we could
be using "--" blocks for readability in more places (I don't think it's
worth going on a hunt to convert old spots, but something to keep in
mind as we write new documentation).

-Peff
