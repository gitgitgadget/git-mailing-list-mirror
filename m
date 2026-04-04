Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96062D73B8
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332201; cv=none; b=BH2ZXlOOqVM9Pa/4idO0uOvG7OwSQWmrgWVlJin0BbBVXf955ZbNUh9gxAEEA1d1E2uFJH/EpnVmusFWTxWGp73uOvHj0lyDaMjmLsWrMfiTfpPsVN0r2+U857Z0zx6QnZp53ZIZ69wZdE356Bbe5s6cjKMtFoxuZ6PIi4okfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332201; c=relaxed/simple;
	bh=MkEhnty9KyVknF+ACIpBelFMOjcbyyqaX4N4UK4JhZM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fPco+jrd9r+q5GQNEnSMqR735seQ/d5D7RjJsmCQqghctWXKoBG8gadK9zAVM1JonmJbqgWyCbmLsfSRenZ/8RPQL9Fm6ssSYqyNBHtG0B6Q336JpIr1l6UDFfmlvCo+x4EnmRx//qkrBNTaBVtZR8V5BBOUPjKbm0ctsG2gi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsOwMfRJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsOwMfRJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso37586846d6.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332198; x=1775936998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xi47qzOC8uzg6u8aJsk1WFn9cjb83LIoA/NOqlPX58g=;
        b=XsOwMfRJ0VHCssAUBy5aS8ecUm8nX6usYSl9guzQO6N+LD+EOAnMdmL06x9qAWBrl6
         pIX6nNPAMZloqD98sOiNs/CSTEQ6hhey7gHldYwFM3kx+4qz+2jWG5xKSA/apG4QFA40
         i3AcfZ7HvDMoyZwUm19aEHlYqk6kOKeVmBjkatX5fYmG2HsXkWIE0eIDM5LM7UkOpw0t
         P1lrAbk3lgA3YvM2xU6Od2DaxkQbNB/6ALEFVQAXShXcPFEzvWZ8MdohpYplccmGh1uk
         F4DCZ0xuV0XLFpzV8RGZXFUqNmXOsqpIuXT/ifs0Nsw0rOzcdA2XMwSdMuNLs8i4n9B4
         RrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332198; x=1775936998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xi47qzOC8uzg6u8aJsk1WFn9cjb83LIoA/NOqlPX58g=;
        b=bempbU6UHAlMWoZbCz8bSajhDvJpIsuodyq5v0AXmVPVnOuZMlkoEj0xTEkxCx+P2Q
         /dHqO4TmMNrIyyYwt+un+omfqkGNNECshpbptzxI5idlFZewt7DNYsIJ92weSjdY77Lr
         cESB2+CAQeqUwSvTp/hP1/J1KpNIZC0EX/QcvFyssYocpp5numssLD/SJ7C6iy9wREtH
         GmTffI1NuXMQG0xaqLaQqrH6NEyg0SY5ghMKwzd7XNvimBV8nrjqM5/vX2E4nf4oVoHV
         /MYP7mF2RNqg7aIOGk0sFGZSv0BFQtrLzn6fulXh7Aoy7Tn1gwkZNWl1M1cAzeYwHS+5
         0+wg==
X-Gm-Message-State: AOJu0Yx3UcGRAFlnqvU+iLUH/0OJLLXH6XyiOlexhWoJXsaQgguUX4rs
	h2rVOCxre1ybdADI3mQuis41eWhb3E3r+zjnXFbnt6k2KRh6F2CeOhnommopBQ==
X-Gm-Gg: AeBDieu0pqSumkVYigqS7TeqGKj0ZVIwRAZA46CmBAWDV87ezi0Q2SKr7Gjejrs2HBc
	YJPxIXK5bAm+EIf/uw1BOdC0oKSsVEfh+hhYxXDtM3Fnnu1f0GT+LNQ157Ya+QDZ8kWMDvddxm1
	BVAU2IBlrofFgmI5XmEeYSC/4+TKaFowTK45vWAANNs18pg46jX+vQC4ENun4hl/kztLJlOUo1S
	R6fEffk+/wRg16m8MCR5i/kyK4z7rHj+g6IJrzclzWNW1SJFkkzoOIcOzGkZpiZ7qFgNbNKpvpl
	OG2IElarlPiVH8NmfxZo9iLS1SLL2HD77BzoJzHOlIV18CK3qZf6+DH++hfx2JKl/f9+9d/ih3p
	VyiMir0C/yAL6j2iGerfMImmvqyIwTh5YE0TnPeVvbr2Ip2UxP3Vvx0em+0gNtBICuas8pUVuvN
	bVzCKklMt1RCznrdSrQqnNdRuJymI=
