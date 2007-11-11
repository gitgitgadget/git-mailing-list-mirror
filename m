From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit with a dirty index
Date: Sat, 10 Nov 2007 17:42:52 -0800
Message-ID: <20071111014252.GA18748@mayonaise>
References: <DBC1E504-9007-4C89-9728-2DDBAFF2053B@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Nov 11 02:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir1r3-0001Cu-1e
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 02:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXKKBmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 20:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbXKKBmz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 20:42:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56258 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXKKBmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 20:42:54 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DFFC27DC0FE;
	Sat, 10 Nov 2007 17:42:52 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 10 Nov 2007 17:42:52 -0800
Content-Disposition: inline
In-Reply-To: <DBC1E504-9007-4C89-9728-2DDBAFF2053B@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64392>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> Hello list,
> From what I understand, when using dcommit, git-svn uses rebase to  
> "sync" the history with what has just been committed.  If the index  
> is in a dirty state, this will cause trouble.  I thought about using  
> git-stash and then git stash apply --index but I'm afraid this could  
> be confusing if dcommit actually brings more revision in that the  
> ones it has just committed.  I'm not sure this is possible and even  
> if it is, it might not be troublesome since if the commits are  
> accepted in the SVN repo, they surely don't overlap with commits that  
> have been sent in the mean time.  But it's risky, so I don't know  
> what to do.  If we use the stash approach, we might want to tell the  
> user that we bailed out because of a problem that needs to be fixed  
> and that he can recover his changes with git stash apply --index.
> 
> Or we should simply check that the index isn't dirty beforehand and  
> refuse to dcommit if it is.
> 
> Any suggestion?

The latter option is much simpler.  I actually thought there was already
a check in dcommit that prevents it from committing with a dirty index,
but apparently not...

> PS OT: Eric, have you made any progress on the svn:externals<- 
> >submodules mapping?  I badly need this feature, but I don't want to  
> start to work on it if you're currently working on it (or about to  
> deal with it) to avoid unecessary effort duplication.

Oops, sorry.  I've been busy and forgetful.  I'll try to work on it
later tonight or tomorrow.

-- 
Eric Wong
