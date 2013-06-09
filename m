From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 31/36] rebase: trivial cleanup
Date: Sun,  9 Jun 2013 14:24:45 -0500
Message-ID: <1370805890-3453-32-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI1-00048m-ML
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab3FIT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:15 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:47509 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3FIT2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:13 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so5177808oag.36
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hWn5iOXexO3POUrlAMQElGpq7Esg2SnIXJKN6Kpn3CA=;
        b=YphpHG64Ifa4NOBDx/X92NsZmhUxi0hTV3PAVrqWXKJKzqkgnp9yvJrUxv/D4Ze324
         VDK/PzJ0+cbGjbBdlsk64IH1YwkpjYC8knE2V3Oo4RWkWNSGXQMcVtFnxxuIJCMTupII
         Zdtqh1VCmi2zHY+wFRReOW0r9SHU2Oh3Qn9Xmfje6QP0FJtE/QIKSQCc+8uIpiF3ilQ9
         5ij7SOE2LpeEWTELN+ukZcLOk6YPnEaW9nO1+SulpUii75FyvrIC+ghsA4E17/TnwlNV
         Qu6nTOe9183zsBFMbQMCa+NklURJPU/5ygdBtaZIa5ZyRb816okAtnTg50hBqP85TFNF
         t4bA==
X-Received: by 10.182.220.232 with SMTP id pz8mr5727870obc.9.1370806093191;
        Sun, 09 Jun 2013 12:28:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm15957922obz.11.2013.06.09.12.28.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227138>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--am.sh | 1 +
 git-rebase.sh     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 6460028..2ce7570 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -51,6 +51,7 @@ then
 	return $?
 fi
 
+test -n "$GIT_QUIET" && git_am_opt="$git_am_opt -q"
 git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 0937e2c..6be247d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -285,7 +285,6 @@ do
 		;;
 	-q)
 		GIT_QUIET=t
-		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-- 
1.8.3.698.g079b096
