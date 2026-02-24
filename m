Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C12E091E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959610; cv=none; b=YG5Ku/YL8ef8Cjy08G6/50GeXMI43NhSyMw20zdJ/gSS8hnHpM5/kP4LSO4jFZ6+k5Moek/UXM2Q2BCg+sWWsKWT4rj+K7IMBuJE+PLL2jdzybwidVCQabHKtgIvK2JRuoe+gDkmMVQHTZ0dvAlghnzF7HzAbWyhNi/nSEOD+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959610; c=relaxed/simple;
	bh=kgBxEkkNQM/aLrRrdc5xUisVM/RtKHF5VcnlOqbg1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEQqelyWm1jptgxjhutAZ5d9C0c+cUSQzUU6hrebIemzJ8jsdeqpeesmgbZCRxL5VphLqjt50u5hvlp6/Y/mOM5gvmz8KHTOEREnIeHB30fFWLxptebMe6PzO/tj/2Le6pRK/OyLnycUD/pwHE0uv1p+RXRvJ8gknUlDH1HGQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Aj5oV+i3; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Aj5oV+i3"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-897023602b1so67635216d6.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959608; x=1772564408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nV1F4i6ffxirhquxL4AGOfFk2UKNKtWaAF1eEh/ovKc=;
        b=Aj5oV+i3kHVs9QEbpGQ63VOQjzP2jZY3iA96fBqUvhwv7H1hvpMNEBhwg6fmSUyyP+
         lV3TKzj/UeuyF0hejej8rgq+Jyu7jLP+0283Pz+/OzP6AifCG/pfViH/cFn64SyFpQDA
         QZl0DXzoTUO8W7HQfAt7BtGbp/v/TmSLnd/vn+u8CUeNsqZw/Jza6hV2t1Y6/ELx7UW8
         bze96oszKaPv2J136IDkKndtnPCSND/ZEg7YVhZsNhagLlAK9T4mXR1iFspcQtODg3KD
         U8IHZZCqJZQwUOC2dMinChVdA7kq911zjQkJGMe+l3g2d2rr4ryjGCctoJuiP2yuz67p
         hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959608; x=1772564408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV1F4i6ffxirhquxL4AGOfFk2UKNKtWaAF1eEh/ovKc=;
        b=mN0D6U/tcraowEEASVhXp+Mi4Wtl5KSNy9ffIVUSgyKhZYBc4uRUX2Hepxf1nYpqN9
         HOpZ4jGerLNfGluTELHOStgA02JK+aYjGTfY4XzSei4BtprGhrc40ttex1p12O/6A0XJ
         6VEP3H9mII5EjQn15Qug3qYiNseU2kAEdSzZa9jeQ3nOQrenDVXG8Dv4S2xrnNwRlR7Z
         jdejer6Nh233KsMktYOVAI1tbHWT4qpzssVNIW59Nv+tHajI19dk7+/nXh7ljdHwyVS6
         6n0fv0FIkZv6JNQ2O8AzoFj9dADKOy4/4IDhz9op7PJtcU4KR1+JiIkpjnrDeSfxBBgu
         0fJg==
X-Gm-Message-State: AOJu0YzX58fFQcJ4/NHOZTeHEBEeIzZQZDphJRg9B8fWcSLwwqJIgcsf
	OZye1jWR0MNAtKz4ae8uVqkMa1Q/p3gUIqRIGHI5e9diaPpoyDVV65GhkhSCaqcJNJvnDbpDzQ7
	OsJcRVKWvC8I2
X-Gm-Gg: ATEYQzxj5MARBn64W37TrCp8rW73kNNr3hKFQIMVNur2C5AAFLZqREEdwbDyp4qDaDK
	wMz7ES0+j/J8Fhs7gOLyDVhl6DStvg8p4YfZZ07kgHaTPaqF3GLziPS9SzcVSswpBGSbPCDSa1T
	48EW0XQGIpUpcVttml1OvPtobH4pK28vbReZ2L1n50nZhq1/aMp7+CppBr2dCKukw0itIzy4VCy
	PCTCdnJkY7KcpMGzZyttt0dwTwKms4h/VFq2gnK6tW+NYfRl5yjCOHFbaWr+gN8BiRL0ghyQMPs
	ARcVSuWXUzt6WhrQ4m4RvqAoBqjTz3QQgiZ9+iilyup0YIhN+O0FNtdWJ7atFEZSA2LgvogHMuR
	D8p/rMewHIM/6qu0bvfZ3kUFpiyMptdEjoHkYKOgkVWBWYQRdk3lRYphE3BQtXp4BYHQFoRJciM
	Z9dbOrYBp5O9RtXhd72NKTAL9Y7R6fieWpo4PTcb6zTQgQbJyBpBcRfHya6JbPO4UjHYocihg7U
	VujF0ozinNfb7NfwNdE1ExRQEY490GGSHNg9zfZ
X-Received: by 2002:a05:6214:1cca:b0:890:6603:f258 with SMTP id 6a1803df08f44-89979c42004mr183281966d6.12.1771959607419;
        Tue, 24 Feb 2026 11:00:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c690f9csm101076976d6.11.2026.02.24.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:07 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/17] midx-write.c: don't use `pack_perm` when assigning
 `bitmap_pos`
Message-ID: <84d9d1ef7ba5258fe57a476621598a75e7952a5c.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

In midx_pack_order(), we compute for each bitmapped pack the first bit
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
index 13171d7e9c4..da9c5a7c295 100644
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
2.53.0.171.gde83996e422

