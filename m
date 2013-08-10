From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 02:52:52 -0400
Message-ID: <20130810065252.GC30185@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
 <20130810061720.GA30185@sigill.intra.peff.net>
 <20130810064056.GA3165@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Thorsten Glaser <tg@mirbsd.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:53:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V832y-0005Zj-CX
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159Ab3HJGw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:52:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:54203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161147Ab3HJGwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:52:55 -0400
Received: (qmail 27133 invoked by uid 102); 10 Aug 2013 06:52:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 01:52:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 02:52:52 -0400
Content-Disposition: inline
In-Reply-To: <20130810064056.GA3165@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232069>

On Fri, Aug 09, 2013 at 11:40:56PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Even if it worked, though, I am not sure it would be worth such a rule.
> > The /etc/mailname file is not a standard, so you would effectively be
> > cutting off the auto-ident behavior for people on every other system. If
> > we are going to do that, we might as well do it uniformly.
> 
> I don't fully follow.  Do you mean that because other operating
> systems choose not to make full use of an /etc/mailname file when it
> is present (and instead use per-MTA configuration), git should not
> take advantage of it to choose an appropriate email address?
> 
> Or do you mean that on non-Debian systems, the FQDN for localhost is
> reliably the mailname, just like on Debian systems /etc/mailname is
> supposed to be?

Sorry to be unclear. I meant that treating /etc/mailname and gethostname
differently might be justified on Debian under the logic "if you have
/etc/mailname, that is a trustworthy address, and if you do not, then we
cannot guess at a trustworthy address (because putting it in
/etc/mailname is the accepted way to do so on Debian)".

But such logic would not extend to other operating systems, where
/etc/mailname does not have such a status.

I am guessing, too, about what people even put in /etc/mailname. If they
relay mail from the machine to a smarthost, do they put the individual
hostname into /etc/mailname? Or do they put in the domain name that
represents a real deliverable address? If the former, then it is no
better than gethostname anyway.

-Peff
