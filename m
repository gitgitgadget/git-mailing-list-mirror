Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C151F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfAEFwY (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:52:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAEFwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so19260765pfo.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8c2fhWOrXe0rppDg7YgO35H8Wk1rR92T6k5surnjY8=;
        b=t+odpssdOpd/aejzyD5jpkzhWysUU3XAUZ7Omf21sSUYPQ2pir2Cakf5P6wioj7Qnj
         XKREiu+erJ5qahV65a3BnKB5mdrgmxAQr9PHZqr+TUfGoOjm7LbQXek2FH40G/9GOuEi
         sJXH5hpKBi6dRPHG2ydw98R0WsNV1sFTxnxckpF5CESAxD7l/FzGKARPqrfg2DTPfbuY
         TDugkEPphhq0+RsV5ZSqFF7R9FKCjTuNHzQ8VIxTdobCyYfDxVBP/gdA+ObEnML2iwVF
         ILqN8qHz3EhSK2/tEFl5Hdb+jGbwSc+eDDCufkb7pveVjHyiI0Qb91/NIVwVqZbRNGC/
         D81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8c2fhWOrXe0rppDg7YgO35H8Wk1rR92T6k5surnjY8=;
        b=Eisp7sQQaKQ3yFMIYaag+kxcXx+AUXcQj5sUH2BABAImblsAiVXpQHAT8iUJNvLZdp
         QGDT/EH8441iL8iJZhXomMtvWxi2D2r6yLcLYKZHhNOWjKut0qXPqbYyOaoKLIx0mj+b
         6VXpkAUBgG/Wyv6Ca7TagewmBY7EeExktXDfApfbMIVwrIwQnMeUcsTR2cWa1IgygBsR
         A8fF02Fw5/qqR8D/C48zsC0Cu9Sdo37fVrM6krPySD7izy/gp683UlTojSQAolbKEf95
         nN3LLaS+M9diJBMnQOexRYXQUjjYEGVZTl9YApO8lWazLGiK1BM1Nm67/P0f0duKUGUB
         yugw==
X-Gm-Message-State: AA+aEWYEMNzq7Kdj/2dc/vQTLapHT/3za5gDi93fa2hXJFUT63FtjqE+
        4OTyyPi0UqaWHgHLMP9hZ7y0tItJT5Y=
X-Google-Smtp-Source: ALg8bN7AV8MOS74AOZiqtQrfMlsnOSbB7MBrScfsCgtUQAI8mTnquAZvQNBecKT5GmGvYxi2DMqKbg==
X-Received: by 2002:a62:520b:: with SMTP id g11mr55711250pfb.53.1546667542356;
        Fri, 04 Jan 2019 21:52:22 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id o66sm129131923pgo.75.2019.01.04.21.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:52:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:52:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/10] notes-utils.c: remove the_repository references
Date:   Sat,  5 Jan 2019 12:51:44 +0700
Message-Id: <20190105055153.3256-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190105055153.3256-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c     |  2 +-
 builtin/commit.c |  2 +-
 builtin/notes.c  | 21 +++++++++++++--------
 notes-merge.c    |  4 ++--
 notes-utils.c    | 17 ++++++++++-------
 notes-utils.h    | 11 ++++++++---
 sequencer.c      |  7 ++++---
 sequencer.h      |  3 ++-
 8 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..d32044545d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -527,7 +527,7 @@ static int copy_notes_for_rebase(const struct am_state *state)
 	}
 
 finish:
-	finish_copy_notes_for_rewrite(c, msg);
+	finish_copy_notes_for_rewrite(the_repository, c, msg);
 	fclose(fp);
 	strbuf_release(&sb);
 	return ret;
diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..e29fb5e3eb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1674,7 +1674,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
-		commit_post_rewrite(current_head, &oid);
+		commit_post_rewrite(the_repository, current_head, &oid);
 	}
 	if (!quiet) {
 		unsigned int flags = 0;
diff --git a/builtin/notes.c b/builtin/notes.c
index 4996a670f7..02e97f55c5 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -330,10 +330,10 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	}
 
 	if (!rewrite_cmd) {
-		commit_notes(t, msg);
+		commit_notes(the_repository, t, msg);
 		free_notes(t);
 	} else {
-		finish_copy_notes_for_rewrite(c, msg);
+		finish_copy_notes_for_rewrite(the_repository, c, msg);
 	}
 	strbuf_release(&buf);
 	return ret;
@@ -469,12 +469,14 @@ static int add(int argc, const char **argv, const char *prefix)
 		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
-		commit_notes(t, "Notes added by 'git notes add'");
+		commit_notes(the_repository, t,
+			     "Notes added by 'git notes add'");
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			oid_to_hex(&object));
 		remove_note(t, object.hash);
-		commit_notes(t, "Notes removed by 'git notes add'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes add'");
 	}
 
 	free_note_data(&d);
@@ -552,7 +554,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 
 	if (add_note(t, &object, from_note, combine_notes_overwrite))
 		BUG("combine_notes_overwrite failed");
-	commit_notes(t, "Notes added by 'git notes copy'");
+	commit_notes(the_repository, t,
+		     "Notes added by 'git notes copy'");
 out:
 	free_notes(t);
 	return retval;
