From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Fri, 26 Feb 2010 17:40:11 -0500
Message-ID: <20100226224011.GB24370@sigill.intra.peff.net>
References: <20100222110814.GA3247@progeny.tock>
 <20100222112326.GA21929@coredump.intra.peff.net>
 <ca433831002252011r3d3459a2xca7535300cd6630f@mail.gmail.com>
 <20100226093633.GA9609@coredump.intra.peff.net>
 <ca433831002261333n4165d450k40e5feae72937cdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl8rG-0003SD-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 23:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966472Ab0BZWkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 17:40:15 -0500
Received: from peff.net ([208.65.91.99]:58101 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966347Ab0BZWkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 17:40:13 -0500
Received: (qmail 5478 invoked by uid 107); 26 Feb 2010 22:40:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 26 Feb 2010 17:40:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 17:40:11 -0500
Content-Disposition: inline
In-Reply-To: <ca433831002261333n4165d450k40e5feae72937cdc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141158>

On Fri, Feb 26, 2010 at 04:33:23PM -0500, Mark Lodato wrote:

> > Which is almost a 12% speedup by dropping openssl.
> 
> I got about an 8% speedup on this test.

Thanks for more data. It looks like the patch is probably a win for me
(depending on how you slice the workload), and definitely a win for you,
then. So probably it is a sane thing to change the default.

I suspect the reason I got more of a speedup for "make test" is that I
don't do the svn or cvs tests, both of which are really slow and won't
be improved by the patch. If you have either installed, then that is
diluting your speedup.

-Peff
