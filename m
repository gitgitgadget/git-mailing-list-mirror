From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 13:31:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511101317500.25300@iabervon.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net> <20051110180311.GR30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 19:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHCn-0003Dr-0T
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKJSbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKJSbV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:31:21 -0500
Received: from iabervon.org ([66.92.72.58]:36621 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751168AbVKJSbU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 13:31:20 -0500
Received: (qmail 3703 invoked by uid 1000); 10 Nov 2005 13:31:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Nov 2005 13:31:16 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110180311.GR30496@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11500>

On Thu, 10 Nov 2005, Petr Baudis wrote:

> Dear diary, on Thu, Nov 10, 2005 at 06:44:43PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> > > May I *STRONGLY* urge you to name that something different. 
> > > "lost+found" is a name with special properties in Unix; for example, 
> > > many backup solutions will ignore a directory with that name.
> > 
> > Yeah, the original proposal (in TODO list) explicitly stated why
> > I chose lost-found instead of lost+found back then, and somebody
> > on the list (could have been Pasky but I may be mistaken) said
> > not to worry.
> 
> It was the Large Angry SCM. I share your concern.
> 
> > In any case, if we go the route Daniel suggests, we would not be
> > storing anything on the filesystem ourselves so this would be a
> > non-issue.
> 
> I like Daniel's route as well, for the separate command. But it would be
> nice to also have a way to tell git-fsck-cache to save the lost+found
> refs as it goes, much like the filesystem fsck. So if it reports some
> unreachable refs, you will not need to tell it to do the same job
> _another_ time to find out the refs and pass them to gitk. Then again,
> if we do this, the utility of a separate command will be questionable.

Maybe git-fsck-objects should have an option to make it note dangling 
objects of certain types, and then count these as reachable? (That is, you 
want the head of an unreachable chain listed for recovery, but not other 
things reachable from it; you also may want the list of blobs and trees 
not reachable either from a ref or from something listed for recovery, but 
not omitting a blob reachable only from an unreachable tree)

	-Daniel
*This .sig left intentionally blank*
