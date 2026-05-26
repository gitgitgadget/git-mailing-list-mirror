Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C783AB490
	for <git@vger.kernel.org>; Tue, 26 May 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827202; cv=none; b=ICbA3Sxb6SxIA5/6NguHU1luKhcgT5mDtv6fGi5rmhnHo1jvsN34jiYGiEUhouIi8e6mTLEsibn8qf2NWgQVI+Ot/HVd5PWyDjpZ+z9UJugYor8AkymABZuq5NDyWDaYWPzR/moAiZhDQrkg9LEWaTi3WABBhGO0upQWrdLJsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827202; c=relaxed/simple;
	bh=WgCb9TqGEaq1v1mdPxPZE5YgcOr+JEbj2KrDzeP2QKQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hrILUCYINS4P7FSv5pEMKNdCrHUofsjvuhTHcgsN/O8PlYLZE/CfYAeUK9QgVF13HVDhY1M6pZZsWcZy2BuA98D9gDwDMIq7oF0vxRmNrqSelq1qywRWHlyBW6ndHPlz8fj7L2mn8w2VNUjhDso3syy3BG0B2YOsbfDcevrJiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyF7a5yx; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyF7a5yx"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304997cdb21so2812874eec.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827199; x=1780431999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Uo+S3PAQ/dEQGUjRC3llZg34KLay6rQRqrj8FD8aU=;
        b=SyF7a5yx5DmrVwEniPVw4TcbuCe/T2PPGovQqBYchSkXVV48fyUd3h0bcY1Eynoqp3
         IFwIIJz2w6T6z1U1Xu4BbcdQ+013/SpXwHEs3xudTUFy2Hozyr6sfl38R/I5mNVohG1r
         ojgYnwZDtjko2tL1l4FbNXs9c22u7ppE/GVjMZZRhoh1+j7wG3L4rtOQW0d0ns8X55xU
         ezvWuX9+hHiwdEw5jLDGPMnqSTmKYsHVG8juAh+OHGA+BjVjzD1KfkS8hO9saVb3PZX4
         UGS3pwVLQM8/U4VnnR2LnSj01Iyz/IOJgC5bEpMrqccY+ub7Nwaabu9LSEQUhN6wg64V
         CC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827199; x=1780431999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g0Uo+S3PAQ/dEQGUjRC3llZg34KLay6rQRqrj8FD8aU=;
        b=HTxZSnKH1ERKUmlquIebUC+ZI2uL4scuOk0s9jqU+27C8WKL4GKbfX5RXgNQ/sUTk4
         4VPiHn/HibcmcIoAHL45lbI0XRXx0q8rbEp0CtjTuLGWA9xYs03lzfsmwD0i6Y4BQ1fX
         pWXgsVuQxxDqccOuNd9kHPGhQaRA3jGkda69E6tNO7JPOYg0pHhVwIvFQt5Bgmcdjl8+
         HZTu2m4M3gW+Y6EmgsNEOun4eIIJgqwNv14MUw9zkGL3Y9bTsDMlkSgeISq3HhpSew0J
         NGc7Y/BjBYcidxH1WmjCB159OaVcGfri2g21p8IEnNN9Q+Qom8xBRmODnFYOTr10xrkr
         CVnA==
X-Gm-Message-State: AOJu0YyyLR52koR2IFzXPtcjL69G39PIG/Smve81s/RWu7gV8/2b/1K8
	xUT6gXl6otmvxS+kuf2DEbNLcU0KabrJE9uVUeBlJhChhoX4yYnrUMT7qvxfMQ==
X-Gm-Gg: Acq92OEzQDbTeEN0JWXnrDfkLfK+0+Omh9MHgfEap2cu4kdAynm0vxUPhowJAS4WfBY
	GWv9pWs8wf+vCktBUWHDSeTseo+QP7I5qAyBFpGfuogODGAXvw6q19tRzHmk03by+2pxtSjNDzL
	0/FoMmRsvUMeHTEhtA0AMhxfFZbYvv8QtPOjqYQF6l55fWnWmbc7Kbds3cxm+wt5oxjjnX6UoYX
	Il4NpbG/KoHTb7rTD1nqEWS+h7F7DnhYFEL9hBZzRKXqMtEJa2NFcLREirORs2rwQ9oa8Wd59NY
	qNn1r9NyibbgRLcfF2ol9ZDncGp39rDtthbuXMcZWZA2iVAgznb03VqRxkey+PGBoEKdwIsuRpB
	HcLU59whAyN311VAvRbVeTLjIbLLB5woiMpJGxlmhgGMU3hJHloC2cFE4rYjRVFzx032LGfFIyw
	HideGQwlN49SiaUL9LNkhx/kdXSJMsG5AmO9FaYfp8KU9PAPg7
X-Received: by 2002:a05:7300:8ca7:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-304491d4ab4mr8753555eec.26.1779827198809;
        Tue, 26 May 2026 13:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef5492sm10970287eec.6.2026.05.26.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:26:38 -0700 (PDT)
Message-Id: <7c56d038307d54929d9eaa9b8cb3cf26af181702.1779827195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
	<pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 20:26:33 +0000
Subject: [PATCH v2 1/2] t1092: test 'git restore' with sparse index
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

A user reported that 'git restore --staged .' causes the sparse index to
expand. This is somewhat natural because the '.' pathspec means 'check
every path'. However, the restore will not update paths marked with the
SKIP_WORKTREE bit, so we shouldn't need to process such entries.

For now, establish the current behavior, including the sparse index
expansion, in the t1092 test case as a baseline.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d98cb4ac11..d69434e7ab 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2573,4 +2573,54 @@ test_expect_success 'sparse-index is not expanded: merge-ours' '
 	ensure_not_expanded merge -s ours merge-right
 '
 
+test_expect_success 'restore --staged with sparse definition' '
+	init_repos &&
+
+	# Stage changes within the sparse definition
+	test_all_match git checkout -b restore-staged-1 base &&
+	test_all_match git reset --soft update-deep &&
+	test_all_match git restore --staged . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git diff --cached
+'
+
+test_expect_success 'restore --staged with outside sparse definition' '
+	init_repos &&
+
+	# Stage changes that include paths outside the sparse definition.
+	# Although the working tree differs between full and sparse checkouts
+	# after restore, the state of the index should be the same.
+	test_all_match git checkout -b restore-staged-2 base &&
+	test_all_match git reset --soft update-folder1 &&
+	test_sparse_match git restore --staged . &&
+	git -C full-checkout restore --staged . &&
+	test_all_match git ls-files -s -- folder1 &&
+	test_all_match git diff --cached -- folder1
+'
+
+test_expect_success 'restore --staged with wildcards' '
+	init_repos &&
+
+	test_all_match git checkout -b restore-staged-3 base &&
+	test_all_match git reset --soft update-deep &&
+	test_all_match git restore --staged "deep/*" &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git diff --cached
+'
+
+test_expect_success 'sparse-index is expanded: restore --staged' '
+	init_repos &&
+
+	git -C sparse-index checkout -b restore-staged-exp base &&
+	git -C sparse-index reset --soft update-folder1 &&
+	ensure_expanded restore --staged .
+'
+
+test_expect_success 'sparse-index is expanded: restore --source --staged' '
+	init_repos &&
+
+	git -C sparse-index checkout -b restore-source-staged base &&
+	ensure_expanded restore --source update-folder1 --staged .
+'
+
 test_done
-- 
gitgitgadget

