Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08160345CA1
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214328; cv=none; b=bT1W9q/84+hzmwZsN+1/4Hyg58OVU20zW+4obKgDk8aRUGAFpEKpAVSgOjTYZjBAGM8iNZnkKCtfSbnj1uwAUW25vf7OjQr8He54HW9BMmmO37NukLQhFeGNci7+yawF2uIjMwEsFXGRnUum3EuL+cWyvZMVDCNIWjAJYorSicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214328; c=relaxed/simple;
	bh=Cg8gOdl4iXD8K3iBHzhZ1+M0TqHiSvFtXYaaDhAXIhI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q7yt0d9VLtpXRpVRoIBTnNRvZIkkts9SgG/brpEdrknVFh0v4vKg5tAGCtYT+ys+eGfANx6le9STDfrabloGX+ZpJz1MUeiIjLzYx4R4blTiDJy4y1mAlCwPBKyz4cV1Xzea7Iqjfkw6Qfn9NKUmABJZVWHZYwqVW3O6gWn99Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4pWrANR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4pWrANR"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a151012558so103188456d6.3
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214326; x=1777819126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpT3gsty+J5evlOS4DEDjPoZhDOu8/4vtCbpLo7aTY4=;
        b=a4pWrANR6vgXmS0LLwHESaPeuHS+19C6jPcb/SbZLRBc9a5i3xz8cKxqqzStGbjoxW
         KzBU/XxEfMkleBgmpcTqCqHqLv1gsd2xjHeZ1KvqcOp+r/FmDpsFDAO4r1kbxhqtYPRR
         /WvQb82E9XPpfWaouhoZYto1N5Jrb8qw6gxcFLpPsN/jZ3Dm6gKWkeXQazZy/4PEKHlb
         t09ruwE4IbqlVQyKv1M8xWFdtUH6w3d0sm10yijJ5NiPDXoAPH03oeXSmBLP6fSJ59Nu
         /uTVB86bGZGWJARtnoJHbzg0FXKytKMWXVl3vPnFkDfCD86FrmxPQgVqrxqNdoT1hQVP
         Q90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214326; x=1777819126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpT3gsty+J5evlOS4DEDjPoZhDOu8/4vtCbpLo7aTY4=;
        b=NaW7FwssT4y7heQNykADybjROxst+Q1Qpi1nEM8UIYU5L8P/2jDfpd5w+GrzcY7k88
         BAK5w0WeLFPjoQh+4udkEe/u3fZMDUMUcEyvNiUZ/1B+OYEGWeWEI6ZCH3p6w8kLhioR
         qsW2O05PMCR31YnEIh0Hdc+nbgdDm7+/WxDd1cq6Pbh2fOjXIqbN8gdPaW5FVwrBpDtA
         rykII+TKRahqweTF3hdXc5/27FG2luT2ebgYi/8zs9pU/e5RtrMMWRjLlQk/PbpWTM5l
         RLRQF6QWB3Axx4OcPDGNpEStU2XzNJL59nc/MntIdw5dwSrYBbS2G6cL1tb+/mgGNzLk
         ovgg==
X-Gm-Message-State: AOJu0YzoK4qBhIZCoqZ1/qqGce0FHu/uoi3zTgyJQbd2i4p+IcRJIvAC
	fB1Y1tpCG4kK6hbVKGDUkZPuBDgNtpwwN6znsV74Ie9f8ELS6U5PNCMHd+6IhcR+
X-Gm-Gg: AeBDieuagTacW38ZLq/SepMebIFLOQGVwxfiePbfZxn7slf59FdzJGeXRkHeofZKe5Q
	z3B/YXPtOZo4dhS3pxQ1I2AiFKGABSIemNCWkMmybd0hX5oWcolCHg5v5DlK1rGqVtvLYqBIVBi
	9Kuz8ZgN/p5ApdML8tcM51EPq2ZRz1JSaR6xJWWx/5vEGG8fulwf0nhav8M10cRAUpQcs9LXnYV
	O7nhKvgjXreh2hroh0xvFScbUbi7jDx25chDCeNCHD7Cf1L8lXi0ucL1QTWETYNPUgYklmen28w
	XDSIRPUWyfxwrkDSPXnfRPGPS6rejnN/IV5rXD+lvdnzrkx2O4u31zolDb/6RY4xmL8ImCV4IXz
	0UfpGjfX8PA0hZsHy/FNRM3SDBmeofttBoxvE9V7yW8SEH97aygZb1bG+moC/i0yf5ZKpKr/h/k
	BrRIlHCCqloexR0osGt+CTqyAeX0XhpwWq6A==
X-Received: by 2002:a05:6214:29e9:b0:8ac:bae5:7477 with SMTP id 6a1803df08f44-8b0280eddd8mr621743506d6.26.1777214325676;
        Sun, 26 Apr 2026 07:38:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97347sm235584206d6.41.2026.04.26.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:44 -0700 (PDT)
Message-Id: <5ff48e0892ad0e2c04ed61bafe3178886c267c64.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:32 +0000
Subject: [PATCH v2 4/8] t1305: use `--git-dir=.` for bare repo in include
 cycle test
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Earlier tests in t1305 overwrite `$HOME/.gitconfig` with their own
content as part of testing config includes. This clobbers the
`safe.bareRepository=all` entry that test-lib.sh writes when
`WITH_BREAKING_CHANGES` is in effect, causing `git -C cycle config`
to fail with "not in a git directory" when it tries to access the
bare repository created by `git init --bare cycle`.

Use `--git-dir=.` to access the bare repo explicitly, avoiding the
dependency on global config for repository discovery.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6e51f892f3..f3892578e4 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -350,9 +350,9 @@ test_expect_success 'conditional include, onbranch, implicit /** for /' '
 
 test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
-	git -C cycle config include.path cycle &&
+	git -C cycle --git-dir=. config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
-	test_must_fail git -C cycle config --get-all test.value 2>stderr &&
+	test_must_fail git -C cycle --git-dir=. config --get-all test.value 2>stderr &&
 	grep "exceeded maximum include depth" stderr
 '
 
-- 
gitgitgadget

