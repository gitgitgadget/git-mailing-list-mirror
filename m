From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:53:37 -0400
Message-ID: <E1IhlvV-0002qv-1K@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org> <Pine.LNX.4.64.0710161324490.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: ae@op5.se, barkalow@iabervon.org, raa.lkml@gmail.com,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihlvh-0007sm-K0
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXJPMxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758000AbXJPMxi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:53:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36823 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbXJPMxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:53:38 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhlvV-0002qv-1K; Tue, 16 Oct 2007 08:53:37 -0400
In-reply-to: <Pine.LNX.4.64.0710161324490.25221@racer.site> (message from
	Johannes Schindelin on Tue, 16 Oct 2007 13:29:41 +0100 (BST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61158>

> Date: Tue, 16 Oct 2007 13:29:41 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Andreas Ericsson <ae@op5.se>, barkalow@iabervon.org, raa.lkml@gmail.com, 
>     tsuna@lrde.epita.fr, git@vger.kernel.org
> 
> > > 	removed: README
> > > 	untracked: readme
> > 
> > This is a non-issue, then: Windows filesystems are case-preserving, so 
> > if `README' became `readme', someone deliberately renamed it, in which 
> > case it's okay for git to react as above.
> 
> No, it is not.  On FAT filesystems, for example, I experienced Windows 
> happily naming a file "head" which was created under then name "HEAD".

What program did that, and how did you see that the file was named
"head" instead of "HEAD"?  (The latter question is because Explorer,
for example, does not show the file names exactly like they are
written in the directory, it capitalises them.  But this is
application-level code; in the directory the file names are written
like you gave them in the argument to whatever "create file" API you
used.

> No.  It can also be the output of a program which deletes the file first, 
> and then (since the filesystem is so "conveniently" case insensitive) 
> creates it again, with a lowercase filename.
> 
> And don't you tell me that there are no such programs.  I have to use 
> them, and they are closed source.

Can you name them?

> > Something for Windows users to decide, I guess.  It's not hard to 
> > refactor this, it just needs a motivated volunteer.
> 
> You?

Maybe some day.

> > Unless that 10K is a typo and you really meant 100K, I don't think 10K
> > files should take several seconds to scan on Windows.  I just tried
> > "find -print" on a directory with 32K files in 4K subdirectories, and
> > it took 8 sec elapsed with a hot cache.  So 10K files should take at
> > most 2 seconds, even without optimizing file traversal code.  Doing
> > the same with native Windows system calls ("dir /s") brings that down
> > to 4 seconds for 32K files.
> 
> On Linux, I would have hit Control-C already.  Such an operation typically 
> takes less than 0.1 seconds.

We were not comparing Linux with Windows, we were talking about
Windows user experience.  On Windows 4 seconds is not too long.
