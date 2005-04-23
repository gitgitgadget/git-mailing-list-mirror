From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Hash collision count
Date: Sun, 24 Apr 2005 01:46:37 +0200
Message-ID: <20050423234637.GS13222@pasky.ji.cz>
References: <426AAFC3.800@pobox.com> <1114297231.10264.12.camel@maze.mythral.org> <426AD835.5070404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUG2-0005G2-Uw
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVDWXqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVDWXqk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:46:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38072 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262183AbVDWXqi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:46:38 -0400
Received: (qmail 2756 invoked by uid 2001); 23 Apr 2005 23:46:37 -0000
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <426AD835.5070404@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 01:20:21AM CEST, I got a letter
where Jeff Garzik <jgarzik@pobox.com> told me that...
> Second, in your scenario, it's highly unlikely you would get 4 billion 
> sha1 hash collisions, even if you had the disk space to store such a git 
> database.

It's highly unlikely you would get a _single_ collision.

> First, the hash is NOT unique.
> 
> Second, you lose data if you pretend it is unique.  I don't like losing 
> data.

*sigh*

We've been through this before, haven't we?

> Third, a data check only occurs in the highly unlikely case that a hash 
> already exists -- a collision.  Rather than "trillions of times", more 
> like "one in a trillion chance."

No, a collision is pretty common thing, actually. It's the main power of
git, actually - when you do read-tree, modify it and do write-tree
(typically when doing commit), everything you didn't modify (99% of
stuff, most likely) is basically a collision - but it's ok since it
just stays the same.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
