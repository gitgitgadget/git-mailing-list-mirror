Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A735DA48
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801726; cv=none; b=Ly028C5vMuseHnuEI+rXHmK1XWIIDzjTNI2u2oeXddFYm4v2UXf0YxtrrRqwkg1grk7ZNXsvaDnLL+Pqp8431+6vtdPmU+6L/l91SrCeiwD4eVFdrYbPDamjb0b1rvppsuMIJxZfHbZPSS9MfqsYMIG8xFA8CH6PZOYQtIqYzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801726; c=relaxed/simple;
	bh=3C4SJEoYhNC7A5kSJgLLplPMUa/hOfc9ZKD2Sicyads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiMji2wFT+NSBxf3MRTaac8eM2gKQvcimfO0LMhckX469oBk9qOLmPwCH7jo7m+0JhhIfFimtiXiIYmFNFPWLagME5i8tO+BSleBogbF5kPngb8wMph80ENkiaGry+qE7Tb/7hlbjtmdSQ5jx9rmubGVpLa8QOZxDXg3XBo8zKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hiK+SWeG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hiK+SWeG"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479ef2b7979so699401b6e.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801724; x=1777406524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WphsUDJh0GqsP4JdcIhtFThCHbuqtWlTj8Gbgz1Ofg8=;
        b=hiK+SWeGwPvEqu40DxpX7TUckmikDfHkMfMWWd/YortCnsfOLk44tqwj+fksUux3e/
         CG3JFMOJIlu1vXP3U7cPpDzFBx1bevycKI4InQlNXnIQj4EQr+dDznzyR06BAi636qIH
         jzvIx1MFIFbOHQMpKp5LBlSjRu2GL3v4c+yRRd4GY8QpSQcUvy+4ViChXxLXBKv+nLN0
         D4tK1/ZGpP88+ZsuNOFa2vGrPZh7Sn3auYOGk792CBgxwE1UzfXwMHR791LrxEqASZJk
         6RmcAZz/3lLiIXvjdMhQQEyWmSwFMVciJnCHC2wng2uFA+wzby76NK46Jpf40JUYJbIE
         fJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801724; x=1777406524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WphsUDJh0GqsP4JdcIhtFThCHbuqtWlTj8Gbgz1Ofg8=;
        b=YmFnypjJRwAd5ljZq1dMvxhTmKu3Im2s2z8Y+rAgQrUMEoH9ZW11UnY/UdGqBCw0OX
         4MOopz9a1h4mxzUu3pdj2b2QAx5FJGKf0xbVQ2GAPz7Cip4fMzmLZherJTNxLhGcYwQM
         7h8NonUqzjxwqoQi/P0v1mszF7lWBhGvKbxfkahKbrBhWEJECI39ERrtX/uOD1a1pg/f
         uWIe615xYmoB5sqVlPUwny53EMp6qU9iZQIQu949ZHuHriOx4p/1pzrdZWxrnW0KGv8F
         re+ie98Om23Iiku3NWg+dTl/DecJKcmG859DWx8vpfZmlgj5vkj71kPc+5a2BRDjByS7
         HTMA==
X-Gm-Message-State: AOJu0YzrRqfjvs2BnVFKc0TiZGHO2IHBtYw/ePHscA2JcLsbV++ZBk+c
	p1dtE8YJ1xf59JowO5GWO+H8v83Oq7stgmnkA2MuEYRMeVGTGiLohzF/lF4EBWyRyiJjKEn1aVE
	UPo0KnjI=
X-Gm-Gg: AeBDiesJy46rM1R0LlkhVzHnIie2xMpsNq4bqW5gfCBVIuePj9JPLvOw+4rip/bycL4
	lHniNDP3UGkdHhjKDHaIou1tj/rJlwh5iq4vnilLj12BMVYM+YSjv6FjyvwCpcYEtOp0776S6G9
	0Z3LteGODnITlkF8jWboe1YfKL7i9EKTPdGbzlpV9bjR+9Q0sl0gzcHfyKHLH5IZPVk1pQ5nj5x
	SLWgRfoeUb/tqtNBCnqa9h4xpY2gviTAC7mjrjgOU2UAULq+dbfL3HVzBusHSmOtDA/CUj2SJio
	AyUicMtY+myB0fWxetJCZGdaOwVQDnn/hpir+1lrgNeYZBOtVv4bpFnNW1erDAzQia/gad0pw2m
	ikxEedc9u55CxW3qqlJIP9YeR1Gki+S1fdb5WY5WDzYfVS026aBgB8Q6sm/UefSk+aC7Fs145Fd
	rDyyr8ZC8KiKf4CDfInJgE2URNEmSZG9l5aCCqS/4gPTJDJ2EsR4ZbbIWmDx5nXMRQ0P0luerZz
	93FEt605xLQViwNlzBWLoL9KlrjkuEJ6D6+bCflV/GXE671+pzj3329I7AFb8T2qBbCl8Usx2I0
	g/d7FsWmZzdUDDIl6d2zW63BQQ8=
