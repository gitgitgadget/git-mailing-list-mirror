From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] t3400 (rebase): don't set GIT_AUTHOR_{NAME,EMAIL}
Date: Fri, 10 May 2013 19:59:35 +0530
Message-ID: <1368196178-5807-2-git-send-email-artagnon@gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoJB-00020i-0n
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab3EJO2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:28:05 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:49915 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab3EJO2C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:28:02 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so2839460pbc.3
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TDloxpguuZTZMoIPQyCZ0to36J70wGVUBHjN3jCTbs0=;
        b=eDj2JipN73BgAwptedl72+kRNvOBCmDjxFURL+TmktDdH85hxyycBcycPlKel1axww
         Ch9t1NbMRZ6ptALlUa8Wyp4PhD4m6NNJOIpZUCbjqYpXByn3d6XeCgAVlqAWZ1/zOYs9
         g0d7HbaO03jAClWEMETENmgy8zEyAWoNZArvflLwAatVopTim+yjrS6Q99StexhnwFDx
         0YooRQ4nDL/zB7nTGYUTC9RGRI5NL1cMCY0pf6mINvCXgcA2lolLrDl+Hq/7h+/5/+hL
         oY0kpvaiMBiHf4eL3HM9Pce/Z/d9s8PSpcj6kiy8VJSvhjrw7Aw/CVHbw3lEX21PfUUO
         9JGw==
X-Received: by 10.66.146.74 with SMTP id ta10mr17954010pab.60.1368196082249;
        Fri, 10 May 2013 07:28:02 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ih1sm2885215pbb.44.2013.05.10.07.28.00
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:28:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223848>

test-lib.sh already sets a sane GIT_AUTHOR_{NAME,EMAIL} for all test
scripts to use.  Don't unnecessarily duplicate the work.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..a7ca2f1 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -10,10 +10,6 @@ among other things.
 '
 . ./test-lib.sh
 
-GIT_AUTHOR_NAME=author@name
-GIT_AUTHOR_EMAIL=bogus@email@address
-export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-
 test_expect_success 'prepare repository with topic branches' '
 	git config core.logAllRefUpdates true &&
 	echo First >A &&
-- 
1.8.3.rc1.52.gc14258d
