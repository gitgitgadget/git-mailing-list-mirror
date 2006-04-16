From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken (NOT)
Date: Sun, 16 Apr 2006 19:27:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604161911530.18261@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:27:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVB23-0000G8-63
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWDPR1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDPR1Z
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:27:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:29898 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750764AbWDPR1Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:27:24 -0400
Received: (qmail invoked by alias); 16 Apr 2006 17:27:23 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 16 Apr 2006 19:27:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18794>

Hi,

On Sun, 16 Apr 2006, Linus Torvalds wrote:

> On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> > 
> > But you missed my point. The file log-tree.c had some opt handling. I 
> > changed it (as can be seen in my patch for combined diffstat), so the 
> > merge did not go well with next, which removed that code.
> > 
> > So I tried to be clever and find the (non-merge) commit where this 
> > happened. With what you describe, I should have hit *exactly one* commit 
> > removing the code.
> > 
> > But I hit *exactly none* with "git log --cc master log-tree.c".
> 
> Do you have the tree somewhere?

I have no quick way to publish it, if you mean that.

> In the current git tree, there really _is_ just one commit that touches 
> log-tree.c in "master". And "git log log-tree.c" picks that out without 
> trouble.

It is my master. Not Junio's.

The problem seems to be that the current next does not have the code. But 
when I last merged, it had it. So basically, I have a problem here that I 
thought "git log --cc" can solve, but it doesn't.

"git log -cc" is good to find out when code *that is present now* has 
crept in, but it is no good to find out when code that was in commit 
such-and-such, and is no longer in commit such-and-that, has been culled.

Pity.

Thanks for your help,
Dscho