X-Received: by 2002:a05:6214:5d8e:b0:8a4:71fa:1f4a with SMTP id 6a1803df08f44-8a6ff3b4e2bmr136438236d6.0.1775332198121;
        Sat, 04 Apr 2026 12:49:58 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a59323a0dasm80578406d6.4.2026.04.04.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:49:57 -0700 (PDT)
Message-Id: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:40 +0000
Subject: [PATCH v2 00/17] tests: access bare repositories explicitly
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The safe.bareRepository configuration variable (introduced in 8d1a7448206e)
allows restricting implicit bare repository discovery. Its default may well
change to "explicit" in Git v3.0, at which point any test that relies on
implicit discovery of a bare repository would break, even if the test
subject has nothing to do with bare repositories.

This series adjusts 16 test scripts and git-p4 so that they access bare
repositories explicitly. The techniques used are:

 * Replace git -C <bare-repo> ... with git --git-dir=<bare-repo> ...
 * Export GIT_DIR=. after cd-ing into a bare repository
 * Wrap commands in (GIT_DIR=<path> && export GIT_DIR && ...)
 * Add test_config_global safe.bareRepository all in the few tests where
   implicit discovery is genuinely part of what is being tested

Each commit is a self-contained fix to one test file (or a small related
group).

This patch series is part of https://github.com/gitgitgadget/git/pull/2072.

Changes since v1:

 * Dramatically simplified the patch "t5509: specify bare repository path
   explicitly"

Johannes Schindelin (17):
  t0001: allow implicit bare repo discovery for aliased-command test
  t0001: replace `cd`+`git` with `git --git-dir` in `check_config`
  t0003: use `--git-dir` for bare repo attribute tests
  t0056: allow implicit bare repo discovery for `-C` work-tree tests
  t1020: use `--git-dir` instead of subshell for bare repo
  t1900: avoid using `-C <dir>` for a bare repository
  t2400: explicitly specify bare repo for `git worktree add`
  t2406: use `--git-dir=.` for bare repository worktree repair
  t5503: avoid discovering a bare repository
  t5505: export `GIT_DIR` after `git init --bare`
  t5509: specify bare repository path explicitly
  t5540/t5541: avoid accessing a bare repository via `-C <dir>`
  t5619: wrap `test_commit_bulk` in `GIT_DIR` subshell for bare repo
  t6020: use `-C` for worktree, `--git-dir` for bare repository
  t9210: pass `safe.bareRepository=all` to `scalar register`
  t9700: stop relying on implicit bare repo discovery
  git p4 clone --bare: need to be explicit about the gitdir

 git-p4.py                                  |  1 +
 t/lib-httpd.sh                             | 12 ++--
 t/t0001-init.sh                            |  5 +-
 t/t0003-attributes.sh                      | 66 +++++++++-------------
 t/t0056-git-C.sh                           |  2 +
 t/t1020-subdirectory.sh                    |  5 +-
 t/t1900-repo-info.sh                       |  7 ++-
 t/t2400-worktree-add.sh                    | 21 +++----
 t/t2406-worktree-repair.sh                 |  2 +-
 t/t5503-tagfollow.sh                       | 13 ++---
 t/t5505-remote.sh                          |  4 +-
 t/t5509-fetch-push-namespaces.sh           |  6 +-
 t/t5619-clone-local-ambiguous-transport.sh |  2 +-
 t/t6020-bundle-misc.sh                     |  4 +-
 t/t9210-scalar.sh                          |  2 +-
 t/t9700/test.pl                            |  9 ++-
 16 files changed, 71 insertions(+), 90 deletions(-)


base-commit: cf2139f8e1680b076e115bc0b349e369b4b0ecc4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2076%2Fdscho%2Ftests-explicit-bare-repo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2076/dscho/tests-explicit-bare-repo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2076

