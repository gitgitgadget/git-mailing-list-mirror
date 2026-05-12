Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8F230BDB
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546824; cv=none; b=ilMxtMyLLo7K+nxWVjoR6zuWmEwRlSwxnLOCTHuQWKSLayGDPN4cUe9oqK7OcrV54QXZ0H+NmDNg9HEQ60goz64Np6bHliXxC5Yx4YeR0rYQ60GP5IXf9gfNKeTdqiSgp0ondBncENLebeph8KzBkS0cAZGufXoChvFD3fMxbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546824; c=relaxed/simple;
	bh=s8OQjlSYVsAxmP+FAzMKEy3FZPTFfo2SqUk5yNuTaKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyv6xkILNmgfL0w2AmEnQK30jXLEbT5e5FNteQivewdHfdsRdUX7PQu/VsMN8Sl+ZtTw9fYnDLLYj5RjSFnCA5P4Y9tAgdNOY2zmf4DSwPQMwd9tvcDQZ8ZsbnJf/tKPfvAg+MoK/wlkarY/y+yBrm8qcvoRcchTaDF2nVA49h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ADoRMx4H; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ADoRMx4H"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bf14e33f5bso44139307b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546822; x=1779151622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybIqTig8al64SfzZ+toEWLAj80igOkTcGlVuCp0KIs4=;
        b=ADoRMx4H2WN0WHIEFxCodEVeLzF8KusrBiZKhy6h4DEZm+CqgCxq5u2QuaV6Yh5GbP
         QGs4/5xOdVKPQe8VzadDgpCsBGHObGepVlnUHni46h5xchfGqwKpOJRO8PcJijAl2uel
         QH0UweEq0L35Jd+KxdXjaONG6ytI6w5AwVlqNdpJfAdW8pgxiLZ2abxxmanPTx7nJkLN
         xNOwE0Zf9t29wV7At13U7StQu3HzhJ4nPbx4+oe8R3AcBT3p3gRrHpded+TcnjCG77xb
         B66CMaO1x4TvajkKLqjJHaed+4hiX/KMbGd5Y2vNVHHtBlyEsqRzLtLAjugcCXZaey71
         oMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546822; x=1779151622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybIqTig8al64SfzZ+toEWLAj80igOkTcGlVuCp0KIs4=;
        b=cSuIomXUvFC1sbFdj96po9uOmNUhLJboAiH76kHhuXG3aXjO8ytNVCpWeDzFo7sJHk
         de9OmPKyDKvIoZod45VnBaegWnj/aD+jQPVNrn49jq3LV+fbxa0wLtAJU+nka2kHnIVq
         +G/AvoNjvorGRBrdXw31ZDJk/9TbaqKkFTB6NRbmBf/EJNiQO7+Bi8kG0WR3nlICPjDW
         leliWnew/XOabWh17AfReaRkOkN9BfgB5Y8QB331LBxFku5x2sMOnpHtf4Ae3fJwds7P
         Sy5IbA4kTLNHJZjQv8F2vEnDt342u5OUucLdz9YaKNktJkQgOHUzbT41+8x3QFGY5Dve
         VhUQ==
X-Gm-Message-State: AOJu0YyzDWlUYohaeXMRFoD/xCy3Y3gsN9+WaVNn+IcNSHFBpd05yEuk
	JCT3MrgG0LOdNfV57kldS0SrZfSKTeR8zA3N0/1rs1gd8pm7HpM4j1pAV9wBD8CALS//Lg8jptW
	rAo0tQW9wAQ==
X-Gm-Gg: Acq92OHGi43AC5TMIRHa9pFUIZZXdb+dxslAKFxdlMNsgufID+uLrfntTPKh/eRavD2
	C6Up+wV9s/mv3vfHu2FRJopimcSvAEi/edG3MtfIWsFRD88fbcO2kj5KufticEUtlRqPQc8q9fm
	vsZpf8kjwjxAJiyAlbAB7cbnFMYGbRy+Ls8zRTkO+fGiFvBDQnQw10zoSr3O4Xr0g106Yz3xo7E
	7jrfhf5zbnOQlwbxdW4XzM3hDA2fLGa5hWwC3KYUj9F5A4XvZM5NE16EFyU1hntDqRr706Ev/4y
	7wOsqgf8xcYaoueep1pX6VIJcFC8nVvHFw4yRrv/dDO7cBMPhldr7x9+4e0t+MNGzOuaoyjVLaf
	9xPGWuY9wmd4inXIjSG21ogKqEUvwJhLGEm1UCeW2GZog4YO9J5KwcIWM2VMV53GQC77nrtgBLo
	ZtL1GDDlYLRBnRI0MGa78M0mm2NW3UVRW1EhZCzYDA9itOUHZgWOUZ9PgD8ahhKK70CskL+vdXC
	hunTD0e7njdhCPxN3PiytE6wCKRKqXMDfzyW3P5AzAIG9+1tiAC5u71+q5+aZoCjdmxqitiWuto
	+dYYC5n67YsTlcA3
