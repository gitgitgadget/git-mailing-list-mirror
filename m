From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 04:14:07 -0400
Message-ID: <20120412081407.GE31122@sigill.intra.peff.net>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <7viphaygsg.fsf@alter.siamese.dyndns.org>
 <vpq62d6dyzr.fsf@bauges.imag.fr>
 <20120412075535.GC31122@sigill.intra.peff.net>
 <vpqhawp2wxs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 12 10:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIFAc-0006Dn-4C
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 10:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2DLIOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 04:14:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2DLIOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 04:14:09 -0400
Received: (qmail 24544 invoked by uid 107); 12 Apr 2012 08:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 04:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 04:14:07 -0400
Content-Disposition: inline
In-Reply-To: <vpqhawp2wxs.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195313>

On Thu, Apr 12, 2012 at 10:09:35AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it is as simple as applying the usual upstream rules, then
> > checking the remote name against the local name. Like this:
> 
> This fails if no upstream is configured. I think applying "current"
> instead of failing in this case makes perfect sense (i.e. "simple"
> should fail only if there is an upstream configured, and it has a
> different name).

Then the rule is not really "act only if upstream and current would do
the same thing".

On the one hand, I think what you are suggesting is reasonable in most
cases. On the other hand, what if the lack of upstream is because the
user failed to configure it properly? Then it could be surprising.

I don't have a strong opinion either way. Do you want to pick up my
patch and start tweaking?

-Peff
