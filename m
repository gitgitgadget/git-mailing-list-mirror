Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970903AA4FC
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606091; cv=none; b=Ge57mggiDu6hCM4ZwXzDEbN1yOIx/Rs0Cv13n5hK1PzUVfEPrpXGp1DxLc4ZP1NFcKnYrSGFzWoayIXdAIBxZtskH+uPFhEABfcziLGDSbFvjM5CTt+fYgJfymeslgTANgxWMO9KSAKxyj89tcd/2x5CcNxRbRIKgtUEGSJz5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606091; c=relaxed/simple;
	bh=scZdgLzPWz59xTaUWYQpKILuQrI+/qVu+tWhqoK4Nbg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TSgFlFlo8tqwSuzK92aAorKZWebrwBYm41CUFGLq6knGFzTKyNQprDN7nJnoF4726HKQOS/Bc2InfNELWpDem2n1bqiZymuXvvmjeICOwynkJsZYc73s+sLJzTwnEEMh7acQHalgJ3oR5yYDPzyLl4povtBI2Gbl0kFgH+ukc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtNHA8Lr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtNHA8Lr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506251815a3so16996021cf.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774606088; x=1775210888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqZLJcH1gVbQrvA/naUtuTcDvqjTRk5i1rzi7CrGBRQ=;
        b=AtNHA8LrdaQ6zFhunDp8Dn7VUt3KFj1q9gAvjDOX7cKtOTMKxz0HUhB71VOG/hgShP
         /oXNHPFybRcmO+xnxYYcWrhg4OTnBeOCpGAYhirjK1Lib26sfV/z0EvxJk8uE1wMowGI
         IZhZjHYVTMUIWbC1wk0LNp3+dm5wBdIWRIPUnzaiY1ryd47NhZti+O2kYe78PhGAX+YU
         GAmvkDvRNEps8CEiv9mArxQjKdHyDCN04+tfv/QMUaF/WcGZjpzxLbPTY8GkhmvgViSR
         Zm1n0so95UvxamiFQrI6n78V8qDugbMLtKD8P/zyedY4iYTyf+pEgtNPEhEgMLYB+Jil
         L0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774606088; x=1775210888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqZLJcH1gVbQrvA/naUtuTcDvqjTRk5i1rzi7CrGBRQ=;
        b=pb3Fp1CogSQttxjxuSCz6azDyG5fhoRR6DlEmHrzOd0XV8nSNJKXxOntDY+eOA7FEY
         NpsRYcD4G7mmMWGl6uCvt1G2lt762cno0JQPxwHuYSlerQwUCRhHCM69qgNh2jf7XWJA
         ENP3FUJcZsgesJWf0xB+/dGTCzW5dlzSYCJQH6/P+JVRw4ossebSGKpp9+0UITYQGZnQ
         j9v0CX1h43msJmbgM0DIgkiF+Y4jxPXj036qZ+VAVpm+g2J0QJmDNWV7r/bfwBvOmWOf
         y723TctKfZrFKtSiqsi9LLjVZ2OVSALAR8LD1ZMGAVJ+rIK7iBm70ec8FpIDXIdeNMC8
         /lNQ==
X-Gm-Message-State: AOJu0YyyQ0T5Wd7h/v6zASzRHVnFK62Rp9syTyn56lKzvMcjoE7h47Ho
	QvwpcMi49pcRe66LRBH20d0a9GlsldSPykEjiM7ZJWzE0rbf9X+9xp8IF9RBrRqe
