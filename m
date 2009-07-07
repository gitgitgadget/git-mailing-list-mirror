From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: Fix branch detection when repository root
	is inaccessible
Date: Tue, 7 Jul 2009 00:05:59 -0700
Message-ID: <20090707070559.GA13684@dcvr.yhbt.net>
References: <1246794706.4818.33.camel@kea> <20090706212742.GA8219@dcvr.yhbt.net> <1246919293.4618.12.camel@kea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mattias Nissler <mattias.nissler@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 09:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO4lB-0005ca-9j
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 09:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZGGHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 03:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZGGHF6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 03:05:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55744 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbZGGHF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 03:05:58 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 27E371F4E8;
	Tue,  7 Jul 2009 07:06:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1246919293.4618.12.camel@kea>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122825>

Mattias Nissler <mattias.nissler@gmx.de> wrote:
> Hi Eric,
> 
> On Mon, 2009-07-06 at 14:27 -0700, Eric Wong wrote:
> > Fixing the minimize logic is definitely a wanted improvement I haven't
> > been able to fix myself.  Unfortunately, your patch breaks the
> > t9138-git-svn-multiple-branches.sh test for me.  
> 
> I see the same here, not sure why I've missed it before. I've had a look
> at the problem and found that the test is actually depending on the
> minimizing logic, i.e. needs to specify -d project1/<tag-or-branch-dir>
> for the tag or branch destination where the project1 prefix is due to
> the minimization at clone time. Dropping the project1 part makes the
> test succeed. I'll simply update the test to do so.
> 
> I also think this is much better from a usability point of view since
> you can now use the original branch or tag dir you've given to clone in
> order to specify the branch or tag destination.

OK.  I was slightly concerned about potential breakage but I guess
existing imports will continue to work fine, so I suppose it's
alright...

> > I haven't looked at it
> > at all, but I'll try to take a look at it later today after I process other
> > things in my overflowing work queue; but I definitely want access issues
> > fixed for people with restrictive repo setups.
> > 
> > One thing I would do is to split out the making of dup_changed_paths()
> > the default behavior into a separate patch.  I think this is a good
> > change since it makes things less surprising for future hackers of
> > git svn.
> 
> Ok, will do so. I'll send updated patches in reply to this mail.

Thanks again Mattias.  Acked and pushed out with minor formatting fixes
to git://git.bogomips.org/git-svn along with Yann's documentation
patches.

> Finally, a big thanks for the nice job on git-svn. I've just experienced
> lots of trouble with the mercurial SVN integration and it's really a
> pain in the ass even to just get a simple clean rebase done properly.
> git-svn is really way more mature and it's a pleasure to use it for
> everyday work.

No problem :)

-- 
Eric Wong
