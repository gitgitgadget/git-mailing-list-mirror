From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 17:07:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509231648310.23242@iabervon.org>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz>
 <34462.10.10.10.28.1127417134.squirrel@linux1> <20050923091012.GA10255@pasky.or.cz>
 <7vslvwcelj.fsf@assigned-by-dhcp.cox.net> <20050923095742.GC10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 23:04:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIuhR-0007Y2-9S
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVIWVDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 17:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIWVDO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 17:03:14 -0400
Received: from iabervon.org ([66.92.72.58]:23315 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751293AbVIWVDO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 17:03:14 -0400
Received: (qmail 27101 invoked by uid 1000); 23 Sep 2005 17:07:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2005 17:07:37 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050923095742.GC10255@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9205>

On Fri, 23 Sep 2005, Petr Baudis wrote:

> Dear diary, on Fri, Sep 23, 2005 at 11:34:16AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > 	* cg-fetch can do with symlinked object database
> > 
> > Do you mean ".git/object" in the repository you are fetching
> > into is a symlink to somewhere, or something else?
> 
> Yes, exactly that. You get it by doing cg-clone -l /local/path.  O(1)
> cloning, but it has its downsides and dangers which I tried to describe
> in the cg-clone documentation.

That's actually how I use git, and it works for me. (To be precise, I 
have:

 ~/git/project.git/{objects,refs,info}

and I have

 ~/working/git/current-work/, with .git/{objects,refs,info} symlinks to 
                              the above.

git fetch works fine, with the exception that remotes aren't shared 
between working trees.

> > > 	* cg-fetch won't do useless fetches when we are already
> > > 	  up-to-date
> > 
> > Care to explain?  Perhaps you are talking about rsync transport
> > (in which case I would not be surprised)?
> 
> Just that if the reference pointer did not change, you don't try to pull
> any objects. Speeds things up somewhat, and now it should always work
> (well, cg-fetch has -f which makes it always try objects as well, in
> case something went wrong anyway).

I assume you mean with rsync? The current git-http-fetch won't try any 
objects if the ref didn't change (or, for that matter, if we have a 
different ref that's the same), and the old one would make a local check 
for the objects before trying to downlaod anything.

	-Daniel
*This .sig left intentionally blank*
