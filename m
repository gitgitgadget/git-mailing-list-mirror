From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 17:34:04 -0400
Message-ID: <20120806213404.GA14320@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyUwH-0000Ue-Li
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab2HFVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 17:34:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53764 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066Ab2HFVeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 17:34:07 -0400
Received: (qmail 20113 invoked by uid 107); 6 Aug 2012 21:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 17:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 17:34:04 -0400
Content-Disposition: inline
In-Reply-To: <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202991>

On Mon, Aug 06, 2012 at 05:31:00PM -0400, Ben Walton wrote:

> > I'm happy to spend a few cycles on it.  I don't have access to any
> > real Solaris boxes these days, but I imagine I can get OpenSolaris
> > running under VirtualBox without too much trouble...
> 
> I'm also happy to do this work and have ready access to Solaris 8-11.

I'm currently in pkgutil hell trying to remember how to get a working
gcc on Solaris. Bleh. What kind of OS doesn't ship with a compiler by
default? :)

> Would it be reasonable to support using getpassphrase() if
> !HAVE_DEV_TTY in addition to making the HAVE_DEV_TTY code function on
> Solaris too?  That would provide a harm reduction for Solaris users
> that (for some reason) disabled the nicer interface...but maybe it's
> too much?

If you think there is a reason that somebody on Solaris might not want
to use HAVE_DEV_TTY, then I guess it makes sense. But I can't really
think of one, so I'd be just as happy to leave it until somebody does.

-Peff
