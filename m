From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] difftool--helper: Make style consistent with git
Date: Thu, 18 Aug 2011 00:23:44 -0700
Message-ID: <1313652227-48545-2-git-send-email-davvid@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwxb-0005MS-BX
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab1HRHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:24:08 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:33028 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab1HRHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:24:05 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3440638iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z40irqjtaJ5xgiyrCfdALMrfI9Xen4+O9RRNei60DMg=;
        b=AJ2TyjxNTCHaGUbIQczsyxqHl5lLj2ydvUuMfOgarTUXqE9zLmNIRB92ZBs0rwOc/h
         qw1UL9TsXwI9v9vd4XNAFRXYrKnrNEClCURke3wMnlXoY08RVUyzlrHC+kzDGeEV1Ynw
         Of3Vfo5c6K41sqVKiu4WeRrvQeWoOUaj2aIs8=
Received: by 10.42.28.130 with SMTP id n2mr480425icc.43.1313652245300;
        Thu, 18 Aug 2011 00:24:05 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hq1sm1677692icc.14.2011.08.18.00.24.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 00:24:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
In-Reply-To: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179573>

Use the predominant conditional style where "then" appears
alone on the line after the test expression.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 0594bf7..8452890 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -13,7 +13,8 @@ TOOL_MODE=diff
 should_prompt () {
 	prompt_merge=$(git config --bool mergetool.prompt || echo true)
 	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
-	if test "$prompt" = true; then
+	if test "$prompt" = true
+	then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"
 	else
 		test -n "$GIT_DIFFTOOL_PROMPT"
@@ -37,9 +38,11 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
-	if should_prompt; then
+	if should_prompt
+	then
 		printf "\nViewing: '$MERGED'\n"
-		if use_ext_cmd; then
+		if use_ext_cmd
+		then
 			printf "Hit return to launch '%s': " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
@@ -48,7 +51,8 @@ launch_merge_tool () {
 		read ans
 	fi
 
-	if use_ext_cmd; then
+	if use_ext_cmd
+	then
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
@@ -56,8 +60,10 @@ launch_merge_tool () {
 	fi
 }
 
-if ! use_ext_cmd; then
-	if test -n "$GIT_DIFF_TOOL"; then
+if ! use_ext_cmd
+then
+	if test -n "$GIT_DIFF_TOOL"
+	then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
 		merge_tool="$(get_merge_tool)" || exit
-- 
1.7.6.476.g57292
