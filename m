Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594ED8F6E
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754705883; cv=none; b=F8XtDjYx6paKkBefUvTOdKZWE4LRG0sXttmaxIiUvdLWTDpPcGsfz5cEeT6chi4OgHiN7orWAPyCeQCl1Pc2WfV+ilzjeikeYp0HWVEz0y7Z4s1b6qd8Ve75GmsbGJ9XqJ96cGFe8FxnYYD2mPDb31WjLRnVFfj0pm2NKRMfBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754705883; c=relaxed/simple;
	bh=+37+j0bG9gq0M5j7UHkhnn75gGkBfIOxjKiKwUy6A9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPLYAuO1YQs9rhI1lk0RsmS9PIoQlxK7dLmLrWvpBBCOKgwAVI/ZqEEBa6jalqgrnP0zKev0uid32MuKuhmoMVDkZeL7b8J8Nn4djD2FMmP3Ci+7LBowaU3Sm95goYVe/ddJpneHRtI8INBM4vKrPbP7bnp6TwDTtPRZkxpAYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ9A/Vyg; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ9A/Vyg"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so2355216a91.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754705882; x=1755310682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+vLagoHmdMyApv14qXf4xIvKZS0xYUwdp9Wx2vtGVA=;
        b=cJ9A/Vygkkkrb/f3AOSV5h4Z1MLfdLbd/Nd2oXn1vteaAxZl6JKSRXJf4Z4SSZZxoO
         p2o3xBlVPOEJNNptTSnflqWs3cyoWd+xmIOi95Ch2iuQjmuyGt976hJx9Bh8VGvDdMcy
         OEhSHmQALG3WDIWB0vjrNezytVwNc523rKgDosCB91n+c1ABkZJiJpcdJD53kHpSyvsR
         KQCf01Rt+bV0+tWauobvsjq3Pom2Ysg6EFWFpJG0GhntysSLv6q5YrUTWVgwNMb+LUGh
         6UAHzfYtUR4yUShBtVBmVIjC6Si4fkCvqwPS47ZZFqMUZ0fpaQcrQvbRdrayAZsbZfMr
         fz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754705882; x=1755310682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+vLagoHmdMyApv14qXf4xIvKZS0xYUwdp9Wx2vtGVA=;
        b=UyADSJmZ345sN7ObfbYcIXzSona2F1yhOUDNBnB6nkwiEr7GhS1wA5MYgXVntI553r
         qwBrPDHT1NHa1r/FcLwUw4Bt5/7jWVK+JlmGrv9dAAnCoIo+QaK7TxLDz6ZNlB9HlDRa
         HUDjp4kF1awg87byipk7U849vVyGbAFHMMdSwtjOsMWD6GKBQTSGZa/Dblygo+p28M6x
         zo25A6az7krz2cfH27Ru9Zmi34YjzgDDbwMQOSeFDcmJ07wK8iFk59Kt3sKdf4ZPVXEV
         wgXrPp9HsZsU6qIyaxrvWekSFqAR9KQFIQGeIYvz+cEy9sSSgJnohfXOYroED+VgWb1c
         A4Ng==
X-Gm-Message-State: AOJu0YwuDUEexjvbNxbUiOmS+UIK0HTRpY3h29ubKizA60lgnF0GMk5p
	kBXDhEx4HZrqfBUqEURxIM6UqhFtXMgKt0Ysx/XcDXooZHX31Z+AzntA
