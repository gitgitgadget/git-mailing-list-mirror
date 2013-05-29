From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 6/7] t3406: modernize style
Date: Tue, 28 May 2013 23:39:31 -0700
Message-ID: <1369809572-24431-7-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha3Z-0002ah-PE
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935049Ab3E2GkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:40:14 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:50934 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935042Ab3E2GkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:40:10 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so906882qcz.3
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=xYWZZqOcVRLM5aNxSG6fqs9XaM5K+ARdLULG3Sj+QWU=;
        b=VNs8WR6GRulgJq7dNJlAYuquGFyOKw4HNsm5LEwbHrPhPrOeaafMySHWxjpIGz3JM5
         y7Y6glnO04TwkgbQgVpPmzgY+7jhjB1wEMk+lrPH+RMxJBDvMuJ86gzJA7p5dMmgfZLa
         JU9NvAL5xVA3l17OUZufQ3bAq3aiDjdQEzOldKRorWFw72PPAoIjnF0ytNgDJvgYK58+
         K8gp9p2Pn43xrSBaByZbMoC8IEWV9RBCzap7aiq/M0zGMZQa8p7nhVehfN5lkvl+is+i
         tNY+saXqK2aCi7MW2sYBRY/XajcvnOi6EbTfL/Y6jP3F8Rw6L/P8Oho75ymm45yhdvej
         5ciQ==
X-Received: by 10.236.133.235 with SMTP id q71mr726665yhi.13.1369809608871;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id 10si572432yhj.6.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B06A35A4022;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 55481100D54; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl7DGAJEOMxYg6BFEsNVKB7v2SDRNDZVplwmZpVdB3H97hTzsAVTJXOIH/VIENq4V7zkNmuXUfYcd/mzvq+l4PXCzsXwomxRq+LdKYPQAEqM6Dn+DiQkF79MiDgRuqQ1FZ6e7hQytJgw+e1hg8JJBhm03PmB8xs3OrITyK3K2OQPq+dDDYaTsclGSo2iDK9oDn4toaW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225755>

Update the following:

 - Quote 'setup'
 - Remove blank lines within test case body
 - Use test_commit instead of custom quick_one
 - Create branch "topic" from tag created by test_commit
---
 t/t3406-rebase-message.sh | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index e6a9a0d..fe8c27f 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -4,27 +4,17 @@ test_description='messages from rebase operation'
 
 . ./test-lib.sh
 
-quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
-	test_tick &&
-	git commit -m "$1"
-}
+test_expect_success 'setup' '
+	test_commit O fileO &&
+	test_commit X fileX &&
+	test_commit A fileA &&
+	test_commit B fileB &&
+	test_commit Y fileY &&
 
-test_expect_success setup '
-	quick_one O &&
-	git branch topic &&
-	quick_one X &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Y &&
-
-	git checkout topic &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Z &&
+	git checkout -b topic O &&
+	git cherry-pick A B &&
+	test_commit Z fileZ &&
 	git tag start
-
 '
 
 cat >expect <<\EOF
@@ -34,12 +24,10 @@ Committed: 0003 Z
 EOF
 
 test_expect_success 'rebase -m' '
-
 	git rebase -m master >report &&
 	sed -n -e "/^Already applied: /p" \
 		-e "/^Committed: /p" report >actual &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'rebase --stat' '
-- 
1.8.2.674.gd17d3d2
