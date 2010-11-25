From: Jeff King <peff@peff.net>
Subject: Re: First/oldest entry in reflog dropped
Date: Thu, 25 Nov 2010 11:15:34 -0500
Message-ID: <20101125161530.GB24426@sigill.intra.peff.net>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
 <20101121053545.GA10520@sigill.intra.peff.net>
 <alpine.DEB.1.00.1011211233570.2948@bonsai2>
 <20101122044252.GA7362@sigill.intra.peff.net>
 <7vzksztv6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 17:15:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLeU5-0005Ef-RC
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 17:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab0KYQPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 11:15:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54927 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab0KYQPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 11:15:39 -0500
Received: (qmail 10358 invoked by uid 111); 25 Nov 2010 16:15:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 25 Nov 2010 16:15:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Nov 2010 11:15:34 -0500
Content-Disposition: inline
In-Reply-To: <7vzksztv6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162144>

On Tue, Nov 23, 2010 at 04:35:52PM -0800, Junio C Hamano wrote:

> > So let's do this, which is the equivalent behavior to your gotos, but
> > this structure makes more sense to me as a reader (and it doesn't
> > involve goto :) ).
> 
> I have a feeling that we probably should have structured the code a bit
> more modularly, placing some info in "rev" that tells us how to "pop" a
> commit from the rev->list (typically "not the ones that we have shown"),
> what other commits to push back into the queue (typically, "all the
> parents that are not interesting"), and what side effects we should cause
> when we do so (typically, "mark uninteresting parents"), etc., instead of
> the current "if we are walking reflog, here is the special codepath we
> take", so that the walking is more generalized when we did the reflog
> walking (in fact, if we did this properly we probably wouldn't be calling
> it "bolted on").  But for now let's refrain from doing such a rewrite.

FWIW, I agree with all of that. I don't think it's worth fixing now, but
perhaps in libgit2. :)

-Peff
