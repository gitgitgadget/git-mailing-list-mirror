Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3539CCEA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373068; cv=none; b=dMkGcx3tdH1gGbLqR7iDrzZE7R43+ayOGr1s+zItGzPh5nIzK7Pe0ei+pYFGy4fj83w60hy0B0fOiOjd8yWLse4dnF24zNEOt+6apWon0hzxAR684+XjCdFttdjGnXaCYXgunu8rTBWJ+E8X+GcQXONFlLWGppoG2mN5+i2J7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373068; c=relaxed/simple;
	bh=58D2I0Y8wcIQF+87b1oeuHOy5jxDMzELvCq9QHBBfUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bChzM87kvrm/kLzfsdkdf+rAbUJkhLelS1+5v+7kb4P3dGRhvEfC+0iWO+pk/KdPdMQHNZHsQiLwS/0agyTYMRa10JIxaUH29nesVYPL120YAq/XXDFnzSVYY7e/APIUBwDME9R3dHO9BYXMIcJLhc3VWdQr9TtEceJ6IoHN+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riS2YvfQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riS2YvfQ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93a0fb2f9efso79151785a.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373065; x=1789977865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQAUn7DYIM/qCthpHN/nUFpATXWYghmJmQD5zoKMj6E=;
        b=riS2YvfQq4Hv06A8jpx+sStYzEX8o6l33oFeqwpMv7oHTRtJKplpw/EJbG1K8CBooQ
         2m0Il9MsESAwLppZDfhk5jiaeKm4PYxRdZdH7MXV5CTSZEn5ULYe7CNscJquJ0LTnNq6
         JZqBk6iUK9DW9t7JomGXx58/RQN28XsLvY7dHK1IoJlg7ZJVdwnNfm0exLp5CJbZS+wp
         /iNRtp7HtrMbW2B/ugUk/ya5oFZetwT8G6Idl4W4q6LED03lihmXWFFpUfzWV2tPCj5c
         5VQ/nP40XDmT/pG5EaL0bolUe5HH+TZK1e6pHU+GnEor6CXFhK384Xm66XUl1Wq10WXn
         pWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373065; x=1789977865;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQAUn7DYIM/qCthpHN/nUFpATXWYghmJmQD5zoKMj6E=;
        b=ISsqGvNylGUwWXUiBtRySWibNh5P+2yZ+WcaYJMMPYluVddBl8IpZhDDSbYxgTx6BM
         b5G7XZiEIiJojolSeiQ1x9XUKmZKfVWBWnL1HOOVC5P4JeQLINru+857RbBBw87oatss
         RUEMcmk+ZVNkTPb6QB9a7q6hOv4m02vlskP+uTzyjsjJeSfMe0rrHHqjCHFMwMeHx+Mi
         6t7zsdryOpET2JGH0PCbJiVDtkGotYcZ/S+SQ7uJ/v+R0VTey4+pUXBFfPm15Xs8297l
         g6mHB2PRzAbcp9hRvM5jw0kvCPSO0f9cpmFN/H9DgQ7FApWCICV2ccoBlrgSKZlo/XZs
         z5og==
X-Gm-Message-State: AFuF++l9ejPkMjQlGqc6mndx+SuqpimP6u7WN+i8vCBILXs9c3Bk4JYg
	5mcUlX4FZwi4bnzsWyaqNuiqSOBtxbzLOXk9Vd1xuISNX+FnpAg9a7xEP0hXSQ==
X-Gm-Gg: AYBFou0nyEVlD5AgE0F86LmoeeatyC4O5tJkPmmVBhku2HQeaaEdXZPPQIQh9/9FzJb
	5tq070nIeT4pAiwLygs017HSvZVM06DsIplLUpdW4+GYAr/WJXllgzG1DOieR9WQkFllpIUkLdg
	Pik0ien07oNpkqCghC8p/BB/gUSeyFZobp1+kJ0YOVAhvRWrjXs7dLULx0MuHRs71pPqBEqE7DQ
	hb8fcx4Xodj8Se6Grq3jf8M+/eK9iD4zkx/Ygdi615lwKUGA9GYb2pyQCJm8lModMBggKLJ48a5
	JWQOHLfkfS3WmGqf/OjvNnXiIYtVUYkOBzyB0j14FA8GDIcXyxPhMzyHbPGZitjdV17xYs+Gk5t
	X2DvVVKdjRWFdgYMJQ34lTdnJaWR+CPFs6s/BiPcuLThjFnPmiV+/ad3EVrQ4mlL8p5ocl493fQ
	lSFupBgHgC1UmTIs6jtMzZ6f48VEaqa6mjbeIkpFczwBqm82J9H8S87zw0GB8fDmCSGuNPgTbk9
	7TF
X-Received: by 2002:a05:620a:4710:b0:939:fcf1:5c27 with SMTP id af79cd13be357-93a18551fc3mr549570985a.8.1789373064426;
        Mon, 14 Sep 2026 01:04:24 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.210.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e86b7424sm921299685a.32.2026.09.14.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:04:23 -0700 (PDT)
