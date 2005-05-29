From: Junio C Hamano <junkio@cox.net>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 11:04:44 -0700
Message-ID: <7vekbpq56r.fsf@assigned-by-dhcp.cox.net>
References: <20050529071520.GC1036@pasky.ji.cz>
	<7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
	<20050529120248.GD1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 20:05:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcS7H-0004QU-MV
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVE2SEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVE2SEv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:04:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28594 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261374AbVE2SEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 14:04:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529180444.JNFF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 14:04:44 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529120248.GD1036@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 29 May 2005 14:02:49 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> Like Linus, I do "/^diff --git .*" in my less sessions, which
>> gives a very nice highlighted separator line without wasting a
>> single line on the terminal.  If any of the readers on the list
>> didn't know about this trick (especially the trailing .* part),
>> please try it.  I'm certain everybody would love it.

PB> When I do just cg-diff to see what I changed I usually do not pipe it to
PB> less, and typing that / stuff seems insane (although /^d.* could give a
PB> good approximation).

You said you do not do "less", so the following may not apply to
your usage, but I disagree your comment about "typing that /
stuff seems insane".  Sean's workaround to use "less -p '^diff
--git .*'" in a script, combined with typing 'n' in a "less"
session to find the next such line, would make it very pleasant
to use.

PB> OTOH I think I'll go for the diff output colorification (at
PB> the Cogito level), so the separator indeed isn't strictly
PB> necessary. I can live without it. :-)

When I want to make a customized diff output out of the "diff-*
-p' command, I find it a lot easier to use the GIT_EXTERNAL_DIFF
mechanism than parsing what comes out of "diff-* -p" and munging
it.  I am not _telling_, _ordering_, nor even _asking_ you to
use GIT_EXTERNAL_DIFF; just suggesting you to consider that as a
way to possibly make your implementation easier.  I'd start from
the supplied git-external-diff-script and go from there.

