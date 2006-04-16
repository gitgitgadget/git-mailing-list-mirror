From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 20:09:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604162006050.19560@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 20:09:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBgi-0006GB-Gw
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 20:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDPSJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDPSJ3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 14:09:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:47586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750779AbWDPSJ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 14:09:29 -0400
Received: (qmail invoked by alias); 16 Apr 2006 18:09:27 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp017) with SMTP; 16 Apr 2006 20:09:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18799>

Hi,

On Sun, 16 Apr 2006, Linus Torvalds wrote:

> On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> > 
> > I finally found the commit which removed parse_whatchanged_opt() from 
> > log-tree.c by
> > 
> > 	git-rev-list 4a617..next | while read commit; do \
> > 		echo $commit; \
> > 		git diff $commit^..$commit log-tree.c | \
> > 			grep parse_whatchanged; \
> > 	done | less
> 
> Heh. You really should learn about "-m -p", which does the above, but 
> better (it compares against _all_ parents - you would have missed the 
> thing _again_ if the "lt/logopt" branch had been the main branch ;)

Somehow I forgot. Probably because I don't like the format either.

> [...] even
> 
> 	git show -c 43f934aa90
> 
> won't show that "log-tree.c" file AT ALL, because there was no content 
> conflict: the whole file was taken from one branch, unmodified. 

There's another reason it does not show it. ATM, you have to add "-p" to 
the command line, or "-c" will not show *any* patch, let alone a combined 
one.

> So "--cc" really does ignore everything that is irrelevant for the end 
> result, and in this case you are very much trying to find somethign that 
> is totally irrelevant for the end result, since the function you look for 
> had never even _existed_ in the file as far as the end result goes..

Thanks for all your help, but in this case it was not irrelevant. Because 
I *had* the function in my working copy. And I had changed it. So I had to 
find out where to move the change.

Again, thanks a bunch,
Dscho
