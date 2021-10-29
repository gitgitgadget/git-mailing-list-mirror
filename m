Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFFC4332F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D77461100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJ2OBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJ2OBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10007C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d3so16281378wrh.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IWZ+wQFISLCSuKsKparVaIZmh4E35bF5Bk/+BvEvB5Q=;
        b=XCQ47Tysg1anXPKhFA+GOMUz8jSeQvbX3eTAUn6PDXH1WzR5yU3gbAdw7dL95jfE1D
         cK0wBXozNf6PV5ZGVTH7dkFDaEV+CdeCJwCJvueBKO66BFju7Z4vVqXjFzhCdJrJnhlK
         ezKThtON9/RhKx5QGWN/LiQ5P0j1ueWPG4SAydt+DsbVV75/8lJb4XDHms9Z03QXv0ta
         AK5WaNZ962yIksA7gDSOxKcH9nZTavd0QkXMjZmvyiUIkdhSTg440+5z5DE1bwf9g2CM
         qCYcw7gD0lDMJXg+WTth01gQ9pD7d8j2kWHSbzOcNDt6WHg6ulzSM8OhQM29LwvaLDBH
         PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IWZ+wQFISLCSuKsKparVaIZmh4E35bF5Bk/+BvEvB5Q=;
        b=3xTv2qMLm1Vqcxie1GPWW/wESpGcF4/O34w+YVtIb4yUY/bXLzfSNl1MXyY0CE34Ke
         bzIESuIs231qZC18PMQMqK93TWSxW12A3PXJi0JT5uD8u+ROrZeaFi6gM3ldiuibxObL
         pHCyQp6r0D1I3McfwN74nQ79sM4YgP5RW3mpZtYd7JWvUZlNRUJOTCTAachjKnw2QI5p
         TxNcR9rZaX9jf3DGqGImespuCEpp5+PkSOrTnav6Nf/e2qN6liWjqQWi0JRiBbYFntsB
         cpnHwm2W5Ddjf00SeM3SD6eCbLLvr4wQLsvh1xMPNQ+Bl5CiwFHmDQGrx2iN699sxMav
         ctlg==
X-Gm-Message-State: AOAM533GsBOLhQXdeIejdND2It0A1Lch30YKmyB/T+gpeN44y05XquDp
        67qmhV/xuF+qoUH0FJlY7dl8LX/VYhs=
X-Google-Smtp-Source: ABdhPJx4DFDvl7RkGJP+F+AChRisNhVNWU//c8e/mMx4YeGvTs8O9Kt+A10NdM0BmZl87xt7/RsBNg==
X-Received: by 2002:adf:d082:: with SMTP id y2mr6073304wrh.214.1635515962706;
        Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm1412647wmd.3.2021.10.29.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Message-Id: <489500bb1dcaffecab42672658990cfc26d52d7c.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:14 +0000
Subject: [PATCH v3 3/8] test-lib: add prerequisite for 64-bit platforms
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Allow tests that assume a 64-bit `size_t` to be skipped in 32-bit
platforms and regardless of the size of `long`.

This imitates the `LONG_IS_64BIT` prerequisite.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e8..af1a94c2c20 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1642,6 +1642,10 @@ build_option () {
 	sed -ne "s/^$1: //p"
 }
 
+test_lazy_prereq SIZE_T_IS_64BIT '
+	test 8 -eq "$(build_option sizeof-size_t)"
+'
+
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
-- 
gitgitgadget

