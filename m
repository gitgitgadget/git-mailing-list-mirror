Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D8184125
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250725; cv=none; b=LYfd0wlnxdZyET3jZa5M90XMiAUrzzDtqdGM9W+f5aMyBaj8v83F42GVGYhYUv0jZ7+dQsOrdMZnNFFyPL0lkMZhrvso/1kf7WsHn1vcaJFKq0+T4o2GwrPBlT9/cmuEr9ypuMXGiLuHUwYU03O6T8Ab8JVbnrl1h2t5GG9cDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250725; c=relaxed/simple;
	bh=5cEkhm2dm+UbDPXVQwt4lG/X692PMb5K7ykp3DyXCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIW8GhCeRhZLf86vsulZcgN6al0ZPgEemOpp9nwYA0AC6SzWtYPhEN0e2DwxsPMhpQ0reXcjCx7WmgBOte3ZIDnRTWgQ2T+wu/dkw0LGib+HoGRz9uyOOSZdW5k6YMRiWowgeaEgRTZLREggs9RpH1Cs1pwgLGLpa5n++r94tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=stDgemv5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="stDgemv5"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6519528f44fso752757b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250723; x=1721855523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDEorA7r2fVoo3SiQTc1kG4snLi7jhy/6bhDioCYiVw=;
        b=stDgemv5Zo9+91Adz34+OlOalGFcZSyCxMqphzO2ULme3HohkeZkgXUQZUorjLU3C+
         Y5ibib7EqGIvczzvFcwzsyx9PApaGMbG96qNHcBCaFG1OPx0/WDEBOMh5x745wBbS9Sp
         69WyQiFGQvYzc00FfnCeuHOFnrKOAIqN/aYRSSxVuG0Rv+k9/0Kmo7iGOu7BCYS6j2e/
         1y/oYXs/fUAYi+1SiKltICXnlksVTkhKp+8N8x0JHjV+b/6uTIOd1XFJnEYfc3w/sCtB
         m58z9rWAZtbU8UibqCCpJFbdblbYSQTkxJUL+sv8Z3vmRCgqAx0ZlZ7S6G4ZqkH0SMSD
         6VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250723; x=1721855523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDEorA7r2fVoo3SiQTc1kG4snLi7jhy/6bhDioCYiVw=;
        b=Nfuo7sq20oa2xb3z76rsfQowvKUUhI3182MH3bmuh0fLPD80uxXfhCgTl4jxxjhVPP
         N8Qnoxk3T/OirSVQt3zZ1L9dtlc3LgHTfhWN42rPTk+A68iHhIkLaUUnQt4F2y4o+XZQ
         CLkazYT2nJExOW3MtXUB4Oc0tn5kR3m2D1hzVVeFd2AvDfSaFzPgOuAOup//sYC4NtP/
         MGHzDc9jUJ2ui78QWGKwARUC2rprMOYe/wO9VMXtTgr1KP6b8njBskArz67ki60t/XXR
         p6wdxOqwEu8fpmqD0hJuFnDH8CPy/NlTAR3BYxR4m5bbr95mXHeRDiIR3+Lp2GVzwlTV
         YkXw==
X-Gm-Message-State: AOJu0YyMrPVCXzslW30ks9D3PB36oNemVXCMtNhGKRxfoxTXkcw21hTp
	r7ub9Beb49X2MU8ggo7WfcpDrZAEO4xYKO/TEuodAaPInYo4mvEXXNEBX8qMU1vWlecfj1Mkm1D
	u
X-Google-Smtp-Source: AGHT+IG9ii2gYa2l1Ru0CDr0U3Z+VjNqFIQMP9sV541+3eNYtaCXRxiz3OpYD+AMNof4e5xWs3BX6w==
X-Received: by 2002:a81:dc0d:0:b0:627:956b:dbca with SMTP id 00721157ae682-66603ddb952mr7300427b3.40.1721250722781;
        Wed, 17 Jul 2024 14:12:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66602490bd5sm780797b3.59.2024.07.17.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/19] midx: add new fields for incremental MIDX chains
Message-ID: <337ebc6de7bdf6ff3b4b09c2bea3df2802174e8b.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

The incremental MIDX chain feature is designed around the idea of
indexing into a concatenated lexicographic ordering of object IDs
present in the MIDX.

When given an object position, the MIDX machinery needs to be able to
locate both (a) which MIDX layer contains the given object, and (b) at
what position *within that MIDX layer* that object appears.

To do this, three new fields are added to the `struct multi_pack_index`:

  - struct multi_pack_index *base_midx;
  - uint32_t num_objects_in_base;
  - uint32_t num_packs_in_base;

These three fields store the pieces of information suggested by their
respective field names. In turn, the `num_objects_in_base` and
`num_packs_in_base` fields are used to crawl backwards along the
`base_midx` pointer to locate the appropriate position for a given
object within the MIDX that contains it.

The following commits will update various parts of the MIDX machinery
(as well as their callers from outside of midx.c and midx-write.c) to be
aware and make use of these fields when performing object lookups.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/midx.h b/midx.h
index 8554f2d616..020e49f77c 100644
--- a/midx.h
+++ b/midx.h
@@ -63,6 +63,10 @@ struct multi_pack_index {
 	const unsigned char *chunk_revindex;
 	size_t chunk_revindex_len;
 
+	struct multi_pack_index *base_midx;
+	uint32_t num_objects_in_base;
+	uint32_t num_packs_in_base;
+
 	const char **pack_names;
 	struct packed_git **packs;
 	char object_dir[FLEX_ARRAY];
-- 
2.46.0.rc0.94.g9b2aff57b3

