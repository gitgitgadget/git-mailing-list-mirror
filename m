From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [RFC PATCH 2/2] wt-status: Teach how to discard changes in the working directory
Date: Mon,  8 Sep 2008 00:05:03 +0200
Message-ID: <1220825103-19599-3-git-send-email-mail@cup.kalibalik.dk>
References: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
 <1220825103-19599-2-git-send-email-mail@cup.kalibalik.dk>
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 00:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcSOd-0007gh-1R
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYIGWFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYIGWFJ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:05:09 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:33297 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbYIGWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:05:06 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 510A414078;
	Mon,  8 Sep 2008 00:05:07 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0CB7C14068;
	Mon,  8 Sep 2008 00:05:07 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.dirty
In-Reply-To: <1220825103-19599-2-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95182>

This is a question that comes up a lot in #git.
---
 t/t7502-status.sh |   10 ++++++++++
 wt-status.c       |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ceb3a1e..5bc3e36 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -80,6 +80,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	} else {
 		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
 	}
+	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
 	color_fprintf_ln(s->fp, c, "#");
 }
 
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 38a48b5..efa1239 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -46,6 +46,7 @@ cat > expect << \EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -76,6 +77,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -104,6 +106,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -138,6 +141,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -174,6 +178,7 @@ cat > expect << \EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   modified
 #
@@ -204,6 +209,7 @@ cat > expect << \EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -267,6 +273,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -297,6 +304,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -326,6 +334,7 @@ cat >expect <<EOF
 # On branch master
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -357,7 +366,7 @@ cat >expect <<EOF
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
-- 
1.6.0.1.dirty
