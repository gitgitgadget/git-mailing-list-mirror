Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F413D530
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631497; cv=none; b=bk9HNPKyRrgPyUWDRhwJGDEpLaEO0qapjNQ6HZ1/QY8sswzUWmoilKtMP1ZTDFLDYvZ0mPI5DnOnOAt5d9F2oSfKPa+AwV1A0x+OS+Vd2G3OGIakIx0x58aALJkZc9OpcEMOJMdbtlIfNf7SNCejo50HKQ7rRYD0wTXhdKR5C+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631497; c=relaxed/simple;
	bh=tsJiJCY68G3wGvX+T0usCZ5joy9ImIVNmkOXW1I6WVw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qDE9iGgVX7DFCGyQCPXdiwThncTdRdxhnNOusSSFxkUj67t9x9P7D3IxjoPtQyim0CcvN+YccSLef2bvc+AHfhCykMltQ0TDj+YYtE3xve++xmL207kibTvqqGderzxowFS2i115PeNfWdi3Y9l3weWOEaOWoupDDwtvYvi5Ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtrxO91h; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtrxO91h"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530e22878cfso5900871e87.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631493; x=1724236293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoFpHtw9zbcNZWxPpNZPvFRGpa95pBgFjFS7CuiK3ow=;
        b=LtrxO91hLipfXSHwPWlmYDfYS4UCF9TuRZ4qnAP5WGtgEWfOS3RpXz122R8z7qT1ne
         Iq9kWcrTiwq7QiVF94KnUibGCvCpAJJJSEs7AxMHIbbQGe9InquE9xFB9bpUks0cYvER
         yw4CYkjTFAln8a8kDC3oUwCvaOjyJllUA1GQvp0goebgSiU2yvDzGN8AKikV/fJWHUVA
         zOiGb7unY6+sEGzlerbRae338ezauYHAkzSie7ArufsAYLc+o+tovz6jqY3l9jgyH3vf
         GDsJ5Q253UDg0kCc6JrChaB/rOUH88Au7j8rtYEMsQRSrJe78ESyNCS1DG3Y8fSKUSSM
         LNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631493; x=1724236293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoFpHtw9zbcNZWxPpNZPvFRGpa95pBgFjFS7CuiK3ow=;
        b=NLEesX3s1xyPU8AUBQ2f1U0rLBaT/07lGgI2C5ZXSKPhLhjNvKUHqz5RiQE2ExWnic
         m2a8ozfueB4ZvQ35uE1Lr3XlcgBBowx0I0N64jaOLlqKpxVIJUVKgZQg5ebRVVrncGri
         Im4ECH0JSSLEm9wgY1OlKqArtrDGeeHycMhskWraYGwFk4al+98OL0JfT1v8jSjylnzy
         zW7Cu35VlW9KdpC/YyIPjcemIlldlN9Ptm9AQhFND/75Z9sjt/u69SxQ99kX/Jyd4twQ
         Nzw/CxIt/ye9uOtmAeRZp/irY6oXvl1Ye/sBcGGSu2qdKKc0mU+DQ5a+ZNfEEC7q3QUO
         H42g==
X-Gm-Message-State: AOJu0YwHU0ON4fW/m5MNZHD1vSNGTp5NW4sQux9fAWcyrX5XUrRGQmyg
	mTBgqui1a8L1Qi5Dj9e3jnk8CFrIDnxOgzllq1kbjyfS4a4ihDkAixJi5Q==
X-Google-Smtp-Source: AGHT+IEV4zWrbuoT9/lqAgXS7rCF8Q9QkbQoU3K5qEFmOW1AWv/pTD8xsBr5J6XKx7PLzT1WYZMx5Q==
X-Received: by 2002:ac2:4e03:0:b0:52e:9ba5:9853 with SMTP id 2adb3069b0e04-532eda85722mr1473441e87.24.1723631492375;
        Wed, 14 Aug 2024 03:31:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded5bcdbsm15387895e9.43.2024.08.14.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:31:31 -0700 (PDT)
Message-Id: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 10:31:26 +0000
Subject: [PATCH v3 0/4] git for-each-ref: is-base atom and base branches
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
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>

