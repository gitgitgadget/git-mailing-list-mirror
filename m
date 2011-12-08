From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] add generic terminal prompt function
Date: Thu, 8 Dec 2011 16:52:18 -0500
Message-ID: <20111208215218.GA12127@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
 <20111208083323.GE26409@sigill.intra.peff.net>
 <m38vmmivkc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 22:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYltC-0001zm-3z
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 22:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1LHVwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 16:52:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44583
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab1LHVwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 16:52:20 -0500
Received: (qmail 31698 invoked by uid 107); 8 Dec 2011 21:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 16:58:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 16:52:18 -0500
Content-Disposition: inline
In-Reply-To: <m38vmmivkc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186599>

On Thu, Dec 08, 2011 at 01:48:33PM -0800, Jakub Narebski wrote:

> > @@ -833,6 +838,7 @@ ifeq ($(uname_S),Linux)
> >  	NO_STRLCPY = YesPlease
> >  	NO_MKSTEMPS = YesPlease
> >  	HAVE_PATHS_H = YesPlease
> > +	HAVE_DEV_TTY = YesPlease
> >  endif
> 
> Here you use HAVE_DEV_TTY (by the way, I wonder if it could be
> automatically detected by ./configure script)...
> [...]
> ...and here you have NO_DEV_TTY

Whoops. Thanks for catching. I converted it to NO_DEV_TTY, which would
turn this code on by default (because I think _most_ platforms we use
are going to want this), but then I decided to go the conservative route
and let platforms opt into it.

And of course since my platform is the one that enables it, I didn't
notice during my testing.

I'll fix it for the next re-roll.

-Peff
