Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbhLVK7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244336AbhLVK7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6176C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so4183924wrb.0
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rato+b+gDDJp4bZBDwPOPwpDF5sfClgs0nUjNmKWOsg=;
        b=JHQe2NVMM4TftPxg4f1gOKSzi44VjT4qFHL+3ZT9heFtcT8boI+bfV28BVNLputUht
         9w4qxbJVX3OXyvzYfyQprKJZy50CeE+iw9JWgVFH2Rx9a+pgM+KbOGpzoZZxvCyBx7I0
         SBc9t4arV+SqdOZI1g3UIiTsr2atX9JoxshdhzqMCngpLSj65K6Rg62q3014MYeRM07J
         5svoRjYUZrGpKIyNpGsNdbajcRv48TKFU1QDw9/usvM+jMyPvSxiFpLKaq7kFz6nXbPb
         Ei2UOIroPy2eZ2VirHUHiZSpYY1HbDx9576MLsI8EEggbZQEErIYJQUNKYKyNhZo768N
         MmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rato+b+gDDJp4bZBDwPOPwpDF5sfClgs0nUjNmKWOsg=;
        b=IuiTVQj9+NTPAfFnuq9h5XUqUqHLcgrMKeRKoyKlNTpt8xP+9rQ7MmLvEYrL0Uu19Z
         JR83yLUlLlHZtb4/SAgm7h41QHzkh37PnkI06L1Fn07VehSp0Q2Ywn0wKkNXdRgIFP+1
         tEHfhT8Y+5AmU64BW/uZyipThOpELoqa4Cj2TrO1K38GoGNNEFjeGNWaLIMCzYYFM6K9
         SqF6oDQZiYfHcAL7vYw+WaOl/IDjFBbeUTJQ9NiQTjLSSi6ClImYXHDx0uiPNi/OfSDG
         Ax9knS/IXx9+echlKNXwN6nXnfkiGNH347gLAm+3HRlRd7yz2AmsifUhjaCPwY4D+Kla
         8sRQ==
X-Gm-Message-State: AOAM5320noWSiEWSWPQWdVr0bGkX6mvziacsDVBGIeUMTA4lFiTiG3ac
        7x2Z7gqnMrEP49HUkGUB5txNsH5nIhQ=
X-Google-Smtp-Source: ABdhPJwmSMVekkAofX86BD+KTlbGs5Tr+HSCqt5b6VfyQxhQKcbn+Hnu3ylrB/VrvX07u4whfGKZrg==
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr1716753wra.281.1640170787416;
        Wed, 22 Dec 2021 02:59:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm1551682wrb.2.2021.12.22.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:59:47 -0800 (PST)
Message-Id: <36758f8cda3da4a53cbdff3af2eac3a60aadd692.1640170784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 10:59:42 +0000
Subject: [PATCH 2/4] t5550: require REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The dumb HTTP protocol exposes ref storage details as part of the protocol,
so it only works with the FILES refstorage backend

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5550-http-fetch-dumb.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d9142afc3b..259203926a9 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -5,6 +5,13 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+
+if test_have_prereq !REFFILES
+then
+	skip_all='skipping test; dumb HTTP protocol not supported with reftable.'
+	test_done
+fi
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

