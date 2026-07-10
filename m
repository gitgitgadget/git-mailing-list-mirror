Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B81374E57
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705377; cv=none; b=F+LxwKgncQqKYbjJylETS7or6qOLJRUXbik/btZ4jDZ2ypa6jjplu0eFTKoAmlG5tPwqR73c7UIIYn6iMrqFIixEjc8p9E4MVrATblzXbuxYGGFKXwWs9PP4BftE+8QJniuHdpxqDL/0+9WqyZr7w/CLa/pxC2DeAavbt9m9YX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705377; c=relaxed/simple;
	bh=VoOr8D+k1bMN1UWsGlmFzw3oZ2knyDGI9/SwoPnSSaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qfTGUQDCqA8YtfQ4NetvqiK4ftjLLvoYqRP5wcYCpqkhbmiue7fd1GZQi7/kcPFDXEZLWADx+pbgXB7G5A9tZZEQOMWEbXZ1agzVbvUoUc+Gc/+m9mqQQczuQmAcgO6P911Q9NGiw8dWhYzwgDAdM9wFeHN/l1TqaIMdErpHwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBV10tK9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBV10tK9"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso799244a12.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783705375; x=1784310175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n1EwSCV4voUUpsmVjpuMC74ajz5NQUbb+DwUbzpNvFs=;
        b=ZBV10tK9BnqhM2mB/8tB5eyPacNBsAhLtrQXO7HTlvlBtp1Lnt+Fu93I8MEYW+PnV8
         S4xt7Nuum+cfsRlXllLsF2VTduoFslxwNrclgL3oqocKZhWIEjz8AoJkUWIoUN4z9ovo
         31wm27ekS7zeMk8u0s0nXF6Xmg9I9vG3DV9M25tlvyGHkLjqMlxl/CV01JsayT0EPrIL
         jHLf5AGtBml269bn1TQE659/se4jhe4Q2jDAtj62pCJxCnGJ10a/ukySHd2/5u8bryGD
         8Mnan0SzdoIoBOs+UgrdwJL050MmVsJ18stqy13se3kZgWXxseZle08wlTRJhTFA+uYg
         cVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705375; x=1784310175;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n1EwSCV4voUUpsmVjpuMC74ajz5NQUbb+DwUbzpNvFs=;
        b=T7YMXfej2SiwMDXI+q4ovzB9ymXInucYwuG2KS8r8CV7eFT4PeI/bt7i9QEtNBnEZU
         lKovxBhOp5+jFE71vCyYkEs/+ajGjk7U7TWpt0/BvjnLt+b5qrd6LlBu1SWFT7zzNUgp
         kr/2YpLTEdGA1UuwP1ZOOZjcKLfkkhX/atszyUHDHm79Sp+zOJ5Ju2SWYbPLw5/85Ftk
         w7fcjN7ZHwvdk0pwB3bfoGsf6B+dg3G2Xv4gz++nIPffc9qNSXUKATcm2cOjMUC2uhNl
         dZkwE1IskDmz6XXcIBE/BM3Tp4Nw8GfVrtjyXYzvwGlQVoJaZo9JLZtmgE+WWppLYELy
         AxLg==
X-Gm-Message-State: AOJu0Yxt3wGKQM/Vqy7Yn3jwybZGYdmjcum22cuOYllvkfgjksiwUAkv
	egerh88XvYg6N3eoRec4LBOtrScUZhm44xjpoiitEJFTi+aLNOcUHqDIX2jBSQ==
X-Gm-Gg: AfdE7cnpEHR+oVB0hQvVM51A9IMIbzIl4Z+yDVegidHpszDKU4s24VyPTiglIi/jfQp
	Mhw84x2/aPkmPwH+oSlc23taqqAOCC/0CMeKM8C4fG94gGYJ9co3BYLu9AyGQi7rgicAS00o8+n
	4YlGVN9Oj1ieut0WcigLnH1ahZNHSBadsppO1vc3p5HJ52fBU9lyRY+ax08m7SyrWzmZxY3WfBn
	55tNT4PuQfsZjuT98eXLjCR8ePeytksKig0nyxDPfQAJH4LfOTevnNzK5xlznptxn+8uHpA70Rq
	Xm6gulDMYz7y0Svt3POspVZ2jek5G3I2UuEV9uSI3Ux4N6IrQBCdED2d7Dx76P+/E4hYzoXJZXc
	8kNQoQalbBkzK30A6wwIBMgrzzNfJv0awiK1wd83IbGa3Zg3YM0Mpfki8iM3lzxc5x0RTiNH7MW
	vjEQlxa7jJS0yuM1/2
