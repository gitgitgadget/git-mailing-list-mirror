Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E133BA22C
	for <git@vger.kernel.org>; Tue, 26 May 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827201; cv=none; b=aZZXuKCX9RPd3IkdaUh+B2N/LGPL2n6tSrrlWQIV2Av2B2vqpeZ6FrJQYv2GHD2aqbu62FcXFiYK/gK97Vy4ceHAFcAmYUiLp9y29fj6SiImLWZ//DjUMAZLiQSIGLdc7HPmOmXgHTmjzZswHTGT7hMx4KYoJiL8mVjUlaIqKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827201; c=relaxed/simple;
	bh=irMZLekd+sotp4ki43LLoFUNPYnyNCCayWp14HnYJ7g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q0UxDxOHvDZJpYsX5wYzE+/Da3hS2ax1PIIhP1vLimbYGQMN/uupIcVgrxYyx1uhLp/GoCRmYpTGzhWwk29jdBV7IUsMd+SmSo6ytc7BXS4v57BHlS792lUMHzdXfJSJ9r7/4DDTry40X5K53MjQs+XLSD+RD86aOhRs+zIPk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOoQ18C; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOoQ18C"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1363fe80fe8so5431153c88.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827197; x=1780431997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csVKtt1GxE+iBKenMh3pofzAsABgZfcgCfo/LTAN40E=;
        b=LBOoQ18C5DAtkz9koZc2yQ3sqs1V78P3NJNWtxHwI1Cx63R+xWjjbYJn+Hw2jjQp9f
         zGnUvtuiSlWdn/vcmhwsM6vdl+pX5ornuRQ4dPQyjbg/boZz0HBFFXyyDzJF/XyZQF9a
         /DKaYOGD5SV+1ZIyCVKDzOxQDZBygYopyaqm0NxyQnESAItQiZ1XYk2Apdi8I/TWdgGT
         YNq6sVWpT+3IQCdY3teRlSGhxwI+torKsupD6CD1Ch3Cr/3BpwsAOfa2Zx0ENtPzuJJS
         4unpxWsf010Hf4DhLqoJDMZaC8hoCT6EMqiMWjp/qixO5ppGK/HgU0Pl5aKLXa3Nc9p5
         kPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827197; x=1780431997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csVKtt1GxE+iBKenMh3pofzAsABgZfcgCfo/LTAN40E=;
        b=p6fJ1fZhCcpAnj8dTN6Ftq+Z8ul40/wCaw7kiK4e/quYe90yKcPAwkSoWb5Olc2VVl
         YaNckoPK91Blx3bzVl8L0jJubHUVTFAIhaHVzpUtxKbiR6t4y6+qjODejOqzB2sLnqxq
         7wEKNQ83YNc8Kx5JJO/5ihdEoqO+jULLpzEjrPEXa0uPbknl0OAWUVAHn9xE0bCL/r/s
         UfaF780uTHD0kdZpY2x6FdEQUACKCeb0C4Ct5Of0KzVm9SDdjeJesKfnfHFNUIzZ0+VH
         kxFgIFU7Na7PxyfXUpS4gtMgAfzU2DHT+8G/53kb3I7KxV/PGTmEMfyCpa36+syOzL/T
         //Vg==
X-Gm-Message-State: AOJu0YycTEol+Iqt2jHuTEM6pV1qMqDNL68oBxyIOTfHZeHSfh9zfNck
	+INM50S/CsnncysxM3VDDHlgmmK+3TYtJVhTO43oY4fpwpNOr0Ke35RzSuzJPg==
X-Gm-Gg: Acq92OGFTrm8mY3MakQiXmLJ9QXnyhRxy4KoOwmo3TE+T4szmo4gmtqCT1UKhy+6XU0
	AHFcbYldlP5BKEINdTZac06YHW80zzdH92Kq344ij0hAp50AHn+YXrj1i8QDXXn5dAZKLIE+BMZ
	L/2kI/5lR2xR3KPDpvfcVwvNWJYEtyKl/FbUeo4So70J+v5BueBvGOyDcBxsK1K6UyWFJXNg0EQ
	WWiR6/Zw7/63BCz9HeazJn0O+yq2DdlpZMVwN6t9O55z0haNkx8l2CEdiRz+5vZT9Smb4eDDyKS
	/BH045qNASjp9coLJX4jE6qobNUNwddHxiK1aBCUPvTuecIfoikPeL/LAtko2H36szTM4X/Q3oE
	LrvnMag8yPpX0Hg2kSvb/oqKZq61yKJxCxnuLHu7cuxsjeaaEjdhO15AeDslW75dLwIFLKnfJPz
	7Ch4zJ0VuVTV1kReiXaahLLztNYr53Z3TAa8k3sA==
X-Received: by 2002:a05:7022:4a4:b0:12d:ca32:59f with SMTP id a92af1059eb24-1365f81890amr6899334c88.11.1779827197357;
        Tue, 26 May 2026 13:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40187fsm10692220c88.5.2026.05.26.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:26:36 -0700 (PDT)
Message-Id: <pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 20:26:32 +0000
Subject: [PATCH v2 0/2] restore: better integrate with sparse index
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
    Derrick Stolee <stolee@gmail.com>

There's still a long tail of situations where Git expands a sparse index
in-memory in order to operate on blob path entries instead of intelligently
handling trees. I was recently alerted to one such case with git restore
--staged -- ..

The basic idea here is that the pathspec . signals that all paths matter,
but what we want to do across those pathspecs will ignore the expanded blob
paths with the SKIP_WORKTREE bit, so we should avoid expanding the tree when
we can.

