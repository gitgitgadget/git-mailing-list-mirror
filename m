From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 2/7] l10n: unpack-trees: mark strings for translation
Date: Fri,  8 Apr 2016 20:02:40 +0000
Message-ID: <1460145765-7454-2-git-send-email-vascomalmeida@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 22:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aocjI-0002tZ-6O
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757AbcDHUJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:09:58 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:59653 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754721AbcDHUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:09:57 -0400
Received: (qmail 16803 invoked from network); 8 Apr 2016 20:03:16 -0000
Received: (qmail 16241 invoked from network); 8 Apr 2016 20:03:16 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:03:11 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291060>

Mark strings seen by the user inside setup_unpack_trees_porcelain() and
display_error_msgs() functions for translation.

One case Git outputs the named strings is when the user does some editing to
a file on some branch and then checks out other branch, but that file
changes by the checkout. This is the case of the first string marked.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 unpack-trees.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc2..4bc6b4f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,21 +61,21 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 
 	if (advice_commit_before_merge)
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.";
+		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s"
+			"Please, commit your changes or stash them before you can %s.");
 	else
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
+		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
 		xstrfmt(msg, cmd, cmd2);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
-		"Updating the following directories would lose untracked files in it:\n%s";
+		_("Updating the following directories would lose untracked files in it:\n%s");
 
 	if (advice_commit_before_merge)
-		msg = "The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.";
+		msg = _("The following untracked working tree files would be %s by %s:\n%%s"
+			"Please move or remove them before you can %s.");
 	else
-		msg = "The following untracked working tree files would be %s by %s:\n%%s";
+		msg = _("The following untracked working tree files would be %s by %s:\n%%s");
 
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
@@ -84,14 +84,14 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
 	 * cannot easily display it as a list.
 	 */
-	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
+	msgs[ERROR_BIND_OVERLAP] = _("Entry '%s' overlaps with '%s'.  Cannot bind.");
 
 	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
-		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
+		_("Cannot update sparse checkout: the following entries are not up-to-date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
-		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
+		_("The following Working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		"The following Working tree files would be removed by sparse checkout update:\n%s";
+		_("The following Working tree files would be removed by sparse checkout update:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
@@ -168,7 +168,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		string_list_clear(rejects, 0);
 	}
 	if (something_displayed)
-		fprintf(stderr, "Aborting\n");
+		fprintf(stderr, _("Aborting\n"));
 }
 
 /*
-- 
2.1.4
