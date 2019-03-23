Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D30620248
	for <e@80x24.org>; Sat, 23 Mar 2019 06:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCWGia (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 02:38:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:33512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726046AbfCWGia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 02:38:30 -0400
Received: (qmail 25059 invoked by uid 109); 23 Mar 2019 06:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Mar 2019 06:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26781 invoked by uid 111); 23 Mar 2019 06:38:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Mar 2019 02:38:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2019 02:38:27 -0400
Date:   Sat, 23 Mar 2019 02:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: How to properly find git config in a libgit.a-using executable?
Message-ID: <20190323063827.GA9227@sigill.intra.peff.net>
References: <20190320101941.2xjsjx3zfnnp33a2@glandium.org>
 <20190322073311.GA839@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 02:39:43PM +0100, Johannes Schindelin wrote:

> How about
> 
> 	GIT_EDITOR=echo git config --system -e 2>/dev/null
> 
> It will error out if the directory does not exist, for some reason, e.g.
> when you installed Git in your home directory via `make install` from a
> fresh clone. So you'll have to cope with that contingency.

Oh, that's much more clever than mine. I did wonder if it would require
the containing directory to be writable, but it seems that "--edit" does
not do the usual lock-and-rename.

-Peff
