Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D4263F34
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567895; cv=none; b=doDRfy3DZNPDVCUOKcrOD0/gQla5Pm2Umr+WZFuEXyWOpYW2voIpJAIlNQe11+Uuj9WySIUnhGNwMbdA7QQT0aLJd2xVnBtVxRYMSdG2y91hkR9AumJpo09RW6kvjZAYbU+NRCzeUv4bj8+S5AjkgUrXrOe0VS0F82LyHXAMpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567895; c=relaxed/simple;
	bh=tv3/5ptxl680gFuC/vSHaEMi0juc0X3/Y8dn8mCyFng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GW2PROnGlF/MhPDp0gdAB5DI0aZ8TDyFRJVb9AwBc6h/hsheBmclGhNOG3/sTxchU/2iAY21rnhlMwCjMnE+7J/CuWlfBJnbxYheDLxkgLU2E8fbFFywNMy73ieut0Mj/2fcwzHhwyll2L3GI4jGr92HuKhVFE8iLksvuKOtZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAoF08BA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAoF08BA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso1518221a91.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773567893; x=1774172693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLtrPn/BO1yVpPMzOJy4QNhUR7Jd/DyCeJEcgUuPeuA=;
        b=iAoF08BAFhOcTITvadTOIgbrFYtq7plErESCTygR6NLU+4ai/HltArtmC2iACg32Ir
         KPyR9clspesq75xSJB3AEvGT8NMX7LHqu7wG3wJ5ZgRziP6PyCTR3F7DjnFK2RTALj4m
         PFAACPqukjBi0wqevbGCGOlhGN81OoweZ2wAW8j2snVPI06hdIyRrIdkuijGRH3FII/x
         LK3SfX90qJpcC6iz9RMYD3SrdQvqAmBnZShuX1VaALXQ5gMNgh4shRSubEzBz/G2+jrn
         qPQ8sTcqOoAPLKHeIQUmQBRT4MgIjTR6DeklvtbAk+sWe49f01zV2MohisshewwQV0jv
         Ul8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773567893; x=1774172693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLtrPn/BO1yVpPMzOJy4QNhUR7Jd/DyCeJEcgUuPeuA=;
        b=n+0fPDfo2FIUaTTi3jJxRYkYhnQkVaswVOR/8ov1465TuUURWuIQsejvOo5xyExqWG
         FHsA3FrMB781FYL5qQqhA32N2EdxIB22omKcSWos+695ayyqdti6VVmojFMe/3CZoYA8
         wGvkh/biQM7eQWlda7pbb2iXp217/Lo3VUfqI3poPdj0KIPZjtwTTE+Gj5cl5DXNUnba
         Gm8Cd1TNPMnq06egdsxYpMKdJrVurdkFgrgTV1EZz8tFUh5V6WaSdk/nHD+C34C4cUHd
         KUaqizpAweMfvbFScNoS/Nlx9K0H7oTcyHCPdyoAfWOFaoGXxenXoKbDEBpuQbAB8PjU
         6cWA==
X-Gm-Message-State: AOJu0YxJTH4Bg8tW5xoMXibetJL5qdSMXYp4o/y2PewTsnsBvngZYoSP
	dItbZOQP6qKgc+9cXjf+FsD3+kEy/NNeQjD7Kb9q20Sj6Yhx3Az3sFWb7PMPNA==
X-Gm-Gg: ATEYQzxYmP8fpc9mJIfv5GZODDlS+3Jk7wQUJPrU/UninXM9ARKj2Z9GsFbWOVGEdPX
	PwOO6dQ2AM52P52yx94N0fq+nN6wPihnMQ4gczuKY9kkQP6YgIeLQ/PuEmB5CoAVRYMpXOcmz+6
	174iVqGj0+xLSZ/TCLrSuyNBc7FmSotYqBvXsqxwwK6nX7hQ3awokIRR34EdVqllmBtqXu3/VOa
	RlRClaLb8QtAld5LX2xyfjJUOQuRyC4wA2axMUIgX/7Sql+2QYMdPkw7itdjfLvq7284nA4tC3i
	3ewcNhBd+3w8WF526SNkdkehX59j0pJiAnSLGInS86JuiYggWb/J+Pyk0ZVKLmOWqBNqjyzLZpz
	xAEnO4ukRqYsaWfjmKSdb+U67PmmFnha/f/WjLGBaRzZIGa7m9YcTy2YNxuIt5GgRN6zi+3U17n
	9ixBC4kYadDZZCLMW2qKfBvApNJvmy05p/sGEhtk30Iwb8Vt4=
X-Received: by 2002:a17:90b:2687:b0:35b:9ab6:1d51 with SMTP id 98e67ed59e1d1-35b9ab61f3emr596860a91.24.1773567893026;
        Sun, 15 Mar 2026 02:44:53 -0700 (PDT)
Received: from d ([106.207.231.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a229e7f9asm3413596a91.0.2026.03.15.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 02:44:52 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 0/2] coccinelle: detect and fix strbuf-by-value parameters
Date: Sun, 15 Mar 2026 09:44:42 +0000
Message-ID: <20260315094445.19849-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing the write_worktree_linking_files() fix [1], Jeff King
suggested adding a coccinelle rule to detect functions that take
struct strbuf by value.  I previously posted an RFC discussing such a rule
and its implementation [2].

Patch 1/2 adds a coccinelle rule to detect functions that take
struct strbuf by value and rewrites the parameter to a pointer
to highlight the issue.

Patch 2/2 fixes the one remaining instance found by the rule in
stash.c by changing the parameter to struct strbuf * and
updating the caller accordingly.

The worktree.c instance that motivated the rule is already fixed
by [1], so only the stash.c case remains.

[1] https://lore.kernel.org/git/20260309192600.GC309867@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/CAG7UgESKLMnO_4+PSJUt-TXJxFQyxEEfpCmJfMmTw2+rhT-HWw@mail.gmail.com/

Deveshi Dwivedi (2):
  coccinelle: detect struct strbuf passed by value
  stash: do not pass strbuf by value

 builtin/stash.c                 |  6 +++---
 contrib/coccinelle/strbuf.cocci | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.52.0.230.gd8af7cadaa

