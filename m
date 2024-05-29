Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378D1CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023324; cv=none; b=GBMS9YH75FF7IQ3NOd5qlpIzKahDnX40cG3AR+F2CzglHNjDvC9z7Fr/2+UAINDRKmWGwyEB05bS8CdopPLImTe1hdfG1SrkRTfiQdeIoTprxT/9zza2fhtCOcvedhWXqDW3aj4nvV2oR8VBvCVFza1lHd/tICOivqXF1ZCE8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023324; c=relaxed/simple;
	bh=ncEr/vdaghLw4HaNscI2g7Vk7X2GkWVl7hYiIoOHUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuBho1j3oNyyhhFlIND0hTUzhU89E3YvHE1yfhKaD1bZWT4Hev+LiKE1J+ILSoy/LGW2MozE7Vhd3/thYbSKAwJPyMt9HKNuzJWFGUJI+ejR9mA+ZeWEFm1NKTSrMAgnhJ0bTdF/XI0RpZpl4gJBWDmWUoeIdjdQwmGzC7w8v3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BTp8ZMap; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BTp8ZMap"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ab9d01c479so1089286d6.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023321; x=1717628121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2qnGTH7FSQCQFCFupyWglJmKwfpyviSgK3xaNDTBnA=;
        b=BTp8ZMapQ7rIXGoXdivbDl4OjcpAckN3G9JY+hJWcFcc3SJZNmRzhdFSpp/4bQlt2Z
         L8THm0z3LRvRBrq+kPjsJ0EWlNWdhmyFyDo7cRCROFhHSCw8jFCfIW8B99rtGy1WZVmx
         latBKri9CRSkxhNVpvFqVJFDEi3sGhcvE/srS2HmERJIZ8NkKTorm8/XKbye+WbtJWGI
         PJoOIsgfoZvZwTj/ew9B85S9hAeTnlOPYd9ZliO8IBf75cAeRsgBRtBBHU6hsiGIeonR
         GIzCWaENgME8ssmiVJrQm1Sb9wHybLfOzzTna8o6RH4HKuADEHtx2ybCHAlM+p67XYZq
         FXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023321; x=1717628121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2qnGTH7FSQCQFCFupyWglJmKwfpyviSgK3xaNDTBnA=;
        b=KaG176hr7RjPOU73Hf2a6DOuFby+7ueVl8AWeAvYvQJKps0Dev/++xJX3gDZx2IRC2
         Zwa1UvtK9xjnnh6VnOLZphGWic+8gmPVASuLFOg/C4vThDcGNwprupeB8OBQcT9lmWPo
         o1Udx0wveWD7MNET5z7gDKcLAyaT2WzW+R8zcG9BKGQ2Dz1KSzhp8n/wUjR4vMblOfsw
         bTSDbaRP5WA8X0X7YAq/cX21q8Sw5cYW9Bbfa+v8AFnPy6DDZWiSy0ikH77mqyESRI3O
         gCgxwSd39nwe2LYXuTuHrsMLh5XA/ykEJlBXR4MjIuyLhuADnPtA4HAQopUhwb2/ZE91
         pmng==
X-Gm-Message-State: AOJu0YySRUTe8jRYOE2rCpDazarz8S7l+NTBZXV+l6puCGwfjHb5Rtz1
	qzkjh6aAR2hASsUB53ERG6YLMJhe135XEnewP23LQ9l8+RG1RZ571H5dBg2lOjOynyyg5qvOJU4
	HR8I=
X-Google-Smtp-Source: AGHT+IGpGu1XA8wx8LQ8yrvMyCp6DnM920ofPRE+3nQs3cmhY/OygySWZuHMM8vdGiRlz9dXQ9Vedg==
X-Received: by 2002:a05:6214:2f83:b0:6a0:6676:f1c8 with SMTP id 6a1803df08f44-6ae0cce535amr4309586d6.59.1717023321375;
        Wed, 29 May 2024 15:55:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac20a134f5sm57709746d6.146.2024.05.29.15.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:20 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] midx-write.c: tolerate `--preferred-pack` without
 bitmaps
Message-ID: <ad268bd264e34f02f9c32e31db696c7acc1efc2b.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

When passing a preferred pack to the MIDX write machinery, we ensure
that the given preferred pack is non-empty since 5d3cd09a808 (midx:
reject empty `--preferred-pack`'s, 2021-08-31).

However packs are only loaded (via `write_midx_internal()`, though a
subsequent patch will refactor this code out to its own function) when
the `MIDX_WRITE_REV_INDEX` flag is set.

So if a caller runs:

    $ git multi-pack-index write --preferred-pack=...

with both (a) an existing MIDX, and (b) specifies a pack from that MIDX
as the preferred one, without passing `--bitmap`, then the check added
in 5d3cd09a808 will result in a segfault.

Note that packs loaded from disk which don't appear in an existing MIDX
do not trigger this issue, as those packs are loaded unconditionally. We
conditionally load packs from a MIDX since we tolerate MIDXs whose
packs do not resolve (i.e., via the MIDX write after removing
unreferenced packs via 'git multi-pack-index expire').

In practice, this isn't possible to trigger when running `git
multi-pack-index write` from `git repack`, as the latter always passes
`--stdin-packs`, which prevents us from loading an existing MIDX, as it
forces all packs to be read from disk.

But a future commit in this series will change that behavior to
unconditionally load an existing MIDX, even with `--stdin-packs`, making
this behavior trigger-able from 'repack' much more easily.

Prevent this from being an issue by removing the segfault altogether by
calling `prepare_midx_pack()` on packs loaded from an existing MIDX when
either the `MIDX_WRITE_REV_INDEX` flag is set *or* we specified a
`--preferred-pack`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                |  8 +++++++-
 t/t5319-multi-pack-index.sh | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 2fa120c213..591b79bcbf 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -935,11 +935,17 @@ static int write_midx_internal(const char *object_dir,
 		for (i = 0; i < ctx.m->num_packs; i++) {
 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
 
-			if (flags & MIDX_WRITE_REV_INDEX) {
+			if (flags & MIDX_WRITE_REV_INDEX ||
+			    preferred_pack_name) {
 				/*
 				 * If generating a reverse index, need to have
 				 * packed_git's loaded to compare their
 				 * mtimes and object count.
+				 *
+				 * If a preferred pack is specified,
+				 * need to have packed_git's loaded to
+				 * ensure the chosen preferred pack has
+				 * a non-zero object count.
 				 */
 				if (prepare_midx_pack(the_repository, ctx.m, i)) {
 					error(_("could not load pack"));
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index dd09134db0..10d2a6bf92 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -350,6 +350,29 @@ test_expect_success 'preferred packs must be non-empty' '
 	)
 '
 
+test_expect_success 'preferred pack from existing MIDX without bitmaps' '
+	git init preferred-without-bitmaps &&
+	(
+		cd preferred-without-bitmaps &&
+
+		test_commit one &&
+		pack="$(git pack-objects --all $objdir/pack/pack </dev/null)" &&
+
+		git multi-pack-index write &&
+
+		# make another pack so that the subsequent MIDX write
+		# has something to do
+		test_commit two &&
+		git repack -d &&
+
+		# write a new MIDX without bitmaps reusing the singular
+		# pack from the existing MIDX as the preferred pack in
+		# the new MIDX
+		git multi-pack-index write --preferred-pack=pack-$pack.pack
+	)
+
+'
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
-- 
2.45.1.321.gbcadaf92783

