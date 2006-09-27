From: Jeff King <peff@peff.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 11:28:47 -0400
Message-ID: <20060927152847.GA2807@coredump.intra.peff.net>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <7vodt2nmft.fsf@assigned-by-dhcp.cox.net> <451A398C.3060800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 17:29:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSbLB-00073D-9S
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 17:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWI0P2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWI0P2u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 11:28:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:60334 "HELO
	peff.net") by vger.kernel.org with SMTP id S964931AbWI0P2u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 11:28:50 -0400
Received: (qmail 14695 invoked from network); 27 Sep 2006 11:28:47 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Sep 2006 11:28:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2006 11:28:47 -0400
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <451A398C.3060800@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27910>

On Wed, Sep 27, 2006 at 10:42:52AM +0200, Andreas Ericsson wrote:

> >>It's true I don't know much about git, what is the difference
> >>between a changeset and a snapshot?  Are you saying timestamps
> >
> >I do not know what Jeff meant by snapshot vs changeset, so I
> >would not comment on this part.
>
> Me neither, but I've seen this distinction before on the mailing-list.
> 
> To my mind, a changeset is the patch that brings some form of data from 
> one state (snapshot) to another. In this respect, git is certainly both 
> snapshot- and changeset-based.

I was talking specifically about the core data structure of git. The
commit object doesn't say "I'm based on commit X, and the deltas are Y."
It says "Here are the complete contents of the tree at this point, and
the previous complete contents were X."

Of course, git often shows changesets (patches, git-whatchanged, etc)
because that's what's useful to users. But the context of the discussion
was fetching commits to a repository. In that case it's important to
note that you're just grabbing the new state (albeit optimizing the
process by skipping things you have) and not "re-committing" changesets
(which is what the OP seemed to think was happening).

-Peff
