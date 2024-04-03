Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D8161
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103643; cv=none; b=naTA+TzBYycvj9tz0xJFU/x1uxxR0K/o+qr33rYIiflcucmbRGun1dDlUbUpnUU0EsyJfK3L0CUuZgU+oaPYMvoPVNOV2eQWcNPr/na4WwvmbjS/kAWllCWG/yUYEiBnYauzxCuAWtBmv8iCrA7Nu1dSljnJhcX/vTrzj4Jhy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103643; c=relaxed/simple;
	bh=2EXiN4M78flz5ln7K12IM7VciIvJB9DqizjdHR/9qDA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NFZAKCFg64Szks+6F8cxKmlxvaA20EM60RP9gjAR9Bhd3ordqCheeVQa4W7XxHBkGra8UjXLG8NxNyWpnP6w/fxibS2/yfMEnGzrSC22btu3DT3H9okpyHx8PR9vpxl/Ndi1azF2554Hdpl1MIfnDxkYedq3zEyy6phiMEZdFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwEpJBkN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwEpJBkN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4161b7d15c0so8839915e9.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712103638; x=1712708438; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqZT/bTCYR+IiyXhRGi5546cpozcA6e61WEJM3TjrCI=;
        b=iwEpJBkNzknuaqlJPu0njMszlq/ibIG+rTNx0P9vlwBknnOtZmpZ0NNKdX0jliDbhd
         8LaV2FN3y6gvJankpyo05esf2aJYGf0zv5HZa0XbiLJx+82YQ4ZYgw0cU08sAOcn9G7x
         QY4COcVejMnPsFe5vkMqdSeB0EyAJR9uW5CRyRf15YpcMbI3Z2R8YSz+Bj6W96o7HX4T
         rvKF8opqkX1ULO/SLGyROxJCeTC7Kuc6BmJFPhI6FDo/HeNrcg29UUoy9/aVqmb0o+So
         sN+tXiC8mXjqxqtaWVu+X8m4SEo1VqrNFdRq3ywVdP9H7ON1gVBgiUe1ZubT/y7Rot+W
         AphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103638; x=1712708438;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqZT/bTCYR+IiyXhRGi5546cpozcA6e61WEJM3TjrCI=;
        b=On42joDIeRKbwhIGnj9gK/S/D4fYwxf7LE8IEu7zYEFkwZpJAme/kJ6YAdJ3dw5IZi
         Tsp4o+JDVuoxnMl35gZfFSh/Wav/pEErGvshGqptcs0ruzLId7wdG/7m7+9lGjvgXeuF
         D1bhzmiweZUe4n/ewz3jzCkiRdhb4viuULCSR0LGSTBWDleyvyyiPrAu+Y2v+N65YegS
         MlJIDvQsH8wNY64BK8oQTS3DN88LKIKWG0QgltkVv/bZ5RkTrLdrmqeLBnpUy6tjKmO7
         8092QNWqIQe9cyxRI1GV7UKdCxgI+ywdUNXga/XBo4oO/T+V0ci/C5p62F6BCQgwtvJ4
         ySgQ==
X-Gm-Message-State: AOJu0YypAJjWiyWaX6FXbKYgxlGkUw3CvR5y1EZ/zb9AnbscJLfSvpa5
	hsgRdgkJaD+tl04Mm0LL0RVBf0NUXEnPHNKb/f+rZW4yU2odMVKQVLAWbvdQ
X-Google-Smtp-Source: AGHT+IE3D0R3eIWilpFFKgRWXPCeMFPqnA+ejgymPIbXuCpIcBgUGMC2tfh/OAQ7NuV9VMgQzyMQ0Q==
X-Received: by 2002:a05:600c:3ca9:b0:413:f7c4:f4fc with SMTP id bg41-20020a05600c3ca900b00413f7c4f4fcmr9771478wmb.15.1712103638385;
        Tue, 02 Apr 2024 17:20:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0041401eb021asm19534899wmq.24.2024.04.02.17.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:20:37 -0700 (PDT)
Message-Id: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Apr 2024 00:20:34 +0000
Subject: [PATCH v4 0/2] reftable/stack: use geometric table compaction
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the fourth version my patch series that refactors the reftable
compaction strategy to instead follow a geometric sequence. Changes compared
to v3:

 * Changed env name from GIT_TEST_REFTABLE_NO_AUTOCOMPACTION to
   GIT_TEST_REFTABLE_AUTOCOMPACTION and set the default to false. This
   should hopefully be a bit more intuitive since it avoids the double
   negative.
 * Updated the corresponding env var test in t0610-reftable-basics.sh to
   assert on the number of tables added and be overall less fragile.
 * Folded lines that were too long.
 * Updated some comments in stack.c to more accurately explain that table
   segment end is exclusive.
 * Dropped reftable/stack: make segment end inclusive commit to keep segment
   end exclusive and better follow expectations.

Thanks for taking a look!

-Justin

Justin Tobler (2):
  reftable/stack: add env to disable autocompaction
  reftable/stack: use geometric table compaction

 reftable/stack.c           | 126 +++++++++++++++++++------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  66 ++++---------------
 reftable/system.h          |   1 +
 t/t0610-reftable-basics.sh |  65 +++++++++++++++----
 5 files changed, 132 insertions(+), 129 deletions(-)


base-commit: c75fd8d8150afdf836b63a8e0534d9b9e3e111ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

