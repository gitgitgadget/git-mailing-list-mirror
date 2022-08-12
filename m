Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D21C25B0F
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiHLULD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHLUKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC210FDA
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so1006844wmc.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=VZ8GLFKo65Lht6bc4OIAa6XfjjSijGV5BjsLU+uLFFOArGlVdUAHR06dqNR4aeF3LP
         fVJhgS1mkseQWdNuoic9g3c6LQe5pi6o4PZr7LOO5PAEK6n9iQFAGDKRKO98EE1X9Cmo
         uKfAVksIK4vXz8E2qMiG5wYsDxn0W2v7JtSxzUhfI6Qh7lQuQa9V1va7wLaUDjqJ3twm
         3ujS9vI00GVaBkzJgyKb79SC9nDuyOEqUv7EjzMLVou55nPoHT3Q+BteoJ239SJPIwqK
         gvhVBQyTOVIOPPd6WPr8HNCkU+DR2yO9+HVCWSw4FOTJXQjM3ZqCLc7YWbs8LFt1mchB
         UbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=MfDuqxvcA2UVY2wWqNBJ+SS2h2MR/+CoOLBqOXJTT5Uk6LaKLi8sIgvLK2dnNdkjHD
         FVnGA/ALkm8meGfwADaK2V9RpXtoEJKrr3pjr7EnCGFMCe68NmZamQiSq6a10ctWSXUL
         xda6cCufvPymVgADAYKQKwzTAJ7Tctcrqy0wNRX9r8wFOESlRVSCdVe4KIDGRlzq41Zi
         iPsqa3OrghRWmwDRRHc27s451mGyuF/V5zYFtwcebClctF7HLXpqKikMz8BkGCd7TAmz
         YXxIXBAn7ZDSjws4XCagF9ogS2O0eecStywvxIoL3i/JSZWXrVk+oYU0J/8lEDAW1Ey5
         nnXg==
X-Gm-Message-State: ACgBeo2Qb9+CW98Sz36jtsRGiVKHKecKb2qD3M95R9QBxmSE2pe+/86U
        5s32BdhJ1A6P4Nvs7vXwnSe6h11raQM=
X-Google-Smtp-Source: AA6agR77Dc5ZBTnlLs7yCzU3pbgJXmOuNEy+7E1jeCh7Ed0fhAlANz3CKDL6gArAnM6YWo5DokDiNg==
X-Received: by 2002:a05:600c:34c9:b0:3a3:74a1:2754 with SMTP id d9-20020a05600c34c900b003a374a12754mr9892240wmq.35.1660335031914;
        Fri, 12 Aug 2022 13:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14-20020adfeb0e000000b0021d6d18a9f8sm279650wrn.76.2022.08.12.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:31 -0700 (PDT)
Message-Id: <728f8b81fd09a3d46f87d98a6eac38c46765d688.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:19 +0000
Subject: [PATCH v4 11/11] scalar: update technical doc roadmap
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

Update the Scalar roadmap to reflect the completion of generalizing 'scalar
diagnose' into 'git diagnose' and 'git bugreport --diagnose'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..f6353375f08 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,6 +84,9 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
+  into `git diagnose` and `git bugreport --diagnose`.
+
 Roughly speaking (and subject to change), the following series are needed to
 "finish" this initial version of Scalar:
 
@@ -91,12 +94,6 @@ Roughly speaking (and subject to change), the following series are needed to
   and implement `scalar help`. At the end of this series, Scalar should be
   feature-complete from the perspective of a user.
 
-- Generalize features not specific to Scalar: In the spirit of making Scalar
-  configure only what is needed for large repo performance, move common
-  utilities into other parts of Git. Some of this will be internal-only, but one
-  major change will be generalizing `scalar diagnose` for use with any Git
-  repository.
-
 - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
   `git`, including updates to build and install it with the rest of Git. This
   change will incorporate Scalar into the Git CI and test framework, as well as
-- 
gitgitgadget
