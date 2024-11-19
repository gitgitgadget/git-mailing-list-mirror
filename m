Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0F1D47DC
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054056; cv=none; b=ji7fIr9x7eZIQT7fqen8UdG6KmR1jUmqp5oH0LBZshdGfxdXbLOZo0c9Nnfdh1Pk2PBSsgg5GeJog7f9QeKF/EfgLmItJ4oVj0n6mSZmcdBbpfdQGFZxyqxzqedKsuX07w6y9G8k1KqV1Ar/citm3q2vUY8/gCqG/ic1c/d4zQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054056; c=relaxed/simple;
	bh=1W7lAVYmqwyCX7xRvlJoz0Y9t763XBgmhRBNmHvqaYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnybw3jWi95QevJXK1hveJtD2Xkmf6g6BHTxGb6km1c0v4JsGfN2KTSWfl4hxiGiZ15yiVvX5E08ElcQ4l8Wg461zYirTx0YB8TayRqffUuATl7rV3FfI4TSw++tOWm7lOhNzVCwwb8LvYipSiCwkci9YmvmUcHtdsPGGqmybPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XpdezrMK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XpdezrMK"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso4185407276.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054053; x=1732658853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZmRmRyoHiab2M6+39qY3gDsE1lORmI0KrWIdrhjJfM=;
        b=XpdezrMK+53UeFjKFCDmwwhiliZzPSbvLPcLvvhM9KcTy+K+hJekVNfswBrhz6PEFY
         wClCctsX7dVzkCKkPatAkvZ1U/g91bMJwMkVJG8SSXTukG7Z63tgJkQHUMd57/sH6MD6
         cpuv23ZPwo0i8CGvz8X8CsG5S6QsIM1UwXvGfLAEQUnvPQaXgXSayzSVHxNXsisYbEDF
         Tu+yZW4aXKHf3EFzEgz+Cy+m68YUDIcO4Vhqyap81JF1k4G5acTk5upDPWV1ev05qSRg
         A3xM9vb5MDDJngyiLfAf+Mvht6sh3tZ71hiI3sr6UDd8E8qsLfbZq30955YPjFXSCFls
         cNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054053; x=1732658853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZmRmRyoHiab2M6+39qY3gDsE1lORmI0KrWIdrhjJfM=;
        b=FnUPiDatwGmIhEJlWaTCiJzd3d3vbYOpVD0RIzU2Hl8je5pfLgzTq5WG/4wcwl5U51
         mzEiOttpCfeb8rVykqSbbyeugApbgxxpdXOwvD/xYuHlTNWVXoJKUGq+twztXmH7wTsJ
         ejH7J154AUOZ+h2akT2LM3Ft+VbYmqCL+B/CsOsTXnz4GIb9QvthS52HnaZ4jeJZ+T3p
         N2LEeyr4Tnhyp9LHFRWk63xKUjp4PhmmKIpCSzwOGOIfUjnxokZ5eIwYjUcjcvJs2eH5
         /f3vxTIRd7c+3Qjum45vQUIoSSi2cHBLA2eMU+9gjHRHzKz4OHBt2pY47q4S+G9WVOND
         1Hag==
X-Gm-Message-State: AOJu0YzyaSqcoKp1aPfH7ep6mo12an8SwNO/eqqPQReE9oDjMNE15wpV
	0HS2t7zfFJby30GrylakSq8K5+zqTy1fnRWEd4qQ/RsYl/zTMjXSl9nh4cAPpjgIqoi6W8D37fU
	wciY=
X-Google-Smtp-Source: AGHT+IGiBZxkzINSRYlLuIpyX7lRRV5r7ZYD6plyXV5/SQsYWoQbWhL30isBgqDU44Ut6UPFqjQ9hg==
X-Received: by 2002:a05:6902:2387:b0:e38:b44d:a959 with SMTP id 3f1490d57ef6-e38cb5ec155mr342831276.42.1732054053552;
        Tue, 19 Nov 2024 14:07:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38b27a45edsm1069050276.48.2024.11.19.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:33 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/13] pack-bitmap.c: teach `show_objects_for_type()`
 about incremental MIDXs
Message-ID: <b7a45d7eff8e2c4e6c34b053c682b23a730f4877.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Since we may ask for a pack_id that is in an earlier MIDX layer relative
to the one corresponding to our bitmap, use nth_midxed_pack() instead of
accessing the ->packs array directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e3fdcf8a01a..c2c824347a6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1631,7 +1631,7 @@ static void show_objects_for_type(
 				nth_midxed_object_oid(&oid, m, index_pos);
 
 				pack_id = nth_midxed_pack_int_id(m, index_pos);
-				pack = bitmap_git->midx->packs[pack_id];
+				pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			} else {
 				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
 				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-- 
2.47.0.301.g77ddd1170f9

