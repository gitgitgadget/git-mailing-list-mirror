From: freku045@student.liu.se
Subject: [PATCH 7/25] git-count-objects: Die with usage message if we are invoked incorrectly.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434772549-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYk-0002PO-9P
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbVLJTii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVLJTih
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:37 -0500
Received: from [85.8.31.11] ([85.8.31.11]:20173 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161038AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C05144118; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006z6-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13461>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-count-objects.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

5db708396a841860c4d5e41c2acd60476d2207c4
diff --git a/git-count-objects.sh b/git-count-objects.sh
index 40c58ef..0d544ad 100755
--- a/git-count-objects.sh
+++ b/git-count-objects.sh
@@ -3,7 +3,16 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+. git-sh-setup
+
+usage () {
+    die "usage: $0"
+}
+
+if [ "$#" != "0" ]
+then
+    usage
+fi
 
 dc </dev/null 2>/dev/null || {
 	# This is not a real DC at all -- it just knows how
-- 
0.99.9.GIT
