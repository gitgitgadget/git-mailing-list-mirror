Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644179;
	b=Y4lKm2duic292t2DWG369jfPVPT1pgRuY/BeRMS8hQfJatI3ybzosIPRUtA0YcfmsC7F
	 F/Ljibcr64ZCkaInJ3Vdr0K8Mk7aJUC2ddvPevlhDCXwIRbXKab59bvi7DU8erPZQhtb7
	 Z/etF3E21qH8775cc70wDG1Y5T7IVdSovxOePuOGGLizMhxrf/cHMxBm7x0DCwYECwy8v
	 WVbUtrgRLeH+ZW8pVJMgPkv8a9w6LHyAmJuxCMy5sjW+Y824j/uK+a+8VG3IYKOuHCL2+
	 05kKHWokOMmGfWKDJcmhAmQuV3q7wotVm7SAXP9andVBxzfUEf9qTLZl7EOrCKdNYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oBKSsvU/hYDf47pPnPyqwaLSPOz7vZynDeqS2ZH8Olo=;
	b=A8U36FIhF9v2TJfQwUwcKXmPsDQi5KZyxQBJr+JkRsuB6Ue7TwkRUPVIMBZuVIyIlLXD
	 zTrG2uwySCNE4ZZx6rdASg2OX4Rcfb/A7c2e/1628yQW0V/1wrdmwVapPndq/qt6BN5GL
	 bu/ZYk3tpl05EYos7rOmAPhKEhVPVVt2wtWQgp/5v6h3INt6QTejBp31g+0z2AAkVMire
	 Edb/w2aTjaTMVLYSbjWd4dpd5AxMcwhUY6PhXLI5asW0KHnHWsBSb30zZPWmmbW9tK58R
	 PJxjTlu1QK5EEPve92OdSVNtmv99bG7yaabytkqd5FtEZORAFDTy40yIEGSR5VATjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Wdb3yZ6e;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6095606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6095606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Wdb3yZ6e
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5495d549924so4509631cf.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793644178; x=1794248978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBKSsvU/hYDf47pPnPyqwaLSPOz7vZynDeqS2ZH8Olo=;
        b=Wdb3yZ6e59RVqXgrYIqd3DgqCu92iFryOwHNoHmgstdNIBZzg6W6hop8uwzbXQFxIe
         uLcal7OtIMVbLUAtfla4ClE8LS58jx+AKm70CrVThxXASTTZIsgKW5NaDOidWK5VDeuK
         odYyxn6eigCsvZ/s2Y4lcPVIVqW8o53F1UxgvShettF4zSZAXaC63ZhgUyi/x4908d9X
         +Z3dFLvVDFMh/ex9f7ITzfew3MmVLXWqC/1V6DP6adkvmxJpocvWn/EQVPdt9dnJ6ef9
         4h5JoIHZgblOJqvQLa37aRYr9xxSxSYQrOcJ0Yryjx2s240mDRPDSmgOxXXAEzKgKtqb
         iWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644178; x=1794248978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBKSsvU/hYDf47pPnPyqwaLSPOz7vZynDeqS2ZH8Olo=;
        b=U72TK28dOr0ir+6ah2sOE1LXhpPLUH3yp9KS4cuTkNEtJ14teFN2BL1djN7p8dAC02
         iycakWqlGj3TKzmjVdjuAr75prSkSRcpM8ihyGloi3ByLcC5ngkzAcT7qBtLIy1vxY2K
         mBd8JXzCchnINltpGH8/hUHATLgfLUe2SZLaAI6sg5b4JBidffD3Sf7+ylEMuB5Wq7Tk
         UgG/b8je0VbqMTvkbAChLkBjWMAxESyUQ+fUfrbA3El8AiMWDZQTshGw1omH2fJRsaWD
         P7dDHuzPsNECh1reTCsnuolnf4zCkIIGsSQI3CE1JiDGj2Wf5TRENwMaw4ZcLFTJSrFf
         +23Q==
X-Gm-Message-State: APuU4Z8Xrd1V3N51Yn7Lch/SZXbsMdNaStHJgheOwYypVxlXZvej73vb
	9w4jweD5fFNoCwyZgv+oSGUpvSpjsqTH5N1F1pIm7/8VgYzMxqnRqPyV0qyepVg89rCSdIxkfum
	Bd5BWwoypJA3vhmSAn4acnc2zuGdrqAA+CyuZXWRlmRzAV7L1EBkxy3F0H0nlOOHwrP/AUllJ6l
	igg4yG3tIS4encrj42ttGKoLlSrhZdKVK1bIAmJT5kVqemFuUOTgIbKPN8h5T8t2MH1mLdzLOD/
	ALZ0SXzNTed55AlqTqoOuyuaDhUbTlzrUTgKW4KEAQ=
