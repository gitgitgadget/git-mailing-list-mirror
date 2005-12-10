From: freku045@student.liu.se
Subject: [PATCH 22/25] git-status: Print usage message on incorrect invocation.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434791594-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:41:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYa-0002PO-3f
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVLJTid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVLJTic
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:32 -0500
Received: from [85.8.31.11] ([85.8.31.11]:23757 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161049AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D65DF4128; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-000708-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13470>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-status.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

5bce9bb1977eea80398f894880340f10bdc9a2eb
diff --git a/git-status.sh b/git-status.sh
index 2dda0c5..4ba6cc2 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -2,7 +2,17 @@
 #
 # Copyright (c) 2005 Linus Torvalds
 #
-GIT_DIR=$(git-rev-parse --git-dir) || exit
+
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
 
 report () {
   header="#
-- 
0.99.9.GIT
