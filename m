From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fetch failure: index.lock file exists
Date: Sat, 17 Nov 2007 13:15:49 -0800
Message-ID: <20071117211549.GC31598@mayonaise>
References: <65dd6fd50711151607x50639232w6d79322129c3d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ollie Wild <aaw@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItV1M-0001p5-Da
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbXKQVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXKQVPv
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:15:51 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33674 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbXKQVPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:15:51 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D4AAE7DC0FE;
	Sat, 17 Nov 2007 13:15:49 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 13:15:49 -0800
Content-Disposition: inline
In-Reply-To: <65dd6fd50711151607x50639232w6d79322129c3d82@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65310>

Ollie Wild <aaw@google.com> wrote:
> Hi,
> 
> I've been using git-svn for a while now to work on gcc.  Last night, I did a
> 
>   git svn fetch
> 
> and got the following failure:
> 
>   Found possible branch point: svn+ssh://aaw@gcc.gnu.org/svn/gcc/trunk =>
>       svn+ssh://aaw@gcc.gnu.org/svn/gcc/tags/libbid-last-merge, 128810
>   Found branch parent: (tags/libbid-last-merge)
>       789aa951bbc6a49f791bf5109136335fc33222c5
>   fatal: unable to create
> '.git/svn/tags/libbid-last-merge/index.lock': File exists
>   read-tree 789aa951bbc6a49f791bf5109136335fc33222c5:
>       command returned error: 128
> 
> Naively, it looks to me like I've just got a stale lock file from a
> previous run.  However, I have no idea what the correct recovery
> strategy is.  Can I just delete the lock file?  Do I need to do some
> sort of data validation?
> 
> I'm using git version 1.5.2.5 with subversion version 1.4.5 (r25188).

Did you interrupt git-svn in a previous run?  But you should be able to
just remove it; git-svn should verify that the index is in a consistent
state before it attempts to fetch again.

-- 
Eric Wong
