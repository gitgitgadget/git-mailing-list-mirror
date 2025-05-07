Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD241C72
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579327; cv=none; b=sajBFveyoSjzZaFcrmq7k9hAjzuqtlOQJFRR7TGVYtpZ0P72Lq+QToHNfUEOruoRTDsQaZdex/lKMSnIogsh45fJQlzkMrEfAQAkwxyxlFNmRkGPPJYMD9+5dfGay8JOExxpMtvP3q/+wJIuMs2Op80RXF6DDz+zKYWoyt2vezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579327; c=relaxed/simple;
	bh=jQl8SOTl7lej9Q65fNdcJ62sn/5mDz14vuLSGSoRL3c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gm0PJGPZYs5aFmgXKKx2a7iQIeREw/Vl9yStvb03v2xM8IeHuV4s+KoRCLFg4wMwldMOMMf200NHaRD6FmYPjLM+7vCI0pHAZeBwtaUqw4naHmxioU6ZoL+0IZcMVsMJaHeVyvy7rkCfOlbNvb0ctn0Pik4Ib7sKtxB9caUMP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQOE7O1r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQOE7O1r"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-440685d6afcso55383075e9.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579324; x=1747184124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTICe0W0xuuUYAxymVVybM16Y8GTSJwg2l5I+P8Yge4=;
        b=bQOE7O1rTRSEHLXulfO+2VuoZNnz/6k/B/wKcqACJUJWXuVTfnfHHSdmE5rMpmVzEq
         pKS56b7RDvWCv5KPnx/ZFvIJGASM5utR9LuOanQgRGFWYor/bFH9UeY2ENk3zFfRE/44
         8auWIv1G8CLpMMwHEgpgyav55+PI3jFF8HVyFeImhQ9zTx9BQcKx/TdEZ2bUsyKGNEc5
         Jx/19Mm4wEpnY/MJ9sewhoywhKU6xR3+YfrFiTvNa6rMNdQrsk3onTiK6/DEw5Yp/Hc4
         DEBJlKgJaAKnsBsCPZRgycYlzwA4OKCeiSQTcWvK/WT/xKIaVD21OC7pnLjANuUrpe7h
         /6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579324; x=1747184124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTICe0W0xuuUYAxymVVybM16Y8GTSJwg2l5I+P8Yge4=;
        b=Up3K1BH+gnz52o66SWFvWuI3MByNpQQ3V1WFG+bCVlUqNdhuT3ItGR6WZ1J2XXuMqc
         RPKiw3vmMyH+7OvueMi5pJY+rJVZmSD5L5+UAWzYEZb6pDWw+yMWB4ZL89Q/asi1yG/R
         XPBNClzuHgQnCJS37jwh6vaUt311gMKDQL3EoGn4xmZ1UDPcZv9PcbYWIt/rnqjmJlos
         uhpyhQu14WhvO92ulLsZFsMlYKNXxC9FROuB/fKc2T/cnZ5RhrRuSPKqbZF7enlJ+vJb
         j6+rqWiF1/Fj3h1iraxQB8pZET9fBqnUusz8IkKERTZHy5gVof+AyRyF5KyDJvFDVFBH
         7Nkw==
X-Gm-Message-State: AOJu0YwLMPO8Fn6EiFGncYs4AaZO1rsFFQabvfrQ8U0jn0y11tOdanb+
	ZczwFuqThpjmSNO1EqZKPDjnJVlV75BPaZPZjztOdJF3ur52Oqk8wPmyOg==
X-Gm-Gg: ASbGnctWW3hLCj3CZSy+aQeKZgo2r4skS3XpVcH7qHmWAXlGzMSNR6+xN5M3hQS7fuw
	9hWrojwz5cyVJPjRi/5JRC+BPJrHMTb+ovOBePxTP/geCgL5LCF7MrfTQixtYCEZqsxPSuBjl+i
	XYKIBD6FTFaWEca/EDmqLuUYeSi8fE6pVKoDlNQ5qEXEHzWaOn5YNpfWPcrWLwQFk6XZgCA5uic
	/MF62tRMsxNjhJFK1SQVdffqyqbzR1w+u5nGpYIDaZ6p9464zJy7TfUaE40prrkz8e1kSqldmGI
	tRMBgvKenRrzrmpgGBycZ+Hk8I/4dcIkkAUb6sAhbbwKLayTOje8
