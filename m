Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20DF20189
	for <e@80x24.org>; Mon, 20 Jun 2016 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbcFTKMU (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:12:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:57198 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754144AbcFTKMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:12:17 -0400
Received: (qmail 13341 invoked by uid 102); 20 Jun 2016 10:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 06:05:25 -0400
Received: (qmail 13341 invoked by uid 107); 20 Jun 2016 10:05:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 06:05:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 06:05:23 -0400
Date:	Mon, 20 Jun 2016 06:05:23 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] object_id part 4
Message-ID: <20160620100522.GB14058@sigill.intra.peff.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
 <57665CC6.6070208@kdbg.org>
 <20160619092448.GA12221@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606200853580.22630@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606200853580.22630@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 09:01:30AM +0200, Johannes Schindelin wrote:

> On Sun, 19 Jun 2016, Jeff King wrote:
> 
> > I think traditionally we've avoided struct assignment because some
> > ancient compilers didn't do it. But it's in C89, and I suspect it's
> > crept into the code base anyway over the years without anyone
> > complaining.
> 
> I fear that's my fault, at least partially, seeing as merge-recursive.c
> even *returns* structs (see 6d297f81; I plan to fix that as part of the
> cleaned-up am-3-merge-recursive-direct patch series).

Heh, that commit is quite old. If nobody has complained about it, then I
think there is nothing to be sorry about. If struct assignment (and
returns) work everywhere, and they make the code easier to read, we
should be using them.

I am on the fence regarding oidcpy/oidclr. I agree they _could_ be
struct assignments, but it is also convenient to have concept wrapped up
in a function, in case we ever want to do anything more complicated.

-Peff
