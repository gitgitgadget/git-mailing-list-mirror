Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A6314B96
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775933; cv=none; b=UTslrlUyzciH/b7gJo05Cy03BsIs3PpbO2Sgf+TO0WreqZL4PQhNU82L55WgJ8xzmmL4aiivyCMC6NZx7RWwV/Q875zTfNHyqA7/cNUFCM2EGcI5XPvdCCxee036Z3EFmAXeP5Ihm84Lu80xAXHjHFoDyr3gDzMxzbkGBT5k2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775933; c=relaxed/simple;
	bh=8clzVtqv8CdXID8fVzTq5Uii/7Izte3R682vnOK1sMQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qUlv3sBhy5KyT1nlMEV3A0EfDflmFSPJRU1gbnl6ckQI5GTNuHDLu3xAcF+C/GbMb1J0p+J1n0lqogm67oLV2F5wJ7WqOWhfgGmgyuwxDWAz2OSEjGFaSkaMZbvEJvUbTf6YH/RE7GOHwTte+uAx9N+MZz/9PAyu34/iNspNg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReSdKybL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReSdKybL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-366375c43c2so4834916a91.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775930; x=1779380730; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUlx7Sx1R2Iil8GMnJGa0EiWasChNfmBA12V9Oj1UZ4=;
        b=ReSdKybLmim62SuntOrWVXJE+C0GSo/TBBy0E9K6r+Sd4MNTnkHHt19BwyWY7lD8DY
         xDcB0cFjaGTFQzxeIUVbnUj1fqoJJ0kVOcAHaeFJoNVeor7mlPlZwPoqejIT8wzcZn7D
         P3lKiNuCIqooo8xdXCZwCiWE0uBc92341k+WUXi4AFM67qQICYmtZjZY5iWWBRu0g5ry
         CrKAuy58OQc/BZmyCdfe6AeTWP862EeaN4oi+O/MUNGGq0z2J8+Pq7jYMqTpfy1WTlPt
         4hdPy7/49+JpQcRP9co6h9h+KfSIkTgNAUgEkARaySv+tAXSMm1E5bJf9HxcaxYTapNm
         rWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775930; x=1779380730;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oUlx7Sx1R2Iil8GMnJGa0EiWasChNfmBA12V9Oj1UZ4=;
        b=pYOslpoQGgNGpAOIo62AkyuHmXhE/SKdEpjFtW6kwJqIypuKgAuMlmSQLMtiVWmqY/
         DLE4PNOFhRiA+qMMsxNYRxZBoZEK5u5SqHT1OfbcnYdNw1kNfz7aGfEOoJWBSW/AT3ai
         eNwAJZO3MFumhosC4DtTcI3iVRyKK+SFdGwPVp6+yb0xA1D260tppV3yywQ5MQSSGoD8
         V+Cm57bIXy9lxyjS9n1mvLSd6cxIIOl+Dp7eNpZn1zeEAIwF+2wCY4ZQ8LkFBpaclIM1
         AhHkqScoDBTTn2LeQOqZLqWGgi9c7R1jF7TBiTO+Iv2m4efpi2rOPN5CJininmM9U09H
         w8Ow==
X-Gm-Message-State: AOJu0YxikfnSeYqwo/KfbriCb2ODS3bhibh0kd4EfzCRFZTvBlHGKcPE
	wELnEDcmRhbqtJs1txnuHV/1RHYqWsGLhalC/+HMa7ErDvRDAAGfV4uYMdhC2A==
X-Gm-Gg: Acq92OH9HmBIi+s9uGIqRq7F8YjTymQ+18AI8xnYZV/6zKJhKFXLI5AVD/7jjWNS6c2
	a5cjhZxaqS82daU4kuMM27+4K7x8m/KIm20b9NSRJBksZxl4rNk28ybsVh41e/t2hux3mQRFk8e
	mO0RkXuQPWbEvYLrArFJ+4YwSYnJBHWaR9kMv2PmhDBDqyiak406b53VMD7cNKVMPpFF1IL4Pq6
	LgroA8nJohLCQZNweIkGFnH0GU2D3GqiJOxHm6if4Aj6rV8znBu/ixRQOehy27LaoXysbNRmrBM
	FJe3ICEwQHXePg6QAA0zD3htiOQUrr3h9zMfr5h5aUZm4+ULkwZVr8MZEoyxlgNUHXBdLveiucs
	KjGeVPasd+TMKKtWEviEu87sFSIY/D/atBTxxUWUG6j5WBizvwJzzsgcb7hsakf4cvvzztQL0jk
	PjyTGZ2ZuRCqJcdcIO1GBPQCc1
X-Received: by 2002:a17:90b:1f8c:b0:35e:3103:d4d8 with SMTP id 98e67ed59e1d1-369518b2048mr132069a91.6.1778775930150;
        Thu, 14 May 2026 09:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517aadb1sm75681a91.9.2026.05.14.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:25:29 -0700 (PDT)
Message-Id: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:25:24 +0000
Subject: [PATCH v3 0/4] Batch prefetching
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v2:

 * Modified the final patch as suggested by Stolee to include pathspec usage
   in the testcase
 * Modified the last two patches to not re-download blobs we already have
   locally, and adjusted the tests to verify
 * Inserted a new first patch, containing a documentation addition that
   would have helped me avoid making the above mistake in the first place.

Note: Stolee also suggest some code sharing or code movement in his review
of v2 2/3, but possibly based on a misunderstanding of v2 2/3 (that patch
isn't about a diff) and it's not clear to me what could be shared or moved,
so that's not part of this round.

Changes since v1:

 * Remove stray file that should have never been added. So embarrassing that
   I didn't catch that before submitting.


Original cover-letter:
======================

Partial clones provide a trade-off for users: avoid downloading blobs
upfront, at the expense of needing to download them later as they run other
commands. This tradeoff can sometimes incur a more severe cost than
expected, particularly if needed blobs are discovered as they are accessed,
resulting in downloading blobs one at a time. Some commands like checkout,
diff, and merge do batch prefetches of necessary blobs, since that can
dramatically reduce the pain of on-demand loading. Extend this ability to
two more commands: cherry and grep.

This series was spurred by a report where git cherry jobs were each doing
hundreds of single-blob fetches, at a cost of 3s each. Batching those
downloads should dramatically speed up their jobs. (And I decided to fix up
git grep similarly while at it.)

I'll also note that git backfill with revisions and/or pathspecs could also
improve things for these users, but since backfill is a manual command users
would have to run and requires users to try to figure out which data is
needed (a challenge in the case of cherry), it still makes sense to provide
smarter behavior for folks who don't choose to manually run backfill.

Also, correct a documentation typo I noticed in patch-ids.h (related to code
I was using for the git cherry fixes) as a preparatory fixup.

Elijah Newren (4):
  promisor-remote: document caller filtering contract
  patch-ids.h: add missing trailing parenthesis in documentation comment
  builtin/log: prefetch necessary blobs for `git cherry`
  grep: prefetch necessary blobs

 builtin/grep.c    | 143 ++++++++++++++++++++++++++++++++++++++++++++++
 builtin/log.c     | 131 ++++++++++++++++++++++++++++++++++++++++++
 patch-ids.h       |   2 +-
 promisor-remote.h |  11 ++++
 t/t3500-cherry.sh |  27 +++++++++
 t/t7810-grep.sh   |  58 +++++++++++++++++++
 6 files changed, 371 insertions(+), 1 deletion(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2089%2Fnewren%2Fbatch-prefetching-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2089/newren/batch-prefetching-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2089

Range-diff vs v2:

 -:  ---------- > 1:  6ad11e2c28 promisor-remote: document caller filtering contract
 1:  663816a344 = 2:  08a2c6517b patch-ids.h: add missing trailing parenthesis in documentation comment
 2:  a705852723 ! 3:  c0655e5d41 builtin/log: prefetch necessary blobs for `git cherry`
     @@ builtin/log.c: static void print_commit(char sign, struct commit *commit, int ve
      +		if (drv && drv->binary > 0)
      +			continue;
      +
     -+		if (DIFF_FILE_VALID(p->one))
     ++		if (DIFF_FILE_VALID(p->one) &&
     ++		    odb_read_object_info_extended(opts->repo->objects,
     ++						  &p->one->oid, NULL,
     ++						  OBJECT_INFO_FOR_PREFETCH))
      +			oidset_insert(blobs, &p->one->oid);
     -+		if (DIFF_FILE_VALID(p->two))
     ++		if (DIFF_FILE_VALID(p->two) &&
     ++		    odb_read_object_info_extended(opts->repo->objects,
     ++						  &p->two->oid, NULL,
     ++						  OBJECT_INFO_FOR_PREFETCH))
      +			oidset_insert(blobs, &p->two->oid);
      +	}
      +	diff_queue_clear(q);
     @@ t/t3500-cherry.sh: test_expect_success 'cherry ignores whitespace' '
      +
      +		grep "child_start.*fetch.negotiationAlgorithm" trace.output >fetches &&
      +		test_line_count = 1 fetches &&
     -+		test_trace2_data promisor fetch_count 4 <trace.output
     ++		test_trace2_data promisor fetch_count 4 <trace.output &&
     ++
     ++		# A second invocation should not refetch any blobs, since
     ++		# the prefetch is expected to filter out OIDs that are
     ++		# already present locally.
     ++		GIT_TRACE2_EVENT="$(pwd)/trace2.output" git cherry upstream-with-space feature-without-space >actual &&
     ++		test_cmp ../expect actual &&
     ++
     ++		! grep "child_start.*fetch.negotiationAlgorithm" trace2.output &&
     ++		! grep "\"key\":\"fetch_count\"" trace2.output
      +	)
      +'
      +
 3:  8fbfe69bc4 ! 4:  75d4ca7cff grep: prefetch necessary blobs
     @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec
      +		strbuf_add(base, entry.path, tree_entry_len(&entry));
      +
      +		if (S_ISREG(entry.mode)) {
     -+			oidset_insert(blob_oids, &entry.oid);
     ++			if (!odb_has_object(repo->objects, &entry.oid, 0))
     ++				oidset_insert(blob_oids, &entry.oid);
      +		} else if (S_ISDIR(entry.mode)) {
      +			enum object_type type;
      +			struct tree_desc sub_tree;
     @@ t/t7810-grep.sh: test_expect_success 'grep does not report i-t-a and assume unch
       	test_cmp expected actual
       '
       
     -+test_expect_success 'grep of revision in partial clone does bulk prefetch' '
     ++test_expect_success 'grep of revision in partial clone batches prefetch and honors pathspec' '
      +	test_when_finished "rm -rf grep-partial-src grep-partial" &&
      +
      +	git init grep-partial-src &&
     @@ t/t7810-grep.sh: test_expect_success 'grep does not report i-t-a and assume unch
      +		cd grep-partial-src &&
      +		git config uploadpack.allowfilter 1 &&
      +		git config uploadpack.allowanysha1inwant 1 &&
     -+		echo "needle in haystack" >searchme &&
     -+		echo "no match here" >other &&
     -+		mkdir subdir &&
     -+		echo "needle again" >subdir/deep &&
     ++		mkdir a b &&
     ++		echo "needle in haystack" >a/matches.txt &&
     ++		echo "nothing to see here" >a/nomatch.txt &&
     ++		echo "needle again" >b/matches.md &&
      +		git add . &&
      +		git commit -m "initial"
      +	) &&
     @@ t/t7810-grep.sh: test_expect_success 'grep does not report i-t-a and assume unch
      +	git clone --no-checkout --filter=blob:none \
      +		"file://$(pwd)/grep-partial-src" grep-partial &&
      +
     -+	# All blobs should be missing after a blobless clone.
     ++	# All three blobs are missing immediately after a blobless clone.
      +	git -C grep-partial rev-list --quiet --objects \
      +		--missing=print HEAD >missing &&
      +	test_line_count = 3 missing &&
      +
     -+	# grep HEAD should batch-prefetch all blobs in one request.
     -+	GIT_TRACE2_EVENT="$(pwd)/grep-trace" \
     ++	# A pathspec-limited grep should prefetch only the two blobs
     ++	# in a/.  It should fetch both blobs in one batched request.
     ++	GIT_TRACE2_EVENT="$(pwd)/grep-trace-pathspec" \
     ++		git -C grep-partial grep -c "needle" HEAD -- "a/*.txt" >result &&
     ++
     ++	# Only a/matches.txt contains "needle" among the matched paths.
     ++	test_line_count = 1 result &&
     ++
     ++	# Exactly the two a/*.txt blobs should have been requested, and
     ++	# the server packed those two objects in the response.
     ++	test_trace2_data promisor fetch_count 2 <grep-trace-pathspec &&
     ++	test_trace2_data pack-objects written 2 <grep-trace-pathspec &&
     ++
     ++	# b/matches.md should still be missing locally.
     ++	git -C grep-partial rev-list --quiet --objects \
     ++		--missing=print HEAD >missing &&
     ++	test_line_count = 1 missing &&
     ++
     ++	# A second grep without a pathspec must recurse into both
     ++	# subdirectories, but should request only the still-missing blob
     ++	# from the promisor.
     ++	GIT_TRACE2_EVENT="$(pwd)/grep-trace-all" \
      +		git -C grep-partial grep -c "needle" HEAD >result &&
      +
     -+	# Should find matches in two files.
      +	test_line_count = 2 result &&
     ++	test_trace2_data promisor fetch_count 1 <grep-trace-all &&
     ++	test_trace2_data pack-objects written 1 <grep-trace-all &&
      +
     -+	# Should have prefetched all 3 objects at once
     -+	test_trace2_data promisor fetch_count 3 <grep-trace
     ++	# Everything is local now.
     ++	git -C grep-partial rev-list --quiet --objects \
     ++		--missing=print HEAD >missing &&
     ++	test_line_count = 0 missing
      +'
      +
       test_done

-- 
gitgitgadget
