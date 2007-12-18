From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 23:26:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182323400.23902@racer.site>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> 
 <20071218204623.GC2875@steel.home>  <200712182224.28152.jnareb@gmail.com> 
 <20071218222032.GH2875@steel.home>  <Pine.LNX.4.64.0712182239500.23902@racer.site>
 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:27:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lq1-0000cx-As
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbXLRX0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbXLRX0h
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:26:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:43761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753177AbXLRX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:26:37 -0500
Received: (qmail invoked by alias); 18 Dec 2007 23:26:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 19 Dec 2007 00:26:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MN+UDRl3M09Vjwzs6aiIFAU5clCR4Vx0QR1cGt3
	FVpbmaTnh74U8a
X-X-Sender: gene099@racer.site
In-Reply-To: <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68846>

Hi,

On Tue, 18 Dec 2007, Dana How wrote:

> On Dec 18, 2007 2:43 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 18 Dec 2007, Alex Riesen wrote:
> > > But the act of running "git-show <tree-ish>:<path>" does have a working
> > > directory relative to the project root.
> >
> > Not necessarily.  My primary use of "git show <tree-ish>:<path>" (yes, I
> > already use the dash-less form ;-) is in _bare_ repositories.
> >
> > And I still maintain that expecting <tree-ish>:<path> to take the current
> > relative path into account would be just like if you expected
> >
> >         C:\> cd WINDOWS
> >         C:\WINDOWS> dir D:system32
> >
> > to show you the contents of D:\WINDOWS\system32.
> >
> > Or another, less Windowsy example:
> >
> >         $ cd /usr/bin
> >         $ scp home:bash ./
> >
> > No, this does not copy home:/usr/bin/bash but home:$HOME/bash.
> 
> Both of your counterexamples use 2 disjoint directory trees:
> C: vs D:,  or trees on different machines.

Well, the first actually only uses 1 "disjoint" directory tree.  You did 
not address the concern of the bare repository.

> The cases we are talking about are all subtrees of the working tree. 
> There is a useful cwd suffix.

Not necessarily.  You can be in a subdirectory that was not even created 
in _any_ revision.  Or you can access a different branch with a different 
history.

It boils down to this: if you need relative paths _only_, you narrowed 
yourself very much in your use cases.

> Don't you think that
>   git <op> commit:./file.c
> could occasionally be more convenient than
>   git <op> commit:very/long/and/boring/path/equal/to/cwd/file.c
> ?

Actually, it depends on the <op>.  And guess what, for those operations 
that I would like to have that, it already works!  "grep", "diff", "log".

Ciao,
Dscho
