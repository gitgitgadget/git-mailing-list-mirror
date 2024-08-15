Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841814F9EB
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755701; cv=none; b=CtqLW5vMn3WlxInAQvieIrvxIlXkGk22iB6Uw+jYSvhjU24jNpocDwhfl6YPB7iTsyhoIUWOuXOa23RoRfnquaYZoTGIvTRH60dxHe7XjTqCGoLhdzLE0SetorYM6PSTtX6v2voc9XLfq/gCE6DV/iz2fs54fMr2hojyzoZqFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755701; c=relaxed/simple;
	bh=6m0KXRcKiFTeCqXkVLH4B7gp29jjiELQPt7qeCoTVfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6ja8Cwm1P09Jx/Dx+/Ha7phk3xEIbbQFBLi+Uhrg4kt3QrfBpXpIjux4cLtinClTbvzfDZQoYjlceMrB0FbqEVQwoJmPELkU2VMt1tTnkti/5DMZ+j5Jgbm64C+t+YDH7fOcsGWM/BdTiuy4BlsejZnqkDFg+8bVsR+2YqH/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vtdYTR/t; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vtdYTR/t"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso1474118276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755698; x=1724360498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Oql4sXviHrCmOI1UoNB7tUbznuL5clvipDPDVw6Fs=;
        b=vtdYTR/tY8dKBRE+6JnSqtcCcLmzayMpwrQ8h6Eox2/DIXfEW1zx34UCTD0p/6jHwe
         xBTtliFADygn2BVAeclpL1h+ZaDJ3grDgxefQFKLbv1pTIvdm+8GwNF9S0RLKvEQstOe
         AHkCSaPXfqvrdTMhwUTmvl7bYC19q+vM9DQ4b/pDRdJSQEfswsp+QODnwCKX0Gb+ZLmX
         T2OcrpUZctUGeUOyeGTwyFzLLijJwmmA3VhZWyheh7JeRCKvdjkSwXpmGhhP0fc8Xz9t
         TPBEzlB91T1GiNTsP2U68Fh2a/WNfG0g5+DSr/QeyVsnPZElka84zLS3EiiM3hjpUU4v
         HhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755698; x=1724360498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Oql4sXviHrCmOI1UoNB7tUbznuL5clvipDPDVw6Fs=;
        b=jn7ouDh83+zwxjOkr3SVrvkpeyLLPwkrGOQHIHhgO4/QtWEEqQwSTBjXPRWeE6kAhl
         VAbvxbSHdsKmK2daoXBk9BKiNEqKFmoRCYcvZzLeYYvX13IUiSNbjTdwvIXlsAN8UFCi
         D2dongRXXuCfhWiGtiowD5KLcTKj0gUTJ45AxM8HXc28iBGjkaDDZDxULtj9Mq6nbKEK
         /Rb6XYWZbWMuiZHQ3a7Smumi1eafskQ3yz16XL9vwVzzfwEcy2Lg9m+JaPcXne6h2KGe
         fBgAgwpuW+TvPGWxGm7zJ3NaNGKQY7gGmbSR74McXtx9+u1Zwif2dov+B2lcWWe+mZTX
         k+TQ==
X-Gm-Message-State: AOJu0YwvPDsPo0u4eMo+8O400VrsArynwoxzxXApKP2y25To6U0z1TlI
	QXmoHD6wpuByNCahS1Sl8wbaHDi1WnZLeBL14zE3wu8ihAzwsdTq4LuEPVM3RV/ZnaakY3txMP1
	u
X-Google-Smtp-Source: AGHT+IGyc7prTUXLp15StunBpDxQwy5Axbhci9Cc+SLNayWn6dd/DMg9xVOvtmxbRUfN5okYm/buMQ==
X-Received: by 2002:a05:6902:118d:b0:e0b:a4b6:670f with SMTP id 3f1490d57ef6-e118100496fmr1287552276.51.1723755698413;
        Thu, 15 Aug 2024 14:01:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e6a848sm453771276.31.2024.08.15.14.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:38 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <01b8bd22cd9a6486cb79500558bd1eb2da832856.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f91ab1b572..2b3c53d882 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2320,7 +2320,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		multi_pack_reuse = 0;
 
 	if (multi_pack_reuse) {
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		struct multi_pack_index *m = bitmap_git->midx;
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
@@ -2344,14 +2345,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
-			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			while (m->base_midx)
+				m = m->base_midx;
+
+			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
 			}
 
-			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
-- 
2.46.0.86.ge766d390f0.dirty

