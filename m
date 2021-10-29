Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC23C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7BA6115C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhJ2OB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhJ2OBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAEEC061714
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o14so16234861wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QBAXo5xOJ9+og0f0DdBUHfgUKw32ULT84hiuDsKSprk=;
        b=JnPMZ+3p00gDdDZONl15pRBJBlZvmiXLxF+nZGvnE3vP4XFx/riXgx+9A49DTkYSIs
         gF4tJjG1diOaqrQInuIIYXH2Ucj06K9FlRxqmMtt3gLwpFBR4NDCEkStaMS33JYVIfe9
         A/QMqzxURKVs1hRVSzH1VTcR1lp6C9i70F1MX+gUPl6ztZKNjhaWBZveNSFxj6uxbixt
         2y3tsPNygGP/8pML9Yr8DMZVLb5tZIGo60Ce2Rk/LXfhtnzhUO8bN9dyYOHIsGs+//jG
         c9kpVOuSAcTiiG8N1BIyVGrIBxJ6bR2KEYQ8jD/ApERW45kOkX+Lt9bQKs4vcTB3sT9U
         9BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QBAXo5xOJ9+og0f0DdBUHfgUKw32ULT84hiuDsKSprk=;
        b=rZ3IYJsXWgz9gt+7iNcUYjqpkEx8lQ5YIr/I1QVPqjFnnfZeSyj3wda9b0CktGD5SI
         5m2NCe4h3/J0WEu8jScIaHqTcuC919HzmDg9f002Z481fvrhXM/wNJt0iQLX1920/+8M
         2aqrkwJHO4HLAFXVRY9SitEJCqRwJD1cdEFo4MKmBi2G/jjYngEusd3NoHxVax5XZJC4
         F2yjC9HJUaWV5V9DeuMrLWtNVQ6McNWFnby1BZvAzNIOLuOQaGnHiL4R+FtWx0NqwJoG
         7bA8BbZQuU3X6Lg41qJ23wo6LA0TF6PQ/PF9C7WEft5jUzbdTHYWUBegOAHalz8+/WBo
         Xy7g==
X-Gm-Message-State: AOAM530hBto4rhCFAdFmPc2yjKxMvF+kO6rsvFW+jt+HOed2+tcIns2Q
        GyWfud7MjIcmxxVBitl9qsSAWgHBI4k=
X-Google-Smtp-Source: ABdhPJxHkMKi8lA490YiyQAmUtKsOrcgHxdEtQBLpTSbMgNXIPk7lCRXd2L9k4ZmS1hA1O7/F68bVg==
X-Received: by 2002:adf:f644:: with SMTP id x4mr14838479wrp.294.1635515963264;
        Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm9595304wmq.34.2021.10.29.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Message-Id: <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:15 +0000
Subject: [PATCH v3 4/8] t1051: introduce a smudge filter test for extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
added to the database or workdir. ("Smudge" when moving to the workdir;
"clean" when moving to the database.) This is used natively to handle CRLF
to LF conversions. It's also employed by Git-LFS to replace large files
from the workdir with small tracking files in the repo and vice versa.

Git pulls the entire smudged file into memory. While this is inefficient,
there's a more insidious problem on some platforms due to inconsistency
between using unsigned long and size_t for the same type of data (size of
a file in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
size_t is typedef'd to unsigned long. On Windows, however, unsigned long is
only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
unsigned long long in order to be 64 bits).

Practically speaking, this means 64-bit Windows users of Git-LFS can't
handle files larger than 2^32 bytes. Other 64-bit platforms don't suffer
this limitation.

This commit introduces a test exposing the issue; future commits make it
pass. The test simulates the way Git-LFS works by having a tiny file
checked into the repository and expanding it to a huge file on checkout.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1051-large-conversion.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b7640b3ba8..bff86c13208 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -83,4 +83,18 @@ test_expect_success 'ident converts on output' '
 	test_cmp small.clean large.clean
 '
 
+# This smudge filter prepends 5GB of zeros to the file it checks out. This
+# ensures that smudging doesn't mangle large files on 64-bit Windows.
+test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB convert on output' '
+	test_commit test small "a small file" &&
+	test_config filter.makelarge.smudge \
+		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
+	echo "small filter=makelarge" >.gitattributes &&
+	rm small &&
+	git checkout -- small &&
+	size=$(test_file_size small) &&
+	test "$size" -ge $((5 * 1024 * 1024 * 1024))
+'
+
 test_done
-- 
gitgitgadget

