Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F14B95B0
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596711; cv=none; b=FsWqE7XpQ4/0EXAH4CRYYw7r0fhUOL2TFyPTngT83eNDGXwsRF5gZx/3z7MBmXrs4lGvrsASvnyXeN8KCb8tiJl+lpsxOxwIitCcQikz1kLdnOBryE3bXjRTpOYbU6L6JLZXLQ855QlFN3CW2hPFCQ02jMY2f4b8LJ+bOfhdCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596711; c=relaxed/simple;
	bh=mmHaEEpbyO8UuOzd91pHDWsUo2O0YdK/UMzuT/XmKGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ed4zQ7p6S4QN906HMXWW/V9ITUmQ8sOr8B0CF3/aI+/ofGxNKAvDm3TcFg4MMITwU5XQUuK1PDH9pa9YGXBeycQWDA+kdaew6lkZdGVJcU0AMPeMmbLZ9RT6doOSR6WE+ZyzBcjhR7MZ+WKehJ4Y8DRjwLUO2oeokDEx+GmD6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmZ0sfO/; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmZ0sfO/"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347327e3aeaso1016876eec.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596708; x=1791201508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kr4UCaKpsfvpEommGx9baP5A5ogtwVdL91d2HWOSHyM=;
        b=PmZ0sfO/UyvbW4HFF2SVQSHl8ttqdMz8aRgh0CDHbteouhmczHYiqGre6uVTnIEwY9
         vbDwG3ySMMuzM90V5g1QooLSQpV9GQkG3JiRRUNv53eiJtotrA1XvM6NOpVFrcn8qH3S
         YVtChin9E6i6/LDW0x9fbSWPdg1v3JGLJbwBKiAR6J67SyeEwuP/x0bA7cMeqqe+HS8D
         MKxUAPxUQyRqoKqGLrpIHPs0UFWnrawTlGifdhyk6ptJFLpWJlUglVHKbacfrPImjA6j
         JkXZndKIV7MarAlT4LE201+RREtdOCgBd2sCGXmNOKuZpnUbO1aMk25UWXkhbck5FY9n
         ERgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596708; x=1791201508;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kr4UCaKpsfvpEommGx9baP5A5ogtwVdL91d2HWOSHyM=;
        b=lvS90xotVC6kq0NdAEZQ0I4eUkiqORoQSXN7FeHneEqGXkYnmZ1VGzJh3n6VQ96GLM
         8YGYkOFWnf7GJt+l/5drik6SYz/3m76Fh+CWbU35PNmx+kxKBJJ+4Po5FdBLb0anw1w5
         09ZqTELYYHVbmMfsd2NUEUGz1xlhIuStcyEhSe+hLGM7GFOQHbdzB17id8ikTfm0oj68
         NYH7d1KlozDCRTTZ+roMpzOYWp4+Yd6CuR2gw/98dNuo/Yu47q3rRSRdZ6fl+QTfMlfR
         H4BPE19ENGaRtbHk2T8RRRHy6fmd68Z++ghfJMfkx0c1yWxyC3SPje8TY4SgFqpoSsBv
         cZ6Q==
X-Gm-Message-State: AFq9FYKlMUGc6kX2UkPhI33fJqJfUDVQatplP2ViVax4lhuSRSS3crtZ
	XNW9ZgzXMR17vQpsDFNeY6JaEjlzc7l6T0FuuKm933j7poqHsxlvSkO3bsX/AQ==
X-Gm-Gg: AYBFou2BtCebyYaL9sXF5yLXejMKI5eTYzKIwJQEZux85B4L1n0+/PSy6hiwWOPwnKB
	Kj2y9BzC6qzgI7/U/T/JLZI6Q240pJJScWYirMkdwc+BqBOn44CyCjir1KWKiyuCDlfibwLpFZh
	X7NzLmQ+o9xEPLOfkixxXC2u11XsbvP6WYNrS86DH0aa4lH4LQalmkj/J8FlI3712/sl1grr2l8
	6+2bHYHz09v7PGWXuigA8i8CqdlBknlHJPhl+8NmlSfmligKABiAuRo2r4smWS6Wh+DcyjFYGw6
	zgajE3NhqBAeTIUd6CMlYYlM3JHGbCjUC7iFwNbmFSToK1ISl8czImjEr4imOyXgUuwy2W1cWJi
	ZkmZ6NKF3HfQ+km5NhMTN6WOgGUUpxPyqPZA4whswBl5xsHhZ0AMji8f8sgS+xLMUP0bIAp4tio
	7UveNpb2/esYgg/iZ0cZjSEXMCYlkPaTcmxYzBgPiUshMfj/fvLx5ZyM/eudoin3Wr0CaeTVYO/
	9oxUGncyRVM
