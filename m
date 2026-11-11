Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410900;
	b=SruMFRntewtqh8Fzcm1NIe9Ql5fHUA5MBQudlTGrCXfqXYnlcmNaJxDYgNixaaHdi8Pm
	 OHEzlI1wuF5nBgibrmKt7ZuB5TiAk4392wmWmJNXe5d9lOA0n8zCLF09Es/4X6Pjo8u+C
	 lD2dakMCzMZnO12unaTW5bLd4hjy7SM8VLkrqKd2yxdgB9GKyzzj3w1Rbb+IvZEhgKfCG
	 aK3pR92Dtnzq5eNp0A1cy/A8yv/SS4POpnqtn6qqtcq/dCwx9O6ohMS5tIK/kzj8Aqtfu
	 bIznaEWSUzhPckIzBAAojWKPItZ7o8k2nTQHPAw825H1teiuKBhdHuFgrYgA78uGJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FegJtsTF6dW/SyQWu/h5QwELJMS2J7NCEogBiQcPqdc=;
	b=FwTh+/eBl2KO5vnpGnkaI6R+vQF2k8hsbEPjZMheBJb6u341uSH6SEH4KIo0Mpgbgtq/
	 ed5UNPgCvOGs/J33WBzkw9CIdEf0PwcBg/EfLbTJe8k7RBbu0X64jzgeVm9QloMSHgWdv
	 bLOmh/yVVNo1vu6uXSqFmWgedQU8Sz6KKdqUDjuYkW8chok0Drba2EnBSYxc06XFDQYon
	 A/VSnSnq+kyTTHk0m8j57uvP8MfITOee7OSbltAPHjSii0fxe7TZeBkhHB8AmWG5c1zgz
	 GUdDzMkO3i/+XT5UA/O8oK9erQWjLoGhwzEMeQ9uu01Z5kJYckgfuQNG6xy6oHq2/1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=dRliyK0s;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F2606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=dRliyK0s
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eb53957cbso42777486d6.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410898; x=1795015698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FegJtsTF6dW/SyQWu/h5QwELJMS2J7NCEogBiQcPqdc=;
        b=dRliyK0suh7MaeFeWlbS+y/nnGC6lKKlTjGPYzI8c/2Gn4usyXTELxMDouOCzR1hmI
         dyq+9q69adEBYW1WEFid2nRuX3kPu1/ie1zm9ab7l5TCtEYxYMbm5mu1BGmW37VYY0lJ
         WtQKQT1dFVrlL/ZHyZHfypCn2jFUDYgJvmsERAu505Sg4wRsWiEgXJlEN6yu0yie7H2h
         AtrLOac21wsy2Y1ZuLr37vVbsi+38+9+ZHN+DT5MI2y75IWNQ/kY/mEk99kHRPmJIir1
         e7ejj2EjQEJpX9cyauzeEHrRKyafDehRZzzpvqk7bkpxmIfb6BDORS5BL7TDTPpH24YW
         sBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410898; x=1795015698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FegJtsTF6dW/SyQWu/h5QwELJMS2J7NCEogBiQcPqdc=;
        b=ay0XRl/bxtb0tF/C6N48wbp9c/+VJM2mSNDmXqBNCqcDqnJlwuS3wbtEl7fJuFqqu0
         RUhJ+AHZ/gIVlIA03THwHIFcIKqDDrCiRhvJPaG/DCyctw8VXWElbagy2Vd9RVm2VWFo
         l7uC7o6Og1mN68RUilJiULeEsuIg9AkXFtZx0VkKJBmqx10zVPg1zOY6q0QGtC3FatUu
         gcDrwT3SjOAUEzqdhK704bFJLsaawGrprM6cn4N620Y+Q1Ev+eCVxe7XGx/iVNYV2nrH
         Uen21BVlj+j+2GybyuGYN3/xaV0JYM7OYwP2ytBP7HZntUoA4INDe0EtVZwaM99xTm1L
         Nvgw==
