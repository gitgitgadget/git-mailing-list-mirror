Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F618024
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723835; cv=none; b=aLpwT7lXI1aaDrDJByl+g+VPaf8NvnLl1oyZUInEwgYk7M+FTJq3ZCzX3gQcd+q3ZO6IyK8oXrJPn8CGFTe1aizlkrLDqQctISjB6leXZP9AGqECwv/DWsQfL7ojQBAAhQkLCHFeclf6snsGE2Heln68aZ5b+YooWju7ebf+O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723835; c=relaxed/simple;
	bh=vSP0952DTpvH4Pn5k/+3Y+MxbxIMdPbHTz9iGX0J7QQ=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=udWo2sQe9XsptbM6cBn1VumcuPawBhpBOyJIw1zQcpHySK0KNEqs4r2TyyiR6UoQE5y9u7+3NCGy4zX7TChYDYrmh6UP/E+TvIHtcjfN8I7y+zrd4HJpcKB73cwB71GTSI9PbNQscNCm4+kWD7p4CLU3raHlM+t0jvgAgwGKbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2eUvNzf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2eUvNzf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso39203265e9.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723831; x=1740328631; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z9SlRvWlW1ma8qviRqJ9IY1oljE05ELRykVWigYnxO8=;
        b=l2eUvNzfi2tN8k5SPP2IgvDmTDzeOsHTviiZ99iu4lCtUyD+cQ7hI2wg4hRnF3mObJ
         lji/qvd2vFouY+UwVitrsB+f6AwtzjVnL31NqY0UJsW8aakw2QjwPgqzcaHS6nn1Sgk8
         +fJKSWcrlp/Et9MOqcxPl55id+DwhBHLeKgX3hVNiJ0P5YEQcM83Mk4cbbm8RGmLNw58
         HMEzdkI6Pvpblc8qrmw2eviZYDojDNjYfL2UuCRiFW3R5cvPFI1mpjgxv0ENSerm6za9
         0uO3DcOWoGOVdvmnbELJPWkwCgCwVd1wCB09npbiL7PGZBrJ9dcZs1l3vXWbQohN3HNZ
         CfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723831; x=1740328631;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9SlRvWlW1ma8qviRqJ9IY1oljE05ELRykVWigYnxO8=;
        b=hTBp4/OVbpZxpKHm31QhXWMa7F5ZwIxHYvjQp3+kxu37N4BoGWYm7Prwhlj5tcuegW
         pM0OEL7dQPLMl5c1r3HH/arwaSYrHKVTejhuRtEhl6dk/7vNhRoxIuhe1ialqgHqXaC7
         LfVjndi/lNTMdZ9yiN9I6mH/6KZZPpUtIDg7G3VXmlSNzDTV7a11/6peEc5jQe3fYchm
         17yh7qrxETZZNruGheDtyboCquPD+EomHxz9hY91kIeNe/+uf3oy34WPtW2IhG5SeOuJ
         C3HGS4IfLIE2IJJ2B8BRubsXUgCdRI2aeU4Rd5ufTix4tLfdp+U0GuagvPUxoakUbWMj
         UbEg==
X-Gm-Message-State: AOJu0Yz3pWLTpMUdWSmCaVXwI7y5ZIjB5v2WdIJSXbIGqwZnqiAs1E/T
	iNK3lnZK6AyCXz9JPo11JGz5siio5QEKNYD1EH4yay8sVdHIPLpPVGN3fg==
X-Gm-Gg: ASbGnculkxYvxXS4Ikyi2ibQLKOurAo9lMDC/DG3rBZLt55cDTCN8RSFUjFJSl0/fnX
	ODqr3gIDQm8x7TKHUhIfet51ccgEAjl5dj5w2ID0EMyRa01c9WK/DI6+u5EkrT4yY+G2N4lxr4h
	XTfxLY0QjQFW6LqPk38fuioHY3/AcuM+Lwo7N/pviPYY8U6MQIDNBlqd53GbR4Q+2bROjELMu3i
	O7ZTjfOkxJ4gd996lQUBaGliq/QSAzETqyXc/fYvLQcI2mgK/RfycaDYJCkvRxsKYn28WNlQzZr
	uEdOXdY7+1FAGD1w
X-Google-Smtp-Source: AGHT+IF8VwznMCagR6MCsLURP/2oll9MAa/xywV8XlfxOncwxY86vlRRnMu5UpUEOT86YCcy/ZVZuA==
X-Received: by 2002:a05:600c:19c7:b0:439:4c86:9c32 with SMTP id 5b1f17b1804b1-4396e6aa021mr64747245e9.8.1739723831302;
        Sun, 16 Feb 2025 08:37:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd3bsm10022208f8f.22.2025.02.16.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:10 -0800 (PST)
Message-Id: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:04 +0000
Subject: [PATCH 0/5] merge-tree --stdin: flush stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

I tried to squash some fixup commits with "git merge-tree --stdin" and found
that my script deadlocked because the output of "git merge-tree" is not
flushed after each merge. The first patch fixes that and the rest are
cleanups I noticed while reading the code and documentation. This series is
based on maint.

Phillip Wood (5):
  merge-tree --stdin: flush stdout to avoid deadlock
  merge-tree: remove redundant code
  merge-tree: only use basic merge config
  merge-tree: improve docs for --stdin
  merge-tree: fix link formatting in html docs

 Documentation/git-merge-tree.txt | 11 ++++++++---
 builtin/merge-tree.c             | 11 +++++------
 2 files changed, 13 insertions(+), 9 deletions(-)


base-commit: f93ff170b93a1782659637824b25923245ac9dd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1862%2Fphillipwood%2Fmerge-tree-flush-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1862/phillipwood/merge-tree-flush-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1862
-- 
gitgitgadget
