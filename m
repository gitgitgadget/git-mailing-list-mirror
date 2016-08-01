Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6ED1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbcHAR7E (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:59:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:52643 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbcHAR7C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:59:02 -0400
Received: (qmail 8750 invoked by uid 102); 1 Aug 2016 17:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:52:20 -0400
Received: (qmail 15278 invoked by uid 107); 1 Aug 2016 17:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:52:17 -0400
Date:	Mon, 1 Aug 2016 13:52:17 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801175216.payv2zrc3mkvkbmz@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <CACsJy8AEFFTnGw01mTBrZu8QnUWmQav7bhZUyw7o91ph7DUwaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AEFFTnGw01mTBrZu8QnUWmQav7bhZUyw7o91ph7DUwaA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 07:46:34PM +0200, Duy Nguyen wrote:

> On Mon, Aug 1, 2016 at 3:05 AM, Eric Wong <e@80x24.org> wrote:
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > Allowing PAGER_ENV to be set at build-time allows us to move
> > pager-specific knowledge out of our build.  Currently, this
> > allows us to set a better default for FreeBSD where more(1)
> > is the same binary as less(1).
> 
> Nice. I was just too lazy to do something like this and "export
> PAGER=less LESS=FRX" then ignored it :-P
> 
> Slightly off topic, but pagers like 'more' does not understand colors
> either. But color.ui = auto does not know what and prints color code
> anyway. It would be nice if we had some configuration to describe
> "this pager can show colors, that pager does not" so I don't have to
> maintain separate .gitconfig files on two platforms.

If you are interested, I suggest you read the thread linked earlier:

  https://public-inbox.org/git/52D87A79.6060600%40rawbw.com/T/#u

which discusses this and other issues. But basically, I think you cannot
really solve this without getting intimate with each pager (which people
seemed not to want to do).

-Peff