Range-diff vs v3:

 1:  2fdd8ea1133 ! 1:  2a0421e5f20 reftable/stack: add env to disable autocompaction
     @@ Commit message
      
          In future tests it will be neccesary to create repositories with a set
          number of tables. To make this easier, introduce the
     -    `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
     -    set, disables autocompaction of reftables.
     +    `GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, when set
     +    to false, disables autocompaction of reftables.
      
          Signed-off-by: Justin Tobler <jltobler@gmail.com>
      
     @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
       		goto done;
       
      -	if (!add->stack->disable_auto_compact)
     -+	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))
     ++	if (!add->stack->disable_auto_compact &&
     ++	    git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
       		err = reftable_stack_auto_compact(add->stack);
       
       done:
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause a
       	test_line_count = 1 repo/.git/reftable/tables.list
       '
       
     -+test_expect_success 'ref transaction: environment variable disables auto-compaction' '
     ++test_expect_success 'ref transaction: env var disables compaction' '
      +	test_when_finished "rm -rf repo" &&
      +
      +	git init repo &&
      +	test_commit -C repo A &&
     -+	for i in $(test_seq 20)
     ++
     ++	start=$(wc -l <repo/.git/reftable/tables.list) &&
     ++	iterations=5 &&
     ++	expected=$((start + iterations)) &&
     ++
     ++	for i in $(test_seq $iterations)
      +	do
     -+		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
     ++		GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     ++		git -C repo update-ref branch-$i HEAD || return 1
      +	done &&
     -+	test_line_count = 23 repo/.git/reftable/tables.list &&
     ++	test_line_count = $expected repo/.git/reftable/tables.list &&
      +
      +	git -C repo update-ref foo HEAD &&
     -+	test_line_count = 1 repo/.git/reftable/tables.list
     ++	test_line_count -lt $expected repo/.git/reftable/tables.list
      +'
      +
       check_fsync_events () {
 2:  7e62c2286ae ! 2:  e0f4d0dbcc1 reftable/stack: use geometric table compaction
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      -		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev]))
      +	/*
      +	 * Find the ending table of the compaction segment needed to restore the
     -+	 * geometric sequence.
     ++	 * geometric sequence. Note that the segment end is exclusive.
      +	 *
      +	 * To do so, we iterate backwards starting from the most recent table
      +	 * until a valid segment end is found. If the preceding table is smaller
      +	 * than the current table multiplied by the geometric factor (2), the
     -+	 * current table is set as the compaction segment end.
     ++	 * compaction segment end has been identified.
      +	 *
      +	 * Tables after the ending point are not added to the byte count because
      +	 * they are already valid members of the geometric sequence. Due to the
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      +	 * Example table size sequence requiring no compaction:
      +	 * 	64, 32, 16, 8, 4, 2, 1
      +	 *
     -+	 * Example compaction segment end set to table with size 3:
     ++	 * Example table size sequence where compaction segment end is set to
     ++	 * the last table. Since the segment end is exclusive, the last table is
     ++	 * excluded during subsequent compaction and the table with size 3 is
     ++	 * the final table included:
      +	 * 	64, 32, 16, 8, 4, 3, 1
      +	 */
      +	for (i = n - 1; i > 0; i--) {
     @@ reftable/stack_test.c: static void test_empty_add(void)
      +	int l = 0;
      +	if (sz == 0)
      +		return 0;
     -+	for (; sz; sz /= 2) {
     ++	for (; sz; sz /= 2)
      +		l++;
     -+	}
      +	return l - 1;
      +}
      +
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause a
       
       	test_commit -C repo --no-tag B &&
       	test_line_count = 1 repo/.git/reftable/tables.list
     -@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: environment variable disables auto-compact
     - 	do
     - 		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
     - 	done &&
     --	test_line_count = 23 repo/.git/reftable/tables.list &&
     -+	test_line_count = 22 repo/.git/reftable/tables.list &&
     - 
     - 	git -C repo update-ref foo HEAD &&
     - 	test_line_count = 1 repo/.git/reftable/tables.list
     +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: env var disables compaction' '
     + 	test_line_count -lt $expected repo/.git/reftable/tables.list
       '
       
      +test_expect_success 'ref transaction: alternating table sizes are compacted' '
      +	test_when_finished "rm -rf repo" &&
     ++
      +	git init repo &&
      +	test_commit -C repo A &&
     -+	for i in $(test_seq 20)
     ++	for i in $(test_seq 5)
      +	do
      +		git -C repo branch -f foo &&
      +		git -C repo branch -d foo || return 1
     @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-refs in main rep
       	test_when_finished "rm -rf repo worktree" &&
       	git init repo &&
       	test_commit -C repo A &&
     --	git -C repo worktree add ../worktree &&
     -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
     -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
     ++
     ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     + 	git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     ++	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
       
      -	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
      -	test_line_count = 4 repo/.git/reftable/tables.list &&
     @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-refs in worktree
       	test_when_finished "rm -rf repo worktree" &&
       	git init repo &&
       	test_commit -C repo A &&
     --	git -C repo worktree add ../worktree &&
     -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
     -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
     ++
     ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     + 	git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     ++	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
       
      -	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
      -	test_line_count = 4 repo/.git/reftable/tables.list &&
     @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-refs in worktree
       '
       
       test_expect_success 'worktree: creating shared ref updates main stack' '
     - 	test_when_finished "rm -rf repo worktree" &&
     - 	git init repo &&
     - 	test_commit -C repo A &&
     -+	test_commit -C repo B &&
     - 
     - 	git -C repo worktree add ../worktree &&
     - 	git -C repo pack-refs &&
      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: creating shared ref updates main stack' '
       	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
       	test_line_count = 1 repo/.git/reftable/tables.list &&
       
     --	git -C worktree update-ref refs/heads/shared HEAD &&
     -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/heads/shared HEAD &&
     ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
     + 	git -C worktree update-ref refs/heads/shared HEAD &&
       	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
       	test_line_count = 2 repo/.git/reftable/tables.list
     - '
 3:  9a33914c852 < -:  ----------- reftable/stack: make segment end inclusive

-- 
gitgitgadget
