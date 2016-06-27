Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7433D2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbcF0QgD (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:36:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:33324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751784AbcF0QgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:36:02 -0400
Received: (qmail 28715 invoked by uid 102); 27 Jun 2016 16:36:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:36:01 -0400
Received: (qmail 9087 invoked by uid 107); 27 Jun 2016 16:36:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:36:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 12:35:59 -0400
Date:	Mon, 27 Jun 2016 12:35:59 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] config: add conditional include
Message-ID: <20160627163559.GA5296@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160626182715.GA12546@sigill.intra.peff.net>
 <CACsJy8DAMe3YH-f_Qm8FEmanXepnwF2z1L6DDGoJf1eysmW2xQ@mail.gmail.com>
 <20160627162052.GA4532@sigill.intra.peff.net>
 <CACsJy8D6TxkMWJTUCeDd8tuMyTRXcvWdMw4VL3nO7jbLEgjE-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8D6TxkMWJTUCeDd8tuMyTRXcvWdMw4VL3nO7jbLEgjE-A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 06:32:39PM +0200, Duy Nguyen wrote:

> On Mon, Jun 27, 2016 at 6:20 PM, Jeff King <peff@peff.net> wrote:
> > You do allow distinguishing the suffix thing with "/" at the end in the
> > rule above, though. So between the two rules:
> >
> >   - slash at the end is a shorthand for "/**"
> >
> >   - no-slash at the beginning (i.e., a non-absolute path) is a shorthand
> >     for "**/" at the beginning
> 
> Neither slash or "./" at the beginning...
> 
> > you should be able to specify anything.
> 
> ...then yeah it looks pretty good. With the exception of  "./" we can
> still have paths relative to where the the config file is. For
> $HOME/.gitconfig that  eliminates the need for expanding "~"
> ($HOME/.config/git/config may still need it, unless we allow "../"
> too, but that complicates matching).

Yeah, I didn't think actual relative paths were that interesting, but if
we declare that they are relative to the config file, I agree that
works pretty well. And I agree that "./" is a convenient way to anchor
them.

-Peff
