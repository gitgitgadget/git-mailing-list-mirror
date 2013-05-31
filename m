From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 7/7] tests: move test for rebase messages from t3400 to t3406
Date: Thu, 30 May 2013 23:49:47 -0700
Message-ID: <1369982987-18954-8-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAZ-0000oP-9T
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab3EaGu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:26 -0400
Received: from mail-ye0-f201.google.com ([209.85.213.201]:36273 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab3EaGuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:05 -0400
Received: by mail-ye0-f201.google.com with SMTP id q9so113175yen.4
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=vLH1RPYb6Yd8oVkcGRXtwcmtotrDUk5j/Fhllasat4A=;
        b=ISvbKblKka2jHIVBEUBDm6yaP3UpaVPHDdSjp3ud+r9ATMezj/aL2+dGtkKv9T5kz7
         0JJJMSPfqooj/hzD5jA6E6QYmzvWRYUlijDwoHbwouuWcIqc0ZVKAqK5rplXSCHdDRVl
         wfKXpoFwbsgfulurtQskR0mSCkd6tQIDeyUo5lEwhL13G/HVj6hS0y1avUuIkQyts4d7
         E0FkrSfhpPPKQgXMLEpDZO9b0KdV4m/2GSFGe36FVugEAZC1dNFyesg7GvNsUcnxYoiw
         thHnFzaTqsJEsMfPeyDpyhut8nrSFcfOXTv4WrRmeMymgFPsP3ziP8Xv2dcoVT/NOuH5
         /JPw==
X-Received: by 10.236.134.132 with SMTP id s4mr5870362yhi.56.1369983003846;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id u22si1575160yhh.7.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AC62331C2CB;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 56D6E101619; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkdID+AbFa9xXjnkTRhA+QowBj82PDP81TuqPJ8BrZ+pWM/DTg0uLzITgBrk5ba0lvLUlmXyi0XPMZY1499R1hXzi63Bm34rV9aReBntkcJ56LHwphJhEqbZ21nS67Td8OB1+vJ8kWJt1xoMoNEWqclHWVgvqrR4phkpRaUdKscl06Ftcygs3v/rN11AzfKgT99R/KA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226056>

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
