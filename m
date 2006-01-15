From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Starting a new project remotely
Date: Sun, 15 Jan 2006 15:01:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601151437240.25300@iabervon.org>
References: <Pine.LNX.4.64.0601151323320.25300@iabervon.org>
 <7vd5it47lr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 21:00:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyE35-0004Ux-BI
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 21:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWAOUAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWAOUAK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 15:00:10 -0500
Received: from iabervon.org ([66.92.72.58]:54795 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932127AbWAOUAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 15:00:09 -0500
Received: (qmail 3001 invoked by uid 1000); 15 Jan 2006 15:01:58 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2006 15:01:58 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5it47lr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14705>

On Sun, 15 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Is there something currently that acts like git-clone, except that it sets 
> > up automatic connections in the opposite direction? That is, you run it in 
> > a repository with no origin, and it pushes the data to the specified 
> > location (which probably needs to be set up already as an empty 
> > repository) and sets the local side's origin remote to the location given.
> 
> The "git push" command allows you to push into an empty or even
> unrelated destination, but I do think there no wrapper that
> creates remotes/ file.  BTW, calling that "origin" is probably
> confusing.  In the scenario you outlined, your local side is the
> source and the remote is the sink.

My general pattern is that I have an "origin" repository, which is public 
and central. I do work in various other repositories, and push the results 
to origin when I finish them. I create these with "git clone", so the 
central point is called "origin" in each clone.

The odd case is when I start out; I have a repository with the initial 
commit, and "origin" is blank. The desired result is that the central 
location gets this commit, and the repository I'm starting from becomes 
identical to any clone of the central location.

I don't create the initial commit in the central location because there's 
no working tree there, and it's a pain to prepare a commit without one. I 
suppose the alternative is to support cloning a blank repository, so I 
could prepare the initial commit just like any later one.

Incidentally, I think it would be useful to have a script that creates a 
remotes/ file given a command line like push or pull. Then you could use 
"git pull" with a long command line until you were happy with the 
behavior, and then make a shortcut out of it. It'd also be nice to have 
the command list the remotes for you as well. If anyone's in the mood for 
scripting and wants something to work on...

	-Daniel
*This .sig left intentionally blank*
