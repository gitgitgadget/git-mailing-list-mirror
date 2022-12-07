Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F5CC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLGOfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiLGOey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D45CD35
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:34:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u12so27407429wrr.11
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+plBVQFXEE6QT9IXQXQ1nH0spaoTmFz/6spUYrNhIo=;
        b=OjWRo0jafQxp8ORGihUNFI8X6ejveaCeUJedaJEUz6WRZ48J5Wev6gbfAWLAMBjhfj
         kdhhV/qFiyterdWFLt3F2Mcc1p7JBbkeda4afsJ6f5NyRTbvU4BDeNWUzUeYojCZBZMX
         FyjxSlu62RhxR9Rq057ZJjScRTx9ZtfAoCfuBcmx/izVa8nQd9zOeqQcqaViCXUqtBiG
         SLb2eE0LXDiez0joH0s2fE9Uv9UMz3Nw1ZX8+Qbgdm7mZd6PkGLhY9Q88BG04sgYW8ai
         TaBurMEFI/zzJUfCDqvpxMPO9ysgHYrJOHUdY2HVhXzKA5clef3bydtvG8k05kTZiFD3
         jwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+plBVQFXEE6QT9IXQXQ1nH0spaoTmFz/6spUYrNhIo=;
        b=MTDmAwsDhrNDBUwgRlHj3ayzJIBQrUBHhbVh6dNp8hrb5wCHYtQL/X7r50sAcgh3WU
         U8vdYZVV6ZfEFSFAFChVnZ8Iyw30zhuzmjV2Aoid6N3Ny4ipk3yLfzYbqEPv9WfLGUUU
         kDw9EXevXDIeirUDSsZcPW+HRVCVYEzxRpvMyrqT3wr3JSpUsahzHv/KsDKt0QrVhiUd
         UCHGGi2luokKrfvw5Qh8zD+KtvCOIehnGqOtecI2UmWiMqy1NHAkvP3CivWyNuRNGlJx
         j1z1n8H9vuafPB9XShq77bui/vux2d8o3u4GdxMPhbMumgrIHtm9FgyH6zZo7Had6xMh
         dl7A==
X-Gm-Message-State: ANoB5pkG9NslyMdi0wKnBeyPq6ffuTSaR8fz12AJsOQLYjn77wmays/r
        vA7fHaH2DT4rxYM3t/1NOaxaY71Z2TA=
X-Google-Smtp-Source: AA0mqf7G7bJ+62dErvLj+ya0g3S0St6i8EsL5FRqyF4MbjPaUAC8ZXp4G8PuC9bcFBBgkEusl65XIw==
X-Received: by 2002:a05:6000:12d0:b0:242:14f5:7aa5 with SMTP id l16-20020a05600012d000b0024214f57aa5mr28007030wrx.465.1670423689642;
        Wed, 07 Dec 2022 06:34:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a05600c220d00b003cf71b1f66csm1926788wml.0.2022.12.07.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:34:48 -0800 (PST)
Message-Id: <1081c62fb266bc41f7084ea2a974729315a7634a.1670423680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:34:40 +0000
Subject: [PATCH 4/4] ci(l10n): avoid using the deprecated `set-output`
 workflow command
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

We need to use an environment file now. For more information see:
https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/l10n.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 27f72f0ff34..2915c595b4f 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -23,8 +23,8 @@ jobs:
             base=${{ github.event.before }}
             head=${{ github.event.after }}
           fi
-          echo "::set-output name=base::$base"
-          echo "::set-output name=head::$head"
+          echo "base=$base" >>$GITHUB_OUTPUT
+          echo "head=$head" >>$GITHUB_OUTPUT
       - name: Run partial clone
         run: |
           git -c init.defaultBranch=master init --bare .
-- 
gitgitgadget
