From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/4] git-compat-util: don't assume value for undefined variable
Date: Tue, 15 Nov 2011 23:01:09 +0530
Message-ID: <1321378269-13867-1-git-send-email-artagnon@gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMsK-0003ZX-D4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab1KORcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:32:43 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33315 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825Ab1KORcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:32:42 -0500
Received: by ywt32 with SMTP id 32so3712916ywt.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uQbLcg/IXXWj7GobI2Gun0RzyuvCZcti4Jk5BGHN0ws=;
        b=Grr0+du/aiP86Hl8lxFLXgNIPnE37kjfMNvS+AVr2Q+YfOmoM9iXnho2maPIo+1M2Z
         vCaXcC+OVTJwzYEdqwTbVRcc6u/rIlmbe3uJ3i3hVYSggwuM/m/2JtaXKX+lv/cUUojk
         F/jv02kUwaPhuD/jI+cYpbvqUdR/iDfdj0D4A=
Received: by 10.68.24.234 with SMTP id x10mr60326301pbf.97.1321378361772;
        Tue, 15 Nov 2011 09:32:41 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lk8sm66516806pbb.4.2011.11.15.09.32.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:32:40 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185472>

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 And here's another probably worth fixing.

 git-compat-util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..8b4dd5c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -219,7 +219,7 @@ extern char *gitbasename(char *);
 #define find_last_dir_sep(path) strrchr(path, '/')
 #endif
 
-#if __HP_cc >= 61000
+#if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
 #elif defined(__GNUC__) && !defined(NO_NORETURN)
-- 
1.7.6.351.gb35ac.dirty
