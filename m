From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 7/7] tests: move test for rebase messages from t3400 to t3406
Date: Thu,  6 Jun 2013 23:11:43 -0700
Message-ID: <1370585503-11374-8-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukpua-0003Q4-SI
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab3FGGMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:16 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:63288 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-yh0-f73.google.com with SMTP id l109so115790yhq.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=JDJ/Invxt/N/r6G+67mrlcnXYNmtapS3uK6afhdHSSs=;
        b=cIwz4rYEXWmjc9YMX7+ABu4oH8YtVQL/2adLg8npWH/NbUcz7bNq+CfA9TA+xkwE/i
         Kfd/UXEenrRGmixwRVuUhkZJ+uwWY1h8WCFEjLUYbz0Dl0DwIDCGm/c/+v88gbG9g+KL
         XLh4/O0nKsWvPaTy4gliNlB9SzANahUTEQw50Lhpn1+D2yLYA0GXKOrOKvSdC+sCDpsG
         eANMlne4937s44S1xvNaDRb2bozDV73f03xSJKvurnolm/uVefQ5/zmDlA0zj/iJ9vhm
         lT/tEOapmVc4vA5/i3XvrTRhQvMRAA6c6l2VrFbOYeFT6giVB7X7sCtsmVRtemHdyqRy
         O8Pg==
X-Received: by 10.236.146.201 with SMTP id r49mr22080963yhj.27.1370585510617;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o42si7050026yhe.5.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 751C55A416A;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 1DBE7100D20; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkn5shg/eN8mOZ1pZE7ndwQ23t7Zdo72gxyb+MRW4JJIsKqeXJNn9KJNQsNhoqK3sslizh/DfkIg8SDXemoNjiuHDQ7PfQOpVpHLqgpjBF4wm7mIAv9pvOJ5RgqBPpSpD0/IZ5p34rNCR8wrMaBzJvMWLaR484Ct6KqP1IUtgEWkUP8MrP4hdJO8vWG6MC5KijLx2DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226602>

t3406 is supposed to test "messages from rebase operation", so let's
move tests in t3400 that fit that description into 3406. Most of the
functionality they tested, except for the messages, has now been
subsumed by t3420.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
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
