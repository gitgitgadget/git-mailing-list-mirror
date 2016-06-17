Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA51D1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbcFQUYj (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:39 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52161 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964917AbcFQUYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:38 -0400
Received: (qmail 23823 invoked from network); 17 Jun 2016 20:24:36 -0000
Received: (qmail 9427 invoked from network); 17 Jun 2016 20:24:36 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:36 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 28/38] i18n: merge: mark messages for translation
Date:	Fri, 17 Jun 2016 20:21:17 +0000
Message-Id: <1466194887-18236-29-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

