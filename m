Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB625393E
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082980; cv=none; b=lkO77i+2X59UAgtSSrYHQL72eWw4j6IQcE1Wzk2aI7PYj94BRSFJd6n/Sd1jKFbvzPRF4o47pH8+XAQOfEiRm/1VF1EFhq82pJ0foDUplfRoqoO7Y6W0gq05PKfzyncfAUD08WQ8hXbm0jUOgQ9pdkVQv9rEb7PujV0x8y5kcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082980; c=relaxed/simple;
	bh=FHbRQKWzfUbwzpFfPVOeGSCWhkPw/ILleunAQY4mzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVVq4NdLQ6aPlaeyyHqXlV1MfYXtI2MBYc+L/FU44Qd4aR1muEwv+ls5wlxVbQXhL1ATa39L6S3Rn6Lb8EBgKiEUxg/u3JHFFQ4IcpbvILG3z7dBI2aH7kXHNAulZmbW73RsV2LOeZqdkFR3RJTaUoqFHLA0B+90jYEurMBqjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cf6OzooU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cf6OzooU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fd8446a1cdso35183487b3.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782082978; x=1782687778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xpwpuxvDq4FgLgOdTc57J/+E9kvmjLag/QlF871yCk=;
        b=cf6OzooUpeYj5h8Iu2bfsss5ckTDSdxbL53/yiaSOsYuBEWbrB2feNQWHRly3QnJEL
         qQjENL3bIFrzm0YYWdn7DjSJ8nustlRNOS1scE/xG8O9+VR0iouFoZbmkk3GCShgBc1o
         lmQOTLN4J73+FCyw7BsnVeS+Blt7wu6GCzbyZ5xOMbl3q7JoavEvevO3dVvfDEOKP2wD
         n8sLNYQ52gTiY2Rl+0hEBf4R9pW0AWrQCrpXVn6YEBraFvqTNhtVY0BmbSHoqvd2pFUt
         wnY7fxMilEisXy0faIXAD6eBvQlem6uSUqep47bws/DAkJBSKzkJDdCa3DlCaN1xj3hO
         xZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782082978; x=1782687778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xpwpuxvDq4FgLgOdTc57J/+E9kvmjLag/QlF871yCk=;
        b=UO+5ozu5wrvalVB+VoqFQuGqCYzbP53Ne4W0k2r2d152i/IMLhtMhupWuzm9K2FZf0
         HbJvXQwC56AVlupOdwVnoU5G+DnPibGSkj2CNYT1dO/Z8NM8AQrlQ5XrEsoXaYMy0uFh
         cjeeLyt8l/aUn6kQnE5DtsuHPmdMLpX697rqQ9nalvmq7JKjns2kNPCirwrh4PkWCst3
         bASX1UWu1s692VJVko7Pqbp3r2pyucv45pBGZAh6nS4neKwf6nhWOlO0ieY1a12WNiJc
         YaRn/7gtPl7cHHojT2bq3OVjvKMZ1QEQR2LpcTfTScTcdFnXJQ7+rxZ0kl2Z7vdOvFzM
         ypMQ==
X-Gm-Message-State: AOJu0Yws8B2B2HSV40E9aKdkp544/d7SgNxUE7sgmSGCmZbGKKgsyTsP
	a02dQvJagY0Whgr/YZuJqPr0ptxQs7Q4jyQhwmH7fwer/+fCBK9VXLMZWsp5U8TgLM64N6RIrWj
	mN/sxVr+HLA==
