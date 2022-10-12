Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DAAC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJLWFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJLWE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DEC13956B
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p186so14585142iof.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUXQftnY6+nqpLxksDLiwUZR+iNRuUwx4tvVipJLAr0=;
        b=F74qKWlqpTdmCtdyYzS/QuQRpHLA/UECKMIJMDdcXhbWkIktn6k/JLzENtAEHbkNO9
         AQ21oPzUrC04WU7vPnGKibKJcKQMBPXkD0bbPNVctgnuDEdrLkT0p/3QHONY7BOHyLTe
         g8etjq3F7u3gAAPuZn1cxM20IN3IiZHKsz8ahIW2Vd7hOhkVOJL904sreGlU55t20wkP
         guKDDVZiAxels9aDB/SHlaHSXPllBeWVZPpDsn8CbrKZnnMovP+N4tWEKpZQx/AfOvmV
         0HNDDSFF6hh74wxiFv0izBvxOw788lDEqpQP9sM/Zkxq8iSwS4YCkUhxJ5O2L0o0BeZw
         7vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUXQftnY6+nqpLxksDLiwUZR+iNRuUwx4tvVipJLAr0=;
        b=1nsN2aJIQ126tKvwX6GT6/zbDpMsGNl4dwuc9b8QlVNHDIV5g52Oc9s+UyBUua9caZ
         1eMFU2cnbWT+06roVf/O5dDrofiDWJySVpEu6Mjd6Syg9Wgr4YQSm8H5k5HApVmpEmvy
         kb1Gr8DRcIm9ODB4Pz0fe5tvCVTwBnZphoIs0WQI1F7RmHOi9XdFwYwQnZbhh74Ehk62
         +OwiMt+dVfidlBMdBmEXDQEhZA8kJM1OMa0YCRPU40zvt5mXrloUNHroqWe0v+ZdUxFE
         3DkMPLOcxbfza0Bw1OQ/U6PHUSeLG6GTlPsi2XlJTBiakL80BJCW7ye5BC5UMuaEQIlt
         9EMg==
X-Gm-Message-State: ACrzQf19fxW/6PUUgkISz2J0PgEd5DVfQBbD6Rftmn8cLXY6j1doEtKW
        hs0DBiHKnX50XJAsn50X4yZuAfuNxzpP/oUx
X-Google-Smtp-Source: AMsMyM61WRj+O+5TVdj3iGZFKkZCViShXYNt4LeyoQ+xTqaQBnPpT6M3Dkj9ZzuaV/KlhUpn9fV9pg==
X-Received: by 2002:a05:6638:25cb:b0:363:edfe:3e3f with SMTP id u11-20020a05663825cb00b00363edfe3e3fmr1020018jat.270.1665612110455;
        Wed, 12 Oct 2022 15:01:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf46000000b002faf7965948sm3779596ilr.55.2022.10.12.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:49 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:01:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH 1/4] midx.c: fix whitespace typo
Message-ID: <6e92b7707dbe6ec993cf4a36180f5c118e6011d7.1665612094.git.me@ttaylorr.com>
References: <cover.1665612094.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665612094.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was unintentionally introduced via 893b563505 (midx: inline
nth_midxed_pack_entry(), 2021-09-11) where "struct repository *r"
became "struct repository * r".

The latter does not adhere to our usual style conventions, so fix that
up to look more like our usual declarations.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 3a8dcfe98e..a9df753220 100644
--- a/midx.c
+++ b/midx.c
@@ -278,7 +278,7 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
-int fill_midx_entry(struct repository * r,
+int fill_midx_entry(struct repository *r,
 		    const struct object_id *oid,
 		    struct pack_entry *e,
 		    struct multi_pack_index *m)
-- 
2.38.0.16.g393fd4c6db

