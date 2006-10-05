From: Junio C Hamano <junkio@cox.net>
Subject: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Thu, 05 Oct 2006 01:13:15 -0700
Message-ID: <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
	<20061005064817.21552.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Oct 05 10:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVOM8-0004Kt-U1
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 10:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWJEINU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 04:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWJEINU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 04:13:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:425 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751209AbWJEINR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 04:13:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005081316.EIGJ13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 04:13:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WYDJ1V00N1kojtg0000000
	Thu, 05 Oct 2006 04:13:19 -0400
To: git@vger.kernel.org
In-Reply-To: <20061005064817.21552.qmail@web31804.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 4 Oct 2006 23:48:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28347>

It's been a while since we lost git_blame from %actions list.  I
am wondering maybe it's time to remove it, after 1.4.3 happens.

While I was looking at it, I noticed that it would make
git-cvsserver the last in-tree user of git-annotate.  As I
understand it, "git-blame -c" should produce compatible output
to the command, so it might also be a good time to consider
removal of git-annotate as well while updating git-cvsserver to
use git-blame instead of it.

Do people have reason to favor annotate over blame?  To keep
existing people's scripts working I think we should add a small
amount of code to blame.c to default to compatibility mode when
the command is called as git-annotate at least for a while, but
other than that I do not see much issue against scheduling for
annotate's removal.

I am not going to do anything about this right now (the "master"
branch is in freeze-and-stabilize phase), but if people have
issues I overlooked, raise hands now please?
