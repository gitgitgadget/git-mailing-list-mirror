From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Sun, 15 May 2005 16:23:08 +0200
Message-ID: <20050515142307.GF13024@pasky.ji.cz>
References: <200505151152.j4FBqoW01239@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, mercurial@selenic.com,
	mpm@selenic.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 16:23:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXK1e-0007PE-Rs
	for gcvg-git@gmane.org; Sun, 15 May 2005 16:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVEOOX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVEOOX3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 10:23:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22962 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261657AbVEOOXK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 10:23:10 -0400
Received: (qmail 29617 invoked by uid 2001); 15 May 2005 14:23:08 -0000
To: "Adam J. Richter" <adam@yggdrasil.com>
Content-Disposition: inline
In-Reply-To: <200505151152.j4FBqoW01239@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 01:52:50PM CEST, I got a letter
where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> On Sun, 15 May 2005 14:40:42 +0200, Petr Baudis wrote:
> >Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
> >where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> [...]
> >> 	I don't understand what was wrong with Jeff Garzik's previous
> >> suggestion of using http/1.1 pipelining to coalesce the round trips.
> >> If you're worried about queuing too many http/1.1 requests, the client
> >> could adopt a policy of not having more than a certain number of
> >> requests outstanding or perhaps even making a new http connection
> >> after a certain number of requests to avoid starving other clients
> >> when the number of clients doing one of these transfers exceeds the
> >> number of threads that the http server uses.
> 
> >The problem is that to fetch a revision tree, you have to
> 
> >	send request for commit A
> >	receive commit A
> >	look at commit A for list of its parents
> >	send request for the parents
> >	receive the parents
> >	look inside for list of its parents
> >	...
> 
> >(and same for the trees).
> 
> 	Don't you usually have a list of many files for which you
> want to retrieve this information?  I'd imagine that would usually
> suffice to fill the pipeline.

That might be true for the trees, but not for the commit lists. Most
commits have a single parent, except merges, which are however extremely
rare with more than two parents too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
