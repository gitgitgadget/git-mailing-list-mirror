From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 18:09:08 -0400
Message-ID: <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org> <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca> <20120806193958.GA10039@sigill.intra.peff.net> <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca> <20120806213404.GA14320@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyVWo-00044U-VL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 00:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab2HFWLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 18:11:53 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53607 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700Ab2HFWJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 18:09:14 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54731 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyVU4-0007rK-7K; Mon, 06 Aug 2012 18:09:08 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyVU4-0004bh-6L; Mon, 06 Aug 2012 18:09:08 -0400
In-reply-to: <20120806213404.GA14320@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202993>

Excerpts from Jeff King's message of Mon Aug 06 17:34:04 -0400 2012:
> On Mon, Aug 06, 2012 at 05:31:00PM -0400, Ben Walton wrote:
> 
> > > I'm happy to spend a few cycles on it.  I don't have access to any
> > > real Solaris boxes these days, but I imagine I can get OpenSolaris
> > > running under VirtualBox without too much trouble...
> > 
> > I'm also happy to do this work and have ready access to Solaris 8-11.
> 
> I'm currently in pkgutil hell trying to remember how to get a working
> gcc on Solaris. Bleh. What kind of OS doesn't ship with a compiler by
> default? :)

One that's losing mindshare and isn't gaining traction? *g*  Feel free
to message me offline if you need a hand with that.

> > Would it be reasonable to support using getpassphrase() if
> > !HAVE_DEV_TTY in addition to making the HAVE_DEV_TTY code function
> > on Solaris too?  That would provide a harm reduction for Solaris
> > users that (for some reason) disabled the nicer interface...but
> > maybe it's too much?
> 
> If you think there is a reason that somebody on Solaris might not
> want to use HAVE_DEV_TTY, then I guess it makes sense. But I can't
> really think of one, so I'd be just as happy to leave it until
> somebody does.

No, I can't think of a _good_ reason to do that either.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
