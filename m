From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 14:37:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031434360.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031243330.14781@racer.site> <Pine.LNX.4.64.0708031347160.14781@racer.site>
 <46B32981.9040904@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 15:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGxLx-000709-CL
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759042AbXHCNiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 09:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758647AbXHCNiC
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 09:38:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:42058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758313AbXHCNiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 09:38:00 -0400
Received: (qmail invoked by alias); 03 Aug 2007 13:37:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 03 Aug 2007 15:37:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ac/cVQkgaBwa0eIgEAWilpTznNhaXQY2sn/NFD0
	rD5ZvKSircw6Td
X-X-Sender: gene099@racer.site
In-Reply-To: <46B32981.9040904@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54726>

Hi,

On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:

> > > Completely forgot: we might want to do something like this at the end of
> > > /etc/profile:
> > > 
> > > 	test ! -d /git || {
> > > 		mv /git $HOME/ &&
> > > 		cd $HOME/git &&
> > > 		make install &&
> > > 		git config remote.origin.url \
> > > 			git://repo.or.cz/git/mingw.git
> > > 		git config remote.origin.fetch \
> > > 			'+refs/heads/*:refs/remotes/origin/*'
> > > 		git config remote.mob.url \
> > > 			repo.or.cz:/srv/git/git/mingw.git
> > > 		git config remote.mob.fetch \
> > > 			+refs/remote/mob:refs/remotes/origin/mob
> > > 		git config remote.mob.push \
> > > 			master:mob
> > > 		git fetch
> > > 		git reset 51785010a4d3e7f6c3
> > > 	}
> > > 
> > > Please test that, and include it if it works.
> 
> Hmmm, I have trouble 'parsing' this.
> You meant
>     test ! -d $HOME/git ||
> right?
> 
> But, given that he removed the initial git sources, the script won't work. He
> left the git executables to be able to check a new Git out, if I understand
> correctly.

I ended up doing it differently.  I test for $HOME/bin/git.exe, and if it 
does not exist, the whole compiling && installing && fetching is done.

Actually, I found out by debugging why it did not work as intended that 
commit 5178501 was a commit _I_ made, from experimental patches Hannes 
sent to the list.

I updated it to origin/devel + patches.

Hopefully these patches will be cleaned up, and submitted to Hannes (hint, 
hint).

Ciao,
Dscho
