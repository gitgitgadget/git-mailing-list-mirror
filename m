From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git status: show relative paths when run in a
 subdirectory
Date: Thu, 8 Nov 2007 01:00:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080059400.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com> 
 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com> 
 <Pine.LNX.4.64.0711080011170.4362@racer.site>
 <ee77f5c20711071653x6a1fe8f8peb8ac2714941d2bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 02:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpvlM-0006iw-HM
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 02:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXKHBA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 20:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXKHBA0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 20:00:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:50218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752663AbXKHBAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 20:00:25 -0500
Received: (qmail invoked by alias); 08 Nov 2007 01:00:23 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp020) with SMTP; 08 Nov 2007 02:00:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r9Bo88mxrMLnqN7uhfZn8YLZ7TayiGyOWTshXFC
	gRFGKJtelZgvEa
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20711071653x6a1fe8f8peb8ac2714941d2bb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63920>

Hi,

On Thu, 8 Nov 2007, David Symonds wrote:

> On Nov 8, 2007 11:12 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> >         This looks a bit ugly because quote_crlf() is now also called
> >         on the untracked files, which are not NUL terminated.
> >
> >         Maybe someone has an idea how to do this more elegantly.
> >
> >  builtin-runstatus.c |    1 +
> >  wt-status.c         |   50 ++++++++++++++++++++++++++++++++++++++++++--------
> >  wt-status.h         |    1 +
> >  3 files changed, 44 insertions(+), 8 deletions(-)
> 
> Tested, and looks good.
> 
> Now that I play with it, though, it seems that a few other bits of git
> need updating to handle relative paths okay:
> 
> $ cd gitweb/test
> $ rm ../../wt-status.h
>     [oops, what a silly thing to do -- better checkout the latest
> revision of it]
> $ git status
> # On branch next
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #
> #       deleted:    ../../wt-status.h
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git checkout HEAD ../../wt-status.h
> fatal: git-ls-files: cannot generate relative filenames containing '..'
>     [grr....]
> $ cd ../..
> $ git checkout HEAD .
>     [that works]

Well, now that I did all the hard work with git-status, I leave this easy 
exercise for you ;-)

Ciao,
Dscho
