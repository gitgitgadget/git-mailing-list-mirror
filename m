From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
	998 symbols
Date: Fri, 21 Nov 2008 07:04:35 -0500
Message-ID: <20081121120435.GC3747@sigill.intra.peff.net>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com> <1227263693.3311.0.camel@therock.nsw.bigpond.net.au> <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arafangion <thestar@fussycoder.id.au>, git@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Ulr-0005HT-Pg
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbYKUMEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYKUMEj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:04:39 -0500
Received: from peff.net ([208.65.91.99]:3523 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbYKUMEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:04:38 -0500
Received: (qmail 28696 invoked by uid 111); 21 Nov 2008 12:04:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 21 Nov 2008 07:04:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2008 07:04:35 -0500
Content-Disposition: inline
In-Reply-To: <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101514>

On Fri, Nov 21, 2008 at 12:37:08PM +0200, Andy Shevchenko wrote:

> > As a curiosity, why is such a check even neccessary?
> I'm not an author of that strange check (possible it's somehow related
> to b8ebe08b9a643f432866eb7150c3b20d59b755f2)

I am the author, and it was a direct response to a user who had
something in his mail path munging overly long lines (which are, in
fact, disallowed by rfc 2822).

Read this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/70847

which contains the problem report and the patches. We could take this
one step further (but didn't at the time) by QP-encoding the body part
with long lines, which is what a normal MUA would do. Since the
receiving tools for git handle this situation, it should work fine. I
think such a patch would be welcome.

-Peff
