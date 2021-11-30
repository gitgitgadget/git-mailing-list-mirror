Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A0C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhK3Fks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhK3Fkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 00:40:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1515C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so41592069wrs.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=FsgiARkBCurhl3JWtwI/fWR4hidev2/sAueu0GcLv91idYKA/1oh+KhYdBM74El/C6
         1LesPPGB3jXsYnATVSyIRJIRyt92Og3550zSsY5FzKL7CA8oPzP9zI1gmtlTN5PmrVC1
         AV9p9peZqhEXEiyqXwC1MlxwPLCBBa/hU1YcFKslMbBtWJR88+WeHKPKuAEn5Ksc0ZlD
         STE/PPCa4XZb9ethRFHhlqlAUdHnSFEFsAlcZwm0n3i5wVT+ypsQkVx04bbdiVUSgQHq
         G4T9Y+i2KYsfpRhtspcnO+lSSStK3DYMK3SmOlCzK8pNQMBv1+xgEPHkCD6uOiGzaA/e
         gtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=VTL6AL0tHmbbR7mO+qQnxdr6rLtFmsryd3s663j+KzJiZyOoz5jnyGytnC9/CgBx/+
         mSkE5OLh4/573UzaSZnxVkwKrxq4y5pOfhjNyO6Jivpu3gIfL+m5xLdUlmkmb3ILmkbl
         aw7UTX/W5/b+znZPTyfWiXbURI4W8ldpk95zoRgXtEG3FYMbhAKF/17c6amaDgnIC2/4
         c+ayjTeck2FafqsLvSUkn7OtL5Clpbtm8zRHv+VrQydjUhGZJygD1Ecsni7k6ZfM2K/i
         NioKtKosx9/Jm15sQBdr15ZVWJuNn4G0wC+t2SfdLUPbQyX5QKmhxNpGU+6y83vZbnB/
         +2+g==
X-Gm-Message-State: AOAM532SjP99fFBTgAVt/VbWe9AjHOgOaMYMW5YZfpCxhoDu8EeOyme3
        lMXvzsbius6h+0YKJ5bZdBQkZehz3eI=
X-Google-Smtp-Source: ABdhPJwV1kY9k35B1/c8r3fHyPVsRRPXmVSo59zIZ2/Z09L0C/iuFzWOtJXhKlrbKw7WBsIiDXUfRg==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr10859791wrs.581.1638250647372;
        Mon, 29 Nov 2021 21:37:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm1244433wme.39.2021.11.29.21.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 21:37:27 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638250645.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
References: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
        <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 05:37:23 +0000
Subject: [PATCH v12 1/3] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
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

