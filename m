Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEBBC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiGTSjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiGTSit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:38:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC97393A
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u5so4305268wrm.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dRxvaKKIUZWa1PC2tLR6WPHJBu061R3VyLFIM7v5ZQs=;
        b=TarGACvFKf4yON7MnpCPHD5Uz/U0zbuExtrSqS8W++oxPZM/wKmDlRWw9DSCC8ULGv
         wvrbRz+Sgg4YBVDzrLGpb+NzEiirNANr8RgNaertioAlGucUGaJhy5dqepsoKYA4XLJN
         Dh6fk0vwsFHIuIWoU86TUJj45Uhc3SWFYDZNf0Zoy6k7qQcG7CvJhLI7boKLvKWFKl4U
         6bwpbdOPMY9U2cG7kwChqa0K4qHV/8bzie43NtQquYrpWLr0GHEFDPmTIT5pkkprWjqD
         eWMzSmhtcEy+jxSYKgoSa8aCbV798NBEj9j8RCug4W1+5PjzDmu7L/IbO1XK0HtZswuL
         bGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dRxvaKKIUZWa1PC2tLR6WPHJBu061R3VyLFIM7v5ZQs=;
        b=2yr48EGhkhdDlSBl58hGKrc+EnaM5VE2X9M/bXGuOTIt/nVJWgQVoBYPJFoWyF5pLO
         TdIDJsePyJVCufJFSmUNtxByd33wXK7SghOXra2rDkr/t4fZDHDrZCFe/atNduZoWRZS
         X4tWFhqcmGLjgaggCLqF6COnFzqrYVC1ucMepKhdac2ZLf0OOgewIf9oPQEG2XNvTz8o
         2r8e5QZ6Lf+kVCpCnpB9Ng/XrRTOQeSc+oIaX8KDIxb2dDRT4DB4jyfUqsQ6jnObC0Pn
         Ogt8CxHSTFuTtHTFKerFWXiqtT8FL1QKR4ERBJb+CIdO0btcWncAxbphL5FFUOu8uMec
         y4Rg==
X-Gm-Message-State: AJIora/kt4jvAErL9BGyd3JOzTodhnQUStBDDyFSkZo+JMzQRqSaB5/F
        Z/eU/VZ0bC1qzfuNjmssPHG3ynT7DwI=
X-Google-Smtp-Source: AGRyM1vQ8AerUdZxVjx3hNnaUulEW+2k5f92Vl6MNZXsKk1GdnMigEchmJIIhmWehJHzTrInNPihdg==
X-Received: by 2002:adf:fbc6:0:b0:21d:3fc3:99e with SMTP id d6-20020adffbc6000000b0021d3fc3099emr31541722wrs.550.1658342312475;
        Wed, 20 Jul 2022 11:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c2c4900b003a02cbf862esm3264300wmg.13.2022.07.20.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:38:31 -0700 (PDT)
Message-Id: <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
        <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:38:23 +0000
Subject: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Enable `pack.writeReverseIndex` before running pack-bitmap related
performance tests.

The performance difference with `pack.writeReverseIndex` enabled and
with disabled are given below -

With `pack.writeReverseIndex`
-------------------------------

Test                                                 this tree
-------------------------------------------------------------------------
5310.3: repack to disk                                 296.55(256.53+14.52)
5310.4: simulated clone                                15.64(8.88+1.39)
5310.5: simulated fetch                                1.65(2.75+0.20)
5310.6: pack to file (bitmap)                          48.71(30.20+7.58)
5310.7: rev-list (commits)                             0.61(0.41+0.08)
5310.8: rev-list (objects)                             4.38(4.26+0.09)
5310.9: rev-list with tag negated via --not            0.07(0.02+0.04)
         --all (objects)
5310.10: rev-list with negative tag (objects)          0.05(0.01+0.03)
5310.11: rev-list count with blob:none                 0.08(0.03+0.04)
5310.12: rev-list count with blob:limit=1k             7.29(6.92+0.30)
5310.13: rev-list count with tree:0                    0.08(0.03+0.04)
5310.14: simulated partial clone                       9.45(8.12+0.41)
5310.16: clone (partial bitmap)                        17.02(10.61+2.67)
5310.17: pack to file (partial bitmap)                 51.91(28.57+7.48)
5310.18: rev-list with tree filter (partial bitmap)    1.00(0.22+0.24)

Without `pack.writeReverseIndex`:
-----------------------------

Test                                                  this tree
------------------------------------------------------------------------
5310.3: repack to disk                              293.80(251.30+14.30)
5310.4: simulated clone                             12.50(5.15+1.36)
5310.5: simulated fetch                             1.83(2.90+0.23)
5310.6: pack to file (bitmap)                       39.70(20.25+7.14)
5310.7: rev-list (commits)                          1.00(0.60+0.13)
5310.8: rev-list (objects)                          4.11(4.00+0.10)
5310.9: rev-list with tag negated via --not         0.07(0.02+0.05)
         --all (objects)
5310.10: rev-list with negative tag (objects)       0.23(0.16+0.06)
5310.11: rev-list count with blob:none              0.27(0.18+0.08)
5310.12: rev-list count with blob:limit=1k          6.41(5.98+0.41)
5310.13: rev-list count with tree:0                 0.26(0.18+0.07)
5310.14: simulated partial clone                    4.34(3.29+0.37)
5310.16: clone (partial bitmap)                     21.48(15.12+2.42)
5310.17: pack to file (partial bitmap)              47.35(37.80+4.84)
5310.18: rev-list with tree filter (partial bitmap) 0.73(0.07+0.21)

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7ad4f237bc3..6e8abcd5b21 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -13,7 +13,8 @@ test_perf_large_repo
 # We intentionally use the deprecated pack.writebitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
+	git config pack.writebitmaps true &&
+	git config pack.writeReverseIndex true
 '
 
 # we need to create the tag up front such that it is covered by the repack and
-- 
gitgitgadget

