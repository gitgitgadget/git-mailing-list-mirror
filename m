From: tom sgouros <tomfool@as220.org>
Subject: Re: mysterious error message
Date: Sun, 28 Sep 2008 11:18:35 -0400
Message-ID: <31976.1222615115@as220.org>
References: <20593.1222378418@as220.org> <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de> <30988.1222439568@as220.org> <20080926143726.GZ3669@spearce.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 17:19:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjy3r-00029G-EV
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 17:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYI1PSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 11:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbYI1PSl
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 11:18:41 -0400
Received: from as220.org ([198.7.230.15]:42771 "EHLO ironzilla.as220.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbYI1PSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 11:18:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id 4427EAAB09;
	Sun, 28 Sep 2008 11:18:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at as220.org
Received: from ironzilla.as220.org ([127.0.0.1])
	by localhost (as220.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RkqPxWrJlYe7; Sun, 28 Sep 2008 11:18:35 -0400 (EDT)
Received: from as220.org (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id 295DFAAB02;
	Sun, 28 Sep 2008 11:18:35 -0400 (EDT)
In-reply-to: <20080926143726.GZ3669@spearce.org> 
Comments: In-reply-to "Shawn O. Pearce" <spearce@spearce.org>
   message dated "Fri, 26 Sep 2008 07:37:26 -0700."
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96975>


I have upgraded and the problem has disappeared.  Many thanks for the
advice.

 -tom

Shawn O. Pearce <spearce@spearce.org> wrote:

> tom sgouros <tomfool@as220.org> wrote:
> > > On Thu, 25 Sep 2008, Tom Sgouros wrote:
> > > > I receive the following error message when I try to do a 'git push':
> > > > 
> > > >   tomfool@toms-box:hpl$ git push
> > > >   updating 'refs/heads/master'
> > > >     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
> > > >     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
> > > >    Also local refs/remotes/origin/master
> > > >   Generating pack...
> > > >   Done counting 10 objects.
> > > >   Deltifying 10 objects...
> > > >   error: pack-objects died with strange error
> > > >   unpack eof before pack header was fully read
> > > >   ng refs/heads/master n/a (unpacker error)
> > > >   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
> > > >   tomfool@toms-box:hpl$
> > > 
> > > I got this message when I tried to push a project with submodules to a 
> > > server which had submodule-ignorant git installed.  Maybe it's that?
> > 
> > I'm not sure which versions are submodule-ignorant, but it's version
> > 1.5.3.6 on the pusher and version 1.5.4.5 on the server.  I installed
> > git via the fink package manager.  Could there be some other
> > incompatibility? 
> 
> This change came after 1.5.3.6 and I think its what you are
> tripping over:
> 
>   commit 481f0ee60eef2c34b891e5d04b7e6e5a955eedf4
>   Author: Linus Torvalds <torvalds@linux-foundation.org>
>   Date:   Sun Nov 11 23:35:23 2007 +0000
> 
>     Fix rev-list when showing objects involving submodules
> 
> rev-list aborting because it cannot mark a submodule commit
> as uninteresting should cause pack-objects to abort too since
> the list of objects wasn't completely produced.
> 
> That fix is in 1.5.3.7 or later.
> 
> -- 
> Shawn.
> 



-- 
 ------------------------
 tomfool at as220 dot org
 http://sgouros.com  
 http://whatcheer.net
