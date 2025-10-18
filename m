Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AD27F016
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818045; cv=none; b=nEJw0zgDPSh23TvU4d7bCeUQm11OfEY5vxyqbrcmYEAILCq7MYm1P0DrO9lrLEYpyvck3WsPv1G6Or9oJSlUiUhcLACRK8ae42vMyM4lTt3qe5dfOppFKfK/ut/+gJBMb0AoHo8W2cYl0/fuHWu5viFzSO4VAc0Sjrdt5MOetOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818045; c=relaxed/simple;
	bh=XMKEBzuPxgKt060TDmCL/IA5h3jbg0yrdY614GyIS/4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MPlbpdfRroT1yYm5nYWvBl3ErcPBWKZ8qQnaYhfUU260dOUxXZtrznH7c008ae+BR5o01ZXR5Ni5FNLPRg5u78M+AXbpo5KPs16+6MB5Baiov0PJ1uyqiKLP3sFAWvB/q8vBPJ8zFgbwjriFTwGEGWcgbqo8qrbvo/Vp4QeXBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeEIT4qN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeEIT4qN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2845234b3a.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818042; x=1761422842; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bzMzcvhLLx2/cdCoAmDcsWdYR6s+Jl6eSgf9gQn8LY=;
        b=SeEIT4qNH6Qz+BNQz51KjD6lJLiaI9hNUkIa1+gAuLOfp0cuiFAOmzeTAa24XHniQ1
         wjDWMhhbcUgdorQ8l2jjJG+ffaGFWB7pANCeCxaygjc6Mq+VRStSDg/FcAG2VAi0zfqK
         A1c3iRDEJMhZoDrvPGDE2sJWJ++hfPnhwXvnQ28tuSmZOI11s0mdhqln/ErVdnu20bD9
         Es8cWvCATQ6+/NI60jThnyjh8SvD5jRuv6NBZIP+OK2yCqT6VkQrDoSzN8slKvva8QIG
         VOLguv9GRlK5C3gV8jeumKbYFU23lXgS6m9aYlC4dfkAJPt6S2o1gvs9ZCN9wRjaZeRv
         QZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818042; x=1761422842;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bzMzcvhLLx2/cdCoAmDcsWdYR6s+Jl6eSgf9gQn8LY=;
        b=NR1qjofK63y3xi73CflU0T8kCRPNOiNr//sc+NRGcxNuZnTUwoajq4425RIMA34wdQ
         psl0jhaw3RmzGuxtUxZBcFWH4UsVyB99zyzufc4eEPIWYJPlp3rWKYbIoSNrlU0Ck4Qh
         33CiVfea/GjHxREvTDYvxTs2pJ5eNq+kwFjvmMGUK7xEDi9w8R/UfsV4vBemN7tgt9W2
         0hpFB7Qt3Gphc4rP+RvZpkZ2Omz8ytB3wbqK+nsPicV35NJ0jWqPpInZdm9AF50h7zfM
         AlNc8O5t+JOhbA/WGlaMVnAAbNCjBHFO4Qzfbbsxej0lBwYRoKmCyUF6ZsaCfyyFTe6Z
         aGcw==
X-Gm-Message-State: AOJu0YxCq1eGtOmy8QJaJfQe+P4Oy+RxDycBefOLXBwhmbzm3Y+K8oN1
	nH31MvTCQHlf0zTr5uZwJ/N47Wkgk8dr9im4K4L+TJKcbUxO7jBkCGXpwioBYw==
X-Gm-Gg: ASbGncvIitH876UERmHr9+st6SSNV1GV8J23TcWNVL2TnT8H31ifqrI3+9wmZ5qLCha
	D7acvqlt0wZNTZMV+vP+KS2kNvA00fP9u3hwXImV+QUX0ovFfOCyV3nhm9Gi9SdUK8r8NpGyYl3
	KCpJ4Q2Ss58ibkfGb/BHbrrg1Ox8E1lvYMxL11R9IAtjhSMhKMnVjrmMqPc2hjTR/QyvscNEMVq
	WObNvr7hoWBjqQk+Di5hhPI/AgdNsdYNetjQeP1QPuR3zLP5RnFPL1Wat1qrBhzf0IO24bGphMJ
	qNpTDqPQn8LDybPb/PMrmQenSMI7hGpYm8WtP/Yl8JdmEqEbrZ7I72Gjv2AVWmBteZxUeQasR8N
	BHbKgkSt58LHRDN0RNC5QzbZemoweGhUktTC55/MkTLciZAVWOR2m9Ghd16ItBB2MTZQEuHfIwh
	toOQA=
X-Google-Smtp-Source: AGHT+IEUbM53L1kj9WSbeebFystjiF27qbBs+KhvduYS3hPxBsY1LUQedTRUpnnMl2G13BlZ7freHw==
X-Received: by 2002:a05:6a21:33a1:b0:249:ba7b:e361 with SMTP id adf61e73a8af0-334a8614258mr10414286637.49.1760818042008;
        Sat, 18 Oct 2025 13:07:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6ba0c83901sm253657a12.1.2025.10.18.13.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:21 -0700 (PDT)
Message-Id: <d98cca698ddb376831c0657eab2c488f9e7585bc.1760818039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:15 +0000
Subject: [PATCH 1/5] read-cache: update add_files_to_cache to take param
 ignored_too(--force)
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The ignored_too parameter is added to the function add_files_to_cache for
usage of explicit updating the index for the updated submodule using the
explicit patchspec to the submodule.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 builtin/add.c      | 2 +-
 builtin/checkout.c | 2 +-
 builtin/commit.c   | 2 +-
 read-cache-ll.h    | 2 +-
 read-cache.c       | 8 +++++++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0235854f80..cd1116e70a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -582,7 +582,7 @@ int cmd_add(int argc,
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
-						  include_sparse, flags);
+						  include_sparse, flags, ignored_too);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
 	    report_path_error(ps_matched, &pathspec))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..b2a404051d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,7 +899,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					   0);
+					   0, 0 );
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index b5b9608813..5bf7ae5fc1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -455,7 +455,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, ps_matched, 0, 0);
+				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
 			exit(128);
 
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..2c8b4b21b1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -481,7 +481,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags);
+		       int include_sparse, int flags, int ignored_too );
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index 06ad74db22..56a3ef424c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3880,9 +3880,12 @@ void overlay_tree_on_index(struct index_state *istate,
 
 struct update_callback_data {
 	struct index_state *index;
+	struct repository *repo;
+	struct pathspec *pathspec;
 	int include_sparse;
 	int flags;
 	int add_errors;
+	int ignored_too;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3945,7 +3948,7 @@ static void update_callback(struct diff_queue_struct *q,
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags)
+		       int include_sparse, int flags, int ignored_too )
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3954,6 +3957,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.repo = repo;
+	data.ignored_too = ignored_too;
+	data.pathspec = (struct pathspec *)pathspec;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-- 
gitgitgadget

