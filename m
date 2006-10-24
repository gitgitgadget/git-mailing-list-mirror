From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing vs. alternates
Date: Mon, 23 Oct 2006 22:29:45 -0700
Message-ID: <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
References: <20061024035335.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 07:30:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcErN-000860-6f
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 07:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWJXF3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 01:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWJXF3r
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 01:29:47 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:33534 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752003AbWJXF3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 01:29:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024052946.PTIB12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 01:29:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e5Vp1V00d1kojtg0000000
	Tue, 24 Oct 2006 01:29:50 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20061024035335.GW20017@pasky.or.cz> (Petr Baudis's message of
	"Tue, 24 Oct 2006 05:53:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29923>

Petr Baudis <pasky@ucw.cz> writes:

>   I don't have time to code that myself right now, so I'm just tossing
> an idea around - pushing to a directory with alternates set up should
> avoid sending objects that are already in the alternate object database.

That is probably only relevant for the first time, since
subsequent pushes have refs from its own repository that tracks
the tips of branches that was pushed for the last time.

And first time usage when you are initializing the repository
with alternates, you have direct access to that repository
(that's how you can set up alternates), you can as easily do the
initial fetch/clone as well at that time.

So it might be a nice addition but I suspect it would not matter
much in practice.
