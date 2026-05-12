Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F08231832
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546818; cv=none; b=UZHGQj5C8Rq/G3S/749zrhLOrE/eM4GTjYbBuP294kneo1cy3VB0N01W2JKZ6GLj0vq7ujn9zSmoHqvkSHX0Ks7pLV5bbRM2zda45Mt+6tKlhpGXcRJMrr9vjHaAaeJEV1EFu8ewbjMTTBExIu1V9aK2xzrck2eAHMoU0OzEY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546818; c=relaxed/simple;
	bh=TakGr70PE8Gt+IvrbEcdXkKJmTzvijzNsliZL+DBzXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbu6nMyJzleUPKboYkAUqm94aNCvePCCW05Og3uF/uUG2oWMGgrarjWAIYrXT9/B+GPdK0BrXYfNROWCFtS7I+77gwA5P3kKTxMczDgvO0YehpztkUB+Q0C1732Iqz8xGgA2Nhj7vwHCWc/C14JQhs+kYxq49B4rCQzPJrAdhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NfW4VStr; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NfW4VStr"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-651bc83e74aso5163947d50.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546816; x=1779151616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr1ZqLeukVnoHiQK5Iz6tu0UlgxxI322+JBSQdX5Xrc=;
        b=NfW4VStr+2ab1kLRShZz6YekTnA8ronTjjU7K/BwOKOViXvdOvYdL6zMyNJ1g8KUpi
         9D4lN3mP9/+1/IoTgfaYrSuaKPEx3tYxzt23304MquiR6AhQe/mVlN2j/jLr0iJkqxe2
         E7J3TQoOCdGqce+CTRxagMXRb+wOXLwgmJV9RY044iN52ZkXv4Na+LQw3QeGJ4/yrK1h
         oX7jAY9u7lK9zCyRNgu7YG5SZaJbskYd6inl2SXWe7p45BnV5TKsbUCM08R4U43yS9jq
         FVHbC/hqYHIyKUeBVov2gKOCjqF4pd63AE1rwc++4XLDcksMcl/SIIGFysceTxaA61Pa
         b8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546816; x=1779151616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr1ZqLeukVnoHiQK5Iz6tu0UlgxxI322+JBSQdX5Xrc=;
        b=Ff5s9TuIMPx18ZOvU5pcF/Dzmr5ZbeyHIGoYARoZY83y5Bqd25Nzu/o/IkaILB29vu
         6FAVI/EbLEUrRtBUEby+R6QxsXMohZBcbEvEj5a9H1q9rZcUe7YsCN8QxbQgZPdSgJY+
         c/tLummA4QkLC9yM8ncw0eFsg8nBmb5J2itdhn49YW4OKVvBxxIU51xG9x5Mk/6DjeRX
         599rH6YqXvjP+NSfs5J7KpInTfm/oMqQe4tnwOqBpZQmllXhEhLDnytIWXegguZeWAb4
         B11CqAKdWZnutj6T15h00VGO2BGmZnwCQALpkAHJl8G2zte0CYL4yacGuPKQK2ttmsWw
         Th+w==
X-Gm-Message-State: AOJu0Yxt+R/1yAvNR2hOpEI4e7wMGjmx+FZroeqTErNax1/t3SEVegWd
	zkhvDI4R8DTl1DgMKl25FC1MzraeGAO9JHPT4iw1094VU5OsOvP+dKUfxq7eVc0JlPSvSNNQtMo
	48NLqN0Y0INyP
X-Gm-Gg: Acq92OEaahea4r8Gukh3iTq8zUuNaBagGkIKja+ZQPvqP+sTmGQcCB6JK9x7KYgsCRT
	DhgVdtvbtxF3JifR5KalTPFLJTEZkENUmC0xzycsdc3V+gjCx1QzM0SAP4isNJ7/jxxqNHRcTC5
	QP+Yj4C78F9k2m10hNB6Gaeb33Crd6dZoZKxrQ4ETcEcRdHTdrTw0jldd+xCVACC17XXa7U1rk6
	PT8vq0JF8pgKKvaFSjDzXqMoIo8ooHk3mlSWbBPz4FHgo59PJHf+Z+e28dmphWiBdlhM7l00yv6
	uMvN+uuvbXSzRY5NfpfruhFV7WsEmxMBWV0rpHKm8AJPOiXUUyzN2nPoFcfQOFwobLxjnOEWRY5
	1NSKmCbRDVeEeyBoS4ci7BBexYfhYBMNlvMXVHBgzaaFpzBpl1It8dFbsub6EX48F4YhHVDUMTW
	CF0Xk8C0ZpKtlVjhKbOcyhaQ3AJiNVGBEKHnQ04Mj9dMoE8Hr/z8bdxY3p+tdpdnzlPxcpuLF1w
	bSktPIUazJ5Ux8QrdtVNs5axvXhsddQ7ticir18HBjJWHhIfSHnKRNQSIfy8ILVwm4Qf+AciMk/
	teiAZvBnfdMYTr5o
X-Received: by 2002:a53:ac8e:0:b0:652:541e:9681 with SMTP id 956f58d0204a3-65c79c67ea6mr28211714d50.3.1778546815566;
        Mon, 11 May 2026 17:46:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm6254061d50.17.2026.05.11.17.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:46:55 -0700 (PDT)
Date: Mon, 11 May 2026 20:46:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/9] pack-bitmap-write: sort pseudo-merge commit lookup
 table in pack order
Message-ID: <bf3a9a07e5f43cf7586fc73e7acaa7cef646090e.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

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
2.54.0.76.g9b17dab2cf7

