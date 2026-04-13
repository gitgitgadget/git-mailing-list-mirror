Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049831C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124616; cv=none; b=Xs5r+0epLCVMtXwLD19xvgpwjtwZ7GBhfve/nHLysBkbyZGzpZvZ8OMj95p3ewFg3zYQUdQc4VELzs54j7gU3j+MaKeNGC1Ez0ll+Y9qLyBRlTjLrycQhkJ+1WIL0LGRq/5Fh28OiPWcUIG9+HR1r4NymxWmtVevUiHhMGC+swU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124616; c=relaxed/simple;
	bh=G7ZbD7tOnzORgF640x9pab0fNrTRc0y9D1Sz2kFiIGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGpGPNAZvaazXyvulj/q8+Bruq/Nz892tr54mL7Oyd9jkL399JmE8YShe6wthKlR2Opn72ILBki3XITjXme5atP36P3uZMQwK2Gks8Y/VcCij+abqRqkA2bVehIKqKf9UKWLjYEDejurhtgS+fgfTsCJo693GHf7a7jMV5q2G6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=APMAzDRd; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="APMAzDRd"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6501725d888so3812449d50.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124614; x=1776729414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRdK/lJ6azFkG4vBMIiuZIUf05aR5J3Q9Tup/JpDHz4=;
        b=APMAzDRdfaoDbCGk9OAIhjMo/mBd9osmVlTlT3G6mvRRUL+CUiXr/fWTpJdOGp6FcN
         KY/X45tyhmF1SiajrDTQn25BThXkq1VfrOUbOPChgaJ2mDmO81IFoE0MZnzW9s4aIa/9
         xtTBXLkVuB6tKKRiRN7k3gy+nlR+iy+5S6PcokzJjgxzikY5Z94E/WsX60iYQnCZx+F0
         MK7R/8GJR6UmSlyLYVwbv7yaQPuujBYvj6oZjiAVu7fFRvRvaLD4mKWObSncx6HtT4xJ
         ilPFGu10FGYJlKjPz49AiyuEI7GmdJOicEzzpFIbSp8Xij3cEpyzWrG4o6roHs58FTf2
         y7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124614; x=1776729414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRdK/lJ6azFkG4vBMIiuZIUf05aR5J3Q9Tup/JpDHz4=;
        b=cWsJeFAe3TDqSB4ZSHXS8JH+Ra9xKHiTRnI8q8pHbRPhQx+qvhPGoBTAqDMxzsOWQv
         vQLn/NDGsjRImRNYub9fxf6lpb8fTk9iKdpPYay0i6J0ryWT/O1ZQ59xu+zVw4lZ/tQb
         0CAoUSLTrNx2ZotHzVKJRPVqH6ppsXSJHXdLVQq0ruQFu29Pf0IWvn04xSJjuED+79b3
         4O2l9WZhwgNPe/TaC8gb9pqy31EIfNMdbInbcmI02ieXnqDFG+6yzp2l4JCUSeNInVI/
         vcSEMY/nmodh+S1nJrsPbj+c7g1yJQE14jxIafEnKzWPEfknoOnUGKQJ5NvKmnUlCj+R
         EE5g==
X-Gm-Message-State: AOJu0Yxf9PrYEjGz6CVWVM4oxbvZokl8FZXraK4eRESyulmXsLO4C3rD
	fA/HpkHSkj1zIhIXHg+evh553/1LWhHpgPwWXNOwE/UOvRKnaPKEXPsKoTodTO5pdCkxQV4p9QZ
	CRZzj7bg=
X-Gm-Gg: AeBDievHCbgst28Y/sbbsaHP3RBQ5vNi06Ud1cnJzIwSnRul9T/MDFtr1N7UX4sFZ22
	qmgCNh5ZmiFcD4CcQ0kmtY+4t+IDRvtHRCPFVUgpNGMml95itTSl/wLUgHH2+LQpMc2TAGOC6TT
	9/qPV6LfzJJvVmDkkD27Y/NqAYSXITLiF+rU1Q/HxBJU7VHcbehJ+YIvoZ79LcxGEviuLmSHsiw
	XNxsEs4Nch8XeR/Sac9Hcj6te8qnjv4uT1XJqoCwpePhdUPxGO6xuGh96fKT89BIKHvtDhJdv0s
	w+2fXmfXRqsW/lYFVbNlpiRIe/tvgZ/qP+JfvjSezEV1A81JPOXEL90d4j+kHNDHs6DDXZ/ej0r
	0cL5oCUpmolnzBQh2sGF1A+FZg+7r9B4J/sE5x4H6HVqbksWxDRTpETX+7/MJGD8ZF6ah+dDLqC
	vvtDv1CL+/fXW6bdBLMesT/cj1xkWRBvmnnrWWJkaD08Zvf51xHexG2lH+iVimWrKWsHR8Oetmv
	vM+s8kLdKGEJaAD3j6g5Er6rcHu79s3Vt/0FkJ9oOQn1S+IZsNYexg6blUmsG8SlkSlkpRR6yAz
	M1hpowlo0xP0Twi5KfUFUyxbOr8=
X-Received: by 2002:a05:690e:1908:b0:651:a928:4c73 with SMTP id 956f58d0204a3-651a9285307mr12029277d50.44.1776124613674;
        Mon, 13 Apr 2026 16:56:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-651baf7ba04sm3240862d50.17.2026.04.13.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:53 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/8] pack-bitmap: fix pseudo-merge lookup for shared commits
Message-ID: <01f1d6f08c6487c9103cf87e222668b664b30d83.1776124589.git.me@ttaylorr.com>
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
index 5bfb5103124..8844a3bced9 100755
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
2.54.0.rc1.73.g8f4e0170952

