Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD92D0C65
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548212; cv=none; b=lAOSJbRdzgL9iqIcv8Fy0jRP8CQgKy0vRq3QBRd7nDh3u/d+8Csm/SiQOk1GegwjorJP4ZS+wR0fQNxnL8x4F3eq6s84maLQ8je1TJrtqX4oXGF7/HJptAC4Ut+mgZmY88soF81/cLYTz2O7/ZX/FejDWTBYicDEn0rwVy/ALxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548212; c=relaxed/simple;
	bh=GJoPmaG39diO91EKEaL6DP3jmmPCrlFzhaKeF/O+Da4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFvl6cF9FZ9pRQ4fm9d5PKd5ouAMqA5i5PI8PCly2u6T1fnzYcQ283DkbKKpMB8+vmWn3E2cvDbRqTAA9XeNIc397D56AoeBSfIAeN15mBz9bI1IwXgxsZHyG4oeCWWgOUfi3Qo6gWpBGoLGkSjBU13ONXsQu5zpYoomvq7JMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6zacERh; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6zacERh"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3139027b825so3923036a91.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752548210; x=1753153010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvUcAkK0oEUe8OHJDGNzc7FjnAclY0z0ObIzflBVg6E=;
        b=I6zacERhYbEAaPVzeuSjtX5OxBGyxlm+m+3xr94Kdm1jT2bj2Vl4IANzHYcM4pdD7K
         WRxxseE8uBH86fAWUrTogGNAQNnw3xXeFmYHc7ts3UViA/E6Lh9kAnFisQSLS96ORHrV
         twEFZZycmTqoK85gQjByssP9gZHUG2Z98nrf8f1wEIGeY31tbZgtLDL3y67Mwrl2DQ/L
         xmKxPOhl2j/94WoQ4PEprkln3HDRnoJotLnMKzPgvQAAsqi8ZxfbsxHfmJ3QZxeEHlTe
         FSsTbTRXwphGJuvz6OBELclt20C0VYjwFYi7Ecdz19H0S7z25WTiWnEtAZo14h5L4D0n
         MLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752548210; x=1753153010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvUcAkK0oEUe8OHJDGNzc7FjnAclY0z0ObIzflBVg6E=;
        b=Tj7nK1Be/AHVcKoEh1UOpTCTn4VOrtPlgRBOOvXA/UztHcDxY4ioGFKcAQPVZrUe4V
         mTmSpQXD1wKuYXmsPv1FPaBvqlVoTiA6SgreaABeyIUHl/QlBYf9nifO1GCxleaQTMl8
         HJihT1vjcDamMnLdc9QSIOy1tE8aWrtjZxWDnbtPaEDY5ecR3SEIG+NBRn9rbcPQckXx
         Wc2oihgZmgnjGIzZ5Y/v65HXh66BfuTGsUmP/zKuA7/K+xy9o7sdOj5si0zVHXeJMOo/
         jlWHBeXRmXP5tpg7PJoQvHnHpnV6unuRud73JAGyurBbj6oUbFREwnh1CtsewmGX517U
         bdSg==
X-Gm-Message-State: AOJu0YwR/L2ik00R0IrGtufA6AG8lwr+ML3tM7cx5uWQgtNPjTG9bk4E
	SHxLj+F7EL69JDHKWFFwBo25UJssqDULup24vOCkehSwF6MOI5OKTq9Im6y9oxLVqJ102Q==
X-Gm-Gg: ASbGncvlwuifE7ffl68ZojT3dyC9aNDdi4FW62Qm/G/H5vIO4hznqsgM9WYIgN+oedy
	qD/PdVAbdXh2iNrJcA43+uKzY4TCq8Up87b41PjEaBEoFUXIyKFKu1iFnuqITwuojnTc3yK8nWl
	QSZDMmu42G0D8BcjgsyEvF7AEyJE79R6hRnQ3vT3ifW3JRsWCZw07qjJ7fiYlgJxfbdizLB1wLC
	0r+EAe9fWHbYtwUNXH7KiJDxXFaLMyAbpSGGAgNFXWxCS24v/XnHTSDQN+LyxGCEqMzCBaxVlvq
	zRJjN/jGyzZenJ7C2Sq9oRlRI7OuVwuPDlve6MCrUgo/pItrHrXaWtx+Crsixjlpa9rhJ0ynJkl
	/Lb78dN8zWnIYziN6RecL/b2UOkdID4xOL5JsxjwKX3EBe5FM1xPZfuipXSzR58InWLMXvax5Iq
	aYCK/Hf/gHCZdl4H42xjWgHLvcB464wA==
X-Google-Smtp-Source: AGHT+IH0fWoGQm7EQImpNtaHAdyAkX3Vr2KFPFVy8q7xJV2woML2X4B/RjF2Vi166VJvq42UV8Z/oQ==
X-Received: by 2002:a17:90b:4c0b:b0:313:2e69:8002 with SMTP id 98e67ed59e1d1-31c4ccdb25amr22517673a91.20.1752548209780;
        Mon, 14 Jul 2025 19:56:49 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb62caasm11562441a91.39.2025.07.14.19.56.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 19:56:49 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: 502024330056@smail.nju.edu.cn
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	stolee@gmail.com,
	Lidong Yan <yldhome2d2@gmail.com>
