From: freku045@student.liu.se
Subject: [PATCH 6/11] git-cherry: Usage string clean-up, use the 'usage' function
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <1134513031495-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:34:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIgS-0006dV-FY
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVLMWav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLMWat
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:49 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52178 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030300AbVLMWap (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:45 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id F019D4115; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001zB-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13605>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-cherry.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

a3b435a4c9bbde849dbe1aac1431387d673cf754
diff --git a/git-cherry.sh b/git-cherry.sh
index 867522b..5e9bd0c 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -3,11 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-. git-sh-setup
-
-usage="usage: $0 "'[-v] <upstream> [<head>]
-
-             __*__*__*__*__> <upstream>
+USAGE='[-v] <upstream> [<head>]'
+LONG_USAGE='             __*__*__*__*__> <upstream>
             /
   fork-point
             \__+__+__+__+__+__+__+__> <head>
@@ -16,8 +13,8 @@ Each commit between the fork-point and <
 compared against the change each commit between the fork-point and
 <upstream> introduces.  If the change seems to be in the upstream,
 it is shown on the standard output with prefix "+".  Otherwise
-it is shown with prefix "-".
-'
+it is shown with prefix "-".'
+. git-sh-setup
 
 case "$1" in -v) verbose=t; shift ;; esac 
 
@@ -35,7 +32,7 @@ case "$#" in
 2) upstream=`git-rev-parse --verify "$1"` &&
    ours=`git-rev-parse --verify "$2"` || exit
    ;;
-*) echo >&2 "$usage"; exit 1 ;;
+*) usage ;;
 esac
 
 # Note that these list commits in reverse order;
-- 
0.99.9.GIT
