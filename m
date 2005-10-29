From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH] Add usage statement to git-checkout.sh
Date: Sat, 29 Oct 2005 17:46:41 -0400
Message-ID: <11306224011899-git-send-email-c.shoemaker@cox.net>
Reply-To: Chris Shoemaker <c.shoemaker@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 29 23:47:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVyXS-0008II-MA
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 23:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVJ2Vqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVJ2Vqn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 17:46:43 -0400
Received: from eastrmmtao03.cox.net ([68.230.240.36]:21754 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932206AbVJ2Vqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 17:46:42 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029214600.TMYV2767.eastrmmtao03.cox.net@localhost>;
          Sat, 29 Oct 2005 17:46:00 -0400
Received: from [127.0.0.1] (helo=pe)
	by localhost with smtp (Exim 4.43)
	id 1EVyXB-0006WV-A5; Sat, 29 Oct 2005 17:46:41 -0400
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10808>

Signed-off-by: Chris Shoemaker <c.shoemaker@cox.net>

---

 git-checkout.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

2fcbb6e58c0902e19373305b7ea77234f5d3ffba
diff --git a/git-checkout.sh b/git-checkout.sh
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 . git-sh-setup || die "Not a git archive"
 
+usage () {
+    die "usage: git checkout [-f] [-b <new_branch>] [<branch>] [<paths>...]"
+}
+
 old=$(git-rev-parse HEAD)
 new=
 force=
@@ -26,6 +30,9 @@ while [ "$#" != "0" ]; do
 	--)
 		break
 		;;
+	-*)
+		usage
+		;;
 	*)
 		if rev=$(git-rev-parse --verify "$arg^0" 2>/dev/null)
 		then
