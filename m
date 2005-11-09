From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with template location
Date: Wed, 09 Nov 2005 13:29:32 -0800
Message-ID: <7vr79pbjcz.fsf@assigned-by-dhcp.cox.net>
References: <200511092045.55300.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:33:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZxWr-0006Fb-79
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 22:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVKIVap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 16:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVKIVap
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 16:30:45 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:29673 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1751476AbVKIVao (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 16:30:44 -0500
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id jA9LUgWt016597
	for <git@vger.kernel.org>; Wed, 9 Nov 2005 13:30:43 -0800
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109212845.PYBB29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 16:28:45 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200511092045.55300.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Wed, 9 Nov 2005 20:45:55 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11415>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> I don't know whether this is something that can be fixed at install time, or 
> whether the README should be changed to make it clear that you need the 
> prefix on the first stage of the process as well as the second.

Thanks Alan and Jon.  This seems to be hitting some people so
here is what I plan to push out.

-- >8 -- cut here -- >8 --
Subject: Update INSTALL

Explicitly mention how to install by hand in build-as-user and
install-as-root steps.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 INSTALL |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

applies-to: 132cf7a143b9ed08e69399da6caa0c627d26f181
c44922a7817398d63bb2b46dc599bd05c710e746
diff --git a/INSTALL b/INSTALL
index bbb13f3..06b11e1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -5,10 +5,13 @@ Normally you can just do "make" followed
 will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
 
-	make prefix=/usr install
+	$ make prefix=/usr ;# as yourself
+	# make prefix=/usr install ;# as root
 
-(or prefix=/usr/local, of course).  Some day somebody may send me a RPM
-spec file or something, and you can do "make rpm" or whatever.
+(or prefix=/usr/local, of course).  Just like any program suite
+that uses $prefix, the built results have some paths encoded,
+which are derived from $prefix, so "make all; make prefix=/usr
+install" would not work.
 
 Issues of note:
 
---
0.99.9.GIT
