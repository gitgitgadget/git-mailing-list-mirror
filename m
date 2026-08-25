Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B48345740
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691880; cv=none; b=K9bGt5Efy0KUTVphymp0YHPMWj2lLtgFn4prmuNz6zcfWDttyFW1NccMXskrDaFbTXPv4r4iIPy7G4eC3dJRiGdun1mfyHCf8eJUw4ay+La4n6NY9xoWpMs34c3gSUzG8CgfWkMUj9Nsup5V/LAXspGxGKo/J4f9FTtQHJqWRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691880; c=relaxed/simple;
	bh=hVAF/qF5PxrwIDCINZOIwHES7jbNt58yc2gNBt9ioDU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A7gGw4PZFqCwRIj3oZF+eBNJv9q6p84TehIncOH0zXl0e/Oz4VhPbP9rqzvk13LP8kE/968gelv77PIVuvJSm7SBUFlFJGAUVur0SzCfTIcwnFDV4EyjD4Wt5NL2Ee0KXeTJhMT5qS7wYQJ2FVrxnSZXjvsjZw9kjuwaxd2J3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZaIyvpo; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZaIyvpo"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f42ef0b693so194896a34.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691878; x=1788296678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vQJfEwjGepjJfD6iJfPt/jd+nW3Kqqtjq6JcZCknxNg=;
        b=AZaIyvpodkQRHstd9+2JyLIbhkeoOfMCTLOvWmihoYjUQsnObnxGv8ANtU1LJTzAfS
         gJUHrUscJlcwarfJgegfjcbzzt4g8Eof9hxAvL5PoIYvvRTqq7AgNesu1t3M6FrZ1+8n
         H+YA0CCfvfeVcTcdL2llXEJ65lB2nzrVD710XEjxTKb4T9znl1lN3MEcFKy/wXh5f1SV
         PjfLXMYj5VI3rMLYg19bHmiALGsNoxQOCi2P6svA6pwZ4F3XSbx3/ysFq7Wg9cuTgjE3
         ze7S3HtSrozb3ToepCnDymIHfmls63uCTxpNDgWXXJD2NFAMeXzTwo3W1YBmxoRnX6vq
         d2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691878; x=1788296678;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQJfEwjGepjJfD6iJfPt/jd+nW3Kqqtjq6JcZCknxNg=;
        b=O9IX87iq6ZN4dsQWFC6TeXxi9oAOOCppeiaLnNt5bmd1D6DtnN4nBOEuujyleONyTA
         EFGhMfM/sXXeclN4Z1m8T77uA3CSlSYN5IkPrjgqZ7KWgIQQWKTd+HSJ0bLbw889ai5p
         D+VfYr0HLPaqNZJBV4VOcFeMjhwQwMPBKLmSx2VAhQDFM6yVxAuukoy1KlmKnARMx+Jx
         ckxn2RqtTVXoJG6I/n0oklmbl8xLBgiFIczu6SOVLWi7D4AFXNOzG42i9DVov8/qJ42Y
         luANGKU3GeODqIo/vorg70+Sir32N15sjsz7K0wVj3k+tB33+H+RcZOzA8Oj/F2nKdeQ
         WNrg==
X-Gm-Message-State: AFuF++mV85Om/4ydO4lRMVAo/jsm6aV5ROnzOYR+rVIC3Ou9E/j1oQPx
	VJYb24JYpxBcUgx3+8oQQRAS3VZeMgLuJswTFPdKDQACMPfd7RTcHC/OX9e93A==
X-Gm-Gg: AR+sD11Q/z44tQttxuQEHxlaexzrl9oQX/bFwUnMrqhjYAqRNF3qj4ao8GZs4MgloJB
	pFI8rDweY84vDzwL8XRWWLlgGFXaktTJ3T+cjnzNOjm/KPgW3WYDOlSxtozhPrBYlcsihPEf/q/
	SNoYWqPwhab03inMGJ9fKgbA1+IjlM4BJkmez7BkXDLhUhSFvwZNJLxv3ehvmZkdgPoU6JJ3e6V
	LK/5gM+ZBwNHF9gFuCTqNBnaiDmHxmy4oBjvFFV1PPTAVMcYoK8i9cL/d4bIhCz7Npp2sdxm0XH
	ueycFBeWDLy1OTsitcl+jTeGJXn+29thb4iwhPw9w9xR6AvBZHNV4yIFn2nt2G1rHtzlxu+MiU2
	UnEzjkW3EuHuWYWOs+8b6sUsfculk7yp4YTOrj2yR63lJgpNrTTTQKcZz7qDv2F/rud22dK0gYW
	tAPygHeKSiLYEDuGnPfWOly5bd3VNZNPT68y8racNPrSsvET/pJEnzrjyiNQ3fDBKgvA==
X-Received: by 2002:a05:6830:3695:b0:7e6:e8cd:bb7e with SMTP id 46e09a7af769-7f4c4b8b2e5mr1991379a34.4.1787691877970;
        Tue, 25 Aug 2026 14:04:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.165.178])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c81c1744sm26894a34.8.2026.08.25.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:04:37 -0700 (PDT)
Message-Id: <pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:04:31 +0000
Subject: [PATCH v8 0/4] worktree add: improve message for ambiguous remote branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add ../foo-dir bar-topic' fails to dwim when there are
multiple remote branches with name `bar-topic'. But it doesn't display
meaningful message as 'git checkout bar-topic' does under the same
situation.

We improve this by adding advice and modify the error message for worktree
add.

By Junio's suggestion, we include matched remote names in the advice. It is
applied to checkout, too.

We also fix the behavior of --guess-remote when there are multiple matches.

Changes from the previous patch:

 * add another commit to fix the behavior of --guess-remote

Yoichi NAKAYAMA (4):
  checkout: extract function to display advice for ambiguous remotes
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name
  worktree add: treat multiple matches with --guess-remote as an error

 Documentation/config/worktree.adoc |  5 +-
 Documentation/git-worktree.adoc    |  4 +-
 builtin/checkout.c                 | 76 ++++++++++++++++++------------
 builtin/worktree.c                 | 57 +++++++++++++++++++---
 checkout.c                         | 14 +++++-
 checkout.h                         |  5 +-
 t/t2400-worktree-add.sh            | 17 ++++++-
 7 files changed, 134 insertions(+), 44 deletions(-)


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v7:

 1:  e3f7d88520 = 1:  e3f7d88520 checkout: extract function to display advice for ambiguous remotes
 2:  89c0f4d303 = 2:  89c0f4d303 checkout: improve message for ambiguous remote branch name
 3:  095a5796d4 = 3:  095a5796d4 worktree add: improve message for ambiguous remote branch name
 -:  ---------- > 4:  927856e0a0 worktree add: treat multiple matches with --guess-remote as an error

-- 
gitgitgadget
