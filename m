From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] bisect: replace "; then" with "\n<tab>*then"
Date: Fri,  5 Aug 2011 21:31:31 +1000
Message-ID: <1312543891-11079-3-git-send-email-jon.seymour@gmail.com>
References: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 13:32:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpIdI-0004Uc-44
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 13:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1HELbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 07:31:51 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37760 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1HELbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 07:31:50 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3511413iye.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wjXjGI0Xl+WmBkCB9Oi20ZI3uCPd86c7NymkJosDoQs=;
        b=YnV6HHXXjvcv2TsTroh7MrO1Qrua0cyBsXT4Tu6I5dGXwYrLNJ/hhmOZAWO9rQP0FM
         CQZdhlQfjQ1wA9je4Qm0Xd2P10uqJwYZ/7ocK7dFhIUz23YYxieZLVqm/atNdZaSkQeJ
         /DYRxi/tLD9XoCE9TmnZh+6k1+u0fIX2mzzJE=
Received: by 10.231.60.73 with SMTP id o9mr1642065ibh.33.1312543910362;
        Fri, 05 Aug 2011 04:31:50 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id es17sm757930ibb.54.2011.08.05.04.31.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 04:31:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.360.geebb0f
In-Reply-To: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178791>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index f5d9ede..1f3c46d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -198,7 +198,8 @@ is_expected_rev() {
 
 check_expected_revs() {
 	for _rev in "$@"; do
-		if ! is_expected_rev "$_rev"; then
+		if ! is_expected_rev "$_rev"
+		then
 			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
 			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
 			return
@@ -331,7 +332,8 @@ bisect_visualize() {
 	if test $# = 0
 	then
 		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
-		   type gitk >/dev/null 2>&1; then
+		   type gitk >/dev/null 2>&1
+		then
 			set gitk
 		else
 			set git log
@@ -400,7 +402,8 @@ bisect_replay () {
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" -o "$git" = "git-bisect" || continue
-		if test "$git" = "git-bisect"; then
+		if test "$git" = "git-bisect"
+		then
 			rev="$command"
 			command="$bisect"
 		fi
@@ -428,7 +431,8 @@ bisect_run () {
 		res=$?
 
 		# Check for really bad run error.
-		if [ $res -lt 0 -o $res -ge 128 ]; then
+		if [ $res -lt 0 -o $res -ge 128 ]
+		then
 			(
 				eval_gettext "bisect run failed:
 exit code \$res from '\$command' is < 0 or >= 128" &&
@@ -439,9 +443,11 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 
 		# Find current state depending on run success or failure.
 		# A special exit code of 125 means cannot test.
-		if [ $res -eq 125 ]; then
+		if [ $res -eq 125 ]
+		then
 			state='skip'
-		elif [ $res -gt 0 ]; then
+		elif [ $res -gt 0 ]
+		then
 			state='bad'
 		else
 			state='good'
@@ -454,7 +460,8 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 		cat "$GIT_DIR/BISECT_RUN"
 
 		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
-			> /dev/null; then
+			> /dev/null
+		then
 			(
 				gettext "bisect run cannot continue any more" &&
 				echo
@@ -462,7 +469,8 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 			exit $res
 		fi
 
-		if [ $res -ne 0 ]; then
+		if [ $res -ne 0 ]
+		then
 			(
 				eval_gettext "bisect run failed:
 'bisect_state \$state' exited with error code \$res" &&
@@ -471,7 +479,8 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null
+		then
 			gettext "bisect run success"; echo
 			exit 0;
 		fi
-- 
1.7.6.354.g7f57d