X-Gm-Gg: ASbGncu10hHbljFLRoZ8XRyVo5pmXWkjHyHjXkSd+mLta2FgQV/VCyRZOZXN859L+5w
	LFy1lyahYIBHOWioNxuGBgrko2ggDjjmH6V27fxdy0LmktpLpolXeg/KTsXi2Fr2W7yJlQNFesA
	6Wye5pC3uXeCW+jVo8hvq9/1z023oXHzWGZIkporuio2D6IZjVhr+juHvhqQYqO0o+FcWSueSUS
	wjkxGbP6+kWu/MoMTvzgcEB1H8/X/1ebd6LeecUcLm3N5evcDSw1dDUHmEUw6DxoJfK0g5T+1ZG
	VCTMxYyYovPlOg+3NzA4+QbQkaryUmtqrW5FNRdmFWZoQ40UiXYTIcIoqI/8LrCfHbnTGAlsPd6
	0ijwnaQ8IhLO+GK3su7E3RhOGCRCoBg//5VM93sGM2rLDVT5quXNvi7+vXkRhqOQlpQ==
X-Google-Smtp-Source: AGHT+IH9chS+i5+bmGVVvY0+79UfN0U3O99FNLDr81RFlB3rbHqeDQBKeI5o29kdvq8i3vRPV8kD4A==
X-Received: by 2002:a17:90b:180f:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-321839d688fmr7211347a91.3.1754705881492;
        Fri, 08 Aug 2025 19:18:01 -0700 (PDT)
