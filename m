From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu, 3 Jan 2013 15:37:39 -0500
Message-ID: <20130103203738.GA8269@sigill.intra.peff.net>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
 <20130103203222.GB4632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:38:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqrY8-0004yH-OU
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab3ACUhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:37:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42298 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775Ab3ACUhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:37:41 -0500
Received: (qmail 10440 invoked by uid 107); 3 Jan 2013 20:38:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 15:38:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 15:37:39 -0500
Content-Disposition: inline
In-Reply-To: <20130103203222.GB4632@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212609>

On Thu, Jan 03, 2013 at 03:32:22PM -0500, Jeff King wrote:

> On Thu, Jan 03, 2013 at 11:05:18AM -0800, Junio C Hamano wrote:
> 
> > This allows things like:
> > 
> >   $ DEFAULT_DOC_TARGET=html make doc
> >   $ DEFAULT_DOC_INSTALL_TARGET=html make install-doc
> > 
> > on a platform that does not have manpage viewer.  Which is not very
> > useful, given that you can already say
> > 
> >   $ make install-html
> > 
> > on such a platform, and these install-$format targets will not go
> > away.
> 
> I think the usefulness is that it can be set by default for a particular
> uname, so people on Windows can just type "make install-doc" without
> having to care about setting anything (though to be honest, I do not
> even know what they build by default; maybe they do build manpages).

I also notice that we have DEFAULT_HELP_FORMAT (which is "html" on
Windows). Wouldn't that be a sane default for DEFAULT_DOC_TARGET if it
is set? I guess we can set all three independently for maximum
flexibility, though, but it seems like a sane fallback.

-Peff
