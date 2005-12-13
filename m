From: freku045@student.liu.se
Subject: [PATCH 2/11] git-verify-tag: Usage string clean-up, emit usage string at incorrect invocation
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <11345130314120-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfX-0006Sp-39
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVLMWaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMWaj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:39 -0500
Received: from [85.8.31.11] ([85.8.31.11]:47826 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030197AbVLMWah (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:37 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 73B864100; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001yv-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13597>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-verify-tag.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

e1bab3098c4926a09cb74dc767d03fd0f3bf8343
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 1f44da5..726b1e7 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -1,11 +1,13 @@
 #!/bin/sh
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
-
-die () {
-    echo >&2 "$*"
-    exit 1
-}
+USAGE='<tag>'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+if [ "$#" != "1" ]
+then
+  usage
+fi
 
 type="$(git-cat-file -t "$1" 2>/dev/null)" ||
 	die "$1: no such object."
-- 
0.99.9.GIT
