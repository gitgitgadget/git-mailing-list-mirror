Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA95674E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603106; cv=none; b=bVT2lwO+sgTunxsUUlMOHOxdrjyOSnZCH6WAc9SPXGhoIZwagUgbYTxMlkTYSca0rZiV/J+aJYDCRi6GOafIaFyk2D1+hnEyKU8sf1clycPWLmoAAsciDebWjKZHwI/W/ssAb+ZAbumqTgpEBmaVQfHCs/lOxXUcfjbknJoQA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603106; c=relaxed/simple;
	bh=Dys5iG3yYjRVsxv3fWE0Vtk1O51zGHZNwfjyiFJQTYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR16dAHG7Xb56Ytpnm4PFfBqPPNL2d0HXZqE+6oUtObN2DBXvB23YRFB+kxB+KXUWG4qpY018f/I9/W+F+puK+gFAu7LAjX1MxSmu+iosB0rny2/2yVH57EKeEg7HYr9NwibhSh9k0W3xcjf+kaK1460NXSjhaE31qw9svfUgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4t+GiA0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4t+GiA0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20caea61132so7681795ad.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603104; x=1732207904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYuYFgsH0FnLfrqxnn+wieu8gtd+r++cMe2xQ+rt6aI=;
        b=W4t+GiA00MM9wUn7LYJIkF5r8wZgkEU/A5/T6iw/3YgAWx+SHXYM2ouhECQU3pFJ3C
         V8SZ50HxPfTCjW3VHFVyPHfWZnoasuQpkkN00pNchMDNARGtqtg5utzfv+ZeAmpj0HNw
         f7Nry+NPYL5izZ9o9LMKHf1wDCfDM37Z9usMLMC8lZLKjU2UEgT1TAFB2HgGCA5PWFJf
         o+ItwwB7fmzn8xKu73kqhEo0GpEY1TQ2w6vvL4Qsr7/MJDya4fUXmKir2E3VX3iUzHcc
         y7YKISNv3w+scf44nUSziDFSVBckXJ/vdFUVDZG3MeBzkfewk/RZHPYBM7LFPBulE5wQ
         Plmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603104; x=1732207904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYuYFgsH0FnLfrqxnn+wieu8gtd+r++cMe2xQ+rt6aI=;
        b=uEnAy1qIDJ4UzC620WdSr24URmLtVvHuwvWUtUcdcbPguPMSxg3CYo6K2Pks4YN8K8
         M96dEiQomjMD0UlPZ7UeBNMCZD/3mjUmRkgjirKmVG8HWkK4nKDfN4yXfCQqSDgTQ8H/
         c6HTlRsgHsrtHn9/BZjlrrKsymakahGnG4gqPss8a+05gwj604QKOtuvkFe9I3Ovin1u
         u0OZyfy34ludA4L41nKgUs/a2YcfrswGXu1LVBlCQDGVIgmEPpVK9m7awr2G7+gYNJLc
         upNxxtm/MX4UYwpQ373gRvkbOghPkyRMKqWRQd41c9tvh8P+SMA/1bFj3b/GAlwgYNu1
         Th8Q==
X-Gm-Message-State: AOJu0YyVDXU2We79BWUxColjmpUkgjZcnCq1Sy1mMibsZq0DwmIXK/oF
	bTcp7nd6welf0uh6gcNGwybysai64U+t8vTx4MFBTMZ2a1FdkHQX9GYjnw==
X-Google-Smtp-Source: AGHT+IE3TFz3cqJXo974+mSQnfsUbQ6mM7+j9kmRCa2WYULr2RMlSzc5Kw6RuLIa1qgRaIvmcbRgtg==
X-Received: by 2002:a17:902:dacf:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-211c50c7e1fmr38919465ad.56.1731603103431;
        Thu, 14 Nov 2024 08:51:43 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c56ac4sm12982445ad.106.2024.11.14.08.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:51:42 -0800 (PST)
Date: Fri, 15 Nov 2024 00:51:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 0/9] add ref content check for files backend
Message-ID: <ZzYqoai8X_Wdtbmt@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

Hi all:

This new version solves the following problem:

1. when reading the content of the ref file, we do not use
"fsck_report_ref" function. It's not suitable.
2. Add a new test for symlink worktree test in the last patch. After
writing the tets, find a bug. Fix the bug described below.

Because we have introduced the check for worktrees, we should not use
"ref_store->gitdir", instead we need to use "ref_store->repo->gitdir" to
get the main worktree "gitdir". After fixing this, the test is passed.

Thank Patrick to remind me about this. I forgot to add test thus making
mistakes.

Thanks,
Jialuo

shejialuo (9):
  ref: initialize "fsck_ref_report" with zero
  ref: check the full refname instead of basename
  ref: initialize ref name outside of check functions
  ref: support multiple worktrees check for refs
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add basic symref content check for files backend
  ref: check whether the target of the symref is a ref
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  35 +++
 builtin/refs.c                |  10 +-
 fsck.h                        |   6 +
 refs.c                        |   7 +-
 refs.h                        |   3 +-
 refs/debug.c                  |   5 +-
 refs/files-backend.c          | 195 +++++++++++-
 refs/packed-backend.c         |   8 +-
 refs/refs-internal.h          |   5 +-
 refs/reftable-backend.c       |   3 +-
 t/t0602-reffiles-fsck.sh      | 576 ++++++++++++++++++++++++++++++++--
 11 files changed, 791 insertions(+), 62 deletions(-)

