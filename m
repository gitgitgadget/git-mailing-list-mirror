From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 19:59:38 +0530
Message-ID: <1368196178-5807-5-git-send-email-artagnon@gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoJC-00020i-4a
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904Ab3EJO2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:28:15 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50030 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3EJO2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:28:08 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so2799394pbc.40
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ws/tHUWARzMJMOLdWU4fw20E3dhjFRC9ssSQptYxteI=;
        b=pRB1Ei/BCKx1N0gKhnB3APNyt20s6tmOwVkQipyI0pVF1DO16/Z+upQzLGcDk3hbt0
         obxrET+TDYMeHfgfzFQv5w+RF9xBscbsB3mhcZudx1VyVgqeFhREmWTC8XC0fq63inSp
         UrU9SistamlqisgXIqYVwoCLM5oS24vlCUnj1QbzEKgfLUT52KKtKoi61hkBdodfmBHk
         yBDpyRicLk+1uWCO2jRTexs8nHVy68Prijx1Dc2TVOXGpMt1OnYJjLn2OdDVk8Sain+n
         Ft3wbnAbb2u5phPjJ2nMt0HSNq89EWiaNhBV5lj99m3RImTAIv1dDxK/RChx3CDAJl9e
         +8yg==
X-Received: by 10.68.27.9 with SMTP id p9mr17266561pbg.139.1368196087922;
        Fri, 10 May 2013 07:28:07 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ih1sm2885215pbb.44.2013.05.10.07.28.06
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:28:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223850>

A couple of tests execute 'git rebase' with GIT_TRACE set to 1, but
this trace output is not used anywhere.  Remove it, since it is not
relevant to what we are testing.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0841a12..d0d9442 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -137,13 +137,13 @@ test_expect_success 'rebase a single mode change' '
 	test_chmod +x A &&
 	test_tick &&
 	git commit -m modechange &&
-	GIT_TRACE=1 git rebase master
+	git rebase master
 '
 
 test_expect_success 'rebase is not broken by diff.renames' '
 	test_config diff.renames copies &&
 	git checkout filemove &&
-	GIT_TRACE=1 git rebase force-3way
+	git rebase force-3way
 '
 
 test_expect_success 'setup: recover' '
-- 
1.8.3.rc1.52.gc14258d
