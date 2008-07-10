From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Thu, 10 Jul 2008 02:39:41 -0400
Message-ID: <20080710063941.GC3195@sigill.intra.peff.net>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com> <1215616484.3053.6.camel@josh-work.beaverton.ibm.com> <1096648c0807091424g1e10d0ccrae0be929ec428b89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, git@vger.kernel.org
To: Rob Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGppm-0003IZ-J8
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYGJGj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbYGJGj4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:39:56 -0400
Received: from peff.net ([208.65.91.99]:1141 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbYGJGj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:39:56 -0400
Received: (qmail 18034 invoked by uid 111); 10 Jul 2008 06:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 02:39:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 02:39:41 -0400
Content-Disposition: inline
In-Reply-To: <1096648c0807091424g1e10d0ccrae0be929ec428b89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87947>

On Wed, Jul 09, 2008 at 10:24:27PM +0100, Rob Shearman wrote:

> >>  [imap]
> >> +    sslverify = false
> > [...]
> >> +     else if (!strcmp( "ssl_verify", key ))
> >
> > The example and the code disagree on the name of the
> > sslverify/ssl_verify option.
> 
> I wouldn't exactly call it "disagree". The config variable is limited
> by not allowing underscores, whereas the C language does allow them.

I think his point is that the example says "sslverify" but the code is
looking for the config variable "ssl_verify". So that config won't work.

However as you mention, underscore isn't allowed, so your strcmp line is
totally bogus anyway, but you silently fix it in your 3/4 "style" fix.

-Peff
