From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: fix post rewrite hook report
Date: Thu, 30 May 2013 08:46:35 -0500
Message-ID: <1369921595-30514-1-git-send-email-felipe.contreras@gmail.com>
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3Kd-0005IO-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070Ab3E3Nzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:55:51 -0400
Received: from mail-gg0-f179.google.com ([209.85.161.179]:33916 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab3E3Nzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:55:50 -0400
Received: by mail-gg0-f179.google.com with SMTP id c4so52029ggn.24
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3NMkFHlHf0VYzffd5atjzjXbacGvALUDAO9rPWt9Q4U=;
        b=OywlzqkfungcObp/Y94+R4GXoSWWPofZJOHRm7U1lNMhmgV8m6oHWzRv2qr+yyuSTk
         iK/dJAQXRUnJwFFJAtBqrEwBFFliRAX3vyQimoUmPrtwDLbN12Nq3TRPr59fjAdQCgea
         9TIkGDbTkPyzTmXJ9fUMJSuTSQwIapV8WUIS/7OdVZwq269u43kV4GnJEv2lRnQ7WvJC
         AZV0cESQC6Ghvop7rOJTs/qQbFCYi7WsUzNZTuegJR8xLZq7bjGBTBaTxTUn5hNxlZaQ
         LhDCXzfaDMVUB1oy2Shz9EyCeFxqsGKoRWHyOfaJJznUv5EGoZTHIZBJGqcZ/31mzewW
         +fsg==
X-Received: by 10.236.81.132 with SMTP id m4mr3825478yhe.7.1369921697722;
        Thu, 30 May 2013 06:48:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d24sm28669818yhi.17.2013.05.30.06.48.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:48:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225995>

First expected, then actual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5407-post-rewrite-hook.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index baa670c..ea2e0d4 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -31,8 +31,8 @@ clear_hook_input () {
 }
 
 verify_hook_input () {
-	test_cmp "$TRASH_DIRECTORY"/post-rewrite.args expected.args &&
-	test_cmp "$TRASH_DIRECTORY"/post-rewrite.data expected.data
+	test_cmp expected.args "$TRASH_DIRECTORY"/post-rewrite.args &&
+	test_cmp expected.data "$TRASH_DIRECTORY"/post-rewrite.data
 }
 
 test_expect_success 'git commit --amend' '
-- 
1.8.3.rc3.312.g47657de
