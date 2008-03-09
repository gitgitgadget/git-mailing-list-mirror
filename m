From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] bash: Properly quote the GIT_DIR at all times to fix subdirectory paths with spaces
Date: Sat,  8 Mar 2008 22:10:48 -0500
Message-ID: <1205032248-29246-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: szeder@ira.uka.de
X-From: git-owner@vger.kernel.org Sun Mar 09 04:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYBx7-0007bf-KS
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 04:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbYCIDK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 22:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYCIDK5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 22:10:57 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:60633 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750755AbYCIDK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 22:10:56 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 0D195109EAF;
	Sat,  8 Mar 2008 19:10:49 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.487.g1eab2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76630>

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49e6df0..81e40e4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -75,17 +75,17 @@ __git_ps1 ()
 		elif [ -f "$g/.dotest-merge/interactive" ]
 		then
 			r="|REBASE-i"
-			b="$(cat $g/.dotest-merge/head-name)"
+			b="$(cat "$g/.dotest-merge/head-name")"
 		elif [ -d "$g/.dotest-merge" ]
 		then
 			r="|REBASE-m"
-			b="$(cat $g/.dotest-merge/head-name)"
+			b="$(cat "$g/.dotest-merge/head-name")"
 		elif [ -f "$g/MERGE_HEAD" ]
 		then
 			r="|MERGING"
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
-			if [ -f $g/BISECT_LOG ]
+			if [ -f "$g/BISECT_LOG" ]
 			then
 				r="|BISECTING"
 			fi
@@ -93,7 +93,7 @@ __git_ps1 ()
 			then
 				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
 				then
-					b="$(cut -c1-7 $g/HEAD)..."
+					b="$(cut -c1-7 "$g/HEAD")..."
 				fi
 			fi
 		fi
-- 
1.5.4.3.487.g1eab2.dirty

