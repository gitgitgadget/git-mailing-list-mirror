From: Pavel Roskin <proski@gnu.org>
Subject: Re: Unresolved issues #2
Date: Thu, 04 May 2006 11:45:31 -0400
Message-ID: <1146757531.5294.26.camel@dv>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	 <20060504095827.GW27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Thu May 04 17:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbg20-0001b5-Ig
	for gcvg-git@gmane.org; Thu, 04 May 2006 17:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWEDPqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWEDPqI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 11:46:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:30364 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932335AbWEDPqH
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 11:46:07 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fbg1m-0005N7-Ip
	for git@vger.kernel.org; Thu, 04 May 2006 11:46:06 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fbg1D-0004jS-FR; Thu, 04 May 2006 11:45:31 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060504095827.GW27689@pasky.or.cz>
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19571>

Hello, Petr!

On Thu, 2006-05-04 at 11:58 +0200, Petr Baudis wrote:

> Oh, my holey memory. In Cogito, I have just implemented a solution
> suggested by Martin Mares, which is pretty simple, non-obtrusive
> and will work equally fine with remotes as well as remote branches:
> 
> 	if [ $branch != master ] && [ -s .git/branches/$branch-origin ]
> 		origin=.git/branches/$branch-origin
> 	else
> 		origin=.git/branches/origin
> 	fi

Isn't ".git/branches" obsolete, at least in git?  I'm surprised it's
still referenced in git sources.

What is the future of ".git/branches"?  Is it becoming a Cogito specific
branch database?  Or is it now a database or branch dependencies?

I would prefer to have one single standard for branch origins that could
be used by git, StGIT and Cogito.  Using a location that is obsolete
outside Cogito is probably the worst possible approach.  I'd rather have
a separate directory, e.g. .git/origins or something.

Alternatively, we could reuse .git/refs by having files with "Pull:" but
without "URI:", e.g.

$ cat .git/refs/branch
Pull: branch-origin:branch

-- 
Regards,
Pavel Roskin
