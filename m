From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 2/2] mergetools: add support for ExamDiff
Date: Fri, 25 Mar 2016 15:52:56 -0700
Message-ID: <1458946376-30296-3-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
 <1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 25 23:53:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajabv-0001Tf-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbcCYWxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:53:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35164 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbcCYWxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:53:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so12863609pfb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fm4NLybR47XVUPjnJ+NpB/32zU3RuxQjSAQ9eEQA1hw=;
        b=UO5eNKOtj7vUIF2RJTJ4EcmWkhpC7t31e05g3kf5yhU7pXVCYI9uK7uqAOqFLjR3lW
         OWVox6Hi9jeME+n77iesS2Uxv1nO0v0OaNzezvbl9T2Sg8PRNP/TvP3pVg1FiOrGHilP
         5DuX5y05DXdSNmDyJLXJLKTtOwjQf7KKUqPls7VRxj+Q/szYFkk+TLE9UYjAu0tLgNmL
         Jnt/xwpDUWqsgk/7Qn9/KnyZ978wLAKj6v7CZTBx2MGlvPiintyColjFik3/VTkzEfR6
         bmppUdSLKeSHd6gxZUbxtKBmK5fnkr66TtKHbVHYyJRHy2KgN3Vfb5pNauySG7Tnm2Nu
         rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fm4NLybR47XVUPjnJ+NpB/32zU3RuxQjSAQ9eEQA1hw=;
        b=iMSnSg4vCIlVZhfqBVmFxjOWWYryjuKiYF6A4Q6WroYVI1g/85DP1YALoUxX48sqlY
         FeHN9/cRQDZybBu44o1rISFZP0jQV9GiS/webXy9NVG1UO+inylQVerQySGZDJnkaC9t
         Gim9FIz1mqFc3ZZpAolgHxBRiz733isavb3toeQ6F80wJ379nVygl3+9JBMUChFEidum
         gKvE7gFXqwzydu0JsqQfCL13qc9CO7MPaLjbTlLqjHQIwqW0cV+rWjHxHJn5HrqQ3hC4
         om6qJ8ccGZrHIcmITSyIs5CSo6KR2wZc0KtLs2HHz41rIoqVrMzmoMYiR18E7pftMniO
         isXQ==
X-Gm-Message-State: AD7BkJIPeercB+twILxcq/neKFy9q+QeNW0m2OaL7XkWX9LvzTmQIpM3HNkDq0PQ8vbpTw==
X-Received: by 10.98.14.68 with SMTP id w65mr24485745pfi.144.1458946418143;
        Fri, 25 Mar 2016 15:53:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id 17sm18583342pfp.96.2016.03.25.15.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 15:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289960>

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
