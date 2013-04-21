From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] git-completion.bash: add diff.submodule to config list
Date: Sun, 21 Apr 2013 18:35:48 +0530
Message-ID: <1366549551-18763-3-git-send-email-artagnon@gmail.com>
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
	id 1UTty8-000783-2z
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab3DUNGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:06:05 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58450 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:06:03 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1137855pad.34
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Rae5Iy6EQoqyL6/qLt+shmexAMLLXPM/MSgTLsZt8PY=;
        b=CWud9rBiTmCIIt3fGd+HAihEb2n8bFVccv6UbzBQcrqzeSRlS7y+Z0t9NSGD/WD/P+
         P6P8dOixPgHVFlupSQ+hiv0ZduKs4tKOHMrAAFQ0a+YYTrG/KCe2GTJoIxeIR2BFP1+r
         CqTKztfsjjOIdaxy0eIw4kf+AVEsDxJ24+Z6noYfeqhXdL0Vs89R9ssr2bhQVdbKjvGK
         hQnxlzzTnMbbP7R/C95typqoEAvNRT58TeskyvtMaKfJSBfeCF98Yn/Ht+hyFx/gvUqV
         Byi8nfMSPs4AXm6DmbFIUC4wTrTOBVzQwJlPV3EPZdCg11j/YNo7hBmSwkTnde1Xeauu
         SSFg==
X-Received: by 10.68.97.130 with SMTP id ea2mr26803587pbb.129.1366549563116;
        Sun, 21 Apr 2013 06:06:03 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.06.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:06:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221948>

c47ef57 (diff: introduce diff.submodule configuration variable,
2012-11-13) introduced the diff.submodule configuration variable, but
forgot to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6bfb9ad..f799dc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1864,6 +1864,10 @@ _git_config ()
 			"
 		return
 		;;
+	diff.submodule)
+		__gitcomp "log short"
+		return
+		;;
 	help.format)
 		__gitcomp "man info web html"
 		return
@@ -2065,6 +2069,7 @@ _git_config ()
 		diff.renameLimit
 		diff.renames
 		diff.statGraphWidth
+		diff.submodule
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
-- 
1.8.2.1.501.gd2949c7
