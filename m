From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 10:24:49 -0800
Message-ID: <20130116182449.GA4881@sigill.intra.peff.net>
References: <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
 <20130116181203.GB2476@farnsworth.metanate.com>
 <20130116181558.GA4426@sigill.intra.peff.net>
 <20130116182240.GC2476@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXfn-0008EO-2i
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab3APSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:24:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35466 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474Ab3APSYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:24:54 -0500
Received: (qmail 14482 invoked by uid 107); 16 Jan 2013 18:26:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 13:26:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 10:24:49 -0800
Content-Disposition: inline
In-Reply-To: <20130116182240.GC2476@farnsworth.metanate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213795>

On Wed, Jan 16, 2013 at 06:22:40PM +0000, John Keeping wrote:

> > > [1] http://llvm.org/bugs/show_bug.cgi?id=13747
> > 
> > Yeah, I think it is exactly the same issue, and the fix they mention
> > there would apply to us, too.
> > 
> > Is it worth applying this at all, then? Or should we apply it but limit
> > it with a clang version macro (they mention r163034, but I do not know
> > if it is in a released version yet, nor what macros are available to
> > inspect the version)?
> 
> That maps to revision 06b3a06007 in their git repository [1], which is
> contained in remotes/origin/release_32 so I think that change should be
> in release 3.2, where I still see the warning (although that's not using
> a clang built from that source), so I don't think that the fix for that
> bug removes the warning in this case.
> 
> [1] http://llvm.org/git/clang.git

Thanks for checking. I'd rather squelch the warning completely (as in my
re-post of Max's patch from a few minutes ago), and we can loosen it
(possibly with a version check) later when a fix is widely disseminated.

I know that compiling git with clang is not warning-free yet, but it is
close, and I do not mind if somebody puts some effort into making it so.
This gets us one step closer.

-Peff