X-Received: by 2002:a05:690c:97:b0:7b3:6c50:2e8f with SMTP id 00721157ae682-7bfb9f8eccbmr167433147b3.41.1778546821785;
        Mon, 11 May 2026 17:47:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66528237sm155083657b3.5.2026.05.11.17.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:47:01 -0700 (PDT)
Date: Mon, 11 May 2026 20:47:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 5/9] pack-bitmap: fix pseudo-merge lookup for shared
 commits
Message-ID: <06e3410d323db13f7fd836ba79cd97586c511227.1778546804.git.me@ttaylorr.com>
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

When a commit appears in more than one pseudo-merge group, its entry in
the commit lookup table has the high bit set in its offset field,
indicating that the offset points to an "extended" table containing the
set of pseudo-merges for that commit.

There are three bugs in this path:

 * The `next_ext` offset in `write_pseudo_merges()` undercounts the
   per-entry size of the lookup table (8 vs. 12 bytes).

 * `nth_pseudo_merge_ext()` calls `read_pseudo_merge_commit_at()` on a
   pseudo-merge bitmap offset, misinterpreting it as a 12-byte commit
   table entry.

 * The error check after `pseudo_merge_ext_at()` in
   `apply_pseudo_merges_for_commit()` tests `< -1` instead of `< 0`,
   silently swallowing errors from `error()`.

The first bug is on the write side: each commit lookup entry contains a
4- and 8-byte unsigned value for a total of 12 bytes, but the
calculation assumes that the entry only contains 8 bytes of data. This
makes `next_ext` too small, so the extended-table offsets that get
written point into the middle of the non-extended lookup table rather
than past it. The reader then interprets non-extended lookup data as
extended entries, producing garbage.

The second bug is on the read side and is independently fatal: even with
a correctly positioned extended table, `nth_pseudo_merge_ext()` feeds
the offset it reads (which points at pseudo-merge bitmap data) to
`read_pseudo_merge_commit_at()`. That function tries to parse 12 bytes
as a `pseudo_merge_commit` struct, clobbering `merge->pseudo_merge_ofs`
with whatever happens to be at that location. The caller only needs
`pseudo_merge_ofs`, so the fix is to store the offset directly rather
than re-parsing a commit table entry. The `commit_pos` field is left
untouched, retaining the value that `find_pseudo_merge()` set earlier.

The third bug is latent. With the first two fixes applied, the extended
table is correctly written and read, so `pseudo_merge_ext_at()` does not
fail during normal operation. The `< -1` vs `< 0` distinction only
matters when the bitmap file is corrupt or truncated, in which case the
error would be silently ignored and the code would proceed with
uninitialized data.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c             | 2 +-
 pseudo-merge.c                  | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 86ed6a5d78c..1c8070f99c0 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -877,7 +877,7 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 
 	next_ext = st_add(hashfile_total(f),
 			  st_mult(kh_size(writer->pseudo_merge_commits),
-				  sizeof(uint64_t)));
+				  sizeof(uint32_t) + sizeof(uint64_t)));
 
 	table_start = hashfile_total(f);
 
diff --git a/pseudo-merge.c b/pseudo-merge.c
index fb71c761792..34e1da00b4e 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -600,7 +600,7 @@ static int nth_pseudo_merge_ext(const struct pseudo_merge_map *pm,
 		return error(_("out-of-bounds read: (%"PRIuMAX" >= %"PRIuMAX")"),
 			     (uintmax_t)ofs, (uintmax_t)pm->map_size);
 
-	read_pseudo_merge_commit_at(merge, pm->map + ofs);
+	merge->pseudo_merge_ofs = ofs;
 
 	return 0;
 }
@@ -671,7 +671,7 @@ int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
 		off_t ofs = merge_commit.pseudo_merge_ofs & ~((uint64_t)1<<63);
 		uint32_t i;
 
-		if (pseudo_merge_ext_at(pm, &ext, ofs) < -1) {
+		if (pseudo_merge_ext_at(pm, &ext, ofs) < 0) {
 			warning(_("could not read extended pseudo-merge table "
 				  "for commit %s"),
 				oid_to_hex(&commit->object.oid));
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 5411fbf1e04..90459da5e63 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -549,7 +549,7 @@ test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges with overlapping groups during fill-in' '
+test_expect_success 'apply pseudo-merges with overlapping groups during fill-in' '
 	test_when_finished "rm -fr pseudo-merge-fill-in-overlap" &&
 	git init pseudo-merge-fill-in-overlap &&
 	(
-- 
2.54.0.76.g9b17dab2cf7

