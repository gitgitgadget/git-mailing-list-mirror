From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/27] refs.h: Rename the action_on_err constants
Date: Mon, 24 Mar 2014 18:56:38 +0100
Message-ID: <1395683820-17304-6-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS986-00018N-HH
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbaCXR5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58411 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753743AbaCXR5U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:20 -0400
X-AuditID: 12074414-f79d96d000002d2b-68-533071ff59bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C8.8E.11563.FF170335; Mon, 24 Mar 2014 13:57:19 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xb028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:17 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqPu/0CDYYPp5fYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8brUy+YC86EVjT+KWlgvO7cxcjJISFgIvHoWBsT
	hC0mceHeerYuRi4OIYHLjBIfLyxhhnBOMElM+X6YHaSKTUBXYlFPM1iHiICaxMS2QywgRcwC
	VxglrnzcDuRwcAgLuEhMPi8BUsMioCoxp+0RI4jNCxRecuA/G8Q2OYkpvxeAzeQUcJXY2n6Y
	GcQWAqrZ8bGXaQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIYEn
	soPxyEm5Q4wCHIxKPLwRxgbBQqyJZcWVuYcYJTmYlER52XKBQnxJ+SmVGYnFGfFFpTmpxYcY
	JTiYlUR4LcOBcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErxTgREm
	JFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjPhiYGyApHiA9taCtPMWFyTmAkUh
	Wk8xKkqJ814rAEoIgCQySvPgxsLSyStGcaAvhXnng7TzAFMRXPcroMFMQIPDm/RABpckIqSk
	GhjtL7LIzJZIP2t3XqhxX4Oi2/mrnEEG9upy71YIvnz4QUzEvuTFrPWfdAv5r61MuKw2/YNg
	oqOKF4PQW6GOC13Xm65/KJX4ydm3rcVW9l/6wZy77ntlxIpjo4Rvrf/v+PfiNGXN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244831>

Given that these constants are only being used when updating
references, it is inappropriate to give them such generic names as
"DIE_ON_ERR".  So prefix their names with "UPDATE_REFS_".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/checkout.c                     |  2 +-
 builtin/clone.c                        |  9 +++++----
 builtin/merge.c                        |  6 +++---
 builtin/notes.c                        |  6 +++---
 builtin/reset.c                        |  6 ++++--
 builtin/update-ref.c                   |  5 +++--
 contrib/examples/builtin-fetch--tool.c |  3 ++-
 notes-cache.c                          |  2 +-
 notes-utils.c                          |  3 ++-
 refs.c                                 | 18 +++++++++---------
 refs.h                                 |  9 +++++++--
 11 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ada51fa..f79b222 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -624,7 +624,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
-			   REF_NODEREF, DIE_ON_ERR);
+			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
diff --git a/builtin/clone.c b/builtin/clone.c
index 43e772c..af3b86f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -521,7 +521,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
 		update_ref(msg, ref->name, ref->old_sha1,
-			   NULL, 0, DIE_ON_ERR);
+			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
@@ -589,14 +589,15 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
 			const char *head = skip_prefix(our->name, "refs/heads/");
-			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
+			update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
+				   UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_sha1);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", c->object.sha1,
-			   NULL, REF_NODEREF, DIE_ON_ERR);
+			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
@@ -604,7 +605,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * Detach HEAD in all these cases.
 		 */
 		update_ref(msg, "HEAD", remote->old_sha1,
-			   NULL, REF_NODEREF, DIE_ON_ERR);
+			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index f0cf120..a4c3b17 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -398,7 +398,7 @@ static void finish(struct commit *head_commit,
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD",
 				new_head, head, 0,
-				DIE_ON_ERR);
+				UPDATE_REFS_DIE_ON_ERR);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -1222,7 +1222,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->object.sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->object.sha1,
-			   NULL, 0, DIE_ON_ERR);
+			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
@@ -1339,7 +1339,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
-		   NULL, 0, DIE_ON_ERR);
+		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	if (remoteheads && !common)
 		; /* No common ancestors found. We need a real merge. */
