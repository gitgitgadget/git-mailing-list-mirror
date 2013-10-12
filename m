From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/20] run-command: trivial style fixes
Date: Sat, 12 Oct 2013 02:07:11 -0500
Message-ID: <1381561636-20717-16-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOh-0005u7-Sb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab3JLHN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:57 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:36860 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:55 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so494757oah.22
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SPE0jYSaox4nooKr7I2ZUu+7UfiKbNTWlnxnfC+RZZY=;
        b=y8G4xksS1rP12rScr7xH0nfgUj6r4huLehNMi7mDisbijLjcyHH5K4iarZWOOCOpFV
         Wx1cPUAYQFzbNMxTOxMfRCLh5dZbyMmJpRayXGDI1/5y4BR+g1JVgydS3h5VEumjxXSy
         wLl1+PvOQ+65YCutUWvlmpwxpJou4dFEB5eB+P1Qjo0qR51PtSfqBH/2mfUMI1dE4ij5
         oc1mfP+SafiHXJw95SYbHGRZuvh6RgnkdEmdHqxQyaDB/vtD/b4GCPkPpXeeYcoWbs/n
         puIYhGeWHCD3ckUUdjob+gA7Mn3J/5uLc9Spn9qiRBV09W3Y3jS50vCXXajoi9PMjjBc
         E4fw==
X-Received: by 10.182.129.201 with SMTP id ny9mr17908173obb.0.1381562035148;
        Sat, 12 Oct 2013 00:13:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm101404166oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236023>

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
