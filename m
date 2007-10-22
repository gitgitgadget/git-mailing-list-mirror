From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Tue, 23 Oct 2007 00:34:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710230026380.25221@racer.site>
References: <1193091122.v2.fusewebmail-240137@f> <20071022224015.GG23714@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott R Parish <srp@srparish.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6nZ-0004Gn-2u
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXJVXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbXJVXex
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:34:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:40924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751003AbXJVXex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 19:34:53 -0400
Received: (qmail invoked by alias); 22 Oct 2007 23:34:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 23 Oct 2007 01:34:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+36cgdng+EwqVM9WNQoiew3qObEnJ6ysLRnUBMy
	eJdTMx7aBQt5Xb
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022224015.GG23714@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62058>

Hi,

On Tue, 23 Oct 2007, Alex Riesen wrote:

> Scott R Parish, Tue, Oct 23, 2007 00:12:02 +0200:
> > > Alex Riesen, Mon, Oct 22, 2007 12:01
> > > Scott R Parish, Mon, Oct 22, 2007 19:01:48 +0200:
> > > > +                strbuf_addch(out, ':');
> > >
> > > Shouldn't it break MingW32 native port?
> > 
> > What can i do here to better accommodate MingW32? You're right, just 
> > because the original code did it this way isn't a good excuse for me 
> > not to do it better.
> 
> someone here mentioned "higher abstractions".

That someone may well have mentioned that term, but what he meant was 
special case those code paths which have to be treated differently for 
Windows, and Windows alone.

(Yeah, I know, a response to that was that Nokia phones have drive 
letters, too, but that was an invalid objection to that particular 
statement, since Nokia phones expect the full path at any time, so I did 
not even bother answering to that mail.  Well, in a way, I guess I just 
did.)

All this boils down to adding code dedicated to Windows.  And I am a huge 
fan of the principle that you should cross bridges when you get to them, 
and not before (i.e. avoid over-engineering).

So my vote is: get it in as-is, us msysGit lot will cope with it in one 
way or another.  (We already have at least one other place where ":" is 
used, which we have to cope with, in shell.c:do_cvs_command().)

Ciao,
Dscho