X-Gm-Message-State: APuU4Z/zHikNNScepO4t1/etSGYlE2M39UAvpmYId09wH+D1RFft7F/b
	fsjisqvQqnhXgwiu5QPNdYxrW3FhI33srdNW+XVNHjFN5sp5R6Lv6VJEkv1aBOPtZ7GCqvUAxlY
	IGNpMcSwnIDxlMVenRlh6/Pi8fO2xkrvqM2Cd9bb8U6RehZC5z4nIioA6YuEJajh3xmZlBgT17B
	itzd9tcFZNvBlCjvFG73aD84gLYalobweLFHTEUm2e6+Fd7Lxi2amTZESu543t/ByXyTEFKCVdG
	GDyYQd8FaGL/7tePsGKykh2cfAy2uxwjrTOASj+8YY=
X-Gm-Gg: AYBFou0wmCGaw1wb/bcG4N5ykXrEEclq7XNUbh12vrY59hfRhlHHhY925zNCYqjCmew
	ND9HZZM1As4Mj1/KrThloqmMyj2Qre8erpJqhxAhBN1EZFNKfO22PZ3Mqq7ol0ynF62yC/sFI33
	P3TSWYgg2VTOBjPl4cm6eiUhv9m7DG+ZalKQgrMVwXNIiFz33gPZuskykGjuo8aEiR5TIg76RCD
	/cgvcO2hr7fWjsLNFgOh0p2H+trG/o7Ln9LFuiEnsHLrCMGKuVFnp6vADpfPM4Ga3VEFFSRxM86
	5jxby8qvZG9ne0JU+iU9BBlBWPSeZMs85/qYkf0Rp6e3VxuHXd3NCxtzH0EePtI2+TOBy7m5DAJ
	FNm5xsI/4eVZEmL/lw6Fz+O3/Mo10vv0lgLTJ5vbjb8eqF48//U/1jMxDW3Z6b1158nNhKVFYPR
	BziBpRbJYcT08HOyDC/ZYWCq6HTWB1IXhr3QN7qFs4AIvWdnbf4Bsdq4qliHq5N44z2XWkD8WMN
	IW56bDhGc0oTKPzwqrnezkGX+vQ3laXW9jb3/Xa15AXZAs3EBXyVkHWUvq3RoZS469ED21Mt1aV
	XRIN0LwtHx3nCxKvFoXNn/Pn3H4GOCr32vFreepgro7OUowNIabtf3M+euaTnBfb9gHiY53JKzN
	XUzpyBqD88Vj8lwON/+pKvlwGiL9L5F9YmGtuT2vp0O2xxfpFI6SbAMr5Q3t6dG7ehZIH3IdPjO
	Y1+GBeuzTsm7CmFiUMa9HxACTtzOxxJ4/Rh8P1J5974C6xRgxVFsInpJ5bW1mG5zgCifKeHZiwP
	RJLIkHdTTcSSkKHcjESXOSgZk3mr2Hy0uP34r7zAK5QX+Y8NQm0Jg==
X-Received: by 2002:a05:6214:318e:b0:91e:a762:94e4 with SMTP id 6a1803df08f44-91f0404ae5fmr45006056d6.16.1794410898512;
        Wed, 11 Nov 2026 07:28:18 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:17 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 1/5] worktree remove: refuse a worktree in the middle of an operation
Date: Wed, 11 Nov 2026 10:28:06 -0500
Message-ID: <20261111152811.99986-2-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git worktree remove" refuses to remove a worktree with modified or
untracked files unless --force is given, but it removes a worktree
that is in the middle of a rebase, a "git am" session, a bisect, a
cherry-pick or a revert when its files happen to be clean. The state
of that operation lives in the worktree's own $GIT_DIR, so it is lost
with the worktree. Examples of such a clean worktree are a rebase
stopped at an "edit" or "break" line or after a failed "exec", a
cherry-pick sequence after a conflict was resolved and committed, and
a single cherry-pick or revert whose conflict was resolved to the
current contents, which leaves CHERRY_PICK_HEAD or REVERT_HEAD behind.

