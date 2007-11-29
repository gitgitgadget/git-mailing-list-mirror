From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: git-svn rebase issues (the commiter gets changed)
Date: Thu, 29 Nov 2007 08:16:32 -0800
Message-ID: <94ccbe710711290816t7a6ba9b1o8f37ecf583305a51@mail.gmail.com>
References: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com>
	 <20071129075205.GB32277@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixm4L-0002Ac-Uo
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 17:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369AbXK2QQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759057AbXK2QQe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 11:16:34 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:32068 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758744AbXK2QQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 11:16:33 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1491490nze
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ySqKDdkVXdHQIgInj4KYjTVTscI8X5M2qleyN2o5QTc=;
        b=K0Hr0CRyUSG4cNIfP5s+yDbzOUkPxhihAPaAF2uPymG2qR29moznCvZktcVFqvT4sPUj5eW1Do/Fj0Dto24DZL00nE9QwxqfL0OAJ/iXPHi+04OiDFKDpZimZAHu+VSznJD3amM1uB2C8D6BacuwZThd1rna4UJjkNlLEbOEYsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=teCFjBAtve6EpVzdm6Ucyiy7pqRUGG1FahNjbrcu2Rr+IEGuaB7OEpdvXFM6JyV9sY8T4cnB+slFndv8UaGZi/v8PA4P90VNizvsVJ6QiKN3OVScdi7vwwgF0Bs3v384hhRNv/JHHs/DVcgiu8EsbRd7zCyVukvCAM0psqQrVZM=
Received: by 10.115.60.1 with SMTP id n1mr156837wak.1196352992200;
        Thu, 29 Nov 2007 08:16:32 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Thu, 29 Nov 2007 08:16:32 -0800 (PST)
In-Reply-To: <20071129075205.GB32277@soma>
Content-Disposition: inline
X-Google-Sender-Auth: cb99a38ebc20cc1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66544>

On Nov 28, 2007 11:52 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Kelvie Wong <kelvie@ieee.org> wrote:
> > When using git-svn rebase (I'm not sure if this happens with a regular
> > rebase as well, I use use git-svn primarily at work), the following
> > oddity happens:
> >
> > kelvie@mudd (working) qt $ git-cat-file commit
> > c27e6207c9078d4225288d55454d6577f0135c16
> > tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
> > parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
> > author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
> > committer cscrimgeour
> > <cscrimgeour@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195691944 +0000
>
> This is strange.  Does this commit end below? or did you truncate
> the git-svn-id: line from this message?
>

This is one of my local commits, not yet commited to the SVN repo.
I've talked on IRC, and it seems I'm not the only one that has this
problem.  I have heard that the committer timestamp of _all_ rebased
local commits gets changed to the last SVN commit (made by someone
else), but the committer doesn't get changed (except in the first
commit rebased after SVN).

> >
> > Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now
> >
> > This is also a reapplication of r39657, which got rolled back.
> >
> > These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
> > Solution), and thus, it does not build without it.
> > <kw>
> > kelvie@mudd (working) qt $ git-cat-file commit
> > 7075991c67c6d409ec2315dfeef6f45dd328485b
> > tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
> > parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
> > author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
> > committer Kelvie Wong <Kelvie.Wong@safe.com> 1195747291 +0000
>
> This commit hasn't made it into SVN, yet, right?  If so, then that's
> alright.
>
> >
> > Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now
> >
> > This is also a reapplication of r39657, which got rolled back.
> >
> > These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
> > Solution), and thus, it does not build without it.
> > <kw>
> >
> >
> > These are both the exact same commit (the tree, parent, and author are
> > equivalent).
> >
> > Sometimes (not always), the committer in a commit changes to be the
> > committer of the parent (svn) commit.  This only happens to the
> > commits whose parent is the SVN commit.  In the above example,
> > cscrimgeour is a SVN user, who obviously could not have changed my
> > code; the proper commit is the one at the bottom.
> >
> > Both of these are the first local commit that I have rebased onto SVN.
>
> Did you get these commits by cherry-picking (or format-patch + am)
> from another SVN branch?  Have these commits been made to SVN already?
>

It's a commit I made directly.

> `gitk --reflog --all' may reveal some answers or clarify
> things for you (assuming you have reflogs enabled in .git/config).
>
> Rebase (all forms of it) *does* rewrite committer info, but how you got
> cscrimgeour in there is very strange to me.
>
> --
> Eric Wong
>

Just did it again this morning, with a clean test branch:

kelvie@mudd (text-edit) qt $ git checkout -b test git-svn
Switched to a new branch "test"
kelvie@mudd (test) qt $ touch test
kelvie@mudd (test) qt $ git add test
kelvie@mudd (test) qt $ git commit -a -m 'Test!'
Created commit 05c4016: Test!
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 apps/qt/test
kelvie@mudd (test) qt $ git-cat-file commit HEAD
tree 867c0aa4c814542f0752b5d4c85fc96ba2279aac
parent 831ffbf25057ed30274d4216269c572cfce12184
author Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800
committer Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800

Test!
kelvie@mudd (test) qt $ git svn rebase
<snip>
HEAD is now at 7319c2a... (svn commit message)
kelvie@mudd (test) qt $ git-cat-file commit HEAD
tree 4edacbd41af76ac243099467b33350887c0fb03d
parent 7319c2a810554aab25a688bcc2b16fc60529b59d
author Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800
committer ogibbins <ogibbins@e2d93294-a71b-0410-9dca-e2ea525a67c9>
1196346907 +0000

Test!
kelvie@mudd (test) qt $ git --version
git version 1.5.3.6.736.gb7f30

And again, the committer of a local commit gets changed.

Now, this part is more interesting:

kelvie@mudd (test) qt $ git checkout working
Switched to branch "working"
kelvie@mudd (working) qt $ git svn rebase
<no fetch, just a checkout and rebase>

And when I cat-file the commit, this time it's preserved.  Wild guess
here (this behaviour seems kind of inconsistent), but it has to do
with the transition between fetch and rebase?  Or is this a bug in
git-rebase somewhere?

-- 
Kelvie Wong
