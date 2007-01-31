From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 11:25:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311102300.20138@iabervon.org>
References: <87odognuhl.wl%cworth@cworth.org> <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
 <Pine.LNX.4.64.0701302052230.3021@xanadu.home> <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
 <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:30:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIHR-0002fB-IU
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbXAaQZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbXAaQZu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:25:50 -0500
Received: from iabervon.org ([66.92.72.58]:2869 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030232AbXAaQZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:25:49 -0500
Received: (qmail 20882 invoked by uid 1000); 31 Jan 2007 11:25:46 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2007 11:25:46 -0500
In-Reply-To: <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38270>

On Wed, 31 Jan 2007, Nicolas Pitre wrote:

> On Wed, 31 Jan 2007, Daniel Barkalow wrote:
> 
> > On Tue, 30 Jan 2007, Nicolas Pitre wrote:
> > 
> > > On Tue, 30 Jan 2007, Daniel Barkalow wrote:
> > > 
> > > >   warning: you are now browsing the history without a local branch. You 
> > > >   will not be able to commit changes unless you create a new local branch 
> > > >   with "git checkout -b <new_branch_name>".
> > > 
> > > This isn't true.  You can commit on top of a detached head.  In fact you 
> > > can do almost anything.
> > 
> > "Commits you make will not be attached to permanent state unless you 
> > create a local branch"? I'm not sure how the feature turned out to work, 
> > but I know that (a) you're fine if you don't make any commits and (b) the 
> > behavior is more like what happens with anonymous checkouts of other 
> > people's repositories in non-distributed SCMs, so people will tend to
> > underestimate what they can do with this, rather than overestimating it 
> > and getting into trouble.
> > 
> > I suppose it's reasonable to warn at commit time, if we ended up going 
> > with allowing commits like normal.
> 
> I disagree.
> 
> It is not the commit which is dangerous when the head is detached.  It 
> is the checkout of another branch.  And this case is covered already 
> such that the checkout is refused unless you actually create a branch 
> for your detached head or you give -f to checkout to override the 
> protection.
> 
> Giving a warning at commit time is not the place where the user has to 
> be aware of the issue since it is indeed not the place where there is 
> any issue to worry about.

At commit time, the user is reasonably likely to be doing something 
unintended (at least, it's more likely that the user is doing something 
unintended by committing with a detatched head than that the user is doing 
something unintended by detatching the head). Certainly the only time 
there's any danger of losing work is when the head is detatched and a 
commit has been made since it was set, because otherwise there's either no 
work to lose, or no commits could be becoming unreachable.

I suspect that there will be people from other SCMs who will assume 
they're back on a local branch if the system lets them commit, because 
they would be prohibited from committing on top of an anonymous checkout 
or a historical commit. Of course, they can cherry-pick the misplaced 
commit, so it's not a big deal, but I think it's where a naive user would 
be getting into a state they don't understand.

	-Daniel
*This .sig left intentionally blank*