X-Gm-Gg: AYBFou1Oh0qzzOdLX5SKqLigyfJV17JgDAuSHvrRA01EW/niIoYEUqHxjE55wrMPiwZ
	WDaG7iHdUlJRBO/nqj6bROoV9Y2aL83KukS4qlb6nS52t4gOFA/MBDY2o3rXICQfr4RWY5F+w6R
	yDLktp39zdF0kwkojWeL1g4/VJ2FVIg3dOBPydMUtYxQ7Sn21RNb6PvM7uf6/UgB1PyQLWFH48b
	+mLyka53geQ42SpIVZSp/xjxUG1g0C8hViCQYitYqP3ahV8xctjbgsxhrltNiVVygAdNCjtAyKi
	HBo+68w8P8ePsWlWGCsIpeuVDdNv2cYHpHASML9L1EdNKhaWxN0LQ6Zoj4poxYJg3SN8gMpbpWZ
	Pz56OE3LwHj/dHqZjZVepKKipGlO+6fYbZQo7/NIc8UO/2sBNe9dti+H/cYZKwtm0TJtM4j9k8d
	L27/yAc7ydKUWNnrWMyWfq1Espk0u4B2QmdNyWHGEY+XL6wWz2DkGKISVsFAzPqKC7LNiV2X1rx
	DGVGiePW62a95UL13HKnc+3BY64vNs6JvmQZA3VhIYGbcvt/gZJPJI+NKpDfJ2WuXgDX/pjz+ww
	1yW1rIOfuvBT8wbDIlmA9H4s+mQ3aMwlRChu9Qyfeoz9RTrQERLe/A7bqxOsHlW9q80UjBGtURr
	chf+TCwL8+EfVxBBeORdK5ocMt7Pqct5urS5M8lzYka4i2waMEH3aVLv11UOo1QrTq2nCn/HkDt
	7yIQD3Wd30/fY0vbqEvkw9eVKf9PxmlnaTUJ+HYMJlkKd/jHrb2rEnWZDsZ5B04O/jClB8YvucB
	uGFBzdwJ/a3Q/98Hh6tpI6EpGInIzkc7UdBrtoPkqCmhGQ=
X-Received: by 2002:a05:622a:4207:b0:533:4346:57fe with SMTP id d75a77b69052e-542b7b0b9camr174049411cf.58.1793644177314;
        Mon, 02 Nov 2026 10:29:37 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm4346221cf.4.2026.11.02.10.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:29:36 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v4 0/4] worktree: treat a branch being rebased or bisected as checked out
Date: Mon,  2 Nov 2026 13:29:26 -0500
Message-ID: <20261102182930.3511-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030142137.54750-1-me@jaspermayone.com>
References: <20261030142137.54750-1-me@jaspermayone.com>
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

While a worktree is rebasing or bisecting a branch, its HEAD is
detached. "git worktree add" and "git branch -d" already treat the
branch as checked out there, but "git worktree remove" deletes such a
worktree when its files are clean, and %(worktreepath) and "git
branch" do not show which worktree has the branch.

Patch 1 makes "git worktree remove" refuse a worktree in the middle of
an operation unless --force is given. Patch 2 documents how to read
%(worktreepath) safely. Patch 3 makes %(worktreepath) name the
worktree that is rebasing or bisecting a branch, and patch 4 keeps
"git branch" from marking that branch with "+" in that worktree.

Changes since v3 [1]:

 * Patch 1: also refuse a worktree that has CHERRY_PICK_HEAD or
   REVERT_HEAD, for a single cherry-pick or revert whose files are
   clean, with tests. The git-worktree documentation now lists the
   cases that need --force. The tests use a shared setup and
   subshells. Dropped the Helped-by trailer, as Phillip asked.

 * Patch 2 is new. It adds the notes that Phillip suggested to the
   documentation of %(worktreepath): the path can contain a newline,
   and only one worktree is shown for a branch that is checked out in
   more than one.

 * Patch 3: %(worktreepath) now uses a new branch.c function,
   branch_checked_out_worktree(), that reads the list that
   prepare_checked_out_branches() builds, in place of a copy of that
   code in ref-filter.c. ref-filter.c loses its own worktree map. The
   commit message explains why branches that "rebase --update-refs"
   will update are not included, and the change for the HEAD of a
   bare repository, which now has a test.

 * Patch 4 is new. "git branch" no longer marks a branch with "+" in
   the worktree that is rebasing or bisecting it, because the
   "(no branch, ...)" line already names it.

