From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 1/2] mergetools: created new mergetool file for ExamDiff
Date: Tue, 22 Mar 2016 17:43:13 -0700
Message-ID: <1458693794-9124-2-git-send-email-jacob.nisnevich@gmail.com>
References: <20160321033201.GA2004@gmail.com>
 <1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 01:45:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiWvU-0001qQ-5h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 01:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbcCWAp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 20:45:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33444 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcCWAp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 20:45:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id x3so101958pfb.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2yN28BVxPRDqjER520wznW8w105HzzyYJIEzLLob/3A=;
        b=kOrGeOG7N5/GGqvz5xvDP/ei4MsVYSnOgFYfUzxv7Ni7/IE+lDUvgQ5CUkspVO5lKc
         kBrUyj/AjQ7TZnkglGHKoKriQa4kS9qrFCoDjSOkZCHaPjV+MHUBgPLpocecgKb1pOc0
         jW0lyWr5qSywPsT3CRLaY3FOrp6wXUrAW9lWA9th34nvE+/f12DyfcGw/iLhh/NYt1VS
         /ckznBcp82PlqzGQylPUUeRK5kqINwzPneges3wvD8qrv3Tnyv9AZX0pj6hWpldhkx94
         z50IIYBmA1H/t6BwRilDqVVOfuJ3fUlWXlSkWRdEP79CFcO3ivGrwhrf4v6kdQZ7LVFN
         EG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2yN28BVxPRDqjER520wznW8w105HzzyYJIEzLLob/3A=;
        b=QOHSi/XmfTb1h8GMF6b0+jL8mPLI7Hz0SjRe2uO1BXatMKYOiFQ/TPhzlv/Ltg1xMM
         9LvpgtcfQXaIaycC1svoNoxMO+Cer4FImclqKfO14flIZXpxS6gARMBrVIJuY5SIOBc9
         ZW9GQVxwNlLm0ckrKywtfib3CxTNJQhocK2mEsQUwxM5AjcyLtQTWBS0CeOx6ZR1GRDq
         WbtUV+EDtxGNEx4rPNzwUqRU5B7rNGiJW9owml0cCv1ho3W8Sd+i5IGpgoLXpYpPg93W
         GVL4c5L1rHpbgEd5Z14SJcxRzAGEqD/tOAbkf49cl4b9hur98/Rg0AuxREtJSyY4Qi2b
         shRg==
X-Gm-Message-State: AD7BkJLeiENbYmmyTS8QjTVn0suhufEuE4jAkOqk5KL/PKEr8wpLgvsSl1WSyT57TSVB+w==
X-Received: by 10.66.139.199 with SMTP id ra7mr123318pab.74.1458693927150;
        Tue, 22 Mar 2016 17:45:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id l4sm35924725pfi.73.2016.03.22.17.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 17:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289590>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 mergetools/examdiff | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 mergetools/examdiff

diff --git a/mergetools/examdiff b/mergetools/examdiff
new file mode 100644
index 0000000..474fffe
--- /dev/null
+++ b/mergetools/examdiff
@@ -0,0 +1,37 @@
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
+	# Use ExamDiff.com if it exists in $PATH
+	if type -p ExamDiff.com >/dev/null 2>&1
+	then
+		printf ExamDiff.com
+		return
+	fi
+
+	# Look for ExamDiff.com in the typical locations
+	examdiff="ExamDiff Pro/ExamDiff.com"
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
+		cut -d '=' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$examdiff"
+		then
+			printf '%s' "$directory/$examdiff"
+			return
+		fi
+	done
+
+	printf ExamDiff.com
+}
\ No newline at end of file
-- 
1.9.1
