Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EB267B90
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774682051; cv=none; b=hyhQGuzd1+2+njySHw2anRNFPniIZEq0yZgGYTFYtOaeK29yeyBuPNiB6l57ChaJvMiaXseZUi19vwQfvIhFHlK6cPY5sdDmUL8UIaQMMfL2Q6ncz9xNPdwalFKwKWemIXfls0+vPusZibHLNMQ6HFITJ5iwZVuz4g63pryqSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774682051; c=relaxed/simple;
	bh=LPqCUFIB/mI9AdrjJ9gojh4fc2LHo6xxBlUGGZdn4qg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hZyZGd2T7+jNgpr8Nbbfco0XQlNOFSs+e0F/k+hZj8cgFzpbR/4Iwa7KA7TJGSYdM2sbfO962aezsId/kZEGe+qtfBc3gB5maRSE7Gaue8PnVKtL0omwnXAFgF4WR1pegasPuSYELgKNwwVr6Gxv4iqISo++R+SyGt1bbaZ84EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb3fgM+3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb3fgM+3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd77786e97so294862385a.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774682048; x=1775286848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsTCsWHkjubbxpB/cWRvJ6sjG9hmxQoSZQQ9BA1sBhw=;
        b=Fb3fgM+3Hbpj/g9QUqUkCUgyG7RGwKXAaFrnr5MSMOvTtN86HtHApakXuB5LV1Y5Xg
         25ox26c8zkdPs9i7/ipVDWQqSlLnt0mKRdR43UMhGnOndQZXp3ZWZcRaRpaRDXY1xoYm
         DHtJ7Pl8bil7oMb/bvmL7vu/d978VGKPq3+WvqN/1KC0XsyK6yGkAdXkWCL/yrzCpJZz
         UiqSmqBZVwO1T4GsJOJDR4j+olyDjgyU3Fbip6pN37IWgZvwO8IYgwESaZNnjt8HYDda
         KLPpW7vqoGmr6mdrHoiFCrpCi9rigPACWB5wnISjCgy3XCxp+Wv4oljycZfGjg4IrMW2
         ahsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774682048; x=1775286848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsTCsWHkjubbxpB/cWRvJ6sjG9hmxQoSZQQ9BA1sBhw=;
        b=fBO/Ncsa4bvKtAgllAbDu08zKU9oP0irtUPz+haQnNOp/1kFh3Wu78XqkBUj433BSM
         L9/EWQckYyoVajuvqkP1jJYwRcJxNZtWvga6dZQZzIR7JSlGMMejdDmiuINuDmCuJamu
         TDjXrxKALKWw81kW0RlTNtg8oy2CfS0rq15yeqYEyZHUn038ExpHBZcksyjEobzr8fYD
         9PobArxpRk8AE6yKe1sig8dDUp25fv4wmtPVa14/vplQtPLT11yCG8JiEhF/Wm0Dap2w
         0n09M2e+qZOln2UkPkPzs3rvV9JAVpmZ9Yjk+2l7u3/2njwXcNiwj1co9TocgGDXT737
         IOpw==
X-Gm-Message-State: AOJu0YyBTp955olKKGlMX15k0NZJLRRAxIpqW0jFyZClxP/+m/ayhZAy
	C4jyrMtTFAW4IjaC+IMPfdmXGHsW1TfX3qxTEZZ83USMLFxv6eBxYO3m9N67Ow==
X-Gm-Gg: ATEYQzyyMH6iLbbXVdudJ1RybKBmTNGdewNfjqi4yBG62FELZE74pGFOZTLBOCpBjF2
	hijo06iBbWEjTguN3yFCypWfQebuj9OCtYts/jaRi2puluaxlWfbTSg62Ik+6x9lnKBtE/fqhSk
	0xqjTPArUFQ8sYQkOGSKW78r0gqLU246PIF2pNPnWtSLxIiLA1UmW1AOXxoHax5TGORxPSPVl0f
	/9OPsVNiKXR9upP8UhbeMXI4Lr97sArmBbl2EqaPEfhjebqDJAqI9jQKeiYxnKPjcGkmSTmD1W/
	hzOkwectusY31gnmuRjbmiuWkBSjVuA1X03Ga99boX6OG8XtfRB0Z9Cd7LdAmJL0/JaU1hgoX62
	niGIX8XpexZ3GXrepQNXnARJfkEVckFg/F+3HoX2WPBOsfW5pVCpeVRP78H2bFvNgc7KT5q5pJk
	p6w5fcnjDUnIeOj+J5jTduzIKksA==
X-Received: by 2002:a05:620a:4514:b0:8cb:5176:ef8 with SMTP id af79cd13be357-8d01c60e98emr738110685a.8.1774682048103;
        Sat, 28 Mar 2026 00:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.169.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027f2035esm106657885a.19.2026.03.28.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 00:14:07 -0700 (PDT)
Message-Id: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
References: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 07:14:06 +0000
Subject: [PATCH v2] read-cache: use istate->repo for trace2 logging
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
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

trace2_data_intmax() calls in do_read_index() currently use the
global 'the_repository' instance, even though the index_state
already carries an explicit repository pointer (istate->repo).

index_state instances are initialized via INDEX_STATE_INIT(r),
which sets istate->repo. Using the_repository here is therefore
redundant and obscures the actual repository context associated
with the index being read.

In particular, using the global repository can lead to misleading
trace2 output in scenarios where multiple repository instances are
in use (such as tests or future refactoring toward better library
boundaries), as events may be attributed to the wrong repository.

