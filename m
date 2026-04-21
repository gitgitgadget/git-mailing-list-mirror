Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F73242BE
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801734; cv=none; b=UBAM1nf2eBjV5+xXfyxO7lp3chWG9Hi7pfyvMgNS4GrDoZSoZgXx0LxfMV7ZbZ5uL6TO45GfqM2aKETnhXsgBuBbQtkld4UBiQ7szntIpiwRRIdr+LViRonClyF2ZGnW8enxsI/l4kTACbW2pa5Asw04EuldSIn14F0GqEFx3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801734; c=relaxed/simple;
	bh=+iTkIDGMBbRzjwGof+cn5vH+r2YwiZqOdpBp+QqzJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRIspjyqsExQtJuzKEqahvSKHPJ0VDqbW7/H0/z/dq46IUw3BX/n3WIU4XC/gb7hGrKhJnt0ZArP+eTnKqg7lhrBuw2oUkts4X6JqW1v/Z5Yj03mbmY/k2Q9U/XvWZEvYSjch2HKNWt0wfZ1wR8NXRQxXA0OCkeUmRCHgSuJ1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FTX9PWKV; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FTX9PWKV"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40423dbe98bso1944172fac.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801732; x=1777406532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VQoC3pDKVtXXHG9SKXQrULQP0DBNakaq4sQsRfHyQ8=;
        b=FTX9PWKVEFuxf21TnXsCBwYp5dW6TgWNgMNBNe1g1RAmYRDE5E7qPQfHMrcLjhB91R
         QO8NuH6La5pc0uN4IZOuN3zSGVCETOysVbPMXfHuMLkYiKOIlLMWKdRI/avvc6BCjD3m
         J3S6gts8igi5McfKxyC+2RiROsH3phhfQplmMg+zdjLpUtzOlQ2CJ3D/TkTFIUUCA4t+
         Ayynneasn42CKl+a/kSnytu9r5LDj9O+OpNpeaQ16E/0XIjboOCZf0J0seA5NseNjVRF
         tB/feuQqaBjwSo6tGETGeQcFGs2eNzQd5iaIugA0L4LRFT35kzC7oFG5CMgAu6pXHszb
         L0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801732; x=1777406532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VQoC3pDKVtXXHG9SKXQrULQP0DBNakaq4sQsRfHyQ8=;
        b=rpVehWR3fMR6HVMpGmGWe6yni+KIqRpWMP1Brto5M0RHfrz+14Fil24Um+RL9z9hi6
         0BKwlp8jF6E3f08Fl/nPG3vFA3DaUNif4w2v19TU/1jVp463845Gqq8aHI3aPeYwnqBk
         5SRfleFSB4ld6QhIV/FQsbzFmFqiEKvUis7tY4hh0hmQqO5VrqybHgfA3tXKE0Dxx3C1
         mHep38Gaa4BWGmjGaB0xea+iUjUviSt/CDT8AQ6LTivMirrA3XBz6RQ86JRXppXIJmFv
         qEPwCNKwefzNlyV3Ps87rNPRzZYQpyEVGoyXCaodhXHHm90KtnhPxQqfC5Y6XnmVWvgq
         WGsQ==
X-Gm-Message-State: AOJu0YzfAmjUiyE1ydKx4xIEkuZRO2xuwORPNvRoDj3rAFXxTn+26RmZ
	EysXfHIgdAWUYqku5YGEDV+7w3QSnHYxdkY3Ii4Jc06pBUBt3A1w2rCS9/xmyCAb9sdXth9EyRJ
	Pw7DR9MY=
X-Gm-Gg: AeBDieveAJRuE3PlC84gyD8OhzXBspv6FgPx4eEStm7YvTxffPn+RDzVhXFw+arazSw
	mMXaPyLNuYAdxcL/xs39gahhrYDcjKeSTXaEd4wMK4fwov5AENjP2q3edjYVeuUIxpfQAB2Azqj
	upFO0+vSWeH5tgyHpdvIjrNeLvzFEOc3j1T5aiLVr8e1bvQ8MQvIZe8dlj43Bp3c6C1E0TeCeVG
	bTVzWS733UHu8S3VL8zX2VNFBMt/CYa8qJMwdakIfA+QI54Cr2XoKia7TYW4/akNFWZ8opsDMop
	cGkOl7wCjLr9axdpvNAHidqYJ9EB0SOhIKr8UflokuOEQg7VRGB07h+EdQYalc3hQD0XW8KqD2M
	pVYF7U0AetT9M7tWWWl2YVhJVCalnddD7KqYwrBSdhoPhZVul/JtS+kuGNEHd0m5t2NV3yGWefq
	QT3C7/xIoWGgSOpjlfMK7EPfVeewVkAdDalu7wcnJIhQS2RS7NoykGj8hxeS1MA/WUDbGvvtQkL
	ccPJdVzmpj/7liyB4MswpH7QtRmQ25AYf2vzQn4BBRK8e+V8lbiMwr8p7MDIUEwU88Er2o5xHyr
	WSPbEKC0X6Xue7P/fDr9llIXfsK6i7TsSnPOIw==
X-Received: by 2002:a05:6870:e314:b0:42c:2c15:375f with SMTP id 586e51a60fabf-42c2c430784mr2769507fac.2.1776801729960;
        Tue, 21 Apr 2026 13:02:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm13211982fac.10.2026.04.21.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:09 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/9] pack-bitmap: fix pseudo-merge lookup for shared
 commits
Message-ID: <3ed0b39843f2102f17a4c9865e05eceba0198b46.1776801694.git.me@ttaylorr.com>
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
index c5db6a11f6a..f558e87ab21 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -550,7 +550,7 @@ test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges with overlapping groups during fill-in' '
+test_expect_success 'apply pseudo-merges with overlapping groups during fill-in' '
 	test_when_finished "rm -fr pseudo-merge-fill-in-overlap" &&
 	git init pseudo-merge-fill-in-overlap &&
 	(
-- 
2.54.0.9.gb905fd5d0ae

