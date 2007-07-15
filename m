From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: finding the right remote branch for a commit
Date: Mon, 16 Jul 2007 00:48:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160036160.14781@racer.site>
References: <20070710144907.GA324@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0707112226170.4516@racer.site> <20070715223341.GA3797@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADpI-0005Tf-DS
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759753AbXGOXsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758402AbXGOXsY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:48:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:50960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763421AbXGOXsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:48:23 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:48:21 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp050) with SMTP; 16 Jul 2007 01:48:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//2NgIqN7/uN9eVfnfeVuVp2ify/BRhNewhAL29S
	uccmPRjf1kLdJ3
X-X-Sender: gene099@racer.site
In-Reply-To: <20070715223341.GA3797@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52609>

Hi,

you left enough hints to convince me that you will not fix the bugs.  
So I will bite the bullet, and find some time this week to fix the issues.

Junio, I'd really appreciated if you considered waiting with 1.5.3 (maybe 
do an -rc2?) before these bugs are squashed.

On Mon, 16 Jul 2007, Matthias Lederhofer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > In practice, and I consider these all bugs, it does not work:
> > 
> > - you have to say
> > 
> >   $ git --work-tree=$HOME --bare init
> > 
> >   which is a bit counterintuitive.  After all, it is _not_ a bare 
> >   repository.  The whole purpose of worktree, as far as I understand, is 
> >   to have a _detached_ repository, which would otherwise be called bare.
> 
> Use
> 
>     $ git --work-tree "$HOME" --git-dir . init
> 
> instead.

Why _should_ that be necessary at all?  I _already_ told git that the 
working tree is somewhere else.  It makes _no sense at all_ to treat the 
cwd as anything else than the GIT_DIR, when --work-tree but no --git-dir 
were specified.

> IMHO the --bare flag did not make much sense before the introduction
> of GIT_WORK_TREE and doesn't after, at least not with the meaning it
> has: why should 'git --bare' mean to use the repository from cwd?

To the contrary, it makes tons of sense.  If you want to initialise a bare 
repository, what _more_ natural way than to say "git init --bare"?  And 
what _more_ natural place to pick for GIT_DIR than the cwd, when you did 
not specify --git-dir?

> > [descriptions of bugs, that have been largely ignored]
>
> Up to now you are supposed to be in the working tree all the time when 
> using it.  Therefore I'd call these feature requests rather than bugs :)

Feature requests? WTF? What reason is there for the _requirement_ to 
specify a working tree, when git does not make use of it?  Hmm?

Ciao,
Dscho
