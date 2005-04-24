From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Design of name-addressed data portion
Date: Sun, 24 Apr 2005 17:14:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241703060.30848-100000@iabervon.org>
References: <20050424205438.GN1507@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 23:09:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoLu-0007x3-2N
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVDXVOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVDXVOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:14:09 -0400
Received: from iabervon.org ([66.92.72.58]:58117 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262429AbVDXVOB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 17:14:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPoQZ-0003VF-00; Sun, 24 Apr 2005 17:14:07 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424205438.GN1507@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 24, 2005 at 08:17:23PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > I'd propose the following structure:
> > 
> >  objects/    the content-addressed repository portion
> >  references/ the name-addressed repository portion
> 
> references/ is just too long for my taste. ;-) What about just refs/ ?

Fine with me. I guess you can't just hit tab when writing a script. :)

> >    heads/    the heads that are being used out of this repository
> >      DEFAULT the head that people pulling this repository mean by default
> >      ...     other heads, by name, that fsck-cache should mark reachable
> >    tags/     the tags
> >      ...     files with the symbolic name of the tags, containing the hash
> >  info/       other per-repository information
> >    remotes   URLs of remote repositories
> >    complete  hashes that the repository contains all references from
> >    missing   hashes that the repository lacks but wants
> >    excluded  hashes that the repository doesn't want
> >  ...         other files are per .git directory, not shared on push/pull
> >  index       
> >  HEAD        symlink to the head that is the local default
> >  tracked     remote that this working directory tracks
> 
> I will probably throw the local stuff to local/.

That seems to encourage confusion with the local/remote repository
contrast. I think branch/ or fork/ would be more clear. Putting it in a
directory doesn't seem so important to me, since it won't be shared
anyway. (The reason I want info/ is so that you just symlink info/ to the
master info/, and you don't have to remember to make a link for each
file).

	-Daniel
*This .sig left intentionally blank*

