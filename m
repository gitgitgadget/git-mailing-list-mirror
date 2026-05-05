Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E038E5C5
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965752; cv=none; b=Hqn1FAO2cU5oZxTQ4gQ2tfIXHDzu5Ki954BEUlulijP6E9M4FGH2pblUhMizQaGLyCatcGBlaJICNke9/PG9qERnhBIQZP5OVKngT9zISTxEwiodaBJTPOAPWF8nTNaifIuaAl7LmvTAFSfpmmix7AMCDx7icQuoQHVJbTlmNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965752; c=relaxed/simple;
	bh=0HdvqvtbuiNmXBQUYF32yEK5w2RSLZ2MvX8eQP0Nxns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qIxsyJu0CaPLa5lmisbVdt0ardarQ0OLIn43vRSNQKZEq/qaUKdNTCA+LnOy1o2EKkKTm4Nm5jQfAQ5RIQCmUg8srskksMBazRHdWQG+XtvFzaBwjKcYuM528CYBFZDyjomomN0Pglbdn8bvLRWQ3Ohb4WR0dUAVX646c3XngsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPwlrAnW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPwlrAnW"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ee62a19730so535621185a.3
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965749; x=1778570549; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFU879bhYOHrdWjkSd7lkTDOYvZrpn7ku8pwOewekSc=;
        b=iPwlrAnWywmWaBDpgvUDxdqa10pKStA0Jb4Q4Rnm1lgjPdj3qeJgWcp0A942pk6ex3
         CjR/9LQoZjyPwLMmEOT+UxZbqxjLnIwHwaYYpc/HQ9TE8N6KloTVQ9SJyIvKk3Njf9YN
         NuiP7cGaGFxjPQW18xe7s7YkaOELz5gkSzIGg5uGC2ViOGZVMHHkdh4YO6ziHcaTTDSd
         DH/OUyy/tLNV7wU0L0xfYEqH9VM+fqZseORzfiiInEIGnwdkBP88WXRbmqPv1h+/jeoa
         xKMWLqQfmyWN1/0Oqb7X0qPiG8dfOkR22i0gh8a8a5dzFJidV/nEDOPuSNvUjlTVepLf
         Wb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965749; x=1778570549;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFU879bhYOHrdWjkSd7lkTDOYvZrpn7ku8pwOewekSc=;
        b=qqjTlmyyZGsm4JUd+X/GPO3w266bn8+UuJUjDDCxKkROyw8dr5rlyZcTd7xeIckco6
         W3bkoyICABfTflL0dEz9FGCsWtzzn6f/y6jPCs92kzrQVqQeHeY3FgbZ+v+iU0vSD9+8
         wTnWlqoL7JUlifw6p/71mqFHxvFrZbiteRLHnYygyHzh6527w5jfGqio1l2JQESV5LZQ
         qR/+QBlkXQozi3wO1/QxRsOwsUQ3wMntVWDjME8evZlzTkz03FtrvQYdVLDC1vxisUbl
         obZ7uznXbQWzvBLnzeeBBxzgMA6tj0P2zEjJdVs1j5J3ML1R1lhsbHzH1ybUuGhG3hn9
         8+3w==
X-Gm-Message-State: AOJu0Yzaxhy+falcoyOG5maZIVCPBXKSrepRxU4wIfOvM8wDXJlbA5zS
	AG8ZyQSSEAXIcdalO0wJMC9bXTtMz3RnJf9v4wDYhbhmqwnsScrsxHSYN/Y6XA==
X-Gm-Gg: AeBDiev8xyT25mdxMIxVmGPXXe6sPfez6CDxPSLiLlcwiXrtV5ih9Q4Tgd+2smgDreM
	2hG1xUN0A+gN/RoUx09VtmvbqwrjxPDlPuGhMjAvprNYFsjuNx19u2FyQsOa25pXxB0JYOCv0sV
	PRXp0GCbtAZtT+J0q1QeHUDRCv9FUclYdw75OyoxukQr5oNRizrfhplV4YuBwSQ5po7Y7AT9e2x
	ck6/+Y0k8ijkPGR+czgew+zhe0TodUD2IAyiUx9zoxtwOKFPZejc7mV48OTaXBr3AwViYvwsaR5
	vIkVjHf8Njbc6jjE3PMzFyrZJP+qV3zO9jNmQTUH9krfYtx2fZYnpl4JOW4upuKOHD+yFvTRH1+
	KoCLSKZ1y3v2gOevHYRsZllOsSvWQndpnXYYmxjo5mKw/+PKWfuq7aAjWRTRD0oXaPweOenpR83
	nC0+HLT4l+GrYGwyvE9A35PaigPq59slyShaWG
X-Received: by 2002:a05:620a:701b:b0:8e8:ffd2:efb4 with SMTP id af79cd13be357-8fd15bd8f33mr1992547185a.6.1777965749038;
        Tue, 05 May 2026 00:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd06f16sm1291413385a.42.2026.05.05.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:28 -0700 (PDT)
Message-Id: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:21 +0000
Subject: [PATCH v3 0/6] fetch: add fetch.pruneBranches config
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * s/remote-tracking refs/remote-tracking branches/g