X-Received: by 2002:a05:6a20:7350:b0:3b3:e05:7fc4 with SMTP id adf61e73a8af0-3c110ac62b9mr17947637.30.1783705374372;
        Fri, 10 Jul 2026 10:42:54 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm45272321eec.27.2026.07.10.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:42:53 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Fri, 10 Jul 2026 10:42:37 -0700
Subject: [PATCH v2] sequencer: honor --empty when a fixup!/squash! empties
 its target
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAwvUWoC/6XNTQ6CMBCG4auQWTumf6niynsYF6UWmEQottCIh
 LtbOIAbl++XzDMLRBfIRbgUCwSXKJLvc4hDAbY1feOQHrlBMKHZiZVYf9BMo4+vycQWXTeMM1Z
 al8LWUlvNIF8OwdX03tXbPXdLcfRh3p8ksa2/vcSR41nZSpXKSs3ltekMPY/Wd7B5if9prOv6B
 Zm3KKv6AAAA
X-Change-ID: 20260709-fz-autosquash-empty-b6692cf36c60
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
its target, the result can be a commit that no longer changes anything
relative to its parent, for example when the melded change reverts the
target.  Rather than dropping or keeping this empty commit, the rebase
stops with

	You asked to amend the most recent commit, but doing so would
	make it empty. ...

and the "--empty" option has no effect on it.  This makes backing a
change out of a series awkward: reverting a commit as a "fixup!" and
running "git rebase --autosquash --empty=drop" ought to remove both the
commit and its revert, but it halts instead.

A "fixup!" is applied by amending HEAD, so the melded commit has HEAD's
parent as its parent and is empty when the index matches the tree of that
parent, not of HEAD.  do_pick_commit() only compares against HEAD, so it
never notices that the meld cancelled the commit out and falls through to
"git commit --amend", which refuses to create an empty commit.

After melding a fixup or squash, check whether the amended commit is
empty -- its index matches the tree of HEAD's parent -- and, if so, honor
"--empty" just as for a commit that becomes empty when picked: keep it,
drop it, or halt.

When "--empty=drop" applies, the emptied commit has already been created
by the preceding "pick", so drop it by moving HEAD back to its parent.
The commit is dropped rather than rewritten, so discard the pending
rewrite records and do not record the fixup either, leaving nothing for
the post-rewrite machinery; a following "label" or "update-ref" then sees
HEAD at the parent.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
At Meta we maintain a fork of LLVM that we regularly rebase onto
upstream.  A set of internal patches rides on top, and we keep each one
as a single commit by folding follow-up changes into it with autosquash
"fixup!" commits.  That works well for evolving a patch, but not for
retiring one: to back an internal patch out today we hand-edit the
interactive rebase todo list to delete the commit and its scattered
fixups, which is fiddly and easy to get wrong.  (The history is rewritten
either way, so a force-push is still needed; what this avoids is the
manual todo surgery.)

It would be nicer to retire a patch the same way we amend one: commit a
revert of it as a "fixup!" and let autosquash fold the two together.
The net change is empty, so the commit should just drop out of the
series.  Today it does not -- the rebase stops instead.

For example, starting from a commit we want to retire:

    $ git log --oneline
    4d5e6f7 add feature patch
    9a1b2c3 base

    # revert the feature and mark the revert as a fixup of it
    $ git revert --no-edit HEAD
    $ git commit --amend -m "fixup! add feature patch"

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    You asked to amend the most recent commit, but doing so would
    make it empty. You can repeat your command with --allow-empty [...]
    Could not apply 8e9f0a1... # fixup! add feature patch

The "--empty=drop" is ignored.  "--empty" only governs commits that are
picked empty, whereas a "fixup!" is applied by amending, and the
emptiness of an amended commit is measured against the wrong parent.  So
the rebase falls through to "git commit --amend", which refuses to
create an empty commit, and halts.

With this patch the emptied commit is recognized and handled according
to "--empty", the same as any other commit that becomes empty during a
rebase:

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    dropping 8e9f0a1... fixup! add feature patch -- resulting commit is empty
    Successfully rebased and updated refs/heads/main.

    $ git log --oneline
    9a1b2c3 base

