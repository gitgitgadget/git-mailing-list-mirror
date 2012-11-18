From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/6] completion: add comment for test_completion()
Date: Sun, 18 Nov 2012 11:51:52 +0100
Message-ID: <1353235917-13059-2-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2UM-0004qt-LF
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2KRKwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab2KRKwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sb3hb32OgpKKDHdU8N1g7Ee1kDS90G8mwJrMKSJkFqE=;
        b=FrE9pItj8UTinclkYBHLFL42TxT9Fme5aLM0mxlgYucQJmUhXKL3MgG1ja5/6KLtOv
         j7jIRxV7qnKnLVDmgdZLS0PY1Y15cxIzBJdNab2eAzq6yl7eKGfEF3ob3SMJZK58Dg+/
         HzchHcdI9MTT8KzKAxExfGRR7Qw941pToA+UM5V/douc4rmasN3AjF5xdhRkGgEMg6av
         OzSsnv3d378LjXYFKdBlPVU58dpvt32R7Y5jYn2R9LqgQ9+wr+xoj5TGR6llcNo1DPwy
         uam+suuH0PGifPkKY8sVrnVHp2QoiyE5CXmXca29Ue4HT23pBqLilE/trOhVe8N7bruL
         UOYg==
Received: by 10.204.130.10 with SMTP id q10mr3871265bks.59.1353235937578;
        Sun, 18 Nov 2012 02:52:17 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id a5sm851156bkw.8.2012.11.18.02.52.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210006>

So that it's easier to understand what it does.

Also, make sure we pass only the first argument for completion.
Shouldn't cause any functional changes because run_completion only
checks $1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8fa025f..2276a37 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -54,10 +54,14 @@ run_completion ()
 	__git_wrap__git_main && print_comp
 }
 
+# Test high-level completion
+# Arguments are:
+# 1: current command line
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