X-Received: by 2002:a05:693c:87c7:20b0:347:86e1:59b3 with SMTP id 5a478bee46e88-34786e17798mr2841868eec.12.1790596708452;
        Mon, 28 Sep 2026 04:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm46201638eec.9.2026.09.28.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:58:27 -0700 (PDT)
Message-Id: <3984c7666bc3ee1e7670f4e092f1d59c0935c2bc.1790596702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 11:58:22 +0000
Subject: [PATCH v5 3/3] rerere: go on at a conflict when the lock stays busy
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
command dies there. A rebase loses more than a recording that way.
The sequencer has not yet written the state that "git rebase
--continue" needs, so the rebase cannot go on, and the "git commit
--amend" it suggests instead folds the conflicted pick into the
previous commit.

So warn and go on. The conflict is still in place, and the warning
tells the user to run "git rerere" before resolving it, which records
the preimage or replays a known resolution as the command would have.
The hint is under advice.mergeConflict like the other hints printed
at a conflict stop.

Callers that run rerere after a resolution, like "git commit" and
"git am --continue", still fail when the wait is up. They move on
right away, and a leftover MERGE_RR entry would make the next rerere
run record whatever the file holds by then. The user's own rerere
commands and the "rerere clear" of --skip and --abort fail as well.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  10 ++-
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/merge.c                  |   2 +-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  30 +++++++--
 rerere.h                         |   2 +
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 105 ++++++++++++++++++++++++++++++-
 9 files changed, 143 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index a58c2ff684..d9ea56f5b2 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -16,6 +16,10 @@ rerere.lockTimeout::
 	lock when another process holds it, typically a background
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
-	second).  When the time is up, the command fails as it does
-	for any other lock it cannot take.  `git rerere gc --auto`
-	does not wait and does nothing while the lock is held.
+	second).  When the time is up, a command that stops at a
+	conflict, such as `git merge` or `git rebase`, prints a
+	warning and goes on without rerere; run `git rerere` before
+	resolving the conflict to record it after all.  Any other
+	command fails, as it does for any other lock it cannot take.
+	`git rerere gc --auto` does not wait and does nothing while
+	the lock is held.
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
index 7a9843413b..3f9fd20569 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -732,7 +732,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		repo_rerere(the_repository, 0);
+		repo_rerere(the_repository, RERERE_SKIP_LOCKED);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/rerere.c b/rerere.c
index 43c8eb04db..5a036fe456 100644
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
+	    (flags & (RERERE_NOWAIT | RERERE_SKIP_LOCKED)))
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
+		if (flags & RERERE_SKIP_LOCKED)
+			lock_flags = 0;
 		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
-							    git_path_merge_rr(r),
-							    lock_flags, timeout_ms);
-		if (fd < 0)
+							    path, lock_flags,
+							    timeout_ms);
+		if (fd < 0) {
+			if (flags & RERERE_SKIP_LOCKED) {
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
index d54c53d0d4..ed8a878f8f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -12,6 +12,8 @@ struct repository;
 #define RERERE_READONLY     04
 /* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
 #define RERERE_NOWAIT       010
+/* Warn and go on without rerere if MERGE_RR.lock cannot be taken in time */
+#define RERERE_SKIP_LOCKED  020
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/sequencer.c b/sequencer.c
index 6dae43e4db..dabba729c7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2520,7 +2520,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
 		goto leave;
 	}
 
@@ -4449,7 +4449,7 @@ static int do_merge(struct repository *r,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(r, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 9435b0ed58..b5209d8c04 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -277,17 +277,118 @@ test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
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
 test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
 	test_when_finished "rm -f .git/MERGE_RR.lock" &&
 	>.git/MERGE_RR.lock &&
-- 
gitgitgadget
