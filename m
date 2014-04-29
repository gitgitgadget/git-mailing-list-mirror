From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] add: remove dead code
Date: Tue, 29 Apr 2014 16:49:38 -0500
Message-ID: <1398808178-3703-4-git-send-email-felipe.contreras@gmail.com>
References: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG4o-00079h-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbaD2WA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:00:29 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:53242 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbaD2WA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:00:28 -0400
Received: by mail-yk0-f179.google.com with SMTP id 9so773511ykp.38
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I4c/+g5rt66R3K5KqoZhQR09dYO6sL9rsWjffeFz/rk=;
        b=b3JueCE0np+4+eqqC+rFlsz/gSJkHtUyU+NbGFLa/pwV5687x2lnP864TXhvi8p3Cz
         L0Okq/+bLMr1EvfHQU5uUA/T4OdULD84dNuZPVzrjhcsMd99A9EPGUrvNWatMcZgI32x
         1qCRTF6If4mNZVAp5aUK8C/sDwz5RFp87mICgTRj/Gi/gtpOS5aPsySBiJRtLwWha3t/
         ls7cP7qVCcjkqGAYF9UN/upbfmC1QcFVja+kIBSJnnFsqww/YGETvadXfg2ax9k52xn2
         md7G1tdMg3ZfVCHfjDSHq4WR8FTaHoMkNfyiEW662MOU8MYHEyn44WNLf5PZhCIzCtUx
         +ylQ==
X-Received: by 10.236.93.16 with SMTP id k16mr615649yhf.140.1398808827821;
        Tue, 29 Apr 2014 15:00:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c24sm39114810yhc.2.2014.04.29.15.00.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 15:00:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247621>

addremove is already 1 by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ac10bab..980e247 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -329,10 +329,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/* Turn "git add pathspec..." to "git add -A pathspec..." */
-		addremove = 1;
-
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
-- 
1.9.2+fc1.3.gade8541
