From: Jeff King <peff@peff.net>
Subject: Re: Fix signal handler
Date: Wed, 3 Feb 2010 10:17:09 -0500
Message-ID: <20100203151709.GA28477@coredump.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B689CC5.3000400@web.de>
 <20100202223208.GB18781@sigill.intra.peff.net>
 <4B694DEE.5030207@web.de>
 <20100203102915.GA25486@coredump.intra.peff.net>
 <4B696447.10803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:17:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncgyl-00057C-Sz
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab0BCPRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:17:13 -0500
Received: from peff.net ([208.65.91.99]:50220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201Ab0BCPRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:17:13 -0500
Received: (qmail 29021 invoked by uid 107); 3 Feb 2010 15:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 10:17:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 10:17:09 -0500
Content-Disposition: inline
In-Reply-To: <4B696447.10803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138835>

On Wed, Feb 03, 2010 at 12:55:51PM +0100, Markus Elfring wrote:

> > It's not that we're ignoring a specification, it's that there _isn't_
> > a concrete specification for the set of systems we're interested in.
> 
> I have got doubts on your view. Known specifications are available for
> POSIX and corresponding programming languages like C and C++. I know
> that they have got open issues on their own because a few important
> wordings are not as precise and clear as you might prefer.
> 
> For which software environments do you miss programming standards?

Off the top of my head, I have seen mention of git running on Linux,
{Free,Net,Open}BSD, Solaris 7-10, OpenSolaris, AIX 5.x and 6.x, HP-UX,
Windows, SCO OpenServer, and SCO UnixWare. Not all of those are POSIX,
and I am not sure even if they were that we could (or would want to)
stick to a strict subset of POSIX. If all of those systems allow less
strict behavior, then what is the problem in taking advantage of it if
it makes development or maintenance of the code easier?

Ditto for C. We mostly stick to C89, but there are many parts of the C89
standard where behavior may be implementation defined or even undefined,
but in practice work just fine. I am not interested in spending a lot of
effort working around those issues just to meet the letter of the
standard if there is no practical system on which it matters.

> How many efforts would you like to spend on conditional compilation for
> "special" platforms?

If I haven't made that clear, _I_ don't want to spend any effort. If
_you_ are concerned about it, feel free to make a patch. If your patch
is not too intrusive, and especially if you can demonstrate that it is a
problem on a real-world system, then I think your patch would be
considered for inclusion upstream.

If you are not willing to spend any effort on these problems, and
instead are trying to direct _my_ priorities, then I have no interest in
listening to what you have to say (and I suspect that goes for the rest
of the regular git developers, too).

-Peff
