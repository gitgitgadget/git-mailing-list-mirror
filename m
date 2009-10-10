From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting
 GIT_EXIT_OK to GIT_EXIT_CODE
Date: Sat, 10 Oct 2009 10:03:36 -0400
Message-ID: <20091010140336.GB16827@sigill.intra.peff.net>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
 <20091010120121.GA16336@localhost>
 <m2eipbphbr.fsf@igel.home>
 <1255178966-sup-5813@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Oct 10 16:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwccg-0006p9-GA
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 16:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761239AbZJJOEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761230AbZJJOEQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 10:04:16 -0400
Received: from peff.net ([208.65.91.99]:36073 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759083AbZJJOEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 10:04:16 -0400
Received: (qmail 24298 invoked by uid 107); 10 Oct 2009 14:07:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 10 Oct 2009 10:07:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Oct 2009 10:03:36 -0400
Content-Disposition: inline
In-Reply-To: <1255178966-sup-5813@ntdws12.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129884>

On Sat, Oct 10, 2009 at 08:53:00AM -0400, Ben Walton wrote:

> > According to the autoconf docs this bug is also present in the Solaris
> > /bin/sh (and autoconf generated scripts use some elaborated workaround).
> 
> Solaris' /bin/sh shouldn't be used for anything but forking a decent
> shell, imo.  It was brought to my attention recently that the test
> suite for mercurial on solaris was failing the git tests.  The
> mercurial folks initially thought this was a git on solaris bug.

Yes, that is the attitude we take towards /bin/sh on Solaris. Most
people running git on Solaris (or other broken-shell platforms) point
SHELL_PATH to bash. I think the point of Brandon's patch is to let them
use a native shell.

So while /bin/sh is broken, the question is whether the alternate native
shell is broken enough to use or not.

-Peff
