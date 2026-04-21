Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BC3446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803838; cv=none; b=oLKfGHVcAG8S7AvLu5nwnyBYfbXfrpDWNTWJjxSdLseYuqA3/aeqcyzp9eEdiT5eZKMzUc6JQYtn+VNpItJewDULlAMn0GNpw6mjJTVibg73fyav4lQCNxpZini2LBC2q+TsYFNACPe5EhqPV48+bezAMWmK47NaOxkkWlSygAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803838; c=relaxed/simple;
	bh=hNFm5oiMzFp5BtBx7GN0f3KrkvfZ9DYmmbBbUrLy15M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMfJzdoylauNRhY7jkXdLeYyUImX/ZypIVePcTDCClJlKpBqRKu2ebBVbNo4jpO2T5SkBrPUQsslg1JI4kHIyY0RoEaX4hrU7f/wG3/MPup53vnPcTTNHkwgT+ngHsf7Yp1UbxkzONlWH7DGxt4fnvfcFxF3y4I3L9r9oi1bXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=K22XpicP; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="K22XpicP"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479eb8bcacbso828813b6e.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803836; x=1777408636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEYMLYO7cRTtbVdfwZXTb8sH7lsnlTMgLTUvMYBeEP8=;
        b=K22XpicPafFVFNXIbOdHhSMSmVzHNDKi7fwN55BH2IACAU1aNpZd9A9BJ+eset0eNt
         eOhWEkfs0S3Ky2wjXQkkkQVlMb9/y77AQ/GDSf6iB0LxjRh/rLjZmnHHSbEekWpep/2K
         i2jaG5e8WJYdFwtgYTxfGEftyTWEMd9cxll44aIEHDUpBZGx2t6eWdhuhlxn1UyuH7Vc
         NOHMLYUY/QlRMdoF/rFf5Bs6Ku4baDcoyQTL3ozTLhnjRSlQy9VYKO0adP8cF83diScH
         EOYGPSfdLpr7fVXK7wt9qHUL2DyS5U8gTsBrOkPK44wREockEh3VhxkBzZm73e7LoB6D
         ROvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803836; x=1777408636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEYMLYO7cRTtbVdfwZXTb8sH7lsnlTMgLTUvMYBeEP8=;
        b=OxBnPbnuXT6Ii/6h2eU/lh6diG4sars/yJBFPOOgOta1Dkr9tLuDy6t7KPOrqb0Ku2
         CuMgw28v0BpbfeuiZqi0zINAi2im1dGet8wvLshtv6c2w20RqdSZPKr+PDXasENpUazM
         riWgqzO7I7FUpDTWf6obTRfp3/I7Wv2fLqosR9yPGVMLZhPYQJA+wFNlYV/f/qZHxIrM
         5tD8dSFN3WE249XSYlbXo6xiiDEUA+6TFZpBrp/2r+uv6sjiXx4jq/WCS522WkCNqdQm
         oUH6s5FRBD4HHLZOubtGM76h53kBqvlNBqqWrpZKh/xsPSbtJbjMcOs50InW6lMyNSOY
         oToA==
X-Gm-Message-State: AOJu0YyePhUcTRSuoX5piDAOsnhuiPIi3BWe9piisCphzEAoLc4IND21
	KJd5p7mliQQFzkqMc1ln2EVCWhXjRshd+nz7nzdVg65o4oqafB/YBD8L1I6ctGohYmTqEkqdTdk
	jY5Zu1Kc=
