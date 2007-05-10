From: Petr Baudis <pasky@suse.cz>
Subject: Using StGIT for tweaking already-committed stuff
Date: Thu, 10 May 2007 22:02:53 +0200
Message-ID: <20070510200253.GD4489@pasky.or.cz>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu May 10 22:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEqq-0003Vv-FG
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbXEJUC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756231AbXEJUC4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:02:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59290 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbXEJUCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:02:55 -0400
Received: (qmail 22036 invoked by uid 2001); 10 May 2007 22:02:53 +0200
Content-Disposition: inline
In-Reply-To: <87tzuk31fu.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46895>

On Thu, May 10, 2007 at 09:48:05PM CEST, Carl Worth wrote:
> On Thu, 10 May 2007 21:21:06 +0200, Petr Baudis wrote:
> > 	stg uncommit -n N
> > 	stg pop -n N-1
> > 	..hack..
> > 	stg refresh
> > 	stg push -a
> >
> > It seems to be a bit shorter than the sequence you've presented above,
> > and overally working with volatile commits using StGIT feels much more
> > natural to me - and I haven't even ever used quilt seriously! (I have
> > special antipathy to the git reset UI, too.)
> 
> The -n option is something I hadn't noticed, and that helps, (except
> that what I've got to start with is a git revision name, not a
> number).

Hmm, yes, I've been thinking myself that it would be quite nice if I
could just tell uncommit git revname right away.

> But there are still some places where an experienced git user runs
> into some awkward situations trying to use stg. For example, "stg
> refresh" is basically always doing the equivalent of "commit -a" so
> there's annoyingly no way to refresh only some of the modified state
> into the commit.

Yes, I fear that StGIT hides the index in a similar way that Cogito
does. It seems like user index usage is undergoing kind of renaissance
these days in Git community (at least it seems to me this way, maybe
it's always been this way), it would probably make sense to allow making
use of index in StGIT as well.

> Also, if I want to edit a commit message while under the influence of
> stg, how do I do that? If I do "git commit --amend" will I seriously
> confuse stg, (I'm guessing I would, but I don't know).

I have no idea, but there's stg refresh -e.

> It's that kind of uncertainty that makes me uncomfortable to mix git
> and stg. And personally, I couldn't get excited about using it alone,
> (for example, in addition to the commit message with headline, stg
> makes me invent yet _another_ name for every commit---yuck). Not to
> mention I'm already quite comfortable with git alone, and all the
> flexibility it provides.

I wouldn't normally use it for projects I have commit access to myself,
but for maintaining own patches for an "external" project, I just find
it much more comfortable than using git. But then again, if this part of
git UI improved as much as some of the other parts in the last half a
year...

And yes, it would be cool if stg new could guess patch name from the
subject line in a similar manner that stg uncommit does.

> Plus, all the stuff that stg provides to allow it to be used
> standalone ends up just being noise to the git user that just wants to
> do some stack-based manipulation of an unpublished branch, for
> example.

I'm sorry, I couldn't parse this. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
