From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Mon, 4 Jun 2007 18:40:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041840460.4046@racer.site>
References: <20070603010044.GA4507@spearce.org>  <20070603130745.GC2495@steel.home>
  <7vvee4jh24.fsf@assigned-by-dhcp.cox.net> <81b0412b0706040700s667afe5ap14a8343a9313ef60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGaI-0007a8-Vz
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXFDRnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbXFDRnG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 13:43:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:59210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750795AbXFDRnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 13:43:05 -0400
Received: (qmail invoked by alias); 04 Jun 2007 17:43:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 04 Jun 2007 19:43:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ep3JjvQWeuwp731Tx/T1tz9rMZ4JID3KZc0ZvKL
	UJ1NP9JDVrTP8I
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0706040700s667afe5ap14a8343a9313ef60@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49117>

Hi,

On Mon, 4 Jun 2007, Alex Riesen wrote:

> On 6/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Updated. BTW, where does "no $(call) in Makefile" came from?
> > > It could simplify the thing a lot
> > 
> > Probably, but first let's make it "work right" while not
> > introducing new stuff.
> > 
> 
> Just looked for the reasons, which appear to be there:
> commit 39c015c556f285106931e0500f301de462b0e46e
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Sat Feb 18 12:40:22 2006 +0100
> 
>    Fixes for ancient versions of GNU make
> 
>    Some versions of GNU make do not understand $(call), and have problems to
>    interpret rules like this:
> 
>    some_target: CFLAGS += -Dsome=defs
> 
>    [jc: simplified substitution a bit. ]
> 
>    Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>
>    Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> I trust Johannes to have such a make, never seen it myself, though.

Yes. I no longer have access to that machine, but it was an SGI machine 
running IRIX, and I had no root access, and I had a quota.

That is when I worked towards getting rid of Python (making the use of it 
optional at first), and working with incompatible or sufficiently non-GNU 
programs like old make, different sed, etc.

At the time I was really annoyed with the situation, especially since it 
was _easy_ to stay compatible with them. I have little sympathy with 
making things just a little simpler for John R. Developer, and 
substantially harder for a lot of users.

So, are you sure you want to force everybody who wants to compile Git to 
use a recent GNU make?

Ciao,
Dscho
