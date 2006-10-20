From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Fri, 20 Oct 2006 16:35:47 -0700
Message-ID: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 01:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3u4-0002Gi-MJ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWJTXft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJTXft
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:35:49 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2773 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161087AbWJTXfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 19:35:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020233547.OWEJ28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 19:35:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cnbY1V00Y1kojtg0000000
	Fri, 20 Oct 2006 19:35:33 -0400
To: git@vger.kernel.org
In-Reply-To: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Oct 2006 16:53:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29557>

Junio C Hamano <junkio@cox.net> writes:

>  - git-diff paginates its output to the tty by default.  If this
>    irritates you, using LESS=RF might help.

I am considering the following to address irritation some people
(including me, actually) are experiencing with this change when
viewing a small (or no) diff.  Any objections?

diff --git a/pager.c b/pager.c
index dcb398d..8bd33a1 100644
--- a/pager.c
+++ b/pager.c
@@ -50,7 +50,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "-RS", 0);
+	setenv("LESS", "FRS", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
