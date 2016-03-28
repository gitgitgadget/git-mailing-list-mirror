From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] t/perf: "make clean" from the top-level to clean
 results
Date: Mon, 28 Mar 2016 16:20:42 -0400
Message-ID: <20160328202042.GA23792@sigill.intra.peff.net>
References: <xmqqfuvaxsr1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:20:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akded-0001CD-7G
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 22:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbcC1UUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 16:20:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:39553 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755352AbcC1UUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 16:20:45 -0400
Received: (qmail 25373 invoked by uid 102); 28 Mar 2016 20:20:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 16:20:45 -0400
Received: (qmail 16099 invoked by uid 107); 28 Mar 2016 20:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 16:21:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2016 16:20:42 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfuvaxsr1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290063>

On Mon, Mar 28, 2016 at 01:16:50PM -0700, Junio C Hamano wrote:

> Running "make clean" from the top-level after running perf tests
> left t/perf/test-results/ directory and tons of files in it.  At
> least "make distclean" should turn things back to pristine state.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Perhaps I am missing some reason why this was deliberately left
>    out when we added t/perf/Makefile that does have the clean
>    target?  Cc'ing the suspects found by "shortlog t/perf".

I don't think I've ever touched the "clean" code path.

This change is fine by me. I have noticed that the contents of
t/perf/build can pile up and consume quite a lot of space, as they are
all full builds of git. They're a little more expensive to reproduce
than some other things, but they're inherently still a cache. I think
your patch is doing the right thing.

-Peff
