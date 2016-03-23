From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 2/2] created helper function for both winmerge and examdiff mergetools
Date: Tue, 22 Mar 2016 17:43:14 -0700
Message-ID: <1458693794-9124-3-git-send-email-jacob.nisnevich@gmail.com>
References: <20160321033201.GA2004@gmail.com>
 <1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 01:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiWva-0001w2-Me
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 01:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcCWApd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 20:45:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35555 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbcCWAp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 20:45:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so91878pfb.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2SS8f/lGlwMdQ3lvkPk/gahNY8Fg+S/KduA0zH/5nw=;
        b=PIF+RO5A+6LDMt830lnGC6JEsi9lKIWR3/6naS5ClVjHrKipyw5salhXZMt+2kaLiE
         eJwHDtwdIcblO/82nN6k8aOTPpgQG7H+gKUDu/mSeoQ23YFQMFGYp8stgZPSSOeKBLnW
         6hw/XR235fp1N9Ss2MggV0JRJH/SFv/tRqVzxk/kPLMvOb+wFtdmM+HR8DxM9xzpD6Bm
         9C9YBCnLoqpe8CFoxRo/zC4yBfn2RBOyj89llvLLPCddVV6roPw0BgRuOEOBkAlLtF7r
         KTozhsT5bXU8aWQSNAmyUAG3rPmIu+y/LVhsTxoblCs6vD4oSt//Yvxh8YiGUhfglgtH
         jcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2SS8f/lGlwMdQ3lvkPk/gahNY8Fg+S/KduA0zH/5nw=;
        b=MEv49Oi6VOAyfkOXNlWL+pZ283y4HEmb+/Z4f1D54XPjg9lT7wemcIbBrNMokRIvni
         Otq6S3aDxz72Y8vneQ+A+ukfGupicwV+LiGYI24z9r6Nakc0jfhfaXpAJh2fRsHiophJ
         GRvgb3U8EhzclVJxHe+HTRw5MbC9SATaA6zrgEv380LUV/0GBODppLeGsDXmPB68oIEK
         UJJHCJpZFXcq4exu5OeHPbIMeZHVdEewnWWV3NZ6mV1NjcD0iXsb6Kv/0dyFBylxAeOE
         ECTreFiYDxVHsYuaNa1wbLMFYfQVB7U694WkIIcUf3RHiE5dIsm6J+j8gnUk5nB737a5
         aFog==
X-Gm-Message-State: AD7BkJKwLMfjBm2wsa267TxkgkHmGr3VN0fpGRzjJCok/nEuMrTi5m1vmzLI5OmZ9OYm3Q==
X-Received: by 10.66.191.202 with SMTP id ha10mr146572pac.8.1458693928019;
        Tue, 22 Mar 2016 17:45:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id l4sm35924725pfi.73.2016.03.22.17.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 17:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289592>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 ...s-created-new-mergetool-file-for-ExamDiff.patch | 58 ++++++++++++++++++++++
 mergetools/examdiff                                | 25 ++--------
 mergetools/mergetools_helpers                      | 30 +++++++++++
 mergetools/winmerge                                | 23 ++-------
 4 files changed, 95 insertions(+), 41 deletions(-)
 create mode 100644 0001-mergetools-created-new-mergetool-file-for-ExamDiff.patch
 create mode 100644 mergetools/mergetools_helpers

diff --git a/0001-mergetools-created-new-mergetool-file-for-ExamDiff.patch b/0001-mergetools-created-new-mergetool-file-for-ExamDiff.patch
new file mode 100644
index 0000000..99e0d6b
--- /dev/null
+++ b/0001-mergetools-created-new-mergetool-file-for-ExamDiff.patch
@@ -0,0 +1,58 @@
+From a26ad589bc5e747962359c89c5536858748e5eb8 Mon Sep 17 00:00:00 2001
+From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
+Date: Sat, 19 Mar 2016 17:31:50 -0700
+Subject: [PATCH] mergetools: created new mergetool file for ExamDiff
+To: git@vger.kernel.org
+
+---
+ mergetools/examdiff | 37 +++++++++++++++++++++++++++++++++++++
+ 1 file changed, 37 insertions(+)
+ create mode 100644 mergetools/examdiff
+
+diff --git a/mergetools/examdiff b/mergetools/examdiff
+new file mode 100644
+index 0000000..474fffe
+--- /dev/null
++++ b/mergetools/examdiff
+@@ -0,0 +1,37 @@
++diff_cmd () {
++	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
++}
++
++merge_cmd () {
++	touch "$BACKUP"
++	if $base_present
++	then
++		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
++	else
++		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
++	fi
++	check_unchanged
++}
++
++translate_merge_tool_path() {
++	# Use ExamDiff.com if it exists in $PATH
++	if type -p ExamDiff.com >/dev/null 2>&1
++	then
++		printf ExamDiff.com
++		return
++	fi
++
++	# Look for ExamDiff.com in the typical locations
++	examdiff="ExamDiff Pro/ExamDiff.com"
++	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
++		cut -d '=' -f 2- | sort -u)
++	do
++		if test -n "$directory" && test -x "$directory/$examdiff"
++		then
++			printf '%s' "$directory/$examdiff"
++			return
++		fi
++	done
++
++	printf ExamDiff.com
++}
+\ No newline at end of file
+-- 
+1.9.1
+
diff --git a/mergetools/examdiff b/mergetools/examdiff
index 474fffe..8b66c17 100644
--- a/mergetools/examdiff
+++ b/mergetools/examdiff
@@ -1,3 +1,5 @@
+. mergetools_helpers
+
 diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
 }
@@ -14,24 +16,5 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	# Use ExamDiff.com if it exists in $PATH
-	if type -p ExamDiff.com >/dev/null 2>&1
-	then
-		printf ExamDiff.com
-		return
-	fi
-
-	# Look for ExamDiff.com in the typical locations
-	examdiff="ExamDiff Pro/ExamDiff.com"
-	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
-		cut -d '=' -f 2- | sort -u)
-	do
-		if test -n "$directory" && test -x "$directory/$examdiff"
-		then
-			printf '%s' "$directory/$examdiff"
-			return
-		fi
-	done
-
-	printf ExamDiff.com
-}
\ No newline at end of file
+	mergetool_find_win32_cmd "ExamDiff.com" "ExamDiff Pro"
+}
diff --git a/mergetools/mergetools_helpers b/mergetools/mergetools_helpers
new file mode 100644
index 0000000..6df9d09
--- /dev/null
+++ b/mergetools/mergetools_helpers
@@ -0,0 +1,30 @@
+# Find path to win32 executable using typical locations
+# Arguments
+#  executable      - default name of executable file
+#  folder          - folder containing executable file from Program Files
+# Returns
+#  Path to the executable
+mergetool_find_win32_cmd () {
+	executable = $1
+	folder = $2
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
index 74a66d4..265d853 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -1,3 +1,5 @@
+. mergetools_helpers
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