X-Gm-Gg: AfdE7cluQwc+QzmKn18egZhGSZ0SV1R3S/QWPVkejcq8JfY3zW4sH8qjPqGp00EuDmy
	rCF4HbMfy4Oxk9v6DPfI5bYHzjAG9rp/9s8P5FVdk0zD8r/MuLSd4IdgeYzR5iZ8gfKGnktCI8W
	b5dmcIXjMB70JihMAOcGh9NLOQm7mJjH8f4+ZfrEV2DBn6VDOcI+n70i/tTq4mwzkUzpZQ4/0PA
	aJJUtiLm2e3IqR6EEPpBsrH2tVssa+kXToiXAzKgqIu97Qu+468IAH1Pq9kanSXC7Pm+h0ujX07
	qDBHH2OXYHP1QKq1aTQSd3CEFmJX78lclxZw+psiseiPWMyj3hkVb85a8AolObptTLF9/ARQT3Z
	2TdbZp38L9JrBVkLKNAqS0avwJzSAqH3GMP2S+EEbJS4gXBrc1FMMdRmysZRYP86/l4U7DqMtqn
	N0p658amTRyB4Wz6f8RCjA8SL58zWBNV/F4yYhfyzQFnbI51wDa4h0zSIdZllsQd4JtOdxkF6Yg
	uApZyCbwY0rteEiC7OW7/JskGaidFp5gu97JbEl6/X9wFlb7Y7ql8SA5dld/d89TRnDIFLGjoAp
	Jgia1w==
X-Received: by 2002:a05:690c:dd4:b0:7ff:13d8:bc65 with SMTP id 00721157ae682-801336f584fmr127944437b3.39.1782082978070;
        Sun, 21 Jun 2026 16:02:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f9d7df6sm24779957b3.32.2026.06.21.16.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:02:57 -0700 (PDT)
Date: Sun, 21 Jun 2026 19:02:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/4] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
Message-ID: <cover.1782082975.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>

Note to the maintainer:

 * This series is still based on 'ds/path-walk-filters' with Patrick's
   'ps/clang-w-glibc-2.43-and-_Generic' merged in.

Here is another small reroll of my series to make `--path-walk` work
with reachability bitmaps and delta-islands.

This round addresses Stolee's request to demonstrate the repack-size
side of the integration between `--path-walk` and bitmap writing, and
fixes an errant "grep" in the test suite.

Changes since v2 include:

 * p5311 now forces a fresh repack with '-F' when building its bitmapped
   test repository. This avoids reusing deltas from a non-'--path-walk'
   pack when we are trying to measure a pack produced by `--path-walk`.

 * p5311 now records the size of the bitmapped pack, both with and
   without `--path-walk`, to show that writing bitmaps during a
   `--path-walk` repack does not lose the pack-size improvement that
   `--path-walk` provides in repositories where it helps.

 * The second patch's commit message has updated p5311 numbers from a
   recent fluentui clone, fixing the "pack sizes" typo and documenting
   the new bitmapped-pack-size comparison.

 * The t5310 grep assertion now uses `test_grep`, as suggested by Junio.

Outside of the above, the series is functionally unchanged.

Thanks in advance for another look.

Taylor Blau (4):
  t/perf: drop p5311's lookup-table permutation
  pack-objects: support reachability bitmaps with `--path-walk`
  pack-objects: extract `record_tree_depth()` helper
  pack-objects: support `--delta-islands` with `--path-walk`

 Documentation/git-pack-objects.adoc | 12 ++---
 builtin/pack-objects.c              | 68 +++++++++++++++++++++--------
 t/perf/p5311-pack-bitmaps-fetch.sh  | 24 ++++++----
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++
 t/t5320-delta-islands.sh            | 29 ++++++++++++
 5 files changed, 138 insertions(+), 31 deletions(-)

