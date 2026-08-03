Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE94379960
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750649; cv=none; b=nPGXBUCZbW3c0Y9fD9tW6C5n4eZEBJ+VeQVdR3JooRA674egylP8ZjoAZ0YbHGJB0wix2p8J5m1QkW1PrCOvtQpsHFSdojzuD8XDVDs8RHSAXewTMJ7236UgCqp5POvuwh755pgqT2NQHuF6ud0qcMSgf87J1NwLnBTSdhOkbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750649; c=relaxed/simple;
	bh=oCd+HVd7Bgll/b3FqNuFD9sbpoRLvhadp/oCRGgV1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC9nsBx7XqyMq6CrumqTL1haLjKYPvuIjEarr8R8vFno0jcsfHj6VC0GvdgwEWIBesXj2U8nTVnyrYdvrLGdY3dcSX/apT9tdWojsTu0noy3vXAS+g167OUqk+xgosUCcVljaQu/KEPwy86cid88QB0hMk5uT6a3X5MYQm4lXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzrdAAzc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzrdAAzc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so17028675e9.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750646; x=1786355446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUSQRUdfOiPHsPLYc7WzbPoNB7wdU5E0JU+gVhEyqIQ=;
        b=MzrdAAzclUwXRlcirZMmR3RV1JibQNPYnhBSnnQsHurX7SEmLq+Qgb0+/AHidjc9KJ
         fPdVyAEw9VPW6wlmg5uP8RiDMHWJS6ijLE0VdJh4mlRWPi7OVSQIHPH0urwl4zQLIb2w
         upM/5sC0K/wW5uFhj75BOrN/8I1BfyNf8HQM9pk6WdgOKkaVe7OE0ujcYAwjXdYJDd9L
         YrYAX0NJfLCUEZyrkHC7tv+lXFt1fsZ94zhLnhchwLLlC5OR/LYaHqdnFP2uhf/gOndx
         1PoQfI9ULRNtm4F/ssUbwlOHkAk/0vNgCJ6CXJ0nFxDMtT3hMvfIYbIbSSmEstmHpcVM
         Cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750646; x=1786355446;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUSQRUdfOiPHsPLYc7WzbPoNB7wdU5E0JU+gVhEyqIQ=;
        b=kaHOexuLKrYB0wPt03Hb76eP01NTvjuzTP03Q1BW3XmO8B9tZbFnDrT3dtzZ16fmjs
         XU+9KgUlT/q7+KqEhpY9r7d30v7QEh6I7juwnaXCZm2Y0YzJ2Dak9q/zpMtjKcyEb95/
         xnWc2+b7BFTi4DNeOhR1I41WNsCXJlBdlMyPzCTeriXMpgrKKSmUnxBuM+PQcX1DVxKG
         KhxDk4qqF3Mp6tusUW3oGC1oHjENXyeZmqNwWrIvLj2ZpWNsUrX/tpIU6zJxVEdLape2
         BBnzm7abiikgH9ymvH5VqxdWgCIeOW9YAdWPJDTL+aOmsNaCMXujGUrPbArVMBzD5oqf
         0P7A==
X-Gm-Message-State: AOJu0YzdwqwYuyjiCK3iU8b9/FtSJ89xK5E8ckUSw8luI9ShL787vlrM
	IqPGlhPrKgpCGnMjKaQlyp3wmhLCzcqVznShT1XRKEwztQ4ahGIlMMGi0XXMwA==
X-Gm-Gg: AR+sD125wXly3oQHf89Ipj0T/UFCvavXXGmIW6mXEPQJGOhCGUYcqF7N+QshUh1TP2h
	SmEDT6ux41f5y4aPk8Vrd5PE4Ycns6KvynlK2DO9OgwJ2Hd+7kaL/YbGenRqAU6olSOa8pilosD
	oUQaxUE/clRf9SNl/iyOCOeYDGUbuXsK2yQOqm6soejL+kikJVbjZEKZyPAbw+EZdH/SFsBotY2
	4ja2TO3U3g3vXLAyrPy93s+FCz5P5MH0k2vlxuWjlZZ0rn14YuKsWKGwNttr180Bj52XCTjztof
	WEkKWrBOz6X/2zMV/vnzGtQKglvy89hdfxTVb8HgRrt1I/+lZSdPgOKGKtfB11XPFLDHVcYGkRP
	dj2VJcz/3yYtIAJh7aPtdrJdlVQNF1EzT22G9FMnDNtPTuFqqp1rwcwi3Wo++KkssffXvPzpIMI
	ABg5eIAdhgbZ9RNO9Qy9cMAdNjc00Zz1Y97Ur/84mQZUYzkyWBHrYrrF++s7Du85Ee
X-Received: by 2002:a05:600c:1553:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4980ee7e62amr172639025e9.16.1785750645491;
        Mon, 03 Aug 2026 02:50:45 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.5/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:25 +0100
Message-ID: <4b994a075b6332b45113bfbcfbeb62168e20c255.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Refuse to squash if there are branches descended from squashed commits