Received: from localhost.localdomain (n058152022104.netvigator.com. [58.152.22.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da57b4sm26511602a91.5.2025.08.08.19.17.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Aug 2025 19:18:01 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	stolee@gmail.com,
	ttaylorr@github.com,
	yldhome2d2@gmail.com
Subject: [PATCH v3] bloom: enable bloom filter with wildcard pathspec in revision traversal
Date: Sat,  9 Aug 2025 10:16:42 +0800
Message-ID: <20250809021642.22195-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.49.gea0dd4b6b4.dirty
In-Reply-To: <xmqqsei1izhs.fsf@gitster.g>
References: <xmqqsei1izhs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When traversing commits, a pathspec item can be used to limit the
traversal to commits that modify the specified paths. And the
commit-graph includes a Bloom filter to exclude commits that definitely
did not modify a given pathspec item. During commit traversal, the
Bloom filter can significantly improve performance. However, it is
disabled if the specified pathspec item contains wildcard characters
or magic signatures.

For performance reason, enable Bloom filter even if a pathspec item
contains wildcard characters by filtering only the non-wildcard part of
the pathspec item.

The function of pathspec magic signature is generally to narrow down
the path specified by the pathspecs. So, enable Bloom filter when
the magic signature is "top", "glob", "attr", "--depth" or "literal".
"exclude" is used to select paths other than the specified path, rather
than serving as a filtering function, so it cannot be used together with
the Bloom filter. Since Bloom filter is not case insensitive even in
case insensitive system (e.g. MacOS), it cannot be used together with
"icase" magic.

With this optimization, we get some improvements for pathspecs with
wildcards or magic signatures. First, in the Git repository we see these
modest results:

git log -100 -- "t/*"

Benchmark 1: new
  Time (mean ± σ):      20.4 ms ±   0.6 ms
  Range (min … max):    19.3 ms …  24.4 ms

Benchmark 2: old
  Time (mean ± σ):      23.4 ms ±   0.5 ms
  Range (min … max):    22.5 ms …  24.7 ms

git log -100 -- ":(top)t"

Benchmark 1: new
  Time (mean ± σ):      16.2 ms ±   0.4 ms
  Range (min … max):    15.3 ms …  17.2 ms

Benchmark 2: old
  Time (mean ± σ):      18.6 ms ±   0.5 ms
  Range (min … max):    17.6 ms …  20.4 ms

But in a larger repo, such as the LLVM project repo below, we get even
better results:

git log -100 -- "libc/*"

Benchmark 1: new
  Time (mean ± σ):      16.0 ms ±   0.6 ms
  Range (min … max):    14.7 ms …  17.8 ms

Benchmark 2: old
  Time (mean ± σ):      26.7 ms ±   0.5 ms
  Range (min … max):    25.4 ms …  27.8 ms

git log -100 -- ":(top)libc"

Benchmark 1: new
  Time (mean ± σ):      15.6 ms ±   0.6 ms
  Range (min … max):    14.4 ms …  17.7 ms

Benchmark 2: old
  Time (mean ± σ):      19.6 ms ±   0.5 ms
  Range (min … max):    18.6 ms …  20.6 ms

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
[jc: avoid allocating zero length path in
convert_pathspec_to_bloom_keyvec()]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c           | 37 +++++++++++++++++++++++++++----------
 t/t4216-log-bloom.sh | 31 +++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index 18f300d455..386c52aba1 100644
--- a/revision.c
+++ b/revision.c
@@ -671,12 +671,17 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 static int forbid_bloom_filters(struct pathspec *spec)
 {
-	if (spec->has_wildcard)
-		return 1;
-	if (spec->magic & ~PATHSPEC_LITERAL)
+	unsigned int allowed_magic =
+		PATHSPEC_FROMTOP |
+		PATHSPEC_MAXDEPTH |
+		PATHSPEC_LITERAL |
+		PATHSPEC_GLOB |
+		PATHSPEC_ATTR;
+
+	if (spec->magic & ~allowed_magic)
 		return 1;
 	for (size_t nr = 0; nr < spec->nr; nr++)
-		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+		if (spec->items[nr].magic & ~allowed_magic)
 			return 1;
 
 	return 0;
@@ -693,19 +698,31 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	size_t len;
 	int res = 0;
 
+	len = pi->nowildcard_len;
+	if (len != pi->len) {
+		/*
+		 * for path like "dir/file*", nowildcard part would be
+		 * "dir/file", but only "dir" should be used for the
+		 * bloom filter
+		 */
+		while (len > 0 && pi->match[len - 1] != '/')
+			len--;
+	}
 	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
+	if (len > 0 && pi->match[len - 1] == '/')
+		len--;
 
-	len = strlen(path);
 	if (!len) {
 		res = -1;
 		goto cleanup;
 	}
 
+	if (len != pi->len) {
+		path_alloc = xmemdupz(pi->match, len);
+		path = path_alloc;
+	} else
+		path = pi->match;
+
 	*out = bloom_keyvec_new(path, len, settings);
 
 cleanup:
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 639868ac56..1064990de3 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -154,11 +154,34 @@ test_expect_success 'git log with multiple literal paths uses Bloom filter' '
 	test_bloom_filters_used "-- file*"
 '
 
-test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+test_expect_success 'git log with paths all contain non-wildcard part uses Bloom filter' '
+	test_bloom_filters_used "-- A/\* file4" &&
+	test_bloom_filters_used "-- A/file\*" &&
+	test_bloom_filters_used "-- * A/\*"
+'
+
+test_expect_success 'git log with path only contains wildcard part does not use Bloom filter' '
 	test_bloom_filters_not_used "-- file\*" &&
-	test_bloom_filters_not_used "-- A/\* file4" &&
-	test_bloom_filters_not_used "-- file4 A/\*" &&
-	test_bloom_filters_not_used "-- * A/\*"
+	test_bloom_filters_not_used "-- file\* A/\*" &&
+	test_bloom_filters_not_used "-- file\* *" &&
+	test_bloom_filters_not_used "-- \*"
+'
+
+test_expect_success 'git log with path contains various magic signatures' '
+	cd A &&
+	test_bloom_filters_used "-- \:\(top\)B" &&
+	cd .. &&
+
+	test_bloom_filters_used "-- \:\(glob\)A/\*\*/C" &&
+	test_bloom_filters_not_used "-- \:\(icase\)FILE4" &&
+	test_bloom_filters_not_used "-- \:\(exclude\)A/B/C" &&
+
+	test_when_finished "rm -f .gitattributes" &&
+	cat >.gitattributes <<-EOF &&
+	A/file1 text
+	A/B/file2 -text
+	EOF
+	test_bloom_filters_used "-- \:\(attr\:text\)A"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.51.0.rc0.49.gea0dd4b6b4.dirty