This series has two patches: first a test to demonstrate the baseline
behavior of git restore across different sparsity cases as well as
demonstrate that the index is currently expanded. The second patch includes
the fix and maintains the same end-to-end behavior with the only change
being the performance improvement from not expanding the sparse index.


Update in v2
============

The logic around handling a tree entry is extracted to a helper method,
making the diff easier to read.

Thanks, -Stolee

Derrick Stolee (2):
  t1092: test 'git restore' with sparse index
  restore: avoid sparse index expansion

 builtin/checkout.c                       | 65 +++++++++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh | 50 ++++++++++++++++++
 2 files changed, 109 insertions(+), 6 deletions(-)


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2121%2Fderrickstolee%2Frestore-sparse-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2121/derrickstolee/restore-sparse-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2121

Range-diff vs v1:

 1:  7c56d03830 = 1:  7c56d03830 t1092: test 'git restore' with sparse index
 2:  47542cbd42 ! 2:  88f5d26a33 restore: avoid sparse index expansion
     @@ builtin/checkout.c
       #include "submodule.h"
       #include "symlinks.h"
      @@ builtin/checkout.c: static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
     + 	return run_hooks_opt(the_repository, "post-checkout", &opt);
       }
       
     ++/*
     ++ * Handle a tree object and determine if we need to recurse into the
     ++ * tree (READ_TREE_RECURSIVE) or skip it (0).
     ++ */
     ++static int try_update_sparse_directory(const struct object_id *oid,
     ++				       struct strbuf *base,
     ++				       const char *pathname,
     ++				       int overlay_mode)
     ++{
     ++	struct strbuf dirpath = STRBUF_INIT;
     ++	struct cache_entry *old;
     ++	int pos, result = READ_TREE_RECURSIVE;
     ++
     ++	if (!the_repository->index->sparse_index)
     ++		return result;
     ++
     ++	strbuf_addbuf(&dirpath, base);
     ++	strbuf_addstr(&dirpath, pathname);
     ++	strbuf_addch(&dirpath, '/');
     ++
     ++	pos = index_name_pos_sparse(the_repository->index,
     ++				    dirpath.buf, dirpath.len);
     ++	if (pos < 0)
     ++		goto cleanup;
     ++
     ++	old = the_repository->index->cache[pos];
     ++	if (!S_ISSPARSEDIR(old->ce_mode))
     ++		goto cleanup;
     ++
     ++	if (oideq(oid, &old->oid)) {
     ++		/* Tree content already matches; no need to descend. */
     ++		result = 0;
     ++	} else if (!overlay_mode) {
     ++		/*
     ++		 * In non-overlay mode (e.g., restore --staged), replace the
     ++		 * sparse directory OID directly since files not present in
     ++		 * the source tree should be removed anyway.
     ++		 */
     ++		oidcpy(&old->oid, oid);
     ++		old->ce_flags |= CE_UPDATE;
     ++		result = 0;
     ++	}
     ++
     ++cleanup:
     ++	strbuf_release(&dirpath);
     ++	return result;
     ++}
     ++
       static int update_some(const struct object_id *oid, struct strbuf *base,
      -		       const char *pathname, unsigned mode, void *context UNUSED)
      +		       const char *pathname, unsigned mode, void *context)
     @@ builtin/checkout.c: static int post_checkout_hook(struct commit *old_commit, str
       	int pos;
      +	int overlay_mode = context ? *((int *)context) : 1;
       
     --	if (S_ISDIR(mode))
     -+	if (S_ISDIR(mode)) {
     -+		/*
     -+		 * If this directory exists as a sparse directory entry in
     -+		 * the index, we can handle it at the tree level without
     -+		 * descending into individual files.
     -+		 */
     -+		if (the_repository->index->sparse_index) {
     -+			struct strbuf dirpath = STRBUF_INIT;
     -+
     -+			strbuf_addbuf(&dirpath, base);
     -+			strbuf_addstr(&dirpath, pathname);
     -+			strbuf_addch(&dirpath, '/');
     -+
     -+			pos = index_name_pos_sparse(the_repository->index,
     -+						    dirpath.buf, dirpath.len);
     -+			if (pos >= 0) {
     -+				struct cache_entry *old =
     -+					the_repository->index->cache[pos];
     -+				if (S_ISSPARSEDIR(old->ce_mode)) {
     -+					if (oideq(oid, &old->oid)) {
     -+						strbuf_release(&dirpath);
     -+						return 0;
     -+					}
     -+					if (!overlay_mode) {
     -+						/*
     -+						 * In non-overlay mode (e.g.,
     -+						 * restore --staged), we can
     -+						 * replace the sparse dir OID
     -+						 * directly since files not in
     -+						 * the source tree should be
     -+						 * removed anyway.
     -+						 */
     -+						oidcpy(&old->oid, oid);
     -+						old->ce_flags |= CE_UPDATE;
     -+						strbuf_release(&dirpath);
     -+						return 0;
     -+					}
     -+				}
     -+			}
     -+			strbuf_release(&dirpath);
     -+		}
     - 		return READ_TREE_RECURSIVE;
     -+	}
     + 	if (S_ISDIR(mode))
     +-		return READ_TREE_RECURSIVE;
     ++		return try_update_sparse_directory(oid, base, pathname,
     ++						   overlay_mode);
       
       	len = base->len + strlen(pathname);
       	ce = make_empty_cache_entry(the_repository->index, len);

-- 
gitgitgadget
