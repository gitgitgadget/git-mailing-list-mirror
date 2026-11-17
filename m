Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937472;
	b=umRuMMBvI23NASIYxkvOCraG+YgSYcb/YHuMwa1WnvbnRLjaP0R9KXxUb8P1k7B9HrtX
	 05aOGwAO1YhL/3vWwmX6dVZr029tT8C7g6B1dSTWZK1WiR8WnrLfa7Ngabc8CBQib99lx
	 0c+hTjl6gt6TjQPnA9E1qGJmQjsXRVV+2NyEG+ojS6ddG2TAcw+djRdAhYB3axg/TUVwx
	 KbSdLYDgipvmMvLnR7EQ1x32wgNdkBYWM7YaWLA8/smMU77VIAH7wocNmoTReOywS+kvA
	 lB2jYjbuCFeLZFIrDznFwtw/AQrC0KC/ziaJbJZZMnAG5J62DZTMGqeB3aPYBd3+Nww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+5AtRx+66w99T+/ncYQO7jrZFEnICvhWHI1O+838cSM=;
	b=DYj/yG72Za/N6G86IYOxA08OJM/Io8FoWuezOKGPBR/p2EONImM22s9x5WTN3UdN675t
	 5HGaVTtDwy9gGeSUr0enfwZIi6bQDUa7YU5kpO5/0zXAzSPVzNNDrcOZNXzGM9Ahnh0e5
	 B4Tg20a3xXwg4Qw03dLuXYrgNyfqTlUzhiBNyRiFLop23Q/hydBf37dJutyHPEUwGP9TY
	 JWpmtAppxBTHyUX9XU732oAoHuk5nNzjMpkSou6xZSDpSfu8AhF9MtlfJqqyzG/ZHVmWM
	 pNz5qIQuIMtNVeu45hYibe/uYp8tys3GA+RA75ua9yw4o5aulIj8cHwHKX5aCLpOoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZIqbJsdl;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B8606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZIqbJsdl
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c510a28688dso64194266b.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937470; x=1795542270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5AtRx+66w99T+/ncYQO7jrZFEnICvhWHI1O+838cSM=;
        b=ZIqbJsdle1XNidDqOjw0wqqEAr75O78m2fI8nYAcNjQ97+yPU+moyJFhlJKdS+kvz+
         EslH3sXFrsIPHbkgysAdRqQ/eVqyUEQVygA6V/R99JXcZili8f+tMuHMStHDkdtsIZoM
         GoYboUqKY8TgASYDv0vMK00okAQ2RIy29G01A6+JUN10MVppgPX4+H645q1WUzrYPAku
         JlSAFlbe4uFTb/pcpikTsvReeBBHJxy3iC4usOXwk5q6K1G4QZ9o7lyuZ66y8P6kQlI6
         qDz4tD9CM4bIIKf8Pee66bZhktPFLiO7Cu1c3pGikdS+qLubrhOWNOuzz9BZeMLaTFzG
         RsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937470; x=1795542270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5AtRx+66w99T+/ncYQO7jrZFEnICvhWHI1O+838cSM=;
        b=UnfhYB5LGZNAtAV6UzjyMO3O/n7N1zUSMOsc37yCZuPROT2DEI5hRZhT8hCJUjrSs4
         9IdSg5Si79gAOQRNfEC3aUW3sMhyQJZ8JIDedRVnI5GTxUz4zboCH2tPm9aXdiPBQiK9
         nEgQ26DJbpTaCMx3eWbXNxeYHaEl0t67VYcsgpf6IEpD+ixgcXJgliOfD+V/Rl5FQpHE
         yFq7gp5CCBXW3KOASdsm0eYkq4LQgqE1JMuotosi/hR1y3gaBDMA6YiIw7Z0wdtDKsla
         gboTWnTpdQewuLHcDgf6tRckghNEGk7fAYUgjsiKXn6m0Eq9cf2zJYloSUuOS1YWSicG
         fp6w==
X-Gm-Message-State: APuU4Z8Z4QiGm5ZtWvzDADC3o4KiNwwMuLkJD2+Rb4tqEUvvJnbPPy/F
	zs61VVOvTfC5A9S/qH91mUYvcAT85kQ/HDGukdTPKrSjoSdlCSROnUPEOGoHIw==
