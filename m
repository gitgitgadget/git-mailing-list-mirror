From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn segmetation fault
Date: Fri, 1 Feb 2008 20:06:37 -0800
Message-ID: <20080202040637.GA24478@soma>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 05:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL9fA-0002zp-2U
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 05:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbYBBEGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 23:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759486AbYBBEGj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 23:06:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35259 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbYBBEGi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 23:06:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DCDD02DC08B;
	Fri,  1 Feb 2008 20:06:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47A3BE6F.6080304@saville.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72221>

Wink Saville <wink@saville.com> wrote:
> Wink Saville wrote:
> >I was doing an git-svn dcommit and got a seg fault. The first
> >phase of updating svn completed and then it seg faulted on the
> >second. So I suspect I'm out of sync and need to recover,
> >any guidance appreciated.
> >
> >If it's any help the svn repo is at 
> >http://async-msgcomp.googlecode.com/svn.
> >If someone needs it I happen to have a backup of the git repo before
> >doing the commit and then after the seg fault.
> >
> >If there is any other information that someone needs I can try
> >to supply it.

Which version of the SVN bindings do you have installed?

> >Cheers,
> >
> >Wink Saville
> <snip/>
> 
> 
> <As an update, I first tried to re-execute the dcommit, but that didn't 
> work: />
> 
> wink@ic2d1:$ git-svn dcommit
> Committing to https://async-msgcomp.googlecode.com/svn/trunk ...
> Merge conflict during commit: Your file or directory 
> 'android/hmc/src/com/saville' is probably out-of-date: The version 
> resource does not correspond to the resource within the transaction.  
> Either the requested version resource is out of date (needs to be 
> updated), or the requested version resource is newer than the 
> transaction root (restart the commit). at /usr/bin/git-svn line 420
> 
> <I than did a rebase that got me back in sync: />
> 
> wink@ic2d1:$ git-svn rebase
> Index mismatch: 94bbfa6d433192de71060d1274f0b0eab8f49a30 != 
> 2fcd3a5cc5a9ca062a41d0ff5ac30073f4fa23b0
> rereading 8ce31b64294bdb063c64c50b9358533ac8746af4

<snip long list of files>

>        A       COPYING.LESSER
>        A       COPYING
>        A       AGPLv3.LICENSE
> r52 = 2336c1c70e92d572f5a1b248249b4f857142bc51 (git-svn)
> First, rewinding head to replay your work on top of it...
> HEAD is now at 2336c1c... Refactor to reduce duplicated code and have 
> pure Java Hmc/ActiveHmc.
> Nothing to do.

So it appears the dcommit succeeded in making the change to the
repository, but segfaulted afterwards (when attempting to retreive
the version number of the commit.   Is that assessment correct?

-- 
Eric Wong
