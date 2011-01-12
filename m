From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Wed, 12 Jan 2011 12:27:51 -0500
Message-ID: <20110112172751.GA31747@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
 <20110111065207.GF10094@sigill.intra.peff.net>
 <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
 <20110111180208.GC1833@sigill.intra.peff.net>
 <20110112012515.GA30856@sigill.intra.peff.net>
 <7vd3o232xk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 18:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd4UM-0005xH-6b
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 18:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1ALR14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 12:27:56 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957Ab1ALR1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 12:27:55 -0500
Received: (qmail 22458 invoked by uid 111); 12 Jan 2011 17:27:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 17:27:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 12:27:51 -0500
Content-Disposition: inline
In-Reply-To: <7vd3o232xk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165020>

On Wed, Jan 12, 2011 at 01:07:51AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure. And to be honest I don't really care, because I think
> > people with ambiguous refs are little bit crazy anyway (after all, in
> > the current code it simply calls die()). But I think there is some
> > argument to be made that due to tracking, start_point is not _just_
> > a regular ref. We do care about its branchiness.
> 
> I do not really care either myself, and if 
> 
>     git branch --track foo heads/ambiguity
>     git branch --track foo tags/ambiguity
> 
> allows the user to differentiate between the branch and the tag, it would
> be more than sufficient.

It does already. So I am inclined to leave it alone, then. I doubt
anyone actually cares, and if they do, they will get an error message,
after which they can manually disambiguate themselves.

So let's leave it at the mega-patch I posted earlier.

-Peff
