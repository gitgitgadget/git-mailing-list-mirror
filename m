Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8517DC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiHJXek (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJXej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975E84EEA
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so19479023wrq.4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=THM74PETnAsFVlDUnDYv4JVs4222e08VV/KYjF+kmQfw4LbnWsibEpD0h5nunSNSuF
         OMfP7ktUAz85p+C4IlQzemh3C6TpnSjHzCVO0mLhksORWHMhwI0z5VjnitX9uP8tG37/
         00Ffn6zPlVga6SU2Ra7M9Q4kJQYeX24iBT1K+X3b7jUkapBripMMkGYYEYZhglgirgjD
         PsPpCrGI3uUd+4b/1yrxykKcJm+L+BOhYKeoU1BCutOwpzIQJ9FAEU1I9Eg/C3kROwVk
         AqDp6VGW1lPagk8wFhcD4rM7J/Qsbv2+UkafBeAzIauGWuwzUGTkVOmAfm3tFTaeCL9F
         r8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=a+CAfWmV55pBKpUBhE1CZomRR3JKUTXMPw/Oe9339UgFbQRNMi39Bweq1XHAKaY6EP
         WB85UUzM4XnI1rcGpHsWlaHSwpCtqQ0U4NcSKNANCgnWLlu6/dmW05sDMT4uvgqx03Nc
         egkcLeDpFrwZ0Y/uMKHKdjMNkqDmz0PDqUZTawrOsWkxCEIvMLKJvJNNOUFaaCV2vxLO
         178lpRAQE4dUNqUx1YQRFBnHz2nXh5kA63Bzsn/Hmq2gt7Olpi5NdXJzNjSSPuVI4Ecg
         eCykyGi/qHh7cBzZjaAh+xZ5Ig0yTAm6TpNhspnaPQ70LUCNMA+Az4NlrodFJYiJwJAk
         yfZg==
X-Gm-Message-State: ACgBeo3Y/2rT1+eptQoqtjcKpHTLhTNuUfTyiELfP/rx35nclLRcKdol
        LJzVB7HYS4DHhC7kr6XwBwjJYr8fm5U=
X-Google-Smtp-Source: AA6agR58YMHllQ7FxFDw0aua5rUqEXPg3qRkD68TDYX9icY44hvQ3s57MVUC2inqzyeBp8vp6ks/vw==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr18885148wrb.650.1660174476071;
        Wed, 10 Aug 2022 16:34:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu8-20020a056000078800b002217a25ba8dsm14346669wrb.44.2022.08.10.16.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:35 -0700 (PDT)
Message-Id: <f5ceb9c71903c41c47d715ec75ced9375c643ac3.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:23 +0000
Subject: [PATCH v3 01/11] scalar-diagnose: use "$GIT_UNZIP" in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Use the "$GIT_UNZIP" test variable rather than verbatim 'unzip' to unzip the
'scalar diagnose' archive. Using "$GIT_UNZIP" is needed to run the Scalar
tests on systems where 'unzip' is not in the system path.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/t/t9099-scalar.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 10b1172a8aa..fac86a57550 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -109,14 +109,14 @@ test_expect_success UNZIP 'scalar diagnose' '
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-	unzip -v "$zip_path" &&
+	"$GIT_UNZIP" -v "$zip_path" &&
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
-	unzip -p "$zip_path" diagnostics.log >out &&
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
-	unzip -p "$zip_path" packs-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
 	grep "$(pwd)/.git/objects" out &&
-	unzip -p "$zip_path" objects-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
 	grep "^Total: [1-9]" out
 '
 
-- 
gitgitgadget