X-Gm-Gg: AYBFou3ZQKh8MO8KjFknfYUU2l4Ado5FZVpl2VUb546KTlhOmLu52IYxbI9In3MHlG1
	EDdfOZA8+tF86BpZ8xpDtGzeVva0AzZcJNbWkBR0X/EIkm/Jgp75gK6bpcT0RNxr7P+T7H9GMuG
	qdgJwNc/i03igpf3ngzwB5H62pWQzSphsBypPOBHJJpgJDkczIkYQ4mz/K9FkPLAq/tRVvFHpc0
	VfZnjOf4x3z1lHXVpy+glddK13MOLS0MSsmscK/ubfJq0oz9bwwXhrfSMKqioNKDPXd1p9X+QXP
	OAKQmYC9W3Gb8hr64k35QNn98gAmV2AHZQisYgkwLMNGXAxJ/nKuL2/AHVQg/uGIdCddkURBx/Q
	zYQmZ0uVrI8qctlDTfkKlNPxwuXS7OZmr8nM6t7gPEdaIqT/cCuqlhyC/iiuOFwFC4IgCVIxTWJ
	N0Q6Q+0ueOXP+Z9x5INO/jPC+FVLiexwzL/yDTBVX0vSwU4yYKFI9kcHg1CLBE5q4gx1oD6ygZh
	CFjZTv34Aqo06FR4iI1lEC8Ij4t1k1CmCDul6eacC35w3953+EbEwH1AUkOFiiD0b2isvzCGGNH
	K7krXbzAmamihynEA46XBWxlNjwySs7KrHI0ApXWelxZ8EnYCEpv/461zizNBuddl6gos25OgUU
	MBOq7/YuBnHlYnUHHsdAzY046nogTHjky1KmABga/FfktCYQ//puO+5Alf1G6S5z0uwTs2lc3Dn
	BjUkUKDyNl/ruklBkKVweOImCC7/vZ2oVr9auRZXmGwXYzs0Wvs9JG97ajwECA
X-Received: by 2002:a17:906:4fc8:b0:c46:ba0d:3728 with SMTP id a640c23a62f3a-c510e2d705dmr924266b.18.1794937470120;
        Tue, 17 Nov 2026 09:44:30 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fe47sm7947366b.5.2026.11.17.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:29 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] xdiff: drop LONG_MAX check on merge result size
Date: Tue, 17 Nov 2026 18:43:57 +0100
Message-ID: <20261117174353.1158905-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.495.ge87f5c5eed.dirty
In-Reply-To: <20261117174353.1158905-5-christian.couder@gmail.com>
References: <20261117174353.1158905-5-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 288266c11d (xdiff: use size_t for merge buffer size computations,
2026-10-16), a `size > LONG_MAX` check in xdl_do_merge() makes sure the
size isn't truncated on LLP64 platforms like 64-bit Windows.

This check was useful because that `size` was assigned to mmbuffer_t's
size which was a `long`. Since 81db32ddce (Merge branch
'jk/xdiff-size_t', 2026-10-15) though, `mmbuffer_t` has been replaced
with `mmfile_t`, which uses `size_t` for its `size` member.

That size was still passed to odb_write_object() and
write_buf_to_worktree() that accepted `unsigned long` arguments, but
previous commits have changed the types of those arguments to `size_t`.
So the `size > LONG_MAX` check in xdl_do_merge() is not preventing any
truncation anymore.

Let's then get rid of this `size > LONG_MAX` check and allow sizes as
big as `size_t` allows, so that merges with results over 2 GiB no
longer fail on 64-bit Windows.

This also allows us to clean up related tests in "t4300-merge-tree.sh".

Note that overflows in the size computation itself, for example when
`size_t` is 32 bits, are still caught by the st_add*() calls added by
b1313872ce (xdiff: check for overflow when computing merge buffer size,
2026-10-16).

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 t/t4300-merge-tree.sh | 13 ++-----------
 xdiff/xmerge.c        |  4 ----
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 41386d6025..54bf6c0327 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -430,15 +430,13 @@ test_expect_success EXPENSIVE 'setup: base commit with attributes' '
 	git commit -a -m side2
 '
 
-# We have LONG_IS_64BIT as a prerequisite since we guard against downcasts
-# from 64-bit size_t to 32-bit long (for example on Windows)
-test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,LONG_IS_64BIT 'no buffer overflow in merge-tree --write-tree' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'no buffer overflow in merge-tree --write-tree' '
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
 	tree=$(head -n 1 out) &&
 	git cat-file -e "$tree^{tree}"
 '
 
-test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,LONG_IS_64BIT 'conflicted paths are listed without buffer overflow' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'conflicted paths are listed without buffer overflow' '
 	test_expect_code 1 git merge-tree --write-tree --name-only \
 		side1 side2 >out &&
 	sed -n "2,\$p" out | sed "/^\$/,\$d" | sort -u >actual &&
@@ -449,13 +447,6 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,LONG_IS_64BIT 'conflicted paths ar
 	test_cmp expect actual
 '
 
-# Ensure we properly identify a downcast from 64-bit size_t to
-# 32-bit long on Windows
-test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT 'merge-tree dies when merge buffer size does not fit long' '
-	test_must_fail git merge-tree --write-tree side1 side2 2>err &&
-	test_grep "failure to merge" err
-'
-
 test_expect_success EXPENSIVE,!SIZE_T_IS_64BIT 'merge-tree dies when merge buffer size overflows size_t' '
 	test_must_fail git merge-tree --write-tree side1 side2 2>err &&
 	test_grep "size_t overflow" err
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 5a78b88fad..2ef9c049e5 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -669,10 +669,6 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 						    ancestor_name,
 						    favor, changes, NULL, style,
 						    marker_size);
-		if (size > LONG_MAX) {
-			xdl_cleanup_merge(changes);
-			return -1;
-		}
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
-- 
2.56.0

