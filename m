Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7E186283
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412198; cv=none; b=U6wBRXpw6Gm2hkOcrBG/Pz28JtTBzV5bAgiY56aPKUvybmlZeuqse9Kw/LCsKrGNQ/J2GHttP3g09NfDiXDKat3VUU1yv7m3p7LBlLL58tMetIHz95h5x0wQ7K8sA2xGpLO8tSKCQOgrgZUR6mZSzOt9RVTiG9OZBTcehRd/c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412198; c=relaxed/simple;
	bh=1qGnCdRbo4cKe4e2YkDokmYw+/iIYe1BnoJ+uzeOc9o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=GlsVD8bz7R6a0r8qF5m3btW4oTXplwxpJ+NCBWCA4HfpG2yg1TN57jn/+2p65AZj2uGC3xbkpckhYda6T9TkxUCc4BvRgIIz4MfAGvo7liNmATrGakzJ0kuv93dgnhaGiS3cHuJRAVHoXf4zA3TlbjQ3G4wIzQfPVKOFhg4cYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTaAXtQD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTaAXtQD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f06861ae6so5163779f8f.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412194; x=1720016994; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yXQGcS4nQOItO9pj20KZSwYDBKEBN8YkCDAcNfVm1I=;
        b=bTaAXtQDcY9EFtjrvMWsTO5QoE3u1C2z7Ji/MrQEdMLEXK7s1WNlgr1qkvGLJdreea
         BDQyabBCA2SPXCA2T5FaNBbVLe+0fy/BrYvW8Db7Z+zG1k4JJpxlJSJxxHH/YB3oHG57
         3wd3Ar10R5AQGLIJi6NM+GvT3xvpJwSt5KesTxtWV11i/U3fmuqPpqWu5hgxxjhp5ub8
         EB6fM48ub+YAH6bszDxnLJo7mh5AUIwFtHSuN2X+qK/gBxeSOJZspf2+tt23DQ/b6nM0
         +v+V2MnReTfkd4+P5wgFq3xGa+0nfHxAaRCcsds8SBaUnE30Oi5bBvqRLiWzRbuBv6b8
         a6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412194; x=1720016994;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yXQGcS4nQOItO9pj20KZSwYDBKEBN8YkCDAcNfVm1I=;
        b=PRcpeAG0Yako3YI7Pb2/wZccm6fjPKPT9hhuiTdh8+jtOMN//Xtv0IQTixuQvf+LnH
         xJuAWzjInYwGLRHOv7hiLL9fCIMZlbV/WcFDkzB5JnuIvZ/yBArozmObbKWerRIB/425
         gRfG/T7MbGXfgECGqj4NYPCtwYhm/giP5Xyi1Siw93MEcbyugq8KF/RmOqqlzKYe+hng
         tH+AA6ttbf4/eFw3OAqLJPJOfDk4g0hfA4I1eEMVv1AaoGmMPw9G643CLXzXz7/HGLnx
         /t7ZGk48Ane32uyEmTdt+zx7Pj7FS9KaRyYGb0D56Vj6hZvplpchHW4AF9TkGGh8NhCx
         88Sg==
X-Gm-Message-State: AOJu0YyyGztkPUtYIOYZT5ZapSJXDo9AvFR4vXL4PB5s7j72CQtsbxaR
	hLK4thta2A2xGSFDT74YEmHP9xunroG0dCEJzYez24Ceq/oWHhN6KUGXkg==
X-Google-Smtp-Source: AGHT+IF61V0oU5FtjEjLgyr7T0lrQ7OFJOCZo0gRNhKldq1vyCFJzIBfBI2wpPIHgvahIaS94R+/+g==
X-Received: by 2002:a5d:6685:0:b0:360:7dbf:d3f with SMTP id ffacd0b85a97d-366e96b23d6mr6163094f8f.56.1719412193621;
        Wed, 26 Jun 2024 07:29:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b863fsm15822298f8f.47.2024.06.26.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:53 -0700 (PDT)