Harald Nordgren (6):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  fetch: add --prune-merged
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/fetch-options.adoc |   8 +
 Documentation/git-branch.adoc    |  32 ++++
 builtin/branch.c                 | 247 +++++++++++++++++++++++++++++--
 builtin/fetch.c                  |  20 +++
 t/t3200-branch.sh                | 215 +++++++++++++++++++++++++++
 t/t5510-fetch.sh                 |  31 ++++
 7 files changed, 549 insertions(+), 11 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v3
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v2:

 1:  e9f8d06a2b ! 1:  77e67d4b8b branch: add --forked <remote>
     @@ Commit message
      
          List local branches whose configured upstream falls within any of
          the given <remote> arguments. <remote> may be either a configured
     -    remote name (matching all of its remote-tracking refs) or a single
     -    remote-tracking ref. Multiple <remote> arguments are unioned.
     +    remote name (matching all of its remote-tracking branches) or a
     +    single remote-tracking branch. Multiple <remote> arguments are
     +    unioned.
      
          This is the building block for --prune-merged, which deletes the
          listed branches.
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
      +	List local branches that fork from any of the given _<remote>_
      +	arguments, that is, those whose configured upstream
      +	(`branch.<name>.merge`) is one of those remotes' remote-tracking
     -+	refs.
     ++	branches.
      ++
      +Each _<remote>_ may be either the name of a configured remote
      +(e.g. `origin`, meaning any branch tracking a
     -+`refs/remotes/origin/*` ref) or a specific remote-tracking ref
     ++`refs/remotes/origin/*` ref) or a specific remote-tracking branch
      +(e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
      +
       `-v`::
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +		free(full_ref);
      +
      +		die(_("'%s' is neither a configured remote nor a "
     -+		      "remote-tracking ref"), arg);
     ++		      "remote-tracking branch"), arg);
      +	}
      +}
      +
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked <remote-tracking-ref> lists only matching branches' '
     ++test_expect_success '--forked <remote-tracking-branch> lists only matching branches' '
      +	git -C forked branch --forked origin/one >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +
      +test_expect_success '--forked rejects unknown remote/ref' '
      +	test_must_fail git -C forked branch --forked nope 2>err &&
     -+	test_grep "neither a configured remote nor a remote-tracking ref" err
     ++	test_grep "neither a configured remote nor a remote-tracking branch" err
      +'
      +
      +test_expect_success '--forked requires at least one <remote>' '
 2:  cd4a7e47af = 2:  807c9f981f branch: let delete_branches warn instead of error on bulk refusal
 3:  c0a5f69eb6 ! 3:  49dc853403 branch: add --prune-merged <remote>
     @@ Commit message
      
          Delete the local branches that --forked <remote> would list,
          refusing any whose tip is not reachable from its upstream
     -    remote-tracking ref. With --force, delete unconditionally. The
     -    currently checked-out branch in any worktree is always preserved.
     +    remote-tracking branch. With --force, delete unconditionally.
     +    The currently checked-out branch in any worktree is always
     +    preserved.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
       DESCRIPTION
       -----------
      @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a configured remote
     - `refs/remotes/origin/*` ref) or a specific remote-tracking ref
     + `refs/remotes/origin/*` ref) or a specific remote-tracking branch
       (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
       
      +`--prune-merged`::
      +	Delete the local branches that `--forked` would list for
      +	the same _<remote>_ arguments, but only when the branch's
     -+	push destination remote-tracking ref (the ref `git push`
     ++	push destination remote-tracking branch (the branch `git push`
      +	would update; see `branch_get_push` semantics) no longer
      +	resolves locally. In other words: the branch was pushed
      +	under some name on _<remote>_, and that name has since
      +	been pruned upstream.
      ++
      +By default, the local tip must also be reachable from the
     -+upstream remote-tracking ref (see `--no-merged`); branches with
     ++upstream remote-tracking branch (see `--no-merged`); branches with
      +unpushed commits are refused. With `--force` (or `-f`), delete
      +them regardless. The currently checked-out branch in any worktree
      +is always preserved.
 4:  e979fd238b ! 4:  938bf7c794 fetch: add --prune-merged
     @@ Documentation/fetch-options.adoc: See the PRUNING section below for more details
      +	After a successful fetch, run `git branch --prune-merged
      +	<remote>` for the fetched remote, deleting local branches
      +	that fork from this remote and whose tip is reachable from
     -+	their upstream remote-tracking ref. See linkgit:git-branch[1]
     ++	their upstream remote-tracking branch. See linkgit:git-branch[1]
      +	for the exact selection rules. The currently checked-out
      +	branch is always preserved.
      +
 5:  0bc5ebbe68 ! 5:  b2e7c97298 branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/git-branch.adoc
      @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a configured remote
       	Delete the local branches that `--forked` would list for
       	the same _<remote>_ arguments, but only when the branch's
     - 	push destination remote-tracking ref (the ref `git push`
     + 	push destination remote-tracking branch (the branch `git push`
      -	would update; see `branch_get_push` semantics) no longer
      -	resolves locally. In other words: the branch was pushed
      -	under some name on _<remote>_, and that name has since
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      +	that name has since been pruned upstream.
       +
      -By default, the local tip must also be reachable from the
     --upstream remote-tracking ref (see `--no-merged`); branches with
     +-upstream remote-tracking branch (see `--no-merged`); branches with
      -unpushed commits are refused. With `--force` (or `-f`), delete
      -them regardless. The currently checked-out branch in any worktree
      -is always preserved.
      +The local tip must also be reachable from the upstream
     -+remote-tracking ref; branches with unpushed commits are refused.
     ++remote-tracking branch; branches with unpushed commits are refused.
      +With `--force` (or `-f`), delete them regardless. The currently
      +checked-out branch in any worktree is always preserved, as is
      +any branch with `branch.<name>.pruneMerged` set to `false`.
 6:  66dac97626 ! 6:  6462642cd0 branch: add --all-remotes flag
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +
      +test_expect_success '--forked --all-remotes still validates explicit <remote>' '
      +	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
     -+	test_grep "neither a configured remote nor a remote-tracking ref" err
     ++	test_grep "neither a configured remote nor a remote-tracking branch" err
      +'
      +
      +test_expect_success '--all-remotes alone is rejected' '

-- 
gitgitgadget
