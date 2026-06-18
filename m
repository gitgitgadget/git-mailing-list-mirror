Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0121D5AF
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810231; cv=none; b=KWhtKoftM85XU3JGW1qiKpEa83qLlDd3yqGfLfHLr4MTYxnwJYvzVFYZXRqryy6IH+SuFup0/6JFLa2oNZFx4r/RR+9OYCM4wDPscpSgloGuPMmXcF8h1ZOTH0hHeD65U9sL8UktuYSQWVGZ+/I9JyeAlypIjVlOWVTH19m/HTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810231; c=relaxed/simple;
	bh=0QVYUNb253sjKC65n2U/ROsame+ySUIcQUhQPLdl0nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RfR39J5v6YVKloT51Wk3mjWH0dp5rkLjm8CymfSF8CHRxS1Y/Nhwce01GkqsmUJ8Jw6gYwpZ70hkSreDwPhWJBlrP9PitxkFpqcYJh7sv/OdABMhA7MMl47QT1JUyeSnyUfyBSmC83dhE0ztcasBNVt8nBjss+qLXwwxjYw94G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1fCKMRM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1fCKMRM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519ddebce3dso4492891cf.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810229; x=1782415029; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DhU//k0+rcgk7xHIMH5ubOswPYQ8MfuOHVQfQJELLE=;
        b=r1fCKMRMjVvNM6LQ2PRYHXg0Ue3uvIXbH9U+mUUrIX4Rr+3b1CCf8MAIrTB7vx9tzo
         iTEYC97eI/mBrJjokVCAVYMbevTs8eb6BfgqUFCbdrsIBOuH6DCT1VqPlKuLSnprgfxd
         KAhloOhBoPJhAfJ5z/sMiSCzS8B8cJTrHNYWiiEXbIK3uhJ9WTfGhlyUCrSqpEdkQFvN
         Cq+RbJVLlPwqWX3zULZhgLQQ0XAR07M/XIa5f82kwfPveNOhBTSpQdd56W2xO7AsSNWH
         x9kMr1ZD9q7wcYD6/rcBfgFL8M7fSLg8CjlvSiGrXP3Hu76y3qHKCqHv45vvuVfJtTcp
         DZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810229; x=1782415029;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DhU//k0+rcgk7xHIMH5ubOswPYQ8MfuOHVQfQJELLE=;
        b=YqOnO43LyH7WxWso4flIOsS7990As2tlQBEtlD9XwcNDq/g1v95IEMEBlDb3znT3y4
         TkX0pw/38cNBrGASFFNTRm9a/nDjsBcYVnA92kIyUMr0T/cOX3bH5qpJsZysuWz3pS6z
         JL1QZRtq1Omop5ArR/O8YXIqOEU4Z8V7dIo5oPFifD22dbb7Eoq4qjutt5VRcdlA/Cw3
         cnppI2+kkxzwj4NMyKL1jEY36PNQemdqLSZ74M7Nrod8qvHNws1Qf6rvuO5p24S73Ph1
         FF2zz6QxFF7ACEtX+6tvmp+vYAZQWFPS7DKKCjwRS8lP88Jbrg+bcdvPhBmJOh1yFaqA
         ZQow==
X-Gm-Message-State: AOJu0YyLHsA9+6aIvP1tJwSOfCP5ObZUMzw9hpSSyGcAHbMpfisoSYwL
	UyY/qZAaEDy2p7iEwI7HrJuFBKHVt1YI2ccJLS+o87kzwT+jZqpAGv+0IxEPrA==
X-Gm-Gg: AfdE7cnIoOKP+gNyX91hCqQQLMUAk6He6vShrJxZRE2+Wfw2h78sRRLno6avx14Dr+o
	XZTI/6FcvArg6Dc9DN58R8jjims2GY+dDKQHOqWGmY3JYw65GZqU5qulNNRqFgS5XJMm+TOGDmb
	X0pyEhJ6EyX8oleYfEwvEIf3vZrEQ7jZPOXdv0YOCQroDMBQfY2y+HoqE9jDYmktw9wFomziivq
	ws6RYbqSRnrF/yJ6ArPWRu1HEZ++bjS5COMk5WFoVXZ+puSv95FYRlWDj38b4Y5x0GfPFC73huB
	hTs6fmHfX1cJdHl/bE8uXbpCp369VScSvxKNVOfjxK09s5UI+RkeNXWlzjoFd2DQjPxNyuG1pOd
	4BnUFvusUCOKnV4XAwUZLfCDm3akeVVbkDgIJAEEweYkRUve+xkvX01rFPOn6UCAsM78s6hrALg
	6EJN1GbqAWm0L9UQE=
X-Received: by 2002:ac8:59c5:0:b0:50b:3f6a:1d88 with SMTP id d75a77b69052e-519e4a55702mr7738361cf.19.1781810228738;
        Thu, 18 Jun 2026 12:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e4e9536bsm2303191cf.11.2026.06.18.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:17:07 -0700 (PDT)
Message-Id: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:17:02 +0000
Subject: [PATCH v3 0/4] history: add squash subcommand to fold a range
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits into its
oldest one, reusing that commit's message and replaying any descendants on
top.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  history: re-edit a squash with every message

 Documentation/git-history.adoc |  21 +++
 builtin/history.c              | 287 ++++++++++++++++++++++++++++-----
 t/meson.build                  |   1 +
 t/t3454-history-squash.sh      | 250 ++++++++++++++++++++++++++++
 4 files changed, 521 insertions(+), 38 deletions(-)
 create mode 100755 t/t3454-history-squash.sh


base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v3
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v2:

 1:  c55b9cd6f7 < -:  ---------- t3415: remove prepare-commit-msg hook after use
 2:  22d4276ff5 < -:  ---------- rebase: add --squash to fold a range
 -:  ---------- > 1:  1e31474ef6 history: extract helper for a commit's parent tree
 -:  ---------- > 2:  498da64046 history: give commit_tree_ext a message template
 -:  ---------- > 3:  66b2f49fb4 history: add squash subcommand to fold a range
 -:  ---------- > 4:  43e4270614 history: re-edit a squash with every message

-- 
gitgitgadget
