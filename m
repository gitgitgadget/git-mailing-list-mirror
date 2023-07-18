Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB122EB64DA
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 13:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGRNNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjGRNNI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 09:13:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3541FD
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 06:13:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-314417861b9so5127362f8f.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689685984; x=1692277984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UvA92Umw5kUSa0MgiAPX2l3ycKkThlvR378aErNA1pE=;
        b=B9bkE2+57FSI1ibDC6p7GQT0x+2JaplytpCkuvNreNB+Zr2/KX1HJbruf4kKBLTqNf
         sp8anSBVS03/C0Ur3LT3vQlvSPKKz1bu+c6T5Ay6b+U6OlAkzwIKp5akVyJgWvBYv6L3
         OtvI7oUOxZz9MYO+UQnJvCuQCsy7hkuS6js569iV3LNBzFnTHOm6X3gikjwCqGcPsn9c
         TnWV/XxSgAQvpetospn07S3d9WtOAXVeUK/wWucXQhuHahoCav+NXEMmuRmnKWPHm3nI
         COUxlhYBF/aIBeYJznQzccaiatJ1YYoVt1rBZaszKPTpk4hlsi6z6/Jt4DTqVVylYIDw
         RGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685984; x=1692277984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvA92Umw5kUSa0MgiAPX2l3ycKkThlvR378aErNA1pE=;
        b=CIxsdXfcTcEPPdbYKU90t2FRNC1INvl8d6lVGap2qULBtoMSXUeztckAFPBB4WApSz
         M5jzUKjPdT+AvZcs6EWp9i9Q8gB1e7IuS0fX5EdUkAcs5YPnGTiTzzj+n+5uGetkaZfm
         SEm8b6+RS3Ublk3uWl8WsZLWA3ApViDEiWk1Kq1Grq/BDgbkSG3rCD/u8kH4/vlVRBb6
         yXdCUwl6YOOJdGJ2sfU7hgTDHU3LJ5wNCA8/vWw+6bMZR92iRPzVm+Wr2Q/pC9U1eDHf
         nsTvINRnSxpinQAEJKJjVLFeizTyoo/kJtIqdAgBI4QU7n428adIOD8ULe10azWs1SW3
         vvJw==
X-Gm-Message-State: ABy/qLZVC2C7aT+pVvflZkSQhLVaFGkHVXEN8zh045LpPZP81UACXMuD
        qO/6cm8Gxqjm6LGDQJrCk+5mijRn8b8=
X-Google-Smtp-Source: APBJJlHTQPEe3d9r/anr/QzKnC5FquyZSAha3j5tb1eXusgyXYwf1Xtzdqmf2ktiyuNMNzQYlgc0qQ==
X-Received: by 2002:a5d:658f:0:b0:30f:af06:7320 with SMTP id q15-20020a5d658f000000b0030faf067320mr1499395wru.23.1689685983982;
        Tue, 18 Jul 2023 06:13:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b003143c532431sm2372456wro.27.2023.07.18.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:13:02 -0700 (PDT)
Message-ID: <pull.1553.git.git.1689685982027.gitgitgadget@gmail.com>
From:   "jr via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Jul 2023 13:13:01 +0000
Subject: [PATCH] gitignore.txt: use backticks instead of double quotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jr <johan@latehours.net>, Johan Ruokangas <johan@latehours.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johan Ruokangas <johan@latehours.net>

unifies highlighting with the rest of the documentation

Signed-off-by: Johan Ruokangas <johan@latehours.net>
---
    gitignore.txt: use backticks instead of double quotes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1553%2Fjozan%2Fbackticks-gitignore-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1553/jozan/backticks-gitignore-doc-v1
Pull-Request: https://github.com/git/git/pull/1553

 Documentation/gitignore.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 4c17f2356c4..810041acd17 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -174,10 +174,10 @@ EXAMPLES
    is not relevant  if there is already a middle slash in
    the pattern.
 
- - The pattern "foo/*", matches "foo/test.json"
-   (a regular file), "foo/bar" (a directory), but it does not match
-   "foo/bar/hello.c" (a regular file), as the asterisk in the
-   pattern does not match "bar/hello.c" which has a slash in it.
+ - The pattern `foo/*`, matches `foo/test.json`
+   (a regular file), `foo/bar` (a directory), but it does not match
+   `foo/bar/hello.c` (a regular file), as the asterisk in the
+   pattern does not match `bar/hello.c` which has a slash in it.
 
 --------------------------------------------------------------
     $ git status

base-commit: 5e238546dc7a232d8998f1cd1ec9d3f4a0add68b
-- 
gitgitgadget
