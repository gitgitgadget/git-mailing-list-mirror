From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 08:42:13 -0400
Message-ID: <20080729124213.GB12069@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <7vsktto78y.fsf@gitster.siamese.dyndns.org> <20080729050218.GD26997@sigill.intra.peff.net> <e2b179460807290236k214b41f2wee25c213d7c95ae3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoXz-0003fu-3p
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYG2MmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYG2MmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:42:16 -0400
Received: from peff.net ([208.65.91.99]:1667 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYG2MmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:42:15 -0400
Received: (qmail 8822 invoked by uid 111); 29 Jul 2008 12:42:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 08:42:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 08:42:13 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460807290236k214b41f2wee25c213d7c95ae3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90629>

On Tue, Jul 29, 2008 at 10:36:32AM +0100, Mike Ralphson wrote:

> > I just didn't want history thrown away for two reasons:
> >
> >  - historical interest; some of the commits had counterparts in devel
> >    that were done differently (because the two branches had diverged),
> >    but it might later be interesting to see how and why the stable
> >    changes were done (e.g., if a similar situation arose)
> >
> >  - this project did not rebase, favoring the simplicity of "git pull"
> >    over clean history.
> >
> > Bear in mind that this project was not very big. I think devel had ~20
> > commits, and stable had about ~5. So it was easy to get such confidence.
> 
> Is there any reason you couldn't have reverted the stable commits in
> preparation for the merge from devel?

No, there is no technical reason. I think that is a perfectly valid way
of accomplishing the same goal (as is switching to the "kept" branch and
using "-s ours"). It's just that we had a particular mental model, and
the simplest way of translating that model into a git history graph was
as I described.

Again, I don't think this is a common problem, and I have certainly not
been aching for "-s theirs". The question was whether such a thing might
be useful, and I think it is, if only because it most directly matches
how a user might be thinking of the problem; for other users, or other
similar situations, one of the other methods might make more sense.

To me, seeing a commit that joins two histories with a comment saying
"these two branches are now becoming the same, but we don't care about
what happened down this ancestry chain because of X" most directly
models what happened (in my case).

-Peff
