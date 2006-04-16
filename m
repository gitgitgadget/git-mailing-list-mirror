From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken
Date: Mon, 17 Apr 2006 01:49:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604170138470.824@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161052310.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604162006050.19560@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161117360.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 01:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVGzV-0000Ke-KA
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 01:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDPXtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWDPXtO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 19:49:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:9959 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750854AbWDPXtN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 19:49:13 -0400
Received: (qmail invoked by alias); 16 Apr 2006 23:49:12 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp033) with SMTP; 17 Apr 2006 01:49:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161117360.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18808>

Hi,

On Sun, 16 Apr 2006, Linus Torvalds wrote:

> On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> > 
> > Thanks for all your help, but in this case it was not irrelevant. Because 
> > I *had* the function in my working copy. And I had changed it. So I had to 
> > find out where to move the change.
> 
> Right, but it was irrelevant as far as "top-of-head" was concerned (which 
> is all that "git log" shows you - it doesn't care about your working 
> tree).
> 
> The fact that it _had_ been relevant in the state you used to be at is not 
> something "git log" and friends know or care about.
> 
> Now, I'm not disputing that we might want to make it easier to see what 
> _had_ been relevant at some earlier time. But you'd have to specify that 
> earlier time somehow.

Since quite some time, I wanted to have a way to git-rev-list just the 
revs between commit1 and commit2, i.e. all commits which are ancestors of 
commit2, and which have commit1 as ancestor. With this, my task would have 
been more than simple.

> I assume you had tried to do a "git rebase", and the problem with that 
> is that git rebase really doesn't help you at all when things go wrong, 
> exactly because "rebase" - by design - screws up the history and loses 
> that information for you.

Nope. Was a merge.

> If your problem state had been as a result of a "git merge", you'd 
> actually have had much better tools available to you, exactly because 
> merge doesn't screw up history, so you've got both sides of the merge you 
> can look at (HEAD and MERGE_HEAD, and "git diff --ours" and "--theirs").

That outputs too much. I really wanted to find just the commit which 
removed the function, in order to know where the code was moved to.

ORIG_HEAD would not help, because that commit is not an ancestor.

> [...] In particular, you can do
> 
> 	gitk ORIG_HEAD.. 

... and it will say

	Error: expected integer but got ""
	    while executing
	"clock format $d -format "%Y-%m-%d %H:%M:%S ""
	    (procedure "formatdate" line 2)
	    invoked from within
	"formatdate $date"
	    (procedure "drawcmittext" line 28)
	    invoked from within
	"drawcmittext $id $row $col $rmx"
	    (procedure "drawcmitrow" line 41)
	    invoked from within
	"drawcmitrow $row"
	    (procedure "showstuff" line 35)
	    invoked from within
	"showstuff $canshow"
	    (procedure "layoutmore" line 15)
	    invoked from within
	"layoutmore"
	    (procedure "getcommitlines" line 91)
	    invoked from within
	"getcommitlines file7"

Sorry, I am too tired now to investigate, have been working already to 
long. Tomorrow's another day.

Ciao,
Dscho
