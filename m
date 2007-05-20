From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:24:10 +0200
Message-ID: <20070520222410.GF25462@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520214026.GL5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:24:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hptpi-0006Xp-IX
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbXETWYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757688AbXETWYO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:24:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46050 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831AbXETWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:24:13 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (fruni mo64) (RZmta 6.5)
	with ESMTP id G02655j4KIqkJ0 ; Mon, 21 May 2007 00:24:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6EE67277BD;
	Mon, 21 May 2007 00:24:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DF62CD195; Mon, 21 May 2007 00:24:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520214026.GL5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47937>

Martin Waitz, Sun, May 20, 2007 23:40:26 +0200:
> > > >  - What would we do when the subproject working tree is not
> > > >    clean?
> > > 
> > > I was planning on adding a --dry-run to git-checkout.
> > > The superproject would run this in each subproject before
> > > doing the actual checkout of the superproject.
> > 
> > Why not do exactly what we do now? Pass "-m" down to it, if it was
> > given to the top-level git-checkout.
> 
> sounds good.
> With submodules we have to consider one extra level of merging.
> -m in the supermodule also means that an automatic merge of the
> dirlink entry should be done.  Which would execute git-merge in the
> submodule.  And merging in a dirty tree is a challenge of its own.

But it is not a merge. It is a checkout. Being another operation it
may even be disallow merges of subprojects. Just plainly tell user
that this checkout is not possible because there are changes in
subprojects and in the pointer to this subproject in the upper level
superproject, and that the user should think about committing in
subproject first.

> So if local changes conflict with the checkout we should just error out.

On account of it being too complex. Always a good reason.
