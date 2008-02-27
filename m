From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 02/40] Compile some programs only conditionally.
Date: Wed, 27 Feb 2008 19:54:25 +0100
Message-ID: <1204138503-6126-3-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRU-0000Km-Cf
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbYB0SzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbYB0SzI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:08 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40415 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYB0SzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:05 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 617A0973C8;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75246>

On MinGW, we won't compile some programs.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d33a556..870a862 100644
--- a/Makefile
+++ b/Makefile
@@ -255,7 +255,6 @@ PROGRAMS = \
 	git-fetch-pack$X \
 	git-hash-object$X git-index-pack$X \
 	git-fast-import$X \
-	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-receive-pack$X \
 	git-send-pack$X git-shell$X \
@@ -264,7 +263,7 @@ PROGRAMS = \
 	git-update-server-info$X \
 	git-upload-pack$X \
 	git-pack-redundant$X git-var$X \
-	git-merge-tree$X git-imap-send$X \
+	git-merge-tree$X \
 	git-merge-recursive$X \
 	$(EXTRA_PROGRAMS)
 
@@ -583,6 +582,11 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
+ifndef NO_EXTRA_PROGRAMS
+	EXTRA_PROGRAMS += \
+		git-daemon$X \
+		git-imap-send$X
+endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
-- 
1.5.4.1.126.ge5a7d
