Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6E3921E6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939501; cv=none; b=Cz1hXcfgv3LcrL3LZOBaU1/wkKPZUpejvfiTVzlkTvzCZs6YX9tUXIlY2lv2buethpYJlXQEr5MOevrVgUDe1Ry9kvf89qyjQFvYeA9PAQTNONPa1eM2rqDhwApWhoKr7GhfnXixKQ7L9KdE+U+mpughDIMU5WDrnnJznxZCgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939501; c=relaxed/simple;
	bh=AoJJ6k9FboT6mt27UQhKIe8wUV9lXFbDbFycFg3tsoo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jpsJHy0p5gWlXZ3lOu4mSohmCdrXQ0uipjEpq1x/blJtxxnJVBe96acpN/sE9CUH6vOIxRMfVs/CY9fS8k0sUFksWMTY7prSXi9JGvoSg0b/H7hGF55stVi3lfS7nBO0VtunYBznCQtHKK9U/JtAor4lHZawHP+yDEv8SCE4xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtseoABl; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtseoABl"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so5879494c88.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939499; x=1791544299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sRBiJTSalX5DVsaRiINZB/aG8O/jUWDPw10Ecj7mOx0=;
        b=qtseoABlJgiecF4s8bMSTWIs2yikJp+XhEjGT+FH05SIGxWBzOpYazO/Gq/UTlzaYc
         LrSOmtcw+9ieS3s4Wa45UygfVUlxN6QZBy5EyHCXKqY3dqCzCbSeGr23gYJmCWutqqZ6
         MFzk697khz4IWnrBwZ3Nra43IwMekZOZU4hYDRgt0v2QQ257qhH0w5mGi6s6wP6nE7i3
         pTPNIeL/ODj3t+2EbULDAIVyFQgacIDOv+RGNoSLBQUlJirqtGKxOlbb/HQbdLhLWRYn
         pUj4VnvUq/FQi7/iDKU2t3l+5aaSCK+iDNkFGgiB0r6M/YwDgMrcYmlX8Zgw8RzO6gXA
         EDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939499; x=1791544299;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRBiJTSalX5DVsaRiINZB/aG8O/jUWDPw10Ecj7mOx0=;
        b=zKtxTr7hYOHqszsIB2dncy+5AOG4/xZIL5tpMTKjEC29CN8ZzT7t/fbz9Ms3mO0304
         Z6SrxrQpTurmcvF2b/ypFJ4FLjRTIEFU1JPoYuu3JwrOqzrhp2pJiLD1OOqIWm7yLONy
         yvMLMQP2hW+GG63w2vQlsL6zCgn7hBesH9V9BGFoXNFjMBVoJorTuT3sTzxxV6cgSXql
         Kr0JjiNJ+u73Tt76A59Px4uy3UyWfKKR4N0TicNde295ZwikUfj1g9RmUj72IWJ28mIP
         zVhFdLjK7lrKjeCcogh/eewGDrHAXffrsOgvhM+sOKST6EV26JDl2e8nZCKEJeCaoowk
         K4Yg==
X-Gm-Message-State: AFuF++lnRPxbhz9ZvsRGIfP86D4aPn8AKLzxheRIIHqcjdWvjEE2fOgp
	5RkIQjOj7o/ya8X0OB4ckhBsgdtu7d/pQcbzaYMTp7RmxE7dsfuwK8qdfkicqA==
X-Gm-Gg: AYBFou2BZqJexaomGma9asnNodPRgdOMLUBJ0jiNm7bbJSDi4dpjdn+lnNVFMfpWSQz
	G/sy/OvJpMhHx5F0T+Xd1PkNiXaCgyWu1aDcUrVABz9xeNpsxHTrJd9GogsQLT8LV9dRR9yrick
	1T4RDtJq0zuozeACPJ7fnixVMpeeJWVU1g0MfoZ+jMqlJlzqZM/gsrfNK8wjcb2iVeKW2sNxnB3
	DCTvCCZTBTlCyWozvQa1/HL+cdlcEuS7/Gm73hTOcrOE42goXKsx1rEcWFuT0oPaVb8XLP6pIng
	sksLUNBpQv8ccnnksS+Gv2Qkg1qnYsL/FTI7sWPhrWkwDSnMNJkdhMs5caGgEntnHbWTOF8FKGs
	s8y4SEd4Ou0nsg8I6zHHR1oJ/KEHo9efzEq5WsicooySts6MwaXqThCc7q+VAChUP6NorWSpZ/r
	vasu5DsE032ZWFU1DPhyBp2i1g1455YPqPyswE84K1f8ig0K0p3JqS3XfPB6b1HRb+/lRpjg==
X-Received: by 2002:a05:701b:42c1:20b0:144:c123:4036 with SMTP id a92af1059eb24-14f5cadad4amr2683726c88.35.1790939498835;
        Fri, 02 Oct 2026 04:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.59.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f47a57592sm5327205c88.17.2026.10.02.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:11:38 -0700 (PDT)
