Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D38C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiHRVlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbiHRVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47816BD747
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e20so2655673wri.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=K7DGYUmKzU6s4FHSvg2YMWqxB0namCMuYiK9antuTUYlun4+GAdcKCMTVfp2zj7NZ4
         OAz2ZeJK32DP0yptzx10o+o38Lk6NO5oyIGJECki1at7Uqk4m2jO/OEcv9479Ve1hgXZ
         dbAhTr1kBjGWD/YElqV/x0XO7A6j9qyCp7XvrMZDkwhs4yNV0H7CfovTqPCb0wm/TNI9
         pCAS8QEmj0A6RwHp6xz+1DW7ow52uUm9oXra2z0mSLJOrvzWtas3sdSbHo6FY7SFAw57
         psya8OQ31CfmZhUBFLRadQtLYgWt9J3NuRo8DO49zgUOxohDyRhIdhajKUQqzVLZMlns
         1tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=kL885cxRNe9VsGlM+52MgcxmaX5vu+UyQmspQmujgHstuMhPCROOCSdaHgOcTpeS3l
         0t/rl6T5yHo8CpQupkV7QHPBACudb+dTgFEnonQF8XgiP26B0wdWNYs1veoipLTTPxSK
         H89rJdylxe1cvNbdWsnZxSzDnjIli60DmQw7z1Lg5wIts5aCe13JZVltvSiGQRHQ7/2P
         XWknrTRnluwg86/7kRkHadSO2oa29RwNhPXtqOQQq+LIr5RnQpYDNYkkYDvvemXi4BsP
         mxDGv96UMLzEFrT2w4DdvQ01Yr/SXoM62SXgwigHYWXpaeVFXspJaoFtbBrmNiUNfPI4
         3j6Q==
X-Gm-Message-State: ACgBeo3umVLJncxJH2v9t4FGuSBDRp+Nat80TPV+4CnIzl8rpEUrV/0M
        F6j4ErLbjYXdp4fL8QdIOjb2xvtzknE=
X-Google-Smtp-Source: AA6agR5kvaXHo0IePVs/Iv3Mr9cZvWCvMYN0i08Fqtj2erz0fa4e5vjL0jKdMSY7KRKJSpTAAnFKWw==
X-Received: by 2002:a05:6000:2a9:b0:222:c186:caa5 with SMTP id l9-20020a05600002a900b00222c186caa5mr2611718wry.91.1660858862578;
        Thu, 18 Aug 2022 14:41:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22-20020a1ce916000000b003a531c7aa66sm3407435wmc.1.2022.08.18.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:41:02 -0700 (PDT)
Message-Id: <7cee014e2d2b9140a81125928d388af732783143.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:53 +0000
Subject: [PATCH v3 8/8] scalar: update technical doc roadmap with FSMonitor
 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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
