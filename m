From: Petr Baudis <pasky@suse.cz>
Subject: Re: New script: cg-clean
Date: Fri, 12 Aug 2005 03:08:11 +0200
Message-ID: <20050812010811.GM25280@pasky.ji.cz>
References: <1120862084.17812.6.camel@dv> <20050710154618.GF24249@pasky.ji.cz> <1123312443.17959.34.camel@dv.roinet.com> <20050811232925.GK25280@pasky.ji.cz> <1123808053.4248.47.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 03:09:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3O2P-0004Jf-JY
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 03:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHLBIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 21:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHLBIP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 21:08:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41740 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932382AbVHLBIO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 21:08:14 -0400
Received: (qmail 19637 invoked by uid 2001); 12 Aug 2005 01:08:11 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1123808053.4248.47.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 12, 2005 at 02:54:13AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hi, Petr!

Hi,

> Unfortunately, my latest revision of cg-clean has "committed suicide"
> just when I was about to post it.  Anyway, I would prefer to wait until
> you apply my patch to cg-status to ignore all ignores.  That would allow
> me to reuse cg-status.

well, I did quite a while ago. Unless the kernel.org mirroring system
broke, it should be already public.

> On Fri, 2005-08-12 at 01:29 +0200, Petr Baudis wrote:
> > > Here's the simplified cg-clean script.  Note that the "-d" option is not
> > > working with the current version of git of a bug in git-ls-files.  I can
> > > work it around by scanning all directories in bash, but I think it's
> > > easier to fix git (remove "continue" before DT_REG in ls-files.c).
> > 
> > Is that fixed already?
> 
> It turn out it's quite tricky.  git-ls-files doesn't distinguish between
> known and unknown directories.

In the long term, I would prefer to have directory information in the
index file - to make this kind of tasks easier, allow juggling with
empty directories etc.

> One way to do it would be to check all
> cached files and find all directories they are in.  Another approach
> would involve "git-ls-tree -r", but I don't think it would be right
> because we work with cache and current files, not with committed data
> (but my knowledge is limited to make a call - I still need to read the
> documentation about git).

Yes, we should certainly follow the index, otherwise you will e.g. lose
the files added by cg-add but not committed yet.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
