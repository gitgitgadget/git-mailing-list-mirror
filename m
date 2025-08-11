Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327428382
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892107; cv=none; b=Uk0R8Fye0WgDktm611V9COYeO/G4vBx6+X+DfBpeojcQBlV+Ej18HxVIurRC66cBK06L0n1OsFNEcs8ANMlzslYP6HBsCGMb9+Q+fDY7ZFbdTfq9mkiGuRUB2BL66hMacqn/v0S2lzzh7RLtbibmi/ZRdRs8ny4mZZR0MCkxXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892107; c=relaxed/simple;
	bh=7MIqeHsR6pp2yxv4LsTdqlcxKpCEJIYJKpmXDDSKSH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtCd6PUoPNvh4i4ZG2VBD32ILv79nRxeC4YGzeq43dwo+RLh0IQ86kN3x4PgJJ3U+xtkwSGKgILJwYyhJUgyMKBXtFWeD9rXy28uoID7P9tyjRkfwi3vKZyfbLN+B5VyC7jgfehR0rSjYfVi6xD7Th63qFkbeqebgCSaF/FHnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WualpxOn; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WualpxOn"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so26361455ad.0
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754892105; x=1755496905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc2ur9oRFO178UwG4MQOCfTCeDEebz3LUoa2Qu2P7rw=;
        b=WualpxOn5qIBeNTpC1/2HjgdUwdSnK3Iw07NHduEDW+H7cu18IZyFC1d72EsNp7B8c
         3tQ1ppZ9D999R9y2e8LXOd8sB3Y+0XlCR10+vmoTkXWxgaD/rD71mURD+IXlHY9Efgps
         QOylY2r4jNmC7u0yaDHdr7WamcThnCfsIDDQdBjrHUdqdpLzBWpWxLTYJuFJp1n01DPv
         49Fod5o27pqHQ6yxL2O0skAa7aHCRxJ+RHC176UlgIDCQWqH4wDDwPrq5IdrO3lCFrVY
         8wXYfMC2vsJS384vhzhnSDVTTQB/jNguM4mQ79Pmd2axmWQJZCq0weMpkMkdVSCXfYQo
         RnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754892105; x=1755496905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc2ur9oRFO178UwG4MQOCfTCeDEebz3LUoa2Qu2P7rw=;
        b=g/MnGXMT7rOs1Sb/gdPYwDTGppepGRpGDlLi/lZQbOplQezA1sQW10ZXVVFtXhGDFL
         vD31kKZcBfg81Hir7qa636OEV+Zque7MK9a8O2fxIw2B5lVWHsj9vrjPXidRlz9Hiinl
         XPTqjd58AsrLo1V+aio8dsoq1zW3KffUXwSInsw2cWGIhfgbEm+YtiKJwYXY0EqIxmS/
         Um5835K1hpmd6aeMbYs4EfXcbXBZoYZxaD9Dzd5SyS451iRIe5S0TY8vDkYRpMUFkpru
         STqh5cQvseNvjn2dDx1v14n9arBXah5ukRWcPjONZFDYkmwPSS1FTqjm43d4A1HxmLH9
         8kRg==
X-Gm-Message-State: AOJu0YxfcNtfP1yKzv8U5r+oVy+joP6He6WfwUr7iRg6Y5zEWRlAQTao
	l12boJutJvbAWnoO/jCDFNFKeBdNMEXKyXglEmgZbIDePkmA6BHPLGUM
X-Gm-Gg: ASbGnct8DSV/Q/D9jppJO9VII6UZODtoBRXifQNyzqX30hRM85PrGIzIJfMeffbWjOk
	l8SWDYX2G9rWTSOJq9LC4bZqkR/5M2g2n08EHvFNlLKvnsaCClXr8FiPZbXNHamKzF0Eg3XVqhx
	0rmR05QfYCrv7rwQqaCmFI66IwRZyz4wC8OqWdjDYL8GoTejc5JPJ4rN9cIqo6sN1GahL+kqAmS
	zSd/l+dB/s7BaP91/Rbfhhyt+Br2mCgT1qZBCSIzJCu/CPWgMcnI6HJ6OfBxKFHp3yYU4+F9Wn8
	231GxK1JS2DoOgV6zCQ7Hfgl9f90M+rgBo9FT4Q8vB8fYJ6lbh53/YTssyVWQfcFk4y71DjUxNl
	XjSWLShnalM7U8iqpIb2Z1n1ehkIw9Cn/xfYiQUWgCoEhg6J63y1Fhi8YoEYf9ncf
X-Google-Smtp-Source: AGHT+IG2isa4IAp6BV1pRoi49JA9t5O2eFWZ+CnWrytoklJqZvTCjSgo6rM/BiqptDWXvcy90v4V0Q==
X-Received: by 2002:a17:902:cf0d:b0:235:779:edfa with SMTP id d9443c01a7336-242c220745emr217861695ad.32.1754892104842;
        Sun, 10 Aug 2025 23:01:44 -0700 (PDT)
Received: from localhost.localdomain (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa77sm261978605ad.174.2025.08.10.23.01.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 23:01:44 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	stolee@gmail.com,
	ttaylorr@github.com
Subject: [PATCH v5] bloom: enable bloom filter with wildcard pathspec in revision traversal
Date: Mon, 11 Aug 2025 14:01:37 +0800
Message-Id: <20250811060137.75135-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809042236.72695-1-yldhome2d2@gmail.com>
References: <20250809042236.72695-1-yldhome2d2@gmail.com>
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
 revision.c           | 42 +++++++++++++++++++++++++++++-------------
 t/t4216-log-bloom.sh | 31 +++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index 18f300d455..7449064def 100644
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
@@ -691,23 +696,34 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	char *path_alloc = NULL;
 	const char *path;
 	size_t len;
-	int res = 0;
+	int res = -1;
 
+	len = pi->nowildcard_len;
+	if (len != pi->len) {
+		/*
+		 * for path like "dir/file*", nowildcard part would be
+		 * "dir/file", but only "dir" should be used for the
+		 * bloom filter.
+		 */
+		while (len > 0 && pi->match[len - 1] != '/')
+			len--;
+	}
 	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
+	if (len > 0 && pi->match[len - 1] == '/')
+		len--;
+
+	if (!len)
+		goto cleanup;
+
+	if (len != pi->len) {
+		path_alloc = xmemdupz(pi->match, len);
 		path = path_alloc;
 	} else
 		path = pi->match;
 
-	len = strlen(path);
-	if (!len) {
-		res = -1;
-		goto cleanup;
-	}
-
 	*out = bloom_keyvec_new(path, len, settings);
 
+	res = 0;
 cleanup:
 	free(path_alloc);
 	return res;
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
2.39.5 (Apple Git-154)

