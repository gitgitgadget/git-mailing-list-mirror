Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423F1803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958673; cv=none; b=BpTcsY/pVmRCFoGXso77wlMf6LUHyoJkav/s8tbevLGaUZVJDX4rOVivCC+J0PFLXpUXdGUsWvaXcLy1xDNKv4M5lLr6h9NE42A5472p/rvMXPB1XP2WE7F8Lz1eAjCJBd4TA/drPT8SJfBO8k5TSTEhod2HW3q/kV9oBFtHvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958673; c=relaxed/simple;
	bh=zPQEPQk+mLHSWGCZRtTkh4YWAHIq4jHeXaUMGYZVlBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evaq6w3IIwafDMF2vrlI7LhwwUASjc2W1V8sea4xrp60qfZFV2rc+2xF+wU+t+F2VO47oXNh5mWpIzmii20b3gLOJNydtvfdfe32qRlg603DpvaVqG2JWUl38BhUJSMgP6oBdgMfanb6m6qiIJ8w6mIvHwO4ohSVwcktYnWZL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qyPQ/hkC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qyPQ/hkC"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0878971aa9so793202276.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958671; x=1723563471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOuBwftfA7fRjO8FH2eSlza624bLi0kcVZIjvBjv+eA=;
        b=qyPQ/hkCkmC9C+WCK6iWNr/U+vNuhgWH2Y2etUn+bvZjoR9DGFK3HWvXm9BestBird
         HQUGOlgqeF7/C8LPavJX0oyquvEKI4yuba9ZW7NSBWWFCgGcPXqaS/xuRV6/QisoNrPz
         LdRAwRcXec5vas8WZL9zcu6KmoGnGxlZjm/yzdXeOruqylk/FxJHe6xV4TlGOpJp4G2U
         aoIo11CcgecXQRGjFz76YFJtvHpOqdbEZcSXOpenXZGciBslqa41nYiQFlpqo/KRe8Qr
         zjrDc6XHD1M7jhl9rsnOwLBtIMueQlBvdy6vm//6fGZN2lmI6H/NHZfHlPvCSfgCje6H
         sa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958671; x=1723563471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOuBwftfA7fRjO8FH2eSlza624bLi0kcVZIjvBjv+eA=;
        b=RgX3Iopjc+PCC/tItHg3BQnko7QUZNGG7zhc4m+9wWZeWNfUuPP6Vwjn0YKHc0NHLq
         /1dgLdr59bXFtoCTDYWVH2qyTxkmYMrfdRP299NfIIatWpddAz1xMWDrhzwFXntVrpzJ
         01Yf0FDPvFwGn2LeUFPHLSXU9G6K85BNSzF/A6Uh6ZVbiBipkzAGft2CHRpmND6tG8Wa
         RW+Il5yWMpitCTSEYRgyqN3S5QkfNykEg+F5KF9DDbo46nwnQ/UPH5FYbXDB5zJQQNEm
         XHMhP+zpsrg0EuaxpsGB3NPto1RABh1vGAwEZHzQbeQ8uEAgSQ47Qicf6g55EtBZcuWk
         BphA==
X-Gm-Message-State: AOJu0YyfSUjWiJKl9akPHERZ/viML4tQ7aSbupItVd/7HD2Snj13tnca
	zMu0HPwo8rNdXX1pEyJZx3AUD1nRvFr7zWoVemAkXpNMmROoGOHDF9xUI0lXfTTS3qax3SbK2k9
	m
X-Google-Smtp-Source: AGHT+IFgW9HUiNU5DlcU0Tvjm33xO+S7+7jG7w8AWmgLBNwP8vg8trxft9xPFO9bYFcNujkxivQowg==
X-Received: by 2002:a05:6902:1b04:b0:e0d:19b9:51c9 with SMTP id 3f1490d57ef6-e0d19b962dbmr8024582276.27.1722958670689;
        Tue, 06 Aug 2024 08:37:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be556426fsm1751207276.47.2024.08.06.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:50 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/19] midx: teach `midx_preferred_pack()` about
 incremental MIDXs
Message-ID: <2f98ebb141e7d9231d9f7688b3ebab849e8fa689.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

The function `midx_preferred_pack()` is used to determine the identity
of the preferred pack, which is the identity of a unique pack within
the MIDX which is used as a tie-breaker when selecting from which pack
to represent an object that appears in multiple packs within the MIDX.

Historically we have said that the MIDX's preferred pack has the unique
property that all objects from that pack are represented in the MIDX.
But that isn't quite true: a more precise statement would be that all
objects from that pack *which appear in the MIDX* are selected from that
pack.

This helps us extend the concept of preferred packs across a MIDX chain,
where some object(s) in the preferred pack may appear in other packs
in an earlier MIDX layer, in which case those object(s) will not appear
in a subsequent MIDX layer from either the preferred pack or any other
pack.

Extend the concept of preferred packs by using the pack which represents
the object at the first position in MIDX pseudo-pack order belonging to
the current MIDX layer (i.e., at position 'm->num_objects_in_base').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 454c27b673..918349576f 100644
--- a/midx.c
+++ b/midx.c
@@ -501,13 +501,16 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
+		uint32_t midx_pos;
 		if (load_midx_revindex(m) < 0) {
 			m->preferred_pack_idx = -2;
 			return -1;
 		}
 
-		m->preferred_pack_idx =
-			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+		midx_pos = pack_pos_to_midx(m, m->num_objects_in_base);
+
+		m->preferred_pack_idx = nth_midxed_pack_int_id(m, midx_pos);
+
 	} else if (m->preferred_pack_idx == -2)
 		return -1; /* no revindex */
 
-- 
2.46.0.46.g406f326d27.dirty

