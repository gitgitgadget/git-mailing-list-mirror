Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078CD1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbcLFNmP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:42:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:52378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbcLFNmO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:42:14 -0500
Received: (qmail 17328 invoked by uid 109); 6 Dec 2016 13:42:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:42:13 +0000
Received: (qmail 13300 invoked by uid 111); 6 Dec 2016 13:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 08:42:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 08:42:12 -0500
Date:   Tue, 6 Dec 2016 08:42:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rv@rasmusvillemoes.dk
Subject: Re: [PATCH v2 0/6] shallow.c improvements
Message-ID: <20161206134212.mttcb75dov2jvqu5@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 07:53:33PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Nguyễn Thái Ngọc Duy (4):
>   shallow.c: rename fields in paint_info to better express their purposes
>   shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
>   shallow.c: make paint_alloc slightly more robust
>   shallow.c: remove useless code
> 
> Rasmus Villemoes (2):
>   shallow.c: avoid theoretical pointer wrap-around
>   shallow.c: bit manipulation tweaks

The first 5 patches look obviously good to me. The naming changes in
paint_alloc() make things much clearer, and the fixes retained from
Rasmus are all obvious improvements.

The final one _seems_ reasonable after reading your explanation, but I
lack enough context to know whether or not there might be a corner case
that you're missing. I'm inclined to trust your assessment on it.

-Peff
