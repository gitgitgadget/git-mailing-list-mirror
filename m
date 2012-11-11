From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/6] completion: add comment for test_completion()
Date: Sun, 11 Nov 2012 15:35:53 +0100
Message-ID: <1352644558-9410-2-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeN-0005xu-1n
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab2KKOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:18 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KKOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:17 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5DCbcOWYiLYWc5VxidJAcBRn835Ba0KY9pyrfyxxV24=;
        b=SAFjlIpfm4lVfopzCkVsWtIAdW82BITZ2dG3q2nNa4JDa0sLEjhfU6obHBBdHc9gNt
         fo9NfE0NQ5Jbp4Gmfk9GYhJ33EWO/BFLTR5pmPRYc1An+bPYp7DXpuyodoo4696Bt0uN
         EnPJpNvKhGfa1SU/vQc7G+YeZwxUf8XZ6s1MbKORqCL9bCW+7579qqzLkdjFX1srlget
         SdyVpBxoLXn5PXZeaJPoHjdOYdQeB7BVwtOXXA+zyakSqUWzgpMEt4jIvS++px3EOu+3
         zCgqyYQrX05ihjqTAaNAbyPd3DIbCgmJ/TF0fmYGlf7EAty1KDJa2ZC7aWyodTz0kXqg
         Ajlg==
Received: by 10.204.150.211 with SMTP id z19mr6015060bkv.60.1352644576818;
        Sun, 11 Nov 2012 06:36:16 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id e3sm1518534bks.7.2012.11.11.06.36.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209384>

So that it's easier to understand what it does.

Also, make sure we pass only the first argument for completion.
Shouldn't cause any functional changes because run_completion only
checks $1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..5c06709 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -54,10 +54,14 @@ run_completion ()
 	__git_wrap__git_main && print_comp
 }
 
+# Test high-level completion
+# Arguments are:
+# 1: typed text so far (cur)
+# 2: expected completion
 test_completion ()
 {
 	test $# -gt 1 && echo "$2" > expected
-	run_completion "$@" &&
+	run_completion "$1" &&
 	test_cmp expected out
 }
 
-- 
1.8.0
