From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 2/4] t1505: add tests for '-' notation in rev-parse
Date: Mon, 30 Mar 2015 13:41:53 -0400
Message-ID: <1427737315-7229-3-git-send-email-kenny.lee28@gmail.com>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Cc: gitster@pobox.com, Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:43:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdhr-0002mt-F7
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbC3Rmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:31 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36151 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbbC3Rma (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:30 -0400
Received: by iedm5 with SMTP id m5so124217288ied.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5qOKuRB/2+DEKCqE2vI5LxMkJuqkD+o8/kCwhfZ8KI=;
        b=CE9Cqnc2EDYD+FGHsMgKjrF9yAa/QxMsAyjsM0esE8nSkdeYDM9JsR+StA6OqCHVX9
         uKiN3IcLjoQLnoDBoesGeHFX59NFo2GVMjw3by99ZwrXLp7q3qFZJ2buY33zuo2TMqfl
         Y2EkExGfPc0zRlLdrXWtRADb9pqjnJRFYRK6IgZGf+0PGuj0SmhRYuzPBS5FtQTWGMUO
         mbAKTac0NrXAxJ25sssEuOgRlpxy5/Comg7sNhQF/K6cd7WiFziVF24Gvf202bsui+RS
         pOCdZgrUd4uBlt3bGMcmz/zXr3l4hBnQLRvryOIHu1QCbMa0HAlLg5WFmm8JIc8IgaER
         PHWg==
X-Received: by 10.42.240.4 with SMTP id ky4mr61473126icb.70.1427737349747;
        Mon, 30 Mar 2015 10:42:29 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.26])
        by mx.google.com with ESMTPSA id x9sm8246356igl.2.2015.03.30.10.42.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 10:42:29 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.203.g8ffb468.dirty
In-Reply-To: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266464>

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 t/t1505-rev-parse-last.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4969edb..a1976ad 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -33,19 +33,23 @@ test_expect_success 'setup' '
 # and 'side' should be the last branch
 
 test_expect_success '@{-1} works' '
-	test_cmp_rev side @{-1}
+	test_cmp_rev side @{-1} &&
+	test_cmp_rev side -
 '
 
 test_expect_success '@{-1}~2 works' '
-	test_cmp_rev side~2 @{-1}~2
+	test_cmp_rev side~2 @{-1}~2 &&
+	test_cmp_rev side~2 -~2
 '
 
 test_expect_success '@{-1}^2 works' '
-	test_cmp_rev side^2 @{-1}^2
+	test_cmp_rev side^2 @{-1}^2 &&
+	test_cmp_rev side^2 -^2
 '
 
 test_expect_success '@{-1}@{1} works' '
-	test_cmp_rev side@{1} @{-1}@{1}
+	test_cmp_rev side@{1} @{-1}@{1} &&
+	test_cmp_rev side@{1} -@{1}
 '
 
 test_expect_success '@{-2} works' '
-- 
2.3.3.203.g8ffb468.dirty
