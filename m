From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 2/8] git-sh-setup.sh: add variable to use the stuck-long mode
Date: Sun,  3 Nov 2013 16:54:18 +0100
Message-ID: <1383494064-5653-3-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd01C-00088f-HU
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab3KCPyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:55 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35783 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab3KCPys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 677F54E60
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VcqIew0WNmkI; Sun,  3 Nov 2013 16:55:02 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 1D63D48BC;
	Sun,  3 Nov 2013 16:55:02 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id B69CC43934; Sun,  3 Nov 2013 16:54:45 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237265>

If the variable $OPTIONS_STUCKLONG is not empty, then rev-parse
option parsing is done in --stuck-long mode.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 contrib/examples/git-checkout.sh | 1 +
 contrib/examples/git-clean.sh    | 1 +
 contrib/examples/git-clone.sh    | 1 +
 contrib/examples/git-merge.sh    | 1 +
 contrib/examples/git-repack.sh   | 1 +
 contrib/git-resurrect.sh         | 1 +
 git-am.sh                        | 1 +
 git-instaweb.sh                  | 1 +
 git-quiltimport.sh               | 1 +
 git-rebase.sh                    | 1 +
 git-request-pull.sh              | 1 +
 git-sh-setup.sh                  | 2 ++
 12 files changed, 13 insertions(+)

diff --git a/contrib/examples/git-checkout.sh b/contrib/examples/git-checkout.sh
index 1a7689a48f07..d7507edaf564 100755
--- a/contrib/examples/git-checkout.sh
+++ b/contrib/examples/git-checkout.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 OPTIONS_KEEPDASHDASH=t
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git-checkout [options] [<branch>] [<paths>...]
 --
diff --git a/contrib/examples/git-clean.sh b/contrib/examples/git-clean.sh
index 01c95e9fe8a1..9d881cd90dfb 100755
--- a/contrib/examples/git-clean.sh
+++ b/contrib/examples/git-clean.sh
@@ -4,6 +4,7 @@
 #
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git-clean [options] <paths>...
 
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index 547228e13ce6..ea4757db33ab 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -8,6 +8,7 @@
 # See git-sh-setup why.
 unset CDPATH
 
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git-clone [options] [--] <repo> [<dir>]
 --
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index a5e42a9f0124..f0243d560121 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -4,6 +4,7 @@
 #
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git merge [options] <remote>...
 git merge [options] <msg> HEAD <remote>
diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
index 757933174e4c..fd5ced527da5 100755
--- a/contrib/examples/git-repack.sh
+++ b/contrib/examples/git-repack.sh
@@ -4,6 +4,7 @@
 #
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git repack [options]
 --
diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index a4ed4c3c62f0..d7e97bbc76c2 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -10,6 +10,7 @@ is rather slow but allows you to resurrect other people's topic
 branches."
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git resurrect $USAGE
 --
diff --git a/git-am.sh b/git-am.sh
index bbea43075be0..a3b6f988229c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -4,6 +4,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--continue | --skip | --abort)
diff --git a/git-instaweb.sh b/git-instaweb.sh
index e93a23867543..4aa3eb80fd25 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -5,6 +5,7 @@
 
 PERL='@@PERL@@'
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git instaweb [options] (--start | --stop | --restart)
 --
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 8e17525dd86a..167d79fea809 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git quiltimport [options]
 --
diff --git a/git-rebase.sh b/git-rebase.sh
index 226752fbff62..6ebef7e8b86e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -5,6 +5,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
diff --git a/git-request-pull.sh b/git-request-pull.sh
index fe21d5db631c..cf4f1505a54b 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE='Summarizes the changes between two commits to the standard output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC='git request-pull [options] start url [end]
 --
 p    show patch text as well
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ebfe8f7a4d06..e1d66799693d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -75,6 +75,8 @@ if test -n "$OPTIONS_SPEC"; then
 	parseopt_extra=
 	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
 		parseopt_extra="--keep-dashdash"
+	[ -n "$OPTIONS_STUCKLONG" ] &&
+		parseopt_extra="$parseopt_extra --stuck-long"
 
 	eval "$(
 		echo "$OPTIONS_SPEC" |
-- 
1.8.4.2
