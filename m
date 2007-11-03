From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/3] Use setup_work_tree() in builtin-ls-files.c
Date: Sat,  3 Nov 2007 12:23:12 +0100
Message-ID: <1194088993-25692-2-git-send-email-mh@glandium.org>
References: <1194088993-25692-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 12:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoH7L-0003JZ-PX
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbXKCLYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXKCLYZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:24:25 -0400
Received: from vawad.err.no ([85.19.200.177]:57400 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXKCLYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:24:24 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoH6n-0007sk-Ic; Sat, 03 Nov 2007 12:24:14 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoH5u-0006gg-5N; Sat, 03 Nov 2007 12:23:14 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194088993-25692-1-git-send-email-mh@glandium.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63235>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin-ls-files.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index b70da18..e0b856f 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -525,11 +525,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (require_work_tree && !is_inside_work_tree()) {
-		const char *work_tree = get_git_work_tree();
-		if (!work_tree || chdir(work_tree))
-			die("This operation must be run in a work tree");
-	}
+	if (require_work_tree && !is_inside_work_tree())
+		setup_work_tree();
 
 	pathspec = get_pathspec(prefix, argv + i);
 
-- 
1.5.3.5
