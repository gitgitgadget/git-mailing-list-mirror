From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 17:34:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251733040.5731@racer.site>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801242227250.13593@iabervon.org>
 <7vprvq7cy7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801251134570.5731@racer.site> <alpine.LNX.1.00.0801251111540.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 18:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JISSl-00019C-S7
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbYAYRfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbYAYRfD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 12:35:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753968AbYAYRfB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 12:35:01 -0500
Received: (qmail invoked by alias); 25 Jan 2008 17:34:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 25 Jan 2008 18:34:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NfS0YvmYNfSxFmjwCKh3VfIWPluKDnZYHQDs50i
	MxG9T+hXqb+Il0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0801251111540.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71721>

Hi,

On Fri, 25 Jan 2008, Daniel Barkalow wrote:

> On Fri, 25 Jan 2008, Johannes Schindelin wrote:
> 
> > On Thu, 24 Jan 2008, Junio C Hamano wrote:
> > 
> > > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > 
> > > > $ git checkout branch
> > > > Warning: xt_CONNMARK.c conflicts with xt_connmark.c; not checking it out
> > > > $ git checkout xt_CONNMARK.c --as xt_CONNMARK_caps.c
> > > > $ edit xt_CONNMARK_caps.c
> > > > $ git add xt_CONNMARK_caps.c
> > > 
> > > Heh, I like that very much.
> > 
> > It would make it easier to test on Linux, too, yes.
> > 
> > But then, it would break the build process all the same.
> 
> Sure, but it would permit a user of a filesystem that can't handle the 
> project to make modifications that generate a commit the filesystem can 
> handle, which is currently pretty difficult.
> 
> $ git checkout xt_CONNMARK.c --as xt_CONNMARK_tmp.c
> $ mv xt_CONNMARK_tmp.c xt_connmark_flag.c
> $ edit Makefile
> $ git add xt_connmark_flag.c
> $ git commit -a

AFAICT it is possible right now:

$ git checkout xt_CONNMARK.c
$ git mv xt_CONNMARK.c xt_connmark_flag.c
$ git checkout xt_connmark.c
$ edit Makefile
$ git add Makefile
$ git commit

Ciao,
Dscho
