Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B10A1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442651AbfIYIVC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:21:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46673 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:21:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so2916509pfg.13
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dtq4xAmfsfRMOQJaGqblLA4XTcbRUfguxhPPP41y5Is=;
        b=X0bIL4WeyGKrlKNJ+0ZdkiWzeejMsBBiqTTzcIAWdFhfeFA6WEM5O0F1XE4xs0fvT6
         As6gIOsjaMvVnvWHSzI4N8bqn4pKu/yaZtmhNHJUzEhDG88Yhx1SLuRMnDEpYOPwcVeb
         hG7iWPv6XYzTm6Wug+TpJ3HlBlgk+XBpXe4/aFdD/RgJQVXOc8LlraDraFK2PiMOyIMz
         zhzf7P4zCVFulCjpSquk6PBGBmozZ46XXrz/irf2CANEblYUciIL9M6vBaJYjNCV1xV9
         w5IqC9WRYV2xDJGKfosUWZv8Ka4LhrYIq9rjnEG1ZS8+XNdJ8EIqg8NeHnCQ8WZQAglJ
         QU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dtq4xAmfsfRMOQJaGqblLA4XTcbRUfguxhPPP41y5Is=;
        b=LmLNtf6BzE/+gUdySzf2M4+A2yMqeyIho4rCixyK8Imxa1vakVk4MnOlbQDeXSzbiB
         3mmb6Yujv1Jfj0en4DiPJd5wcP8xCO8kQCYeXrR70i8Fl/OUu8eDZdu5DSbwNnNSzEUy
         nJHacuTXy2S3FJehCyRWpm9V9PINYd3jcdCVcCyIXg1WfrB6KiSgw7cjzK5dYxLaJQ/g
         ZD+7l0Nv2UvShHGXMJXV1AXSAc2haopI8kBbKVRtTRecnD43OfyesG53J9VYFqu8RCZq
         gKBPNNOiKxKb8QSIAvndlw18+ooCyQrK2kX5VOwqDpEJPcPvKo17EsnWUwJgqeHD+ncL
         gdGA==
X-Gm-Message-State: APjAAAX6gbXNgkFsBLkD/rXhUogTcCa/Yai8yIJN+3OCRCybpVAKG+Ny
        92Khk6b5xJ6eFhHujmXAmLnz7SRc
X-Google-Smtp-Source: APXvYqyZd2cAqnsoohmqBgO/XPZFn1Zrw55O9F1yHYQoW95GZM+sxTpMFDwOtPiiHX22uw6k5S6ygw==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr7586706pgb.90.1569399661284;
        Wed, 25 Sep 2019 01:21:01 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id f89sm2478923pje.20.2019.09.25.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:21:00 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:20:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 3/4] pack-bitmap.h: remove magic number
Message-ID: <50e37c16f9715bb6bc41940545c779f6aa9f6be4.1569398897.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <cover.1569398897.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1569398897.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran `make hdr-check` with the following patch

	diff --git a/Makefile b/Makefile
	index f879697ea3..d8df4e316b 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -2773,7 +2773,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
	HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))

	$(HCO): %.hco: %.h FORCE
	-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
	+	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $(ALL_CFLAGS) $<

	.PHONY: hdr-check $(HCO)
	hdr-check: $(HCO)

and with `DEVELOPER=1`, we got the following warning on Arch Linux:

	pack-bitmap.h:20:19: error: ‘BITMAP_IDX_SIGNATURE’ defined but not used [-Werror=unused-const-variable=]
	   20 | static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
	      |                   ^~~~~~~~~~~~~~~~~~~~
	cc1: all warnings being treated as errors

"Use" the BITMAP_IDX_SIGNATURE variable by making the size of
bitmap_disk_header.magic equal to the size of BITMAP_IDX_SIGNATURE,
thereby eliminating the magic number (4).

An alternative was to simply add MAYBE_UNUSED, however that does not
eliminate the magic number.

Another alternative was to change the definition to

	extern const char BITMAP_IDX_SIGNATURE[4];

However, this design was also not chosen as the static definition allows
us to keep the declaration together for readability along with removing
the magic number.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
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

