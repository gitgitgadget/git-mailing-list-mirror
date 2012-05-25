From: Jeff King <peff@peff.net>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 20:34:57 -0400
Message-ID: <20120525003457.GA11300@sigill.intra.peff.net>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
 <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
 <20120524201553.GA19990@sigill.intra.peff.net>
 <20120524232515.GA11054@sigill.intra.peff.net>
 <7vipflunps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 02:35:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXiUm-0002R1-6V
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333Ab2EYAfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:35:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54657
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab2EYAfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:35:00 -0400
Received: (qmail 2826 invoked by uid 107); 25 May 2012 00:35:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 20:35:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 20:34:57 -0400
Content-Disposition: inline
In-Reply-To: <7vipflunps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198454>

On Thu, May 24, 2012 at 05:08:15PM -0700, Junio C Hamano wrote:

> >   [5/7]: ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
> >   [6/7]: ident: reject bogus email addresses with IDENT_STRICT
> >   [7/7]: format-patch: do not use bogus email addresses in message ids
> >
> > These ones prevent bogus message ids from being generated at all
> > (which is an improvement over the previous state).
> 
> All looked pretty straightforward and cleanly done.
> 
> We might want to further tighten 6/7 to verify user-supplied (i.e. non
> default) e-mail for sanity, as I agree with the comment below --- lines of
> that patch.

Yeah. I'd be fine with more tightening, but I wanted to just catch the
most common uncontroversial problem in the initial round. We can build
on top later if we want.

> Also the check might want to be further tightened in the RFC 822/2822/5322
> sense, but getting it correct will open a huge can of worms; I think the
> check in 6/7 is a good place to stop, at least for now.

Yeah, I considered that, but got nervous thinking about the same can of
worms. It is not like people are complaining now, so I'd rather leave
it.

-Peff
