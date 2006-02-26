From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach the "git" command to handle some commands internally
Date: Sun, 26 Feb 2006 15:10:14 -0800
Message-ID: <7vbqwt7m3t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>,
	Michal Ostrowski <mostrows@watson.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDV23-0002ye-Lo
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWBZXKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBZXKV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:10:21 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3271 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932245AbWBZXKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 18:10:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226230736.OPBL17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 18:07:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 26 Feb 2006 12:34:51 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16803>

Linus Torvalds <torvalds@osdl.org> writes:

> This also implies that to support the old "git-log" and "git-diff" syntax, 
> the "git" wrapper now automatically looks at the name it was executed as, 
> and if it is "git-xxxx", it will assume that it is to internally do what 
> "git xxxx" would do.
>
> In other words, you can (once you implement an internal command) soft- or 
> hard-link that command to the "git" wrapper command, and it will do the 
> right thing, whether you use the "git xxxx" or the "git-xxxx" format.

I like this careful backward compatibility part.

> There's one other change: the search order for external programs is 
> modified slightly, so that the first entry remains GIT_EXEC_DIR, but the 
> second entry is the same directory as the git wrapper itself was executed 
> out of - if we can figure it out from argv[0], of course.

I am not sure about this part, though.
