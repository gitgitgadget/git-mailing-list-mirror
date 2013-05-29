From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 7/7] tests: move test for rebase messages from t3400 to t3406
Date: Tue, 28 May 2013 23:39:32 -0700
Message-ID: <1369809572-24431-8-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:41:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha4G-0003Df-IU
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870Ab3E2Gk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:40:57 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:34442 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935043Ab3E2GkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:40:10 -0400
Received: by mail-qa0-f74.google.com with SMTP id bs12so391281qab.3
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=vLH1RPYb6Yd8oVkcGRXtwcmtotrDUk5j/Fhllasat4A=;
        b=Zo6zzPGFF6uTe9WJkE5yB7Evg/o7fqC7ZCv3mlZSq71vIS6tMFQ6t/JCfCVMU4/s9J
         l0A9+cSocCB7vH/9rJYIIZ09qh20RuZ6NukNEox/mFU20JzFr9AF2h6nFYJDklYKRFl5
         Fzmi3oPO2+K+fQGG22XnaXCH+LL8TbV3beq7vOeF0zWq0WAttfGbdpq7LmM0PbDTnJIa
         DyEWk4CkBaGZ9ob63wj5YSLh5umt9ngz6I8T52NXddcHhV7LvaI6fz2tXtoD9kECSeU6
         bMdDrxxPa9yFE5DAYaQ1wZz4cPi1gfXkqeB6zyjp+wF8474IOGsnrfNZFYK9oJztFJ/R
         xcDw==
X-Received: by 10.236.138.20 with SMTP id z20mr697673yhi.31.1369809608879;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b23si2629880yhj.4.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AFF7431C121;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 5F9CD100D56; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnqrSfwPJbVNsS4ZdUsyGgHHLeckfboWFxWok5cweo3BnWu+a80SpBA/z/fWOsRyEMCFM1BGC+MClJOxGmHQpqtZs6MmlMGbRhn15+fqka3ybf5hURGDhgyBY9RnPm2ofPXA3UuLxxtaKqJE9QtdQEQXOu2hIzALktSpFdYLGmRLdigR+0bplH9Mk49uOhw0NsNn7s9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225759>

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
1.8.2.674.gd17d3d2
