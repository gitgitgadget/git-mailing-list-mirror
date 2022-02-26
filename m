Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE9C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 05:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiBZFe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 00:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBZFe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 00:34:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D62241C5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 21:34:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i19so2759809wmq.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 21:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b0WLIYVG9mmuGLn4h6i4alX/GiTvLQPaBf1KMmSwvME=;
        b=ojXX68tVgkP8DfxeTVfoHdrhiXqEE9pl8PO20VzcWZ4d9Dh8vU88L2l62U4IDs4CMP
         JIw2ciWMvu9JyO4Kx06AYcO75/QEgi27L7IzpZGYpX7knm0hDj0OH6k0h049dx5cIErh
         lBuyGq+5UMWHBuv9Pv1qkskyvypMZ3y5iLL3EcCL+jsTbDWrpn82qs12KOaBy0dtOjyp
         zSLXurlqhwgtftVlcKVLz6fdSAX190CdhiONRwW0mqrTVc3+WUhxGpoz00v1ARFnPtz7
         j72quxQPxIIoDMKtWUNRrOmbr5FukscZcG3qFJ29WPIrMucZNXuaGnUjEvNrrexEJYfU
         sGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b0WLIYVG9mmuGLn4h6i4alX/GiTvLQPaBf1KMmSwvME=;
        b=BK4GTfMurvpUARWD1XLSjXipmu14vYpocjYRtgjqjcvHhwKgtyNtKb2m0i82WE89O8
         e3d9yjDfOUoH9s63rshEkcaBo+s1lHZls12DbF+tvXnaChPJwQhNX3o3ZlALMI1rinID
         LhkNeCzdKsZ+m7BMm0x/Zpvc173rINVFUF3vBc/I3x2ujoGYu/wiFsrY5d18OGFm3hkB
         lpsbErBugnUj8tC0X1oMlKFwjHAxLErYzbpr3rqpuVjzGeJAd3YSZ0axFPRJHULfy4+8
         6n90sQ1IEv32Kyh6pN2SzNkrmVkt58BV78Pi2EOf9YpQKMmEmERlpzbIFMMTJG4y63Ny
         9oOA==
X-Gm-Message-State: AOAM533w1NZPjCbZmS1maGHIt9K5e+r+efKug39nR9Z7m9MTSe78nmlz
        kVS38uPXZAQQZvBPVWiZGfkLjrgXDYc=
X-Google-Smtp-Source: ABdhPJxGnFM+GwK13j8wFYDsr3+duLee/ZiFv9TBiAbv/tldn4u5rr+zVxFB0tSsXZ8hK87HtERn4Q==
X-Received: by 2002:a1c:35c9:0:b0:37b:edec:4d88 with SMTP id c192-20020a1c35c9000000b0037bedec4d88mr5328153wma.159.1645853662447;
        Fri, 25 Feb 2022 21:34:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b0037c4e2d3baesm7580264wma.19.2022.02.25.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 21:34:22 -0800 (PST)
Message-Id: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
From:   "Matheus Felipe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Feb 2022 05:34:21 +0000
Subject: [PATCH] fix: include the type flag in the cli docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Felipe <matheusfelipeog@protonmail.com>,
        Matheus Felipe <matheusfelipeog@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Felipe <matheusfelipeog@protonmail.com>

When the `git config --global --help` command is invoked,
the cli documentation is shown in the terminal with a small
error in one of the values of the Type group, which is the
absence of the type flag in the `--type` argument.
This commit fixes that.

Signed-off-by: Matheus Felipe <matheusfelipeog@protonmail.com>
---
    fix: include the type flag in the cli docs
    
    When the git config --global --help command is invoked, the cli
    documentation is shown in the terminal with a small error in one of the
    values of the Type group, which is the absence of the type flag in the
    --type argument:
    
    image
    [https://user-images.githubusercontent.com/50463866/155674905-01fcdf18-8f67-488a-b367-985040dfe57d.png]
    
    In the web documentation and man page:
    
    image
    [https://user-images.githubusercontent.com/50463866/155675353-4a39965a-875c-475c-829d-7849a982f5b9.png]
    image
    [https://user-images.githubusercontent.com/50463866/155675437-7283dbac-fff2-44b7-8733-7d5af375bce4.png]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1220%2Fmatheusfelipeog%2Ffix%2Fgit-config-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1220/matheusfelipeog/fix/git-config-docs-v1
Pull-Request: https://github.com/git/git/pull/1220

 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 542d8d02b2b..2aea465466b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),

base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
-- 
gitgitgadget
