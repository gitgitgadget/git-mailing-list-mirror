From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: most commonly used git commands?
Date: Sun, 1 Jul 2007 18:49:01 +0200
Message-ID: <20070701164901.GB3661@steel.home>
References: <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site> <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com> <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com> <Pine.LNX.4.64.0706281506390.4438@racer.site> <20070630131428.GA2866@steel.home> <Pine.LNX.4.64.0706301531050.4438@racer.site> <20070630223504.GB2703@steel.home> <20070701091645.GA26243@efreet.light.src>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I52bm-0000u5-VD
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbXGAQtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbXGAQtG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:49:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:65014 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbXGAQtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:49:04 -0400
Received: from tigra.home (Fa9ee.f.strato-dslnet.de [195.4.169.238])
	by post.webmailer.de (fruni mo2) (RZmta 7.6)
	with ESMTP id Z02860j61GNU4o ; Sun, 1 Jul 2007 18:49:02 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 27155277BD;
	Sun,  1 Jul 2007 18:49:02 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DBF09C164; Sun,  1 Jul 2007 18:49:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070701091645.GA26243@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrERwE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51310>

Jan Hudec, Sun, Jul 01, 2007 11:16:46 +0200:
> On Sun, Jul 01, 2007 at 00:35:04 +0200, Alex Riesen wrote:
> > Johannes Schindelin, Sat, Jun 30, 2007 16:31:48 +0200:
> > > On Sat, 30 Jun 2007, Alex Riesen wrote:
> > > > Johannes Schindelin, Thu, Jun 28, 2007 16:07:17 +0200:
> > > > > > No. It was meant as Alex said it. Windows (MinGW) doesn't understand
> > > > > > "chmod a+x blub".
> > > > > 
> > > > > Yes, I suspected that. But I don't see a need for it on Windows (MinGW) to 
> > > > > begin with.
> > > > > 
> > > > 
> > > > But it is necessary on Windows (Cygwin):
> > > 
> > > I thought that on Cygwin, filemode=1? I mean, Cygwin _never_ had problems 
> > > with chmod under my fingers.
> > > 
> > 
> > Try doing stat(2) on file.txt which contains "#!/bin/sh" in its first
> > line and for which you have issued a chmod yet. Like a new file, or
> > like every file in a git-tracked directory after you did a fresh
> > checkout. Cygwin actually opens the files when doing stat(2), looks
> > inside and tries to guess if they are executable.
> > 
> > You should have said: "Cygwin _never_ had problems with chmod because
> > it cannot and didn't make it work". It is not just chmod, the other
> > side, stat, matters as well.
> 
> I always had the impression, that cygwin actually *implements* chmod and does
> so using windows ACLs. And in ACL windows *do* support executable bit (I

Windows ACLs don't have exec bit in the UNIX sense.

> copied some DLL with cygwin copy and it was NOT executable then). Of course
> this only works on filesystems (NTFS, NTFS exported over CIFS) that support
> ACLs. On FAT it might be doing something like you describe. Though it is
> mostly irrelevant for git, because git does not work on FAT (Cygwin only
> supports posix rename on NTFS).

It does not work on NTFS either. For all the same reason I described
above: Cygwin tries to be clever (and annoying) and looks into files.
And no Windows program (like, for example, your editor of preference)
will call Cygwin's chmod just to set the permissions how Cygwin likes
them.