Range-diff vs v1:

  1:  a1cdbd58f0 =  1:  a1cdbd58f0 t0001: allow implicit bare repo discovery for aliased-command test
  2:  78744602fb =  2:  78744602fb t0001: replace `cd`+`git` with `git --git-dir` in `check_config`
  3:  a4f7a6df51 =  3:  a4f7a6df51 t0003: use `--git-dir` for bare repo attribute tests
  4:  5b6bb18632 =  4:  5b6bb18632 t0056: allow implicit bare repo discovery for `-C` work-tree tests
  5:  c38f0a68f1 =  5:  c38f0a68f1 t1020: use `--git-dir` instead of subshell for bare repo
  6:  a084c39273 =  6:  a084c39273 t1900: avoid using `-C <dir>` for a bare repository
  7:  6a7730cf57 =  7:  6a7730cf57 t2400: explicitly specify bare repo for `git worktree add`
  8:  2905e000c5 =  8:  2905e000c5 t2406: use `--git-dir=.` for bare repository worktree repair
  9:  9001883e15 =  9:  9001883e15 t5503: avoid discovering a bare repository
 10:  6932658411 = 10:  6932658411 t5505: export `GIT_DIR` after `git init --bare`
 11:  f6fc807af6 ! 11:  2f1e745b55 t5509: specify bare repository path explicitly
     @@ Metadata
       ## Commit message ##
          t5509: specify bare repository path explicitly
      
     -    After switching from `-C pushee` to `--git-dir=pushee` as part of
     -    the `safe.bareRepository` preparation, `ext::` URLs that used `.`
     -    (resolved relative to the `-C` target) must spell out the directory
     -    name explicitly.
     +    When `ls-remote` is told to switch the current working directory to the
     +    bare repository `pushee` via `-C pushee`, as part of the
     +    `safe.bareRepository` preparation let's append `--git-dir=.` to spell
     +    out that this is a bare repository that does not need to be discovered
     +    implictly.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t5509-fetch-push-namespaces.sh: test_expect_success 'mirroring a repository us
       test_expect_success 'hide namespaced refs with transfer.hideRefs' '
       	GIT_NAMESPACE=namespace \
      -		git -C pushee -c transfer.hideRefs=refs/tags \
     --		ls-remote "ext::git %s ." >actual &&
     -+		git --git-dir=pushee -c transfer.hideRefs=refs/tags \
     -+		ls-remote "ext::git %s pushee" >actual &&
     ++		git -C pushee --git-dir=. -c transfer.hideRefs=refs/tags \
     + 		ls-remote "ext::git %s ." >actual &&
       	printf "$commit1\trefs/heads/main\n" >expected &&
       	test_cmp expected actual
     - '
      @@ t/t5509-fetch-push-namespaces.sh: test_expect_success 'hide namespaced refs with transfer.hideRefs' '
       test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
       	git -C pushee pack-refs --all &&
       	GIT_NAMESPACE=namespace \
      -		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
     --		ls-remote "ext::git %s ." >actual &&
     -+		git --git-dir=pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
     -+		ls-remote "ext::git %s pushee" >actual &&
     ++		git -C pushee --git-dir=. -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
     + 		ls-remote "ext::git %s ." >actual &&
       	printf "$commit1\trefs/heads/main\n" >expected &&
       	printf "$commit0\trefs/tags/0\n" >>expected &&
     - 	printf "$commit1\trefs/tags/1\n" >>expected &&
      @@ t/t5509-fetch-push-namespaces.sh: test_expect_success 'check that transfer.hideRefs does not match unstripped refs
       
       test_expect_success 'hide full refs with transfer.hideRefs' '
       	GIT_NAMESPACE=namespace \
      -		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
     --		ls-remote "ext::git %s ." >actual &&
     -+		git --git-dir=pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
     -+		ls-remote "ext::git %s pushee" >actual &&
     ++		git -C pushee --git-dir=. -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
     + 		ls-remote "ext::git %s ." >actual &&
       	printf "$commit1\trefs/heads/main\n" >expected &&
       	test_cmp expected actual
     - '
 12:  5aa3f2a225 = 12:  c8789bd542 t5540/t5541: avoid accessing a bare repository via `-C <dir>`
 13:  97f22f9e87 = 13:  f09a96e55d t5619: wrap `test_commit_bulk` in `GIT_DIR` subshell for bare repo
 14:  1ae4caf155 = 14:  01ec77c908 t6020: use `-C` for worktree, `--git-dir` for bare repository
 15:  861a8e0940 = 15:  00eaefbf62 t9210: pass `safe.bareRepository=all` to `scalar register`
 16:  1f1668a6f4 = 16:  890dfd024d t9700: stop relying on implicit bare repo discovery
 17:  c8e5bef27b = 17:  139b9da946 git p4 clone --bare: need to be explicit about the gitdir

-- 
gitgitgadget
