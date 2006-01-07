From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] git-status: use ls-files --others --directory for untracked list.
Date: Sat, 07 Jan 2006 14:32:07 -0800
Message-ID: <7vslrzacuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 07 23:32:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvMbd-0000gY-9E
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 23:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbWAGWcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 17:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbWAGWcK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 17:32:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7661 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1752589AbWAGWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 17:32:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107223119.ZUAX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 17:31:19 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14282>

This shortens "Untracked files" list by using --directory option
when running ls-files --others.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-status.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

6bb87e11a937bbaab78c589fb82ff3a84a0597b8
diff --git a/git-status.sh b/git-status.sh
index 50ccd24..10d781c 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -83,11 +83,11 @@ report "Changed but not updated" "use gi
 
 if test -f "$GIT_DIR/info/exclude"
 then
-    git-ls-files -z --others \
+    git-ls-files -z --others --directory \
 	--exclude-from="$GIT_DIR/info/exclude" \
         --exclude-per-directory=.gitignore
 else
-    git-ls-files -z --others \
+    git-ls-files -z --others --directory \
         --exclude-per-directory=.gitignore
 fi |
 perl -e '$/ = "\0";
-- 
1.0.7-g0263
