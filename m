From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT
 vs Other: Need argument)
Date: Wed, 25 Apr 2007 18:39:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704251743300.28708@iabervon.org>
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
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0704251345220.28708@iabervon.org> <873b2o6vvk.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgq9H-0007hQ-D0
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423389AbXDYWjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423390AbXDYWjk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:39:40 -0400
Received: from iabervon.org ([66.92.72.58]:4763 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423389AbXDYWjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 18:39:39 -0400
Received: (qmail 25725 invoked by uid 1000); 25 Apr 2007 22:39:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2007 22:39:37 -0000
In-Reply-To: <873b2o6vvk.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45588>

On Wed, 25 Apr 2007, Carl Worth wrote:

> On Wed, 25 Apr 2007 15:44:11 -0400 (EDT), Daniel Barkalow wrote:
> 
> > Here, you probably need to specify what you want the new branch to be,
> > because it will often be the case that the remote branch will be "master"
> > in a repository with a long unrecognizable URL, and you need to be able to
> > switch to and away from the branch in some sane way. On the other hand,
> > the user will presumably never care too deeply about the remote, aside
> > from that git remembers stuff appropriately. I say, use the hash of the
> > URL as the name of the remote, and provide some shorthand for the tracking
> > branch that would be merged by default into the current head, and you're
> > set. I.e.:
> >
> > git track new-name URL [branch]
> 
> OK, that still allows for pasting the URL and branch, but the user has
> to know not only "git track" but also that she must invent a local for
> the branch and insert that into the command as well. And it's hard for
> me to help the user on this point (at least in a cut-and-pasteable
> way), since the whole point of that argument is to create an entry in
> a private namespace that I don't know anything about.

Well, it's not only a private namespace, it's a namespace of stuff that 
should be meaningful to the user. Sure, there's a certain extent to which 
what's meaningful to the publisher is likely to be meaningful to the user, 
but I've used "subproject" to refer to a "submodule2" remote branch, 
because that's what I was naming the feature in my head, and I wouldn't 
have found the 2 intuitive in general (it was the second attempt at an 
implementation). It's fundamentally a local alias for a global name.

On the other hand, it might be good if the publisher could give 
instructions with an option that prompts the user with a sensible default, 
given the arguments and the state of the repository.

> > With the most common case for two tracking branches being master from two
> > repositories, such that upstream branch names are most often useless for
> > distinguishing anything.
> 
> Ah, that's an interesting point.
> 
> It's interesting because it's obviously the case for some projects,
> but it's also not the case for some, (like the cairo project that I
> care about). Maybe we're still overly accustomed to our "central"
> mentality, but we don't really have a lot of interesting "master"
> branches in our personal repositories. Instead, the central repository
> has "master" and one branch for each stable maintenance series, then
> each developer's personal repository has a collection of topic
> branches for stuff that is cooking.

I think there's likely to be a reasonably large variation in what 
repositories exist and what branches they have. People could easily have a 
repository per topic, with a branch per stable series (with experimental 
work being potentially queued for a relatively far future series). There 
could be shared repositories for features that multiple people work on, 
with per-person branches. People do all sorts of things, and even within a 
project, they don't all have to be the same, so long as the "URL branch" 
format works for everybody who has to get a branch. But that also means 
that it's hard to find a reliable meaningful sub-part of that format.

	-Daniel
*This .sig left intentionally blank*
