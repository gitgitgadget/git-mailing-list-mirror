From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Design of name-addressed data portion
Date: Sun, 24 Apr 2005 22:54:38 +0200
Message-ID: <20050424205438.GN1507@pasky.ji.cz>
References: <Pine.LNX.4.21.0504241336250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPo3R-00069Q-7A
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 22:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVDXUzD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 16:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDXUzD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 16:55:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65483 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262418AbVDXUyj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 16:54:39 -0400
Received: (qmail 11721 invoked by uid 2001); 24 Apr 2005 20:54:38 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504241336250.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 08:17:23PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> It would be useful to have a bit more structure to the repository, such
> that there are a fixed number of paths that hold all of the information
> about the state of the repository, while the rest of the directory has
> information that is particular to a working directory's state (e.g.,
> index).

Agreed.

> 
> 
> I'd propose the following structure:
> 
>  objects/    the content-addressed repository portion
>  references/ the name-addressed repository portion

references/ is just too long for my taste. ;-) What about just refs/ ?

>    heads/    the heads that are being used out of this repository
>      DEFAULT the head that people pulling this repository mean by default
>      ...     other heads, by name, that fsck-cache should mark reachable
>    tags/     the tags
>      ...     files with the symbolic name of the tags, containing the hash
>  info/       other per-repository information
>    remotes   URLs of remote repositories
>    complete  hashes that the repository contains all references from
>    missing   hashes that the repository lacks but wants
>    excluded  hashes that the repository doesn't want
>  ...         other files are per .git directory, not shared on push/pull
>  index       
>  HEAD        symlink to the head that is the local default
>  tracked     remote that this working directory tracks

I will probably throw the local stuff to local/.

I think I like this otherwise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
