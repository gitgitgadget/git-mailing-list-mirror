Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D118A954
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250737; cv=none; b=C4H78/UdcWvueNGHLO7OdB4BckxT08zYEPKVIiK//3qVV1lNjUca0nq7aWS1kDCuCzRCD5BpownRpHwD4HLyCPOWONz7Yt7dwixXLhxuJacmdioGC71jvU0vqK0oaGPbQxjYLwWIjMWeQi5pPrpUUK0i8rLF/+hmL0H3gFwWCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250737; c=relaxed/simple;
	bh=rp9H5Ps0slzbmwcdWfNKoeCQ2/c24MjW1R7UEIfykJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF1v/mQKVKm+XCyBAygF7DlVJu9Kd/PrkHjfG9/91CPIDXqmBGUMD1qMZLVVSkkYobnpScVlmIQx37s0cdMJBlryrVXxpfa07Q57s1ztOMN6yMDWtgPrD6WMHRtv0QQZOjTB1bnMT51Ttu/4O4W57cfDC8jNA7ggiL61LnRjpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XmOHzMNa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XmOHzMNa"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-655fa53c64cso657197b3.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250735; x=1721855535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y95yQ3vdOL+plYLZWUmvWiBLqym6EC/GeYFs7CrGkDI=;
        b=XmOHzMNa/F69VLThhyofNRgOyer7yGpjE2chvoYq4/AyDOfS1PqejINUo7T9fl7IDk
         pTRmasBci9gM7pzl7ypE54ZsjbW2qFOK6FbSXYqPOZiPgjuALXtA6rqnoDsdiRcEGLsy
         vbEUK4ht30+uJFGX7EB532EiWJrIquMmIN7o3vyK3XbefTDrOWCIlNVlas7zKN64AqO2
         e2gQi/4DKgvwIr0Fd1ug3MzAMlVlhli7RstWTErmwvAfvo8/DwY0iodP3M7xguh0JWmy
         abhAopPkaLjLtsFMSezbzu/YL2orWIwZ4v3Z3Ku2tah5vB+Xh7iufOoXHoMUSm0wn7Qn
         t29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250735; x=1721855535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y95yQ3vdOL+plYLZWUmvWiBLqym6EC/GeYFs7CrGkDI=;
        b=NLDMbQXu5qLB24r1F/3j4tF/3UiX2YyZ+CPLQUFFvfEVeUP9IS8XAFlquxtqVvYdMJ
         ayTjmZf2zybfe0U+rsirlL00exqYzY1P96NOZLCMT9WD4J/V4m5G7WkdAj1l4xVoyGnI
         bWbRItOG7vU776V7KZYKaGhOlFaIlKmh4A38W8vDQXaKm/IX3vF6pIiwn4la5+srCSSh
         9vGGR5BjvUaYb0mFwGTZ4t+M7fX3vWL4MLDOcfSCwHkAmHJw6x069VUYPCXNHc1TLagT
         nUDRpMXekuTRlbvcODRYTxxPZOujKauXFnCg/erACj5mXphdSxxl4cTKyid5nVdV76LS
         LA2g==
X-Gm-Message-State: AOJu0YxeysWIqq7HMEXeaxUqb3KH8J1c8r+zmFhBm6A5NY+X0WGOSApt
	LdcQrXxJ8+aGLERRQK6r+USJuQba2/J+G9s6HMGrYPMlmNrxLQdN4SuXG3KurirgSdl8Mnp795m
	i
X-Google-Smtp-Source: AGHT+IF439x0TSVzU+wCz6j7xENmkIq7hFzzRxzHSPVhVM2WNwH8rDYQ1MH4+yQUH/UoFJ4qpoA/iQ==
X-Received: by 2002:a05:690c:6603:b0:646:5f0b:e54 with SMTP id 00721157ae682-666016fa9f0mr10185167b3.8.1721250734871;
        Wed, 17 Jul 2024 14:12:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666038f68cfsm758937b3.90.2024.07.17.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:14 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/19] midx: teach `nth_bitmapped_pack()` about
 incremental MIDXs
Message-ID: <650b8c8c21b7e8a6e4f65d9b47185a875f0022bb.1721250704.git.me@ttaylorr.com>
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

In a similar fashion as in previous commits, teach the function
`nth_bitmapped_pack()` about incremental MIDXs by translating the given
`pack_int_id` from the concatenated lexical order to a MIDX-local
lexical position.

When accessing the containing MIDX's array of packs, use the local pack
ID. Likewise, when reading the 'BTMP' chunk, use the MIDX-local offset
when accessing the data within that chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index d470a88755..b6c3cd3e59 100644
--- a/midx.c
+++ b/midx.c
@@ -310,17 +310,19 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id)
 {
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+
 	if (!m->chunk_bitmapped_packs)
 		return error(_("MIDX does not contain the BTMP chunk"));
 
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
 
-	bp->p = m->packs[pack_int_id];
+	bp->p = m->packs[local_pack_int_id];
 	bp->bitmap_pos = get_be32((char *)m->chunk_bitmapped_packs +
-				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id);
+				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id);
 	bp->bitmap_nr = get_be32((char *)m->chunk_bitmapped_packs +
-				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id +
+				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
 				 sizeof(uint32_t));
 	bp->pack_int_id = pack_int_id;
 
-- 
2.46.0.rc0.94.g9b2aff57b3

