Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39DC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A661994
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhKSFII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhKSFIH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:08:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E4CC06173E
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so15873887wru.13
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ecYa1k70FjAuUAbe3oL9n0ZmrdS6E4opQqZqVqbxt0=;
        b=M1tL4TM0hwCRnWwZLj2vw7+GomF3TNSSnY0izadAeW7buJHgvnjBiBE7R+B0eJtRoW
         PzLvI2f2LKF/DxsQ/gb6IC3m1QgHwpQDX6cfTvWM3CmhJats+gaBXvyvGYccyb4U7w7Z
         mHUyNxyxVLwx6gxQhf4tJy+DiC9dPmmnJPj5JmDmjqm3LPqOh73RvkT/kc4VkUn9bRlD
         fSFGG+rRMSpfxRfeywW0uuTeZkUBywV1lgtw43NexAwg7Lua1wO0TvC9cYpmMyx0S136
         oPKgigeXVWyhtjUivrWGlGeszYrkAIaaC5YPHWAr+6nmYInV7F3zPLR2c8O9aVVLu5aa
         b4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ecYa1k70FjAuUAbe3oL9n0ZmrdS6E4opQqZqVqbxt0=;
        b=YkIr2sL5FvZnRQmXIYjfUm1JeVmdO+74AnhXr2sKZ5K4ft/NVuqaBiT5nyz5RFnL8s
         tHDfxK13ZrmtVKkU8+3vmPHDnhVe8yLg1K6tglUhTkkNW50Dsmla4POJs7MB0ph1xrFa
         Gg1QSARgibgfL0sMvtIX+TgijyJhF8Ql/N59zuu7e89GHBpDiwXsMJHyI2VJRVHXEjgE
         22SYR4VEeuD8bQhK9S/NKyj1oFq34mgYzjLZKOgwYSP02ZG01tGceE34Lbw/WNjxbYUP
         t4xoeSuaCMxZoBidq9K54DCliuz+/1v0rWyRMRXwqqMyme/a3mdJO2NBHEkdeKwfVpUf
         f4Sw==
X-Gm-Message-State: AOAM531SA6JYzj4OZakO9IwLjWhgXNz1UF2p8vGjoj36/+T6LbSJgEJ6
        uZAiIbIDwCI0GI5JPINtRH1vNK+mQGA=
X-Google-Smtp-Source: ABdhPJxfxFTJzi8ojfcgPEodGFa0i5Z7J+5cJsAtHVbYFVADUmJ5aHMx8UZwVH7ZNsBqAWbm+g3dQQ==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr3808935wru.97.1637298303877;
        Thu, 18 Nov 2021 21:05:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm11206755wml.8.2021.11.18.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 21:05:03 -0800 (PST)
Message-Id: <d612bc49d57291f5ae67eb7cb4dabc3a1f2af7e7.1637298299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 05:04:57 +0000
Subject: [PATCH v7 1/2] doc: git-format-patch: describe the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

This commit has described how to use '--always' option in the command
'git-format-patch' to include patches for commits that emit no changes.

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