Message-Id: <cd018289bbb330753e41a1e5b6156b6e85c12dbe.1790939492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 11:11:32 +0000
Subject: [PATCH v6 3/3] rerere: go on at a conflict when the lock stays busy
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

When a merge, rebase, cherry-pick, revert, am, stash or apply stops
at a conflict, it runs rerere right before it returns to the user.
If MERGE_RR.lock is still held when rerere.lockTimeout runs out, the
command dies there. In a rebase, the sequencer has not yet written the
state that "git rebase --continue" needs. A later
"git rebase --continue" fails, and the "git commit --amend" that its
message offers first folds the conflicted pick into the previous
commit.

So warn and go on without rerere. The conflict is still in place, and
a hint tells the user to run "git rerere" before resolving it. That
records the preimage or replays a known resolution, as the command
would have. The hint is under advice.mergeConflict like other hints
printed at a conflict stop.

Everything else that waits for the lock is left as it is and still
fails if the wait times out. That includes "git commit" and
"git am --continue", which run rerere after a resolution. When they
fail, the rebase or am can still be continued.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  12 ++--
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/merge.c                  |   2 +-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  30 ++++++--
 rerere.h                         |   2 +
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 120 ++++++++++++++++++++++++++++++-
 9 files changed, 159 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 80c38ee951..08fb1cd37e 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -16,7 +16,11 @@ rerere.lockTimeout::
 	lock when another process holds it, typically a background
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
-	second).  When the time is up, the command fails as it does
-	for any other lock it cannot take.  A `git rerere gc` run by
-	`git maintenance run --auto` or `git gc --auto` does not wait
-	and does nothing while the lock is held.
+	second).  When the time is up, a command that stops at a
+	conflict, such as `git merge` or `git rebase`, prints a
+	warning and goes on without rerere; run `git rerere` before
+	resolving the conflict to record it after all.  Any other
+	command fails, as it does for any other lock it cannot take.
+	A `git rerere gc` run by `git maintenance run --auto` or
+	`git gc --auto` does not wait and does nothing while the lock
+	is held.
diff --git a/apply.c b/apply.c
index f00b7ba4d3..f2b896af9d 100644
--- a/apply.c
+++ b/apply.c
@@ -4865,7 +4865,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		 * tree with conflict markers, but that isn't written with --cached.
 		 */
 		if (!state->cached)
-			repo_rerere(state->repo, 0);
+			repo_rerere(state->repo, RERERE_WARN_LOCKED);
 	}
 
 	return errs;
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..aa09211461 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1649,7 +1649,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		repo_rerere(the_repository, state->allow_rerere_autoupdate);
+		repo_rerere(the_repository, state->allow_rerere_autoupdate |
+			    RERERE_WARN_LOCKED);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..68511614c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1061,7 +1061,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	repo_rerere(the_repository, allow_rerere_auto);
+	repo_rerere(the_repository, allow_rerere_auto | RERERE_WARN_LOCKED);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..08062512c1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -732,7 +732,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		repo_rerere(the_repository, 0);
+		repo_rerere(the_repository, RERERE_WARN_LOCKED);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/rerere.c b/rerere.c
index 43c8eb04db..bb7052d3a1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "copy.h"
 #include "environment.h"
@@ -887,11 +888,13 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
-		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
+	if ((flags & RERERE_READONLY) &&
+	    (flags & (RERERE_NOWAIT | RERERE_WARN_LOCKED)))
+		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
 	if (flags & RERERE_READONLY) {
 		fd = 0;
 	} else {
+		const char *path = git_path_merge_rr(r);
 		int lock_flags = LOCK_DIE_ON_ERROR;
 		int timeout_ms = rerere_lock_timeout_ms;
 
@@ -900,17 +903,32 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 		 * "git rerere gc" while it prunes rr-cache, so wait for
 		 * it instead of dying right away.  The gc of an automatic
 		 * maintenance run does not wait, since skipping one of
-		 * its runs costs nothing.
+		 * its runs costs nothing.  A command that stops at a
+		 * conflict must not die here either, so it warns and
+		 * goes on without rerere.
 		 */
 		if (flags & RERERE_NOWAIT) {
 			lock_flags = 0;
 			timeout_ms = 0;
 		}
+		if (flags & RERERE_WARN_LOCKED)
+			lock_flags = 0;
 		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
-							    git_path_merge_rr(r),
-							    lock_flags, timeout_ms);
-		if (fd < 0)
+							    path, lock_flags,
+							    timeout_ms);
+		if (fd < 0) {
+			if (flags & RERERE_WARN_LOCKED) {
+				warning_errno(_("skipping rerere, "
+						"unable to create '%s.lock'"),
+					      path);
+				advise_if_enabled(ADVICE_MERGE_CONFLICT,
+						  _("run \"git rerere\" before "
+						    "resolving the conflict to "
+						    "record or replay its "
+						    "resolution"));
+			}
 			return -1;
+		}
 	}
 	read_rr(r, merge_rr);
 	return fd;
