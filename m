From: Junio C Hamano <junkio@cox.net>
Subject: Re: git --exec-path conversion
Date: Sat, 19 Nov 2005 04:04:40 -0800
Message-ID: <7vy83k6dyf.fsf@assigned-by-dhcp.cox.net>
References: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 13:05:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdRSX-0001gI-9s
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 13:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVKSMEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 07:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVKSMEm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 07:04:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58773 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751084AbVKSMEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 07:04:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119120326.HNEB17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 07:03:26 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sat, 19 Nov 2005 03:14:44 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12332>

Marco Costalba <mcostalba@yahoo.it> writes:

> if I understood correctly, git programs will be installed
> somewhere in $PATH for at least next two months.

I suspect things will stay in /usr/bin longer than that, but
futureproofing is good in any case.

Assuming you are writing things in C or C++:

 - run "git --exec-path" at the very beginning of main(),
 - read the output, prepend it to $PATH using setenv(3).

and I think you are done.  After this, your QGit::run("ls") and
QGit::run("git frotz") would not be affected (you still have
/usr/bin in your $PATH), and QGIT::run("git-frotz") would find
git-frotz installed somewhere outside /usr/bin.