[1] https://lore.kernel.org/git/20261030142137.54750-1-me@jaspermayone.com/

Jasper Mayone (4):
  worktree remove: refuse a worktree in the middle of an operation
  doc: for-each-ref: say how to read %(worktreepath) safely
  ref-filter: name the worktree of a branch being rebased or bisected
  branch: do not mark the branch the current worktree is rebasing

 Documentation/git-branch.adoc       |   6 +-
 Documentation/git-for-each-ref.adoc |  12 +++-
 Documentation/git-worktree.adoc     |  17 +++--
 branch.c                            |  13 ++++
 branch.h                            |   9 +++
 builtin/branch.c                    | 103 +++++++++++++++++++++-------
 builtin/worktree.c                  |  37 +++++++++-
 ref-filter.c                        |  74 +-------------------
 t/t2403-worktree-move.sh            |  94 +++++++++++++++++++++++++
 t/t3203-branch-output.sh            |  49 +++++++++++++
 t/t6302-for-each-ref-filter.sh      |  76 ++++++++++++++++++++
 11 files changed, 386 insertions(+), 104 deletions(-)

Range-diff against v3:
1:  a79b69a0e4 ! 1:  bca692b844 worktree remove: refuse a worktree in the middle of a rebase or bisect
    @@ Metadata
     Author: Jasper Mayone <me@jaspermayone.com>
     
      ## Commit message ##
    -    worktree remove: refuse a worktree in the middle of a rebase or bisect
    +    worktree remove: refuse a worktree in the middle of an operation
     
    -    "git worktree remove" refuses a worktree with modified or untracked
    -    files unless --force is given, but it removes a worktree that is in
    -    the middle of a rebase, a "git am" session, a bisect or a cherry-pick
    -    or revert sequence when its files happen to be clean. The state of
    -    that operation lives in the worktree's own $GIT_DIR, so it is lost
    -    with the worktree. A rebase stopped at an "edit" or "break" line, an
    -    "exec" that failed, or a cherry-pick sequence after a conflict was
    -    resolved and committed is clean in this sense and still has work in
    -    progress.
    +    "git worktree remove" refuses to remove a worktree with modified or
    +    untracked files unless --force is given, but it removes a worktree
    +    that is in the middle of a rebase, a "git am" session, a bisect, a
    +    cherry-pick or a revert when its files happen to be clean. The state
    +    of that operation lives in the worktree's own $GIT_DIR, so it is lost
    +    with the worktree. Examples of such a clean worktree are a rebase
    +    stopped at an "edit" or "break" line or after a failed "exec", a
    +    cherry-pick sequence after a conflict was resolved and committed, and
    +    a single cherry-pick or revert whose conflict was resolved to the
    +    current contents, which leaves CHERRY_PICK_HEAD or REVERT_HEAD behind.
     
         Treat such a worktree as unclean: refuse to remove it unless --force
         is given, and name the operation in the message.
    @@ Commit message
         worktree, which is only done when the directory exists.
     
         Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
    -    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Jasper Mayone <me@jaspermayone.com>
     
      ## Documentation/git-worktree.adoc ##
     @@ Documentation/git-worktree.adoc: the new working tree location.
    + 
      `remove`::
      
    - Remove a worktree. Only clean worktrees (no untracked files and no
    +-Remove a worktree. Only clean worktrees (no untracked files and no
     -modification in tracked files) can be removed. Unclean worktrees or ones
     -with submodules can be removed with `--force`. The main worktree cannot be
     -removed.
    -+modification in tracked files) can be removed. A worktree in the middle
    -+of a rebase, a `git am` session, a bisect or a cherry-pick or revert
    -+sequence is not clean either, because removing it loses that state. Unclean worktrees or ones with submodules
    -+can be removed with `--force`. The main worktree cannot be removed.
    ++Remove a worktree. The main worktree cannot be removed. Without
    ++`--force`, a worktree is not removed when:
    +++
    ++--
    ++* it has untracked files or modifications in tracked files,
    ++* it has submodules, or
    ++* it is in the middle of a rebase, a `git am` session, a bisect, a
    ++  cherry-pick or a revert, because removing it loses the state of that
    ++  operation.
    ++--
      
      `repair [<path>...]`::
      
    @@ Documentation/git-worktree.adoc: twice. If the destination is already assigned t
      allows the move to proceed; use `--force` twice if the destination is locked.
      +
     -`remove` refuses to remove an unclean worktree unless `--force` is used.
    -+`remove` refuses to remove an unclean worktree, or one in the middle of a
    -+rebase, `git am` session, bisect, or cherry-pick or revert sequence,
    -+unless `--force` is used.
    ++`remove` refuses to remove a worktree in the cases listed under
    ++`remove` above unless `--force` is used.
      To remove a locked worktree, specify `--force` twice.
      
      `-b <new-branch>`::
    @@ builtin/worktree.c: static void check_clean_worktree(struct worktree *wt,
      }
      
     +/*
    -+ * A rebase, "git am", bisect or cherry-pick/revert sequence keeps its
    -+ * state in the worktree's own $GIT_DIR, and removing the worktree
    -+ * throws that away even when "git status" says the files are clean.
    ++ * A rebase, "git am", bisect, cherry-pick or revert keeps its state in
    ++ * the worktree's own $GIT_DIR, and removing the worktree throws that
    ++ * away even when "git status" says the files are clean.
     + */
     +static void check_no_operation_in_progress(struct worktree *wt,
     +					   const char *original_path)
    @@ builtin/worktree.c: static void check_clean_worktree(struct worktree *wt,
     +		die(_("'%s' is in the middle of a bisect, use --force to delete it"),
     +		    original_path);
     +	wt_status_state_free_buffers(&state);
    ++	if (refs_ref_exists(get_worktree_ref_store(wt), "CHERRY_PICK_HEAD"))
    ++		die(_("'%s' is in the middle of a cherry-pick, use --force to delete it"),
    ++		    original_path);
    ++	if (refs_ref_exists(get_worktree_ref_store(wt), "REVERT_HEAD"))
    ++		die(_("'%s' is in the middle of a revert, use --force to delete it"),
    ++		    original_path);
     +	if (is_directory(worktree_git_path(wt, "sequencer")))
     +		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
     +		    original_path);
    @@ t/t2403-worktree-move.sh: test_expect_success 'move worktree with relative path
      	test_cmp expect .git/worktrees/absolute/gitdir
      '
      
    ++test_expect_success 'setup commits that conflict for am, cherry-pick and revert' '
    ++	git worktree add --detach conflict-setup init &&
    ++	(
    ++		cd conflict-setup &&
    ++		test_commit base conflict.t base &&
    ++		git switch --detach init &&
    ++		test_commit side conflict.t side &&
    ++		test_commit side-two
    ++	) &&
    ++	git worktree remove conflict-setup
    ++'
    ++
     +test_expect_success 'remove worktree in the middle of a rebase' '
     +	test_when_finished "rm -rf mid-rebase; git worktree prune" &&
    -+	git worktree add --detach mid-rebase init &&
    -+	test_commit -C mid-rebase rebase-me &&
    ++	git worktree add --detach mid-rebase side &&
     +	test_must_fail git -C mid-rebase rebase -f -x false init &&
     +	test_must_fail git worktree remove mid-rebase 2>err &&
     +	test_grep "in the middle of a rebase" err &&
    @@ t/t2403-worktree-move.sh: test_expect_success 'move worktree with relative path
     +
     +test_expect_success 'remove worktree in the middle of an am session' '
     +	test_when_finished "rm -rf mid-am patch; git worktree prune" &&
    -+	git worktree add --detach mid-am init &&
    -+	test_commit -C mid-am am-me &&
    -+	git -C mid-am format-patch -1 --stdout >patch &&
    -+	git -C mid-am reset --hard init &&
    -+	echo conflict >mid-am/am-me.t &&
    -+	git -C mid-am add am-me.t &&
    -+	git -C mid-am commit -m conflict &&
    -+	test_must_fail git -C mid-am am ../patch &&
    -+	git -C mid-am reset --hard &&
    ++	git format-patch -1 --stdout side >patch &&
    ++	git worktree add --detach mid-am base &&
    ++	(
    ++		cd mid-am &&
    ++		test_must_fail git am ../patch &&
    ++		git reset --hard
    ++	) &&
     +	test_must_fail git worktree remove mid-am 2>err &&
     +	test_grep "in the middle of an am session" err &&
     +	git worktree remove --force mid-am
    @@ t/t2403-worktree-move.sh: test_expect_success 'move worktree with relative path
     +
     +test_expect_success 'remove worktree in the middle of a bisect' '
     +	test_when_finished "rm -rf mid-bisect; git worktree prune" &&
    -+	git worktree add --detach mid-bisect init &&
    -+	test_commit -C mid-bisect bisect-one &&
    -+	test_commit -C mid-bisect bisect-two &&
    -+	git -C mid-bisect bisect start HEAD init &&
    ++	git worktree add --detach mid-bisect side-two &&
    ++	git -C mid-bisect bisect start side-two init &&
     +	test_must_fail git worktree remove mid-bisect 2>err &&
     +	test_grep "in the middle of a bisect" err &&
     +	git worktree remove --force mid-bisect
     +'
     +
    -+test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
    ++test_expect_success 'remove worktree in the middle of a cherry-pick' '
     +	test_when_finished "rm -rf mid-pick; git worktree prune" &&
    -+	git worktree add --detach mid-pick init &&
    -+	git -C mid-pick switch -c pick-src &&
    -+	test_commit -C mid-pick pick-one &&
    -+	test_commit -C mid-pick pick-two &&
    -+	git -C mid-pick switch --detach init &&
    -+	echo conflict >mid-pick/pick-one.t &&
    -+	git -C mid-pick add pick-one.t &&
    -+	git -C mid-pick commit -m conflict &&
    -+	test_must_fail git -C mid-pick cherry-pick pick-src~1 pick-src &&
    -+	git -C mid-pick checkout --theirs pick-one.t &&
    -+	git -C mid-pick add pick-one.t &&
    -+	git -C mid-pick commit --no-edit &&
    -+	test_path_is_dir .git/worktrees/mid-pick/sequencer &&
    ++	git worktree add --detach mid-pick base &&
    ++	(
    ++		cd mid-pick &&
    ++		test_must_fail git cherry-pick side &&
    ++		git checkout --ours conflict.t &&
    ++		git add conflict.t &&
    ++		git rev-parse --verify CHERRY_PICK_HEAD
    ++	) &&
    ++	test_path_is_missing .git/worktrees/mid-pick/sequencer &&
     +	test_must_fail git worktree remove mid-pick 2>err &&
    -+	test_grep "in the middle of a cherry-pick or revert" err &&
    ++	test_grep "in the middle of a cherry-pick," err &&
     +	git worktree remove --force mid-pick
     +'
    ++
    ++test_expect_success 'remove worktree in the middle of a revert' '
    ++	test_when_finished "rm -rf mid-revert; git worktree prune" &&
    ++	git worktree add --detach mid-revert base &&
    ++	(
    ++		cd mid-revert &&
    ++		test_must_fail git revert side &&
    ++		git checkout --ours conflict.t &&
    ++		git add conflict.t &&
    ++		git rev-parse --verify REVERT_HEAD
    ++	) &&
    ++	test_path_is_missing .git/worktrees/mid-revert/sequencer &&
    ++	test_must_fail git worktree remove mid-revert 2>err &&
    ++	test_grep "in the middle of a revert" err &&
    ++	git worktree remove --force mid-revert
    ++'
    ++
    ++test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
    ++	test_when_finished "rm -rf mid-pick-seq; git worktree prune" &&
    ++	git worktree add --detach mid-pick-seq base &&
    ++	(
    ++		cd mid-pick-seq &&
    ++		test_must_fail git cherry-pick side side-two &&
    ++		git checkout --theirs conflict.t &&
    ++		git add conflict.t &&
    ++		git commit --no-edit
    ++	) &&
    ++	test_path_is_dir .git/worktrees/mid-pick-seq/sequencer &&
    ++	test_must_fail git worktree remove mid-pick-seq 2>err &&
    ++	test_grep "in the middle of a cherry-pick or revert" err &&
    ++	git worktree remove --force mid-pick-seq
    ++'
     +
      test_done
