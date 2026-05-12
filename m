Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC07188596
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546809; cv=none; b=d+tiyW6ix6nA4vcLHebdYp7tSINjnoTb1dgJaX+UrhlW9tzeq0xeUcnZrxC9TtRoTZ9AtmYRsXCPa5Q92BNafjexJbFBEUI9Mx7DrfeImVRMX25zawZhaN4k5rTjOhuihAEQz5ilZd8ZgHoCGRT2ALmZSpp2YakfergGjvDU7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546809; c=relaxed/simple;
	bh=2AA40+wMgDzqQVpVYN3T111xoL3razCr9vU2KJ1P3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWtPAOcSWZ8mO67hW5k4HXTGaYIG2D5MxkkXPOt01zWENiCAmbxWltf9x8mtVjs/Ik8eX5pGiInGivfiymxL1aQ4ro+BSSQUgYI/K6LTKL7225ozjSXH1khPZU7etziIm1wSMch+q7/I5Cfx0hp/gwSYiVzsMeDo+mryw6NUt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oZL3SW/Z; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oZL3SW/Z"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so5275232d50.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546807; x=1779151607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=az2YwlR8ohj535KnlNAZPbNtNKgaDfqbfipZyuyWmWI=;
        b=oZL3SW/ZDiPkNpHXSHIeNNNs1VgaJbUHbzL5xICLJGam+105YMnjHIP1UhccK6zdGn
         HDkkhbEMu/lni+OypgwvwYbiE2uh0UXfDNlNxKW02DwLw6hQYuSDdYRXAeZgppEVIWzA
         X9d5nTPSv+Y+igQPIoSN9r8w41bFBrgFtXnGOGlAY33ew2yZNqzDj2L7Rv6c1hnMp+iU
         UBdjmh58tiebJbULtp2jAvcBxgbDpbTwp+87806V3U3tuwQGI+3OfMALw+a+L7Miz7l1
         YyYLlolJUiH5NL5l+JVGjnGstgSCTtsqEdkx/OA6Jtx/s83kt2uWiYBYfzTxs+lIxXZr
         RrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546807; x=1779151607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az2YwlR8ohj535KnlNAZPbNtNKgaDfqbfipZyuyWmWI=;
        b=lkz8KVxJ4aKZX9eAZLLOJc217zOflk3BzR/SMH6FJhVwMw4pBNrPUit4qV62oF2/xZ
         r9pPqUIvD9nfJ+LuCeMS/2Ww8vY1RHpx81Df8HJo8cNEa/sTJZNflXqucceZZiWPLKpC
         3HG4yidOWCPW9khkdbRuRtq1POO1ng6qZ61gStd5ZkQDINqTHCbRDePlLkfYj3cXePXU
         cNIDfbihqa0mY99PSwfQRwcqxw2FiCApThlOXtqis8iNeSGKlqg8bpRdfP+s3kqvt1Kp
         x4j91cOH+vFIzcseYeekQd2Defeyl9xwlIadD+t3KIGfZIYwqRiXYydaX2WQVsLpY0n4
         9PLw==
X-Gm-Message-State: AOJu0YyPsMpQMUM3vSYXn1eaJe/VOdSWHtqdjfRckFb/sB+wLf/XgZlZ
	K8KKKSP8tQEKAl5n43rtliHw4qXR2jJZtgT8zsvIpWa5qhPhwglNdPZu9axhNPhxg9vpeKlzJ2w
	ec93zSSmcSA==
X-Gm-Gg: Acq92OGr95M768dlQmbct5XzkH2JXj6YsPFsSqyAdaiqWzhKbdPtu1FzB3wK6fttSLU
	y/HHj5z6+8+HzaypYzo3zJwQuSlAqFjSHMqi/NtQXjbSbfDf6jHnSb/ne3pZ8H5mpXAfvfbQW3J
	62trMh5LkR77GAGQGBf8Ae4iLyMKi45qkFYubN0BfMGwj56K0lmkmfycSHxHHqpTq6O43iYmKmS
	4wRHVefh6tMAQLhbGkah161MrAL8DVa46jLq/kKlTwr7xgW/XJylGig1NtGncl24dqLtG6QVhvl
	lxgBs3AG4rSRxbVx0WFyGQLYv0tOyo3suOeGjLaab5m5qLXyBn3mk4j+zG5m7ktUBrJLc2dnDTL
	wZNO54SD1k2+o/OOABV9wndKPafUCgr4PdappGLRnAAg6zjA/3uwd0Fou8+oq64vBdBJ3Bu69SY
	W1d0eHOu1sDCs9en/B92ghLGSZ/b6Pyak7XHW8SrsTu885ge+oRhPtK1g0P8xpfmkZIsxbVo7JX
	47zE/jcIHpmkgvDwmtTaoUkOQbR9u2zvz3EyqK8f9LTkgH7fc0f4tSFH9JLjjYKeDNAq2KEY+s2
	xU0avY39JFLznMGi
X-Received: by 2002:a05:690e:43c1:b0:65d:b75e:9bc5 with SMTP id 956f58d0204a3-65de1338691mr477728d50.45.1778546806428;
        Mon, 11 May 2026 17:46:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm6253860d50.17.2026.05.11.17.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:46:45 -0700 (PDT)
Date: Mon, 11 May 2026 20:46:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/9] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <cover.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

