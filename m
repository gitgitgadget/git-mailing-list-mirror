From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 2/2] mergetools: add support for ExamDiff
Date: Fri, 25 Mar 2016 16:17:57 -0700
Message-ID: <1458947877-31764-3-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
 <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 26 00:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajb00-0006Ms-5W
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbcCYXSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:18:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35715 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcCYXSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:18:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id u190so12902754pfb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fm4NLybR47XVUPjnJ+NpB/32zU3RuxQjSAQ9eEQA1hw=;
        b=aSAv2m6w4WLXNsFrj+dCAPyydU+9ua+2dUxbcvlrAAjbTtsBCfHLEnCczFXipBD+9H
         Wks2400/+xV31AuLBTsdIrjer3F2sMzLWqOB01SL5MNZLvhPPVw8mYuo+VV6IInoe1M5
         1NeO6YsKfFfnev/YInP1/r+60kqIRaI442EnGLZPX6+RSGuN/Fd/IbViQTUFvleLPUdm
         LYd74m6VaNRxn9TA15/IL+O9+ehCN3aDXNf9BQUExNeplBwkgZHIDVGVWkrrv+mfmOSq
         8ctxkU7dSJQUOtE96sLKc2tYpTZqOXFdymS7HyGpIzcTRx+0YmoYROJVF6SNOMx1yZU7
         /buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fm4NLybR47XVUPjnJ+NpB/32zU3RuxQjSAQ9eEQA1hw=;
        b=iOOZDKjEsk0A1L9/zyvcnhiks3oQfGC/kXjaIsUCg9JX2es78hoCz3/Jh8ETXFBF+G
         kiezrh1ToKWoOqhIujPAB8UQpP0+RD2yuvivlCdPhXbq3dETANuvh3WRx7p9o5kVruzn
         Kl2UdXyLvm/KO0llLahCDS43ngc7tDs96GNPkfkL0t7RsQXgMrCmkMm7tyV09gFaThp0
         GB8uT7ZVLk5lkIwBocuBtf+mY/xe+hcEjzUyX7UaNLdWQX96Cyl19K9TjeTrv++I12fV
         9+F2phRRaPm0whzv7fxSKPVwFhvWOEmQrx3PzJto5vTUoAKdljO/76OQYo0nY+4bV/MI
         rYAw==
X-Gm-Message-State: AD7BkJK8ioBbt6jb+iMgDblI2uYUztSz5omUNaoAnpxqefILo7CEbRsPjs1kQUv8F3KCBA==
X-Received: by 10.98.72.218 with SMTP id q87mr24664644pfi.117.1458947904579;
        Fri, 25 Mar 2016 16:18:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id y23sm18674072pfi.22.2016.03.25.16.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 16:18:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289969>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 mergetools/examdiff | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 mergetools/examdiff

diff --git a/mergetools/examdiff b/mergetools/examdiff
new file mode 100644
index 0000000..7b524d4
--- /dev/null
+++ b/mergetools/examdiff
@@ -0,0 +1,18 @@
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
-- 
1.9.1
