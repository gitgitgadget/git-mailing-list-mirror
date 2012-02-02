From: Jeff King <peff@peff.net>
Subject: Re: how to determine oldest supported version of git
Date: Thu, 2 Feb 2012 14:49:37 -0500
Message-ID: <20120202194937.GB9246@sigill.intra.peff.net>
References: <jgeekn$of2$1@dough.gmane.org>
 <20120202192124.GA19873@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:50:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2fQ-0006co-K8
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab2BBTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:49:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53640
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755987Ab2BBTtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:49:41 -0500
Received: (qmail 24659 invoked by uid 107); 2 Feb 2012 19:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 14:56:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 14:49:37 -0500
Content-Disposition: inline
In-Reply-To: <20120202192124.GA19873@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189685>

On Thu, Feb 02, 2012 at 01:23:40PM -0600, Jonathan Nieder wrote:

> However, in my experience people interested in product lifetimes more
> often mean "versions the vendor will respond to bug reports about"
> rather than "versions getting updates".  If you have discovered a bug
> in an old version of git, even if it is only a couple of major
> releases ago, a good debugging strategy is almost always to try with
> the newest release and see if it still exhibits the bug.  If you don't
> try that, people on this list might just try it themselves.  If it
> doesn't affect recent releases, I would not be surprised if people on
> this list do not necessarily care much.  One can more easily interest
> me at least by pointing out which regression is making it hard to
> upgrade instead.

Agreed. It is very annoying to have somebody report a bug, I (or another
dev) spends time trying to reproduce, and then we find out that it was
actually fixed a year ago.

However, I am much happier if a submitter does that leg-work themselves,
and posts to the list something like:

  I am using version a.b.c. It has bug $FOO, which was fixed by $COMMIT
  and released in d.e.f [or even "I tried d.e.f and it does not exhibit
  the bug"]. This bug fix should get cherry-picked back to a.b.c,
  because {it is more important than usual for reason X, upgrading past
  a.b.c is not feasible for reason Y, etc}.

Nobody wastes time tracking down the already-fixed bug, and it's
relatively easy to decide whether the cherry-pick is worth the effort
based on the reasoning given.

I know not everybody is capable of complex bisection or writing a
succinct test case. But they can at least try to reproduce with the
latest version and convert "there's a bug in git" to "there's a bug in
this old version of git".

-Peff