diff --git a/rerere.h b/rerere.h
index d54c53d0d4..12ff4a8adb 100644
--- a/rerere.h
+++ b/rerere.h
@@ -12,6 +12,8 @@ struct repository;
 #define RERERE_READONLY     04
 /* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
 #define RERERE_NOWAIT       010
+/* Warn and go on without rerere if MERGE_RR.lock cannot be taken in time */
+#define RERERE_WARN_LOCKED  020
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/sequencer.c b/sequencer.c
index 6dae43e4db..17a775806d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2520,7 +2520,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_WARN_LOCKED);
 		goto leave;
 	}
 
@@ -4449,7 +4449,7 @@ static int do_merge(struct repository *r,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_WARN_LOCKED);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 28152bf456..a9dfe74091 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -277,17 +277,133 @@ test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	test_grep "^=======\$" $rr/preimage
 '
 
-test_expect_success 'merge fails once rerere.lockTimeout is up' '
+test_expect_success 'merge goes on without rerere once rerere.lockTimeout is up' '
 	git reset --hard &&
 	rm -rf $rr &&
 	test_when_finished "rm -f .git/MERGE_RR.lock" &&
 	>.git/MERGE_RR.lock &&
 	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
-	test_grep "Unable to create" err &&
+	test_grep "skipping rerere" err &&
+	test_grep "hint: .*git rerere" err &&
 	test_grep "^=======\$" a1 &&
 	test_path_is_missing $rr/preimage
 '
 
+test_expect_success 'rerere run at the stop records what was skipped' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-catch-up third &&
+	test_when_finished "git checkout third && git branch -D lock-held-catch-up" &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first &&
+	test_path_is_missing $rr/preimage &&
+	rm .git/MERGE_RR.lock &&
+	git rerere &&
+	test_grep "^=======\$" $rr/preimage &&
+	echo resolved >a1 &&
+	git add a1 &&
+	git commit -qm resolved &&
+	test_path_is_file $rr/postimage
+'
+
+test_expect_success 'rebase goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held third &&
+	test_when_finished "git checkout third && git branch -D lock-held" &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase first 2>err &&
+	test_grep "skipping rerere" err &&
+	test_path_is_file .git/rebase-merge/stopped-sha &&
+	rm .git/MERGE_RR.lock &&
+	echo resolved >a1 &&
+	git add a1 &&
+	git rebase --continue &&
+	test_path_is_missing .git/rebase-merge &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'rebase -r goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	git checkout -b lock-held-merge second &&
+	test_when_finished "test_might_fail git rebase --abort &&
+		git checkout third && git branch -D lock-held-merge" &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase -r --force-rebase main 2>err &&
+	test_grep "skipping rerere" err &&
+	test_cmp_rev REBASE_HEAD second &&
+	rm .git/MERGE_RR.lock &&
+	git rebase --abort &&
+	test_path_is_missing .git/rebase-merge
+'
+
+test_expect_success 'commit fails on a lock it cannot take' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-commit third &&
+	test_when_finished "git checkout third && git branch -D lock-held-commit" &&
+	test_must_fail git merge first &&
+	test_path_is_file $rr/preimage &&
+	echo resolved >a1 &&
+	git add a1 &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 commit -qm resolved 2>err &&
+	test_grep "Unable to create" err &&
+	test_path_is_missing $rr/postimage
+'
+
+test_expect_success 'am goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-am third &&
+	test_when_finished "test_might_fail git am --abort &&
+		git checkout third && git branch -D lock-held-am" &&
+	git format-patch -1 --stdout first >first.patch &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 am --3way first.patch 2>err &&
+	test_grep "skipping rerere" err &&
+	test_path_is_dir .git/rebase-apply &&
+	rm .git/MERGE_RR.lock &&
+	git am --abort &&
+	test_path_is_missing .git/rebase-apply
+'
+
+test_expect_success 'stash pop goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-stash third &&
+	test_when_finished "git reset --hard && git stash drop &&
+		git checkout third && git branch -D lock-held-stash" &&
+	echo stashed >>a1 &&
+	git stash &&
+	echo committed >>a1 &&
+	git commit -qam committed &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 stash pop 2>err &&
+	test_grep "skipping rerere" err &&
+	test_grep "^=======\$" a1
+'
+
+test_expect_success 'apply --3way goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-apply third &&
+	test_when_finished "git reset --hard &&
+		git checkout third && git branch -D lock-held-apply" &&
+	git format-patch -1 --stdout first >first.patch &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 apply --3way first.patch 2>err &&
+	test_grep "skipping rerere" err &&
+	test_grep "^=======\$" a1
+'
+
 test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
 	test_when_finished "rm -f .git/MERGE_RR.lock" &&
 	>.git/MERGE_RR.lock &&
-- 
gitgitgadget
