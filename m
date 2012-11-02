From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 12/14] fast-export: fix comparison in tests
Date: Fri,  2 Nov 2012 03:02:16 +0100
Message-ID: <1351821738-17526-13-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bg-0001Jy-88
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992657Ab2KBCDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992623Ab2KBCDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bTnm+CmVUrNYT/wITL54y6HoBLAkQQwPed0RZ3wh4Qk=;
        b=cnIkyo0QmTyWHYP27sJaXD90A0RPAfcckk2nxqDhHRPcgDgdCECRQVq3er+p4idpOK
         hG3H6hW22Qn5LJwcnHAtX93P/yWSYOpE6sTP2V5kFnzLPpnfD0kclX68VGsG47D+lKkN
         4T/hkiuRNAQ+Gt3wUFVt9fDWe+aAd4BXGAfD4G2MSv58yO8+A8/QKsf2AVOeDJG6gVki
         ww7qJtxD5xpn1pXVRWNOz5k+Z8mMsdZIj7EY7LjZnkYnGc4rOjXs37MhiTnVPnWbdRED
         KtN2YM+6nkJ7Ip/5ZOv0dQYB0sKwZGr/V8f1kMIuX5/DbgPS64x0kZKnAJkYzAp6UPB0
         73JA==
Received: by 10.204.9.136 with SMTP id l8mr23494bkl.78.1351821795752;
        Thu, 01 Nov 2012 19:03:15 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id r15sm5771388bkw.9.2012.11.01.19.03.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208910>

First the expected, then the actual, otherwise the diff would be the
opposite of what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9350-fast-export.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 0c8d828..b7d3009 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -303,7 +303,7 @@ test_expect_success 'dropping tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -320,7 +320,7 @@ test_expect_success 'rewriting tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -351,7 +351,7 @@ test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
 		git fast-export master~2..master~1 > output &&
-		test_cmp output expected
+		test_cmp expected output
 	)
 '
 
-- 
1.8.0
