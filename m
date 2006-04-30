From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 00:08:34 -0700
Message-ID: <7vwtd7zgjx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 09:08:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa62p-0000P3-Um
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 09:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWD3HIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 30 Apr 2006 03:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWD3HIg
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 03:08:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42945 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751014AbWD3HIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 03:08:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430070835.BNNA21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 03:08:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 29 Apr 2006 21:22:49 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19328>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio - I currently have a "push-all" script in each of the repos I=20
> maintain. That has worked, but I'd just rather do something like
>
> 	git push all
>
> instead, and have it pick up the list of URI's from .git/remotes/all.

Makes sense.  I am still somewhat drunk (cacha=E7a -- agua de
beber -- pretty good but strong stuff), so I will look at the
patch tomorrow, but...

> How do you do multi-targeted pushes?

I do not.  At least not that often.  I merge things up, test all
of "master", "maint", "next", and "pu" locally (the Meta/Doit
script, available after checking out "todo" branch in Meta/
subdirectory), then "git push ko-private" to push into ~/git of
the kernel.org machine and do "all branches" test again
(Meta/DoKernelOrg script).  Only after all that passes, I do a
"git push ko" from my local machine to push into the public
area, /pub/scm/git/git.git, of the kernel.org machine.

=46or Solaris and Cygwin testing, only occasionally, I do not push
but pull from the machines at work.  This is because I want to
catch breakage of pull side myself if there is one.

The only time I do multi-target push is just before cutting a
release.  In addition to "git push ko-private" to push into the
primary Opteron machine, I push to "git push ko-old-private" to
push into the i386 machine at kernel.org, "Meta/DoKernelOrg
master" (or "maint") to prepare RPMs for i386 there, and another
"Meta/DoKernelOrg master" (or "maint") on the Opteron to
prepare RPMs for x86-64.  So personally I never felt the need
for a multi-target push.
