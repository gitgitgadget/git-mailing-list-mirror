Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF326C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiHPSJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiHPSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:08:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE3857EF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9254679wmh.5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=KUdT3E42nU8gDdcUp6WAON5T6yTsRVw1fLnjEJ63JxvvSBf8yHZ2sHihZXcMOvhCJ+
         lhdywFnGYmeSHb7iEwOOEMUSWG4sHybHJ8o4j2vA1DNr4Z+KJA83xJ43EJ9Dc2Pj1k0L
         LoFEIxUQFG8XmMpks9Rur+D/BI5kBNALJd33gMA/jYD8WvadZf21J28Ik5RUgBeHoKY0
         bXJcjAf14aF5HaUs8QHPCadHlu8My5fcYtFb4FRXbv6Lg5clL1D1rSQWHQaukI0ioT2n
         RNngUWyQ/sRfUMOc4oU5DuXNegHfWYnWBdeKBhNYXm6C6yu6EYYKTdnOen2ioPf/O6jY
         3VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=ZIBl1gZlyFGiOPRe0Ii9lZcUKnZrSd7oys0hkqKjVGDvGxUAOMkE1Cl9B43Zu79JkL
         lr4vmHrrNGnX4MefprimDiJfDbqm4gDEgeDKwMWTbbNGtB7JKbMMLft0qwKLeuAhldlQ
         ftggdcuQQZHnZv5NORt1Uga+/YiYcklC+hSYo2vKHDEyA0WHQ47+g4rKgpan0wNBwbP3
         kALb+HFQnc7ucAEEZVAXd1Ud1z/us7l9+PDANP0NjLrFsmjwjjsVdyJ2kEBjY18gqoCu
         AZCAzOBiTIpayl1hMocwsPp1J8/aNzLwzcd9mJ4lkl7lNu1yz4Ng1lkcjxuo5nhrEvXx
         Ha8w==
X-Gm-Message-State: ACgBeo3XsXiO8MGm+TIW8Nx2OvosMKrA4eUv4CvHxgbLHY6i0YPmVzeO
        7v/5fV0VHQkaDUW2LyW+wAT6UOaVYm8=
X-Google-Smtp-Source: AA6agR6q9Q3+/IJf4TkTLPXF7uTmmBSuqNRFnWxFXYQ69zBPhHIXCDk45iNrXumYiQSiCmsmdBDCtQ==
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id 10-20020a05600c020a00b003a5a700017dmr13979297wmi.148.1660673273272;
        Tue, 16 Aug 2022 11:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az3-20020adfe183000000b002207a0b93b4sm11318480wrb.49.2022.08.16.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:52 -0700 (PDT)
Message-Id: <5457a8ff1fa0c8591ed1a26da31c0bd99c1bdf44.1660673269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 18:07:49 +0000
Subject: [PATCH 3/3] scalar: update technical doc roadmap with FSMonitor
 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the Scalar roadmap to reflect completion of enabling the built-in
FSMonitor in Scalar.

Note that implementation of 'scalar help' was moved to the final set of
changes to move Scalar out of 'contrib/'. This is due to a dependency on
changes to 'git help', as all changes to the main Git tree *exclusively*
implemented to support Scalar are part of that series.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..047390e46eb 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,13 +84,13 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
+  enlistments. At the end of this series, Scalar should be feature-complete
+  from the perspective of a user.
+
 Roughly speaking (and subject to change), the following series are needed to
 "finish" this initial version of Scalar:
 
-- Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
-  and implement `scalar help`. At the end of this series, Scalar should be
-  feature-complete from the perspective of a user.
-
 - Generalize features not specific to Scalar: In the spirit of making Scalar
   configure only what is needed for large repo performance, move common
   utilities into other parts of Git. Some of this will be internal-only, but one
@@ -98,9 +98,12 @@ Roughly speaking (and subject to change), the following series are needed to
   repository.
 
 - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-  `git`, including updates to build and install it with the rest of Git. This
-  change will incorporate Scalar into the Git CI and test framework, as well as
-  expand regression and performance testing to ensure the tool is stable.
+  `git`. This includes a variety of related updates, including:
+    - building & installing Scalar in the Git root-level 'make [install]'.
+    - builing & testing Scalar as part of CI.
+    - moving and expanding test coverage of Scalar (including perf tests).
+    - implementing 'scalar help'/'git help scalar' to display scalar
+      documentation.
 
 Finally, there are two additional patch series that exist in Microsoft's fork of
 Git, but there is no current plan to upstream them. There are some interesting
-- 
gitgitgadget
