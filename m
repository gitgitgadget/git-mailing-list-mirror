From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] add: avoid yoda conditions
Date: Sat,  7 Dec 2013 23:56:55 -0600
Message-ID: <1386482220-18558-3-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVD-0004iR-H6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab3LHGFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:46 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61598 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab3LHGEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so2539367oag.5
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6Px1UAPBVhCzMBBBxHr38xDXKWA6chAnrGJPJu+i9E=;
        b=q/XMtGCfXOSOjAMblVEPGIuhlsxSToy+NlL5ev0EG05xt8ae6zTBpeutzeCCJ16MXq
         hu2NVhvRgHGPyDmJQzo5EvgtQwNeb7jF5IGndMYce47iL5o2Gp3yh5C8gfmsHnT31Wxm
         ybSqQK3i1yCBbgmmb2utKs/ju71F7COTdHeW28o5g+O/HwR6MPvQGB5dXJzy/KMwYRSt
         dp/+lHL6sNPnKhtRO3/VYhGMQnvIeOOf8hK7J+eraEH7MwuOacHyKgpruxNnbhZWMmkE
         sukQp3Z5Nh05eOcuZ24APw5NcfZw4kgBi0vHKTv+hyu7bWxdzDez1jQWINHXrDLPZqco
         /1kQ==
X-Received: by 10.182.103.133 with SMTP id fw5mr8746130obb.43.1386482677158;
        Sat, 07 Dec 2013 22:04:37 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m4sm10693881oen.7.2013.12.07.22.04.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:36 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239036>

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
1.8.5.1+fc1.2.gebd1fb1
