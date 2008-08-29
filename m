From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-am: Pass the --directory option through to git-apply
Date: Fri, 29 Aug 2008 15:27:50 -0700
Message-ID: <1220048870-97641-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 00:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZCSf-0001HF-VG
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbYH2W1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 18:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbYH2W1w
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 18:27:52 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:53746 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755725AbYH2W1w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2008 18:27:52 -0400
Received: from localhost.localdomain (c-98-207-244-219.hsd1.ca.comcast.net [98.207.244.219])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 8D155EE218;
	Fri, 29 Aug 2008 15:28:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1.207.g020e5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94335>

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/git-am.txt |    1 +
 git-am.sh                |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index b9c6fac..64c8178 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,6 +66,7 @@ default.   You could use `--no-utf8` to override this.
 
 -C<n>::
 -p<n>::
+--directory=<root>::
 	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
diff --git a/git-am.sh b/git-am.sh
index aa60261..7e7a86f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -18,6 +18,7 @@ k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
+directory=      pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
@@ -155,7 +156,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace)
+	--whitespace|--directory)
 		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
-- 
1.6.0.1.207.g020e5.dirty