Rework the detection of branches descended from squashed commits
to protect branches that are not updated (i.e. any branch that is
descended from the squashed range but not the tip of the range). The
current behavior of protecting only those branches that point directly
at a squashed commit but not those descended from the same commit
is inconsistent and confusing. Note that this change means we now
complain when a branch points to the start of the squashed range.

When walking the commits we only need to add those with a parent
outside the squashed range to the ref filter as all the other commits
are descended from those. This patch needs some polishing to print the
branches that are causing us to error out. I've updated the existing
tests to reflect that, though I'm unclear what extra coverage the last
test (squashes a range whose internal merge has a single base) adds.

We do not protect detached HEADs that point to a commit in the
squashed range. I think that's reasonable - if HEAD is detached,
the user is likely experimenting so does not necessarily care that
the commits are being squashed in a different worktree. Protecting
them would require a separate revision walk including the detached
HEADs from all worktrees and excluding the base of the squashed range.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c         | 85 +++++++++++++++++----------------------
 t/t3455-history-squash.sh | 67 ++++++++++++++----------------
 2 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index bb4a74ec1a..84e13fd75a 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -17,6 +17,7 @@
 #include "path.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "ref-filter.h"
 #include "replay.h"
 #include "reset.h"
 #include "revision.h"
@@ -1019,16 +1020,18 @@ static int cmd_history_split(int argc,
  * but the range must have a single base and must not reach a root commit.
  */
 static int resolve_squash_range(struct repository *repo,
+				bool update_branches,
 				int argc, const char **argv,
 				struct commit **base_out,
 				struct commit **oldest_out,
-				struct commit **tip_out,
-				struct oidset *interior_out)
+				struct commit **tip_out)
 {
 	struct rev_info revs;
 	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
 	size_t i;
 	int ret, tip_count = 0;
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array refs = { 0 };
 
 	repo_init_revisions(repo, &revs, NULL);
 	revs.reverse = 1;
@@ -1101,8 +1104,12 @@ static int resolve_squash_range(struct repository *repo,
 			 * Allow parents that match the parents of the
 			 * squashed commit.
 			 */
-			for (q = oldest->parents; !seen && q; q = q->next)
-				seen = p->item == q->item;
+			for (q = oldest->parents; !seen && q; q = q->next) {
+				if (p->item == q->item) {
+					seen = true;
+					commit_list_insert(commit, &filter.with_commit);
+				}
+			}
 			if (!seen) {
 				ret = error(_("parent %s of commit %s is "
 					      "outside the revision range"),
@@ -1117,14 +1124,16 @@ static int resolve_squash_range(struct repository *repo,
 				o->flags &= ~SQUASH_TIP;
 			}
 		}
-		if (!oldest)
+		if (!oldest) {
+			commit_list_insert(commit, &filter.with_commit);
 			oldest = commit;
-		if (tip)
-			oidset_insert(interior_out, &tip->object.oid);
+		}
 		tip = commit;
 		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
 		tip_count++;
 	}
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	reset_revision_walk();
 	if (!tip_count) {
 		ret = error(_("the revision range is empty"));
 		goto out;
@@ -1138,6 +1147,24 @@ static int resolve_squash_range(struct repository *repo,
 		goto out;
 	} else if (!oldest->parents) {
 		BUG("an in-range commit must have a parent");
+	}
+	commit_list_insert(tip, &filter.no_commit);
+	filter.kind = FILTER_REFS_BRANCHES;
+	if (update_branches &&
+	    filter_refs(&refs, &filter, filter.kind)) {
+		ret = error(_("could not filter refs"));
+		goto out;
+	}
+	if (refs.nr) {
+		/*
+		 * TODO: list the branches and also check HEADS from other worktrees
+		 */
+		ret = error(_("a branch points to a commit that is being squashed"));
+		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+				  _("Use --update-refs=head to rewrite only "
+				    "the current branch and leave such refs "
+				    "untouched."));
+		goto out;
 	}
 	base = oldest->parents->item;
 
@@ -1147,9 +1174,9 @@ static int resolve_squash_range(struct repository *repo,
 	ret = 0;
 
 out:
-	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
-	reset_revision_walk();
 	release_revisions(&revs);
+	ref_filter_clear(&filter);
+	ref_array_clear(&refs);
 	return ret;
 }
 
@@ -1261,23 +1288,6 @@ static int reject_dangling_fixups(struct repository *repo,
 	release_revisions(&revs);
 	strvec_clear(&args);
 	return ret;
-}
-
-struct interior_ref_cb {
-	const struct oidset *interior;
-	const char *name;
-};
-
-static int find_interior_ref(const struct reference *ref, void *cb_data)
-{
-	struct interior_ref_cb *data = cb_data;
-
-	if (oidset_contains(data->interior, ref->oid)) {
-		data->name = xstrdup(ref->name);
-		return 1;
-	}
-
-	return 0;
 }
 
 static int cmd_history_squash(int argc,
@@ -1305,7 +1315,6 @@ static int cmd_history_squash(int argc,
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf message = STRBUF_INIT;
-	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten, *msg_source,
 		*amend_source;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1328,8 +1337,8 @@ static int cmd_history_squash(int argc,
 	strbuf_addstr(&reflog_msg, "squash: updating ");
 	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
 
-	ret = resolve_squash_range(repo, argc, argv, &base, &oldest, &tip,
-				   &interior);
+	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
+				   argc, argv, &base, &oldest, &tip);
 	if (ret < 0)
 		goto out;
 
@@ -1347,23 +1356,6 @@ static int cmd_history_squash(int argc,
 		strbuf_addstr(&message, body);
 		message_template = message.buf;
 		repo_unuse_commit_buffer(repo, amend_source, amend_message);
-	}
-
-	if (action == REF_ACTION_BRANCHES) {
-		struct interior_ref_cb cb = { .interior = &interior };
-
-		refs_for_each_ref(get_main_ref_store(repo),
-				  find_interior_ref, &cb);
-		if (cb.name) {
-			ret = error(_("'%s' points into the squashed range"),
-				    cb.name);
-			advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
-					  _("Use --update-refs=head to rewrite only "
-					    "the current branch and leave such refs "
-					    "untouched."));
-			free((char *)cb.name);
-			goto out;
-		}
 	}
 
 	ret = setup_revwalk(repo, action, tip, &revs);
@@ -1395,7 +1387,6 @@ static int cmd_history_squash(int argc,
 out:
 	strbuf_release(&reflog_msg);
 	strbuf_release(&message);
-	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
 	return ret;
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index ba826df592..d7697489a0 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -305,17 +305,36 @@ test_expect_success '--update-refs=head only moves HEAD' '
 	test_cmp_rev "$other_before" other
 '
 
-test_expect_success 'refuses to fold a range a ref points into' '
-	git reset --hard three &&
-	git branch -f mid HEAD~1 &&
-	head_before=$(git rev-parse HEAD) &&
+test_expect_success 'refuses to fold a range a branch points into' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f -b feature start &&
+	test_commit C1 &&
+	test_commit C2 &&
+	git checkout -b topic-1 start &&
+	test_commit C3 &&
+	test_commit C4 &&
+	git checkout C3 &&
+	test_commit C5 &&
+	git checkout feature &&
+	git merge C5 &&
+	test_commit C6 &&
+	git checkout -b topic-2 C2 &&
+	test_commit C7 &&
+	git checkout feature &&
 
 	test_must_fail git history squash start.. 2>err &&
-	test_grep "error: .* points into the squashed range" err &&
-	test_grep "hint: .*--update-refs=head" err &&
-	test_cmp_rev "$head_before" HEAD &&
+	# TODO: check the branch names when we print them (topic-1 & topic-2)
+	test_grep "^error: a branch points to" err &&
+	test_grep "^hint: .* --update-refs=head" err &&
+	test_cmp_rev C6 HEAD &&
 
-	git branch -D mid
+	# squash succeeds with --update-refs=head
+	git history squash --update-refs=head start.. &&
+	test_cmp_rev start HEAD^ &&
+	test_cmp_rev C6^{tree} HEAD^{tree} &&
+	test_cmp_rev C6 HEAD@{1}
 '
 
 test_expect_success 'advice.historyUpdateRefs silences the hint' '
@@ -325,37 +344,11 @@ test_expect_success 'advice.historyUpdateRefs silences the hint' '
 
 	test_must_fail git -c advice.historyUpdateRefs=false \
 		history squash start.. 2>err &&
-	test_grep "points into the squashed range" err &&
+	test_grep "^error: a branch points to" err &&
 	test_grep ! "hint:" err &&
 	test_cmp_rev "$head_before" HEAD &&
 
 	git branch -D mid
-'
-
-test_expect_success '--update-refs=head folds past a ref pointing into the range' '
-	git reset --hard three &&
-	git branch -f mid HEAD~1 &&
-	mid_before=$(git rev-parse mid) &&
-
-	git history squash --update-refs=head start.. &&
-
-	check_commit_count start..HEAD 1 &&
-	test_cmp_rev "$mid_before" mid &&
-
-	git branch -D mid
-'
-
-test_expect_success 'refuses to fold a range a tag points into' '
-	git reset --hard three &&
-	git tag -f mark HEAD~1 &&
-	head_before=$(git rev-parse HEAD) &&
-
-	test_must_fail git history squash start.. 2>err &&
-	test_grep "refs/tags/mark" err &&
-	test_grep "points into the squashed range" err &&
-	test_cmp_rev "$head_before" HEAD &&
-
-	git tag -d mark
 '
 
 test_expect_success 'squashes a range whose internal merge has a single base' '
@@ -582,8 +575,8 @@ test_expect_success 'refuses to fold a range a ref points into at a merge' '
 	head_before=$(git rev-parse HEAD) &&
 
 	test_must_fail git history squash start.. 2>err &&
-	test_grep "at-merge" err &&
-	test_grep "points into the squashed range" err &&
+	# TODO: test for branch nome "at-merge"
+	test_grep "a branch points to a commit" err &&
 	test_cmp_rev "$head_before" HEAD &&
 
 	git branch -D at-merge
-- 
2.54.0.200.gfd8d68259e3

