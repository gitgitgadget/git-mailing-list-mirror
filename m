Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644180;
	b=q7qmxvCmR4T/xQUr7m6KQfwHYFydOrVVfUdR30pE2vu9g16AGSi/UrIo6KgmY1Sm88aO
	 YEj+sFCHnWs5UPJjhg+RwtcL8oDRnX9y9oY//kQIrt94Q7Y1j5LoPBq1Nk6G/IGZqQzDZ
	 m9K6iH5EH1aVpkWh17eSRV4RIZBvKx2KLfBZ6dCFprh+stPhnwswXohnwTCZFZUhgeeNY
	 rYfplIIf607o47V9NNLpHMGH9fXdzWsB/DIxcm3+lSvJoczcU78x3Hgxz+v/8atSelYz3
	 rJ2F23bDgryvsL+hac/LifGOLXiSaOI9njkceiOx3/2Qnh6O1sm5u0j15P/pa4GNtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gxk0fknpCeEGHpFgYQFm+z9l2XJCJ8JueAUixpkNJDs=;
	b=OMM/qSl44s0KGpgc9XF3DrrocJVcX2+vlk3QAaxtX7jzG52rbrvp3gOS4dXib/tJr269
	 Px6V+iWVnIJIuWGc3Ysxm+2qbormTM3yZG0v/AluxbtN78hYQ6cogfq1rR2ZzfpFgguIQ
	 MtNYDxB91PFg9oFTpXtewZNiBAzuNNlp3JLcB3wh72TZZPvn2gZqsik82qA4/Nm/8M8Ky
	 RVAP7NTB71Kyo6pLDADW8rTQfphYQm5CkNt3GSvX7g5T9xNvLN9l/6m2k911jbqezIfZv
	 6HvAi27Ct6aCl9EE3sCTm7YTNTKIkxypKp3pepLmV972Hun9Se24bYteurAl9cIi+TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Ate105VL;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3B606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD3B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Ate105VL
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5430f70c827so37758551cf.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793644178; x=1794248978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxk0fknpCeEGHpFgYQFm+z9l2XJCJ8JueAUixpkNJDs=;
        b=Ate105VLsptSqIqqz+xReqGgiMoI8nMiXjbVut05nRWeUHIkc34ybiNdw/1FVVnzFU
         +duzZZvpfsJfK5HlZHfSB/GfUxtemckBU4kLFuNCEXwoTAEVIdi0OkbUREcVA/SDc2/1
         JVeGND2mmZ3wQu04nlYJag/kjCuWTn3mmRsrZYjpR/nwbZs2u0uzowICX078fR+Rpofp
         3SANPLug1hPMFre5vGyqPRVh9vYZ6/Y4qtZM1YR8lDaFh9+NVFZd/7MJYWsxOhyQtK7D
         3dhAh7WZCD80IPcRXZSZPDGU16oyuh+8l08acO4lhWq51nCc1pyL4T0NQCD+yQxcE+Nv
         mesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644178; x=1794248978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxk0fknpCeEGHpFgYQFm+z9l2XJCJ8JueAUixpkNJDs=;
        b=eSJLGaFg+q0IP4LLTN/j+bXpE4mxolkAK4pxjMR5MRFkh/CgJ+8UPIiB6dvaz7iYGS
         tss++M7I0KHPhRgVAHxyIlG2T3FE7MtwU9lDZOCZNlRkUWVH9sdtGs64WN7eiVTL6QkC
         kya68kBXGMMx0BEFJMNPFU5BxRVe3/dE5ZkT92NGmpfS06MuSRroUzofnfKaObLCSilj
         Beb1zmD3J3VJp+SHu4BPqFdHWlNfRZZdlgglsmJv2FMYz2yt2/yIiDSsHXg5ZoYLS+0X
         23HojCg9b9Xst4CpMKB9J5sgWUYSErANJ4m05m2U6Yw0wxCdjxuvAUOBCKwvbV40eP6B
         OdZw==