Switch these calls to use istate->repo directly, making the
association between the index and its repository explicit.

Since istate->repo is expected to be non-NULL, enforce this
assumption with a BUG() check so that any violation of this
invariant is caught early.

Also remove the now-obsolete TODO comment.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    [GSoC] read-cache: use index state repository for trace2 logging
    
    
    HIGH LEVEL
    ==========
    
    trace2_data_intmax() calls in read-cache.c currently use the global
    'the_repository' instance, even though index_state already carries an
    explicit repository pointer (istate->repo).
    
    Use istate->repo directly in these calls, making the repository context
    associated with the index explicit.
    
    
    Low-level (Implementation & Justification)
    ==========================================
    
    index_state instances are initialized via INDEX_STATE_INIT(r), which
    sets istate->repo. Therefore, istate->repo is expected to be non-NULL in
    normal code paths.
    
    Using the global 'the_repository' in this context is redundant and can
    obscure the actual repository associated with the index being read.
    
    In particular, relying on the global repository may lead to misleading
    trace2 output in scenarios where multiple repository instances are in
    use (e.g., tests or future refactoring toward improved library
    boundaries), as events could be attributed to the wrong repository.
    
    Changes:
    
     * Replace uses of the_repository in trace2_data_intmax() with
       istate->repo
     * Enforce the expectation that istate->repo is non-NULL via BUG()
     * Remove the now-obsolete TODO comment
    
    Example:
    
     * trace2_data_intmax("index", the_repository, "read/version", ...)
    
     * trace2_data_intmax("index", istate->repo, "read/version", ...)
    
    
    Summary
    =======
    
    Use the repository associated with index_state for trace2 logging
    instead of the global repository instance, making the repository context
    explicit and consistent with existing initialization guarantees.
    
    
    Changes since v1:
    =================
    
     * Dropped fallback to the_repository; rely on istate->repo invariant
     * Added BUG() check for NULL istate->repo
     * Removed TODO comment
     * Improved commit message with detailed rationale
     * Cleaned up duplicate commits and fixed history

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2253%2Fjayesh0104%2Ftrace2-istate-repo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2253/jayesh0104/trace2-istate-repo-v2
Pull-Request: https://github.com/git/git/pull/2253

Range-diff vs v1:

 1:  ba6d2add1d ! 1:  7fdfaaef9b read-cache: use index state repository for trace2 logging
     @@
       ## Metadata ##
     -Author: jayesh0104 <jayeshdaga99@gmail.com>
     +Author: Jayesh Daga <jayeshdaga99@gmail.com>
      
       ## Commit message ##
     -    read-cache: use index state repository for trace2 logging
     +    read-cache: use istate->repo for trace2 logging
      
     -    Replace uses of the_repository in trace2_data_intmax() with
     -    istate->repo, which represents the repository associated with
     -    the index state.
     +    trace2_data_intmax() calls in do_read_index() currently use the
     +    global 'the_repository' instance, even though the index_state
     +    already carries an explicit repository pointer (istate->repo).
      
     -    This avoids relying on global repository state and aligns with
     -    other parts of the codebase (e.g., sparse-index.c) that pass the
     -    repository instance explicitly.
     +    index_state instances are initialized via INDEX_STATE_INIT(r),
     +    which sets istate->repo. Using the_repository here is therefore
     +    redundant and obscures the actual repository context associated
     +    with the index being read.
      
     -    No functional change intended.
     +    In particular, using the global repository can lead to misleading
     +    trace2 output in scenarios where multiple repository instances are
     +    in use (such as tests or future refactoring toward better library
     +    boundaries), as events may be attributed to the wrong repository.
      
     -    Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
     +    Switch these calls to use istate->repo directly, making the
     +    association between the index and its repository explicit.
     +
     +    Since istate->repo is expected to be non-NULL, enforce this
     +    assumption with a BUG() check so that any violation of this
     +    invariant is caught early.
     +
     +    Also remove the now-obsolete TODO comment.
     +
     +    Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
      
       ## read-cache.c ##
      @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, int must_exist)
     @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, in
       	if (istate->initialized)
       		return istate->cache_nr;
      @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, int must_exist)
     - 	 * TODO trace2: replace "the_repository" with the actual repo instance
     - 	 * that is associated with the given "istate".
     - 	 */
     + 	}
     + 	munmap((void *)mmap, mmap_size);
     + 
     +-	/*
     +-	 * TODO trace2: replace "the_repository" with the actual repo instance
     +-	 * that is associated with the given "istate".
     +-	 */
      -	trace2_data_intmax("index", the_repository, "read/version",
     -+	r = istate->repo ? istate->repo : the_repository;
     ++	r=istate->repo;
     ++	if (!r)
     ++	    BUG("istate->repo is NULL in do_read_index");
      +	trace2_data_intmax("index", r, "read/version",
       			   istate->version);
      -	trace2_data_intmax("index", the_repository, "read/cache_nr",


 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..46ffb49cab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2206,6 +2206,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t extension_offset = 0;
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
+	struct repository *r;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2309,13 +2310,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	}
 	munmap((void *)mmap, mmap_size);
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_data_intmax("index", the_repository, "read/version",
+	r=istate->repo;
+	if (!r)
+	    BUG("istate->repo is NULL in do_read_index");
+	trace2_data_intmax("index", r, "read/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "read/cache_nr",
+	trace2_data_intmax("index", r, "read/cache_nr",
 			   istate->cache_nr);
 
 	/*

base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
gitgitgadget
