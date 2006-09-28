From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 23:47:05 -0400
Message-ID: <20060928034704.GB22897@spearce.org>
References: <20060928001241.62887.qmail@web51013.mail.yahoo.com> <7vzmck7pis.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609272252041.9349@xanadu.home> <20060928033948.GC3650@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 05:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSms1-0005wf-Kq
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWI1DrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWI1DrL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:47:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31204 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751277AbWI1DrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:47:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSmrP-0001rQ-8Q; Wed, 27 Sep 2006 23:46:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 575DE20FB28; Wed, 27 Sep 2006 23:47:05 -0400 (EDT)
To: Tom Prince <tom.prince@ualberta.net>
Content-Disposition: inline
In-Reply-To: <20060928033948.GC3650@socrates.priv>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27976>

Tom Prince <tom.prince@ualberta.net> wrote:
> On Wed, Sep 27, 2006 at 11:07:35PM -0400, Nicolas Pitre wrote:
> > I beg to differ.  Such information might be really useful.  I agree 
> > though that this is an expensive operation and gitweb might not be the 
> > best place for it at all.
> > 
> > For example... some times I look at git-log output and finds about a 
> > certain bug fix that was apparently committed a month ago.  And 
> > incidentally I recall having been bitten by that bug not really long 
> > ago, say last week.  Although the bug fix was committed _somewhere_ last 
> > month, what I would really want to know is just when _i_ received that 
> > bug fix in my own repository to determine if it was before or after last 
> > week.  So if it was before last week then I could conclude that the bug 
> > fix didn't actually fix my bug.  Knowing that it has been committed last 
> > month is absolutely useless to me in this case.
> > 
> 
> But even knowing when the commit arrived in your local repository does
> you no good unless you are compiling every time you pull, in which case,
> the reflog support on you local machine will give you the information
> you need. Otherwise, you need to know the name of the commit you were
> running when you got bitten by the bug which is a separate issue.

Which is why Git embeds its version number from git-describe as
part of its build process.  So "git --version" can give you back
an identifier.

And given that identifier (and the new schooling given to the
sha1 expression parser) you can easily ask git to determine if the
given bug fix commit was an ancestor of that identifier, or not.
No reflog involved and you have your answer.

As it happens I build and install `next` every time I fetch from
Junio's public tree.  But I never rely on my reflog to associate
back to a commit; I always use `git --version`.

-- 
Shawn.