X-Received: by 2002:a05:6808:1b12:b0:46a:bbae:d47a with SMTP id 5614622812f47-4799c9bcef7mr11237051b6e.34.1776801723895;
        Tue, 21 Apr 2026 13:02:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a03ac624sm9847402b6e.18.2026.04.21.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:03 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/9] pack-bitmap-write: sort pseudo-merge commit lookup
 table in pack order
Message-ID: <8d908ab415ed021fac113c63a093c3e72b0ba40b.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

The pseudo-merge commit lookup table stores each commit's position in
the pack- or pseudo-pack order, and is used to perform a binary search
in order to determine which pseudo-merge(s) a given commit belongs to.

However, the table was previously sorted in lexical order (via
`oid_array_sort()`), causing the binary search to fail.

While this causes pseudo-merge bitmaps to be de-facto broken for fill-in
traversal, there are a couple of important points to keep in mind:

 * Pseudo-merge application during the initial phases of a bitmap-based
   traversal are applied via `cascade_pseudo_merges_1()`. This function
   enumerates the known pseudo-merges and determines if its parents are
   a subset of the traversal roots.

   This is a different path than the fill-in traversal, where we are
   looking for any pseudo-merges which may be satisfied after visiting
   some commit along an object walk, which involves the aforementioned
   (broken) binary search.

   As a consequence, any pseudo-merges we apply at this stage are done
   so correctly.

 * While this bug makes applying pseudo-merges during fill-in traversal
   effectively broken, it does not produce wrong results. Instead of
   applying the *wrong* pseudo-merge, we will simply fail to find
   satisfied pseudo-merges, leaving the traversal to use the existing
   fill-in routines.

Fix this by sorting the table by bit position before writing, matching
the order that the reader's binary search expects.

This does produce a change the on-disk format insofar as the actual code
now complies with the documented format (for more details, refer to:
Documentation/technical/bitmap-format.adoc). Given that this never
worked in the first place, such a change should be OK to perform.

If an out-of-tree implementation of pseudo-merges happened to generate
bitmaps that comply with the documented format, they will continue to be
read and interpreted as normal.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c             | 21 ++++++++++++++++++++-
 t/t5333-pseudo-merge-bitmaps.sh |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 8338d7217ef..86ed6a5d78c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -819,6 +819,20 @@ static void write_selected_commits_v1(struct bitmap_writer *writer,
 	}
 }
 
+static int pseudo_merge_commit_pos_cmp(const void *_va, const void *_vb,
+				       void *_data)
+{
+	struct bitmap_writer *writer = _data;
+	uint32_t pos_a = find_object_pos(writer, _va, NULL);
+	uint32_t pos_b = find_object_pos(writer, _vb, NULL);
+
+	if (pos_a < pos_b)
+		return -1;
+	if (pos_a > pos_b)
+		return 1;
+	return 0;
+}
+
 static void write_pseudo_merges(struct bitmap_writer *writer,
 				struct hashfile *f)
 {
@@ -876,7 +890,12 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 		oid_array_append(&commits, &kh_key(writer->pseudo_merge_commits, i));
 	}
 
-	oid_array_sort(&commits);
+	/*
+	 * Sort the commits by their bit position so that the lookup
+	 * table can be binary searched by the reader (see
+	 * find_pseudo_merge()).
+	 */
+	QSORT_S(commits.oid, commits.nr, pseudo_merge_commit_pos_cmp, writer);
 
 	/* write lookup table (non-extended) */
 	for (i = 0; i < commits.nr; i++) {
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 0e9638c31c3..3d7a7668121 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -462,7 +462,7 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges during fill-in traversal' '
+test_expect_success 'apply pseudo-merges during fill-in traversal' '
 	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
 	git init pseudo-merge-fill-in-traversal &&
 	(
-- 
2.54.0.9.gb905fd5d0ae

