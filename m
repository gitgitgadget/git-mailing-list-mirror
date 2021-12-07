Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7802AC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 05:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhLGFFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 00:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLGFFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 00:05:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5349C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 21:01:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so1323709wmd.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 21:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=R+YX1gSVjBYvymSF6Hpq7K3I4/2RIQFZUHZn4RnbAApaShdWBo+L4hP1QQRw/XVpGY
         xgTkiEPEOpynn90pCmSCKmIA7BEVRgZnU2f8jld9zc0ArFsF510as8vBD7V7OxGAa+90
         4krslQgHq+xQHZYsu+oj9tdGJdNFBBUUdecaWEzFVE9qouu/gy/ZE0Z4SAnLQasOLUqS
         k+fDCGqkjWGKFToPmGNy0NwJ9MyuygH/jYA6Dz+N+m2IQ6a7KPvlDNWw7AqJ36k5sql2
         hbRFuCt7B9a1UdQX54vw1gk3UgeN/ypIplCEi70FUp3zNHNx6IAr71lP04ByMuWaey7k
         ukrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=TdRViH5UFRGYQ030PnCiK9LjIuLV9bKTgo33M0eYCB1W+HQVTSkELTIGOkwwWd8sUR
         Ej1v84HyUEG3Mz82bHFfPNf3WVl280cR5vZTvyqEvIBFP3B5NAI5YYiSmwm+7n+xgCGs
         LXzSW57y+Ynqo5h5yx2iv5vR+liOwfe8G7rz6jqvw0RTfatrkwKSuMTBP6VMEYJJqoOH
         rD/eKReE92Jr53M8o+Ydq1P0MX34akmknM5Z+MEIuHM14zEGCJL8a+w7Q47NW71G/Npo
         SsUX8eWZfBlYYo1WD2VtuW7GKy4NoLo8BAmXQXca5zPK021V/FPnfV3awt+cn+pIew2U
         pQ+A==
X-Gm-Message-State: AOAM531E++tz7T/iRnIP8gNtyHs17uB07U0nzDFvwxsMmPFAW2bp8cDQ
        DT2/jpXluSO4G+/+gsvIXpJLVHJCk1U=
X-Google-Smtp-Source: ABdhPJzVr4Kk19seyf9etc1qEmk0wP3nm3C6QaCp6UgHQ76KiSYWBYWTpKtDwKXUmD6Aw7hWxdOn2Q==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr4013033wma.85.1638853298255;
        Mon, 06 Dec 2021 21:01:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm13608215wrr.47.2021.12.06.21.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 21:01:37 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638853296.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
References: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
        <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 05:01:33 +0000
Subject: [PATCH v16 1/3] doc: git-format-patch: describe the option --always
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

