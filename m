Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10FD20958
	for <e@80x24.org>; Tue, 28 Mar 2017 07:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbdC1HcD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 03:32:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52793 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753896AbdC1HcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 03:32:02 -0400
Received: (qmail 27055 invoked by uid 109); 28 Mar 2017 07:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 07:32:00 +0000
Received: (qmail 7095 invoked by uid 111); 28 Mar 2017 07:32:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 03:32:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 03:31:59 -0400
Date:   Tue, 28 Mar 2017 03:31:59 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
Message-ID: <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 04:01:22PM +0000, brian m. carlson wrote:

> This is part 7 in the continuing transition to use struct object_id.
> 
> This series focuses on two main areas: adding two constants for the
> maximum hash size we'll be using (which will be suitable for allocating
> memory) and converting struct sha1_array to struct oid_array.

Both changes are very welcome. I do think it's probably worth changing
the name of sha1-array.[ch], but it doesn't need to happen immediately.

I read through the whole series and didn't find anything objectionable.
The pointer-arithmetic fix should perhaps graduate separately.

I suggested an additional cleanup around "linelen" in one patch. In the
name of keeping the number of re-rolls sane, I'm OK if we skip that for
now (the only reason I mentioned it at all is that you have to justify
the caveat in the commit message; with the fix, that justification can
go away).

-Peff