diff --git a/builtin/notes.c b/builtin/notes.c
index bb89930..66147b6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -717,7 +717,7 @@ static int merge_commit(struct notes_merge_options *o)
 	strbuf_insert(&msg, 0, "notes: ", 7);
 	update_ref(msg.buf, o->local_ref, sha1,
 		   is_null_sha1(parent_sha1) ? NULL : parent_sha1,
-		   0, DIE_ON_ERR);
+		   0, UPDATE_REFS_DIE_ON_ERR);
 
 	free_notes(t);
 	strbuf_release(&msg);
@@ -812,11 +812,11 @@ static int merge(int argc, const char **argv, const char *prefix)
 	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
 		/* Update default notes ref with new commit */
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
-			   0, DIE_ON_ERR);
+			   0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
-			   0, DIE_ON_ERR);
+			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
diff --git a/builtin/reset.c b/builtin/reset.c
index f4e0875..f368266 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -252,11 +252,13 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
+			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
 		delete_ref("ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0,
+				       UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 02b5f95..f6345e5 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -282,7 +282,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
+		return update_refs(msg, updates, updates_count,
+				   UPDATE_REFS_DIE_ON_ERR);
 	}
 
 	if (end_null)
@@ -314,5 +315,5 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-				  flags, DIE_ON_ERR);
+				  flags, UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index 8bc8c75..ee19166 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -31,7 +31,8 @@ static int update_ref_env(const char *action,
 		rla = "(reflog update)";
 	if (snprintf(msg, sizeof(msg), "%s: %s", rla, action) >= sizeof(msg))
 		warning("reflog message too long: %.*s...", 50, msg);
-	return update_ref(msg, refname, sha1, oldval, 0, QUIET_ON_ERR);
+	return update_ref(msg, refname, sha1, oldval, 0,
+			  UPDATE_REFS_QUIET_ON_ERR);
 }
 
 static int update_local_ref(const char *name,
diff --git a/notes-cache.c b/notes-cache.c
index eabe4a0..97dfd63 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -62,7 +62,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(&msg, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
-		       0, QUIET_ON_ERR) < 0)
+		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
 
 	return 0;
diff --git a/notes-utils.c b/notes-utils.c
index 4aa7023..a0b1d7b 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -48,7 +48,8 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	create_notes_commit(t, NULL, &buf, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
+	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0,
+		   UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_release(&buf);
 }
diff --git a/refs.c b/refs.c
index 28d5eca..196984e 100644
--- a/refs.c
+++ b/refs.c
@@ -3243,9 +3243,9 @@ static struct ref_lock *update_ref_lock(const char *refname,
 	if (!lock) {
 		const char *str = "Cannot lock the ref '%s'.";
 		switch (onerr) {
-		case MSG_ON_ERR: error(str, refname); break;
-		case DIE_ON_ERR: die(str, refname); break;
-		case QUIET_ON_ERR: break;
+		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
+		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
 		}
 	}
 	return lock;
@@ -3258,9 +3258,9 @@ static int update_ref_write(const char *action, const char *refname,
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
 		switch (onerr) {
-		case MSG_ON_ERR: error(str, refname); break;
-		case DIE_ON_ERR: die(str, refname); break;
-		case QUIET_ON_ERR: break;
+		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
+		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
 		}
 		return 1;
 	}
@@ -3294,11 +3294,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
 			switch (onerr) {
-			case MSG_ON_ERR:
+			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->ref_name); break;
-			case DIE_ON_ERR:
+			case UPDATE_REFS_DIE_ON_ERR:
 				die(str, updates[i]->ref_name); break;
-			case QUIET_ON_ERR:
+			case UPDATE_REFS_QUIET_ON_ERR:
 				break;
 			}
 			return 1;
diff --git a/refs.h b/refs.h
index 87a1a79..a713b34 100644
--- a/refs.h
+++ b/refs.h
@@ -214,8 +214,13 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
  */
 extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
 
-/** lock a ref and then write its file */
-enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
+enum action_on_err {
+	UPDATE_REFS_MSG_ON_ERR,
+	UPDATE_REFS_DIE_ON_ERR,
+	UPDATE_REFS_QUIET_ON_ERR
+};
+
+/** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
-- 
1.9.0
