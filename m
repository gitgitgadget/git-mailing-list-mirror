From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sun, 15 Feb 2009 13:18:18 -0500
Message-ID: <20090215181818.GA2291@coredump.intra.peff.net>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYlbg-00008a-Bp
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 19:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZBOSSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbZBOSSV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:18:21 -0500
Received: from peff.net ([208.65.91.99]:46572 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbZBOSSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 13:18:21 -0500
Received: (qmail 8758 invoked by uid 107); 15 Feb 2009 18:18:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 13:18:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 13:18:18 -0500
Content-Disposition: inline
In-Reply-To: <200902151711.45099.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110027>

On Sun, Feb 15, 2009 at 05:11:40PM +0100, Thomas Rast wrote:

> > > +	MSG=3 test_must_fail git notes edit
> > 
> > test_must_fail is a shell function, and we have precedence 2d60615 (tests:
> > Avoid single-shot environment export for shell function invocation,
> > 2009-01-26) to avoid this construct.
> 
> Bah.  I really have a bad memory, don't I?
> 
> Is there a "bare minimum" POSIX shell that I can run the tests under,
> to save myself such embarassment in the future?

Using "dash" will catch bash-isms, and is pretty commonly available, I
think.  But this behavior, IIRC, happens on FreeBSD's /bin/sh, which is
derived from "ash" (so is "dash", but I they have long since diverged).

There are even more quirks on more exotic systems, I expect, though I
have to admit that I gave up on Solaris and just started using bash
there. :)

So I don't think there is a catch-all shell that will help you, but some
"ash" variant is probably your best bet.

-Peff
