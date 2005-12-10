From: freku045@student.liu.se
Subject: [PATCH 10/25] git-grep: Print usage message on '-h' and '--help'.
Date: Sat, 10 Dec 2005 20:37:58 +0100
Message-ID: <11342434783113-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYc-0002PO-AY
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbVLJTih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVLJTig
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:36 -0500
Received: from [85.8.31.11] ([85.8.31.11]:21453 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161041AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 31C5B411B; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXe-0006zI-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13458>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-grep.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

b375c3ad7c6ce4d6cda208c61828f8ff72cb7d53
diff --git a/git-grep.sh b/git-grep.sh
index 44c1613..e6acc41 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -3,6 +3,11 @@
 # Copyright (c) Linus Torvalds, 2005
 #
 
+usage () {
+        echo >&2 "usage: $0 <option>... <pattern> [pathspec*]"
+        exit 1
+}
+
 pattern=
 flags=()
 git_flags=()
@@ -26,6 +31,9 @@ while : ; do
 		shift
 		break
 		;;
+        -h|--h|--he|--hel|--help)
+                usage
+                ;;
 	-*)
 		flags=("${flags[@]}" "$1")
 		;;
@@ -40,8 +48,7 @@ while : ; do
 	shift
 done
 [ "$pattern" ] || {
-	echo >&2 "usage: 'git grep <pattern> [pathspec*]'"
-	exit 1
+        usage
 }
 git-ls-files -z "${git_flags[@]}" "$@" |
 	xargs -0 grep "${flags[@]}" -e "$pattern"
-- 
0.99.9.GIT