Message-Id: <1cce403113833c14a1c4a0da0db0772c5abdeb1c.1789373061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 08:04:21 +0000
Subject: [PATCH v4 2/2] rerere: go on at a conflict when the lock stays busy
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
command dies there. For a rebase that is worse than a lost
recording: the sequencer has not yet written the state that
"git rebase --continue" needs, so the rebase cannot continue, and
following the "git commit --amend" advice folds the conflicted pick
into the previous commit.

So print a warning and go on instead. The conflict is still in
place, and the warning tells the user to run "git rerere" before
resolving it. That records the preimage, or replays a known
resolution, just as the command would have done.

All other callers still fail when the timeout runs out. "git commit"
and "git am --continue" record the resolution and then move on to
the next commit or patch. A warning would come too late there, and
the next rerere run would record whatever the file contains by then.
The "rerere clear" that am and rebase run for --skip and --abort
would leave the same stale entry behind. "git rerere", "git rerere
forget" and "git rerere clear" fail because the user asked for that
state explicitly.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  10 ++-
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/merge.c                  |   2 +-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  16 ++++-
 rerere.h                         |   2 +
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 105 ++++++++++++++++++++++++++++++-
 9 files changed, 132 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index cc9dd0c37b..81deefa006 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -16,6 +16,10 @@ rerere.lockTimeout::
 	lock when another process holds it, typically a background
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
-	second).  When the time is up, the command fails as it does
-	for any other lock it cannot take.  `git rerere gc` never
-	waits and skips its run while the lock is held.
+	second).  When the time is up, a command that stops at a
+	conflict, such as `git merge` or `git rebase`, prints a
+	warning and goes on without rerere; run `git rerere` before
+	resolving the conflict to record it after all.  Any other
+	command fails, as it does for any other lock it cannot take.
+	`git rerere gc` never waits and skips its run while the lock
+	is held.
diff --git a/apply.c b/apply.c
index f00b7ba4d3..3b8502535b 100644
--- a/apply.c
+++ b/apply.c
@@ -4865,7 +4865,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		 * tree with conflict markers, but that isn't written with --cached.
 		 */
 		if (!state->cached)
-			repo_rerere(state->repo, 0);
+			repo_rerere(state->repo, RERERE_SKIP_LOCKED);
 	}
 
 	return errs;
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..bcb93db515 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1649,7 +1649,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		repo_rerere(the_repository, state->allow_rerere_autoupdate);
+		repo_rerere(the_repository, state->allow_rerere_autoupdate |
+			    RERERE_SKIP_LOCKED);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..1ed5959bfd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1061,7 +1061,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	repo_rerere(the_repository, allow_rerere_auto);
+	repo_rerere(the_repository, allow_rerere_auto | RERERE_SKIP_LOCKED);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 72c52571f8..83b6e1be72 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -729,7 +729,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		repo_rerere(the_repository, 0);
+		repo_rerere(the_repository, RERERE_SKIP_LOCKED);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/rerere.c b/rerere.c
index 7d44f3937c..a996d39159 100644
--- a/rerere.c
+++ b/rerere.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "copy.h"
 #include "environment.h"
@@ -887,8 +888,9 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
-		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
+	if ((flags & RERERE_READONLY) &&
+	    (flags & (RERERE_NOWAIT | RERERE_SKIP_LOCKED)))
+		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
 	if (flags & RERERE_READONLY) {
 		fd = 0;
 	} else {
@@ -900,18 +902,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 		 * Another process may hold the lock for a while, e.g.
 		 * "git rerere gc" while it prunes rr-cache, so wait for
 		 * it instead of dying right away.  The gc itself never
-		 * waits: skipping one of its runs costs nothing.
+		 * waits: skipping one of its runs costs nothing.  A
+		 * command that stops at a conflict must not die here
+		 * either, so it warns and goes on without rerere.
 		 */
 		if (flags & RERERE_NOWAIT) {
 			lock_flags = 0;
 			timeout_ms = 0;
 		}
+		if (flags & RERERE_SKIP_LOCKED)
+			lock_flags = 0;
 		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
 							    path, lock_flags,
 							    timeout_ms);
 		if (fd < 0) {
 			warning_errno(_("skipping rerere, "
 					"unable to create '%s.lock'"), path);
+			if (flags & RERERE_SKIP_LOCKED)
+				advise(_("run \"git rerere\" before resolving "
+					 "the conflict to record or replay "
+					 "its resolution"));
 			return -1;
 		}
 	}
diff --git a/rerere.h b/rerere.h
index a2712d543e..e91f3f4afa 100644
--- a/rerere.h
+++ b/rerere.h
@@ -12,6 +12,8 @@ struct repository;
 #define RERERE_READONLY     04
 /* Never wait for MERGE_RR.lock, and skip the run when it is held */
 #define RERERE_NOWAIT       010
+/* Warn and go on without rerere if MERGE_RR.lock cannot be taken in time */
+#define RERERE_SKIP_LOCKED  020
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..49776e7c5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2519,7 +2519,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
 		goto leave;
 	}
 
@@ -4448,7 +4448,7 @@ static int do_merge(struct repository *r,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 27082a7676..d0a9363a1c 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -272,17 +272,118 @@ test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
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
 test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
 	test_when_finished "rm -f .git/MERGE_RR.lock" &&
 	>.git/MERGE_RR.lock &&
-- 
gitgitgadget
