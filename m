From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 28/38] i18n: merge: mark messages for translation
Date: Tue,  7 Jun 2016 11:52:27 +0000
Message-ID: <1465300357-7557-29-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFbP-0008D5-N7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbcFGLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:16 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33232 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161146AbcFGLzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:14 -0400
Received: (qmail 28605 invoked from network); 7 Jun 2016 11:55:12 -0000
Received: (qmail 24002 invoked from network); 7 Jun 2016 11:55:12 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:06 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296656>

Mark messages shown to the user for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..961def5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1014,7 +1014,7 @@ static int default_edit_option(void)
 	if (e) {
 		int v = git_config_maybe_bool(name, e);
 		if (v < 0)
-			die("Bad value '%s' in environment '%s'", e, name);
+			die(_("Bad value '%s' in environment '%s'"), e, name);
 		return v;
 	}
 
@@ -1115,7 +1115,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		if (!commit) {
 			if (ptr)
 				*ptr = '\0';
-			die("not something we can merge in %s: %s",
+			die(_("not something we can merge in %s: %s"),
 			    filename, merge_names->buf + pos);
 		}
 		remotes = &commit_list_insert(commit, remotes)->next;
@@ -1149,7 +1149,7 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 			struct commit *commit = get_merge_parent(argv[i]);
 			if (!commit)
 				help_unknown_ref(argv[i], "merge",
-						 "not something we can merge");
+						 _("not something we can merge"));
 			remotes = &commit_list_insert(commit, remotes)->next;
 		}
 		remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
@@ -1421,7 +1421,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date("Already up-to-date.");
+		finish_up_to_date(_("Already up-to-date."));
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
@@ -1506,7 +1506,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date("Already up-to-date. Yeeah!");
+			finish_up_to_date(_("Already up-to-date. Yeeah!"));
 			goto done;
 		}
 	}
-- 
2.7.3