Range-diff against v7:
 1:  bfb2a21af4 =  1:  bfb2a21af4 ref: initialize "fsck_ref_report" with zero
 2:  9efc83f7ea =  2:  9efc83f7ea ref: check the full refname instead of basename
 3:  5ea7d18203 =  3:  5ea7d18203 ref: initialize ref name outside of check functions
 4:  cb4669b64d =  4:  cb4669b64d ref: support multiple worktrees check for refs
 5:  4e1add6465 !  5:  c6c128c922 ref: port git-fsck(1) regular refs check for files backend
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +	if (S_ISLNK(iter->st.st_mode))
     +		goto cleanup;
     +
    -+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
    -+		ret = fsck_report_ref(o, &report,
    -+				      FSCK_MSG_BAD_REF_CONTENT,
    -+				      "cannot read ref file '%s': %s",
    -+				      iter->path.buf, strerror(errno));
    ++	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
    ++		/*
    ++		 * Ref file could be removed by another concurrent process. We should
    ++		 * ignore this error and continue to the next ref.
    ++		 */
    ++		if (errno == ENOENT)
    ++			goto cleanup;
    ++
    ++		ret = error_errno(_("cannot read ref file '%s': %s"),
    ++				  iter->path.buf, strerror(errno));
     +		goto cleanup;
     +	}
     +
 6:  945322fab7 =  6:  911fa42717 ref: add more strict checks for regular refs
 7:  3006eb9431 =  7:  7aa6a99206 ref: add basic symref content check for files backend
 8:  c59d003d78 =  8:  dbb0787ad1 ref: check whether the target of the symref is a ref
 9:  bb6d7f3323 !  9:  a6d85b4864 ref: add symlink ref content check for files backend
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
      
     -	if (S_ISLNK(iter->st.st_mode))
     +	if (S_ISLNK(iter->st.st_mode)) {
    -+		const char* relative_referent_path = NULL;
    ++		const char *relative_referent_path = NULL;
     +
     +		ret = fsck_report_ref(o, &report,
     +				      FSCK_MSG_SYMLINK_REF,
     +				      "use deprecated symbolic link for symref");
     +
    -+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
    ++		strbuf_add_absolute_path(&abs_gitdir, ref_store->repo->gitdir);
     +		strbuf_normalize_path(&abs_gitdir);
     +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
     +			strbuf_addch(&abs_gitdir, '/');
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
      		goto cleanup;
     +	}
      
    - 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
    - 		ret = fsck_report_ref(o, &report,
    + 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
    + 		/*
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
      			goto cleanup;
      		}
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'the target of the textual symref
     +	rm $tag_dir_prefix/tag-symbolic-1 &&
     +	test_cmp expect err
     +'
    ++
    ++test_expect_success SYMLINKS 'symlink symref content should be checked (worktree)' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	cd repo &&
    ++	test_commit default &&
    ++	git branch branch-1 &&
    ++	git branch branch-2 &&
    ++	git branch branch-3 &&
    ++	git worktree add ./worktree-1 branch-2 &&
    ++	git worktree add ./worktree-2 branch-3 &&
    ++	main_worktree_refdir_prefix=.git/refs/heads &&
    ++	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
    ++	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
    ++
    ++	(
    ++		cd worktree-1 &&
    ++		git update-ref refs/worktree/branch-4 refs/heads/branch-1
    ++	) &&
    ++	(
    ++		cd worktree-2 &&
    ++		git update-ref refs/worktree/branch-4 refs/heads/branch-1
    ++	) &&
    ++
    ++	ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
    ++	EOF
    ++	rm $worktree1_refdir_prefix/branch-symbolic-good &&
    ++	test_cmp expect err &&
    ++
    ++	ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
    ++	EOF
    ++	rm $worktree2_refdir_prefix/branch-symbolic-good &&
    ++	test_cmp expect err &&
    ++
    ++	ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
    ++	EOF
    ++	rm $main_worktree_refdir_prefix/branch-symbolic-good &&
    ++	test_cmp expect err &&
    ++
    ++	ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
    ++	git refs verify 2>err &&
    ++	cat >expect <<-EOF &&
    ++	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
    ++	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
    ++	EOF
    ++	rm $worktree1_refdir_prefix/branch-symbolic &&
    ++	test_cmp expect err &&
    ++
    ++	for bad_referent_name in ".tag" "branch   "
    ++	do
    ++		ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
    ++		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
    ++		EOF
    ++		rm $worktree1_refdir_prefix/bad-symbolic &&
    ++		test_cmp expect err &&
    ++
    ++		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
    ++		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
    ++		EOF
    ++		rm $worktree1_refdir_prefix/bad-symbolic &&
    ++		test_cmp expect err &&
    ++
    ++		ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
    ++		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
    ++		EOF
    ++		rm $worktree2_refdir_prefix/bad-symbolic &&
    ++		test_cmp expect err &&
    ++
    ++		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
    ++		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
    ++		EOF
    ++		rm $worktree2_refdir_prefix/bad-symbolic &&
    ++		test_cmp expect err || return 1
    ++	done
    ++'
     +
      test_expect_success 'ref content checks should work with worktrees' '
      	test_when_finished "rm -rf repo" &&
-- 
2.47.0

