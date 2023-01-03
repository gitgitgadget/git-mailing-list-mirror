Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE2C4708E
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 10:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjACK1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 05:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjACK1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 05:27:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8410C1
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 02:27:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso16198874wms.5
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8BsX3Wk7Lkzq5h0lIffcd94lNs2btVl51fbahcL+XxI=;
        b=mVThPO+0JBtolqbcILttswvEeQBjwsgMKy6bU/S58YB1hke7T/NQP9DLfVsF2FVl2X
         HBHfmpyK+isyvymu7lUjCgtWikhkV7UEhvThopauFPsASbdNosOLG7Fi3/985DhynHAg
         mh5NqvfEvY3SPQG7TnkZzU6Fw2GIh9mFjbtUqMU2Ji7NzHKIvqfup+iOqVEGw6UqU2EA
         MYlxr0/DIm4WiIt2kplWw/5EWoH+cyT4d+gnkfpOaWiQJBqnATYUatezauNh/AnUEDLv
         Y2k1FOooR8s3w62MFTsw/37pr4cSgvvRSvPoAAob2kCyHxPbtz0aNBMkG5XRjbi0aOVX
         fz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BsX3Wk7Lkzq5h0lIffcd94lNs2btVl51fbahcL+XxI=;
        b=LgZdPPCibmJnF/p+Ylz3AjluDubwiVEsfMhP+Z+tmIelVlvsXVyJKgp1lDs93EuN6U
         PaUaTcAT7CiMsWQ+aaVYxu2xnP8JluX1kx7j66sc9uBjJzrNXyt2alaq1/gBCqutmiWG
         95gA03wb6Ag5ePkOTMvuu5ny5NEKBK5svPNYefkNayfN9ptrkRNI4nET4R08Yiu3csQ3
         ypHJi8PBZ7IDRwvJlduVlif0jSUkOa/72DzBzHM53A/VywYCaPlXsOUaCIfKEsNbghc6
         AgDhGIKUrl+WmSfcYVZYw4JLKte0zXGeh9XPJGDFBJ6lLdDp0AKFUbVMljaYzr/L5ywv
         bsew==
X-Gm-Message-State: AFqh2kr8o/wvFAOr84i/cShtvpd/lOr3cEYSaYSwRKK/D/CPjgvezBnQ
        JE6b6fb6aazD4sDiNYoY2wwBJj8SaJY=
X-Google-Smtp-Source: AMrXdXsKMxhiItx7KFnLUvIsETH4K2XAla/YIgWDOqKk72fj5agSJf23j2uQScwRd3Zg14eCGDdJmw==
X-Received: by 2002:a05:600c:6016:b0:3d3:3c93:af5e with SMTP id az22-20020a05600c601600b003d33c93af5emr30847743wmb.35.1672741641576;
        Tue, 03 Jan 2023 02:27:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n64-20020a1ca443000000b003d21759db42sm46434869wme.5.2023.01.03.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:27:21 -0800 (PST)
Message-Id: <pull.1453.git.1672741640587.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 10:27:20 +0000
Subject: [PATCH] ci(github): restore "print test failures" step name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As well as removing the explicit shell setting d8b21a0fe2 (CI: don't
explicitly pick "bash" shell outside of Windows, fix regression,
2022-12-07) also reverted the name of the print test failures step
introduced by 5aeb145780f (ci(github): bring back the 'print test
failures' step, 2022-06-08). This is unfortunate as 5aeb145780f added a
message to direct contributors to the "print test failures" step when a
test fails and that step is no-longer known by that name on the
non-windows ci jobs.

In principle we could update the message to print the correct name for
the step but then we'd have to deal with having two different names for
the same step on different jobs. It is simpler for the implementation
and contributors to use the same name for this step on all jobs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    ci(github): restore "print test failures" step name
    
    Ævar seems to think the name change in 5aeb145780f was unintentional [1]
    but looking at the original commit I don't think that's the case.
    
    [1]
    https://lore.kernel.org/git/221208.86sfhq6pmg.gmgdl@evledraar.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1453%2Fphillipwood%2Fci-print-test-failures-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1453/phillipwood/ci-print-test-failures-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1453

 .github/workflows/main.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index e67847a682c..126eac8239d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,8 +265,9 @@ jobs:
     - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
+    - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v3
@@ -298,8 +299,9 @@ jobs:
       if: matrix.vector.jobname == 'linux32'
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
+    - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
       uses: actions/upload-artifact@v3

base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b
-- 
gitgitgadget