Treat such a worktree as unclean: refuse to remove it unless --force
is given, and name the operation in the message.

A worktree whose directory is already gone is still removed without
--force, as before: the check is part of the check for a clean
worktree, which is only done when the directory exists.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-worktree.adoc | 17 ++++--
 builtin/worktree.c              | 37 ++++++++++++-
 t/t2403-worktree-move.sh        | 94 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index e6e77252ab..cde17c9ab5 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -141,10 +141,16 @@ the new working tree location.
 
 `remove`::
 
-Remove a worktree. Only clean worktrees (no untracked files and no
-modification in tracked files) can be removed. Unclean worktrees or ones
-with submodules can be removed with `--force`. The main worktree cannot be
-removed.
+Remove a worktree. The main worktree cannot be removed. Without
+`--force`, a worktree is not removed in these cases:
++
+--
+* The worktree has untracked files or modifications in tracked files.
+* The worktree has submodules.
+* The worktree is in the middle of a `git rebase`, `git am`,
+  `git bisect`, `git cherry-pick` or `git revert`. Removing the
+  worktree would lose the state of that operation.
+--
 
 `repair [<path>...]`::
 
@@ -189,7 +195,8 @@ twice. If the destination is already assigned to some other worktree but is
 missing (for instance, if _<new-path>_ was deleted manually), then `--force`
 allows the move to proceed; use `--force` twice if the destination is locked.
 +
-`remove` refuses to remove an unclean worktree unless `--force` is used.
+`remove` refuses to remove a worktree in the cases listed under
+`remove` above unless `--force` is used.
 To remove a locked worktree, specify `--force` twice.
 
 `-b <new-branch>`::
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..7f53215cda 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -26,6 +26,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "wt-status.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
@@ -1408,6 +1409,38 @@ static void check_clean_worktree(struct worktree *wt,
 			  original_path, ret);
 }
 
+/*
+ * A rebase, "git am", bisect, cherry-pick or revert keeps its state in
+ * the worktree's own $GIT_DIR, and removing the worktree throws that
+ * away even when "git status" says the files are clean.
+ */
+static void check_no_operation_in_progress(struct worktree *wt,
+					   const char *original_path)
+{
+	struct wt_status_state state = { 0 };
+
+	if (wt_status_check_rebase(wt, &state)) {
+		if (state.am_in_progress)
+			die(_("'%s' is in the middle of an am session, use --force to delete it"),
+			    original_path);
+		die(_("'%s' is in the middle of a rebase, use --force to delete it"),
+		    original_path);
+	}
+	if (wt_status_check_bisect(wt, &state))
+		die(_("'%s' is in the middle of a bisect, use --force to delete it"),
+		    original_path);
+	wt_status_state_free_buffers(&state);
+	if (refs_ref_exists(get_worktree_ref_store(wt), "CHERRY_PICK_HEAD"))
+		die(_("'%s' is in the middle of a cherry-pick, use --force to delete it"),
+		    original_path);
+	if (refs_ref_exists(get_worktree_ref_store(wt), "REVERT_HEAD"))
+		die(_("'%s' is in the middle of a revert, use --force to delete it"),
+		    original_path);
+	if (is_directory(worktree_git_path(wt, "sequencer")))
+		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
+		    original_path);
+}
+
 static int delete_git_work_tree(struct worktree *wt)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -1461,8 +1494,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 	strbuf_release(&errmsg);
 
 	if (file_exists(wt->path)) {
-		if (!force)
+		if (!force) {
+			check_no_operation_in_progress(wt, av[0]);
 			check_clean_worktree(wt, av[0]);
+		}
 
 		ret |= delete_git_work_tree(wt);
 	}
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 69768c1207..2e45cd77f9 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -271,4 +271,98 @@ test_expect_success 'move worktree with relative path to absolute path' '
 	test_cmp expect .git/worktrees/absolute/gitdir
 '
 