-:  ---------- > 2:  39eb92d441 doc: for-each-ref: say how to read %(worktreepath) safely
2:  0cd13347e1 ! 3:  990a19fd11 ref-filter: name the worktree of a branch being rebased or bisected
    @@ Commit message
     
         The rest of Git already treats that branch as checked out: "git
         worktree add" and "git branch -d" refuse it, because finishing the
    -    rebase or bisect will check it out again. "git worktree list" shows
    -    such a worktree as "(detached HEAD)", so %(worktreepath) is the only
    -    place a script could find out which worktree is working on the
    -    branch.
    +    rebase or bisect will check it out again. But no command shows which
    +    worktree is working on the branch: "git worktree list" shows such a
    +    worktree as "(detached HEAD)", and %(worktreepath) is empty.
     
    -    Also map the branch that a worktree is rebasing or bisecting to that
    -    worktree, as prepare_checked_out_branches() in branch.c does.
    -    Branches that "rebase --update-refs" will update are not mapped: that
    -    worktree has not checked them out, it only moves them when the rebase
    -    is done.
    +    branch.c already knows the answer, as prepare_checked_out_branches()
    +    records the branch that each worktree has checked out, is rebasing or
    +    is bisecting. Add branch_checked_out_worktree() to look a branch up in
    +    that list, and use it for %(worktreepath) in place of the map that
    +    ref-filter.c builds from the HEAD of each worktree.
     
    -    As a result "git branch" marks such a branch with "+", also when it
    -    runs in the worktree that is rebasing or bisecting it, where it shows
    -    both "* (no branch, rebasing topic)" and "+ topic". Document that.
    +    The new function skips the branches that "rebase --update-refs" will
    +    update. branch_checked_out() includes them, so that they cannot be
    +    checked out or deleted during the rebase, but the worktree that runs
    +    the rebase has not checked them out. %(worktreepath) therefore stays
    +    empty for them, unlike branch_checked_out().
    +
    +    This also changes the result for a bare repository: its HEAD names a
    +    branch, and %(worktreepath) used to give the path of the bare
    +    repository for that branch. "git branch" in a linked worktree marked
    +    the branch with "+", although no worktree has it checked out and "git
    +    worktree add" lets you check it out. prepare_checked_out_branches()
    +    skips bare repositories, so %(worktreepath) is now empty for that
    +    branch and "git branch" no longer marks it.
     
         Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    @@ Documentation/git-branch.adoc: DESCRIPTION
      branches are listed; the current branch will be highlighted in green and
      marked with an asterisk.  Any branches checked out in linked worktrees will
     -be highlighted in cyan and marked with a plus sign. Option `-r` causes the
    +-remote-tracking branches to be listed,
     +be highlighted in cyan and marked with a plus sign. A branch that a
    -+worktree is rebasing or bisecting counts as checked out there, so it is
    -+marked in the same way, also in the worktree that is rebasing or
    -+bisecting it. Option `-r` causes the
    - remote-tracking branches to be listed,
    ++worktree is rebasing or bisecting counts as checked out in that
    ++worktree, so the other worktrees mark it in the same way. Option `-r`
    ++causes the remote-tracking branches to be listed,
      and option `-a` shows both local and remote branches.
      
    + If a `<pattern>`
     
      ## Documentation/git-for-each-ref.adoc ##
     @@ Documentation/git-for-each-ref.adoc: but if used together the last option is selected.
    @@ Documentation/git-for-each-ref.adoc: but if used together the last option is sel
     -	out, if it is checked out in any linked worktree. Empty string
     +	out, if it is checked out in any linked worktree. A branch that
     +	a worktree is rebasing or bisecting counts as checked out there,
    -+	although that worktree's `HEAD` is detached. Empty string
    - 	otherwise.
    - 
    - `ahead-behind:<commit-ish>`::
    ++	although that worktree's `HEAD` is detached. A branch that
    ++	`git rebase --update-refs` will update does not. Empty string
    + 	otherwise. If the ref is checked out in more than one worktree,
    + 	only one of them is shown. The path can contain a newline, so
    + 	use one of the quoting options such as `--shell`, or follow
     
    - ## ref-filter.c ##
    -@@ ref-filter.c: static struct expand_data {
    - 
    - struct ref_to_worktree_entry {
    - 	struct hashmap_entry ent;
    --	struct worktree *wt; /* key is wt->head_ref */
    -+	struct worktree *wt;
    -+	char refname[FLEX_ARRAY]; /* the key */
    - };
    - 
    - static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
    -@@ ref-filter.c: static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
    - 	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
    - 	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
    - 
    --	return strcmp(e->wt->head_ref,
    --		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
    -+	return strcmp(e->refname,
    -+		keydata_aka_refname ? keydata_aka_refname : k->refname);
    + ## branch.c ##
    +@@ branch.c: const char *branch_checked_out(const char *refname)
    + 	return strmap_get(&current_checked_out_branches, refname);
      }
      
    - static struct ref_to_worktree_map {
    ++const char *branch_checked_out_worktree(const char *refname)
    ++{
    ++	const char *path = NULL;
    ++
    ++	prepare_checked_out_branches();
    ++	for (size_t i = 0; i < checked_out_branches_nr; i++) {
    ++		if (checked_out_branches[i].kind != BRANCH_CHECKOUT_KIND_UPDATE_REF &&
    ++		    !strcmp(refname, checked_out_branches[i].refname))
    ++			path = checked_out_branches[i].path;
    ++	}
    ++	return path;
    ++}
    ++
    + const char *branch_bisecting(const char *refname)
    + {
    + 	prepare_checked_out_branches();
    +
    + ## branch.h ##
    +@@ branch.h: void create_branches_recursively(struct repository *r, const char *name,
    +  */
    + const char *branch_checked_out(const char *refname);
    + 
    ++/*
    ++ * If a worktree has the branch 'refname' checked out, or is rebasing or
    ++ * bisecting it, return the path of that worktree, or of the last one if
    ++ * there are more. Otherwise return NULL. Unlike branch_checked_out(),
    ++ * this ignores the branches that "git rebase --update-refs" will
    ++ * update, because no worktree has them checked out.
    ++ */
    ++const char *branch_checked_out_worktree(const char *refname);
    ++
    + /*
    +  * If the branch at 'refname' is currently used for bisecting in a
    +  * worktree, then return the path to that worktree.
    +
    + ## ref-filter.c ##
    +@@
    + #define DISABLE_SIGN_COMPARE_WARNINGS
    + 
    + #include "git-compat-util.h"
    ++#include "branch.h"
    + #include "environment.h"
    + #include "gettext.h"
    + #include "config.h"
    +@@ ref-filter.c: static struct expand_data {
    + 	struct object_info info;
    + } oi, oi_deref;
    + 
    +-struct ref_to_worktree_entry {
    +-	struct hashmap_entry ent;
    +-	struct worktree *wt; /* key is wt->head_ref */
    +-};
    +-
    +-static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
    +-				      const struct hashmap_entry *eptr,
    +-				      const struct hashmap_entry *kptr,
    +-				      const void *keydata_aka_refname)
    +-{
    +-	const struct ref_to_worktree_entry *e, *k;
    +-
    +-	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
    +-	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
    +-
    +-	return strcmp(e->wt->head_ref,
    +-		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
    +-}
    +-
    +-static struct ref_to_worktree_map {
    +-	struct hashmap map;
    +-	struct worktree **worktrees;
    +-} ref_to_worktree_map;
    +-
    + /*
    +  * The enum atom_type is used as the index of valid_atom array.
    +  * In the atom parsing stage, it will be passed to used_atom.atom_type
     @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref,
      	return ret;
      }
      
    -+static void add_worktree_entry(struct hashmap *map, struct worktree *wt,
    -+			       const char *refname)
    -+{
    -+	struct ref_to_worktree_entry *entry;
    -+
    -+	FLEX_ALLOC_STR(entry, refname, refname);
    -+	entry->wt = wt;
    -+	hashmap_entry_init(&entry->ent, strhash(refname));
    -+	hashmap_add(map, &entry->ent);
    -+}
    -+
    -+/*
    -+ * Map each branch to the worktree that has it checked out. A worktree
    -+ * that is rebasing or bisecting a branch has it checked out, too,
    -+ * even though its HEAD may be detached, as for
    -+ * prepare_checked_out_branches() in branch.c.
    -+ */
    - static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
    - {
    +-static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
    +-{
     -	int i;
    -+	struct strbuf ref = STRBUF_INIT;
    - 
    +-
     -	for (i = 0; worktrees[i]; i++) {
     -		if (worktrees[i]->head_ref) {
     -			struct ref_to_worktree_entry *entry;
    @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref,
     -			entry->wt = worktrees[i];
     -			hashmap_entry_init(&entry->ent,
     -					strhash(worktrees[i]->head_ref));
    -+	for (size_t i = 0; worktrees[i]; i++) {
    -+		struct worktree *wt = worktrees[i];
    -+		struct wt_status_state state = { 0 };
    - 
    +-
     -			hashmap_add(map, &entry->ent);
    -+		if (wt->is_bare)
    -+			continue;
    -+
    -+		if (wt->head_ref)
    -+			add_worktree_entry(map, wt, wt->head_ref);
    -+
    -+		if (wt_status_check_rebase(wt, &state) &&
    -+		    (state.rebase_in_progress ||
    -+		     state.rebase_interactive_in_progress) &&
    -+		    state.branch) {
    -+			strbuf_reset(&ref);
    -+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
    -+			add_worktree_entry(map, wt, ref.buf);
    - 		}
    -+		wt_status_state_free_buffers(&state);
    -+
    -+		if (wt_status_check_bisect(wt, &state) &&
    -+		    state.bisecting_from) {
    -+			strbuf_reset(&ref);
    -+			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
    -+			add_worktree_entry(map, wt, ref.buf);
    -+		}
    -+		wt_status_state_free_buffers(&state);
    - 	}
    -+	strbuf_release(&ref);
    +-		}
    +-	}
    +-}
    +-
    +-static void lazy_init_worktree_map(void)
    +-{
    +-	if (ref_to_worktree_map.worktrees)
    +-		return;
    +-
    +-	ref_to_worktree_map.worktrees = get_worktrees(the_repository);
    +-	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
    +-	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
    +-}
    +-
    + static char *get_worktree_path(const struct ref_array_item *ref)
    + {
    +-	struct hashmap_entry entry, *e;
    +-	struct ref_to_worktree_entry *lookup_result;
    ++	const char *path = branch_checked_out_worktree(ref->refname);
    + 
    +-	lazy_init_worktree_map();
    +-
    +-	hashmap_entry_init(&entry, strhash(ref->refname));
    +-	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
    +-
    +-	if (!e)
    +-		return xstrdup("");
    +-
    +-	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
    +-
    +-	return xstrdup(lookup_result->wt->path);
    ++	return xstrdup(path ? path : "");
    + }
    + 
    + /*
    +@@ ref-filter.c: void ref_array_clear(struct ref_array *array)
    + 	FREE_AND_NULL(used_atom);
    + 	used_atom_cnt = 0;
    + 
    +-	if (ref_to_worktree_map.worktrees) {
    +-		hashmap_clear_and_free(&(ref_to_worktree_map.map),
    +-					struct ref_to_worktree_entry, ent);
    +-		free_worktrees(ref_to_worktree_map.worktrees);
    +-		ref_to_worktree_map.worktrees = NULL;
    +-	}
    +-
    + 	FREE_AND_NULL(array->counts);
      }
      
    - static void lazy_init_worktree_map(void)
     
      ## t/t3203-branch-output.sh ##
     @@ t/t3203-branch-output.sh: test_expect_success 'worktree colors correct' '
    @@ t/t3203-branch-output.sh: test_expect_success 'worktree colors correct' '
     +test_expect_success 'branch being rebased in a worktree is marked' '
     +	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
     +	git worktree add -b rebasing rebase_dir branch-two &&
    -+	git -C rebase_dir commit --allow-empty -m rebase-me &&
    -+	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
    -+	test_must_fail git -C rebase_dir symbolic-ref -q HEAD &&
    ++	(
    ++		cd rebase_dir &&
    ++		git commit --allow-empty -m rebase-me &&
    ++		test_must_fail git rebase -f -x false HEAD~1 &&
    ++		test_must_fail git symbolic-ref -q HEAD
    ++	) &&
     +	git branch --list rebasing >actual &&
     +	echo "+ rebasing" >expect &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'branch being rebased is marked in its own worktree' '
    -+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
    -+	git worktree add -b rebasing rebase_dir branch-two &&
    -+	git -C rebase_dir commit --allow-empty -m rebase-me &&
    -+	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
    -+	git -C rebase_dir branch --list rebasing >actual &&
    -+	echo "+ rebasing" >expect &&
    -+	test_cmp expect actual &&
    -+	git -C rebase_dir branch >actual &&
    -+	test_grep "^\* (no branch, rebasing rebasing)" actual
    -+'
    -+
     +test_expect_success 'branch being bisected in a worktree is marked' '
     +	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
     +	git worktree add -b bisecting bisect_dir branch-two &&
    -+	git -C bisect_dir commit --allow-empty -m bisect-one &&
    -+	git -C bisect_dir commit --allow-empty -m bisect-two &&
    -+	git -C bisect_dir bisect start HEAD HEAD~2 &&
    -+	test_must_fail git -C bisect_dir symbolic-ref -q HEAD &&
    ++	(
    ++		cd bisect_dir &&
    ++		git commit --allow-empty -m bisect-one &&
    ++		git commit --allow-empty -m bisect-two &&
    ++		git bisect start HEAD HEAD~2 &&
    ++		test_must_fail git symbolic-ref -q HEAD
    ++	) &&
     +	git branch --list bisecting >actual &&
     +	echo "+ bisecting" >expect &&
     +	test_cmp expect actual
    @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'validate worktree atom' '
     +	git for-each-ref --format="%(worktreepath)" refs/heads/ >actual &&
     +	test_grep ! detached-rebase actual
     +'
    ++
    ++test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
    ++	test_when_finished "rm -rf bare.git bare-wt" &&
    ++	git clone --bare . bare.git &&
    ++	git -C bare.git symbolic-ref HEAD refs/heads/main &&
    ++	git -C bare.git worktree add --detach ../bare-wt main &&
    ++	git -C bare.git for-each-ref --format="%(worktreepath)" refs/heads/main >actual &&
    ++	echo >expect &&
    ++	test_cmp expect actual &&
    ++	git -C bare-wt branch --list main >actual &&
    ++	echo "  main" >expect &&
    ++	test_cmp expect actual
    ++'
     +
      test_expect_success 'start after with empty value' '
      	cat >expect <<-\EOF &&
-:  ---------- > 4:  56e29c448f branch: do not mark the branch the current worktree is rebasing
-- 
2.56.0

