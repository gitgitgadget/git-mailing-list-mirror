From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 21:31:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704232039300.28708@iabervon.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9sb-0007kS-8E
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 03:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXDXBb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 21:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbXDXBb1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 21:31:27 -0400
Received: from iabervon.org ([66.92.72.58]:4153 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbXDXBb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 21:31:26 -0400
Received: (qmail 13308 invoked by uid 1000); 24 Apr 2007 01:31:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2007 01:31:25 -0000
In-Reply-To: <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45401>

On Mon, 23 Apr 2007, Linus Torvalds wrote:

> On Mon, 23 Apr 2007, Carl Worth wrote:
> >
> > And with the recent talk about phasing cogito out and just merging its 
> > functionality into git itself, why not just use the cogito syntax for 
> > this:
> > 
> > 	git clone <url>#<branch>
> 
> That's a fundamentally weaker operation than the current "git clone", so I 
> really don't think it's a good idea. The syntax also absolutely sucks, 
> it's so horribly non-unixy.
> 
> I'd personally be ok with a
> 
> 	git clone --default=<branch> <url>
> 
> to create something where "master" defaults to some other remote branch, 
> but that just addresses the syntax. And quite frankly, I don't think we 
> *need* to. We shoud just tell people how _easy_ it is to track some other 
> branch now.

I've converted all my coworkers to git recently, and it was helpful to be 
able to go two weeks without explaining branches, due to the fact that our 
repositories only have one branch each (at least that people care about). 
It was also nice that, when one of them did learn about branches, he had 
the two weeks of experience with the absolute basics. I think that a first 
time user should be able to get, from the clone command:

[remote "origin"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/<something>

if the first-time user's first repository for learning has the interesting 
stuff in a non-default branch. Now, a second-time user can learn about 
branches, but I think that branches are confusing and scary if you don't 
already have a bit of experience with the operations that affect a branch.

Obviously, if you want to track two branches in one repository, you need 
to know how to *have* additional local branches, but you can put off 
learning that until you recognize the need for it, if there's any easy way 
to get your initial branch to track the remote branch you're interested 
in.

Someone can get work done with clone, add, commit -a, pull, and push (or 
format-patch). Two commands and an additional fundamental concept is a lot 
of overhead at that stage.

For that matter, I sometimes want a repository where master tracks a 
branch that isn't default for other people and "mainline" tracks the 
upstream master, which requires a small amount of config file editing, and 
can't be made to just happen.

	-Daniel
*This .sig left intentionally blank*
