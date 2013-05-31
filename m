From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 6/7] t3406: modernize style
Date: Thu, 30 May 2013 23:49:46 -0700
Message-ID: <1369982987-18954-7-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJH6-0003xZ-4H
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3EaG5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:57:17 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:47804 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab3EaG5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:57:15 -0400
Received: by mail-yh0-f73.google.com with SMTP id a41so113900yho.2
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=xYWZZqOcVRLM5aNxSG6fqs9XaM5K+ARdLULG3Sj+QWU=;
        b=SUhS4usiYU8/dwDpE2NAwTBkkLIjKryQChsmpmh5BWrirAYtFiZxFtx7HoqmEgzSTQ
         yu/hOuFMoHzHFbmSdllwl4zMqLRWGni5k4Ex419I4F+WeaCyhKjisQXdq1uk5kb17Y6U
         RAkqfsBJHizC0c2MZih/EA+IRQ3xmqF6/WA/B4IMDClXZdtFffGzlOdiQjOGvrTdu2Cw
         n+8zymeh/K6ljR2vF48zWBn6sFyqhzGE2oyY3rVBJccb/L0oD2fv9ezPY+pZe6b5yzUl
         YfX38VfWcXJZ8z7MrwE3dIFzZPkljZ98D02eWNaAAQ2Sdh0dvdF4cO/jjdDmvAYFf1bE
         89iw==
X-Received: by 10.236.112.226 with SMTP id y62mr5682100yhg.14.1369983003853;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n78si3624271yhh.1.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AAF9F5A405D;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 425511010E6; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQk5gBPIX8+E5KHUl7p/UxhN+XIIp7bH6jD+g6UbEAKpMUMlJbW+6GwL2ShQOK9iwq6DR/mrQcMqs6j9Yxv5j0lNJWhl/LYInPyKxO8hlwy/73d+zl7yF/3o29Cz2/RwAdcjUyL1jZRdfkK30JGcF7PcTy/CHe6jnKqlx9K+jA618hLWSACk8f1MaWASwSJ2vPSKirau
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226057>

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
