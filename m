Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC3278161
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741271; cv=none; b=lkMIYwqkGd5nY/L4l8rRMvX6jy3N79vLtBssTwQjK9FeK7c61SdQBfyvoCfHmeI39ZDH/B8KqqnpEhbtAInZvSgAAjNT/1R5H0VQj/VSRSaMtI4wtYNSKcmxQOOPty6lkZgDoduVdg9ZmdTtm750s6epnNQ7dNYRctEmjc7Pa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741271; c=relaxed/simple;
	bh=4l8tUtcI50ZHNPi7yWFsgFjpNOvmr4HvsXiCVIysRuk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d6nS10DKb13X1NELh7KeSx/NNW0CIgv7xlzKKkqOIje6njJKoAXg27niw7RbEpKWuham0Tuc++WB1ADhwFueyLF7WbTv+Ij2n5B3ADynwmDam6qH0dSHOFLH7Zd14OqFYJN2TktpMrpEkhYBIqFnk8GpbUBzwQ2blOrOSlPPWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLr+0+7z; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLr+0+7z"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a3b0242631so10639336d6.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741268; x=1776346068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP988JqBHdXKei8KSk4IgTvPcE7SMhmJuiZbk2tOne8=;
        b=bLr+0+7zhjc/uMWMD9Aq0szkj0qH3fizjzkr55cWKK/yzHSlufhUibCYEVY1JeE7ZB
         UfOuFXbEo2ovA5XZLcZddGv6POnkmnJq16sNGxRFhWOL+gWQxiKI5nQ7WWV9Pr7fP9qO
         /b/Ss0jsSWnr7jaJuyZqUa9/hpVrUgeYZfGNmV3SjjXvxD79mYH8Ka9wku73hc3SBmKz
         BbhjICHL2/ypQ6vqLa9vzUqyS+hH1oiICExFPMqVhHaFz6fObNATZgU15NQuOhOHURMx
         c7ik2gSLZ6bbQbJIMcesZrl93v+YTTS+HUHgq5nE6hNnjm0RlUIg7nj7jZ2cZ/HNC1LK
         JKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741268; x=1776346068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hP988JqBHdXKei8KSk4IgTvPcE7SMhmJuiZbk2tOne8=;
        b=TWUL1mFt5NvEgLyt79WnCJAsHrCHHm4wx0oFmDsiHCbYZn/qNBcu1acLJ26m9feGLk
         IZxRZ09FL4ZZMgKAYmBtFdrIdXHe+peoCqWvxi8Lejr7cSpH4c/X5CsW5nawH9yhpQaC
         6ESEELmS6cbAb84Mr68iCgwVZjnJq6Alw5/EyPCOn5IXVG5D0xWWLOzYrrxSuT+elqkz
         /ShGOtoU1puP61bh2kgGDoCnMO5ujEPvokFQzWAlwIzFAK6AK/ci8vsDGdJEQ9IV9WEb
         Xhxr7+cZUO9r4lLmiTlAPVvM7DlhN1N3HLRYF6EJpiT2w4pni1x6HFYt2jVGpjiSl2gC
         hZuw==
X-Gm-Message-State: AOJu0YxUXMZd9Or6bT5NgHakk0WcC50YbADIfT4xdeNGnKpu4o1am18J
	Ped01kFMAm+WawZo9ghPF9ZZ13lx7VlXuTCCho5KthZctNMCMu8bcUls6BX2xA==