@@ -636,7 +639,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		remove_note(t, object.hash);
 		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
 	}
-	commit_notes(t, logmsg);
+	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
@@ -937,7 +940,8 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 	if (!retval)
-		commit_notes(t, "Notes removed by 'git notes remove'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes remove'");
 	free_notes(t);
 	return retval;
 }
@@ -965,7 +969,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
 		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
 	if (!show_only)
-		commit_notes(t, "Notes removed by 'git notes prune'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes prune'");
 	free_notes(t);
 	return 0;
 }
diff --git a/notes-merge.c b/notes-merge.c
index 72688d301b..280aa8e6c1 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -649,7 +649,7 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, o->commit_msg.buf,
+		create_notes_commit(o->repo, local_tree, parents, o->commit_msg.buf,
 				    o->commit_msg.len, result_oid);
 	}
 
@@ -724,7 +724,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		strbuf_setlen(&path, baselen);
 	}
 
-	create_notes_commit(partial_tree, partial_commit->parents, msg,
+	create_notes_commit(o->repo, partial_tree, partial_commit->parents, msg,
 			    strlen(msg), result_oid);
 	unuse_commit_buffer(partial_commit, buffer);
 	if (o->verbosity >= 4)
diff --git a/notes-utils.c b/notes-utils.c
index 14ea03178e..a819410698 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -5,7 +5,9 @@
 #include "notes-utils.h"
 #include "repository.h"
 
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+void create_notes_commit(struct repository *r,
+			 struct notes_tree *t,
+			 struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid)
 {
@@ -20,8 +22,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
 		if (!read_ref(t->ref, &parent_oid)) {
-			struct commit *parent = lookup_commit(the_repository,
-							      &parent_oid);
+			struct commit *parent = lookup_commit(r, &parent_oid);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
@@ -34,7 +35,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		die("Failed to commit notes tree to database");
 }
 
-void commit_notes(struct notes_tree *t, const char *msg)
+void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id commit_oid;
@@ -50,7 +51,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_addstr(&buf, msg);
 	strbuf_complete_line(&buf);
 
-	create_notes_commit(t, NULL, buf.buf, buf.len, &commit_oid);
+	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
 	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
@@ -171,11 +172,13 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 	return ret;
 }
 
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg)
+void finish_copy_notes_for_rewrite(struct repository *r,
+				   struct notes_rewrite_cfg *c,
+				   const char *msg)
 {
 	int i;
 	for (i = 0; c->trees[i]; i++) {
-		commit_notes(c->trees[i], msg);
+		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
 	}
 	free(c->trees);
diff --git a/notes-utils.h b/notes-utils.h
index 5408306528..d9b3c09eaf 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -5,6 +5,7 @@
 
 struct commit_list;
 struct object_id;
+struct repository;
 
 /*
  * Create new notes commit from the given notes tree
@@ -17,11 +18,13 @@ struct object_id;
  *
  * The resulting commit SHA1 is stored in result_sha1.
  */
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+void create_notes_commit(struct repository *r,
+			 struct notes_tree *t,
+			 struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid);
 
-void commit_notes(struct notes_tree *t, const char *msg);
+void commit_notes(struct repository *r, struct notes_tree *t, const char *msg);
 
 enum notes_merge_strategy {
 		NOTES_MERGE_RESOLVE_MANUAL = 0,
@@ -45,6 +48,8 @@ int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const struct object_id *from_obj, const struct object_id *to_obj);
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
+void finish_copy_notes_for_rewrite(struct repository *r,
+				   struct notes_rewrite_cfg *c,
+				   const char *msg);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index b68bca0bef..1a92a5d678 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1115,7 +1115,8 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	return finish_command(&proc);
 }
 
-void commit_post_rewrite(const struct commit *old_head,
+void commit_post_rewrite(struct repository *r,
+			 const struct commit *old_head,
 			 const struct object_id *new_head)
 {
 	struct notes_rewrite_cfg *cfg;
@@ -1124,7 +1125,7 @@ void commit_post_rewrite(const struct commit *old_head,
 	if (cfg) {
 		/* we are amending, so old_head is not NULL */
 		copy_note_for_rewrite(cfg, &old_head->object.oid, new_head);
-		finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
+		finish_copy_notes_for_rewrite(r, cfg, "Notes added by 'git commit --amend'");
 	}
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
@@ -1405,7 +1406,7 @@ static int try_to_commit(struct repository *r,
 	}
 
 	if (flags & AMEND_MSG)
-		commit_post_rewrite(current_head, oid);
+		commit_post_rewrite(r, current_head, oid);
 
 out:
 	free_commit_extra_headers(extra);
diff --git a/sequencer.h b/sequencer.h
index 9d83f0f3e9..2caecd550b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -124,7 +124,8 @@ int update_head_with_reflog(const struct commit *old_head,
 			    const struct object_id *new_head,
 			    const char *action, const struct strbuf *msg,
 			    struct strbuf *err);
-void commit_post_rewrite(const struct commit *current_head,
+void commit_post_rewrite(struct repository *r,
+			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
-- 
2.20.0.482.g66447595a7

