From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 00:32:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
References: <20050423205847.7758bfaa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:28:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYiP-00067X-2s
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVDXEcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVDXEcP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:32:15 -0400
Received: from iabervon.org ([66.92.72.58]:58372 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262202AbVDXEcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 00:32:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPYn0-0000vI-00; Sun, 24 Apr 2005 00:32:14 -0400
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050423205847.7758bfaa.pj@sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Paul Jackson wrote:

> I'm missing something here (well, missing alot, but ...).
> 
> What are the exact steps, given that I have an empty chunk
> of diskspace, to get Linux 2.6.12-rc3 to appear there, using
> git.
> 
> Actually, I got part way.  Perhaps someone can complete
> the following:
> 
>     mkdir git
>     cd git
>     curl -O ftp://ftp.kernel.org/pub/software/scm/cogito/git-pasky-0.6.3.tar.bz2
>     tar xvfj git-pasky-0.6.3.tar.bz2
>     cd git-pasky-0.6.3
>     ls -l /usr/local/include/openssl/sha.h	 # yup - I have openssl header
>     make
>     ./git init rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
>     make install
>     git addremote pasky rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
>     git pull pasky

You might need a "git seek" or a "git cancel" or a "git track
pasky" here; make sure that VERSION is 0.7.

Then do make install again (to install the 0.7 version that you just got).

Then you want to go into the directory you want linux in:

  cd ..
  mkdir linux
  cd linux

And get a version of Linux:

  git init linus rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

(IIRC; I've only really worked on git with git)

If you do another addremote in the git directory, it will think that both
remote repositories are for different versions of the same project, and it
will be unhappy with the fact that they are completely unrelated.

	-Daniel
*This .sig left intentionally blank*

