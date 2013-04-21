From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] git-completion.bash: complete branch.*.rebase as boolean
Date: Sun, 21 Apr 2013 18:35:49 +0530
Message-ID: <1366549551-18763-4-git-send-email-artagnon@gmail.com>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTty8-000783-J3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab3DUNGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:06:07 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50824 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:06:06 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so3059851pab.35
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UTs3wPHDOSjVDbFvMPdLqAchh87Ne/kyCNw/8fKBgMA=;
        b=LcyYYNDoMCb7wOvHBNq0hqJiJxHmLOKGSDgAjt1N9SulTaMh7DXX7gIIBK4W08Doj1
         Z31RVd+mFIJUHn34CEQUH+rcohydf7MsqGapEMeP8n11eLBW6/FL1bHaJqHa7UxAidEm
         t1z2nEncmA+22QPj6vfIO5GOt3nkb82irKCJfgF+BxhDs27q7XiDmbeHJDzBYzS7ZdXE
         TIR9oudYI5zOkPV6dq0tIVFv4wJDUsOqCxDGK4R/s7AXYRBzORZ7+jL2o93ppZscW47M
         n+iSO8Bq4z0chfo4vUMhsPDIB2CB7V3MCWNHFZP0JnSKG9FOdOi8BOhoWJLBIoNa8r8y
         yGzw==
X-Received: by 10.66.240.70 with SMTP id vy6mr7524893pac.70.1366549565560;
        Sun, 21 Apr 2013 06:06:05 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.06.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:06:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221950>

6fac1b83 (completion: add missing config variables, 2009-06-29) added
"rebase" to the list of completions for "branch.*.*", but forgot to
specify completions for the values that this configuration variable
can take (namely "false" and "true").  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f799dc8..843273c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1825,6 +1825,10 @@ _git_config ()
 		__gitcomp_nl "$(__git_refs)"
 		return
 		;;
+	branch.*.rebase)
+		__gitcomp "false true"
+		return
+		;;
 	remote.*.fetch)
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
-- 
1.8.2.1.501.gd2949c7