X-Gm-Gg: AeBDieuSDzsv33ZQIjwZyo/fwS3fh3N5OMjIuAigyWVMKT9d0+dU7F+qmffK3+49s2a
	Oh1qefOealbsE9Tq5Dse7pfcO4kVALMqODXgp4CnCsclU8XVyLtM3zWM5Rnvr9Y92fCtk5lQJat
	XVI9jDQbCq6NCUqwXAqZYQh96LeNUZQNmTKNq3VN9Qm+JC+zj+MOHeYxNccTxAfOhLHGkhTQ05a
	nqjgtnpIqO/TCE9XVUlEUuy7nUTqdajqo17AjwYo14oMR9R8qHa2rm0J5GPH21ndYUjHRY3L+JL
	gVtcceeDXVo8q3zATIomRa5YvhSwGixU8hpyA8f5FZ9lnLUYzcnj4Vs/A54t44qzbmvGj40dIqk
	E5aX3Hpm8W79dWneUbVNff8ZVC5ag1iEo9otfoTkdBEDi28hUANAPv4mXJCapBM9K88sPavE01B
	3hme+rkcuF9q0gRDL/hQVxtD/gu3v0XHmdKhcRDA==
X-Received: by 2002:a05:6214:501a:b0:8a6:268e:a17d with SMTP id 6a1803df08f44-8a7025b8639mr415573316d6.21.1775741267541;
        Thu, 09 Apr 2026 06:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf2769sm194455256d6.14.2026.04.09.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:27:46 -0700 (PDT)
Message-Id: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 13:27:41 +0000
Subject: [PATCH v7 0/4] checkout: 'autostash' for branch switching
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --ours-label, --theirs-label, --base-label for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 +++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  27 ++---
 builtin/checkout.c              | 138 ++++++++++-------------
 builtin/stash.c                 |  32 ++++--
 sequencer.c                     |  67 +++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  18 +++
 t/t7201-co.sh                   | 188 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 13 files changed, 431 insertions(+), 151 deletions(-)


base-commit: b15384c06f77bc2d34d0d3623a8a58218313a561
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v7
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v6:

 1:  cd9c64ba60 ! 1:  284075600a stash: add --ours-label, --theirs-label, --base-label for apply
     @@ Documentation/git-stash.adoc: git stash list [<log-options>]
      -git stash apply [--index] [-q | --quiet] [<stash>]
      +git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
       git stash branch <branchname> [<stash>]
     - git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
     + git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
       	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
      @@ Documentation/git-stash.adoc: the index's ones. However, this can fail, when you have conflicts
       (which are stored in the index, where you therefore can no longer
 2:  d572c4bb7d = 2:  64261e3cb6 sequencer: allow create_autostash to run silently
 3:  80a98116fc = 3:  c0d6b4b4c0 sequencer: teach autostash apply to take optional conflict marker labels
 4:  7ecb0835b7 ! 4:  1c29e19971 checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      -					0, 0);
      -			init_ui_merge_options(&o, the_repository);
      -			o.verbosity = 0;
     --			work = write_in_core_index_as_tree(the_repository);
     +-			work = write_in_core_index_as_tree(the_repository,
     +-							   the_repository->index);
      -
      -			ret = reset_tree(new_tree,
      -					 opts, 1,
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	git reset --hard
      +'
      +
     ++test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
     ++	git checkout -f main &&
     ++	git reset --hard &&
     ++	git clean -f &&
     ++
     ++	git checkout -b nonoverlap_base &&
     ++	fill a b c d >file &&
     ++	git add file &&
     ++	git commit -m "add file" &&
     ++
     ++	git checkout -b nonoverlap_child &&
     ++	fill a b c INSERTED d >file &&
     ++	git commit -a -m "insert line near end of file" &&
     ++
     ++	fill DIRTY a b c INSERTED d >file &&
     ++
     ++	git checkout -m nonoverlap_base 2>stderr &&
     ++	test_grep "Applied autostash" stderr &&
     ++	test_grep ! "resulted in conflicts" stderr &&
     ++
     ++	fill DIRTY a b c d >expect &&
     ++	test_cmp expect file &&
     ++
     ++	git checkout -f main &&
     ++	git branch -D nonoverlap_base &&
     ++	git branch -D nonoverlap_child
     ++'
     ++
      +test_expect_success 'checkout -m -b skips stash with dirty tree' '
      +	git checkout -f main &&
      +	git clean -f &&

-- 
gitgitgadget
