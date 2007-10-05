From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2007 unfinished summary (long)
Date: Thu, 4 Oct 2007 21:27:27 -0400
Message-ID: <20071005012726.GR2137@spearce.org>
References: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com> <Pine.LNX.4.64.0710041712120.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 03:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idbyf-0003Pt-8T
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 03:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759530AbXJEB1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 21:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759077AbXJEB1c
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 21:27:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38875 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758700AbXJEB1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 21:27:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IdbyI-0005C3-2o; Thu, 04 Oct 2007 21:27:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E61220FBAE; Thu,  4 Oct 2007 21:27:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710041712120.4174@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60025>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 4 Oct 2007, Jakub Narebski wrote:
> > 26. Which porcelains do you use?
> > 
> > Multiple answers (one can use more than one porcelain).
> > 
> >   Answer (multiple choice)       | Count
...
> >   other                          | 14
...
> > Those 14 "other" answers make me wish to have provided "if other,
> > what it was?" (sub)question; actually not only for this question.
> 
> git-gui, of course.  I consider it porcelain, because it uses core-git as 
> backend.

I tried to get git-gui into this list as a choice as I really do
consider it porcelain but Jakub thought it wasn't and wanted to
have a specific category for GUIs.  Whatever.  Its probably all
git-gui and qgit users that picked other here.  Probably in about
the same ratio too, so 8 git-gui's and 6 qgit's.

For the most part git-gui tries to only ever invoke plumbing.  I
break that rule in only three places:

  - git-merge: I'm lazy and didn't have time yet to rewrite this
               properly using Tcl.  I already do about half of the
               work anyway (e.g. merge base testing, fast-forward
               detection, message formatting).

  - git-fetch: Now that this is in C I'm going to call it plumbing
               even if nobody else does.  Especially for say HTTP
               as git-fetch process does all of the HTTP requests
               directly.  I won't reimplement it in Tcl, it would
               be slower and suck more.  So git-gui won't be calling
               git-fetch-pack anytime soon.

  - git push: Same as the above reason for git-fetch.

IMHO, porcelain is anything that only invokes plumbing.  Seats
however can sit above porcelain to make the position slightly
more comfortable.  :-)

> In the same vein, I should consider gitk porcelain now, since it has 
> rebase capabilities.  I will not, and I am not very happy that this viewer 
> got a non-view-only capability, instead of git-gui, where that feature 
> should have belonged (as suggested by at least one answer to a later 
> question in the survey -- not by me).

I agree.  I actually never use the modification features of gitk.
They are so hidden that most users don't even know they are there.
Of course that's just as hidden as the hunk selection in git-gui
is so I shouldn't be complaining.

I'm seriously looking at implementing those modification features
into git-gui and will probably start work on some of that during
the trip.  I got plenty of time in a sealed tube at 30,000 feet
to kill.  More time than I got battery packs for the laptop.  :-\

I think the first thing to implement is cherry-pick and revert as
those are easy and co-workers have been asking about them.  That way
you can then rebase using cherry-pick and the Mark I wetware loop.
Then we need a cool graph thing that you can drag the nodes around
on to create a visual `rebase -i`.

-- 
Shawn.
