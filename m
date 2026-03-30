Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE62FD7D3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895890; cv=none; b=EH3IjDffSj6YQ5v9ADaCU6SABLBd+kEu82zrNeN+wlywvGAu5+rAcIUSpqqmGisLmDJCAKJqhnxdxf8Za4s36cjCfug1PduRxPlxFE3M2fXHTaVQFXcSEGRVxgBihJ7Jnzf/2qVA2TqiAoodIluVatoXlpfz2D2vE1/PrpZcS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895890; c=relaxed/simple;
	bh=kw3jQz5g9/PgZZZcEkSdTkolvPs1uK1+N2RFf+JoriI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D036pdpbEdQ/ppQlx99u8YF3uPI//CFL8pld+AQQ18px4c8rq+UeJ9lGldtYSNcmK8Jo4ljMHElUmMuZpBnEJgkU27U52hzRoVpntTy9d7tUSF12YuxZ0UP6PWg33x//2Np0Z7IhQyby2rAVA+n3m3+GaqzecNLtAb/tpj68MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcCBtNqt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcCBtNqt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a7bbe9d0so41402111cf.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895888; x=1775500688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrGAL2zEou+87ghyIuU9r77QO2pRMBL0EofoKUEzr0M=;
        b=gcCBtNqtaqsaFfgwVco/tQ+tuq+OYAOGZ9hUu/BV5zm4xcB8Ob0Ohy1+piO7iSLQxE
         eqelvIuY10l/EJAmH8BDpxHUq/iCUznU/sJbhJYwA4W7QC9kNHguExQXo4CNFvILb6h2
         cE9+8ZtdZE0yI5dP5YUwx7P4Y+iT+aEt/DiKT7iLgNwMxNE5NoGqA4kZ507Okvgfne9z
         Zs8vrYVNnpQnjFsvBFNpZBHiz2KleazInDWJSmpmGdrJAgPW0dFYVR1B3WXgpYasEQx9
         3N/0oqwoXP5hL0X7GS3ZDexLautenFanOHtIuxBr8tKTsxk8CHocysXQTowPoaD4KkmA
         2eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895888; x=1775500688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrGAL2zEou+87ghyIuU9r77QO2pRMBL0EofoKUEzr0M=;
        b=hUQ73wom4+G5S6yzi5bwzeYHUYZqf1OY6dDL6SgBTMcv1yEetLLp/DktsD98SvlJdc
         omf90IvIYgT4kxJMcIOEn7Wq6aNrIvaqF8IZm24p/2PF6rkrISGkbmLUdb5ZDKa3M30J
         I7cOYp39Y563iRjyZeW/1QoXq4bAxETZsxfDmumh+t5nZZJTUCR3pMhXvvMhMAlblUpT
         iQkpHbTvs+RLkZ90MdvUVWYH3qPya1iKGZ4JrnXZTW+6UUtA8Ppve/eRvle8E2+Fi/qU
         B+MiUFr3TWsVAzgNIBM3ySCsbOxGV+oo5FmII+zJ5ObWVRweWkXv2BwNFXBeJiuE9pR9
         +e3Q==
X-Gm-Message-State: AOJu0YzQ/i7MGY/TMxWZV/DQ+fp09Xd/xFhFGvjfhIq9gJWlezbLoQqn
	qQJD8/SjH/4+N6PhDoZxpgACsFvkIt0BiKgU0v1P1MZeoxu0JGhb0c8QMh/fZQ==
X-Gm-Gg: ATEYQzzoE+qvZWAjaQs3avM1hTSXrsY3rSljkC8NcZ0cSQs4BfqMdJJVlWLIAmbG/tk
	wLdFuILwv/Mrw59R2AOhepLzypfV1IpvfacmSMBHuRsDIBMOAwULUiBqS7yjbIvs2yqltkjlPxO
	VKWb9yq0cpA780b3I8e+3LQK6zL9Pd7H+wfHGjLRblwyUsZeONNqhKvYVaPh4War0qjoz6pEzQk
	jmRMsYq6D5ihfNB0r5W/Jg/7YsVSX23mpP1vtIOUI7B6OipTWwKMcg2JGhSzaTLKuMRUBqrur0A
	+kGv2oeduc/hUiyrYFV+iCPe+3wTVrxRqNp6vo3F4FpLj2Xs+LW7bQ0XgXUAcoyvSs6GozCt88f
	WttU8QVQ966XAFrRL9Myb5Apuwk9duqK2pK8jCAv13xd+wDMlp7MR0GQc01JFDHZ/O0c1iXXwcA
	S6uFAQDn9nM5KyZ3BciQt1N08C6Q==
