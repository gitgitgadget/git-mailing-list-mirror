From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 08 Oct 2005 23:46:49 -0700
Message-ID: <7vmzljkx0m.fsf@assigned-by-dhcp.cox.net>
References: <20051008180023.GC28875@diku.dk>
	<7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
	<20051008213612.GA5794@steel.home>
	<7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 08:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOUxt-0008QL-MP
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 08:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJIGqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 02:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJIGqx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 02:46:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62145 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932227AbVJIGqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 02:46:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051009064635.BBQE11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Oct 2005 02:46:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 8 Oct 2005 19:19:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9860>

Linus Torvalds <torvalds@osdl.org> writes:

> The more interesting issue is how to set the _flag_ that we should do 
> this. We may have to add a config file, and it should be per-repository 
> (ie something like ".git/config" or ".git/info/config"). Or do we just do 
> yet another environment variable?

Per-repository configuration file like .git/info/config sounds
like the way to go.  Long time ago, the core never read any
per-repository nor per-odb configuration file, but after grafts
and then now alternates, we started doing it, and there is no
reason to shy away from having an official configuration file
mechanism.  Maybe recent HTTP related environment variables
could also be folded into it.

While we are at it, we may want to move things around to
consolidate per-repository configuration into a single placek.
Specifically, I have moving .git/remotes/ in mind.
