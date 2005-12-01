From: Tim O'Callaghan <timo@dspsrv.com>
Subject: Re: unexpected EOF?
Date: Thu, 1 Dec 2005 14:49:17 +0100
Message-ID: <20051201134917.GH2188@ELSAMSW37164>
References: <E1EhohG-0001iZ-IB@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 01 14:50:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhooL-0001sb-K4
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 14:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVLANtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 08:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLANtT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 08:49:19 -0500
Received: from ns.dspsrv.com ([193.120.211.34]:16853 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S932188AbVLANtS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 08:49:18 -0500
Received: from [145.36.48.101] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1EhooH-0001Ig-00
	for git@vger.kernel.org; Thu, 01 Dec 2005 13:49:17 +0000
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1EhohG-0001iZ-IB@jdl.com>
User-Agent: mutt-ng/devel-r570 (CYGWIN_NT-5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13057>

On Thu, Dec 01, 2005 at 07:42:02AM -0600, Jon Loeliger wrote:
> 
> I thought I had imagined this last time, but now 
> that it has happened twice, I'm not so sure what
> is going on.  First pull attempt garners an
> unexpected EOF message; immediately pull again
> seems to work.
> 
> Some state:
> 
> jdl@ubuntu:/usr/src/git-core$ git --version
> git version 0.99.9j
> 
> jdl@ubuntu:/usr/src/git-core$ cat .git/remotes/origin
> URL: git://git.kernel.org/pub/scm/git/git.git/
> Pull: master:origin
> Pull: todo:todo
> Pull: maint:maint
> Pull: pu:pu
> 
> And the error capture:
> 
> jdl@ubuntu:/usr/src/git-core$ git pull origin
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git/
> jdl@ubuntu:/usr/src/git-core$ git pull origin
> Unpacking 17 objects
>  100% (17/17) done
> * committish: d175455acaaba6bd39dd2d5ec71961bf238f06d4
>   branch 'todo' of git://git.kernel.org/pub/scm/git/git
> * refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/scm/git/git* committish: 93dcab2937624ebb97f91807576cddb242a55a46
>   branch 'maint' of git://git.kernel.org/pub/scm/git/git
> * refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pub/scm/git/git
> * committish: b34403aa97047f90c0cdd5177e63a8e7530e3388
>   branch 'master' of git://git.kernel.org/pub/scm/git/git
> * refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/git/git
> * committish: 6e35634a4d595d554423b04438bfa8b523414c54
>   branch 'pu' of git://git.kernel.org/pub/scm/git/git
> * refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
>   not updating.
> Already up-to-date.


I noticed this myself this morning. It happened twice, then after leaving it
for a minute or two, it worked. Possibly traffic problems to kernel.org?


I should also report that if a spurious lockfile exists (under cygwin at
least), git just dies with the cryptic "unable to create new cachefile".

Tim.
"I've worked myself up from nothing to a state of supreme poverty."
-- Groucho Marx
