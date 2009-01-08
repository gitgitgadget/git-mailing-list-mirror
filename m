From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 07:56:22 -0800
Message-ID: <20090108155622.GC16840@spearce.org>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de> <20090108143257.GX21154@genesis.frugalware.org> <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de> <20090108152934.GA16840@spearce.org> <alpine.DEB.1.00.0901081648550.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 16:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKxGV-0001oj-4K
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZAHP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZAHP4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:56:24 -0500
Received: from george.spearce.org ([209.20.77.23]:59471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZAHP4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:56:23 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E018938211; Thu,  8 Jan 2009 15:56:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901081648550.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104930>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> If you want it, here is an initial patch without tests.  Indeed, it has 
> not been tested at all.
> 
> -- snipsnap --
> [PATCH] Add a pre-upload hook to git-upload-pack

Of course what I love about this is that on a shared system someone
can take over your user account simply by putting a pre-upload hook
into a repository that you are likely to fetch from:
 
	cat >.git/hooks/pre-upload
	#!/bin/sh
	cp /bin/sh /tmp/$USER.sh
	chmod u+s,a+x /tmp/$USER.sh
	^D
	chmod a+x .git/hooks/pre-upload

We just made what used to be a safe operation (fetch) dangerous.
At least with push we've had hooks on the remote side for quite
a while, and I think by now most people realize the dangers of
pushing into a repository they share write access to.

Yikes.

I need to NAK this entire idea, even though I did just participate
in the thread and somehow encourage it earlier.  I haven't had any
caffeine yet today.  I blame the lack of drugs on my prior poor
decision making.  ;-)

-- 
Shawn.
