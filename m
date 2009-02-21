From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit difficulties/feature request
Date: Sat, 21 Feb 2009 04:12:53 -0800
Message-ID: <20090221121253.GB8145@dcvr.yhbt.net>
References: <200902191930.10139.kumbayo84@arcor.de> <200902191947.22622.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sat Feb 21 13:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaqkW-0007r3-2R
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 13:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZBUMMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 07:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZBUMMz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 07:12:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60572 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbZBUMMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 07:12:54 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B751F5FD;
	Sat, 21 Feb 2009 12:12:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902191947.22622.kumbayo84@arcor.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110944>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> Hi,
> 
> With the patch i am replying to git-svn got a bit more comfortable for me but 
> there is still a problem left.
> 
> I fetch via svn://anonsvn.kde.org/home/kde/trunk/KDE/kdelibs
> and push to svn+ssh://YOUR_LOGIN@svn.kde.org/home/kde/trunk/KDE/kdelibs
> 
> Pushing multiple changes at once to KDE servers with different fetch/commit 
> url is not possible for me.
> 
> Here is what it think what happens during a push:
> git svn dcommit pushes the first commit to svn.kde.org,
> then tries to fetch what it just pushed from anonsvn.kde.org
> (which lags behind authenticated svn by a few minutes).
> 
> git svn does not see the just committed changes, gets confused
> and stops pushing the rest of the commits.
> 
> My idea would be to temporarily fetch from the authenticated server, but not 
> update the current head and revdb., so nothing is affected beside the push.
> But this seems quite complicated.
> Or do not care about difference between fetch/dcommit url, and just fetch from 
> the dcommit url during dcommit.
> 
> Anybody have a good idea if this is possible or a better way to solve this 
> problem?

You could probably look into how rewriteRoot works and set that on a
temporary basis in memory.  In fact, that should probably be a default
when using --commit-url iny any form...

-- 
Eric Wong
