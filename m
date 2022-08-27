Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B55ECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiH0Mow (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiH0Mom (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3231EC5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b5so4757220wrr.5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=SztfntRn+yOSBqhUw19wzsnN+EzsMIQ3OPwfGQES8Q53GDTnuNtLtevUaJRay/WwBV
         MrQKOe3XUNSftpg72NGv6kQiLPjQKc5w0stHjxApPACjmdlqE5fcBVx6c0rowsXwV6Xj
         5SQFd30pSSOrc8XHp2+cg7DqNmWJqQ1HyldSMjX312SCtuAzabUXMM5gnUSFPZe/9cPY
         NdAynyr/SoYT7qqH8utoKD4fwmkJPar3HGSjzeUAIGvjlsB2wth74tKF/JsvxSRooMZQ
         B10ubKOtlBwd6PhcdFbHF24IO0OCqUva6m5trkh1Pov9Oq2KPSet9TpJqzMdNz+k671n
         shPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=6b4jS69tL6nVYHKIVbep8GEk78d43wfM8yIkm64I42wha8yafnFw8FBhOXKSI8+iqm
         XLD6XkEt9FKCN7IRM0lp8yhV4r/3TV8/lQxCVU0JRGg4wS95JGnk4CCbkew01pniHI0z
         wbDCwqkfn2F6RXCxOJDcXz1gPLkXVDR8ZFzRZc9Og/vU3WsAFe4ZC1NxUwZ1uXMOa5dm
         IAZ6SsUBsbmr6YRJUyy677obpyL66/JZQAgOZQ0LebenOYCxce2VuYrMpfZw5AHdi3pd
         4ZulDSFm3HXPb3h4XkrAbo+ytrnXs6/0m0MxqK7J/i0csAoVDZd5sGHuHtc1L2P6l7MM
         UuLg==
X-Gm-Message-State: ACgBeo3zpZ1iE1GVvciLebXIyjsZcI84tW0QQxrlQB+b7Y2fMwdDRg62
        AV/Xmp13fo06j8VELAk4sktxGE538Bg=
X-Google-Smtp-Source: AA6agR5FfAkDU5l2yQaUb4bvTmnumuex2ChwIYi97s6d62FmQq/2p+cxU/0H0Fmi40bjTTBXS5arqg==
X-Received: by 2002:a05:6000:4005:b0:225:8b27:e6d5 with SMTP id cy5-20020a056000400500b002258b27e6d5mr2083602wrb.603.1661604277668;
        Sat, 27 Aug 2022 05:44:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a6091b3a96sm3109863wms.23.2022.08.27.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:36 -0700 (PDT)
Message-Id: <ba537af706635b0246660ea1a459a33b9fc29376.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:16 +0000
Subject: [PATCH v5 08/16] bisect: verify that a bogus option won't try to
 start a bisection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not want `git bisect --bogus-option` to start a bisection. To
verify that, we look for the tell-tale error message `You need to start
by "git bisect start"` and fail if it was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482fb..6d6e72276ae 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -900,6 +900,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bogus command does not start bisect' '
+	git bisect reset &&
+	test_must_fail git bisect --bisect-terms 1 2 2>out &&
+	! grep "You need to start" out &&
+	test_must_fail git bisect --bisect-terms 2>out &&
+	! grep "You need to start" out &&
+	grep "git bisect.*visualize" out &&
+	git bisect reset
+'
+
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-- 
gitgitgadget