"--empty=keep" retains it as an empty commit, and "--empty=stop" (the
default under "-i") halts so the user can decide -- matching how these
options already behave for commits that become empty when picked.

Changes in v2 (thanks to Phillip Wood's review):
 * An emptied fixup/squash now honors --empty in all cases, including
   when the commit it was folded into started out empty; v1 kept that
   case regardless of --empty.
 * On drop, the dropped commit and its fixup are no longer recorded as
   rewritten, so nothing spurious reaches the post-rewrite machinery.
 * Added tests for the empty-placeholder + fixup cases and for the
   not-recorded-as-rewritten behavior; adjusted t3415 "abort last squash".
 * Link to v1: https://lore.kernel.org/r/20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com
---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
---
 Documentation/git-rebase.adoc |  12 ++++
 sequencer.c                   | 148 +++++++++++++++++++++++++++++++++++-------
 t/t3415-rebase-autosquash.sh  | 138 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 275 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..7eb8bbe95f 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
 preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
 passed).
 +
+A commit can also become empty as a result of `--autosquash`, when a
+`fixup!` or `squash!` commit cancels out all of the changes of the
+commit it is melded into.  Such a commit is treated the same way and is
+dropped, kept, or stopped at according to this option.
++
 See also INCOMPATIBLE OPTIONS below.
 
 --no-keep-empty::
@@ -591,6 +596,13 @@ changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
 are moved right after the commit they modify.  The `--interactive` option can
 be used to review and edit the todo list before proceeding.
 +