X-Gm-Gg: ATEYQzwwdNqE7OSeyrLx7PoPf6g92BTsqk/dJnEDcAXNSqYmEu1OY7yXt0cw/V39yER
	PpyfpmMgzFoT+cktkSPHYVh2RAPfWivfyNs8Rt/FZoYFIOOMcGhGvE2JwWeB+Q2PGxJsod1oDTI
	tg619Z6K1nsiqzpNpCL4IjPfFgDfG3YnHFezgtgfk0JM0l/Upwg61OqxCQQ1vBb9brLcQReDYym
	Ts8DAHjX+j1/DoKg4ycp5JhtRQ9ZHa7DI9gw+64H3jkDiOjHlO6fEMexCLF4tlXjoN3AYS0XHcz
	Zt3zwSg8oW8IXT6hvTmPI7pxvgfaoz8ygf1iCbZhoD8/1fdXSn6d0sv4+3vocwlkp6aLvruDrZW
	bqSJraEklfZcEQb2Wse5y14hp/YgGUAa/j5RRQjUyemIRokJq8b0HUlPtsRIZ0dd44JeYRmYMQ9
	OWpkKgOLvaDL06L92j1FSKZLP7GhM=
X-Received: by 2002:ac8:7f48:0:b0:50b:4537:2e23 with SMTP id d75a77b69052e-50ba39524d0mr23402691cf.48.1774606087628;
        Fri, 27 Mar 2026 03:08:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.117.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18c20sm45053106d6.28.2026.03.27.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 03:08:06 -0700 (PDT)
Message-Id: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 10:08:06 +0000
Subject: [PATCH] read-cache: use index state repository for trace2 logging
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

Replace uses of the_repository in trace2_data_intmax() with
istate->repo, which represents the repository associated with
the index state.

This avoids relying on global repository state and aligns with
other parts of the codebase (e.g., sparse-index.c) that pass the
repository instance explicitly.

No functional change intended.

Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
---
    [GSoC] read-cache: use index state repository for trace2 logging
    
    
    HIGH LEVEL
    ==========
    
    The current implementation of trace2_data_intmax() in read-cache.c
    relies on the global the_repository instance.
    
    As part of the ongoing effort to "lib-ify" the Git codebase and reduce
    dependence on global state, this patch transitions those calls to use
    the repository instance associated with the index_state.
    
    
    Low-level (Implementation & Justification)
    ==========================================
    
    In read-cache.c, the index_state (istate) typically carries a pointer to
    its associated repository. However, because istate->repo is not
    guaranteed to be initialized in all code paths (e.g., certain low-level
    utility or testing contexts), this patch implements a defensive fallback
    pattern.
    
    Changes:
    
    Introduced a local repository pointer r that prefers istate->repo but
    falls back to the_repository if the former is NULL.
    
    Updated trace2_data_intmax() calls to use this context-aware pointer.
    
    + struct repository *r = istate->repo ? istate->repo : the_repository;
    - trace2_data_intmax("index", the_repository, "read/version", istate->version);
    + trace2_data_intmax("index", r, "read/version", istate->version);
    
    
    Benefits:
    
    Thread Safety & Modernization: Aligns with the project's goal of moving
    away from the_repository.
    
    Robustness: The ternary fallback ensures we avoid potential NULL pointer
    dereferences while maintaining existing logging behavior in edge cases.
    
    Consistency: Follows patterns seen in other modernized areas of the
    codebase.
    
    
    Summary
    =======
    
    Transitioned trace2 logging in read-cache.c from global to local
    repository context.
    
    Implemented a safety fallback to the_repository to handle uninitialized
    istate->repo pointers.
    
    No functional changes to telemetry output are intended.
    
    cc :Karthik Nayak karthik.188@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2253%2Fjayesh0104%2Ftrace2-istate-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2253/jayesh0104/trace2-istate-repo-v1
Pull-Request: https://github.com/git/git/pull/2253

 read-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..2c5c5165e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2206,6 +2206,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t extension_offset = 0;
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
+	struct repository *r;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2313,9 +2314,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	 * TODO trace2: replace "the_repository" with the actual repo instance
 	 * that is associated with the given "istate".
 	 */
-	trace2_data_intmax("index", the_repository, "read/version",
+	r = istate->repo ? istate->repo : the_repository;
+	trace2_data_intmax("index", r, "read/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "read/cache_nr",
+	trace2_data_intmax("index", r, "read/cache_nr",
 			   istate->cache_nr);
 
 	/*

base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
gitgitgadget
