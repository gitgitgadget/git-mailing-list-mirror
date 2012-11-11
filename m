From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 07/15] remote-testgit: remove irrelevant test
Date: Sun, 11 Nov 2012 14:59:44 +0100
Message-ID: <1352642392-28387-8-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY63-0007lt-RJ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2KKOA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:57 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:56 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bLcrf5qtmluFFzfc1sNgK9RDBIMxl0NLdNrJYnWIvp0=;
        b=LgJeNsWXQ9uH4TqQpqjL6ZCqQEP/huq36OI1e2GTgoTkPZvQQzvuzOTthcRkV6c1AL
         w5tKf37Z4Onwm+6XwkZiRMJvpVlalZiK2dg9vYR0b5YckWZddzziEPkCZeyDCPXVa96Y
         vx/1T7zQ7MGk2/5PmDwXKRs3R+ubW/qd6wjQxdLYWehLHmekTq37HsWA6IBsivUxAQtT
         zyN7F1hSTWlaYsM7E1tXQcnlDFam5hz3Mil5e36f5DDzsdc8lIaKQogU4zUeyEONtCxa
         3Ss5IeagXk2EAJ1orOCltP8MzdJfFbWfHZmgOUuW/rXqpY1m6ngk9cUT+LFe1x/GLIUT
         4djg==
Received: by 10.204.11.213 with SMTP id u21mr5906544bku.42.1352642455728;
        Sun, 11 Nov 2012 06:00:55 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id gz6sm1177702bkc.16.2012.11.11.06.00.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:54 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209362>

Only makes sense for remote-testpy.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2f7fc10..6801529 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -53,19 +53,6 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
-# Generally, skip this test.  It demonstrates a now-fixed race in
-# git-remote-testgit, but is too slow to leave in for general use.
-: test_expect_success 'racily pushing to local repo' '
-	test_when_finished "rm -rf server2 localclone2" &&
-	cp -R server server2 &&
-	git clone "testgit::${PWD}/server2" localclone2 &&
-	(cd localclone2 &&
-	echo content >>file &&
-	git commit -a -m three &&
-	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
-	compare_refs localclone2 HEAD server2 HEAD
-'
-
 test_expect_success 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
-- 
1.8.0
