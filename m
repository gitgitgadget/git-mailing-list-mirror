From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom
 merge strategy
Date: Tue, 29 Jul 2008 01:27:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNc7s-0001c3-EC
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676AbYG1X0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758688AbYG1X0i
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:26:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:46570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751263AbYG1X0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:26:37 -0400
Received: (qmail invoked by alias); 28 Jul 2008 23:26:35 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp024) with SMTP; 29 Jul 2008 01:26:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P82d/xk0Pz1c/ZNUONqd584VQpg8J8NYGVDW8zm
	lbXnmWtRiXuInp
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080728192651.GA26677@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90522>

Hi,

On Mon, 28 Jul 2008, Jeff King wrote:

> On Mon, Jul 28, 2008 at 08:09:55PM +0100, Johannes Schindelin wrote:
> 
> > Well, I have to say that the workflow is a bit backwards if the person 
> > who _publishes_ the thing is the one saying "Ooops, my version no 
> > goodie, other version please, but so that pull still works".
> > 
> > I would have expected the one who has the good version to make the 
> > choice.
> 
> My situation was two long-running branches, "stable" and "devel", both 
> of which were worked on by many developers. One person was in charge of 
> integration and branch management. They wanted "stable" to get the 
> contents of "devel" (which were now ready for release), ignoring any 
> small fixes that had been done on "stable" (since they had all been 
> moved over to "devel" previously, but in subtly different ways that 
> would create conflicts). And "git reset" was not an option, because they 
> wanted to keep the history of "stable" in case those fixes needed to be 
> looked at later.
> 
> So the logical sequence was:
> 
>   git checkout production
>   git merge -s theirs master

To me, this suggests that they were too married to 'production' being the 
"dominant" branch.

Thing is: they had two branches.  They should be merged, but one should 
prevail: 'master'.

So if I have two branches, say "x" and "y", and I want to merge them, but 
really throw away the tree of "x", I would check out 'y', naturally.  Then 
'git merge -s ours x'.

If the result should become the state of 'x', too, I would then just 
'git push origin y:x'.

Maybe I am "Git-braindead" by now, so that you can make fun of me like I 
used to make fun of CVSers and SVNers...

Ciao,
Dscho
