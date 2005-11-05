From: Linus Torvalds <torvalds@osdl.org>
Subject: git binary directory?
Date: Sat, 5 Nov 2005 13:02:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Nov 05 22:04:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYVBs-0005q4-4o
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 22:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKEVCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 16:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVKEVCb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 16:02:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751006AbVKEVCa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 16:02:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA5L2PnO029861
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Nov 2005 13:02:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA5L2N0a031726;
	Sat, 5 Nov 2005 13:02:24 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11184>


Just for fun, I did "git-<tab><tab>" a moment ago, and it asked me

	Display all 171 possibilities? (y or n)

which was a bit scary. Now, part of that was because I hadn't cleaned up 
the old git names, so I removed everything, and did a clean "make install" 
with the current git tree. At which point the question became

	Display all 105 possibilities? (y or n)

and pressing "y" shows a really nice list of programs.

Now, this is actually very convenient, and since I tend to install things 
in my own ~/bin directory, it's all good. What's a hundred files more or 
less?

However, doing a "ls /usr/bin/ | wc" shows that on my laptop /usr/bin is 
already 2583 files, and git is actually part of the problem there (hey, 
it's got the git RPM installed - it's not my main machine)..

Now, I happen to think that 2500+ files in /usr/bin is a bit much (ever 
try to use the horrid gnome executable finder on it when you want to 
convince firefox to use xpdf instead of that broken crap called "evince"? 
Takes absolutely ages and is horrible).

And git made it about 4% worse all on its own.

So I'd really suggest that while the "git-<tab><tab>" thing is perhaps 
useful, we'd actually be better off with an /usr/lib/git directory where 
we put the git executables by default. And just put "git" into /usr/bin.

That way, people who _want_ to use "git-<tab><tab>" can just add the git 
binary directory to their path and directly access all of them. And others 
can just use the plain "git" interface.

That would mean that I'd have to learn to use "git whatchanged" and "git 
diff-tree" instead of "git-whatchanged" and "git-diff-tree", but hey, it's 
why we have that "git" script in the first place.

What do people think?

			Linus
