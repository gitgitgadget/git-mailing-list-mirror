Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3B1DF73A
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543598; cv=none; b=Ewn191ldOl3bYPWN73EGt0xWWvAo4acygdBH9aMyrQs7W6p3I7dV8MCg0ERKu8DtZyzd/y3PKAeqeWwTO5QdbdUkrRWDVXR3z/nCt1arzb0jw2zq9tidciGV3lI2EpMsXgY8rQUqKFJXmcbWOm7E2JA/A5e7zmFTRcJo73bmUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543598; c=relaxed/simple;
	bh=YN+tS4rdo9BXXorPha8nWV5GHwnO3OELpaueaP/1Mlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uU1IZzWGDWOD7Si3OqmIIWq0u6ziQdeNONz8CprwKWcxJPeuyOEAQGMxLot9JnuXrvnywoiGSuxpEN7+FY76apALiNrAL5q41Rqz/6Sar8gX8y8w69hmKU9kaf7528eSUh0WfmSEwv5mdb4c+sjzopXm0Im2wYZOKIopACCafUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At/zzwBn; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At/zzwBn"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23c8f179e1bso7362915ad.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754543596; x=1755148396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SYAXt3sSj7zh9bewTvWhKqJtXe8Hxgzu49FYrN92TM=;
        b=At/zzwBnwLCHOZc7qdm8wh9vL7tW54Z6Tl9eVq2h5jxhE047uGZrVQl8S7isTRdV/4
         Qv1Zrzv0/qrgfPkxfIg57aNShR9kmr6oNE/BJeRFb15Q1+U18JrM5KVUUS2ofi8hnc2Q
         iWZ8o3KuuCP9W9ztK2scbFfmiZ1Rf37daWnxEz5n0a/uktf3JGXHEo/fLr51aER1j1+Z
         5Rv0hu9xtP2V2tGI3x/+Fey8XiSz7DzzmDy1yWxDR08vX16xzBmyie61L+WNiwg9sYdB
         PxbZ9RGdUH7vHaLlkmKN3yZdJmE16UmGO5LprwqddGcmiRGnlxIMxHUUazUB+DFQUxXW
         1Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754543596; x=1755148396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SYAXt3sSj7zh9bewTvWhKqJtXe8Hxgzu49FYrN92TM=;
        b=hiiYKQE2jsvKjAY0bi8Ffj+BfqTDdUrMO/C0yWMYq1odZ5G+3Sh/lUtckNo9GHeXLS
         qfCS6Ec2gW2ULfQP+vBBC32su8b6UCjhPct205ljZOqMu6GxmptdbrN/GZBcYPA/4PId
         m0pzccUvUGSYWXB6M1Bu/a2LId52gPHrrZu9Shg4tE/msXUX7fx+hkKnPXRNkf1qPHiY
         PrHeKQprXKsivsMm3pEzz8VaFhgP1xgcc+94xOicJcZPgRzrHu33x7hKhIgmOLXk6ULm
         TQtBhmObmWUojbIcDpH/DeYhS4qmNEl5IjKx3UhUrfkb/C8Pqe9RyJluejPO8+1RWkIM
         Zjug==
X-Gm-Message-State: AOJu0Yy6Ai16PAkCdYY3z0jzfiVdRgO80J8z2fzy28EC5AujtvvD1XaS
	Rg7cuB5jDTBp/rigul4toIVnLAQ59xsayVKs2HMVTrwHLkmnqDQuCP0efS1/k90cbyo=
X-Gm-Gg: ASbGncs68BCDJUiyG8EOQt7IgzA7NerVIfIjn52h1k14LLJmpFoJEP3r4h6rqy5yDkj
	QrfL7DY48eo/Pw0d3kxSsYOl1IdypQwLBOl0mueIHBEmTQ05RQK4uFHEX462jbgE4bPCBXDUUHK
	EaHJP2D6d2Gj0nAT37GucST88wnxrr/Qt1PRbpnqnGfvXKkH6T8O5U+hzffjlMFSKOoma0YWVHI
	wrVIyQ2puQvrBK/gorr/WcXsCXH0hFKNxQ361UMjvcENAs4zDCegpHAAHlDnzHu+AYxucjge03k
	54l+f/l/5vr3P5Y4I8WO/Uiun7AVCB+CD1cBO3bQ8AAhVbFOWFxtJTawHdo0HgbU1IM4KFvWi0h
	ERutbH3ATtrrkGdKIZl3wOdEaY0g79clmxrxO58hEsdjw7m3G9JIbY/4T7UcLuO0c
