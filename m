From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 7/7] tests: move test for rebase messages from t3400 to t3406
Date: Mon,  3 Jun 2013 13:42:15 -0700
Message-ID: <1370292135-1236-8-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaY-0000k0-IL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab3FCUmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:44 -0400
Received: from mail-vb0-f73.google.com ([209.85.212.73]:56638 "EHLO
	mail-vb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328Ab3FCUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:27 -0400
Received: by mail-vb0-f73.google.com with SMTP id i3so296496vbh.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=TjftlvvPoK8ynIg/zyaVjfRp67f6OmSYc9QrK7s/ba8=;
        b=pS2nyze0+O9ksd0d56w59z7ZfuDi9MU/qSz7iZ89OT6ndjpFFBEYM30OG+U9ZRCNaz
         WQCV8lgeaKcNNt/w6G31Gk0vY7jwI71e2fW3+si+nTFWhrY4ZsZvhJDHMlNFQm2U/FIb
         FZMm3BPXoWTH93jKy5AoVvk9Ct/8WO83Q0HZhqXynwDcq7/dRicyDZTmeXoR4xvy2qWs
         +K5nHa3GphOT/g4AF2u2veeUXMNgQyZQSzTqtjQ9M/3DKGgYIIQnopSEcssoLyAtjrUC
         9HY2Csmn9WfOJvE2XZTlJza1eLDTghbWgUUmuxs0nsgoF44bs9RgWDu6boIzNkrWhLQS
         WaeQ==
X-Received: by 10.236.231.10 with SMTP id k10mr13610644yhq.30.1370292146233;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id 10si3726165yhj.6.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1284031C1ED;
	Mon,  3 Jun 2013 13:42:26 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 9133F10132C; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl5SiHslAqjhd0sFWyKcytjBnXVNQUJ7B7BU3SmukdY8ibUIYtjfnH79xO0UslrM+NQTTflhMuoHR9ywm2qADK4vZCblL+awh6zlBn6DcXceUn+7QThSLq/jaWffkWfM69akPf4v1cOohfYcKkD0pOWW7dnTxmSw+isaFlts/JZGti68k/pAQv7tmDqLPL6Qsps1fUY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226284>

t3406 is supposed to test "messages from rebase operation", so let's
move tests in t3400 that fit that description into 3406. Most of the
functionality they tested, except for the messages, has now been
subsumed by t3420.
---
 t/t3400-rebase.sh         | 22 ----------------------
 t/t3406-rebase-message.sh | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b436ef4..45a55e9 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,28 +59,6 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
-test_expect_success 'rebase against master twice' '
-	git rebase master >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date" out
-'
-
-test_expect_success 'rebase against master twice with --force' '
-	git rebase --force-rebase master >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date, rebase forced" out
-'
-
-test_expect_success 'rebase against master twice from another branch' '
-	git checkout my-topic-branch^ &&
-	git rebase master my-topic-branch >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date" out
-'
-
-test_expect_success 'rebase fast-forward to master' '
-	git checkout my-topic-branch^ &&
-	git rebase my-topic-branch >out &&
-	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
-'
-
 test_expect_success 'the rebase operation should not have destroyed author information' '
 	! (git log | grep "Author:" | grep "<>")
 '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index fe8c27f..0392e36 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -30,6 +30,28 @@ test_expect_success 'rebase -m' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase against master twice' '
+	git rebase master >out &&
+	test_i18ngrep "Current branch topic is up to date" out
+'
+
+test_expect_success 'rebase against master twice with --force' '
+	git rebase --force-rebase master >out &&
+	test_i18ngrep "Current branch topic is up to date, rebase forced" out
+'
+
+test_expect_success 'rebase against master twice from another branch' '
+	git checkout topic^ &&
+	git rebase master topic >out &&
+	test_i18ngrep "Current branch topic is up to date" out
+'
+
+test_expect_success 'rebase fast-forward to master' '
+	git checkout topic^ &&
+	git rebase topic >out &&
+	test_i18ngrep "Fast-forwarded HEAD to topic" out
+'
+
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
-- 
1.8.3.497.g83fddbe
