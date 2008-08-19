From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI] reset,cat-file: remove const declaration from array
Date: Mon, 18 Aug 2008 19:08:50 -0500
Message-ID: <hjRg2-WPGYEeqAP0h-sXbS8ouecjwZU2ymwwyp8wKIjQ_CGDG5-urQ@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEnK-0003su-FD
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYHSAIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbYHSAIv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:08:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41682 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbYHSAIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:08:51 -0400
Received: by mail.nrlssc.navy.mil id m7J08oXO031644; Mon, 18 Aug 2008 19:08:50 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Aug 2008 00:08:50.0175 (UTC) FILETIME=[C1E548F0:01C9018F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92784>

Silence compiler complaints about opt array initialized with local
variables which was declared const.
---
 builtin-cat-file.c |    2 +-
 builtin-reset.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 7441a56..d954c09 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -212,7 +212,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0, batch = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 
-	const struct option options[] = {
+	struct option options[] = {
 		OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
 		OPT_SET_INT('t', NULL, &opt, "show object type", 't'),
 		OPT_SET_INT('s', NULL, &opt, "show object size", 's'),
diff --git a/builtin-reset.c b/builtin-reset.c
index 4d246c3..28b633f 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -176,7 +176,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
-	const struct option options[] = {
+	struct option options[] = {
 		OPT_SET_INT(0, "mixed", &reset_type,
 						"reset HEAD and index", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
-- 
1.6.0.11.gecc7e
