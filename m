From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: git-svn seems confused about current HEAD
Date: Fri, 03 Jul 2009 11:43:05 -0600
Message-ID: <auto-000019869879@sci.utah.edu>
References: <auto-000019790488@sci.utah.edu>  <20090702075438.GA11119@dcvr.yhbt.net>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 19:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMmn0-00049w-6F
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 19:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbZGCRm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755596AbZGCRm6
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 13:42:58 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:39941 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755549AbZGCRm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 13:42:57 -0400
Received: from dummy.name; Fri, 03 Jul 2009 11:42:59 -0600
In-Reply-To: Your message of "Thu, 02 Jul 2009 00:54:38 PDT."
             <20090702075438.GA11119@dcvr.yhbt.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122704>

Hi all, just wanted to ACK and confirm that the recommended actions
were sound.

Eric Wong <normalperson@yhbt.net> writes:
> tom fogal <tfogal@alumni.unh.edu> wrote:
> > I've got a repository that git-svn won't grab the most recent commits
> > for:
> > 
> >   tf@shigeru tuvok ~/sw/bin/git svn find-rev HEAD
> >   1164
> >   tf@shigeru tuvok ~/sw/bin/git svn fetch
> >   tf@shigeru tuvok ~/sw/bin/git --version
> >   git version 1.6.3.3
> > 
> > The repository is actually at revision 1184.
> >
> > Interestingly, 1165 is also a commit which contains a string which
> > is not representable in 8bit ASCII in the commit log.
> 
> Wow, "svn log" seems to croak on 1165, too.  How did you manage that?  I
> guess SVN servers don't check for UTF-8 validity at all in the
> commits...

*shrug*, I just copy-and-pasted a contributor's name into the log.  I
think in the future, I'll leave their names in the code instead of the
log :)

> I would get your SVN administrator to propedit the r1165 log entry
> so people can see it in the future.  Basically git svn relies on the
> library version of "svn log", so if "svn log" fails, then git svn
> usually has no chance of getting those revisions.

I think Eric was referring to `svnadmin setlog' here.  We've done that
and everything seems to be working well.

I'm slightly worried that I've rewritten history behind git's back
-- I'm likening it to rebasing an upstream after pulling from it --
but everything seems okay so far without any gymnastics downstream.
Perhaps it's not an issue because only a log message, and not actual
code, has changed. *shrug*, for my case, re-cloning wouldn't be a
disaster anyway.

> > Is there a known workaround for this issue (or, how did I manage to
> > `ignore' those commits in my initial repo)?
> 
> Here's what I did when the initial clone got stuck at 1164:
[snip]

Thanks much for the help!

-tom
