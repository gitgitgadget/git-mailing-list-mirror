Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5A2D9EED
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973602; cv=none; b=evtb+ixWBznCQ+3OygG4atQ7iuOTxEp/xcG3yB9rru8d9u9bpBLykDFQ9ExIYYTVu22Eu27sLj1vb7pQZHqw9j6ZEksKStn59+ReqjJI9dq5uQPSW3hCLl1Qg3XF6rnNDSN3Shrfj2Gp4BI1szuQTZCuYx97pTADjHLjR/ZLiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973602; c=relaxed/simple;
	bh=PNYVIW1/BJNqJ0S2iFAdSyI5sf0C1PAlPgKvJexsvDo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VxqLw/+Bw4d0xkeB62XlFUY6pSvvFL5zxrp2V57ZjKi4Ps/MW/0vXtQlSD5NMGXH37upjbi0R7Jf7VVR9Ayz/rRDi/GYD4L7oO2pSYj4NRrneLeCSKybx7aAW0lbPMepjcp8E3llmC3meoViEYcnfUBDUkcboDXsDHquJokq5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy8aw362; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy8aw362"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so28961175e9.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751973598; x=1752578398; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tgSsjxi8/Op2EpODMUUBS2MXisP/0E3v28o9sPAHFM=;
        b=Vy8aw362d8dzjmBg+XTaM+9vi2cmrG+g00Zc12uC0st5MEra84wpX1wjt47wBr1iSG
         5fElwDz5aSnxKXJHGkyTpT8sMjqlVQluNU5s/nuTPMGYVjDPH6d6XQKUZEAfVxK3KQmi
         Z5i+HCWDf8RvBdHFbXyAtkYYqrwQEa4uuwuyTLF+/wPnG3xGJtI/BN7JSHyj72cagEeX
         Ha5H3CPk5DIlRYrbLRxKrrwkUB80/Ay5Kbbd8VcC9hPkjCG1fMiEUr67/5KmyJKWSfpR
         azQ0ln+czXWTj40HtFZI8EcnI8Un1Bm/SJn+0p6NAOQgeDGqbBXdiJ8I2Ly2/0gMeZd1
         lQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973598; x=1752578398;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tgSsjxi8/Op2EpODMUUBS2MXisP/0E3v28o9sPAHFM=;
        b=bAA50BSxuzP2fwUq9Kftxg2Wgnh24vtlA6XekHtH4JXgbCtZhejnm+UNy+xi0UHHKh
         uAwXuAcr65trU88A2aCnxU3nnRS3ijHt3bf29qfynaUQqxZ6ABRzkQJF51TBl1K1ngUP
         3z5lcmFJvlRIXv4baPCqAfWHe0VLqCi5D1qSFEFYAmWrJmnrd+E7Ul9TUUacbJZ9ojUv
         lcmyzsRWP4GVUjdOtc4bLiKbjmsiepPji70fEr/yH6eUDvajcRVeRNkqKr/XVj8qzbZ5
         RLY95V5A08fTTTQA6AmivTCK7LoxTqI5IW1raBd/V4fIuhamycX7wFGXLP86CTNKx2ml
         L6vw==
X-Gm-Message-State: AOJu0YxXpdY42Q05I9Jp99v3KdCHLX0n9DKvi/1MGhNsE8CDea31fLwS
	p+u3fwHyfq2Ch0EViB4g7JeebEQQdjl5Oy0xxhi46MffcLPqs9ke1Q8ifDrLeg==
X-Gm-Gg: ASbGncvSEeqqjAmTSjAz8psHfzGOalnHtzxhDewWVYaCSRq8T8aDIAnkCDM4DvTfus5
	AmDBhdGXOUBzZPYEMvj5en6pyL2CTJ3ekozw8hcCt65MRFTg4V0UJI9Bd8tS5Epe3bwZBVfgLxj
	02qpytCxzKlbKRwLkymdF/P/TdtHHI1BvN+yXFDQEicMTHqdZFaNmo75HePpg/Qs/VvIKzbEORt
	fsY5dQ5AfQ9229j6PEg2i3zSM6nRCnok82kcyleNVeVYKWPkZHY/n1D1mqsrB2Jw5OkVnz9qv8o
	ee4IPs/IXAOrd6DB0mXGQTFX5SfsZ6uJGf+OGUUMNCE8vaQXtmzaQuuDDV6tjVx+yWOZBZue4g=
	=