+If melding a `fixup!` or `squash!` commit cancels out all of the changes of
+the commit it is applied to, the result is an empty commit.  The handling of
+these empty commits can be configured with the `--empty` option: the emptied
+commit is dropped, kept, or stopped at.  This makes it possible to back a
+change out of a series by committing a revert of it as a `fixup!` and letting
+`--autosquash --empty=drop` remove both.
++
 The recommended way to create commits with squash markers is by using the
 `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
 linkgit:git-commit[1], which take the target commit as an argument and
diff --git a/sequencer.c b/sequencer.c
index 0fe8fed6c3..bc24132c7c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1817,6 +1817,39 @@ static int allow_empty(struct repository *r,
 		return 0;
 }
 
+/*
+ * Melding a "fixup!"/"squash!" amends HEAD, so the resulting commit is empty
+ * when the index matches the tree of HEAD's parent (rather than of HEAD, as a
+ * plain pick would).  Returns 1 if the amended commit would be empty, 0 if not,
+ * and negative on error.
+ */
+static int amended_commit_is_empty(struct repository *r)
+{
+	struct object_id head_oid, *cache_tree_oid;
+	const struct object_id *parent_tree_oid;
+	struct commit *head_commit;
+
+	if (repo_get_oid(r, "HEAD", &head_oid))
+		return error(_("could not resolve HEAD commit"));
+	head_commit = lookup_commit_reference(r, &head_oid);
+	if (!head_commit || repo_parse_commit(r, head_commit))
+		return -1;
+
+	if (head_commit->parents) {
+		struct commit *parent = head_commit->parents->item;
+		if (repo_parse_commit(r, parent))
+			return -1;
+		parent_tree_oid = get_commit_tree_oid(parent);
+	} else {
+		parent_tree_oid = the_hash_algo->empty_tree;
+	}
+
+	if (!(cache_tree_oid = get_cache_tree_oid(r->index)))
+		return -1;
+
+	return oideq(cache_tree_oid, parent_tree_oid);
+}
+
 static struct {
 	char c;
 	const char *str;
@@ -2260,10 +2293,34 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+/*
+ * A "fixup!"/"squash!" that melds into HEAD may empty it out.  In that case,
+ * with --empty=drop, we want to drop the commit entirely.  Since the commit
+ * being amended has already been created (by the preceding "pick"), and the
+ * index and worktree already match the tree of its parent, dropping it is a
+ * matter of moving HEAD back to that parent.
+ */
+static int reset_head_to_parent(struct repository *r, struct replay_opts *opts,
+				struct object_id *head)
+{
+	struct commit *head_commit = lookup_commit_reference(r, head);
+
+	if (!head_commit || repo_parse_commit(r, head_commit))
+		return error(_("could not parse HEAD commit"));
+	if (!head_commit->parents)
+		return error(_("cannot drop the root commit"));
+
+	return refs_update_ref(get_main_ref_store(r),
+			       reflog_message(opts, "fixup",
+					      "dropping emptied commit"),
+			       "HEAD", &head_commit->parents->item->object.oid,
+			       head, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
-			  int final_fixup, int *check_todo)
+			  int final_fixup, int *check_todo, int *dropped)
 {
 	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
@@ -2277,6 +2334,9 @@ static int do_pick_commit(struct repository *r,
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
+	if (dropped)
+		*dropped = 0;
+
 	if (is_rebase_i(opts))
 		reflog_action = reflog_message(
 			opts, command_to_string(item->command), NULL);
@@ -2493,23 +2553,67 @@ static int do_pick_commit(struct repository *r,
 	}
 
 	drop_commit = 0;
-	allow = allow_empty(r, opts, commit);
-	if (allow < 0) {
-		res = allow;
-		goto leave;
-	} else if (allow == 1) {
-		flags |= ALLOW_EMPTY;
-	} else if (allow == 2) {
-		drop_commit = 1;
-		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, REF_NO_DEREF);
-		unlink(git_path_merge_msg(r));
-		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
-				NULL, REF_NO_DEREF);
-		fprintf(stderr,
-			_("dropping %s %s -- patch contents already upstream\n"),
-			oid_to_hex(&commit->object.oid), msg.subject);
-	} /* else allow == 0 and there's nothing special to do */
+	if (flags & AMEND_MSG) {
+		/*
+		 * A "fixup!"/"squash!" amends HEAD.  Separately from the usual
+		 * empty-commit handling, check whether applying it leaves the
+		 * commit empty and, if so, honor --empty (keep, drop, or -- when
+		 * neither is requested -- halt below in do_commit), just as for a
+		 * commit that becomes empty when picked.
+		 */
+		int melded_empty = amended_commit_is_empty(r);
+		if (melded_empty < 0) {
+			res = melded_empty;
+			goto leave;
+		} else if (melded_empty && opts->keep_redundant_commits) {
+			flags |= ALLOW_EMPTY;
+		} else if (melded_empty && opts->drop_redundant_commits) {
+			drop_commit = 1;
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, REF_NO_DEREF);
+			unlink(git_path_merge_msg(r));
+			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+					NULL, REF_NO_DEREF);
+			/*
+			 * The commit the fixup was melded into was already
+			 * created by the preceding "pick", so drop it by moving
+			 * HEAD back to its parent.  Since the commit is being
+			 * dropped rather than rewritten, discard the pending
+			 * rewrite records and tell our caller not to add one, so
+			 * that neither the dropped commit nor the fixup is
+			 * recorded as rewritten.
+			 */
+			res = reset_head_to_parent(r, opts, &head);
+			if (res)
+				goto leave;
+			unlink(rebase_path_rewritten_pending());
+			if (dropped)
+				*dropped = 1;
+			fprintf(stderr,
+				_("dropping %s %s -- resulting commit is empty\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		}
+		/* else the meld is non-empty, or empty but neither kept nor
+		 * dropped, in which case do_commit halts on the empty result. */
+	} else {
+		allow = allow_empty(r, opts, commit);
+		if (allow < 0) {
+			res = allow;
+			goto leave;
+		} else if (allow == 1) {
+			flags |= ALLOW_EMPTY;
+		} else if (allow == 2) {
+			drop_commit = 1;
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, REF_NO_DEREF);
+			unlink(git_path_merge_msg(r));
+			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+					NULL, REF_NO_DEREF);
+			fprintf(stderr,
+				_("dropping %s %s -- patch contents already upstream\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		} /* else allow == 0 and there's nothing special to do */
+	}
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
@@ -4958,12 +5062,12 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
-	int res;
+	int res, dropped = 0;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
-			     check_todo);
+			     check_todo, &dropped);
 	if (is_rebase_i(opts) && res < 0) {
 		/* Reschedule */
 		*reschedule = 1;
@@ -4980,7 +5084,7 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
 	}
-	if (is_rebase_i(opts) && !res)
+	if (is_rebase_i(opts) && !res && !dropped)
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
@@ -5545,7 +5649,7 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	return do_pick_commit(r, &item, opts, 0, &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo, NULL);
 }
 
 int sequencer_pick_revisions(struct repository *r,
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..b4607f44b3 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -461,8 +461,10 @@ test_expect_success 'abort last squash' '
 	git commit --allow-empty -m second &&
 	git commit --allow-empty --squash HEAD &&
 
+	: "squashing empty onto empty leaves an empty commit; --empty=keep" &&
+	: "keeps it so the squash still reaches the editor, which aborts" &&
 	test_must_fail git -c core.editor="grep -q ^pick" \
-		rebase -ki --autosquash HEAD~4 &&
+		rebase -ki --autosquash --empty=keep HEAD~4 &&
 	: do not finish the squash, but resolve it manually &&
 	git commit --allow-empty --amend -m edited-first &&
 	git rebase --skip &&
@@ -510,4 +512,138 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addX fileX 1 &&
+	test_commit --no-tag changeX fileX 2 &&
+	test_commit --no-tag later fileW hello &&
+	echo 1 >fileX &&
+	git commit -m "fixup! changeX" fileX &&
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	git log --format=%s >actual &&
+	! grep changeX actual &&
+	grep addX actual &&
+	grep later actual &&
+	echo 1 >expect &&
+	test_cmp expect fileX &&
+	echo hello >expect &&
+	test_cmp expect fileW
+'
+
+test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
+	git reset --hard base &&
+	test_commit --no-tag addY fileY 1 &&
+	test_commit --no-tag changeY fileY 2 &&
+	echo 1 >fileY &&
+	git commit -m "fixup! changeY" fileY &&
+
+	git rebase -i --autosquash --empty=keep HEAD~3 &&
+
+	git log --format=%s >actual &&
+	grep changeY actual &&
+	: "the retained commit is empty" &&
+	git diff --exit-code HEAD~1 HEAD &&
+	echo 1 >expect &&
+	test_cmp expect fileY
+'
+
+test_expect_success 'fixup! that empties its target stops with --empty=stop' '
+	git reset --hard base &&
+	test_commit --no-tag addZ fileZ 1 &&
+	test_commit --no-tag changeZ fileZ 2 &&
+	echo 1 >fileZ &&
+	git commit -m "fixup! changeZ" fileZ &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash --empty=stop HEAD~3
+'
+
+test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addS fileS 1 &&
+	test_commit --no-tag changeS fileS 2 &&
+	echo 1 >fileS &&
+	git commit -m "squash! changeS" fileS &&
+
+	git rebase -i --autosquash --empty=drop HEAD~3 &&
+
+	git log --format=%s >actual &&
+	! grep changeS actual &&
+	grep addS actual &&
+	echo 1 >expect &&
+	test_cmp expect fileS
+'
+
+test_expect_success 'fixup! filling in an empty commit keeps a non-empty commit' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	test_commit --no-tag "fixup! placeholder" fileP content &&
+
+	git rebase -i --autosquash --empty=stop HEAD~2 &&
+
+	git log --format=%s >actual &&
+	grep placeholder actual &&
+	echo content >expect &&
+	test_cmp expect fileP &&
+	: "the once-empty placeholder is no longer empty" &&
+	test_must_fail git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'fixup! leaving an empty commit empty stops with --empty=stop' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash --empty=stop HEAD~2
+'
+
+test_expect_success 'fixup! leaving an empty commit empty is dropped with --empty=drop' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	git rebase -i --autosquash --empty=drop HEAD~2 &&
+
+	git log --format=%s >actual &&
+	! grep placeholder actual
+'
+
+test_expect_success 'fixup! leaving an empty commit empty is kept with --empty=keep' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	git rebase -i --autosquash --empty=keep HEAD~2 &&
+
+	git log --format=%s >actual &&
+	grep placeholder actual &&
+	git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'a dropped emptied fixup is not recorded as rewritten' '
+	git reset --hard base &&
+	test_commit --no-tag preR fileR 1 &&
+	test_commit --no-tag changeR fileR 2 &&
+	R=$(git rev-parse HEAD) &&
+	echo 1 >fileR &&
+	git commit -m "fixup! changeR" fileR &&
+	F=$(git rev-parse HEAD) &&
+	test_commit --no-tag keepR fileK keep &&
+
+	test_when_finished "rm -f .git/hooks/post-rewrite actual.rewrites" &&
+	write_script .git/hooks/post-rewrite <<-\EOF &&
+	cat >actual.rewrites
+	EOF
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	: "changeR and its fixup were dropped, so must not be reported as" &&
+	: "rewritten, but the surviving keepR must be" &&
+	! grep -e "$R" -e "$F" actual.rewrites &&
+	grep "$(git rev-parse HEAD)" actual.rewrites
+'
+
 test_done



