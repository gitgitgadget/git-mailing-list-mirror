From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: 'upstream' branches.
Date: Sat, 5 May 2007 19:44:16 +0200
Message-ID: <20070505174416.GA2898@steel.home>
References: <1178368166.11851.60.camel@pmac.infradead.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat May 05 19:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOIy-0006mo-R2
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133AbXEERoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934134AbXEERoV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:44:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:27828 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934133AbXEERoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:44:21 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo40) (RZmta 5.9)
	with ESMTP id A04995j45EA3D1 ; Sat, 5 May 2007 19:44:17 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 22593277BD;
	Sat,  5 May 2007 19:44:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8B48ED171; Sat,  5 May 2007 19:44:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1178368166.11851.60.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46272>

David Woodhouse, Sat, May 05, 2007 14:29:26 +0200:
> [remote "origin"]
>         url = ssh://git.infradead.org/~/public_git/foo-2.6.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> 	fetch = +refs/heads/mtd:refs/heads/mtd
> 	fetch = +refs/heads/linus:refs/heads/linus

These pluses request overwriting of the local reference even if it has
more commits than the remote ("is newer"). Are you sure you want that?

> What I have at the moment isn't ideal because I think pulling from the
> 'mtd' tree will fail if the 'linus' branch there is older than the local
> clone's 'linus' branch. But it mostly works.
> 
> Is there a better way?

I would just remove the pluses. git-fetch will say that the branch is
already up-to-date, if the local branch already has everything the
remote has.
