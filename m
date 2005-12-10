From: freku045@student.liu.se
Subject: [PATCH 24/25] git-verify-tag: Clean-up usage message.
Date: Sat, 10 Dec 2005 20:38:00 +0100
Message-ID: <11342434801752-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYb-0002PO-76
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVLJTit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbVLJTir
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:47 -0500
Received: from [85.8.31.11] ([85.8.31.11]:25293 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161056AbVLJTiP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:15 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1F080412B; Sat, 10 Dec 2005 20:48:22 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXg-00070G-00; Sat, 10 Dec 2005 20:38:00 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13471>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-verify-tag.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

54db71ed3add0583463d77645e840ef61c8c6d9c
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 1f44da5..aff7c68 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -1,14 +1,14 @@
 #!/bin/sh
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+. git-sh-setup
 
-die () {
-    echo >&2 "$*"
-    exit 1
+usage () {
+    echo >&2 "usage: $0 [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]"
+    die "$@"
 }
 
 type="$(git-cat-file -t "$1" 2>/dev/null)" ||
-	die "$1: no such object."
+	usage "$1: no such object."
 
 test "$type" = tag ||
 	die "$1: cannot verify a non-tag object of type $type."
-- 
0.99.9.GIT
