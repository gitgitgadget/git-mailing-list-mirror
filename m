From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH 1/3] Call extended-semantics commands through variables.
Date: Sat, 11 Feb 2006 15:10:11 -0800
Message-ID: <4230.1139699411@lotus.CS.Berkeley.EDU>
References: <7vwtg2mmx5.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 00:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F83sl-0003yv-0d
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 00:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBKXKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWBKXKP
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 18:10:15 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:50595 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750805AbWBKXKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 18:10:14 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1BNABxZ004232;
	Sat, 11 Feb 2006 15:10:11 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1BNABWc004231;
	Sat, 11 Feb 2006 15:10:11 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vwtg2mmx5.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15965>

And Junio C Hamano writes:
 - The use of FIND or CPIO in git clone does not need -0 (and the
 - code does not use -0, nor your patch adds -0), so you should not
 - have to override them this way.

I'm not sure what's up with cpio, but git causes pkgsrc's 
default cpio to segfault on my Solaris machines.  It's 
easier to point CPIO at a different cpio than debug a 
utility I've never really used.  ;)  I thought it was
git-clone breaking in the tests, but it could have been
git-merge.  I'll check again when I get a chance.

And I worry about using different programs in different 
scripts, so I just changed all of them.

 - (BTW, you got count-objects one wrong; there is a leftover 
 - GIT_FIND there).

Friday afternoon patching, sorry.  That also means either 
that count-objects has no test cases or that branch of it 
is not exercised by tests.

 - The places we _do_ use -0 currently should be converted
 - with something like your patch to use -0 capable version of the
 - tool.

Again, I'm not very comfortable using different finds or 
xargs in different places.  But if you want, I'll re-do the
patch with just those locations changed, and I'll double-
check which cpio invocation is breaking.

 - [...] but nobody should be using rsync transfer anyway,
 - so...

Is there a better way of grabbing all the tags now?  I haven't
kept track, as I haven't had to do that in a while.

Jason