Range-diff against v2:
1:  52d63e8910e = 1:  b1dbf30ddbe t/perf: drop p5311's lookup-table permutation
2:  ffad584a43e ! 2:  1884f495809 pack-objects: support reachability bitmaps with `--path-walk`
    @@ Commit message
            bitmap can answer the request, use it; otherwise fall back to
            path-walk's own enumeration.
     
    -    As a result, we can see significantly reduced pack sizes from p5311
    -    before this commit:
    +    As a result, we can see significantly reduced pack generation times from
    +    p5311 (with our `GIT_PERF_REPO` set to a recent clone of the fluentui
    +    repository) before this commit:
     
    -        Test                                      HEAD^             HEAD
    -        ----------------------------------------------------------------------------------
    -        5311.38: server (1 days, --path-walk)     2.56(2.52+0.03)   0.01(0.01+0.00) -99.6%
    -        5311.39: size   (1 days, --path-walk)              123.9K            123.9K +0.0%
    -        5311.40: client (1 days, --path-walk)     0.00(0.01+0.00)   0.00(0.00+0.00) =
    -        5311.42: server (2 days, --path-walk)     2.57(2.52+0.05)   0.01(0.01+0.00) -99.6%
    -        5311.43: size   (2 days, --path-walk)              123.9K            123.9K +0.0%
    -        5311.44: client (2 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    -        5311.46: server (4 days, --path-walk)     2.58(2.51+0.07)   0.01(0.01+0.00) -99.6%
    -        5311.47: size   (4 days, --path-walk)              123.9K            123.9K +0.0%
    -        5311.48: client (4 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    -        5311.50: server (8 days, --path-walk)     2.58(2.53+0.04)   0.02(0.02+0.00) -99.2%
    -        5311.51: size   (8 days, --path-walk)              152.4K            152.4K +0.0%
    -        5311.52: client (8 days, --path-walk)     0.00(0.01+0.00)   0.00(0.01+0.00) =
    -        5311.54: server (16 days, --path-walk)    2.58(2.52+0.05)   0.03(0.02+0.00) -98.8%
    -        5311.55: size   (16 days, --path-walk)             205.3K            205.3K +0.0%
    -        5311.56: client (16 days, --path-walk)    0.01(0.01+0.00)   0.01(0.01+0.00) +0.0%
    -        5311.58: server (32 days, --path-walk)    2.59(2.53+0.06)   0.03(0.03+0.00) -98.8%
    -        5311.59: size   (32 days, --path-walk)             209.3K            209.3K +0.0%
    -        5311.60: client (32 days, --path-walk)    0.01(0.02+0.00)   0.01(0.02+0.00) +0.0%
    -        5311.62: server (64 days, --path-walk)    2.70(2.76+0.06)   0.16(0.24+0.04) -94.1%
    -        5311.63: size   (64 days, --path-walk)               4.1M              4.1M +0.0%
    -        5311.64: client (64 days, --path-walk)    0.44(0.50+0.02)   0.44(0.51+0.02) +0.0%
    -        5311.66: server (128 days, --path-walk)   2.88(3.20+0.05)   0.34(0.65+0.05) -88.2%
    -        5311.67: size   (128 days, --path-walk)              9.0M              9.0M -0.0%
    -        5311.68: client (128 days, --path-walk)   0.93(1.22+0.07)   0.93(1.20+0.08) +0.0%
    +        Test                                            HEAD^             HEAD
    +        ----------------------------------------------------------------------------------------
    +        5311.40: server (1 days, --path-walk)           1.43(1.39+0.04)   0.01(0.01+0.00) -99.3%
    +        5311.41: size   (1 days, --path-walk)                    139.6K            139.7K +0.0%
    +        5311.42: client (1 days, --path-walk)           0.02(0.02+0.00)   0.02(0.02+0.00) +0.0%
    +        5311.44: server (2 days, --path-walk)           1.43(1.39+0.04)   0.01(0.00+0.00) -99.3%
    +        5311.45: size   (2 days, --path-walk)                    139.6K            139.7K +0.0%
    +        5311.46: client (2 days, --path-walk)           0.02(0.02+0.00)   0.02(0.02+0.00) +0.0%
    +        5311.48: server (4 days, --path-walk)           1.44(1.39+0.04)   0.01(0.01+0.00) -99.3%
    +        5311.49: size   (4 days, --path-walk)                    238.1K            238.1K +0.0%
    +        5311.50: client (4 days, --path-walk)           0.03(0.03+0.00)   0.03(0.03+0.00) +0.0%
    +        5311.52: server (8 days, --path-walk)           1.43(1.39+0.03)   0.01(0.00+0.00) -99.3%
    +        5311.53: size   (8 days, --path-walk)                    344.9K            344.9K +0.0%
    +        5311.54: client (8 days, --path-walk)           0.07(0.07+0.00)   0.07(0.08+0.00) +0.0%
    +        5311.56: server (16 days, --path-walk)          1.47(1.44+0.03)   0.10(0.08+0.01) -93.2%
    +        5311.57: size   (16 days, --path-walk)                   844.0K            844.0K +0.0%
    +        5311.58: client (16 days, --path-walk)          0.09(0.09+0.00)   0.09(0.09+0.00) +0.0%
    +        5311.60: server (32 days, --path-walk)          1.52(1.50+0.05)   0.14(0.15+0.02) -90.8%
    +        5311.61: size   (32 days, --path-walk)                     4.2M              4.2M +0.1%
    +        5311.62: client (32 days, --path-walk)          0.34(0.48+0.02)   0.34(0.45+0.05) +0.0%
    +        5311.64: server (64 days, --path-walk)          1.55(1.52+0.06)   0.15(0.15+0.04) -90.3%
    +        5311.65: size   (64 days, --path-walk)                     6.4M              6.4M -0.0%
    +        5311.66: client (64 days, --path-walk)          0.51(0.79+0.05)   0.51(0.80+0.06) +0.0%
    +        5311.68: server (128 days, --path-walk)         1.59(1.57+0.06)   0.16(0.21+0.01) -89.9%
    +        5311.69: size   (128 days, --path-walk)                    8.4M              8.4M -0.0%
    +        5311.70: client (128 days, --path-walk)         0.72(1.44+0.08)   0.71(1.47+0.09) -1.4%
     
         We get the same size of output pack, but this commit allows us to do so
         in a significantly shorter amount of time. Intuitively, we're generating
    @@ Commit message
         '--path-walk' traversal), but are able to perform pack-reuse on that
         repacked state via bitmaps.
     
    +    When comparing the size of the repacked pack with/without '--path-walk'
    +    on the previous commit versus this one, we see that (a) the repacked size
    +    improves significantly with '--path-walk', and that (b) writing bitmaps
    +    during repacking does not regress this improvement:
    +
    +        Test                                            HEAD^             HEAD
    +        ----------------------------------------------------------------------------------------
    +        5311.3: size of bitmapped pack                           558.4M            558.5M +0.0%
    +        5311.38: size of bitmapped pack (--path-walk)            164.4M            164.4M +0.0%
    +
    +    (Note that to observe an improvement here, we must repack with '-F' in
    +    order to avoid reusing non-'--path-walk' deltas, which would otherwise
    +    skew our results.)
    +
         There is one wrinkle when it comes to '--boundary', which we must not
         pass into the bitmap walk in the presence of both '--path-walk' and
         '--use-bitmap-index'. Path-walk needs boundary commits when it performs
    @@ t/perf/p5311-pack-bitmaps-fetch.sh: test_description='performance of fetches fro
     +	test_expect_success "create bitmapped server repo ${argv:+($argv)}" '
      		git config pack.writebitmaps true &&
     -		git repack -ad
    -+		git repack -ad $argv
    ++		git repack -adF $argv
    ++	'
    ++
    ++	test_size "size of bitmapped pack ${argv:+($argv)}" '
    ++		test_file_size .git/objects/pack/pack-*.pack
      	'
      
      	# simulate a fetch from a repository that last fetched N days ago, for
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases
     +			git -c pack.allowPackReuse=$reuse pack-objects \
     +				--stdout --revs --path-walk --use-bitmap-index \
     +				<in >out.pack &&
    -+			grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
    ++			test_grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
     +
     +			git index-pack out.pack &&
     +
3:  069c50d3370 = 3:  315ee0b1988 pack-objects: extract `record_tree_depth()` helper
4:  ae57607b57f = 4:  371fc4317ad pack-objects: support `--delta-islands` with `--path-walk`

base-commit: 45a9ecee26839cc880fdd5e704339dd3cf4ffc26
-- 
2.54.0.23.g371fc4317ad
