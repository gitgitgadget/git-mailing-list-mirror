From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH] mergetools: implemented new mergetool file for ExamDiff
Date: Wed, 23 Mar 2016 15:55:45 -0700
Message-ID: <1458773745-783-2-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
 <1458773745-783-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 23:56:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airhh-0004qU-ES
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 23:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcCWW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 18:56:38 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34092 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcCWW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 18:56:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id x3so41376521pfb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZcLUIzT8D6t+WEu4pH9ZZHqT8qEdNJX4s43XF48dmo=;
        b=utjvI+rBvEhACZnaGXM5pVUvTXpJL7D3/SDAOHhDsCv2pJ7IcE77PpemrssMEcCdh5
         rWmQ0iUqtyaJC/5CZDrsltwQ356A+oT6zmuz1jJzvxs6zNJJFPAgn9eMwWri9meRM9kp
         wkpCinCts/ovz7uG8Z53MUloRf5AaU01WPQmz9topccsSweqC/30Q8AP3OS/YCHmNPIk
         o/KPjcRGRmMbsolQYGaiFL/QYx2eeM7kkvuLYhG//0+J0zjufze5vyX4qVmvCCGzqLSu
         6yeFyj3m26bKE2lqcFK9/v+m2y1lMvhSQJHCMJP0yIRYbduYBhMSkNQAMncpTnwZrlF/
         fLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HZcLUIzT8D6t+WEu4pH9ZZHqT8qEdNJX4s43XF48dmo=;
        b=ei5ZP3Ktu3F+/kA4ZAGUijYgqJiUdKYWjNfdqCKEFTtLsuI6zCCOERGEYI17QSCJ7+
         m2mmmq+UIZseQdh1r07UIrPl61h1Iw0dSc68AiRAzFwNR14LIl0PVKY/W7LA1VHZbSD2
         C0r34D2q5rmr9W9DePhjSu+1uzFX8Wj4qyvSd92+iV3wJ7PmpTHH6la2kY9SAII5F9gU
         ybGiNRHOwiC0S9q6EIQxpecBTAiDaeMN7ZG/YfcgGZC52jgMqA4BFiPEjkkcy1ORy8bf
         z3tvS4hfHchYyS/kejM9WKCgg3TGNuo3lO/08krmhkqVZLVmQITXmAEBlCSlgAnJX9hV
         TuqQ==
X-Gm-Message-State: AD7BkJJJeKtQS3wPc8GBMuNnXrTRnFv3CLxskmHL8Mq1M6SNuWBsUobZcsNHsbOy3ByZNA==
X-Received: by 10.98.69.84 with SMTP id s81mr7748203pfa.125.1458773796428;
        Wed, 23 Mar 2016 15:56:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id ko9sm6471871pab.37.2016.03.23.15.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 15:56:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458773745-783-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289690>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 mergetools/examdiff           | 20 ++++++++++++++++++++
 mergetools/mergetools_helpers | 24 ++++++++++++++++++++++++
 mergetools/winmerge           | 23 +++--------------------
 3 files changed, 47 insertions(+), 20 deletions(-)
 create mode 100644 mergetools/examdiff
 create mode 100644 mergetools/mergetools_helpers

diff --git a/mergetools/examdiff b/mergetools/examdiff
new file mode 100644
index 0000000..c5edd0e
--- /dev/null
+++ b/mergetools/examdiff
@@ -0,0 +1,20 @@
+. "$MERGE_TOOLS_DIR/mergetools_helpers"
+
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
+	else
+		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	mergetool_find_win32_cmd "ExamDiff.com" "ExamDiff Pro"
+}
diff --git a/mergetools/mergetools_helpers b/mergetools/mergetools_helpers
new file mode 100644
index 0000000..46ae2d8
--- /dev/null
+++ b/mergetools/mergetools_helpers
@@ -0,0 +1,24 @@
+mergetool_find_win32_cmd () {
+	executable=$1
+	folder=$2
+
+	# Use executable.com if it exists in $PATH
+	if type -p $executable >/dev/null 2>&1
+	then
+		printf $executable
+		return
+	fi
+
+	# Look for executable in the typical locations
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
+		cut -d '=' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$folder/$executable"
+		then
+			printf '%s' "$directory/$folder/$executable"
+			return
+		fi
+	done
+
+	printf $executable
+}
diff --git a/mergetools/winmerge b/mergetools/winmerge
index 74a66d4..c785be8 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -1,3 +1,5 @@
+. "$MERGE_TOOLS_DIR/mergetools_helpers"
+
 diff_cmd () {
 	"$merge_tool_path" -u -e "$LOCAL" "$REMOTE"
 	return 0
@@ -13,24 +15,5 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	# Use WinMergeU.exe if it exists in $PATH
-	if type -p WinMergeU.exe >/dev/null 2>&1
-	then
-		printf WinMergeU.exe
-		return
-	fi
-
-	# Look for WinMergeU.exe in the typical locations
-	winmerge_exe="WinMerge/WinMergeU.exe"
-	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
-		cut -d '=' -f 2- | sort -u)
-	do
-		if test -n "$directory" && test -x "$directory/$winmerge_exe"
-		then
-			printf '%s' "$directory/$winmerge_exe"
-			return
-		fi
-	done
-
-	printf WinMergeU.exe
+	mergetool_find_win32_cmd "WinMergeU.exe" "WinMerge"
 }
-- 
1.9.1
