Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C1C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 15:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhKWPaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbhKWPaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:30:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F5C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:26:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so3049667wrn.6
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=X6RvIVN6zk9irH9qCWkZDlctOhQMmvu+z8sO7S6cd3poJ8xqP2WmuY4Djmuv3mXFrG
         ofebap6g5KKoqA1NZWMLt8qqAwV9ScOUaWwyxLkEQIQbVKZFbDq3VkiL4dejkvQpSFUU
         yVnBkOOb8P5esmcz3tVvILMFoSuJNQ2P69atgp+/MGcqbkK+9Vdoe35McD6nxjhuZw/3
         MOzdSXf3wuGSz8/KgOq9n0kOHn4/ySx2jQ5296KjBn/kbveqP3QflPDltZ+/5KKVn2Kf
         TtvrxYGMrTdfsLZqNL5pf8VGCrxJTkas9Inu/cIsfAWRvjlz40OmPtlWFId+imA+0aCU
         /wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=5oWeZmvl+xkhE8Fm4I4i1RLfzEyFWoaP/zpMuyB4bh+V7fTMpAZOvu9Jpdkr+pLXDT
         Y1ynnh1/BCe0huYYuABCf0IdO3spTtK0bwz5WARXrLTSabKsk0Eq3ZENx7/z7fzUfDpr
         6rABhRHo5YQEQP2jXywhUUvlz8pJbYp46KSKcbHylwOglEJUcAaDPCFYjtrJzP5UWXOH
         ZCS1F/Pe4JzJ6emrjXwCOUPEbd9pnIBh0Qf6Rz90DLudDg11IZlLZr7urmdSGm4xh52K
         z0GLRXS1ErCQ72j/VGthRFW61AKbFgLVEt/cnGe0U6WKxRJv+a+dG/75XQfkH1ZXrKHp
         u8DA==
X-Gm-Message-State: AOAM530UPoVoSFZ6ZkIE/cuECp6QoEmW+ucn21VJ3zH5aKwugHWuAp+t
        bqpCqQEoT55RinrVpjnoZo/lHmE2NT8=
X-Google-Smtp-Source: ABdhPJzpTtxp1PPa4sxULcJBwIjHW7P1EmAnqXRkDajoBUupLyO8B7AmUtKb/FUp/OSQkp8GrlXg6g==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr8004937wrw.36.1637681217776;
        Tue, 23 Nov 2021 07:26:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm15116149wrq.20.2021.11.23.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:26:57 -0800 (PST)
Message-Id: <3d7e96ce2b32096a6b900abe825b9df7b0ec3831.1637681215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
        <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:26:53 +0000
Subject: [PATCH v11 1/2] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= 
        <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?=
 <aleen42@vip.qq.com>

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

