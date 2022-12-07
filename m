Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDFC63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLGOex (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLGOet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071394E425
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:34:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f18so28356733wrj.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WmURY8YfLexVIrO9Za9daYjGb0I8oqr1bINI3k7xpA=;
        b=kgrsWOpa0DESIJLtGytUotgbOpv4gbnR/sJR1eSwX4KPqArVQAq5204tU3nkSp7ehi
         1NbdQ4O0Wlqv+J7FvR+Tjq4vfPx/0aHt/bi96ffUJEqxi6VDDuiD4WfoLDZRTYQ8ehgH
         sYqYel+8YeW7/XJ8Af98Biks+ZhzsF9/VflOtDjnL3kZveHpzBZKEgsPYl0nXitOnYZU
         cbnt6K2Iqd0QA0TT4NHE1ZZ8gKA6w1+S6+P4k2cdMhEc2lSe9KfzhyUIRVSEu4eKeG85
         GHENgKWLBfNyBKC/jaHuLpN2VOSQMZfK3HoM0y3sbYZ0qR8aA+eJWQALFMYUKYElIpKd
         To1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WmURY8YfLexVIrO9Za9daYjGb0I8oqr1bINI3k7xpA=;
        b=pRqObvw7KAA76g5uSxXuOFVI0qUCfNhY/PIa398c+PsLBcz8XNrLE0vL6fgHkDbpnC
         qJyHDHKOxorA1LlG4ciKWkDspXnewQUQWVa6Nkrjz1wx9HEyG6V4QEMqEJMo8fbk0rbc
         A0lXKXRbgDyBAVazFFWNro2HZJTCSUL7+2FSk8gAEFggjU3l1LekhYSIUzGlNKYey8vV
         11CRho8GRVR9tuu98tx6HwkyDyoJkfXm4wpfocnok7STZukxHIaxjwLEftXkH74oPqp1
         fL9kr55a5jZ/L39GD6wm6ibHOQ7vRSI+uFJCcTmq8VTP5xkXuIP7zGt8LjLjFfDG7CeS
         ZcRg==
X-Gm-Message-State: ANoB5pllDFdUbudKkfFXiDNLTMxewT67hBfNTvbJvOMpootS0GqX5WNM
        7VytGlCeAq6X5BVR7n3qPtJQWo41dJU=
X-Google-Smtp-Source: AA0mqf6I/vFNLdXIh68xgfny/00bprJIV+mPHikD9MxnflO1osizGEvU48Uwwk68XvumSz/oRFvGpw==
X-Received: by 2002:a5d:6751:0:b0:242:122c:6672 with SMTP id l17-20020a5d6751000000b00242122c6672mr29773472wrw.330.1670423685717;
        Wed, 07 Dec 2022 06:34:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i82-20020a1c3b55000000b003d1ee3a6542sm1867127wma.47.2022.12.07.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:34:44 -0800 (PST)
Message-Id: <1693393443975bc25f3020e61a29944804e35601.1670423680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:34:38 +0000
Subject: [PATCH 2/4] ci: avoid deprecated `set-output` workflow command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Due to security concerns, this command was deprecated and we need to
write into `$GITHUB_OUTPUT` instead. For more details, see
https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 43d47824dd3..1e95aa86b6c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -34,7 +34,7 @@ jobs:
           then
             enabled=no
           fi
-          echo "::set-output name=enabled::$enabled"
+          echo "enabled=$enabled" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
         uses: actions/github-script@v6
-- 
gitgitgadget