Message-Id: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:46 +0000
Subject: [PATCH v2 0/5] sparse-index: improve clear_skip_worktree_from_present_files()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>

While doing some investigation in a private monorepo with sparse-checkout
and a sparse index, I accidentally left a modified file outside of my
sparse-checkout cone. This caused my Git commands to slow to a crawl, so I
reran with GIT_TRACE2_PERF=1.

While I was able to identify clear_skip_worktree_from_present_files() as the
culprit, it took longer than desired to figure out what was going on. This
series intends to both fix the performance issue (as much as possible) and
do some refactoring to make it easier to understand what is happening.

In the end, I was able to reduce the number of lstat() calls in my case from
over 1.1 million to about 4,400, improving the time from 13.4s to 81ms on a
warm disk cache. (These numbers are from a test after v2, which somehow hit
the old caching algorithm even worse than my test in v1.)


Updates in v2
=============

Thanks to Elijah for a thorough review, leading to valuable improvements.

 * I was mistaken that the sparse index was required for this logic to
   happen. This has changed several descriptions across the commit messages.
 * The final lstat() in path_found() was not needed, so is removed in v2.
   This saves even more time and lstat() calls, updating the stats.
 * Elijah created a particularly nasty example for testing, which I include
   in my final patch. He gets a "Helped-by" credit for this.
 * Several comments, variables, and other improvements based on Elijah's
   recommendations.

Thanks, Stolee

Derrick Stolee (5):
  sparse-checkout: refactor skip worktree retry logic
  sparse-index: refactor path_found()
  sparse-index: use strbuf in path_found()
  sparse-index: count lstat() calls
  sparse-index: improve lstat caching of sparse paths

 sparse-index.c | 216 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 164 insertions(+), 52 deletions(-)


base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1754%2Fderrickstolee%2Fclear-skip-speed-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1754/derrickstolee/clear-skip-speed-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1754

Range-diff vs v1:

 1:  ddd8a9a90ce ! 1:  93d0baed0b0 sparse-index: refactor skip worktree retry logic
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-index: refactor skip worktree retry logic
     +    sparse-checkout: refactor skip worktree retry logic
      
          The clear_skip_worktree_from_present_files() method was introduced in
          af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files present
     -    in worktree, 2022-01-14) to help cases where the sparse index is enabled
     -    but some paths outside of the sparse-checkout cone also exist on disk.
     -    This operation can be slow as it needs to check path existence in a way
     -    that is not stored in the collapsed index, so caching was introduced in
     -    d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
     -    caching, 2022-01-14).
     +    in worktree, 2022-01-14) to help cases where sparse-checkout is enabled
     +    but some paths outside of the sparse-checkout also exist on disk.  This
     +    operation can be slow as it needs to check path existence in a way not
     +    stored in the index, so caching was introduced in d79d299352 (Accelerate
     +    clear_skip_worktree_from_present_files() by caching, 2022-01-14).
      
          If users are having trouble with the performance of this operation and
     -    don't care about paths outside of the sparse-checkout cone, they can
     -    disable them using the sparse.expectFilesOutsideOfPatterns config option
     +    don't care about paths outside of the sparse-checkout, they can disable
     +    them using the sparse.expectFilesOutsideOfPatterns config option
          introduced in ecc7c8841d (repo_read_index: add config to expect files
          outside sparse patterns, 2022-02-25).
      
     +    This check is particularly confusing in the presence of a sparse index,
     +    as a sparse tree entry corresponding to an existing directory must first
     +    be expanded to a full index before examining the paths within. This is
     +    currently implemented using a 'goto' and a boolean variable to ensure we
     +    restart only once.
     +
          Even with that caching, it was noticed that this could take a long time
          to execute. 89aaab11a3 (index: add trace2 region for clear skip
          worktree, 2022-11-03) introduced trace2 regions to measure this time.
     @@ Commit message
      
          One thing that can be confusing about the current setup is that the
          trace2 regions nest and it is not clear that a second loop is running
     -    after the index is expanded. Here is an example of what the regions look
     -    like in a typical case:
     +    after a sparse index is expanded. Here is an example of what the regions
     +    look like in a typical case:
      
          | region_enter | ... | label:clear_skip_worktree_from_present_files
          | region_enter | ... | ..label:update
 2:  7c3b545ee5e ! 2:  69c3beaabf7 sparse-index: refactor path_found()
     @@ Commit message
          the callers with this approach.
      
          Note that the clear_path_found_data() method is currently empty, as
     -    there is nothing to free. However, this will change in the future, so
     -    place the method and its callers for now.
     +    there is nothing to free. This method is a placeholder for future
     +    changes that require a non-trivial implementation. Its stub is created
     +    now so consumers could call it now and not change in future changes.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
 3:  217594ffb10 = 3:  0a82e6b4183 sparse-index: use strbuf in path_found()
 4:  88a3145e585 = 4:  9549f5b8062 sparse-index: count lstat() calls
 5:  2654fcb7142 ! 5:  0cb344ac14f sparse-index: improve lstat caching of sparse paths
     @@ Commit message
          in af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
          present in worktree, 2022-01-14) to allow better interaction with the
          working directory in the presence of paths outside of the
     -    sparse-checkout cone. The initial implementation would lstat() every
     -    single sparse tree to see if it existed, and if one did, then the sparse
     -    index would expand and every sparse file would be checked.
     +    sparse-checkout. The initial implementation would lstat() every single
     +    SKIP_WORKTREE path to see if it existed; if it ran across a sparse
     +    directory that existed (when a sparse index was in use), then it would
     +    expand the index and then check every SKIP_WORKTREE path.
      
          Since these lstat() calls were very expensive, this was improved in
          d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
     -    caching, 2022-01-14) by caching directories that do not exist. However,
     -    there are some inefficiencies in that caching mechanism.
     +    caching, 2022-01-14) by caching directories that do not exist so it
     +    could avoid lstat()ing any files under such directories. However, there
     +    are some inefficiencies in that caching mechanism.
      
          The caching mechanism stored only the parent directory as not existing,
          even if a higher parent directory also does not exist. This means that
     -    wasted lstat() calls would occur when the sparse files change immediate
     -    parent directories but within the same root directory that does not
     -    exist.
     +    wasted lstat() calls would occur when the paths passed to path_found()
     +    change immediate parent directories but within the same parent directory
     +    that does not exist.
     +
     +    To create an example repository that demonstrates this problem, it helps
     +    to have a directory outside of the sparse-checkout that contains many
     +    deep paths. In particular, the first paths (in lexicographic order)
     +    underneath the sparse directory should have deep directory structures,
     +    maximizing the difference between the old caching algorithm that looks
     +    to a single parent and the new caching algorithm that looks to the
     +    top-most missing directory.
      
     -    To set up a scenario that triggers this code in an interesting way, we
     -    need a sparse-checkout in cone mode and a sparse index. To trigger the
     -    full index expansion and a call to the
     -    clear_skip_worktree_from_present_files_full() method, we need one of the
     -    sparse trees to actually exist on disk. The performance test script
     -    p2000-sparse-operations.sh takes the sample repository and copies its
     -    HEAD to several copies nested in directories of the form f<i>/f<j>/f<k>
     -    where i, j, and k are numbers from 1 to 4. The sparse-checkout cone is
     -    then selected as "f2/f4/". Creating "f1/f1/" will trigger the behavior
     -    and also lead to some interesting cases for the caching algorithm since
     -    "f1/f1/" exists but "f1/f2/" and "f3/" do not.
     +    The performance test script p2000-sparse-operations.sh takes the sample
     +    repository and copies its HEAD to several copies nested in directories
     +    of the form f<i>/f<j>/f<k> where i, j, and k are numbers from 1 to 4.
     +    The sparse-checkout cone is then selected as "f2/f4/". Creating "f1/f1/"
     +    will trigger the behavior and also lead to some interesting cases for
     +    the caching algorithm since "f1/f1/" exists but "f1/f2/" and "f3/" do
     +    not.
      
          This is difficult to notice when running performance tests using the Git
          repository (or a blow-up of the Git repository, as in
          p2000-sparse-operations.sh) because Git has a very shallow directory
          structure.
      
     -    This change reorganizes the caching algorithm to focus on storing both
     -    the deepest _existing_ directory and the next-level non-existing
     -    directory. By doing a little extra work on the first sparse file, we can
     -    short-circuit all of the sparse files that exist in that non-existing
     -    directory. When in a repository where the first sparse file is likely to
     -    have a much deeper path than the first non-existing directory, this can
     -    realize significant gains.
     +    This change reorganizes the caching algorithm to focus on storing the
     +    highest level leading directory that does not exist; specifically this
     +    means that that directory's parent _does_ exist. By doing a little extra
     +    work on a path passed to path_found(), we can short-circuit all of the
     +    paths passed to path_found() afterwards that match a prefix with that
     +    non-existing directory. When in a repository where the first sparse file
     +    is likely to have a much deeper path than the first non-existing
     +    directory, this can realize significant gains.
      
          The details of this algorithm require careful attention, so the new
          implementation of path_found() has detailed comments, including the use
     @@ Commit message
          _increases_ from 28 to 31. However, these numbers were already
          artificially low.
      
     +    Contributor Elijah Newren created a publicly-available test repository
     +    that demonstrates the difference in these caching algorithms in the most
     +    extreme way. To test, follow these steps:
     +
     +      git clone --sparse https://github.com/newren/gvfs-like-git-bomb
     +      cd gvfs-like-git-bomb
     +      ./runme.sh                   # NOTE: check scripts before running!
     +
     +    At this point, assuming you do not have index.sparse=true set globally,
     +    the index has one million paths with the SKIP_WORKTREE bit and they will
     +    all be sent to path_found() in the sparse loop. You can measure this by
     +    running 'git status' with GIT_TRACE2_PERF=1:
     +
     +        Sparse files in the index: 1,000,000
     +      sparse_lstat_count (before):   200,000
     +       sparse_lstat_count (after):         2
     +
     +    And here are the performance numbers:
     +
     +      Benchmark 1: old
     +        Time (mean ± σ):     397.5 ms ±   4.1 ms
     +        Range (min … max):   391.2 ms … 404.8 ms    10 runs
     +
     +      Benchmark 2: new
     +        Time (mean ± σ):     252.7 ms ±   3.1 ms
     +        Range (min … max):   249.4 ms … 259.5 ms    11 runs
     +
     +      Summary
     +        'new' ran
     +          1.57 ± 0.02 times faster than 'old'
     +
     +    By modifying this example further, we can demonstrate a more realistic
     +    example and include the sparse index expansion. Continue by creating
     +    this directory, confusing both caching algorithms somewhat:
     +
     +      mkdir -p bomb/d/e/f/a/a
     +
     +    Then re-run the 'git status' tests to see these statistics:
     +
     +        Sparse files in the index: 1,000,000
     +      sparse_lstat_count (before):   724,010
     +       sparse_lstat_count (after):       106
     +
     +      Benchmark 1: old
     +        Time (mean ± σ):     753.0 ms ±   3.5 ms
     +        Range (min … max):   749.7 ms … 760.9 ms    10 runs
     +
     +      Benchmark 2: new
     +        Time (mean ± σ):     201.4 ms ±   3.2 ms
     +        Range (min … max):   196.0 ms … 207.9 ms    14 runs
     +
     +      Summary
     +        'new' ran
     +          3.74 ± 0.06 times faster than 'old'
     +
     +    Note that if this repository had a sparse index enabled, the additional
     +    cost of expanding the sparse index affects the total time of these
     +    commands by over four seconds, significantly diminishing the benefit of
     +    the caching algorithm. Having existing paths outside of the
     +    sparse-checkout is a known performance issue for the sparse index and is
     +    a known trade-off for the performance benefits given when no such paths
     +    exist.
     +
          Using an internal monorepo with over two million paths at HEAD and a
     -    typical sparse-checkout cone such that the index contains ~190,000
     -    entries (including over two thousand sparse trees), I was able to
     -    measure these lstat counts when one sparse directory actually exists on
     -    disk:
     +    typical sparse-checkout cone such that the sparse index contains
     +    ~190,000 entries (including over two thousand sparse trees), I was able
     +    to measure these lstat counts when one sparse directory actually exists
     +    on disk:
      
            Sparse files in expanded index: 1,841,997
     -           full_lstat_count (before):   173,259
     -           full_lstat_count  (after):     6,521
     +           full_lstat_count (before): 1,188,161
     +           full_lstat_count  (after):     4,404
      
          This resulted in this absolute time change, on a warm disk:
      
     -          Time in full loop (before): 2.527 s
     -          Time in full loop  (after): 0.071 s
     +          Time in full loop (before): 13.481 s
     +          Time in full loop  (after):  0.081 s
      
          (These times were calculated on a Windows machine, where lstat() is
          slower than a similar Linux machine.)
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## sparse-index.c ##
     @@ sparse-index.c: static void clear_path_found_data(struct path_found_data *data)
      +	 * At this point, we know that 'path' doesn't exist, and we know that
      +	 * the parent directory of 'data->dir' does exist. Let's set 'data->dir'
      +	 * to be the top-most non-existing directory of 'path'. If the first
     -+	 * parent of 'path' exists, then we will act ast though 'path'
     ++	 * parent of 'path' exists, then we will act as though 'path'
      +	 * corresponds to a directory (by adding a slash).
       	 */
      -	newdir = strrchr(path, '/');
     @@ sparse-index.c: static void clear_path_found_data(struct path_found_data *data)
      +	strbuf_setlen(&data->dir, common_prefix);
      +	while (1) {
      +		/* Find the next directory in 'path'. */
     -+		const char *next_slash = strchr(path + data->dir.len, '/');
     ++		const char *rest = path + data->dir.len;
     ++		const char *next_slash = strchr(rest, '/');
       
      -	data->lstat_count++;
      -	data->dir_found = !lstat(data->dir.buf, &st);
     @@ sparse-index.c: static void clear_path_found_data(struct path_found_data *data)
      +		 * method is reused, then this must be reconsidered.
      +		 */
      +		if (!next_slash) {
     -+			strbuf_addstr(&data->dir, path + data->dir.len);
     ++			strbuf_addstr(&data->dir, rest);
      +			strbuf_addch(&data->dir, '/');
      +			break;
      +		}
       
     --	return 0;
      +		/*
      +		 * Now that we have a slash, let's grow 'data->dir' to include
      +		 * this slash, then test if we should stop.
      +		 */
     -+		strbuf_add(&data->dir, path + data->dir.len,
     -+			   (next_slash - path) - data->dir.len + 1);
     ++		strbuf_add(&data->dir, rest, next_slash - rest + 1);
      +
     -+		/* If the path doesn't exist, then stop here. */
     ++		/* If the parent dir doesn't exist, then stop here. */
      +		data->lstat_count++;
      +		if (lstat(data->dir.buf, &st))
      +			return 0;
     @@ sparse-index.c: static void clear_path_found_data(struct path_found_data *data)
      +
      +	/*
      +	 * At this point, 'data->dir' is equal to 'path' plus a slash character,
     -+	 * and the parent directory of 'path' definitely exists. Let's return
     -+	 * the case of whether 'path' exists.
     ++	 * and the parent directory of 'path' definitely exists. Moreover, we
     ++	 * know that 'path' doesn't exist, or we would have returned 1 earlier.
      +	 */
     -+
     -+	data->lstat_count++;
     -+	return !lstat(path, &st);
     + 	return 0;
       }
       
     - static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)

-- 
gitgitgadget
