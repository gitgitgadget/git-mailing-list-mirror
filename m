From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 23:09:54 +0200
Message-ID: <20070520210954.GB942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
 <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
 <20070520205444.GC25462@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsfB-0003FF-P5
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbXETVJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756621AbXETVJ5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:09:57 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:39725 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569AbXETVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:09:56 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIC00FH1YSJP6@smtp13.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 23:09:55 +0200 (CEST)
Received: (qmail 1648 invoked by uid 500); Sun, 20 May 2007 21:09:55 +0000
In-reply-to: <20070520205444.GC25462@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47919>

On Sun, May 20, 2007 at 10:54:44PM +0200, Alex Riesen wrote:
> Sven Verdoolaege, Sun, May 20, 2007 21:59:30 +0200:
> > > I am very worried about this big red switch that says "all
> > > subprojects to be cloned and checked out, or nothing".  I think
> > > this would not work well with projects that truly need
> > > superproject support (i.e. very large ones, where most people
> > > would not want to clone and check out every single subproject).
> > 
> > It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> > Since the subcloning only happens at checkout, you could set these
> > before doing a checkout.
> 
> And set them back after doing the checkout?

What do you mean?  Why would you set them back?
I guess I'm missing something.

> Me too. I actually believe it is the only way to do it. How can you
> checkout a subproject to something else (to what a branch may point)
> and to what the tree of superproject has? On the other side (in
> subproject) - why are you, the superproject, allowed to screw the
> references of the subproject?! It is independent, isn't it?!

Well... the subproject as a whole is independent of the superproject,
but the checkout in the superproject is not entirely independent.

> > >  - What would we do when the subproject working tree is not
> > >    clean?
> > 
> > I was planning on adding a --dry-run to git-checkout.
> > The superproject would run this in each subproject before
> > doing the actual checkout of the superproject.
> 
> Why not do exactly what we do now? Pass "-m" down to it, if it was
> given to the top-level git-checkout.

We want to be sure that all (selected) subprojects can be updated before
updating any, no?

skimo
