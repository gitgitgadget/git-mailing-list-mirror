Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B6125B9
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006682; cv=none; b=WPP4pPLLOqVYannNaUwUnZG0E8NrS66ZpEvvHLAoWdGk1go21k15BUJKcUCjAJEbtgpqHORgulzoGfeeEWq+il72r8vKGd7TK23fWLGshKs94jR18vosK+f/SjpYrjUwCx0Mx9BaOAWvDlwsPmgiKCiCkZN/YVTw6sa+/JP+Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006682; c=relaxed/simple;
	bh=c1ysInGluMQSvshwt5clWalgzcU5X8RkBfHEkgthMY4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O3ZeA00ArEVUIyVzCmLMH9jB+51pqruJpdFC9iT1Uo+JTrG56jmYZpO8RW+CClkrQ06/L4rPLSPHuKZxWz5hAYFwLK0EGlkYa3cod3gPBswtoYo9DRhBRNqWBmTmwuYERZO0az7SeGY3bsmcbDxndvf6GEXwM4u/gRgRzdgH7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m44g/oA0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m44g/oA0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450d37d4699so31257335e9.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006677; x=1749611477; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJpsr5XTa15OVqNPrnGGZpZfUtB4g6n6nq+oXO3ERGE=;
        b=m44g/oA0/SUGqP/jfna/vNqlzlCO92aWCQZPXqPmQjq2krhuP/v0m6Mwcd1IdXMXJ6
         gheOZBTMWnLeUAw7oKEsNljC3CLB57qiJM+Xt6DxT8oKd0XY9/Vb5kyxy9mX243Ibyg6
         WrvKHVTx8WyYkFwVR9A50LI/hwhmJO0jxqYZtJ/8K0809ULze4asCTbqwcECmEIFMu+X
         KeB6F5yI5f7tiaIe1h9J4NAxWBVKAxnHhd543mVuV2OdEE3rsV/6WlZSM3i6wzy4PtX0
         eRGMxiDRyTMTVUKv5yv/f2Wi621+Lzio8Kwa2389co8cDOlSas4YodM2fL5/9POj1ZBR
         3BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006677; x=1749611477;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJpsr5XTa15OVqNPrnGGZpZfUtB4g6n6nq+oXO3ERGE=;
        b=f3WhysD2eu8GRtwPEpIt0+qs34kvJQtlQqBeTlunty+7xavb5TEuKnNhGm+Gr0896r
         Rx7wmwTRZ3NyGaK0pYp7a3i6vy7xFpD7735c1wymrvA9FRkk672YZtUJvUORdumjBWI4
         bEiF07Ksa2ufTahoVVJv9NIuTA80xPkYXob6w0a2O91Bjsx8f5ul1XZTaijaqg23rEcD
         1nEB93/u3nBmm4XpORpVGit/YtWpTepk7dYKTl0Atw1CcplzUadGCfVr2d/vMBxUw+q/
         5DE0IMWUtdhwgb5IVCSeZZCAu8TZB+VQlYN8vOmzzwI3+SnN7UStH4OSrspNIp8Q2K/+
         BXiw==
X-Gm-Message-State: AOJu0YyAQtF4pvAGEGuQsk+R90xpj+JoQfsjWx1PKk7DproqknRG99fn
	oKK17jzLHHvqsMwCdOYmVrVlcbrBBjz29REFVt08b/wDk+TWLozLJjBnKEUWrw==
X-Gm-Gg: ASbGnctX/qjpFFEnpoYy9JSfdGUar0h30puzG+qi9btXNxqZWXf55sT5iAoW4R+X5D8
	b1N+0DjAVYcZQpauCXpMcvbBM4BQiYbjZdcUUnfY8NLw95JjYBXoPoSjPYF0sUmVMtUPcflFQhd
	fOcvBU3MpvC+76JlNl23nIXduuSy6tv+LRhapZiA8PrU57N0192mkbPtBPHEd+CHRLuuP93FMrF
	14nKJhpaqazpuTjAevztIp+ClBt28uoo2FT0IyxSgPNoibLsBdodtkZ2bvU84A9jsdfj3ye6XiE
	MjmMqeToqpofLi9ratE2AY3IueF/+ZdM93aQ93pLMYjoYtaodm8afsQweHFraMY=
X-Google-Smtp-Source: AGHT+IGklUVzXjJtfXXMdGEegdG/VY0AnWpMXzPJHk2BnZkLZfjf7YYT/ZS50sDyzV3gK1/7QABZrA==
X-Received: by 2002:a05:600c:8288:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-451f0f2fc9dmr8180895e9.10.1749006676747;
        Tue, 03 Jun 2025 20:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb86d2sm183914975e9.30.2025.06.03.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:11:16 -0700 (PDT)
Message-Id: <pull.1986.git.git.1749006675784.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 03:11:15 +0000
Subject: [PATCH] commit-graph: fix start_delayed_progress() leak
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In commit-graph.c:graph_write(), if read_one_commit() failed,
progress allocated in start_delayed_progress() will leak. Add
stop_progress() before goto cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    commit-graph: fix start_delayed_progress() leak
    
    In commit-graph.c:graph_write(), if read_one_commit() failed, progress
    allocated in start_delayed_progress() will leak. Add stop_progress()
    before goto cleanup.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1986%2Fbrandb97%2Ffix-graph-write-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1986/brandb97/fix-graph-write-leak-v1
Pull-Request: https://github.com/git/git/pull/1986

 builtin/commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a783a86e797..ee48980248f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -311,6 +311,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		while (strbuf_getline(&buf, stdin) != EOF) {
 			if (read_one_commit(&commits, progress, buf.buf)) {
 				result = 1;
+				stop_progress(&progress);
 				goto cleanup;
 			}
 		}

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
