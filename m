From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some git performance measurements..
Date: Sat, 8 Dec 2007 11:05:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712081103430.27959@racer.site>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
  <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>  <finmvm$da8$1@ger.gmane.org>
  <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home> 
 <B161871F-E812-44B4-A699-44341B5783D3@zib.de> 
 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com> 
 <Pine.LNX.4.64.0712071348100.27959@racer.site> 
 <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com> 
 <Pine.LNX.4.64.0712071816100.27959@racer.site>
 <e2b179460712071115k369dddcatb0f6456d0028acbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:06:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0xVz-00039a-58
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXLHLGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbXLHLGO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:06:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:56934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751009AbXLHLGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:06:13 -0500
Received: (qmail invoked by alias); 08 Dec 2007 11:06:11 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp032) with SMTP; 08 Dec 2007 12:06:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jkWt/HpGj7SXejMyVFKZV2mrerA3/OeVDY5yyAg
	z4ObrAFUnLNHti
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460712071115k369dddcatb0f6456d0028acbb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67538>

Hi,

On Fri, 7 Dec 2007, Mike Ralphson wrote:

> On Dec 7, 2007 6:37 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 7 Dec 2007, Mike Ralphson wrote:
> >
> > > On Dec 7, 2007 1:49 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > On Fri, 7 Dec 2007, Mike Ralphson wrote:
> > > >
> > > > > I benchmarked 3 alternative qsorts, qsortG [2] was the fastest 
> > > > > on my system but has funky licensing, the NetBSD qsort was 
> > > > > middle-range and the glibc one the slowest of the three (but 
> > > > > that could be due to it being tuned for a "Sun 4/260"). All of 
> > > > > them show over 100x speed improvements on a git-status of my 
> > > > > main repo (104s -> ~0.7s)
> > > >
> >
> > Okay, sorry, I did not bother reading further when I read "You may use 
> > it in anything you like;".
> >
> > But if the author did not respond, it might be a better idea to just 
> > reimplement it.
> >
> 
> I've just tried the mergesort implementation as used in msysgit and that 
> performs faster for me. It's simpler, and compatibly licensed. It looks 
> good.

Now I'm confused.  You said you tested qsortG, NetBSD qsort and qlibc, 
with glibc performing the slowest.  Now, 4msysgit's implementation is 
based on glibc (Thanks Brian!), so I wonder if you could redo the 
performance tests and say if qsortG still is substantially faster than 
4msysgit's qsort?

Ciao,
Dscho
