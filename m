From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/16] run-command: trivial style fixes
Date: Thu, 31 Oct 2013 03:25:45 -0600
Message-ID: <1383211547-9145-15-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocz-0008Mw-2T
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab3JaJdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:17 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56415 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab3JaJdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:33:03 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2781152obc.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZeLbOKRRdolavNh1I8sYLhfeNHapnH2LFNxKm74q59w=;
        b=cCmWu0APCIEU+K61VogFmlSw3yhY53iNXdM5Q4X4rON7inJzjk/HRIYK+tX3chUoIv
         ptz1nZXVFwICdWdIH9+dCIFqc5u7ePVE3ogdawqAGdq275fBv5LZh8H5E7h5mvudM8X5
         3L/XxQ55mYs7SwP6Hza43ODUDfElAIYd0h+0x2cYxBMJszcG2B5nAHtE0/2LchMMmMLb
         8LXsQFoShp334SrcfXu3gmlOAPH9CLHXHOBRaqasO3gbULttiJbRvIGucAqDYy+OdwfE
         GvizuUMxRCiOEzhzFt9KRBmwEyGTWQV1NQ7N7cj4Nqox1kb69LJ1+RD4ebytcJccoZIP
         HD+g==
X-Received: by 10.182.129.42 with SMTP id nt10mr1799414obb.19.1383211982100;
        Thu, 31 Oct 2013 02:33:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm4484993obo.7.2013.10.31.02.33.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:33:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237100>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1b7f88e..3914d9c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -406,13 +406,12 @@ fail_pipe:
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->git_cmd) {
+		if (cmd->git_cmd)
 			execv_git_cmd(cmd->argv);
-		} else if (cmd->use_shell) {
+		else if (cmd->use_shell)
 			execv_shell_cmd(cmd->argv);
-		} else {
+		else
 			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
-		}
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
@@ -446,7 +445,6 @@ fail_pipe:
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
-
 }
 #else
 {
@@ -480,11 +478,10 @@ fail_pipe:
 	if (cmd->env)
 		env = make_augmented_environ(cmd->env);
 
-	if (cmd->git_cmd) {
+	if (cmd->git_cmd)
 		cmd->argv = prepare_git_cmd(cmd->argv);
-	} else if (cmd->use_shell) {
+	else if (cmd->use_shell)
 		cmd->argv = prepare_shell_cmd(cmd->argv);
-	}
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env, cmd->dir,
 				  fhin, fhout, fherr);
-- 
1.8.4.2+fc1
