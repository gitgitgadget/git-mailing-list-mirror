From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 08:18:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-822297470-1130775150=:27915"
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:20:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWcN8-0000BP-SA
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 17:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVJaQSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJaQSz
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 11:18:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932441AbVJaQSy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 11:18:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VGKTsC019266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 08:20:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VGInnN012995;
	Mon, 31 Oct 2005 08:18:50 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
Content-ID: <Pine.LNX.4.64.0510310812440.27915@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10863>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-822297470-1130775150=:27915
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0510310812441.27915@g5.osdl.org>



On Mon, 31 Oct 2005, Johannes Schindelin wrote:
> 
> How about adding the whole explanation as
> 
> 	git/Documentation/howto/tell-why-cvs-sucks.txt
> 
> (maybe with some more polite name)?

Hey, if somebody else does it, that's fine.

I'm personally _so_ biased against CVS that I'm not neutral. I really hate 
the thing. I'd much rather use tar-balls and patches than CVS: I think 
"quilt" ends up being much nicer in many ways than CVS can be.

So feel free to take my explanations and write something up. I just don't 
want to do it, because I fear I might be unfair to CVS (well.. I'm 
personally 120% convinced I'm not, but still, there's a lot of people who 
actually _use_ it, so..).

> Also, I´d like to add that CVS branching/merging is no good:
> 
> <tryingtoputonalbertsshoes>
> 
> Sometimes a developer gets an idea, or the need, to implement a certain 
> feature to a piece of free software. Now, this idea might seem good, but 
> it might take a while to
> 
> 	- implement it,
> 	- flesh the bugs out, and
> 	- maybe realize the idea was not all that good.

[ details deleted ]

Yes. I consider this to be part of the centralized/distributed issue, but 
it's worth talking about. A distributed system automatically implies that 
you can have "throw-away branches" for testing, and you can combine two or 
more of these test-branches without ever disturbing (or even _notifying_) 
the "real development" branch.

In a centralized system, any branches will always be in that central 
repository, so you can't do throw-away stuff without affecting everybody 
else. Maybe the actual _code_ won't be in the "real development" branch, 
but you're writing and affecting the same repository where the development 
happens.

Again, you could replicate the whole repo, and do things there, but then 
you can't ever merge again, which in effect makes the small branch a big 
fork. So in that sense the CVS/SVN mentality basically encourages forking 
and discourages working together. This is more of the same thing that I 
alluded to when saying that CVS inevitably leads to "politics" - having a 
central place means that you have people who fight for control over it, 
even when they'd otherwise _want_ to cooperate.

With git (or with BK, or any truly decentralized model), you just make 
your own repo, do your development there, and you never need to ask for 
permissions from the central repo people. If the development works out, 
you just ask people to merge back. And if it doesn't, you don't even have 
to tell people what a total failure you were.

So with the distributed model, you don't have to publicly humiliate 
yourself when you do something stupid. Similarly, you don't have to 
publicly prove that you're "good enough" before you can play in the 
sandbox. In other words, there's no need for politics and egos.

(Now, obviously, when you've actually done the work, if people recognize 
that you're a mental giant, they'll be more likely to merge with you, and 
you'll generally have an easier time. So I'm not saying that a distributed 
model takes away the need for showing how good you are, but it doesn't 
make that a central pre-conception).

			Linus
--21872808-822297470-1130775150=:27915--
