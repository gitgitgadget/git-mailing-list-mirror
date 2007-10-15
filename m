From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:44:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710151938300.25221@racer.site>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
 <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
 <4713B367.52CEC7E2@dessent.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Eli Zaretskii <eliz@gnu.org>,
	ae@op5.se, tsuna@lrde.epita.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 21:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhUwT-0002no-4J
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960AbXJOSoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933594AbXJOSoR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 14:44:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:33552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933825AbXJOSoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 14:44:15 -0400
Received: (qmail invoked by alias); 15 Oct 2007 18:44:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 15 Oct 2007 20:44:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lrH9TwOplQGRWB2jHUZ4mvvLoQohRrcePTAfy7g
	yVTIHJXSIeNgXd
X-X-Sender: gene099@racer.site
In-Reply-To: <4713B367.52CEC7E2@dessent.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61027>

Hi,

[excluding make-w32 list as per explicit request]

On Mon, 15 Oct 2007, Brian Dessent wrote:

> Alex Riesen wrote:
> 
> > He misunderstood. It is not what you meant. You cannot remove the open
> > file. What he talks about is removing the file after it is _closed_.
> > Junk.
> 
> I did not misunderstand.  The semantics are equivalent to the POSIX 
> case: you end up with a handle to an open file that is exclusive to that 
> process (it cannot be opened by any other process, even root) and that 
> is automatically reclaimed by the filesystem when all open handles are 
> closed, without any explicit action by the user.  It's not "unlinking an 
> open file", no, but it's the same result.

No, it is not equivalent.  For example, you can still see the file.  For 
example, you cannot reuse the filename for another file.  And -- the 
killer -- you cannot remove the directory which contains the file.

But really, we have workarounds in place to make this a non-issue.

My bigger concerns are the performance and stability.  For example, I had 
a very annoying problem on one of the machines I am testing msysGit on.  
The problem was _only_ fixable by deactivating component of Logitech's 
WebCam driver!  Now, if a user-installable 3rd party program can make my 
regular git crash, I am scared what more it can do.

Ciao,
Dscho
