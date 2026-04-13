Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CC1C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124610; cv=none; b=tGMS2jzb6VQlr+N8MxQ3Ay7okSjQi/p81V+LHFqh8/3vzetk4Boy7IvMwm/1GcB3qXFERT8s7QZRxKlnrcs2K8SnHMVkA02ZJbpmNER/f4H2vJ3LTwHcmcWjrjmvW6QmlVSOclYJAL+qJeld61/LF5iepsxazqoIJvcbwn6YPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124610; c=relaxed/simple;
	bh=E3gpIDKAV9A5lc64ESM145cn7YnRVhksMdGB5e3ft7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLgzIe9IMy0qInQlmB/gSy5y3MSfHe0gIGlHmxGt6Oi0h0lZ3phe0hg2ndR+wO23rBm30oXLPxOLM9NLHDEFq8virZxpBjznFGBQ+mHr3ZwfIgvpGdAGK+vE+4QUgQiQTE9JR9OfpJQYcHcr81SmNY7fwgFXxjEtKkXPAyW6dMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=C06Z0qog; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="C06Z0qog"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b41fdf9de2so8369217b3.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124608; x=1776729408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mwPAjlVViSIXmwd2T+S92oOlpPFKAOSsUpVvBdcX3c=;
        b=C06Z0qogF2lGhmpNVCg1YuMA5bNjBTPHGIf8zFlaqsl9ZPMm4MOsLN2W9NH8vVAwnr
         AF2tRf6wZSmYd2K992Xf+H6VyLo847zsoh4eXznOkjoNJ0hVvflQ5nf+UVGB00TUGD29
         LgW0LHZRv/niiVyGOq1kN2p/7B+B/exQxSoXEFrrhzbayCfelcivphTz3s3IZVdoTm+N
         NmMbWJ+wseISH2KZ52CM/nL+QTHbTuJAvZBvt9ufYFFbw/0RgOdPJZeCtzcEAyFDwhdi
         u9oQFjTwclt9vFhDqFlkdDXNE/X/3f4wJk884jex/cpW7ASfYe3E4gnF95XvwGjMml5X
         kT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124608; x=1776729408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mwPAjlVViSIXmwd2T+S92oOlpPFKAOSsUpVvBdcX3c=;
        b=H5DpPZsgPglqHiw+VS/95UntCrkj2R45rLcyF/aG7yPp2Xch6xDuKrnRMvozZfvwst
         DcS3ayu9Q/uLicPyS9kkfUD+1SA+7IoduGl14D6bQjrogAmaFZAHbGZoDsJfIS/eqfvv
         8OjT5eCXrnZf6nJrBc93BwXkGJeBtoiuNrrsxyvJUbjdG38b3wQitNVHnY2YiO4UOrGn
         Z5nOULAh4APTx2D+SbQrUbcc3Ze/WEPI0MuPeQ+YKpUaHDFiFvxMOf08xomOSwmH7UWi
         d8SBaIyVXtMwjy2u82O4oSrkvIaY5/BsxQOCdYj/DbHhBkPJKQlw9WqxDhn+eX+iFV88
         MyZA==
X-Gm-Message-State: AOJu0Yy0FSPeKAru+YrVK/bfs4VJ7812xcr/1kJeTGjLBsJe/uj8Jt/u
	87j5b+RS6Njq0zNtfKYJNDEd46O7S/7xis0EsDDvxzUzRqHZ8HRwA7yJAV4F9ZBGeIRhGYRR2xT
	BnqGPqiQ=
X-Gm-Gg: AeBDievhUlmEvAQH5ZHpfFd2lJgXlaeMCvp/qhR2KuYX1pQs/9PGw3xtUg7mzQCyckm
	aHQcLzJUvhiuk1v5rncyFKvHXKvBnxyaSJlcAKjLpcaiaEpxbfJqoaKDAIqBvXWhjAWQrFuZixV
	XdAtCMjR9+DW4MKqCMMuZLne3Tgt6TsegZyFHEu4UmG3mU/mtsrFh3xBK4WRKzerybD6aH7P5nC
	Fl4pCFPL+PRvdPTbo21pq5RSJoiSMmw9QgybGz3LBJwpW7Vl6cKcLv80ZL4KWM3q6jkTZ8p+DMk
	0QJkZt4c6H8h7to1wxQhqhZWnEOwrqCQM5MaBHTENeX0FxXJ7UUkwBDtcGD8Qxl/VkgXnvbDiSi
	2DO/9XXgqcvKKhySOiDuJjmw3Ai0yZ/1JHJNzeMl1vwOVzSzjH2eEx4Z6win72WijPNZ47n8O5M
	/Vc2tNHbjZ8QIBUc0N464D+AlykR4/tRxqEbT/mb7ql+eybjwDqZygVSEgZAAF/PkoQO6T7POBx
	DEEp3b0a5XWcNvR81Kx7arcrDOZHnyHFFtS9R+4r1RAk/px/i2wwA2P6KlAXVoU1bOVQ5bMqQwH
	iun2KJq0uxYtvqfrJfVbsyj5ViI=
X-Received: by 2002:a05:690c:690a:b0:79a:4419:71bb with SMTP id 00721157ae682-7af6fbf1901mr168804417b3.21.1776124607752;
        Mon, 13 Apr 2026 16:56:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fdff108sm59593707b3.42.2026.04.13.16.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/8] pack-bitmap-write: sort pseudo-merge commit lookup table
 in pack order
Message-ID: <1f5835e8c62880d40187989466fdc70dfe89989f.1776124588.git.me@ttaylorr.com>
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
index 20e77ab4390..dce43ed8dc6 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -462,7 +462,7 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges during fill-in traversal' '
+test_expect_success 'apply pseudo-merges during fill-in traversal' '
 	git init pseudo-merge-fill-in-traversal &&
 	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
 	(
-- 
2.54.0.rc1.73.g8f4e0170952

