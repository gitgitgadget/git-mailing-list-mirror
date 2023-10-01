Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59D6E78491
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 20:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjJAUwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAUwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 16:52:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4FBA
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 13:52:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so160342145e9.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696193529; x=1696798329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGLvRiFvoafxVkJyHmKfRQzT4F6jo7fKeijfiaBYgI0=;
        b=FaOIbgRu4TwUcZSdEAPi2/yE5bpCdXUiW67QftqDPGXWA7ttHw0suZVK4usoy3qsHb
         z1dsdbIK3B7+ZZm+5GiRy4gqDmX+U+Z4h+qxKKhkljDiEjvjltI2NOKFEBkl3UHzsCdP
         bbwKUV2EUDXOwH6lvXZ5IGmZ7jo/CMzT88rCusawQSCS4CfbFp89yNhuqbKqPejR6jdO
         8NOHbBhzFjq6QyYOriNAu7Cy0ykEvIqLRQtqL/r1Kd/uFlP7VUWPiCaYIEVvrsLZEQeO
         h3Rs4CZgVDMbJaBk7mr+gGb5D2pfVAxv3sEEx+0FJtgyde7JzGGo5eHWsexmkpf2S8+Y
         eIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696193529; x=1696798329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGLvRiFvoafxVkJyHmKfRQzT4F6jo7fKeijfiaBYgI0=;
        b=pxBxYLjgI15WZDgUutPMGPj//MxYBkVofXibbCTfY9dSL4NloSd1RSXeVIld9yQJo/
         DyoJpUPgAs6K2NldStSIRHbw+fZ8f9E6oZt3EMvFwx/kbail8T1m6VukeHYednqk1EGj
         gBQ78XfTmw0TqluvJrA8hLnVlmZqJkXSMNUQLKLy/QvemXap3rP+OHu+txPVFofyZmWG
         Mt5zWyN4phCDOd7Zii79reYpQi1DlLOtwpxOGzDHwzM0z86U+LyFuaS8Fc95T8BJj5Xg
         bf08N+nPmmG5YGrqprLNwVCBYqaLbbnviIP1Y1K25OndoCsDrGpq7cNK6GzaEWesnP9C
         fn+g==
X-Gm-Message-State: AOJu0Yy/KDlgrztTJBsDevRfC9GcJ/oFLBmXmacPoXEfiNfYz7oURrba
        MplCDb4cGryLlMIgff/kPMOTGmbeQAk=
X-Google-Smtp-Source: AGHT+IHfp0FDiuT7+nPWzQQFCJ08IN08osOCuAmpbDiax+0vh/X3PxMHSm/SQXR1WgXwvmAyYijo9A==
X-Received: by 2002:a7b:c392:0:b0:405:4a9d:b2bc with SMTP id s18-20020a7bc392000000b004054a9db2bcmr8233589wmj.22.1696193529067;
        Sun, 01 Oct 2023 13:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bcb91000000b0040651505684sm5898081wmi.29.2023.10.01.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 13:52:08 -0700 (PDT)
Message-ID: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
From:   "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Oct 2023 20:52:07 +0000
Subject: [PATCH] git-status.txt: fix minor asciidoc format issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     cousteau <cousteaulecommandant@gmail.com>,
        Javier Mora <cousteaulecommandant@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Javier Mora <cousteaulecommandant@gmail.com>

The paragraph below the list of short option combinations
isn't correctly formatted, making the result hard to read.

Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
---
    git-status.txt: minor asciidoc format correction
    
    The paragraph below the list of short option combinations was hard to
    read; turns out it wasn't correctly formatted in asciidoc.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1591%2Fcousteaulecommandant%2Fman-git-status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1591/cousteaulecommandant/man-git-status-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1591

 Documentation/git-status.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a051b1e8f38..48f46eb2047 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -245,10 +245,11 @@ U           U    unmerged, both modified
 ....
 
 Submodules have more state and instead report
-		M    the submodule has a different HEAD than
-		     recorded in the index
-		m    the submodule has modified content
-		?    the submodule has untracked files
+
+* 'M' = the submodule has a different HEAD than recorded in the index
+* 'm' = the submodule has modified content
+* '?' = the submodule has untracked files
+
 since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.
 

base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
-- 
gitgitgadget
