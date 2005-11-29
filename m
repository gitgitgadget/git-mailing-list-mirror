From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about handling of heterogeneous repositories
Date: Tue, 29 Nov 2005 21:47:29 +0100
Message-ID: <20051129204729.GA3033@steel.home>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> <43837442.9060602@op5.se> <20051122232228.GB2916@steel.home> <20051127131147.GF22159@pasky.or.cz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 21:51:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhCOz-0006UB-Kw
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 21:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVK2Usb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVK2Usb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 15:48:31 -0500
Received: from devrace.com ([198.63.210.113]:58125 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932396AbVK2Usa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 15:48:30 -0500
Received: from tigra.home (p54A0CEB2.dip.t-dialin.net [84.160.206.178])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jATKlbxk020907;
	Tue, 29 Nov 2005 14:47:39 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EhCNz-0002jl-00; Tue, 29 Nov 2005 21:47:35 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EhCNu-0007zr-OT; Tue, 29 Nov 2005 21:47:31 +0100
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051127131147.GF22159@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12954>

Petr Baudis, Sun, Nov 27, 2005 14:11:47 +0100:
> > > >For everyone who have an experience with ClearCase or Perforce (I'm
> > > >sorry for mentioning it) it is what the "mappings" are often used for:
> > > >a project is build together from different parts, which can be worked
> > > >on separately.
> > > >
> > > >I'm trying to introduce git at work, but have to prepare myself for
> > > >possible questions first, and this is one of them :)
> 
> This is something e.g. Cogito wants to support, but does not yet.
> Patches welcome.

I wouldn't know what to patch, having no clear picture of the approach
myself, and especially when I don't feel safe using the solution. For
example, how do you go about moving/renaming files between subrepos?
Rename detection will not work, which will be unexpected...

BTW, how does git-mv behave for out-of-tree renaming? How about
inter-repo renaming (remove+add)?

> > > It would certainly be nicer to have git ignore directories that have the 
> > > ".git" directory (so long as it's not the top of the repo, that is), but 
> > > I haven't had the energy to fix that when there's already a solution 
> > > that's simple enough and quite adequate.
> > 
> > BTW, will something like "*/.git/*" in info/exclude work? IOW, does *
> > match a "/"?
> 
> Nope, but try just '.git' - in case it is not a pathname but just a
> filename (or dirname, for that matter), it will recursively apply to all
> the subtrees.

well, it ignored the ".git"s in the subdirs, not _the_ subdirectories.
I think that can be helped by putting the directories themselves into
.gitignore lists.
