From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] git-completion.bash: add diff.submodule to config list
Date: Mon, 29 Apr 2013 18:19:38 +0530
Message-ID: <1367239781-5232-3-git-send-email-artagnon@gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVL-0002Ed-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab3D2MsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:18 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43333 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab3D2MsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:16 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1968310pbc.31
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kGMIsZOhgNX6LF9o/eMekoff6ZQV5C7nEaCoD9a+mcg=;
        b=sVt2RUfJDlnx68jpTFvWpUYwuJO76n8auek1DvE1gNC87ywHeQzL3Oaziy5YLx4XSt
         eG0Knspo/lVuIM5ZQCRGnTO5cNKLf/xmZZLPWzExw8yUUMOcrcywH70mTc6XJrY001vd
         9qGGMOMoqPCFQixArVoaIJLhZAUNd3zE1CMMk879iNvGc2KQeJcVklT+eUZqUhkjVM+O
         fpvwWEJnVRY7vB2NB0sf7k7MBXWpEKY/Up8t6HQ+rJnf/LmcGoG7mzgCT5JpV3FevGYc
         rMOOOa5iCY/FRw5oK48H8vj1XPQ17qaqRZfBqsjt/8wMP8+ut7SzMhw+JnBxHmq/VYfN
         yK7g==
X-Received: by 10.68.255.130 with SMTP id aq2mr7777330pbd.164.1367239695670;
        Mon, 29 Apr 2013 05:48:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222787>

c47ef57 (diff: introduce diff.submodule configuration variable,
2012-11-13) introduced the diff.submodule configuration variable, but
forgot to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 61ccb19..ba46cd9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1857,6 +1857,10 @@ _git_config ()
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
@@ -2058,6 +2062,7 @@ _git_config ()
 		diff.renameLimit
 		diff.renames
 		diff.statGraphWidth
+		diff.submodule
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
-- 
1.8.2.1.616.ga1e5536.dirty
