From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 15:47:53 -0700
Message-ID: <7v64ruo31i.fsf@assigned-by-dhcp.cox.net>
References: <435560F7.4080006@zytor.com>
	<Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 00:49:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES0FV-0005BH-Dx
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 00:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVJRWr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 18:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJRWr4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 18:47:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12190 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932196AbVJRWrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 18:47:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018224731.TASN29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 18:47:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Oct 2005 15:25:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10239>

Linus Torvalds <torvalds@osdl.org> writes:

> 	git pull git://host/home/linux-2.6
>
> will on the remote end do:
>
> 	chdir("/home/linux-2.6")	// fails with ENOENT
> 	chdir("/home/linux-2.6.git")	// works
> 	chdir(".git")			// works
>
> resulting in it ending up in /home/linux-2.6.git/.git, which is exactly 
> correct, and where it wants to be.
>
> I personally find it a nice bit of usability enhancement. You can name 
> your git repositories with a ".git" suffix (which can help all kinds of 
> automated tasks - like autopacking), but you don't force your users to 
> care.

Wouldn't having /home/linux-2.6/.git/ repository with
/home/linux-2.6/ working tree be good enough for that?  Instead
of doing "find / -type d -name '*.git'" you could do "find /
-type d -name .git" for automated tasks.