+test_expect_success 'setup commits that conflict for am, cherry-pick and revert' '
+	git worktree add --detach conflict-setup init &&
+	(
+		cd conflict-setup &&
+		test_commit base conflict.t base &&
+		git switch --detach init &&
+		test_commit side conflict.t side &&
+		test_commit side-two
+	) &&
+	git worktree remove conflict-setup
+'
+
+test_expect_success 'remove worktree in the middle of a rebase' '
+	test_when_finished "rm -rf mid-rebase; git worktree prune" &&
+	git worktree add --detach mid-rebase side &&
+	test_must_fail git -C mid-rebase rebase -f -x false init &&
+	test_must_fail git worktree remove mid-rebase 2>err &&
+	test_grep "in the middle of a rebase" err &&
+	test_path_is_dir mid-rebase &&
+	git worktree remove --force mid-rebase &&
+	test_path_is_missing mid-rebase
+'
+
+test_expect_success 'remove worktree in the middle of an am session' '
+	test_when_finished "rm -rf mid-am patch; git worktree prune" &&
+	git format-patch -1 --stdout side >patch &&
+	git worktree add --detach mid-am base &&
+	(
+		cd mid-am &&
+		test_must_fail git am ../patch &&
+		git reset --hard
+	) &&
+	test_must_fail git worktree remove mid-am 2>err &&
+	test_grep "in the middle of an am session" err &&
+	git worktree remove --force mid-am
+'
+
+test_expect_success 'remove worktree in the middle of a bisect' '
+	test_when_finished "rm -rf mid-bisect; git worktree prune" &&
+	git worktree add --detach mid-bisect side-two &&
+	git -C mid-bisect bisect start side-two init &&
+	test_must_fail git worktree remove mid-bisect 2>err &&
+	test_grep "in the middle of a bisect" err &&
+	git worktree remove --force mid-bisect
+'
+
+test_expect_success 'remove worktree in the middle of a cherry-pick' '
+	test_when_finished "rm -rf mid-pick; git worktree prune" &&
+	git worktree add --detach mid-pick base &&
+	(
+		cd mid-pick &&
+		test_must_fail git cherry-pick side &&
+		git checkout --ours conflict.t &&
+		git add conflict.t &&
+		git rev-parse --verify CHERRY_PICK_HEAD
+	) &&
+	test_path_is_missing .git/worktrees/mid-pick/sequencer &&
+	test_must_fail git worktree remove mid-pick 2>err &&
+	test_grep "in the middle of a cherry-pick," err &&
+	git worktree remove --force mid-pick
+'
+
+test_expect_success 'remove worktree in the middle of a revert' '
+	test_when_finished "rm -rf mid-revert; git worktree prune" &&
+	git worktree add --detach mid-revert base &&
+	(
+		cd mid-revert &&
+		test_must_fail git revert side &&
+		git checkout --ours conflict.t &&
+		git add conflict.t &&
+		git rev-parse --verify REVERT_HEAD
+	) &&
+	test_path_is_missing .git/worktrees/mid-revert/sequencer &&
+	test_must_fail git worktree remove mid-revert 2>err &&
+	test_grep "in the middle of a revert" err &&
+	git worktree remove --force mid-revert
+'
+
+test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
+	test_when_finished "rm -rf mid-pick-seq; git worktree prune" &&
+	git worktree add --detach mid-pick-seq base &&
+	(
+		cd mid-pick-seq &&
+		test_must_fail git cherry-pick side side-two &&
+		git checkout --theirs conflict.t &&
+		git add conflict.t &&
+		git commit --no-edit
+	) &&
+	test_path_is_dir .git/worktrees/mid-pick-seq/sequencer &&
+	test_must_fail git worktree remove mid-pick-seq 2>err &&
+	test_grep "in the middle of a cherry-pick or revert" err &&
+	git worktree remove --force mid-pick-seq
+'
+
 test_done
-- 
2.56.0

