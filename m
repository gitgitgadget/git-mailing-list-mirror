Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43AC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbiEUWTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245400AbiEUWTC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25514EF60
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so15875590wrg.12
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ychXGwGi9MKGlFm4LBv/h3HDn8TPIu/o+OfIz7tey24=;
        b=MjX3yuMselYclC1hS8A8e5FPRj5MBq5HMIIIFy0aZ7dk/khPHh9tY0gwABOpmR/Z+Q
         ulytuVZ/JAuJ+G9EapwwyehhgZlAMzb9vGyrJcuD5CCFQOQ29xKmdjYZ1eNtRxXcyMys
         UNa5TdH0M0blJSWEokXOvao9EkAg0ijuRXdP8JpJ/Krxo2n6a0scSSx8UX7ztsRFfxIb
         avArEbzJu0By8/zxr33LPBAJotqKdqYkNmUD1eAZrnoaRZIzNBqXw/Ql+TEGO8JVUG9P
         IZAAol33/fYNt3PsDh4QFpxwUSuIlkBsNbqK+02ZU4D8WfS2w5Jl5McoJsB18T1P4Y4r
         bwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ychXGwGi9MKGlFm4LBv/h3HDn8TPIu/o+OfIz7tey24=;
        b=La8UeG0PqN/S2KXxKUDfPDY2QYgWMTB0R5p3vn7DIlJBfDa1vprfWiNLKLM3+3HJtx
         VlZSHyJcx/5Rwk2qWlCn7nMxlT8Pc1/L7wcgxLMbr5SbLzCIDcD4xpAiBPAS1A68BvCB
         lALQciVnQ3EPG8A5ShHony30JRev9X0aAZWPyw7aAmb+LFcLatGexNJw1Sc9BcJZuxBp
         IPBwIE7Ze3wI7VmwWRVy+ZTfsS3lq36X//U/b5YeO4B7KxtLCiHVEsGlc0wDPuYxS93q
         +kPgeg035M3bK379gK+0GUozzbdEi7L3L1poHSjJUS3D/KngbV2INgpLzAynWtBq0DR4
         0MLg==
X-Gm-Message-State: AOAM532162t6lrT4M6scxalNjwwyGU8+IK/Ihe+V46kKGFS1E0bOhHpl
        AkEVy2+V27sg3ruHOJ8mf/39jznkOsw=
X-Google-Smtp-Source: ABdhPJxVZPV2zLOqzZ/lDUpnwNRWRlLcWUb0AzqGzoERG8cK+wOrX06aUVOiLj4NK/UiRLnCx3lpNA==
X-Received: by 2002:adf:cd06:0:b0:20d:a8a:c096 with SMTP id w6-20020adfcd06000000b0020d0a8ac096mr13576986wrm.637.1653171538936;
        Sat, 21 May 2022 15:18:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b00397381a7ae8sm5167410wms.30.2022.05.21.15.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:18:58 -0700 (PDT)
Message-Id: <68793fcec62dce83a972a055fee46f48cedd115a.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:45 +0000
Subject: [PATCH v3 01/12] ci: fix code style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In b92cb86ea14 (travis-ci: check that all build artifacts are
.gitignore-d, 2017-12-31), a function was introduced with a code style
that is different from the surrounding code: it added the opening curly
brace on its own line, when all the existing functions in the same file
cuddle that brace on the same line as the function name.

Let's make the code style consistent again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 86e37da9bc5..d718f4e386d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -69,8 +69,7 @@ skip_good_tree () {
 	exit 0
 }
 
-check_unignored_build_artifacts ()
-{
+check_unignored_build_artifacts () {
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
 	{
-- 
gitgitgadget

