From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/20] add: avoid yoda conditions
Date: Sat, 12 Oct 2013 02:06:59 -0500
Message-ID: <1381561636-20717-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOI-0005bT-41
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab3JLHN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:26 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41545 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3JLHNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:25 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3079689oag.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0fzOMYQ9eBc/yqE0pIxrqKWMAffC8R/pHx2idkpnO+I=;
        b=JOH7RCrrmiUr+KAY+xT8X8VhA21WwzCaN2SBNhTwAi4wHGGqDYrnLglCVRNE6m0vyF
         TDsSv2K7/gpKRdHZSi2iEkYRYk1QTpgR8tDudDPBDitNUr+RriF/lo9KAbXVIaM1a1wU
         ZLaVCyOH2Sm0P/VN81gjITBboa9Y3sJK44/O4UGTME93q67maKIkZfjfL4lmwcc5EZ08
         7o9TkpVRFrwIe6nJ+jmivbHUzS9RsU1Weysqr4kyYwe2Y6IBOLKniM7X55srRk3iUs3J
         eM0PldfFZmixjdXJn0DtN+sZJyeZZ+qLF0RY2GSy9Sy+58t2slaJcDRpvH6WTTvgbhh6
         o3/A==
X-Received: by 10.182.18.9 with SMTP id s9mr10359237obd.15.1381562004625;
        Sat, 12 Oct 2013 00:13:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm28638407obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236013>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 226f758..9b30356 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -429,7 +429,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if (addremove_explicit >= 0)
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
1.8.4-fc
