From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree
Date: Sun, 8 Jul 2007 22:45:53 -0700
Message-ID: <20070709054541.GA2301@mayonaise>
References: <001501c7c02a$4bc130a0$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tjernlund <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7m4U-0001hC-Gk
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbXGIFp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbXGIFp4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:45:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35949 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbXGIFpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:45:55 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 421F92DC032;
	Sun,  8 Jul 2007 22:45:53 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 08 Jul 2007 22:45:53 -0700
Content-Disposition: inline
In-Reply-To: <001501c7c02a$4bc130a0$0e67a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51960>

Tjernlund <tjernlund@tjernlund.se> wrote:
> I have noticed that if I do a git-svn set-tree, remotes/git-svn
> retains the parent from the branch where set-tree was performed.
> 
> If a coworker wants recreate my tree by using git-svn init && git-svn
> fetch he looses the parent I have in my tree.
> 
> I wonder if not git-svn set-tree can record the parent information in
> the svn repos log, so that git-svn init/fetch can recreate the parent
> relationship?

We could at yet another non-standardized property into SVN to handle
merges.  Currently there are at least two properties used in the SVN/SVK
world to represent merges (Sam Vilain can give you the fun details of
each one!).

I'm afraid adding a third incompatible yet similair property for git-svn
would just confuse people.

I've become very much against crazy stuff like set-tree which ends up
creating a M:N history mapping between git and svn.  1:1 is the simplest
and easiest.  I'm more than willing to sacrifice multi-parent histories
in git for easier compatibility with other systems.

Heck, linear history is just easier to deal with and probably preferable
in most/many cases.  I'm sure that the rising popularity of git-rebase,
quilt, stgit, guilt, mq and other like tools is a testament to that.

-- 
Eric Wong
