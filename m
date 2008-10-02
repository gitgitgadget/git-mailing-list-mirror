From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] run-command.c: remove run_command_v_opt_cd()
Date: Thu, 02 Oct 2008 19:14:25 +0900
Message-ID: <20081002191425.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:16:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLE0-00070F-MW
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbYJBKOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYJBKOx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:14:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41921 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbYJBKOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:14:50 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 0DD2AC7B30;
	Thu,  2 Oct 2008 05:14:50 -0500 (CDT)
Received: from 6138.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 274ASYW96FKG; Thu, 02 Oct 2008 05:14:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=J967heZ3tzYkIrFiyN+dA+CpLNyvDzVq9q7v47RAE8O/Mb0kN4eA70Ov5mzm8I9WvliPzqq3c/m7DxUcxRM8grpD2I2DodF8Bw4KEocLdHLtrKVGgURZxnwSCEwbdcvqJKFEe1HUQjq73utLeX7oe41HZLJcfWkQwyS7ip3hZaI=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97304>

This function is not used anywhere.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 run-command.c |    8 --------
 run-command.h |    1 -
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index caab374..c90cdc5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -273,14 +273,6 @@ int run_command_v_opt(const char **argv, int opt)
 	return run_command(&cmd);
 }
 
-int run_command_v_opt_cd(const char **argv, int opt, const char *dir)
-{
-	struct child_process cmd;
-	prepare_run_command_v_opt(&cmd, argv, opt);
-	cmd.dir = dir;
-	return run_command(&cmd);
-}
-
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
 {
 	struct child_process cmd;
diff --git a/run-command.h b/run-command.h
index 4f2b7d7..a8b0c20 100644
--- a/run-command.h
+++ b/run-command.h
@@ -53,7 +53,6 @@ int run_command(struct child_process *);
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
-int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
 /*
  * env (the environment) is to be formatted like environ: "VAR=VALUE".
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
