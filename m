Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B84D1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdAYRkC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 12:40:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:44553 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbdAYRkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 12:40:01 -0500
Received: (qmail 21017 invoked by uid 109); 25 Jan 2017 17:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 17:40:00 +0000
Received: (qmail 13421 invoked by uid 111); 25 Jan 2017 17:40:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 12:40:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 12:39:58 -0500
Date:   Wed, 25 Jan 2017 12:39:58 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
Message-ID: <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
 <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
 <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251800120.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701251800120.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 06:01:11PM +0100, Johannes Schindelin wrote:

> > Looks like "mv" prompts and then fails to move the file (so we get the
> > dangling blob for the source blob, and fsck doesn't report failure
> > because we didn't actually corrupt the destination blob).
> 
> IIRC I had similar problems years ago, on a machine where the
> administrator defined mandatory aliases, including mv="mv -i".

Yeah, that was my first thought, too. But this should be a
non-interactive shell, which would generally avoid loading rc files. I
think there are some exceptions, though (e.g., setting ENV or BASH_ENV).
Loading aliases like "mv -i" for non-interactive shells seems somewhat
insane to me. But whatever the cause, I think the workaround I posted is
easy enough to do.

-Peff
