Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2402FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 06:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhKVGuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 01:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKVGuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 01:50:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE19C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso12721004wmf.0
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fN2giLhJTEe9srNs8cpKUEOdFG2xX4GVxwQG3a1bMjc=;
        b=Hu7kjEPgbtun5GztAmKaykDwuvBzE2Tvu3iU2STnXGAuQMOu96SCTWILZFc1qXOOs5
         TNpjT2SjlACpL1XEMfq2zW2voX/AArMeA/ctsPnv7287PmOuEvuMDYgF++ELQep4pRnc
         RBBvVfWntNg63AHXMk5nQDVJ9svOIJeP0KMa3BjuJca3536tquWxqCO4jOusPu4SgHsv
         2ALEVdijX0Jo/Yj9v85SEou9r8S6Rx++tZWGtbKAxr4Z7kDL7UEAR3IlDRyHE+mzkWAJ
         vDt7XY1HqLRY2clbVz+V4gn6YyBr2vBP/V70eTQF82doXR0Jn1OHHed0yrIyvvVfrvVE
         MFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fN2giLhJTEe9srNs8cpKUEOdFG2xX4GVxwQG3a1bMjc=;
        b=1nOtSa2dAE2/TEN9RrQiTnCPEpUGpaTqN/HCd239yy4rd5sGumfREZ6JBzHdHt/tsB
         YUZf8r28ndPAzBmzQdMSlahZnRXkOPkvkJRv5Y6ZN1pFbX6ty3imU0gtw6qleLmOvTJU
         HbAB4VkG2Gn63Vhl0Bu8pjiE5fMmPqnhjQeH6DWT8w3PhXoo5BmDKSSlEj6rLA9K3jZt
         EYksRkYObYfoTY5YseNhJfpxlKNPQH9gumiZ5scM9ItzCk5vpceIBg0qjoOUFYjaMkwp
         LkwnXft927y2cIs76QgW/IwU7Hgu7vpiMGmNzLwGDdgMuCgF/j18t0CERLi2Ta6pVJR/
         4Agw==
X-Gm-Message-State: AOAM530ywblksJ6JgVimdrRAnTCpNFRSsX1ZOg8SG5m3x901cBwn1qJc
        X+9r4ruvs4peJm0yjMjqLNw6SChH6rw=
X-Google-Smtp-Source: ABdhPJwkD+/eil17OlmQSOmm0KIp9mVPGutnIJ6eNT/Glp3OpJpNr4qnW6So6RodjX7c9fur8tnj+w==
X-Received: by 2002:a05:600c:3c8a:: with SMTP id bg10mr27202700wmb.106.1637563613901;
        Sun, 21 Nov 2021 22:46:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm9406012wmq.29.2021.11.21.22.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 22:46:53 -0800 (PST)
Message-Id: <5d98a088e143c59ab26c98af4f888b789ac29c59.1637563611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
        <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 06:46:50 +0000
Subject: [PATCH v8 1/2] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

This commit has described how to use '--always' option in the command
'git-format-patch' to include patches for commits that emit no changes.

Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

