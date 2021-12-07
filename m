Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D173C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 08:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhLGIf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 03:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhLGIf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 03:35:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1313C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 00:31:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so27771031wrw.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 00:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=qCNYkthkvw4QSiD2TTdffmnWc/SXi9w16htu3dhu9W0C5ZQ64Ij++L8Vyyd5vahGM8
         +devWaJX/7JtV+kBcIm1xmJ07KWN5QzESAe0cRsRH0J6t2Zwoa/OFq/D7VZO0J9+JZ7t
         XbVFmVfO7VgYlQ36Ou+yizYRA1GxTchWI78eF5OvlS/XjY5U0TMhOZ1uFaO8XAY1t+PL
         vJhb7mLR0rWs/jGFdtplL/OfDMY07Knc2/4KsEzerD4VtJJHeo/pAdpM0BPAQ4MxFEll
         oDDaojal3B2kWRL/Wwv4wjtY+tZYIPS0OeGdl8vsMYX87h9YXB4xguhN8I5U9dD0hIUv
         mF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=wR/mTeZ4Qns1zGC3t2mAWe/YcpYIfMlHeLyns6MEnQ8P0DZXpMPfTdHTnJHkkiFTFs
         KYGxO/G0jSRioOr3+cHsGCZOdVeH+VMH2+TQQF9d47upmC8EYevZ/tbb/Lkp0707Wzy7
         eoukafI5TTPqAezNYY9G6s/30JPXIU8Cc8IudVyys4OgpS0puq9aTbnyexn3cyVd4+KJ
         mFyANdw8sgGCsdjXQdijtX7kJPLHcmS0nQzaprhbU4eM2xhCeLeLbgVVxcvPMIcRK8eP
         KEG+8xFUTWITaxbd8tk2CGMFvw4jG97t2DACOMsVhNa3s/5/Yip/N6XVAYy//CFImqaY
         RxHA==
X-Gm-Message-State: AOAM532o+i7PEwQqS32MpnWhHb2AhE+Vvzh0M/5wuz4/M7NiEozZxhwl
        FwffLpo810b0w2N2Jz8JimFZjQc1miA=
X-Google-Smtp-Source: ABdhPJz6X9ECZOP0GMG+7X34mMx3UrjG5MIbdBNNr1leHQaNSivNzG1TCbYwuQvlVdn7wGFXHmxDiA==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr48967549wru.182.1638865916336;
        Tue, 07 Dec 2021 00:31:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm13641770wrd.84.2021.12.07.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:31:54 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638865913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
        <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 08:31:51 +0000
Subject: [PATCH v17 1/3] doc: git-format-patch: describe the option --always
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