X-Gm-Message-State: AFq9FYIC8i7j7QL0sNU3z7w5Dg4Klna/AX3Re+td/fD/0A5n+WOmdg3X
	A1tQvgbTdP6PADkzapMnQmNccOKd1dtoRqdBWYsWwjCUY7uImEt/PI31SCCftQTu+ma28LrzAuG
	h/Lt993eBrY+py8Iwc2lXIwznEIEPtGZvlXwVVHEAo/Vek0cCykExTbFEqZXF0vaB9thuvdusD8
	N4/TncQCyHbIaHd5FmA5aK3kHcb6bGrY02xV4JTzDpmbZ2fVv5z5Re4/5Nf76kJ5A9iGKQcdhDb
	Ii9ciFGtn0v7ksuFsvV47yf77x9AZyad7R/Yc8q7W8=
X-Gm-Gg: AYBFou0UyUavhgba5bXe3gPgfol6u6TZMlNM4OKbGXSfhqGyOd1nodQG2F+zuMY/bvh
	gSR4j+nAxRRfl/TmFJcW6xEIVv/yVarEnmDNNFD4RnETkZ48+h+FARCASa8pH74oxxt37Qc4pOx
	+wyBP8Wd6CmZZxiv6kh2QRNMS6hn0H+Xd+YClCSHWcR9BrcWyyw87m4q5LX6JZkplDADAP2ME8p
	7GzktPfLvzzHVTsBiYzufep/RANBDWo+2lFPmTaBf0zcnYglGqeNA1Sz8ypiwo9LjFBNTJujC2R
	6iT1ZXDlTAYPjLyhbbvxAjWarxqeijnTAW8/TFQQK7RiOfl9qhb/3v++A3g/VL/S24VDPAtPuTK
	d+Qtzt2tuzhMkSOXCRB/6lBtLyNuQYGkG5vzv5Ac/vDnsh368iEgD5NUsdzf5sukr32WXxB05Nw
	5cHebZTEYXWS4BCM9JtvYyPPmJO9ocZ2Z7YrLVgxoU9Z1SLqIsFWzOTe4FgnUdvInd29en2/HDU
	sfXQqW7daLEIXyDDzFvlZYp5FgVMUNDlfTz7tCn3VogE2yRPBzhZOEO0f/ngiclW3VLtiTCLELu
	MCGoJ54JbKLdFAsiNXylGWHcFL+4OWXqWXRpVdNTmZAseWW5SBJhlibNscS2qmc2zMWJJxnDxpG
	j3K0LKiICq5qfB9QDYakdHPnUzEocDucwTzYB2QuDllWVAE1LaUkhx6jPnMqQFsmit8sn1ojvLZ
	aG7T7AbKZIbxhpyEALfmTSTySrrX9FsY9vCgzwKGsCAkwhlHTKl9h8OBMtqDwmC5gkO4BGna14N
	aBNXNL0O3CGlqroWkou+/sVUDY+WmuSP2u3ZmW1PpZV2u8=
X-Received: by 2002:a05:622a:c05:b0:535:a5fb:645c with SMTP id d75a77b69052e-542b83f96demr183123561cf.71.1793644178340;
        Mon, 02 Nov 2026 10:29:38 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm4346221cf.4.2026.11.02.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:29:37 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v4 1/4] worktree remove: refuse a worktree in the middle of an operation
Date: Mon,  2 Nov 2026 13:29:27 -0500
Message-ID: <20261102182930.3511-2-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102182930.3511-1-me@jaspermayone.com>
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
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
index e6e77252ab..4a7dc47dd8 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -141,10 +141,16 @@ the new working tree location.
 
 `remove`::
 
-Remove a worktree. Only clean worktrees (no untracked files and no
-modification in tracked files) can be removed. Unclean worktrees or ones
-with submodules can be removed with `--force`. The main worktree cannot be
-removed.
+Remove a worktree. The main worktree cannot be removed. Without
+`--force`, a worktree is not removed when:
++
+--
+* it has untracked files or modifications in tracked files,
+* it has submodules, or
+* it is in the middle of a rebase, a `git am` session, a bisect, a
+  cherry-pick or a revert, because removing it loses the state of that
+  operation.
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

