Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4AAC433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhKVHy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKVHyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:54:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5ECC061714
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:51:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so3883465wmc.2
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=U+7lZBAkso1pD4vo0mcR6XahjJ0cK3/FwsQtjNOLn+M=;
        b=aSeyWMmcC4GyUYmASrX6Cgt/B+TKdnyQ54zFTHDGB5Cinus3orLDW/fzy4p8TBKcLt
         vhLOmrp850G+RLH4TroZtfrSasDeOYf78ENa9jBYUAb861wNExu41ElWvTmhKwT37ny9
         sTU0nMUl2EDvxuqWeHeM82TMeAc0B8n3dZ2LAq/5XupioChqpUTar0UVcQL2sQuVaErP
         tXYtRKQQMlx10A9FtxGAG0zwlLM9NA6odiXJqUEd+rttGgAEkW90qF3DxP/3uvVCLVWx
         EsJIdd8nuLujcm24RO3aKLdmXTacWHB7SS6PxQPL6SUuo3pg+K7+IBjwW0UFgLd9ha9M
         ZhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=U+7lZBAkso1pD4vo0mcR6XahjJ0cK3/FwsQtjNOLn+M=;
        b=WWdCkHHDch/uE7BwiGl+EFkxjy4beZeF538P6kGTxSW0pl/BPVk460XdXuUqhWXNWD
         WZgBRkrfpYSKFzDtwBK7Z9myhq+ZC6dVg49bbLMyRrWOtWd1sVJ0dmKYEzQzXBLNQ7Hs
         VIOg37VnFSvobAoHGwtpLHKWGKS+OV5FsDN38EJkKJufX7HXZYF0hj3LAY2zrMS8L/LU
         r9U+Fa7+8LCQJUdwdgdoBn38hqMy0uhZRgaInXCQ9Rqs8MXOQ1+/qfRT3ie7A6CzP6eY
         etCy/GNwbXjNVNxfHUgywCR0kJ5GMT/2tVQ5c9kI+saSJXAJbnZhqiHB1EB/YNonYaMw
         4tUA==
X-Gm-Message-State: AOAM530Zz/QSSMeRBwaMaRkInLlFfVhdm7oqzMADNNXZx5Ul6Q0Ukrsp
        lD5McjcFGEr3P9zRUya9O6nFeXRsrf0=
X-Google-Smtp-Source: ABdhPJzOms4tqS5ztXuCq5h1jm/SVmub6MR15J2IV59z13czg7gPS5lT/AHtjL8oGviV7jeZ9RiFbw==
X-Received: by 2002:a05:600c:3788:: with SMTP id o8mr26579454wmr.82.1637567473255;
        Sun, 21 Nov 2021 23:51:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm20885245wmb.7.2021.11.21.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:51:12 -0800 (PST)
Message-Id: <59bce7131dab858e8c87944ccb02eae8ba5fd459.1637567471.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
References: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
        <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 07:51:10 +0000
Subject: [PATCH v10 1/2] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

This commit has described how to use '--always' option in the command
'git-format-patch' to include patches for commits that emit no changes.

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
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

