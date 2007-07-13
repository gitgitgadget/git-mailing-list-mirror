From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Volume of commits
Date: Fri, 13 Jul 2007 12:30:25 +0200
Message-ID: <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
 <20070712132937.GQ19386@genesis.frugalware.org>
 <Pine.LNX.4.64.0707121451290.4516@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: VMiklos <vmiklos@frugalware.org>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 13 12:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9IQU-0005mG-20
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 12:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbXGMKa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 06:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbXGMKa3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 06:30:29 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:53939 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbXGMKa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 06:30:27 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL40092R56QGN@smtp19.wxs.nl> for git@vger.kernel.org; Fri,
 13 Jul 2007 12:30:26 +0200 (CEST)
Received: (qmail 26687 invoked by uid 500); Fri, 13 Jul 2007 10:30:25 +0000
In-reply-to: <Pine.LNX.4.64.0707121451290.4516@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52381>

On Thu, Jul 12, 2007 at 02:59:53PM +0100, Johannes Schindelin wrote:
> In this case, "messy history" means that there are tiny patches which are 
> often in the wrong order, or should be squashed into one commit.  "git 
> rebase -i upstream" presents you with the list of A - HEAD, and you can 
> reorder the patches.  If you want to, you can combine ("squash") some 
> into one commit, or you can skip it, by removing the corresponding line.

If I squash a whole series of commits, how do I prevent git-rebase -i
from firing up an editor after every single commit in the series?

Also, if I do the following:

bash-3.00$ git init
Initialized empty Git repository in .git/
bash-3.00$ for i in a b c; do touch $i; git add $i; git commit -m $i -a; done
Created initial commit 19a8485: a
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
Created commit 4a00f85: b
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 b
Created commit defe3b5: c
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 c
bash-3.00$ git rebase -i  HEAD~2

and then replace the second "pick" by "squash", then I get presented
a commit message that contains the commit message of "c" twice and
after the rebase there are still three commits in the history.
This is with git version 1.5.3.rc1.10.gae1ae
(on top of v1.5.3-rc1-4-gaf83bed).

skimo
