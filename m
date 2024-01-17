Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6224B55
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521166; cv=none; b=QBGhZfk9gQiG9RzXh/AkJrKgK6e1RstNnX3XDISb6fNJsMEOqFXsSL2x0jZKptK42zEt2IFwgSuprxLO9DbYFL0NVBFHXQB/D3y5tORydjctLTc+wXEieFZWgSANR7yii7ihVzhx/5We4vPrRm4GD79s/6TsyLBY2PU+6mJ+mxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521166; c=relaxed/simple;
	bh=erGpIszHwp0vYEDydQr/N3eGDGwcoKRwW1aFitRqpnY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=L0LLirV2Vg6VPA2rA4Y/Bysk6K+c7pPDVGCpBJCO33mgmT2wjlau32jU5X5DU+T7Cd1o6pxuMbdUT28WbQXd16ca9JlFxt0RSlCsERlniBlxPDBDZJqTU0Y7h0VvJDOlSUSGPbXXiqCQ5dbucJ3v0gn8EKjjDjKzuodA8QylGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9sJuIDI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9sJuIDI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e76626170so37964625e9.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521163; x=1706125963; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBsFD9LirYNHxYh0GogWEmWJgi6tlI+7WuMM5cqm1Fg=;
        b=T9sJuIDIdASwxRoALGY02IB2qr3u2wP+LFPoWancAeKvMhxV7cSqQsM9RNN9dTmAaQ
         G3mpEeYVWnztia33A9VobiuQo24hoVVVL3RqYSkflfnVsEO7d7PsM5KdQIdHQqkQYNRG
         n/y33pJAkRL0PCqmGqef24iVAjmTx7/RfdWxmtKLGpnZy7TQwZlkdbAuJ4vDurPHnGmZ
         9yOFYUAj+HlYcB2vOauKGiW+xRuxUj43sOC8Bbe4pQL3UCug0OJTrJDly+1xEyGyiW+H
         hDWOU/X9+zXuhO4I7LAyfbwSn2xt8j/g6krgPYnQLN/Ld1AiPaqbP2FI09p3TBJvkQ0a
         6gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521163; x=1706125963;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBsFD9LirYNHxYh0GogWEmWJgi6tlI+7WuMM5cqm1Fg=;
        b=osHrewuWP7hsl4tfok/J+PcmjF2WXg9arZ2jKxFP3LCmcue94GzmHeQWDADCXDk0gz
         h9bEIrGc7bmlM8khCvupCKQOh0rzgnu7dbqMZbfTwkfc/GemN/MGAhaLBPr8728nYn4Z
         SzhdzHP6NVHd7Oi1dwgiF6YYQX2i8a9ujYRtei2Nsp8zV8Y+gWoLy8p3JHo7hLhG2M33
         dIGdSLr7wrxkMWdHR/PMZCC5pWtKH3H7ql9ackd9L7Tw8X+lgPI3rwVV3F9n7xKVn+6g
         iElgtfPGqYZnK2cPCEp7IV6/5qI1LowdrbweejWgHO93/IXZFiJ3e2NQm0y/Y9rpN7jp
         SZ8A==
X-Gm-Message-State: AOJu0YwIfREJazq492MaO3UhIbbkrQLWHiFJRgz8/IDEHhQTCpxWw7Rv
	3hL1zAtIspR234uJe/kbiMjGOUewNa8=
X-Google-Smtp-Source: AGHT+IFw1gtvPXg2zFTTlGxBxCiVi2jnx8R7JY/N1NuJHI4PiVKzgZOKrnw/FskcgOnXVYndQ0witg==
X-Received: by 2002:a05:600c:3585:b0:40e:499c:f332 with SMTP id p5-20020a05600c358500b0040e499cf332mr5361180wmq.108.1705521163400;
        Wed, 17 Jan 2024 11:52:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0040e85f86515sm5630458wmq.29.2024.01.17.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:42 -0800 (PST)
Message-ID: <9d10526369525a0ceee2d75742399130ccf885ce.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:31 +0000
Subject: [PATCH 08/12] t1415: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move this test into t0600 with other reffiles specific tests since it
checks for individua loose refs and thus is specific to the reffiles
backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 20 ++++++++++++++++++++
 t/t1415-worktree-refs.sh    | 11 -----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 0b28a2cc5ea..8526e5cf987 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -502,4 +502,24 @@ test_expect_success 'empty reflog' '
 	test_must_be_empty err
 '
 
+# The 'packed-refs' file is stored directly in .git/. This means it is global
+# to the repository, and can only contain refs that are shared across all
+# worktrees.
+test_expect_success 'refs/worktree must not be packed' '
+	test_commit initial &&
+	test_commit wt1 &&
+	test_commit wt2 &&
+	git worktree add wt1 wt1 &&
+	git worktree add wt2 wt2 &&
+	git checkout initial &&
+	git update-ref refs/worktree/foo HEAD &&
+	git -C wt1 update-ref refs/worktree/foo HEAD &&
+	git -C wt2 update-ref refs/worktree/foo HEAD &&
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/tags/wt1 &&
+	test_path_is_file .git/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
+'
+
 test_done
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 3b531842dd4..eb4eec8becb 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -17,17 +17,6 @@ test_expect_success 'setup' '
 	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-# The 'packed-refs' file is stored directly in .git/. This means it is global
-# to the repository, and can only contain refs that are shared across all
-# worktrees.
-test_expect_success REFFILES 'refs/worktree must not be packed' '
-	git pack-refs --all &&
-	test_path_is_missing .git/refs/tags/wt1 &&
-	test_path_is_file .git/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
-'
-
 test_expect_success 'refs/worktree are per-worktree' '
 	test_cmp_rev worktree/foo initial &&
 	( cd wt1 && test_cmp_rev worktree/foo wt1 ) &&
-- 
gitgitgadget