X-Google-Smtp-Source: AGHT+IHFzdl2y/6EeCWrmS1+cho0FuvgLfuGM2/OUcMxN81TDazQOUiFkwrtjSWqi/tPH6IYPlmjvw==
X-Received: by 2002:a05:600c:3494:b0:453:8a63:b484 with SMTP id 5b1f17b1804b1-454b318db90mr167286285e9.30.1751973597940;
        Tue, 08 Jul 2025 04:19:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3dd150sm19426935e9.40.2025.07.08.04.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:19:55 -0700 (PDT)
Message-Id: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 11:19:50 +0000
Subject: [PATCH 0/3] sparse-checkout: add 'clean' command
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

When using cone-mode sparse-checkout, users specify which tracked
directories they want (recursively) and any directory not part of the parent
paths for those directories are considered "out of scope". When changing
sparse-checkouts, there are a variety of reasons why these "out of scope"
directories could remain, including:

 * The user has .gitignore or .git/info/exclude files that tell Git to not
   remove files of a certain type.
 * Some filesystem blocker prevented the removal of a tracked file. This is
   usually more of an issue on Windows where a read handle will block file
   deletion.

Typically, this would not mean too much for the user experience. A few extra
filesystem checks might be required to satisfy git status commands, but the
scope of the performance hit is relative to how many cruft files are left
over in this situation.

However, when using the sparse index, these tracked sparse directories cause
significant performance issues. When noticing that the index contains a
sparse directory but that directory exists on disk, Git needs to expand that
sparse directory to determine which files are tracked or untracked. The
current mechanism expands the entire index to a full one, an expensive
operation that scales with the total number of paths at HEAD and not just
the number of cruft files left over.

Advice was added in 9479a31d603 (advice: warn when sparse index expands,
2024-07-08) to help users determine that they were in this state. However,
the advice doesn't actually recommend helpful ways to get out of this state.
Recommending "git clean" on its own is incomplete, as typically users
actually need 'git clean -dfx' to clear out the ignored or excluded files.
Even then, they may need 'git sparse-checkout reapply' afterwards to clear
the sparse directories.

The advice was successful in helping to alert users to the problem, which is
how I got wind of many of these cases for how users get into this state.
It's now time to give them a tool that helps them out of this state.

This series adds a new 'git sparse-checkout clean' command that currently
only works for cone-mode sparse-checkouts. The only thing it does is
collapse the index to a sparse index (as much as possible) and make sure
that any sparse directories are removed. These directories are listed to
stdout.

A --dry-run option is available to list the directories that would be
removed without actually deleting the directories.

This option would be preferred to something like 'git clean -dfx' since it
does not clear the excluded files that are still within the sparse-checkout.
Instead, it performs the exact filesystem operations required to refresh the
sparse index performance back to what is expected.

I spent a few weeks debating with myself about whether or not this was the
right interface, so please suggest alternatives if you have better ideas.
Among my rejected ideas include:

 * 'git sparse-checkout reapply -f -x' or similar augmentations of
   'reapply'.
 * 'git clean --sparse' to focus the clean operation on things outside of
   the sparse-checkout.

The implementation is rather simple with the current CLI. Future
augmentations could include a --quiet option to silence the output and a
--verbose option to list the files that exist within each directory and
would/will be removed.

Thanks, -Stolee

Derrick Stolee (3):
  sparse-checkout: remove use of the_repository
  sparse-checkout: add 'clean' command
  sparse-index: point users to new 'clean' action

 Documentation/git-sparse-checkout.adoc |  13 +-
 builtin/sparse-checkout.c              | 192 +++++++++++++++++--------
 sparse-index.c                         |   3 +-
 t/t1091-sparse-checkout-builtin.sh     |  48 +++++++
 4 files changed, 197 insertions(+), 59 deletions(-)


base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1941%2Fderrickstolee%2Fgit-sparse-checkout-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1941/derrickstolee/git-sparse-checkout-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1941
-- 
gitgitgadget
