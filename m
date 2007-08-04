From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 12:46:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041240500.14781@racer.site>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <20070804133923.eb84a308.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Ismail =?ISO-8859-1?B?RPZubWV6?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHI6l-0004TJ-Lj
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXHDLrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbXHDLrd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:47:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752610AbXHDLrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:47:32 -0400
Received: (qmail invoked by alias); 04 Aug 2007 11:47:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 04 Aug 2007 13:47:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5I9p3jin5E0MTvd7nYWPEiDI0Xxz23ju5NfSOY+
	Unonr4XDkj/LJk
X-X-Sender: gene099@racer.site
In-Reply-To: <20070804133923.eb84a308.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54828>

Hi,

On Sat, 4 Aug 2007, Timo Hirvonen wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > It might be more worthwhile to research what other "Text-ish
> > lightweight mark-up" systems are availble, and if there is one
> > that is more efficient and can go to at least html and man,
> > one-time convert our documentation source to that format using
> > your Perl magic.  The minimum requirements are:
> > 
> >  * The source is readable without too much mark-up distraction;
> > 
> >  * Can go to roff -man;
> > 
> >  * Can go to html.
> 
> I used asciidoc too but it was really PITA to install and use

I disagree.  Whenever I had the need, installing asciidoc was pretty 
swift.  No problems at all.

> so I wrote a small tool (ttman) in C which converts .txt files directly 
> to man pages.

I was impressed!  Right until I saw that

	- it rolls its own parser/lexer without using bison/flex, which 
	  makes it much longer than necessary,

	- it looks like a perl script doing the same job would have been 
	  even smaller yet, and

	- the syntax is nowhere near asciidoc syntax.

The last point is really something to keep in mind.  We have not only a 
large amount of documentation in that format, which would have to be 
converted -- accurately! -- to the new format.  We also have quite a 
number of documentation contributors which would have to be "migrated" 
towards the new format.

I think that Steven's goal is a laudable one.  We have the 'man' and 
'html' branch mainly for the reason that some cannot/wantnot install 
asciidoc.

But I think that we do not have to have a _complete_ replacement.  I, for 
one, would be happy to see a small script which converts all the man pages 
more or less accurately, with the main goal to be _fast_ and having as 
few dependencies as possible (I think Perl is okay here).

For official releases, I'd still want to rely on asciidoc.

Ciao,
Dscho