X-Google-Smtp-Source: AGHT+IFqwIt3xRN1uwfvasdDL7UsoLQ33B5fJh56JtVPdq/OU2ZneDcLA9VavySSwI/qi3vTmrDXIQ==
X-Received: by 2002:a17:902:cecf:b0:240:483:dc3a with SMTP id d9443c01a7336-242a0a911d5mr70536225ad.12.1754543596162;
        Wed, 06 Aug 2025 22:13:16 -0700 (PDT)
Received: from localhost.localdomain (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm172785575ad.173.2025.08.06.22.13.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 22:13:15 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: git@vger.kernel.org
Cc: stolee@gmail.com,
	gitster@pobox.com,
	ttaylorr@github.com,
	Lidong Yan <yldhome2d2@gmail.com>
Subject: [PATCH] bloom: enable bloom filter with wildcard pathspec in revision traversal
Date: Thu,  7 Aug 2025 13:12:43 +0800
Message-ID: <20250807051243.96884-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.48.g112648dd6b.dirty
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
or magic signatures. Enable Bloom filter even if a pathspec item
contains wildcard characters by filter only the non-wildcard part of
the pathspec item. Also Enable Bloom filter if magic signature is not
"exclude" or "icase".

With this optimization, we get some improvements for pathspec with
wildcard and magic signature. First, in the Git repository we see these
modest results:

git log -100 -- "t/*"

Benchmark 1: new
  Time (mean ± σ):      20.7 ms ±   0.5 ms
  Range (min … max):    19.8 ms …  21.8 ms

Benchmark 2: old
  Time (mean ± σ):      25.4 ms ±   0.6 ms
  Range (min … max):    24.1 ms …  26.8 ms

git log -100 -- ":(top)t"

Benchmark 1: new
  Time (mean ± σ):      15.3 ms ±   0.3 ms
  Range (min … max):    14.5 ms …  16.1 ms

Benchmark 2: old
  Time (mean ± σ):      19.5 ms ±   0.5 ms
  Range (min … max):    18.7 ms …  20.7 ms

But in a larger repo, such as the LLVM project repo below, we get even
better results:

git log -100 -- "libc/*"

Benchmark 1: new
  Time (mean ± σ):      10.1 ms ±   0.7 ms
  Range (min … max):     8.7 ms …  11.5 ms

Benchmark 2: old
  Time (mean ± σ):      26.1 ms ±   0.7 ms
  Range (min … max):    24.6 ms …  27.4 ms

git log -100 -- ":(top)libc"

Benchmark 1: new
  Time (mean ± σ):      11.0 ms ±   0.8 ms
  Range (min … max):     9.6 ms …  13.9 ms

Benchmark 2: old
  Time (mean ± σ):      20.7 ms ±   0.8 ms
  Range (min … max):    18.8 ms …  21.8 ms

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 revision.c           | 26 ++++++++++++++++++++------
 t/t4216-log-bloom.sh | 31 +++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 18f300d455..ef8c0b6eca 100644
--- a/revision.c
+++ b/revision.c
@@ -671,12 +671,13 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 static int forbid_bloom_filters(struct pathspec *spec)
 {
-	if (spec->has_wildcard)
-		return 1;
-	if (spec->magic & ~PATHSPEC_LITERAL)
+	int forbid_mask =
+		PATHSPEC_EXCLUDE | PATHSPEC_ICASE;
+
+	if (spec->magic & forbid_mask)
 		return 1;
 	for (size_t nr = 0; nr < spec->nr; nr++)
-		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+		if (spec->items[nr].magic & forbid_mask)
 			return 1;
 
 	return 0;
@@ -693,9 +694,22 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	size_t len;
 	int res = 0;
 
+	len = pi->nowildcard_len;
 	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
+	if (len > 0 && pi->match[len - 1] == '/')
+		len--;
+	else if (len != pi->len) {
+		/*
+		 * for path like "/dir/file*", nowildcard part would be
+		 * "/dir/file", but only "/dir" should be used for the
+		 * bloom filter
+		 */
+		while (len > 0 && pi->match[len - 1] != '/')
+			len--;
+	}
+
+	if (len != pi->len) {
+		path_alloc = xmemdupz(pi->match, len);
 		path = path_alloc;
 	} else
 		path = pi->match;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 639868ac56..d8200e4dcb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -154,11 +154,34 @@ test_expect_success 'git log with multiple literal paths uses Bloom filter' '
 	test_bloom_filters_used "-- file*"
 '
 
-test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+test_expect_success 'git log with paths all contain non-wildcard part uses Bloom filter' '
+	test_bloom_filters_used "-- A/\* file4" &&
+	test_bloom_filters_used "-- file4 A/\*" &&
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
+	cat >.gitattributes <<-EOF &&
+		A/file1 text
+		A/B/file2 -text
+	EOF
+	test_bloom_filters_used "-- \:\(attr\:text\)A" &&
+	rm .gitattributes
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.39.5 (Apple Git-154)

