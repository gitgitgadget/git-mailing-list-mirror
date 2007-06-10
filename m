From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn set-tree bug
Date: Mon, 11 Jun 2007 01:27:09 +0200
Message-ID: <002a01c7abb6$de2b3680$0e67a8c0@Jocke>
References: <20070610213322.GB12222@muzzle>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWov-0004uI-Rv
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbXFJX1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759556AbXFJX1c
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:27:32 -0400
Received: from mail.transmode.se ([83.241.175.147]:63518 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759249AbXFJX1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:27:31 -0400
Received: from Jocke ([84.217.92.176]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 11 Jun 2007 01:27:26 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20070610213322.GB12222@muzzle>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AcerpvqPIbxG/yZHT1yR4771VLUYwwADmaHg
X-OriginalArrivalTime: 10 Jun 2007 23:27:26.0585 (UTC) FILETIME=[E7DE4690:01C7ABB6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49790>

 

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Sent: den 10 juni 2007 23:33
> To: Joakim Tjernlund
> Cc: git
> Subject: Re: git-svn set-tree bug
> 
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > On Sat, 2007-06-09 at 18:47 -0700, Eric Wong wrote:
> > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > trying to do git-svn set-tree remotes/trunk..svn
> > > > in my new git-svn repo I get:
> > > > config --get svn-remote.svn.fetch 
> :refs/remotes/git-svn$: command returned error: 1
> > > 
> > > You need to specify "-i trunk" in the command-line
> > > 
> > > git-svn set-tree -i trunk remotes/trunk..svn
> > > 
> > 
> > Thanks
> > 
> > I have found a bug or two. Run this script and
> > see what happens ant the end.
> 
> <snip>
> 
> > git pull . merge
> 
> This is a non-fast-forward merge, giving you non-linear history.  git
> understands non-linear history without problems, but svn does not.
> 
> > git svn dcommit  # this fails 
> 
> If you have non-linear history, don't use dcommit, use 
> set-tree.  Linear
> history is cleaner and easier to manage, which is why I recommend
> format-patch/am/dcommit/rebase, and avoid using pull/merge unless it's
> fast-forward.

I see, I figured git-svn could work around that.
So I should do a git svn set-tree -i trunk remotes/trunk..svn
and then git svn rebase? That makes the git history hard to
follow.
hmm, is it wise to mix set-tree and dcommit in one repo?
Is there a way to tell set-tree to commit the whole "merge" branch
as one svn commit?
If I merge the latest kernel into my tree there will
be a lot of commits that I don't want in svn.

 Jocke


   Jocke
