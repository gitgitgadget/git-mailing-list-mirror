From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: trivial test fix
Date: Fri, 11 Apr 2014 18:24:05 -0500
Message-ID: <1397258645-15336-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 01:34:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYkxY-00067f-0b
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 01:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbaDKXeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 19:34:07 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44851 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaDKXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 19:34:06 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so6840569obc.16
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H7kjb9MPeFqnAxTkQc+1ETKQDeOsufj6K+Um/88eFiQ=;
        b=NFTzZdrfJeB3p6588hijHF95Q9pllfA/PT9Y7zKma2kPbZwA2q4gEoew0b/vHXB23x
         xBym0LC6gjJ7q5SEC2h0ASJplyUJM1iAI3u/IwoL+3+AodTzG1jFz1eJYgoQHEytI9GI
         4OJk1QLCls189ZlDJpMH15ADu8Tba6DCSPT2EFnBWEDlkRmQnatyFS2XqoCW/QBgzVSW
         IbGVux1GvMndhaTaM5Z+24sWBS2P5zouWLpXquds72EHX1L6i1PKt9UMDCUbqz9F+1Sp
         4VPSy3tWQ4cr8Zt3tht9ET+s8AKjNOH3CRAffArnivaOdBIvHC/kNq3nuE0b/tfSiT9E
         8lNA==
X-Received: by 10.60.125.72 with SMTP id mo8mr21943657oeb.36.1397259245064;
        Fri, 11 Apr 2014 16:34:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pv6sm14810584obb.1.2014.04.11.16.34.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 16:34:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246157>

So that the committer is reset properly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 1e53ff9..f5c90a4 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -362,7 +362,7 @@ test_expect_success 'strip' '
 '
 
 test_expect_success 'export utf-8 authors' '
-	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=C && unset GIT_COMMITTER_NAME" &&
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=C && GIT_COMMITTER_NAME=\"C O Mitter\""
 
 	LC_ALL=en_US.UTF-8
 	export LC_ALL
-- 
1.9.1+fc3.9.gc73078e