X-Received: by 2002:ac8:58c1:0:b0:50b:8ccc:a420 with SMTP id d75a77b69052e-50ba37f2722mr180855451cf.16.1774895887879;
        Mon, 30 Mar 2026 11:38:07 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67beasm71155481cf.5.2026.03.30.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:38:07 -0700 (PDT)
Message-Id: <pull.2253.v4.git.git.1774895886678.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
References: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 18:38:06 +0000
Subject: [PATCH v4] read-cache: use istate->repo for trace2 logging
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
Cc: Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in read-cache.c use the global 'the_repository',
even though the relevant index_state provides an explicit
repository pointer via 'istate->repo'.

Using the global repository can result in incorrect trace2
output when multiple repository instances are in use, as
events may be attributed to the wrong repository.

Use 'istate->repo' instead to ensure correct repository
attribution.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    [GSoC] read-cache: use index state repository for trace2 logging
    
    trace2 calls in read-cache.c use the global 'the_repository', even
    though the relevant index_state provides an explicit repository pointer
    via 'istate->repo'.
    
    Using the global repository can result in incorrect trace2 output when
    multiple repository instances are in use, as events may be attributed to
    the wrong repository.
    
    Use 'istate->repo' instead in these call sites to ensure correct
    repository attribution.
    
    v4:
    
     * reroll as clean series; drop unrelated commit.
    
    v2:
    
     * Apply the change consistently across read-cache.c
     * Drop unnecessary intermediate variable
     * Remove obsolete TODO comments
     * Update commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2253%2Fjayesh0104%2Ftrace2-istate-repo-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2253/jayesh0104/trace2-istate-repo-v4
Pull-Request: https://github.com/git/git/pull/2253

Range-diff vs v3:

 1:  5a8165b05d < -:  ---------- repo: add paths.git_dir repo info key
 2:  9bb6d0fa01 = 1:  c99d731efa read-cache: use istate->repo for trace2 logging


 read-cache.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..b1074fbf06 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2309,13 +2309,9 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	}
 	munmap((void *)mmap, mmap_size);
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_data_intmax("index", the_repository, "read/version",
+	trace2_data_intmax("index", istate->repo, "read/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "read/cache_nr",
+	trace2_data_intmax("index", istate->repo, "read/cache_nr",
 			   istate->cache_nr);
 
 	/*
@@ -2360,16 +2356,12 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_region_enter_printf("index", "do_read_index", the_repository,
+	trace2_region_enter_printf("index", "do_read_index", istate->repo,
 				   "%s", path);
 	trace_performance_enter();
 	ret = do_read_index(istate, path, 0);
 	trace_performance_leave("read cache %s", path);
-	trace2_region_leave_printf("index", "do_read_index", the_repository,
+	trace2_region_leave_printf("index", "do_read_index", istate->repo,
 				   "%s", path);
 
 	split_index = istate->split_index;
@@ -3096,13 +3088,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_data_intmax("index", the_repository, "write/version",
+	trace2_data_intmax("index", istate->repo, "write/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "write/cache_nr",
+	trace2_data_intmax("index", istate->repo, "write/cache_nr",
 			   istate->cache_nr);
 
 	ret = 0;
@@ -3144,14 +3132,10 @@ static int do_write_locked_index(struct index_state *istate,
 		return ret;
 	}
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_region_enter_printf("index", "do_write_index", the_repository,
+	trace2_region_enter_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
-	trace2_region_leave_printf("index", "do_write_index", the_repository,
+	trace2_region_leave_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 
 	if (was_full)

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
gitgitgadget
