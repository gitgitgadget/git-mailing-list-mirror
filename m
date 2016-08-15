Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8851F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcHOMra (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:47:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752796AbcHOMr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:47:29 -0400
Received: (qmail 14970 invoked by uid 109); 15 Aug 2016 12:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:47:28 +0000
Received: (qmail 14392 invoked by uid 111); 15 Aug 2016 12:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:47:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:47:26 -0400
Date:	Mon, 15 Aug 2016 08:47:26 -0400
From:	Jeff King <peff@peff.net>
To:	Arkady Shapkin <arkady.shapkin@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git shallow clone branch doesn't work with recursive submodules
 cloning
Message-ID: <20160815124725.t6bo5fv4lbbnqnfo@sigill.intra.peff.net>
References: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
 <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net>
 <CAB-zwL2oFMBFjkkoh1EhSD7FCK_1wVV+whu8uxTKTHQKJgNzrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB-zwL2oFMBFjkkoh1EhSD7FCK_1wVV+whu8uxTKTHQKJgNzrQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 03:29:14PM +0300, Arkady Shapkin wrote:

> Thank you, after updating to "2.9.3.windows.1" options "--recursive
> --depth 1" now works.
> 
> But "--recursive --shallow-submodules" and "--recursive
> --shallow-submodules --depth 1" still doesn't work.

It does "work", but the server hosting your submodule may not be
configured to allow you to access the reachable-but-non-tip sha1
directly. So it's not a bug, but rather a configuration issue (and the
"fix" in v2.9.1 is to be less aggressive about enabling
shallow-submodules, since the default server configuration does not
allow it to work well).

More discussion is in:

  http://public-inbox.org/git/OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com/t/#u

-Peff
