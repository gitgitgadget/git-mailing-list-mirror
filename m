From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 16 May 2006 20:26:24 -0700
Message-ID: <4973.1147836384@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 05:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgCgI-0006iW-Gu
	for gcvg-git@gmane.org; Wed, 17 May 2006 05:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEQD0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 23:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWEQD0f
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 23:26:35 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:2229 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751211AbWEQD0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 23:26:35 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k4H3QUgH005049;
	Tue, 16 May 2006 20:26:30 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k4H3QOp7005042;
	Tue, 16 May 2006 20:26:29 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20158>

And Linus Torvalds writes:
 - 
 - The complete libification will take some time, and in the meantime, a few 
 - silly C files that hard-code the shell logic is probably much preferable 
 - to using the shell and all the problems that involves (like the whole 
 - problem with quoting arguments - just _gone_ when you do it as a execve() 
 - in a simple C program).

But for recommending and using git on these systems _now_...
Simply translating the shell script into C with execs doesn't
help if you're execing one of the known problems, or if the
script has embedded, non-trivial Perl.  git-clone is the major
blocker; a trivial translation would be a great step but won't 
let people without GNU utilities clone repos.

Plus, alas, Perl modules and Python version drift can be a bit
of a problem on the same semi-pristine (or unmaintained, or
too-stable) systems, so shell isn't the only thing that needs to
go.  And that'll take a good deal of effort.

Note that my code snippets weren't a suggested patch.  I wouldn't
want the easy way out to impede progress on the right thing.

But some local installations may find it much easier to patch git
than to instruct users to change their utilities to match what git
expects, especially if users have old scripts that would break
if they changed their path globally.  Luckily, git makes it really
easy to keep those patches locally...

Jason
