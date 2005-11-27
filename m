From: Petr Baudis <pasky@suse.cz>
Subject: Re: Question about handling of heterogeneous repositories
Date: Sun, 27 Nov 2005 14:11:47 +0100
Message-ID: <20051127131147.GF22159@pasky.or.cz>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> <43837442.9060602@op5.se> <20051122232228.GB2916@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 14:12:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgMJc-0004xd-QQ
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 14:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVK0NLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 08:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVK0NLd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 08:11:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:8876 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751036AbVK0NLd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 08:11:33 -0500
Received: (qmail 29434 invoked by uid 2001); 27 Nov 2005 14:11:47 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051122232228.GB2916@steel.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12806>

Dear diary, on Wed, Nov 23, 2005 at 12:22:28AM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> Andreas Ericsson, Tue, Nov 22, 2005 20:40:50 +0100:
> > >it is sometimes the case that a project consists of parts which are
> > >unrelated to each other, and only thing in common between them is that
> > >they all are used in that particular project. For example a program
> > >uses some library and the developer(s) of that program would like to
> > >have the source of that library somewhere close. Well, for this simple
> > >example one could just use two repositories, laid close to each other
> > >in a directory, like project/lib and project/prog.
> > >Now, if I make the example a bit more complex and say, that the
> > >developers of the program are the developers in that project and
> > >change everything under project/ directory, including
> > >project/library/. They are also good people and ready to give the
> > >changes to the library upstream.
> > >
> > >How do they achieve that, without sending project/ and project/program/?
> > >
> > >For everyone who have an experience with ClearCase or Perforce (I'm
> > >sorry for mentioning it) it is what the "mappings" are often used for:
> > >a project is build together from different parts, which can be worked
> > >on separately.
> > >
> > >I'm trying to introduce git at work, but have to prepare myself for
> > >possible questions first, and this is one of them :)

This is something e.g. Cogito wants to support, but does not yet.
Patches welcome.

> > It would certainly be nicer to have git ignore directories that have the 
> > ".git" directory (so long as it's not the top of the repo, that is), but 
> > I haven't had the energy to fix that when there's already a solution 
> > that's simple enough and quite adequate.
> 
> BTW, will something like "*/.git/*" in info/exclude work? IOW, does *
> match a "/"?

Nope, but try just '.git' - in case it is not a pathname but just a
filename (or dirname, for that matter), it will recursively apply to all
the subtrees.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
