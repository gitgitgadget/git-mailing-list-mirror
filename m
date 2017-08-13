Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40BE208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 04:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdHME6Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 00:58:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750974AbdHME6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 00:58:16 -0400
Received: (qmail 12013 invoked by uid 109); 13 Aug 2017 04:58:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 04:58:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28533 invoked by uid 111); 13 Aug 2017 04:58:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 00:58:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Aug 2017 00:58:13 -0400
Date:   Sun, 13 Aug 2017 00:58:13 -0400
From:   Jeff King <peff@peff.net>
To:     "Dominik Mahrer (Teddy)" <teddy@teddy.ch>
Cc:     git@vger.kernel.org
Subject: Re: NO_MSGFMT
Message-ID: <20170813045813.i42mgwn3dmm6u52o@sigill.intra.peff.net>
References: <b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 03:44:17PM +0200, Dominik Mahrer (Teddy) wrote:

> Hi all
> 
> I'm compiling git from source code on a mashine without msgfmt. This leads
> to compile errors. To be able to compile git I created a patch that at least
> works for me:

Try:

  make NO_MSGFMT=Nope NO_GETTEXT=Nope

This also works:

  make NO_GETTEXT=Nope NO_TCLTK=Nope

The flags to avoid gettext/msgfmt are sadly different between git itself
and git-gui/gitk, which we include as a subproject. It would be a useful
patch to harmonize though (probably by accepting both in all places for
compatibility).

-Peff
