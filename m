From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git branch bug
Date: Sun, 6 May 2007 12:16:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705061141170.28708@iabervon.org>
References: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
 <Pine.LNX.4.64.0705051841200.4015@racer.site> <Pine.LNX.4.64.0705051253380.28708@iabervon.org>
 <7vabwih3bd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 18:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkjPR-0005tP-Na
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbXEFQQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbXEFQQ0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:16:26 -0400
Received: from iabervon.org ([66.92.72.58]:2354 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749AbXEFQQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 12:16:25 -0400
Received: (qmail 10438 invoked by uid 1000); 6 May 2007 16:16:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 May 2007 16:16:24 -0000
In-Reply-To: <7vabwih3bd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46343>

On Sat, 5 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This leaves open the question of how you make your initial commit in a 
> > branch that isn't master. I think the answer should be:
> >
> >  $ git checkout -b experimental
> >  warning: You appear to be on a branch yet to be born.
> >  warning: Forcing checkout of HEAD.
> >  fatal: just how do you expect me to merge 0 trees?
> >
> > Which should probably be:
> >
> >  $ git checkout -b experimental
> >  warning: You appear to be on a branch yet to be born.
> >  warning: Putting you on a new branch yet to be born.
> >
> > And leaving .git/HEAD pointing to refs/heads/experimental instead of 
> > refs/heads/master, with refs/heads/ still empty.
> 
> While I agree that is probably correct, it would not be useful
> in real-life that much.  When you do not even have 'master', I
> do not think there is much point of being able to create two
> useless, yet-to-be-born branches.

The point is that you may not want to have a branch named "master", but 
rather want your first branch to be named something else. Your project 
could be such that "master" would be a confusing term to use for a 
default branch. Currently, it's awkward to start a project that avoids 
that particular name, which is what it seemed to me that the original 
poster was trying to do.

I don't think it's useful to be able to switch to a new yet-to-be-born 
branch from any other state, but I do think it's useful to be able to 
choose what the first branch is.

	-Daniel
*This .sig left intentionally blank*
