Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E54B1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 09:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfIXJI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 05:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46095 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbfIXJI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 05:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so927972pgm.13
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zUm4xRbkoJaY+KYBAJAlTtUgvNtEx8yTgNJ+3SZOnyE=;
        b=nQx7Iowrf2XuEqRNzSvOTEok+ZwGdWUBl4x5Pg055W9mZ118MnRSQAVzzZcJHoTBk6
         fswxG8opePC5YzpH0TtTjTrWGK7z5C+OKsFp+FpZSAcGkvBqn4skstLwxOFK0RuvbfWa
         3vRuCjQCuJLJsGTrN+f/Cfgxn4Vo2C/xVAphffPpqhLBLywI7SKXcaJp8YOmCkT/v1pS
         XmVhkBk8Tjnz4aBHP2fyF0a91GSX09zTEnypXfYR4ABTC6eEIo8ls5bHwd41tI+FHZKL
         dtysl2zy1jrQEJB8gP7A+azH+Ym1GOief5AkypH4RKRFIklBxNbA6HtDC8KMxD0NYjix
         1Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zUm4xRbkoJaY+KYBAJAlTtUgvNtEx8yTgNJ+3SZOnyE=;
        b=kGM07t21krfllxqQPT5v6OWIOk+0W9WB0+gcCuWvvJ5tN0MMo8y4pej7nI3v1jOPeM
         cWxIp8FCxvGKffW1q80zxM81ADGnkqjYO+//nhVNDv/UWj7YpENN5XLn7Wwv8oBry1+O
         MK5oaVPtsIbq0l7Eo/qqq3k85225Vd8pSiQwlPHr1/6BtVSL3hARUJjMf4bu3AXcUfy6
         1MVydNTFMJK/jiktDYGSDRGat5qp+tu4EdV8nVzDLOK9VNwb7v+1CeVhuUomgqL0lAsF
         Xk3O26zrgx6SSGk8uYHeIgJ+4cSPdVNmXJ89VA96a+ZxDe26nzdqwwFE5Dg1DfpOuQ2n
         kGOg==
X-Gm-Message-State: APjAAAU8krdd7IbUAtyCPoQoYfOVfAuN/lvjtPdHKlzEX81uZU8/sJAt
        j9Oq/lAGSiWR22Ar9mGs3usrlM+y
X-Google-Smtp-Source: APXvYqzUeyt4+e2rTDEfEYNbt2na4VcAumT+SL5Fi0paY4tRTrMhBocN4ZrcLSXoH5DaE5ej2bG01A==
X-Received: by 2002:a17:90a:3450:: with SMTP id o74mr1872494pjb.5.1569316136994;
        Tue, 24 Sep 2019 02:08:56 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id v68sm1394388pfv.47.2019.09.24.02.08.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 02:08:56 -0700 (PDT)
Date:   Tue, 24 Sep 2019 02:08:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/3] pack-bitmap.h: fix unused variable warning
Message-ID: <a3a3357925cb144deb35b298cbe2796934fa0673.1569315905.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran `make hdr-check`, we got the following warning on Arch Linux:

	pack-bitmap.h:20:19: error: ‘BITMAP_IDX_SIGNATURE’ defined but not used [-Werror=unused-const-variable=]
	   20 | static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
	      |                   ^~~~~~~~~~~~~~~~~~~~
	cc1: all warnings being treated as errors

"Use" the BITMAP_IDX_SIGNATURE variable by making the size of
bitmap_disk_header.magic equal to the size of BITMAP_IDX_SIGNATURE. An
alternative was to simply add MAYBE_UNUSED. However, this design was
chosen because we eliminate the magic number (4) in the process.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I'm tacking this patch on since this warning didn't show up until I
compiled it on gcc 9.1.0.

 pack-bitmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.h b/pack-bitmap.h
index 00de3ec8e4..466c5afa09 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -9,16 +9,16 @@ struct commit;
 struct repository;
 struct rev_info;
 
+static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
+
 struct bitmap_disk_header {
-	char magic[4];
+	char magic[ARRAY_SIZE(BITMAP_IDX_SIGNATURE)];
 	uint16_t version;
 	uint16_t options;
 	uint32_t entry_count;
 	unsigned char checksum[GIT_MAX_RAWSZ];
 };
 
-static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
-
 #define NEEDS_BITMAP (1u<<22)
 
 enum pack_bitmap_opts {
-- 
2.23.0.248.g3a9dd8fb08

