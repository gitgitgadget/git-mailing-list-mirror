Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412CEB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjGHBGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGHBGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5E210B
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso27987395e9.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778361; x=1691370361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0xGg/Pj9pu/vHv0MSUzGT3dYnt0RDFuv7KHk5qxr4JU=;
        b=CJ9WwCg9UBJvvi2VbolKjoq9NebbXMYGJfrWL4IQyqFUZSw2ZXleq+AHiMmuD2fYHd
         8nOMZSpvIA5stV2Z6tB+2AXOvhxekNd70b4axMAXNrYXMJRgFw60rPebJT/Vurzc+RZy
         1ZmLqav/J5+GM1Ec576G/5yQzof+2NJ19Ev96DkL+VUx4uFBE6tcJxhKxVFRG44NzL/R
         IM9ud1XxLaw0DqKojE68JC3SSX1CoP9I0RPn3szJM96JcZe98dGWZwO/NxLjsXE+CNKV
         7GcFAHn6L77Zn+qBjkRLyi7e2Gievc2aArSIYRx+Kfh1E3i+MZhchNE99KJMWu8KuixW
         +mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778361; x=1691370361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xGg/Pj9pu/vHv0MSUzGT3dYnt0RDFuv7KHk5qxr4JU=;
        b=aETR7P2dGpWnkVSCAmvjWReNp+FJUVHq6JE2g5P0135CR4bAUs6sqJLyNAKvQQFoHo
         4n/gVSCXnSO5C6tLhk537RFW3fl77r5GGXzWv0HS2QhYuBmL1MW5ym4QTGnBbMuyU3uw
         k02+hMkJYrBHHr39k1MPBtrhPCv/rgUPkOs+9n31FyRGU+vZbZpkKcDY1nVwxjfVT0+9
         P+TUi8IK/S9raIz8wN753Z/pMpSxfP9GeeUBKx+t5vNEdSsUXGlaI9A3KxgS46L1/aLe
         arMeNU5vsXd5rrGTPEFHduQMbF80unnEHALQcCeT+v/NSKJccJhNjTRWfnUGvn2xsF8v
         pbag==
X-Gm-Message-State: ABy/qLY5SE/CzMYTtBay1Z5eTVeOM4JAxT6/ixJByLrME4hhm/m0PAB9
        yH+SZZTemAGFtrHH4GYZcAbjzmPBTtA=
X-Google-Smtp-Source: APBJJlH93xxmD6tdAzapO8jPopoaLSBIcpOPyeambBU2yVKeIztePKsPf+oNxkWCXt1bTRAj9tkbMg==
X-Received: by 2002:a1c:7417:0:b0:3fb:e573:4172 with SMTP id p23-20020a1c7417000000b003fbe5734172mr5411003wmc.31.1688778360914;
        Fri, 07 Jul 2023 18:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc859000000b003fc06169ab3sm401263wml.20.2023.07.07.18.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:00 -0700 (PDT)
Message-Id: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:54 +0000
Subject: [PATCH 0/5] SubmittingPatches: clarify which branch to use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series rewords the "base-branch" section to be more informative in
general to new contributors. The main motivation was to remove the phrase
"In general, always base your work on the oldest branch that your change is
relevant to" because it was somewhat misleading from the rest of the text.
Other smaller cleanups and improvements were made along the way.

Linus Arver (5):
  SubmittingPatches: reword awkward phrasing
  SubmittingPatches: be more explicit
  SubmittingPatches: discuss subsystems separately from git.git
  SubmittingPatches: remove confusing guidance about base branches
  SubmittingPatches: define topic branches

 Documentation/SubmittingPatches | 34 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)


base-commit: 061c58647eb4b3f0e2c898333577d4b2af115b1d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1556%2Flistx%2Fdoc-submitting-patches-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1556/listx/doc-submitting-patches-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1556
-- 
gitgitgadget
