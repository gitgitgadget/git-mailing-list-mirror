From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: OT: data destruction classics (was: Re: Error converting from
 1.4.4.1 to 1.5.0?)
Date: Thu, 15 Feb 2007 11:24:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151103100.448@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
 <17875.36879.872210.264473@lisa.zopyra.com> <45D3B4E7.8050408@fs.ei.tum.de>
 <20070215021345.GB29732@spearce.org> <Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdmw-0004OT-BD
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965779AbXBOKY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965782AbXBOKY1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:24:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:47372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965779AbXBOKY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:24:26 -0500
Received: (qmail invoked by alias); 15 Feb 2007 10:24:24 -0000
X-Provags-ID: V01U2FsdGVkX19UfkEolyRUqojVaZtMWCUB/NSMlf5b7ZsmQpPRqi
	MZKQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39810>

Hi,

On Wed, 14 Feb 2007, Linus Torvalds wrote:

> On Wed, 14 Feb 2007, Shawn O. Pearce wrote:
> 
> > Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> > > Bill Lear wrote:
> > > >I'm still muttering to myself that I could be that dumb...
> > > 
> > > Still better than trying to backup with
> > > 
> > > tar czvf data* destfile.tar.gz
> > > 
> > > automatic tape backup is a real helper then :)
> > 
> > or manual backup to "tape", where the tape device supplied was
> > the only disk...  SunOS 4 did not take too kindly to its kernel,
> > swap space, root fs being overwritten...
> 
> Hey, I can beat that (stop me at any time you've heard this story. No? 
> Ok, then..)

We're having a dick contest? Well, I'm game.

> I auto-dialed my harddisk. 

I connected a tape drive.

It was a SCSI tape drive, and I had a SCSI Zip drive, which was so often 
connected/disconnected in-flight that the plug wore out. So I thought that 
it should not be a problem to connect the SCSI tape drive to a running 
system. Right? RIGHT?

BIG MISTAKE.

The SCSI adapter also hosted two RAID systems, one as a SCSI RAID, i.e. 
managed by the adapter, and one as ATAPI RAID, i.e. managed by its own 
embedded computer simulating one (actually, two) SCSI hard disks to the 
SCSI adapter.

We wanted to backup some of the data, and that's why we connected the tape 
drive.

First, we got write errors on the RAID. Then, one RAID (the SCSI one) 
stopped working at all. The fans still moved air, but the bus no longer 
moved _any_ bytes.

Panicked (Douglas Adams, where are you when I need you?), I disconnected 
the tape drive, and the two RAID boxes (all of them were external, so 
that was possible). I shut down the computer and let out a long breath of 
hope.

In the course of several weeks, my days started with praying, connecting 
one or both RAIDs to several SCSI adapter/computer pairings, hoping that I 
could read _anything_ from them.

All of the data was lost. Four terabytes. 6-7 months work of three people. 

To this date, the SCSI RAID is not working. After one week (through which 
it did not work _at all_), the ATAPI RAID worked again (strangely enough), 
but had lost the correct order of its 14 disks.

Even if I could reconstruct the correct order after two more weeks, I 
could not get any data from the RAID, since I had nowhere nearly large 
enough amounts of free disk space. And I could not teach the RAID the 
correct order.

And the tape drive still does not work.

Okay, guys, top _that_.

Ciao,
Dscho