This change introduces a new 'git for-each-ref' atom, 'is-base', in a very
similar way to the 'ahead-behind' atom. As detailed carefully in the first
change, this is motivated by the need to detect the concept of a "base
branch" in a repository with multiple long-lived branches.

This change is motivated by a third-party tool created to make this
detection with the same optimization mechanism, but using a much slower
technique due to the limitations of the Git CLI not presenting this
information. The existing algorithm involves using git rev-list
--first-parent -<N> in batches for the collection of considered references,
comparing those lists, and increasing <N> as needed until finding a
collision. This new use of 'git for-each-ref' will allow determining this
mechanism within a single process and walking a minimal number of commits.

There are benefits to users both on client-side and server-side. In an
internal monorepo, this base branch detection algorithm is used to determine
a long-lived branch based on the HEAD commit, mapping to a group within the
organizational structure of the repository, which determines a set of
projects that the user will likely need to build; this leads to
automatically selecting an initial sparse-checkout definition based on the
build dependencies required. An upcoming feature in Azure Repos will use
this algorithm to automatically create a pull request against the correct
target branch, reducing user pain from needing to select a different branch
after a large commit diff is rendered against the default branch. This atom
unlocks that ability for Git hosting services that use Git in their backend.

Thanks, -Stolee


Updates in v2
=============

 * I had forgotten to include a documentation change in v1. My attempt to
   create a succinct doc change in a follow-up hunk continued to be
   confusing. This version includes a more expanded version of the
   documentation blurb for the is-base token.


Updates in v3
=============

 * Corrected some grammar in a commit message.
 * Fixed (and tested for) a bug where the source branch is equal to a
   candidate ref.
 * Added a test in t6500-for-each-ref.sh to cover some non-commit refs and
   some broken objects.
 * Motivated by the test in t6500, add a new patch that adds a ..._gently()
   method to reduce error noise for non-commit refs.

Derrick Stolee (4):
  commit-reach: add get_branch_base_for_tip
  commit: add gentle reference lookup method
  for-each-ref: add 'is-base' token
  p1500: add is-base performance tests

 Documentation/git-for-each-ref.txt |  42 ++++++++++
 commit-reach.c                     | 126 +++++++++++++++++++++++++++++
 commit-reach.h                     |  17 ++++
 commit.c                           |   8 +-
 commit.h                           |   2 +
 ref-filter.c                       |  77 +++++++++++++++++-
 ref-filter.h                       |  15 ++++
 t/helper/test-reach.c              |   2 +
 t/perf/p1500-graph-walks.sh        |  31 +++++++
 t/t6300-for-each-ref.sh            |   9 +++
 t/t6600-test-reach.sh              | 121 +++++++++++++++++++++++++++
 11 files changed, 448 insertions(+), 2 deletions(-)


base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1768%2Fderrickstolee%2Ftarget-ref-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1768/derrickstolee/target-ref-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1768

