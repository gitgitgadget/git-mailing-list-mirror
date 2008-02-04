From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 7/9] Export create_branch() from builtin-branch.c
Date: Mon, 4 Feb 2008 13:36:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041336010.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6BV-0006Qr-Uz
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYBDSgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbYBDSgG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:36:06 -0500
Received: from iabervon.org ([66.92.72.58]:51156 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbYBDSgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:36:03 -0500
Received: (qmail 8184 invoked by uid 1000); 4 Feb 2008 18:36:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:36:02 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72550>

You can also create branches, in exactly the same way, with checkout -b.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-branch.c |    4 ++--
 cache.h          |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..04e377d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -422,8 +422,8 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 	return 0;
 }
 
-static void create_branch(const char *name, const char *start_name,
-			  int force, int reflog, int track)
+void create_branch(const char *name, const char *start_name,
+		   int force, int reflog, int track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
diff --git a/cache.h b/cache.h
index e4aeff0..97edbf1 100644
--- a/cache.h
+++ b/cache.h
@@ -680,6 +680,10 @@ extern int convert_to_working_tree(const char *path, const char *src, size_t len
 /* add */
 void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
 
+/* branch */
+void create_branch(const char *name, const char *start_name,
+		   int force, int reflog, int track);
+
 /* diff.c */
 extern int diff_auto_refresh_index;
 
-- 
1.5.4
