Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A97C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiGDIqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGDIqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC7BC2F
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5189373wmb.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k6WYHfLVHIWukb6MJ09rmGTuOYwfXDIjpLmszQ0Ix3M=;
        b=Xm+doZJYCd6b76MsJLj5PgAhlvePnpX9JfPSYjmSfWAGdkX/5qeFNDiBIPoYk7zckM
         EqYklTlVyH9o3g9+6yAVDNkYDXZVv1VfQyi739yZ7pOZSADmWM0ri1gJBtahInv9jHJT
         kux91+yDqzzz0+kTHCV8Mj7NadidCUbcH2YEtlotZtNgJ6N8JxyaUbQQ5rTsr6Ned8xB
         rrhUf2VlQ/woBrdx8n535M1BYOvxGT9i0nux+jbgf+p1JLZDofUnx79+ezMlKaf7kBn2
         nSp+OsEU6gZ/ZWfuO6jwEMFRHU+7CmOAy/S86CXHhVGsfO1i4LQB91WNJrNCnBlXjVvB
         yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k6WYHfLVHIWukb6MJ09rmGTuOYwfXDIjpLmszQ0Ix3M=;
        b=io956UXxzF4NeSbzrqw0OC26brpVUUNy5TroWPFlmZgcGb/0So7enlkdeI+6Ie+kw/
         kcPqGSU9g3pWVE5EIGED117Zs8+CEL13sFT5MqnKayu+FM4PhQtiDf6oZ2ykR3xQP7Ng
         P7LbqczpjJlHMLocWHSYv3E4zY8gDpHsCpAQ2MUykWlUmivBVvCiucYgPFzaPx1fcV1g
         GOqNQvjs6oSdXcjoVwtIdavSu5PanhiTdu7pzhdVp/ns+HcKA6C4p9rLyRZp/A//I51H
         lqj9RTlTltgYzXuC9CMKg0zABseYofLVoHdD973O+j2dGnyXmPEIzAvWyuqoqX4X6Sjk
         QsXA==
X-Gm-Message-State: AJIora/NWiAKGOOOltT4Z24uAqzGnJTGaWf0hsMYnQpN+z8WNB8VhqLS
        rO7xSBLasZ/uyK9P9wFFL109draLrD4=
X-Google-Smtp-Source: AGRyM1sPXT5P9HwVzFPEPQJJOLLgF7QJZpBFC0z+YdbfB9p7m3CLAArLVL3K4HzVKVZEDNIN7YAbRA==
X-Received: by 2002:a05:600c:4e8b:b0:3a0:5826:3321 with SMTP id f11-20020a05600c4e8b00b003a058263321mr30263338wmq.108.1656924391126;
        Mon, 04 Jul 2022 01:46:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm28733325wrb.70.2022.07.04.01.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:30 -0700 (PDT)
Message-Id: <4f9f10494855265133bc315fccedf81ced65ce83.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:16 +0000
Subject: [PATCH v3 6/6] p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The previous change enables the `pack.writereverseindex` to see
the effect of writing reverse index in the performance test.

Remove the `pack.writeReverseIndex` configuration.

Below is the result of performance test. Output format is in
seconds.

Test                                                  this tree
------------------------------------------------------------------------
5310.4: repack to disk (lookup=false)               293.80(251.30+14.30)
5310.5: simulated clone                             12.50(5.15+1.36)
5310.6: simulated fetch                             1.83(2.90+0.23)
5310.7: pack to file (bitmap)                       39.70(20.25+7.14)
5310.8: rev-list (commits)                          1.00(0.60+0.13)
5310.9: rev-list (objects)                          4.11(4.00+0.10)
5310.10: rev-list with tag negated via --not        0.07(0.02+0.05)
         --all (objects)
5310.11: rev-list with negative tag (objects)       0.23(0.16+0.06)
5310.12: rev-list count with blob:none              0.27(0.18+0.08)
5310.13: rev-list count with blob:limit=1k          6.41(5.98+0.41)
5310.14: rev-list count with tree:0                 0.26(0.18+0.07)
5310.15: simulated partial clone                    4.34(3.29+0.37)
5310.19: repack to disk (lookup=true)               250.93(171.97+20.78)
5310.20: simulated clone                            10.80(5.14+1.06)
5310.21: simulated fetch                            0.71(0.79+0.16)
5310.22: pack to file (bitmap)                      39.49(20.19+6.98)
5310.23: rev-list (commits)                         0.81(0.48+0.09)
5310.24: rev-list (objects)                         3.48(3.38+0.09)
5310.25: rev-list with tag negated via --not        0.04(0.00+0.03)
         --all (objects)
5310.26: rev-list with negative tag (objects)       0.22(0.16+0.05)
5310.27: rev-list count with blob:none              0.22(0.16+0.05)
5310.28: rev-list count with blob:limit=1k          6.21(5.76+0.29)
5310.29: rev-list count with tree:0                 0.23(0.16+0.06)
5310.30: simulated partial clone                    4.53(3.14+0.39)

Tests 4-15 are without the use of lookup table. The rests are
repeatation of the previous tests but using lookup table.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 1ad3c3f14c6..ac5b7341e8e 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -13,8 +13,7 @@ test_perf_large_repo
 # We intentionally use the deprecated pack.writebitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true &&
-	git config pack.writeReverseIndex true
+	git config pack.writebitmaps true
 '
 
 test_bitmap () {
-- 
gitgitgadget
