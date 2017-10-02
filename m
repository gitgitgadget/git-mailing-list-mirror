Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40D4202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 06:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdJBG4Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:56:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751101AbdJBG4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:56:23 -0400
Received: (qmail 10546 invoked by uid 109); 2 Oct 2017 06:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26382 invoked by uid 111); 2 Oct 2017 06:57:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:57:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:56:21 -0400
Date:   Mon, 2 Oct 2017 02:56:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171002065621.ob3icxhlkefpsm4v@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 10:23:26PM -0700, Taylor Blau wrote:

> Attached is the sixth revision of my patch-set "Support %(trailers)
> arguments in for-each-ref(1)".
> 
> In includes the following changes since v5:
> 
>   * Added an additional patch to change t4205 to harden `unfold()`
>     against multi-line trailer folding.
> 
>   * Added a missing parameter call in ref-filter.c to
>     `trailers_atom_parser` through `contents_atom_parser`.
> 
> I believe that this version of the series should be ready for queueing.

This looks good to me, modulo the flipped logic in the final patch.

Since that's the only thing I noticed, let's hold off on a reroll for
the moment to see if there are any more comments (and I won't be
surprised if Junio just picks it up with the tweak, but we'll see).

Please do make sure that "make test" runs clean before posting (I
usually run it on each commit to catch any "oops, we broke this and then
refixed it" in the middle of the series, too).

-Peff
