From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git status: ignore empty directories (because they cannot be added)
Date: Tue, 23 May 2006 16:00:55 +0200
Message-ID: <E1FiXRP-0006lG-5Z@moooo.ath.cx>
References: <E1FiHXS-0008MC-LB@moooo.ath.cx> <7vu07h8rzr.fsf@assigned-by-dhcp.cox.net> <E1FiPIu-0003cJ-03@moooo.ath.cx> <7vd5e56yi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 16:01:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiXRd-00073P-A3
	for gcvg-git@gmane.org; Tue, 23 May 2006 16:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWEWOA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 10:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWEWOA7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 10:00:59 -0400
Received: from moooo.ath.cx ([85.116.203.178]:52429 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750811AbWEWOA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 10:00:58 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd5e56yi6.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20605>

> > Well, anyway, here the reasons for this patch:
> > - Working in a git repository with a lot of empty directories is
> >   annoying, because all of them show up in git status even though they
> >   cannot be added. With --no-empty-directories they are hidden.
> 
> What directories are they?  Will they some day have files that
> you might want to keep track of?  The reason for this question
> is, "otherwise you could .gitignore them".

I have been trying ruby on rails and there are some empty directories
which will have files later. I would even add those empty directories
if it would be possible.

> > - If there is a directory which may be added because it is quite
> >   useful to have the -u option to see what is in there to add (without
> >   using ls path/to/directory).
> 
> It really depends on how many files there are in such a
> "interesting" directory _and_ other "uninteresting" directories
> full of transitory files.  The -u option that disables "skip
> contents and show only the top directory" behaviour globally
> might not be so useful in such a case -- you will see useful
> contents of an otherwise "closed" directory (because it defeats
> the --directory flag), but at the same time you would get tons
> of uninteresting files in another directory as well in such a
> case.  You are likely to end up doing ls path/to/dir after
> noticing that there are non-empty foo/ and bar/ directories that
> have no tracked files, and you know which one has files
> interesting to you.
> So I am OK with the change, but I am somewhat still doubtful how
> useful the option would be.

The case I think about is that there are some directories which are
not tracked because they contain no files yet. All other directories
which are uninteresting are added to .gitignore. If an untracked
directory shows up in git-status one could easily check with
git-status -u what can be added.

PS: I had a typo in the git mailing list e-mail address and resent my
last e-mail to the list. Your reply did not make it to the list,
perhaps you can send it again.
