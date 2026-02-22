Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B723BF83
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771784941; cv=none; b=Eimi7YmpT2lZJbgBh4pHO4Xgnavi3EC8xfO1oWmoOXLIM/WcLKzhgTeyIc9A4Ug/8ONEcJVICsx585U5P38OEkBmUVybBgorWq9a/2nh1ig4mIziGgRTUsaiKDDoBwKCtt3n/dc1u7ktuhTpIrqoDd0Wng0Wt81UpDB+Heh31rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771784941; c=relaxed/simple;
	bh=xgT9M3+JKpAb9yfDX1cgCZ39FI1srZZ/PzqVOgG9U0U=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RvE+FbX06NnDxmCy2hY64r8VCWzUXLZDdW/qYSoVezp4goWmDF2tToLT5g3qB/RBFitkwBczfiOoBUQiQsyGUO2CYL9qDvaTcSw4phT7TVsOF6OdrpKBpKslHHfKJNgtTqzW6/GxXHGIOkiAsbQBnCsIgNkZ/R+61kNULHaVJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqT41iEe; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqT41iEe"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso3575943eec.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771784939; x=1772389739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KP6mtzr0BEkkssQ6cQAy0Sf/i30Ub0gvDzy4cUndnEc=;
        b=FqT41iEewGTqSfH74qZogGTk1JCR/ZUx1Zz2sL1gSHeuUQsAkpWa3IjyCpPV99baiA
         nTtsiwbAmpuwfIpItH6h7VMH0zmparxmOUmn95Uinm8OS2BeEQmCjwU4YlLuzcdA5uPs
         8s10+Wtqi/ZxYc6o/jo/PC+eOrAmSwfqGeJJBD/HIN2LVrrWj5fPOo3+brndd6qsbv53
         JnIAAXMJRo8WsG6azPVh8ho3YHM+EhvoqMT2SWEf5e8lwBXxqAccztx/fx5JTC5QviUF
         /yeP3hzQwkttDCj+xYqkz9+hdFaW1OR8tNe+L2ONvFl9DMnZjTxrzyShbrdiiBKqs/cr
         9hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771784939; x=1772389739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP6mtzr0BEkkssQ6cQAy0Sf/i30Ub0gvDzy4cUndnEc=;
        b=JjXTvi+ziPBvjIvkk0WPCstj3YG1EybOv/YqAg8nrLfywZTU943a5QseBkhxyXHhm+
         xl9vjvYI5YDefWNU/+3Uk4BKPAsKYpCwOo4W4TczxGmC8rUGkosnSQNLBC7yws6cnsZX
         m6vTpCGsDEspThE0N0jQrVfUtATZFv5DxLcU7Sz5JSSbbgvo3nTQ1dwHehZZRmWRQC84
         3X8XRH1WXmHqg+Z3XClltkkY0jCv8uxaXSL3N+SArvtAzNhQf5WEDlx28K2QcEQQ6slb
         3UX9c1+xsa6Ba2aoZZEwmncnXIqzGXQwBqT6kggrT3bwraRm6SlzouyPW+Hv0kDR4fK/
         nIyA==
X-Gm-Message-State: AOJu0YzhsQ/nDB8Ie0+qNqtcPg/xqnF5jgbRR5zK5Cph2bg6pJkN/MQG
	RLHAE9CZi/yZtW/1+H+SdCUqfWvrLwoXfPtMhFuoaI6+xAuVidpsnaXgcIcDoA==
X-Gm-Gg: AZuq6aKAG5+EHLm3Zd6JTtM1AuwtW18BHBXkAprhewtoUbr3lw6Px/EW3FxQLF+8G4Y
	EPHw4aqkvAvYn+mLnnon6f+ghnD6EnhE/zmWn8zE4pZ3gLf6LnFS0kPkh4vOyba+ws22z7SQ5uF
	KI1nE8PIjx/wZg2g8PbATH6kQ34He0SK7Pyds9bKKv61+brB8DZ1RcgYigjgN3tjPoDQWo2toRS
	+BxKnMu1uRgjkTTckZWt2hrxbiaAaPUPBtprjPXW/StJyYSs9m9GfpdV1tEXmFmE5klEQWoOAlS
	ISNE3xJPTpc31EQzyRUXOa8HgYcpmTNTXU7MZ5SzDEWZpMmvpCty+aX2gvfFGBfVkXvTwtVbizH
	Gkry3WLpBaMKdjLcb0PwucaQkiK2sUyInwW5doaCoBp/GfSg05ttxksd6tvKEgboPL08r6isqqF
	ZfpKYJJg3tNg0w/SiqwUoziWXE
X-Received: by 2002:a05:693c:310b:b0:2b7:1abc:a6e9 with SMTP id 5a478bee46e88-2bd7bc648a5mr2387968eec.12.1771784938745;
        Sun, 22 Feb 2026 10:28:58 -0800 (PST)
Received: from [127.0.0.1] ([20.171.51.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa3701sm3374725eec.10.2026.02.22.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 10:28:57 -0800 (PST)
Message-Id: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 18:28:53 +0000
Subject: [PATCH 0/3] repo: extend info path reporting and structure statistics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>

This series improves git repo info and git repo structure.

For git repo info, it:

 * removes reliance on global repository state in this command path
 * supports category keys (e.g. layout, path)
 * adds rev-parse-like path keys and git-path-derived keys
 * adds --path-format=(absolute|relative) for path output control

For git repo structure, it adds deeper repository metrics inspired by
git-sizer:

 * max inflated and max disk size per object type
 * max commit parent count
 * max tree entry count
 * max blob path length/depth
 * max annotated tag chain depth
 * aggregate keyvalue/nul totals and maxima

Tests and docs are updated accordingly.

Validation:

 * t/t1900-repo.sh
 * t/t1901-repo-structure.sh
 * full make -j4 test in Docker (failed 0)

Eslam reda ragheb (2):
  t1900,t1901: make repo tests hash-agnostic and wc-portable
  t1900,t1901: fix test portability issues

eslam-reda-div (1):
  repo: extend info paths and structure statistics

 Documentation/git-repo.adoc |  67 ++++-
 builtin/repo.c              | 525 ++++++++++++++++++++++++++++++++++--
 t/t1900-repo.sh             | 196 ++++++++++++++
 t/t1901-repo-structure.sh   | 250 ++++++++++++-----
 4 files changed, 948 insertions(+), 90 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v1
Pull-Request: https://github.com/git/git/pull/2208
-- 
gitgitgadget
