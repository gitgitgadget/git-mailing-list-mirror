From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Wed, 04 Oct 2006 01:12:23 -0700
Message-ID: <7vsli4jy8o.fsf@assigned-by-dhcp.cox.net>
References: <7virj0lsua.fsf@assigned-by-dhcp.cox.net>
	<20061004024837.4462.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 10:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV1rj-00044a-6a
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 10:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbWJDIM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 04:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbWJDIM1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 04:12:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:28597 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030651AbWJDIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 04:12:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004081224.XXJJ21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Oct 2006 04:12:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W8CS1V00V1kojtg0000000
	Wed, 04 Oct 2006 04:12:27 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061004024837.4462.qmail@web31808.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 3 Oct 2006 19:48:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28322>

Luben Tuikov <ltuikov@yahoo.com> writes:

> It is not that I don't like it.  For example if we didn't have
> the block-per-commit-coloring, then we'd make use of this, but it
> seems that the block-per-commit-coloring exists for the purpose to
> show conglomerations of same-commit lines, thus obviating the need
> to repeat it (commit-8) every so many lines.
>
> The other question is how many lines should the repeat-chunk be?
>
> In my case I'd like to set it to infinity, since the
> block-per-commit-coloring gives me the same information.

Not that I particularly care that deeply, but my intention was:

 (0) having commit-8 on every line was distracting;

 (1) grouping clue comes solely from the zebra shading;
     placement of commit-8 does not have anything to do with the
     grouping.  It was just that the old interface had N
     commit-8 links for a group that consists of N lines.  I
     made it to approximately N/20 links, and you are in favor
     of having 1 link per group.

 (2) commit-8 is the only visually obviously clickable thing to
     get to the commit.  Having them only on the first line in
     the group means for a large group it would scroll off the
     top after reading all the lines in the group through to
     decide it is worth inspecting; think of a case where one
     commit added 80 lines of code and each line is shown in
     14-dot high font on 1024x768 display which would give you
     50 lines or so at most.

View blame output of README from git.git and scoll down to
around line 400 to see what I mean, with an window that is
around 30 lines.  Jon's ASCII art extends for about 40 lines or
so.

Put it another way, it is a redundancy just like the same set of
links people place at the top and the bottom of a page.  It is
redundant in the sense that you can always scroll to either one,
but having closer to the mouse pointer helps accessing them.  It
is different from the other redundancy we love to hate ;-) that
the shortlog page had -- commit link and the clickable commit
title were immediately next to each other and there was no
argument for that redundancy from accessibility point of view
(the argument was purely "is the clickable commit title obvious
enough?").

> The middle ground as it seems to me, neither infinity nor 1, is
> to just use the block-per-commit-coloring and use your idea of printing
> the commit-8 only on the leading block row with mouse-over author
> and date info. That's an excellent idea.*

I am not quite sure what you mean by this.