X-Google-Smtp-Source: AGHT+IFJwx7YIPuyjpjICNChSSPD4ecuQCgey3VzPbwYPOPjyWs+hS7NVtccwXfmTCRqEWyIkqNAsg==
X-Received: by 2002:a05:600c:c0c3:10b0:43c:f3e4:d6f7 with SMTP id 5b1f17b1804b1-441d47e1ab5mr5037415e9.31.1746579323410;
        Tue, 06 May 2025 17:55:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43a7471sm11450005e9.35.2025.05.06.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:55:22 -0700 (PDT)
Message-Id: <63caae876343faa9609516b0797fd9ff19f7a881.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 00:55:19 +0000
Subject: [PATCH 2/3] git add: make -p/-i aware of sparse index
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
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

It is slow to expand a sparse index in-memory due to parsing of trees.
We aim to minimize that performance cost when possible. 'git add -p'
uses 'git apply' child processes to modify the index, but still there
are some expansions that occur.

It turns out that control flows out of cmd_add() in the interactive
cases before the lines that confirm that the builtin is integrated with
the sparse index. We need to move that earlier to ensure it prevents a
full index expansion on read.

Add more test cases that confirm that these interactive add options work
with the sparse index. One interesting aspect here is that the '-i'
option avoids expanding the sparse index when a sparse directory exists
on disk while the '-p' option does hit the ensure_full_index() method.
This leaves some room for improvement, but this case should be atypical
as users should remain within their sparse-checkout.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/add.c                            |  7 +--
 t/t1092-sparse-checkout-compatibility.sh | 56 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 747511b68bc3..7c292ffdc6c2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,6 +390,10 @@ int cmd_add(int argc,
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
+
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive) {
@@ -426,9 +430,6 @@ int cmd_add(int argc,
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
-
 	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ab8bd371eff3..0dc5dd27184d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -384,6 +384,38 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'git add -p' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Does not expand when edits are within sparse checkout.
+	run_on_all ../edit-contents deep/a &&
+	run_on_all ../edit-contents deep/deeper1/a &&
+
+	test_write_lines y n >in &&
+	run_on_all git add -p <in &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git reset &&
+
+	test_write_lines u 1 "" q >in &&
+	run_on_all git add -i <in &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git reset --hard &&
+
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/a &&
+	test_write_lines y n y >in &&
+	run_on_all git add -p <in &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git reset &&
+	test_write_lines u 2 3 "" q >in &&
+	run_on_all git add -i <in &&
+	test_sparse_match git status --porcelain=v2
+'
+
 test_expect_success 'deep changes during checkout' '
 	init_repos &&
 
@@ -2391,6 +2423,30 @@ test_expect_success 'sparse-index is not expanded: git apply' '
 	ensure_not_expanded apply --cached ../patch-outside
 '
 
+test_expect_success 'sparse-index is not expanded: git add -p' '
+	init_repos &&
+
+	# Does not expand when edits are within sparse checkout.
+	echo "new content" >sparse-index/deep/a &&
+	echo "new content" >sparse-index/deep/deeper1/a &&
+	test_write_lines y n >in &&
+	ensure_not_expanded add -p <in &&
+	git -C sparse-index reset &&
+	ensure_not_expanded add -i <in &&
+
+	mkdir -p sparse-index/folder1 &&
+	echo "new content" >sparse-index/folder1/a &&
+
+	# -p does expand when edits are outside sparse checkout.
+	test_write_lines y n y >in &&
+	ensure_expanded add -p <in &&
+
+	# but -i does not expand.
+	git -C sparse-index reset &&
+	test_write_lines u 2 3 "" q >in &&
+	ensure_not_expanded add -i <in
+'
+
 test_expect_success 'advice.sparseIndexExpanded' '
 	init_repos &&
 
-- 
gitgitgadget

