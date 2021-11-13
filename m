Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76619C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7E460C49
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhKMUlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 15:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKMUlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 15:41:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924FC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 12:38:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso7313537wmr.4
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gWOwGe93U9cpzbtpfLHB2ohkK0wiUnDVeC7k6mMq6xw=;
        b=jyXX/B2ARViyMqTDbF9I3ixOWxWbqzQqWqHmx0RJ1bfb42NDiMQ2gWth8PgbxdGIYj
         SbE4Bxliha0sXUbfB7qaE4+phI2jQYV3fqvGlXzgGPB8Q1i2YIGBrboXDzDCiSMBzrSh
         p56WH4dahead1redZZiuBvSA97Hdu6iMt8WAEHYSrdlX6iKmderRJVZDJtv02Gl6xlNt
         dRxOFm5o5qAk16ejuUy8Spaj04M28fmeKYGkQzp1T9eWABBxAuW5v2DcnYWqTJs2x3uE
         aOlO9rTeubZs7ydRol1mhTYhEG9dRZ2M4g3JRPPfIM+BVk8nZw6b3BTFXL2R5+nftoFh
         NSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gWOwGe93U9cpzbtpfLHB2ohkK0wiUnDVeC7k6mMq6xw=;
        b=XP+3+aJw6/xaVzGIMgVtFjDbhCCy+1PsRdVh8cw6DwvKK+AUycT46L4zmuAxZrf7FW
         +ZLQTru7YzgMn0rTPH9auCzUszHrlV956KCeSMZvM9/R24x+I6pdipL+hSv+8mSDRnrX
         bAMaswt1UCll8bOZYw4aH5a8VsKxRfLWYkXkuAJpnmOfdLk2TK5KT5xbBcDE61zu92IA
         MiMU8h+DNSL2rXSL8M0WyhkUYrn+70/JZ+69zCPkreCbDM3vvUvU5Quv+yXelOtLWITz
         QPq9r7rjGtE2Gxf+MUfCvgMjGvbcFuivQWx+uOEK2cBk1TdNmWSU1jtTJLeE3z4FRPTk
         2HBg==
X-Gm-Message-State: AOAM5310Y6ST4ZIg4SM9XflnGiTq7tL8/JrrB7DANebg6ITo+gNyJH6B
        zPoWMoPZoKAOBw2dFy2ORtMjM8nKb54=
X-Google-Smtp-Source: ABdhPJxNl7rEaGFjtHtY/3uXgsnOeJx6thc/5kZsb5/TYOek6+N/6KA+TqGFY5y1tyXPGPM7kf2A0g==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr45639828wme.35.1636835886423;
        Sat, 13 Nov 2021 12:38:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm13072149wmq.27.2021.11.13.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 12:38:06 -0800 (PST)
Message-Id: <pull.1077.git.1636835885198.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Nov 2021 20:38:05 +0000
Subject: [PATCH] SubmittingPatches: fix Asciidoc syntax in "GitHub CI" section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A superfluous ']' was added to the title of the GitHub CI section in
f003a91f5c (SubmittingPatches: replace discussion of Travis with GitHub
Actions, 2021-07-22). Remove it.

While at it, format the URL for a GitHub user's workflow runs of Git
between backticks, since if not Asciidoc formats only the first part,
"https://github.com/<Your", as a link, which is not very useful.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    SubmittingPatches: fix Asciidoc syntax in "GitHub CI" section

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1077%2Fphil-blain%2Fsubmitting-patches-asciidoc-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1077/phil-blain/submitting-patches-asciidoc-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1077

 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e409022d938..11e03056f2e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -448,7 +448,7 @@ their trees themselves.
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
-== GitHub CI[[GHCI]]]
+== GitHub CI[[GHCI]]
 
 With an account at GitHub, you can use GitHub CI to test your changes
 on Linux, Mac and Windows. See
@@ -463,7 +463,7 @@ Follow these steps for the initial setup:
 
 After the initial setup, CI will run whenever you push new changes
 to your fork of Git on GitHub.  You can monitor the test state of all your
-branches here: https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml
+branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml`
 
 If a branch did not pass all test cases then it is marked with a red
 cross. In that case you can click on the failing job and navigate to

base-commit: 5a73c6bdc717127c2da99f57bc630c4efd8aed02
-- 
gitgitgadget
