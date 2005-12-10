From: freku045@student.liu.se
Subject: [PATCH 12/25] git-lost-found: Print usage message on incorrect invocation.
Date: Sat, 10 Dec 2005 20:37:58 +0100
Message-ID: <11342434782774-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYY-0002PO-9S
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVLJTik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVLJTij
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:39 -0500
Received: from [85.8.31.11] ([85.8.31.11]:21965 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161043AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 6B8B2411D; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXe-0006zQ-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13469>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-lost-found.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

2b2c389a8816f40cfa5b562203988b0c0b2269c5
diff --git a/git-lost-found.sh b/git-lost-found.sh
index 2beec2a..757e51f 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -1,6 +1,16 @@
 #!/bin/sh
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+. git-sh-setup
+
+usage () {
+	die "usage: $0"
+}
+
+if [ "$#" != "0" ]
+then
+    usage
+fi
+
 laf="$GIT_DIR/lost-found"
 rm -fr "$laf" && mkdir -p "$laf/commit" "$laf/other" || exit
 
-- 
0.99.9.GIT
