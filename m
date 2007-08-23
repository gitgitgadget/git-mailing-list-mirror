From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 12:35:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231226110.20400@racer.site>
References: <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se>
 <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
 <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz>
 <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
 <Pine.LNX.4.64.0708231006220.20400@racer.site> <20070823102036.GG7267@thunk.org>
 <Pine.LNX.4.64.0708231122450.20400@racer.site> <20070823112413.GJ7267@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Tweed <david.tweed@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 13:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOAzE-0006WQ-2M
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 13:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335AbXHWLgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 07:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbXHWLgP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 07:36:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:49846 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757178AbXHWLgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 07:36:15 -0400
Received: (qmail invoked by alias); 23 Aug 2007 11:36:13 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 23 Aug 2007 13:36:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19buDI8sDhbWBC4iCP/lLZP7Ag671RFB1KzbbRPMg
	nHJ7dPW+tP+Glb
X-X-Sender: gene099@racer.site
In-Reply-To: <20070823112413.GJ7267@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56497>

Hi,

On Thu, 23 Aug 2007, Theodore Tso wrote:

> On Thu, Aug 23, 2007 at 11:31:56AM +0100, Johannes Schindelin wrote:
>
> > And that is _exactly_ where I fail to see benefits from.  You only get 
> > the full power of C by using C.  You only get the full power of all 
> > open source C programmers by using C.  And you only get the full 
> > flexibility, speed, name-your-own-pet-peeve using C.
> 
> Sure, but not all porcelein commands need the full power of C.  Take 
> "git-gc" for example.  It was a *very* short shell script before it was 
> rewritten to use C.

That is right.  It was short.

> > I have seen boxes where the administrators locked down everything.  
> > And Cygwin _does_ need to write the registry, and there is _no_ easy 
> > way to have two independent Cygwin installs on the same machine.  
> > This is where MinGW/MSys really shines.
> 
> So are you claiming that MingGW/MSys is so good that it has a perl/bash 
> that is fully Linux compatible, so that we don't need to convert our 
> various internal commands that are implemented in shell to C?  I didn't 
> think that was a commonly held assessment...

I did not even come close to saying that.

MinGW/MSys has the advantage over Cygwin that you can have multiple 
installations.  With different settings, in different places.

However, since we are on Windows we have plenty of problems.  Think 
fork().  Think "C:/srv" _not_ meaning a protocol.  Think non-Git programs 
that have a non-POSIX idea of path names, or of passing a command line 
(including quoting).

One problem we face ATM is that MSys apparently cannot be taught _not_ to 
mangle something as "repo.or.cz:/srv/git/something.git" into 
"repo.or.cz;C:\msysGit\srv/git/something.git".  If we had no scripts, this 
would be a non-issue.  Since no MSys would be involved.

Anyway, I'd much rather use my time hacking than reading monster threads 
with more LOC than I will ever write in my life.  And no, that "C" does 
not mean "code".

Ciao,
Dscho
