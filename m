From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 6/6] merge hook tests: use 'test_must_fail' instead of '!'
Date: Thu,  6 Mar 2014 15:50:24 +0100
Message-ID: <1394117424-29780-7-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:51:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdU-0005NE-G8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaCFOuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:52 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59143 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaCFOuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:46 -0500
Received: by mail-wg0-f45.google.com with SMTP id l18so2760942wgh.4
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=b2OoqyyRxhxGL2NuxTjIESaDk448GvqtsreAtjl0d0o=;
        b=krstrClct1Dre2nDFYDz8awZv84yr9B5YswHMxdt0SnUBknYTBptPerGIuvTLy65We
         +Q8huVN9IOLRpfjOJ662pP+zYDRPReMCaYmLjB5PZv7wFp8Lw6aRC+Lx2AD7nCix2zM6
         hv8vHzVWzrLG4PFF1waiNXQXJNs3TibD7gMQQwmBDOxXtsbNZ71DF7Yjj8erfW341PuF
         Lgq8nVEKgHm8Y9CgHP1leML2hHth/BFc/diBZo9CsDG3++hUF5Hk+EMfU2EiP26lNNWl
         C9OrbKBBdM6m2Six8kD2UxvHHrXyNTy449FzWfXhNtZ3yLcQfQFDpkHaHh8DnQQ7ORxK
         YTlg==
X-Received: by 10.194.59.210 with SMTP id b18mr10781958wjr.60.1394117445300;
        Thu, 06 Mar 2014 06:50:45 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id ju6sm17983913wjc.1.2014.03.06.06.50.44
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:44 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243517>

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 604c06e..1be6cec 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -167,7 +167,7 @@ test_expect_success 'with failing hook' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
+	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
 
 '
 
@@ -177,7 +177,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
+	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
 
 '
 
-- 
1.9.0
