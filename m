Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE953202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbdJPW6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 18:58:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:54698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932675AbdJPW6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 18:58:18 -0400
Received: (qmail 13765 invoked by uid 109); 16 Oct 2017 22:58:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:58:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18057 invoked by uid 111); 16 Oct 2017 22:58:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 18:58:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 18:58:16 -0400
Date:   Mon, 16 Oct 2017 18:58:16 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Joris Valette <joris.valette@gmail.com>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
Message-ID: <20171016225816.mowrldmfkx6q7ape@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
 <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
 <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
 <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
 <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
 <87po9m3e3e.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po9m3e3e.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 12:47:01AM +0200, Andreas Schwab wrote:

> On Okt 16 2017, Jeff King <peff@peff.net> wrote:
> 
> > I can't help but feel this is the tip of a larger iceberg, though. E.g.,
> > what about characters outside of the terminal's correct encoding? Or
> > broken UTF-8 characters?
> 
> Or correctly encoded UTF-8 characters that look confusing?  Or blobs
> with embedded escape sequences?

Yes, leaving ESC unfiltered here made me hesitate, too. We must allow it
to show colors, but showing diffs with raw terminal codes can be quite
confusing.

My general advice on committing unprintable characters is: don't.

-Peff
