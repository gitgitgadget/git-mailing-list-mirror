From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 09 Apr 2006 12:08:36 -0700
Message-ID: <7v3bgmbm8b.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 21:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSfH7-0008Uc-Vs
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 21:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDITIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDITIi
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 15:08:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40674 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750825AbWDITIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 15:08:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409190837.LYXO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 15:08:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 9 Apr 2006 12:02:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18562>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, on the other hand, the new "git log --diff" should get the revision 
> counting right even if it's _not_ done by the caller.

Not if the user uses --diff-filter and/or --pickaxe, and after
we start omitting the log message part when no diff is output.

> So I'd suggest:
>  - drop git-whatchanged entirely
>  - keep it - for historical reasons - as a internal shorthand, and just 
>    turn it into "git log --diff -cc"
>
> and everybody will be happy (yeah, it will show a few merge commits 
> without diffs, because the diffs end up being uninteresting, but that's 
> _fine_, even if it's not 100% the same thing git-whatchanged used to do)

I tend to agree.  A merge commit touching a path but not
actually changing the contents of the path from parents might be
a significant event.