X-Gm-Gg: AeBDies2DZZUHCTl6RKK3b3ziS+bDeYVjf62y4KOUe3rZktSH9BCCZBbYVsO1e5zrtu
	wFLqUhksYNLEmg6JtY19VT436jxmL5fEq0vMjDO/jjvYPBANG1bhUyFFQsL0sOsgBExotQ6oWhy
	vIGxCdggPB689ybvtjb7lekmGvIqYHiNrcCIVIWCWB+CJpNEmT9mvY11jcVI47F9K3kUCOTa5an
	WB4UX/Gf7E2afJPzMW6aDClo/YvKMr4th59FqzCCa+TO88mBhRAYKc8MYa6aumZz4NQ1xiSx6jd
	1ds6UsBiWvbi/kXZfwMeHzs5Jw1Mh+KNDeLLf+kopdspXtxVyAdm1R5WyICCfasYrHya6zrNorm
	5iSjWmY25YE4k0J/ebFuRB4pBVfS+/k0xEZDLYBPYBSvFakCzBQDmH2IXh1VBjhE+dzXoDMbD3J
	IpX62dHojjU+BJ8QfwZ5lyNm8LwkaagOs6HNfjJAHQg+0ekIrOmQryl+HgmRFpopyf7FUNGITzt
	pPjg42H1SKwCUT49yfXDA+Xbh/85MlO8fAdVnCqLpWpx4x0J2JzzheE4vOag44K+lG+36yTipPa
	ox3FDEnZ4qjqxucpimF45Wn8hLI=
X-Received: by 2002:a05:6808:1301:b0:467:2375:58c9 with SMTP id 5614622812f47-4799ca307d1mr12931157b6e.45.1776803835919;
        Tue, 21 Apr 2026 13:37:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff36814sm9913966b6e.7.2026.04.21.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/16] midx-write: handle noop writes when converting
 incremental chains
Message-ID: <d6c27317c25895da223906e07b82615afb6f633d.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

When updating a MIDX, we optimize out writes that will result in an
identical MIDX as the one we already have on disk. See b3bab9d2729
(midx-write: extract function to test whether MIDX needs updating,
2025-12-10) for more details on exactly which writes are optimized out.

If `midx_needs_update()` can't rule out any of the obvious cases (e.g.,
the checksum is invalid, we're requesting a different version, or
performing compaction which always requires an update), then we compare
the packs we're writing to the packs we already know about. If there are
an equal number of packs being written as there are in any existing
MIDX layer(s), then we compare the packs by their name.

This comparison fails when we have an incremental MIDX chain with
at least two layers, since we do not recursively peel through earlier
layers, instead treating the `->pack_names` array of the tip MIDX layer
as containing all `m->num_packs + m->num_packs_in_base` packs.

Adjust this to instead look through the MIDX layers one by one when
comparing pack names. While we're at it, fix a typo above in the same
function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                            | 18 ++++++++++--------
 t/t5334-incremental-multi-pack-index.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a25cab75aba..9328f65a201 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 
 	/*
 	 * Ensure that we have a valid checksum before consulting the
-	 * exisiting MIDX in order to determine if we can avoid an
+	 * existing MIDX in order to determine if we can avoid an
 	 * update.
 	 *
 	 * This is necessary because the given MIDX is loaded directly
@@ -1208,14 +1208,16 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 			BUG("same pack added twice?");
 	}
 
-	for (uint32_t i = 0; i < ctx->nr; i++) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, midx->pack_names[i]);
-		strbuf_strip_suffix(&buf, ".idx");
+	for (struct multi_pack_index *m = midx; m; m = m->base_midx) {
+		for (uint32_t i = 0; i < m->num_packs; i++) {
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, m->pack_names[i]);
+			strbuf_strip_suffix(&buf, ".idx");
 
-		if (!strset_contains(&packs, buf.buf))
-			goto out;
-		strset_remove(&packs, buf.buf);
+			if (!strset_contains(&packs, buf.buf))
+				goto out;
+			strset_remove(&packs, buf.buf);
+		}
 	}
 
 	needed = false;
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 99c7d44d8e9..c9f5b4e87aa 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -132,4 +132,20 @@ test_expect_success 'relink existing MIDX layer' '
 
 '
 
+test_expect_success 'non-incremental write with existing incremental chain' '
+	git init non-incremental-write-with-existing &&
+	test_when_finished "rm -fr non-incremental-write-with-existing" &&
+
+	(
+		cd non-incremental-write-with-existing &&
+
+		git config set maintenance.auto false &&
+
+		write_midx_layer &&
+		write_midx_layer &&
+
+		git multi-pack-index write
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae

