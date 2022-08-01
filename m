Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F2EC19F29
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiHAVPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiHAVPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094CB34
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso2277329wme.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e86Lata680xF4IBrHAgj4iHEKpc70lcBjC912uqVMUU=;
        b=lNzGMCNAfSgNJyakvjqXPY3HjlKoac1Ztl7mHdpb/M/p3LPkLk8YbZeVYtnfnuyrg2
         ilNqIARdHX3Ab5t72pnQZagA5Nb19GU8NAcnQ/SETvy1CnpQ38h5zA+ufNQb64T1bfz9
         ge8THSMe64YZyA5KWPX2rFd6q0FpEs5A+Zo0fG7qpp03GEfHwv5l170VR7nWw/L6BUlI
         0OmJLysMS0kRCqC7Y5wozzVHwofYKJC92MkF4OsPoWlwYYP3AYhN/TxRejLx3uy0+4Qz
         kyuBcrjtS5txpU6CbcB9zq+1YORUkM2K176CW6zldOgvAWpbAaVVB4l91o1W1AIZWpVz
         tpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e86Lata680xF4IBrHAgj4iHEKpc70lcBjC912uqVMUU=;
        b=3IsI7FJZldqGI+0wjYmmH25+pvm73u7NaBa4aAwwkt6X2opTL66HzP+Hlu5qr2d0pN
         x/eZzc0BXKUSZgXwI/GlcTGedVTtVqOmpb5fxwWA0fegt8XuMVdF5c47jBpx3m1VZfBs
         vQXGR3KfvPIMroT02dI2rfO3BjAiuwrdpg4XzFRUl1ZBHTXqv8xwCFXe1Cvnjm2qcDyZ
         XJZ/eQSfjiJoUcm/w4lECL7CPwRn6VKxJvrm6TabcldSjQtFr+ClV0jwJSpSx/ZteJke
         dqTwbfR8Fyx6Gyoc/OMOBd+z3z2IXlAM1WpQ2e1PU8KQ3P0p3aHiaVoTv7f60RM7M/3a
         vnsw==
X-Gm-Message-State: AJIora/snOvEf28yw/crjkRrBnN0wHvBrDtT9VZ0w+1AwVazEUCjnQUC
        nbyCsw2UGGTk3U7HZr9mVozImF33vyk=
X-Google-Smtp-Source: AGRyM1uxAIzDMoEzHxn8iKhN3Qa8yNzViVTStXiF+yO5m3CffeGQqIYc0fYPfumDJbyDRgOC36FaTg==
X-Received: by 2002:a05:600c:4f95:b0:3a3:4612:6884 with SMTP id n21-20020a05600c4f9500b003a346126884mr12593110wmq.39.1659388507362;
        Mon, 01 Aug 2022 14:15:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm7567407wmb.6.2022.08.01.14.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:06 -0700 (PDT)
Message-Id: <86d40a4bd15dc5f9198998f761f4c4cfa8f31e1d.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:58 +0000
Subject: [PATCH 7/7] scalar: update technical doc roadmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the Scalar roadmap to reflect the completion of generalizing 'scalar
diagnose' into 'git bugreport --diagnose'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..1fa2f6d5f91 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,6 +84,9 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
+  into `git bugreport --diagnose`.
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
