Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7941D1FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756186AbcLWWNB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 17:13:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:60062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753837AbcLWWNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 17:13:00 -0500
Received: (qmail 3833 invoked by uid 109); 23 Dec 2016 22:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 22:12:54 +0000
Received: (qmail 26899 invoked by uid 111); 23 Dec 2016 22:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 17:13:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2016 17:12:51 -0500
Date:   Fri, 23 Dec 2016 17:12:51 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH v2 1/2] auto gc: don't write bitmaps for incremental
 repacks
Message-ID: <20161223221251.2x5aykpuj6p2kvoh@sigill.intra.peff.net>
References: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 02:43:34PM -0500, David Turner wrote:

> When git gc --auto does an incremental repack of loose objects, we do
> not expect to be able to write a bitmap; it is very likely that
> objects in the new pack will have references to objects outside of the
> pack.  So we shouldn't try to write a bitmap, because doing so will
> likely issue a warning.

Makes sense. Another reason is that the bitmap-reading code only handles
a single bitmap. So it makes sense only to generate one during the
all-in-one repack. I don't know if that is worth mentioning.

> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Jeff King <peff@peff.net>

I don't remember if I signed off the original, but just for the record,
my signoff here is valid.

-Peff
