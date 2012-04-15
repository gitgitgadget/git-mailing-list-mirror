From: Christian Engwer <christian.engwer@wwu.de>
Subject: Re: [PATCH] prohibit "svn dcommit" on remote-tracking-branches
Date: Sun, 15 Apr 2012 15:40:51 +0200
Message-ID: <20120415134051.GA16786@mathe-macht-spass.de>
References: <handler.667488.B.133354466019267.ack@bugs.debian.org>
 <20120410211732.GB27555@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 15:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJPgm-0005kA-NK
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 15:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab2DONjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 09:39:39 -0400
Received: from marnach.net ([87.230.94.153]:33010 "EHLO
	lvps87-230-94-153.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753607Ab2DONjj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 09:39:39 -0400
Received: from dslb-084-060-028-065.pools.arcor-ip.net ([84.60.28.65] helo=sansibar)
	by lvps87-230-94-153.dedicated.hosteurope.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SJPfv-0001qb-Nh; Sun, 15 Apr 2012 15:39:31 +0200
Received: from christi by sansibar with local (Exim 4.77)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SJPhD-0000LM-Lv; Sun, 15 Apr 2012 15:40:51 +0200
Content-Disposition: inline
In-Reply-To: <20120410211732.GB27555@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195569>

Hi,

we had a litte discussion on this topic in the debian bug-tracker:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=667488

> > A branch should either be a local copy of an svn branch, or a remote
> > tracking branch. After a "git svn dcommit" a remote tracking branch
> > could not be synced with the git remote due to the rebase that occured
> > during the dcommit. Thus we check for a remote entry in the git config
> > for the current branch and prohibit the "dcommit" if such an entry
> > exists.
> 
> Should there be an option to force/override this?

The suggestion was implement this as a hook, instead of being the
default behavior. An other option is to use the proposed syntax and
allow an explicit overwrite by setting the commiturl, or to add a
completely new option, in order to avoid confusion.

Opinions?

> git-svn predates remote tracking branches, and I've never gotten in the
> habit using remote tracking branches.  I'll wait for others to chime
> in...
> 
> > +        if (s/^\* +//)
> > +        {
> 
> style, opening brace should be on the same line as the if/while/for:
> 
> 	if (...) {
> 
> Also, indentation should be with hard tabs.  (Basically follow existing
> style conventions when you see them).  Thanks.

I'll update the patch.

Cheers
Christian
