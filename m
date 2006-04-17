From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 7/7] cleanups: remove unused variable from exec_cmd.c
Date: Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
Message-ID: <20060417151448.3130F19B914@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRf-0006gN-Ec
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDQPPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDQPPL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:15:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12933 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751092AbWDQPPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 11:15:09 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEwtV029576
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFEnkk228170
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEmgp017278
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmAN017259
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id 3130F19B914; Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18830>

Not sure whether it should be removed, or whether
execv_git_cmd() should return it rather than -1 at bottom.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 exec_cmd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

3229a225008ab56b33b1ae7511d91f6b698cd19a
diff --git a/exec_cmd.c b/exec_cmd.c
index 590e738..44bb2f2 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -32,7 +32,7 @@ const char *git_exec_path(void)
 int execv_git_cmd(const char **argv)
 {
 	char git_command[PATH_MAX + 1];
-	int len, err, i;
+	int len,  i;
 	const char *paths[] = { current_exec_path,
 				getenv("GIT_EXEC_PATH"),
 				builtin_exec_path };
@@ -85,8 +85,6 @@ int execv_git_cmd(const char **argv)
 		/* execve() can only ever return if it fails */
 		execve(git_command, (char **)argv, environ);
 
-		err = errno;
-
 		argv[0] = tmp;
 	}
 	return -1;
-- 
1.2.5
