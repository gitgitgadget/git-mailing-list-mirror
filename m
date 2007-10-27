From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for running from a subdirectory with
 GIT_WORK_TREE
Date: Sat, 27 Oct 2007 14:27:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271427020.4362@racer.site>
References: <20071027081954.GA23406@laptop>  <Pine.LNX.4.64.0710271343270.4362@racer.site>
 <fcaeb9bf0710270557n48a01ba2w3a89f65680b946d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-974408957-1193491673=:4362"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 15:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlliU-0006C6-5o
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 15:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbXJ0N2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 09:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbXJ0N23
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 09:28:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbXJ0N22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 09:28:28 -0400
Received: (qmail invoked by alias); 27 Oct 2007 13:28:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 27 Oct 2007 15:28:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FVnM7VplFGi856vaPpXNdWYnmkB/RNKCU//I8ao
	WhVhkiIPFl1vyd
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0710270557n48a01ba2w3a89f65680b946d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62492>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-974408957-1193491673=:4362
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 27 Oct 2007, Nguyen Thai Ngoc Duy wrote:

> On 10/27/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sat, 27 Oct 2007, Nguyễn Thái Ngọc Duy wrote:
> >
> > > +mkdir -p work/sub/dir || exit 1
> > > +mv .git work
> > > +if test "$1" = --normal; then
> > > +     say "Normal case"
> > > +else
> > > +     say "Worktree case"
> > > +fi
> > > +test "$1" = --normal || mv work/.git repo.git || exit 1
> > > +
> > > +test "$1" = --normal || export GIT_DIR=$(pwd)/repo.git
> > > +export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
> > > +test "$1" = --normal || export GIT_WORK_TREE=$(pwd)/work
> > > +
> > > +cd work/sub || exit 1
> >
> > Why don't you put this block into a test_expect_success?  And then just
> > make a
> >
> >         for mode in normal worktree
> >         do
> >
> >         ...
> >
> >         done
> >
> > Hmm?  I would like to see this test case in the official git.git.
> 
> Because after normal iteration, the test repository is no longer in
> clean state that the second iteration needs. Maybe I should just
> create another repo then set parameters properly in test_expect_*

Yes, you can do that:

	test_create_repo other-repo

Another option would be that you clean up at the end of the loop.

Ciao,
Dscho

--8323584-974408957-1193491673=:4362--
