From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 2/7] i18n: unpack-trees: mark strings for translation
Date: Tue, 19 Apr 2016 13:19:19 +0000
Message-ID: <1461071964-323-2-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:21:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaI-0003fN-WC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcDSNUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:20:50 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:55030 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754427AbcDSNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:09 -0400
Received: (qmail 14683 invoked from network); 19 Apr 2016 13:20:07 -0000
Received: (qmail 8993 invoked from network); 19 Apr 2016 13:20:07 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:20:01 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291859>

Mark strings seen by the user inside setup_unpack_trees_porcelain() and
display_error_msgs() functions for translation.

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
