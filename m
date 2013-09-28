From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/10] run-command: trivial style fixes
Date: Sat, 28 Sep 2013 16:51:44 -0500
Message-ID: <1380405106-29430-9-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:58:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2Wa-0002PV-QA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab3I1V57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:59 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:61544 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab3I1V54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:56 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so4185969obc.1
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SPE0jYSaox4nooKr7I2ZUu+7UfiKbNTWlnxnfC+RZZY=;
        b=I7jHpIFxOhXE8eZtD8OYrgZfZGrorb6wBo8LtxZqhYrpw9UsQLFSRZnzd3fJtXwjh0
         DrOjmGLs55BCn3BwjT75E51vU0S8NqsvGFXoMKoovh4HVpr4eULp1Bdwa1c/TANyau1F
         SXRYbMBcCRXlcjUFSc2lAOaBssgL4wQhmagcu1sfVzHqfteoYwWhF9tTWrf3k7c5szd6
         QtSFJSMBk68nTF+S8wTnTJ0ORZuujlH9Mzl5uMdGSf6sZlC1ftuT9HQ40jGvpaF1OSrg
         QqhJLxAPGfvvsoX85wuKOjE+JEsOLxooHufFpyDM99gs8tR61VGl7FgOv77XNpmxRjrB
         LoBA==
X-Received: by 10.182.130.131 with SMTP id oe3mr12395234obb.34.1380405475887;
        Sat, 28 Sep 2013 14:57:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm19432912obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235517>

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
1.8.4-fc