Subject: [RESEND][PATCH v6 5/5] bloom: optimize multiple pathspec items in revision
Date: Tue, 15 Jul 2025 10:56:22 +0800
Message-Id: <20250715025622.98646-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <55BF9B3C-F9B1-4ADB-9CBC-0D8EA45BA264@smail.nju.edu.cn>
References: <55BF9B3C-F9B1-4ADB-9CBC-0D8EA45BA264@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To enable optimize multiple pathspec items in revision traversal,
return 0 if all pathspec item is literal in forbid_bloom_filters().
Add for loops to initialize and check each pathspec item's bloom_keyvec
when optimization is possible.

Add new test cases in t/t4216-log-bloom.sh to ensure
 - consistent results between the optimization for multiple pathspec
   items using bloom filter and the case without bloom filter
   optimization.
 - does not use bloom filter if any pathspec item is not literal.

With these optimizations, we get some improvements for multi-pathspec runs
of 'git log'. First, in the Git repository we see these modest results:

Benchmark 1: old
 Time (mean ± σ):      73.1 ms ±   2.9 ms
 Range (min … max):    69.9 ms …  84.5 ms    42 runs

Benchmark 2: new
 Time (mean ± σ):      55.1 ms ±   2.9 ms
 Range (min … max):    51.1 ms …  61.2 ms    52 runs

Summary
 'new' ran
   1.33 ± 0.09 times faster than 'old'

But in a larger repo, such as the LLVM project repo below, we get even
better results:

Benchmark 1: old
 Time (mean ± σ):      1.974 s ±  0.006 s
 Range (min … max):    1.960 s …  1.983 s    10 runs

Benchmark 2: new
 Time (mean ± σ):     262.9 ms ±   2.4 ms
 Range (min … max):   257.7 ms … 266.2 ms    11 runs

Summary
 'new' ran
   7.51 ± 0.07 times faster than 'old'

Signed-off-by: Derrick Stolee <stolee@gmail.com>
[ly: rename convert_pathspec_to_filter() to convert_pathspec_to_bloom_keyvec()]
Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c           | 21 +++++++++++----------
 t/t4216-log-bloom.sh | 23 ++++++++++++++---------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 1614c6ce0d..cf7198c0ea 100644
--- a/revision.c
+++ b/revision.c
@@ -675,12 +675,11 @@ static int forbid_bloom_filters(struct pathspec *spec)
 {
 	if (spec->has_wildcard)
 		return 1;
-	if (spec->nr > 1)
-		return 1;
 	if (spec->magic & ~PATHSPEC_LITERAL)
 		return 1;
-	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
-		return 1;
+	for (size_t nr = 0; nr < spec->nr; nr++)
+		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+			return 1;
 
 	return 0;
 }
@@ -733,13 +732,15 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
 
-	if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[0],
-					     &revs->pruning.pathspec.items[0],
-					     revs->bloom_filter_settings))
-		goto fail;
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[i],
+						     &revs->pruning.pathspec.items[i],
+						     revs->bloom_filter_settings))
+			goto fail;
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac..639868ac56 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -66,8 +66,9 @@ sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
 	rm -f "$TRASH_DIRECTORY/trace.perf" &&
-	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
-	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
+	eval git -c core.commitGraph=false log --pretty="format:%s" "$1" >log_wo_bloom &&
+	eval "GIT_TRACE2_PERF=\"$TRASH_DIRECTORY/trace.perf\"" \
+		git -c core.commitGraph=true log --pretty="format:%s" "$1" >log_w_bloom
 }
 
 test_bloom_filters_used () {
@@ -138,10 +139,6 @@ test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
 	test_bloom_filters_not_used "--walk-reflogs -- A"
 '
 
-test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
-	test_bloom_filters_not_used "-- file4 A/file1"
-'
-
 test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
 	test_bloom_filters_not_used "-- ."
 '
@@ -151,9 +148,17 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
 	test_bloom_filters_used "-- *renamed"
 '
 
-test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
-	test_bloom_filters_not_used "-- *" &&
-	test_bloom_filters_not_used "-- file*"
+test_expect_success 'git log with multiple literal paths uses Bloom filter' '
+	test_bloom_filters_used "-- file4 A/file1" &&
+	test_bloom_filters_used "-- *" &&
+	test_bloom_filters_used "-- file*"
+'
+
+test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+	test_bloom_filters_not_used "-- file\*" &&
+	test_bloom_filters_not_used "-- A/\* file4" &&
+	test_bloom_filters_not_used "-- file4 A/\*" &&
+	test_bloom_filters_not_used "-- * A/\*"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.39.5 (Apple Git-154)

