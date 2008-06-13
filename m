From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 05:10:40 -0400
Message-ID: <20080613091040.GB4474@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <bd6139dc0806130156o747fc128hbe28440ed4d228d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jun 13 11:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75Jp-0006au-QR
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbYFMJKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbYFMJKn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:10:43 -0400
Received: from peff.net ([208.65.91.99]:2550 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742AbYFMJKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:10:42 -0400
Received: (qmail 8840 invoked by uid 111); 13 Jun 2008 09:10:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 05:10:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 05:10:40 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0806130156o747fc128hbe28440ed4d228d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84855>

On Fri, Jun 13, 2008 at 10:56:56AM +0200, Sverre Rabbelier wrote:

> > So of course my first question is "then why didn't you use a branch?" :)
> 
> Because nobody / not everybody has perfect foresight, sometimes you
> don't know in advance that what you thought was going to be a
> temporary stash will turn into a long lived stash. What you are saying
> is that really you should always create a branch, just in case your
> temporary stash proved to be more long-lived than thought?

Well, two things here:

  1. I was being somewhat tounge in cheek with that comment. If you read
     the rest of the email, I was trying to figure out reasons why
     people are using "git stash" for long-term storage, to see if we
     could improve the branch interface or find a middle ground between
     temporary stashes and branches.

  2. You don't need perfect foresight. Sometime in the thirty days (but
     probably about 5 minutes later) you realize "oh, this is some
     stashed work that I'm not going to deal with for a while" and you
     promote it to a topic branch.

     But then, I have good reason to want works-in-progress to become
     topic branches: I can then push them to a location which is backed
     up, and from which I can retrieve them if I want to access them
     from a different machine. Not everybody uses the same workflow.
     If you don't see any other benefits to topic branches, then the
     promotion is just a pain.

-Peff
