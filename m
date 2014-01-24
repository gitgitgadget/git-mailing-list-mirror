From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/9] git-sh-setup.sh: add variable to use the stuck-long mode
Date: Fri, 24 Jan 2014 00:50:59 +0000
Message-ID: <1390524666-51274-3-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6UzU-0001ez-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbaAXAvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51325 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752980AbaAXAvS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:18 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 53FC92807E;
	Fri, 24 Jan 2014 00:51:17 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240982>

From: Nicolas Vigier <boklm@mars-attacks.org>

If the variable $OPTIONS_STUCKLONG is not empty, then rev-parse
option parsing is done in --stuck-long mode.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
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
index 1a7689a..d7507ed 100755
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
index 01c95e9..9d881cd 100755
--- a/contrib/examples/git-clean.sh
+++ b/contrib/examples/git-clean.sh
@@ -4,6 +4,7 @@
 #
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git-clean [options] <paths>...
 
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index 547228e..ea4757d 100755
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
index a5e42a9..f0243d5 100755
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
index 7579331..fd5ced5 100755
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
index a4ed4c3..d7e97bb 100755
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
index bbea430..a3b6f98 100755
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
index e93a238..4aa3eb8 100755
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
index 8e17525..167d79f 100755
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
index 8a3efa2..c1f98ae 100755
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
index fe21d5d..cf4f150 100755
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
index fffa3c7..5f28b32 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -72,6 +72,8 @@ if test -n "$OPTIONS_SPEC"; then
 	parseopt_extra=
 	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
 		parseopt_extra="--keep-dashdash"
+	[ -n "$OPTIONS_STUCKLONG" ] &&
+		parseopt_extra="$parseopt_extra --stuck-long"
 
 	eval "$(
 		echo "$OPTIONS_SPEC" |
-- 
1.9.rc0.1002.gd081c64.dirty
