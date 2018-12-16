Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF531F405
	for <e@80x24.org>; Sun, 16 Dec 2018 10:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeLPKzH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:55:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:43260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729811AbeLPKzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:55:07 -0500
Received: (qmail 24586 invoked by uid 109); 16 Dec 2018 10:55:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:55:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22401 invoked by uid 111); 16 Dec 2018 10:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:54:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:55:05 -0500
Date:   Sun, 16 Dec 2018 05:55:05 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] git-init.txt: do not nest open blocks
Message-ID: <20181216105505.GE13704@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181215112742.1475882-3-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215112742.1475882-3-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 12:27:40PM +0100, Martin Ågren wrote:

> It appears we try to nest open blocks, but that does not work well with
> Asciidoctor, which fails to indent the inner block. This causes the
> inner block to be set as if it had nothing to do with `--shared`. Drop
> the outer one. Asciidoc renders identically before and after this patch,
> both man-page and html.

Hrm. I'm not sure how we're supposed to have a block-within-a-block in
asciidoctor, and that may be something we want to fix in the long run.
But I agree this block around all of the options is not doing anything
useful, and the simplest solution here is just to get rid of it.

It dates all the way back to d145144c3b (Document git-init, 2007-01-11),
so perhaps it did something useful in an ancient version of asciidoc.

-Peff