Range-diff vs v2:

 1:  580026f910d ! 1:  f93d642c8d9 commit-reach: add get_branch_base_for_tip
     @@ Commit message
          which branch was used as the starting point for a given commit. Add focused
          tests using the 'test-tool reach' command.
      
     -    Repositories that use pull requests (or merge requests) to advance one or
     +    In repositories that use pull requests (or merge requests) to advance one or
          more "protected" branches, the history of that reference can be recovered by
          following the first-parent history in most cases. Most are completed using
          no-fast-forward merges, though squash merges are quite common. Less common
     @@ commit-reach.c: done:
      + */
      +define_commit_slab(best_branch_base, int);
      +static struct best_branch_base best_branch_base;
     -+#define get_best(c) (*best_branch_base_at(&best_branch_base, c))
     -+#define set_best(c,v) (*best_branch_base_at(&best_branch_base, c) = v)
     ++#define get_best(c) (*best_branch_base_at(&best_branch_base, (c)))
     ++#define set_best(c,v) (*best_branch_base_at(&best_branch_base, (c)) = (v))
      +
      +int get_branch_base_for_tip(struct repository *r,
      +			    struct commit *tip,
     @@ commit-reach.c: done:
      +
      +	for (size_t i = 0; i < bases_nr; i++) {
      +		struct commit *c = bases[i];
     ++		int best = get_best(c);
      +
      +		/* Has this already been marked as best by another commit? */
     -+		if (get_best(c))
     ++		if (best) {
     ++			if (best == -1) {
     ++				/* We agree at this position. Stop now. */
     ++				best_index = i + 1;
     ++				goto cleanup;
     ++			}
      +			continue;
     ++		}
      +
      +		set_best(c, i + 1);
      +		prio_queue_put(&queue, c);
     @@ commit-reach.c: done:
      +		branch_point = parent;
      +	}
      +
     ++cleanup:
      +	clear_best_branch_base(&best_branch_base);
      +	clear_prio_queue(&queue);
      +	return best_index > 0 ? best_index - 1 : -1;
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref merged:none' '
      +	test_all_modes get_branch_base_for_tip
      +'
      +
     ++test_expect_success 'get_branch_base_for_tip: equal to tip' '
     ++	# (2,3) branched from the first tip (i,4) in X with i > 2
     ++	cat >input <<-\EOF &&
     ++		A:commit-8-4
     ++		X:commit-1-2
     ++		X:commit-1-4
     ++		X:commit-4-4
     ++		X:commit-8-4
     ++		X:commit-10-4
     ++	EOF
     ++	echo "get_branch_base_for_tip(A,X):3" >expect &&
     ++	test_all_modes get_branch_base_for_tip
     ++'
     ++
      +test_expect_success 'get_branch_base_for_tip: all reach tip' '
      +	# (2,3) branched from the first tip (i,4) in X with i > 2
      +	cat >input <<-\EOF &&
 -:  ----------- > 2:  5240c2a7b32 commit: add gentle reference lookup method
 2:  13341e7e512 ! 3:  df05cee6003 for-each-ref: add 'is-base' token
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
      +				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
      +				free(ref->is_base[is_base_atoms]);
      +			} else {
     -+				/* Not a commit. */
      +				v->s = xstrdup("");
      +			}
      +			is_base_atoms++;
     @@ ref-filter.c: void filter_ahead_behind(struct repository *r,
      +
      +	for (size_t i = 0; i < array->nr; i++) {
      +		const char *name = array->items[i]->refname;
     -+		struct commit *c = lookup_commit_reference_by_name(name);
     ++		struct commit *c = lookup_commit_reference_by_name_gently(name, 1);
      +
      +		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
      +
     @@ ref-filter.h: void filter_ahead_behind(struct repository *r,
       void ref_filter_clear(struct ref_filter *filter);
       
      
     + ## t/t6300-for-each-ref.sh ##
     +@@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref with nested tags' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'is-base atom with non-commits' '
     ++	git for-each-ref --format="%(is-base:HEAD) %(refname)" >out 2>err &&
     ++	grep "(HEAD) refs/heads/main" out &&
     ++
     ++	test_line_count = 2 err &&
     ++	grep "error: object .* is a commit, not a blob" err &&
     ++	grep "error: bad tag pointer to" err
     ++'
     ++
     + GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     + TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     + 
     +
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'get_branch_base_for_tip: all reach tip' '
       	test_all_modes get_branch_base_for_tip
     @@ t/t6600-test-reach.sh: test_expect_success 'get_branch_base_for_tip: all reach t
      +		--format="%(refname):%(is-base:commit-4-1)" --stdin
      +'
      +
     ++test_expect_success 'for-each-ref is-base: equal to tip' '
     ++	cat >input <<-\EOF &&
     ++	refs/heads/commit-4-2
     ++	refs/heads/commit-5-1
     ++	EOF
     ++	cat >expect <<-\EOF &&
     ++	refs/heads/commit-4-2:(commit-4-2)
     ++	refs/heads/commit-5-1:
     ++	EOF
     ++	run_all_modes git for-each-ref \
     ++		--format="%(refname):%(is-base:commit-4-2)" --stdin
     ++'
     ++
      +test_expect_success 'for-each-ref is-base:multiple' '
      +	cat >input <<-\EOF &&
      +	refs/heads/commit-1-1
 3:  757c20090db = 4:  cce9921bbd8 p1500: add is-base performance tests

-- 
gitgitgadget
