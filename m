From: Jeff King <peff@peff.net>
Subject: Re: Cannot push a commit
Date: Wed, 18 Jan 2012 18:09:14 -0800
Message-ID: <20120119020913.GA20219@sigill.intra.peff.net>
References: <4F1297E0.1060703@fechner.net>
 <20120116212036.GA21132@sigill.intra.peff.net>
 <4F1524DB.2080009@fechner.net>
 <4F170E7E.9000804@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 03:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnhRO-0003YC-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 03:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109Ab2ASCJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 21:09:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41637
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757096Ab2ASCJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 21:09:17 -0500
Received: (qmail 5363 invoked by uid 107); 19 Jan 2012 02:16:15 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jan 2012 21:16:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2012 18:09:14 -0800
Content-Disposition: inline
In-Reply-To: <4F170E7E.9000804@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188788>

On Wed, Jan 18, 2012 at 07:25:02PM +0100, Matthias Fechner wrote:

> Am 17.01.2012 08:35, schrieb Matthias Fechner:
> > So the problem has something to do with windows as client. I will do
> > some additional test this evening.
> > 
> > Where can we continue to search?
> [...]
> Then I opened the git bash and inserted:
> export GIT_SSH=plink.exe
> git push
> [...]

Thanks for following up on this. It does seem like openssh is dropping
your connection in a half-duplex way, though we don't know why. A bug in
openssh sounds like a reasonable candidate...

> The currently installed version is OpenSSH_4.6p1, OpenSSL 0.9.8e 23
> Feb 2007.  Maybe an updated openssh version in the git bin folder will
> solve the problem?

Especially given how old your version is. Certainly I would try with a
more recent version. If it clears up the problem, I'm willing to assume
it's an openssh bug that's been fixed. If it doesn't, then it may be an
open openssh bug, or perhaps there is some problem in the way we're
invoking it on Windows. We can investigate that path if need be.

-Peff
