Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF322F7F18
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993675; cv=none; b=lxaZZrkPGKbRczzYCVb01AtKWcpvT+qe/epaCFjG1OjABhcTZ8+anUDwKmP0r/LiyA9fLuV3Nx6o5GDAsOU9kzmVNTmV+BHm3e6U7Ib2kWQdsNDUFtblGBR5/6UPTiGyxaS69XfNTiuEvVnc3eHJj2WLv4IiiCgTJ28VZPQur+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993675; c=relaxed/simple;
	bh=mMDZTISHuU00Jm65dpFYVUiikgK+23MGJUMFjWkzIGk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nwY12hxTckuyl6j8gB6dDPM7xbfEz/ZtJR9tCXOTmq7xmd2r0ceessM4TOLkrXUhaMq/vzpm5u0rizLMQ3ZLBjEZzrLyCLfr+uNS5638W4WvAry4EH8crXaMNEzFirqCD6XqgN//xKORneFzpDMKPqORaMmUpdvYB4tRnfEMHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alkea/i9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alkea/i9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1298105a91.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784993672; x=1785598472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gBwevXGvlEqwB0p1QMOrpgldc8hxwcXPTK4ofs2Rpe0=;
        b=alkea/i9OSlX0x79cdFDkvgpHpKGmRPAq1yP1IHaE2sAnyOMha1PYHzEVlAny0pJUz
         4I/R6pUn9jcD/Gr+XjGRbcmmhgns9eflFlb3Thm947uPHasVsoaxf1oXdaXINEtp31qX
         6yXrzFBIX3IKZCpl110gV7KMNvR+uKkKLnQHSpkxxXzboN47QON/Bfl0M0M2EI0paTac
         Sx56r5fqrzpTLexJKfI/fAfwzakWVmFQorKmdwYQEu0tHhWUKCtznEIuMTxnD6LdnajT
         DfnHGVN6G4sqQaowDZMJglfKOZI2T4BMKT1WylhHFqtPMi20v+8BYB3AFClPugRf8Ff5
         xwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784993672; x=1785598472;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gBwevXGvlEqwB0p1QMOrpgldc8hxwcXPTK4ofs2Rpe0=;
        b=let1BINyOudjLTl6fv8OWhvuKkGMJxShZtVpwgUkKSOfSjeV7vqTxTj5OjwU+vsxm6
         aWenymD2MDuliUMWWsh+Vl7lcQjrW0u/u4unXcIxF8e+h4QinDWz6dWkBQxwwrOs6Hmj
         uwTNmMor3yuoup8j/+QNCY9xM+1Z28AjRKS4ypq58ViitaDfb97QmVyZ/JgRNtaUt5Mn
         VGSy9RcZg/UgDjx+On3ABZKD/yIOsQUArO+krobTIZmi7nXe/dpxL6NvXVn7/Gkv3Zh8
         LBBSe8P3UFRrqmf23qC31jgk8xevNMhdzDJdbsilSCjycIsJ5+2b7QKuNo7VK6jWBe+g
         JYbg==
X-Gm-Message-State: AOJu0YzUZznOAgHSzfmiC1wZIFPMFXzUKrfWzIPJ679ZCl0auToTqi6l
	mKtFDOoRxOKdluAXwt0PUzjg72Lw8g6I3G3mdMklFFz0KQ/viWL3IuFEpbPdxw==
X-Gm-Gg: AR+sD10qQtZE11vCScE0hdwOFe4SZahfaHxumaK6COgPi2mVXFyB+O114M2ckC3VY1d
	9jjym5jw+09So9t73vxqnfKsvV+jtists+VPTo0wgbdEBlv8Fd7zFn5YeItrgnIxTr5e5ak9TT2
	Chz4eIFd76IOmfT5wBfZaQa9p+la9IcM10KjAzSeswac+8pO8fzL5nT2Or+rdHMAoSHC7ZXr8In
	gVS/vjXeXWMepOUzDsbgfnWA+CuTlOeL20rDYs8M4F2gKe5vBI5sT98hHZ19hnI261ivgnTZiUj
	fLl0ta4h8AqSJHMC+fFTUaWYCIqaUjN92/hoYYLHBhBf4P+2iBm0Tq+bRtIKP4YRnVuTK28GEZS
	9Ccz4JQQ7u/XwPwhyzEXGt0HilShXgHH0+T1XJi2NMnpoHDQMierCpYBVdFx336145qlX2rczap
	MU89I4yVLK0sw=
X-Received: by 2002:a17:90b:5888:b0:38e:8896:4024 with SMTP id 98e67ed59e1d1-38f298b76d6mr2689125a91.40.1784993671824;
        Sat, 25 Jul 2026 08:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.7.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041c3647sm2871210a91.16.2026.07.25.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:34:31 -0700 (PDT)
Message-Id: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 15:34:27 +0000
Subject: [PATCH 0/2] checkout -m: refine autostash fallback
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

Avoiding checkout -m autostash retries when no tracked local changes exist
and visually separating autostash conflict advice from the subsequent
branch-switch message.

Addresses #leftoverbits from here:
https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/

Harald Nordgren (2):
  sequencer: teach autostash apply to report conflicts
  checkout -m: refine autostash fallback

 builtin/checkout.c | 18 ++++++++++++++----
 builtin/commit.c   |  2 +-
 builtin/merge.c    |  6 +++---
 sequencer.c        | 29 +++++++++++++++++++----------
 sequencer.h        |  3 ++-
 t/t7201-co.sh      | 17 ++++++++++++++++-
 6 files changed, 55 insertions(+), 20 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v1
Pull-Request: https://github.com/git/git/pull/2364
-- 
gitgitgadget
