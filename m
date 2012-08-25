From: travis.carden@gmail.com
Subject: [PATCH] Improve "Not a git repository" error messages
Date: Fri, 24 Aug 2012 22:33:41 -0500
Message-ID: <1345865621-6941-1-git-send-email-travis.carden@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, travis.carden@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 05:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T578R-0002wZ-C8
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 05:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2HYDeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 23:34:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34067 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab2HYDd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 23:33:58 -0400
Received: by obbuo13 with SMTP id uo13so5598368obb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=eEdxStljAo4+PC9eIqPPnmKiwfIdUaQJpEAf7lj1wGw=;
        b=KONZMpBPqAJugoZr27YV6eNnfRdGKBKw4T6appEr1xT9qTrqc4f7iGm+z6JIV/yJX0
         dF+1oReg3c/55XhIGoHuO1aAkNC6uZTJswQci6pzmRcLAQOE9X7s38sPvjQztgov27UO
         rD0yJV2JqieQKmrtyXToSoF6PQrDuLxiREz7s8hIUoUniCZCK93wCjZ9TmvJ7NpSnfY9
         p7BKshsrWMaaDJ+K1Q21YirVWJLT0giixviXKLfFrWscDDU/yToJt1vlrBhsWNIco5g3
         MogWCY725zb6mzuM0CrwvlhEjoheH70BJrZ6+S4gLAbjYTgislq1+uO8IbxMXoSaTx6b
         7zzw==
Received: by 10.182.111.39 with SMTP id if7mr5468563obb.56.1345865637841;
        Fri, 24 Aug 2012 20:33:57 -0700 (PDT)
Received: from quickstart.om.cox.net (ip24-252-18-14.om.om.cox.net. [24.252.18.14])
        by mx.google.com with ESMTPS id d4sm10997677obx.3.2012.08.24.20.33.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Aug 2012 20:33:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204244>

From: Travis Carden <travis.carden@gmail.com>

The former messages changed grammatical subject in the middle.

Signed-off-by: Travis Carden <travis.carden@gmail.com>
---
This is my first attempt at contributing to the Git project.
I'm kind of testing the water with a simple patch to see how
friendly the community is. Thanks!

 setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 9139bee..0cd88e5 100644
--- a/setup.c
+++ b/setup.c
@@ -599,7 +599,7 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 static const char *setup_nongit(const char *cwd, int *nongit_ok)
 {
 	if (!nongit_ok)
-		die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
+		die("Not a git repository (or a descendant of one): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 	if (chdir(cwd))
 		die_errno("Cannot come back to cwd");
 	*nongit_ok = 1;
@@ -706,7 +706,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 					return NULL;
 				}
 				cwd[offset] = '\0';
-				die("Not a git repository (or any parent up to mount point %s)\n"
+				die("Not a git repository (or a descendant of one up to mount point %s)\n"
 				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
 			}
 		}
-- 
1.7.9.5
