Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544DCA5A
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053084; cv=none; b=pEmfoR3dK+7zh6FWAFBSMtlOludsSy37eu2N9pbLPkbuJYSo0uLAJP3zGI57QP+LAyiYDrhnax+bgoYRVxMIqxW7xHMwHJJVgWmA6C+AzHqbVD52t8VOar/QxlDmf4d5uIiQ9NO4YNfc68ZI7x3iqscvO2QIKqSzZJwdqOonMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053084; c=relaxed/simple;
	bh=xbpJKg4/CWQ3fInBNPUW18nPy0GXPHvE4H1k0VvxSdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpIKnd4/nibSaWAfIXaCekjFNaHKXrvQZxWL9DH4ixmSJhL/OkqtuEJLlUky5pnw3FYYHN/ogh1vukkj1cG1qtF2mAiQmbQzIyKx/MIPuabSyHLZKqGvfx3qAw9mQSB7ugdAT8IOszoF2I9SnGtmTVAnlc+jTib74j1XEx9jJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ngcsnCV9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ngcsnCV9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78665368a5cso30340757b3.3
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053080; x=1765657880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yMvnDAxKkTI5tFqj3Rqm0zJ+TOrTo1XqQHI7t1yFXE=;
        b=ngcsnCV9NW814G3RU6daWI9RC0+KuoIDunf4w+ZK+viPWxTt+hoD62vOhc1oUz0qM2
         PlKfyX6EKvMfGLKrB9jMfnAHQMG84j4YSyVER8Zc2K6vM6q9V2VLwQ6VgpgS1BHScaS6
         Svl2HGYn5ur0qHOWovt7drjvl7sCuca6wd8w7KOwA4RJhgKtRFhbB15TyoMP7h8BwlHn
         wNYqzeahEUJ8LOqN4CTNsMo5er1HOOByr3YTp742yB7jIiiAGBOSL2gCh8CTPNY3ayp4
         PvgAvMfMkig7YBgQLpiWaGGct2DALtkOIh5T/mLTAyCppG8nK9T2fyr8R1BoLwxnsWkl
         kZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053080; x=1765657880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yMvnDAxKkTI5tFqj3Rqm0zJ+TOrTo1XqQHI7t1yFXE=;
        b=NlZOC1Fz8xyOpKWBLJEDmu7WZc0ft0+OWvLJcZ2XthwiwPKBBghFBav+SBGjNnyTic
         Huwf7a5ZpAsmLTQEiy9SCLHOc/dxn0DoVAfZOQcCIX5iQfw1dKbKHw6cpvKXVjjIIMcN
         JspUYOh685RwBIkrL97tlBgqErZ33UrOROJZ7F/eBj7k+pBkn6w0/y2EwG2Wxt8AaFpD
         jTpEPZR+s20OPPPApirj5oORd1Kc9tG4O12BAA83r9/dtuGxOcgPIWZsGcndTdNvoiLv
         2CqZkECpC7q7pGNjBxOSa+IOa/XAVIPN6RsBIZMAQZhCD/tfk1E8VR8oZuDDybzFETM/
         8dWQ==
X-Gm-Message-State: AOJu0YwkA6R17FZSD5AJpnKSt2UF0pyuikgDX0SNiSjHgiKt0LM5F9X6
	OtRbTNnoEKbJphUICUFqDkjHkg/Hf+XtuO1tsVq/37iDAE4+BRjkgcClFyVt3QWEiU5qQ+tZwP4
	bVd6eEfM=
X-Gm-Gg: ASbGncs1hUTalAdxrOk3C5hHmZvEwmm5erwMrIklW99l4/5dkZgJwdVpDgxvq8UbhJf
	0vcvbWurkMAeHl4r7nAk7mgwriclte9JfrBhsRIMUQnt4M3UZrfp4g4wDMOB2RXXFsSrRip7TvY
	YlPl2uPSc2Pr7iRvRvFvIcO70tw9LJHG6iqena2dm7OWy/eLM94tV8rLaFNuI+MUi2DXK7Wdx9k
	qsYyImZQbfuCXVrw03HGeSIUuz7JitAbzsEGoFyNbphCcaeThHlkagJ+qDHhSSpiPTWorAogpuG
	6twk0HHqTBh5BruANehR+lgPS6AQfeHGAPogmyEQqPpSHzLcsgH4yWuvYe3YISz6Krf0TIcZwiB
	76hoLnbVAhY+4DYPNs+Flg6P3x0swFvMPUoD8UjtGdzeJfTfoeP0EWcqtWAfIttNa/UjiEkcveL
	fHO1zkFz1Yu8dRDEMS41qdX5esM/ckIzjgkOxyRJj7N/eQgrQY3gA+E4fJfieqrrikkv2MTvB55
	qLexXe9zUaqScmo2g==
X-Google-Smtp-Source: AGHT+IH6loH2aievTghx055zDZedLt9vSf/b4h5aT8DfsJGdmk6lcfYcs4veyYwDepdCeTIFDDengg==
X-Received: by 2002:a05:690c:d91:b0:789:6c45:5df with SMTP id 00721157ae682-78c33b586abmr30201047b3.23.1765053080577;
        Sat, 06 Dec 2025 12:31:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c375addd0sm8511467b3.53.2025.12.06.12.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:20 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/17] midx-write.c: don't use `pack_perm` when assigning
 `bitmap_pos`
Message-ID: <1fc359d9a98cdd61f6986fa1d9a1190f57dacb9b.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

In midx_pack_order(), we compute for each bitampped pack the first bit
to correspond to an object in that pack, along with how many bits were
assigned to object(s) in that pack.

Initially, each bitmap_nr value is set to zero, and each bitmap_pos
value is set to the sentinel BITMAP_POS_UNKNOWN. This is done to ensure
that there are no packs who have an unknown bit position but a somehow
non-zero number of objects (cf. `write_midx_bitmapped_packs()` in
midx-write.c).

Once the pack order is fully determined, midx_pack_order() sets the
bitmap_pos field for any bitmapped packs to zero if they are still
listed as BITMAP_POS_UNKNOWN.

However, we enumerate the bitmapped packs in order of `ctx->pack_perm`.
This is fine for existing cases, since the only time the
`ctx->pack_perm` array holds a value outside of the addressable range of
`ctx->info` is when there are expired packs, which only occurs via 'git
multi-pack-index expire', which does not support writing MIDX bitmaps.
As a result, the range of ctx->pack_perm covers all values in [0,
`ctx->nr`), so enumerating in this order isn't an issue.

A future change necessary for compaction will complicate this further by
introducing a wrapper around the `ctx->pack_perm` array, which turns the
given `pack_int_id` into one that is relative to the lower end of the
compaction range. As a result, indexing into `ctx->pack_perm` through
this helper, say, with "0" will produce a crash when the lower end of
the compaction range has >0 pack(s) in its base layer, since the
subtraction will wrap around the 32-bit unsigned range, resulting in an
uninitialized read.

But the process is completely unnecessary in the first place: we are
enumerating all values of `ctx->info`, and there is no reason to process
them in a different order than they appear in memory. Index `ctx->info`
directly to reflect that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 73d24fabbc6..c30f6a70d37 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -637,7 +637,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		pack_order[i] = data[i].nr;
 	}
 	for (i = 0; i < ctx->nr; i++) {
-		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
+		struct pack_info *pack = &ctx->info[i];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
 			pack->bitmap_pos = 0;
 	}
-- 
2.52.0.171.gd6a4e6b6955