[Note to the maintainer: this series has been rebased onto the current
tip of master, which is 7760f83b597 (Merge branch
'jc/neuter-sideband-fixup', 2026-05-11) at the time of writing].

This is a (very) small reroll of my series to fix several bugs in the
pseudo-merge bitmap implementation. The only changes since last time are:

 - consistently ordering `test_when_finished "rm -fr ..."` above `git
   init` in tests, and

 - avoiding a single Git invocation on the left-hand side of a pipe in
   the final patch

Otherwise, the series is entirely unchanged save for the above and the
rebase.

As usual, a range-diff is included below for convenience. The original
cover letter is as follows:

========================================================================

This series fixes several bugs in the pseudo-merge bitmap implementation
that caused the pseudo-merge application path to be effectively broken
during fill-in traversal.

Peff noticed that this code path was never triggered by the existing
test suite, and investigating that observation uncovered a handful of
bugs, some compounding.

The first two patches introduce test infrastructure: a 'bitmap write'
test helper that gives tests precise control over which commits receive
individual bitmaps, and a set of "test_expect_failure" tests
demonstrating each bug.

The next four patches fix the bugs in the per-commit pseudo-merge
lookup:

  - The pseudo-merge commit lookup table was sorted by OID rather than
    by bit position, causing the reader's binary search to fail.

  - The binary search in pseudo_merge_at() had its lo/hi updates
    swapped.

  - The extended pseudo-merge lookup path had three compounding bugs: a
    wrong entry-size calculation in the writer, a misinterpretation of
    extended table entries in the reader, and a silently-swallowed error
    check.

The final two patches fix issues in pseudo-merge group selection:

  - find_pseudo_merge_group_for_ref() did not parse commits before
    inspecting their dates, so all candidates had date == 0 and were
    unconditionally placed in the "stable" bucket.

  - The config validation for bitmapPseudoMerge.*.sampleRate accepted 0,
    which leads to a division by zero once the date classification is
    fixed and the unstable code path is exercised.

There is also a small fix for a regex leak when the pattern key is
overridden in config.

Thanks in advance for your review!

Taylor Blau (9):
  t/helper: add 'test-tool bitmap write' subcommand
  t5333: demonstrate various pseudo-merge bugs
  pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
  pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
  pack-bitmap: fix pseudo-merge lookup for shared commits
  pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
  pack-bitmap: reject pseudo-merge "sampleRate" of 0
  Documentation: fix broken `sampleRate` in gitpacking(7)
  pack-bitmap: prevent pattern leak on pseudo-merge re-assignment

 Documentation/config/bitmap-pseudo-merge.adoc |   4 +-
 Documentation/gitpacking.adoc                 |   4 +-
 pack-bitmap-write.c                           |  23 +-
 pseudo-merge.c                                |  19 +-
 t/helper/test-bitmap.c                        | 113 ++++++++-
 t/t5310-pack-bitmaps.sh                       |  24 ++
 t/t5333-pseudo-merge-bitmaps.sh               | 229 ++++++++++++++++++
 7 files changed, 402 insertions(+), 14 deletions(-)

Range-diff against v2:
 1:  c0df35f8ebd =  1:  9c7a829cbeb t/helper: add 'test-tool bitmap write' subcommand
 2:  11de3343726 =  2:  d1ed4aadf75 t5333: demonstrate various pseudo-merge bugs
 3:  8d908ab415e =  3:  bf3a9a07e5f pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
 4:  07f70a07c20 !  4:  a1d341c92eb pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'apply pseudo-merges during
     +test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
      	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
      	git init pseudo-merge-fill-in-multi &&
    -+	git init pseudo-merge-fill-in-multi &&
      	(
    - 		cd pseudo-merge-fill-in-multi &&
    - 
 5:  3ed0b39843f =  5:  06e3410d323 pack-bitmap: fix pseudo-merge lookup for shared commits
 6:  95f847211f3 =  6:  78cf7e6d80d pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
 7:  f8a01cfb893 =  7:  4dbf6686718 pack-bitmap: reject pseudo-merge "sampleRate" of 0
 8:  c37156502c0 =  8:  46d0ee2f168 Documentation: fix broken `sampleRate` in gitpacking(7)
 9:  b905fd5d0ae !  9:  9b17dab2cf7 pack-bitmap: prevent pattern leak on pseudo-merge re-assignment
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'sampleRate=0 does not caus
      '
      
     +test_expect_success 'duplicate pseudo-merge pattern does not leak' '
    -+	git init pseudo-merge-dup-pattern &&
     +	test_when_finished "rm -fr pseudo-merge-dup-pattern" &&
    -+
    ++	git init pseudo-merge-dup-pattern &&
     +	(
     +		cd pseudo-merge-dup-pattern &&
     +
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'sampleRate=0 does not caus
     +		git config bitmapPseudoMerge.test.threshold now &&
     +		git config bitmapPseudoMerge.test.stableThreshold never &&
     +
    -+		git rev-parse HEAD~63 |
    -+		test-tool bitmap write "$(basename $pack)" &&
    ++		git rev-parse HEAD~63 >in &&
    ++		test-tool bitmap write "$(basename $pack)" <in &&
     +
     +		test_pseudo_merges >merges &&
     +		test_line_count = 1 merges

base-commit: 7760f83b59750c27df653c5c46d0f80e44cfe02c
-- 
2.54.0.76.g9b17dab2cf7
