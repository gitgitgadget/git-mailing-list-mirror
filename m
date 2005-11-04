From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Now What?
Date: Fri, 4 Nov 2005 12:06:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511041158350.25300@iabervon.org>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103083840.GA28300@ebar091.ebar.dtu.dk>
 <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
 <7vll05bd1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 18:08:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY51b-0005Ai-8Y
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 18:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKDRGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKDRGo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 12:06:44 -0500
Received: from iabervon.org ([66.92.72.58]:46347 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750727AbVKDRGn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 12:06:43 -0500
Received: (qmail 9331 invoked by uid 1000); 4 Nov 2005 12:06:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2005 12:06:28 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll05bd1w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11145>

On Thu, 3 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 3 Nov 2005, Junio C Hamano wrote:
> >
> >> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> >> 
> >> > ~/git/git-core]cat .git/remotes/origin
> >> > URL: git://git.kernel.org/pub/scm/git/git.git
> >> > Pull: master:origin
> >> >
> >> > ~/git/git-core]git-checkout maint
> >> > ~/git/git-core]git pull
> >> 
> >> You are merging my master into your "maint", probably a copy of
> >> my (previous) maint.
> >
> > I think the situation is that he really wanted to update master, but 
> > forgot that he was on the maint branch.
> 
> I wonder if it would make sense to have something in .git/remotes/
> file that says "run merge only when I am on frotz branch", like
> this:
> 
>         ~/git/git-core]cat .git/remotes/origin
>         URL: git://git.kernel.org/pub/scm/git/git.git
>         Pull: master:origin
> 	Fetch-Only-Unless: master
> 
>         ~/git/git-core]git-checkout maint
> 	~/git/git-core]git pull
> 	warning: not merging because you are not on 'master' branch.
> 
> This would make the above "git pull" behave identical to "git
> fetch", and the user can then do:
> 
> 	$ git checkout master
>         $ git pull . origin
> 
> Useful?  Useless?

People probably want to merge master into their personal work branches, 
though; I think it would be better to have it list branches into which it 
shouldn't be merged. I think the pair of "maint" and "master" are special, 
in that they get different fixes for the same problems, and so they'll 
merge badly or to a wrong result.

	-Daniel
*This .sig left intentionally blank*
