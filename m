Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B14C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhKVHFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbhKVHFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:05:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF69C061714
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:02:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so30709945wrd.9
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Yp+RfGdLC5MkcJx2FeMQSkAWg0V7cbYehAzo0O2TxZc=;
        b=lA77PRToWeAIqUpJFRMIOkVApD4U88Ekkerdam8TeGblbZBY/+LEOMal5SKv2XFP09
         n/S9s705grX1guOdguffQlpR9FgQZG4emJNRsFbles25rjON+41gjnDapcTq8PpZjPZY
         HjP7jAPHVKGHBR6yr1xva7E1IQYnrMRAFRmoHbbvee+iTROZ7xlP6Rn8UyNGdt9NUzt6
         Hn8HvwkIcUqDk3fB3MD8X6H3OpGDyZG3KiO26uMkU+J9Va9wRgct6eIHCLekRW9IuWja
         6SlTfWlMqUGgTXnXDGPljKfuMBM98EGOCfcRFu9LfYNuxEsdZBkzJuF4Lf1o58eSWicZ
         KdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Yp+RfGdLC5MkcJx2FeMQSkAWg0V7cbYehAzo0O2TxZc=;
        b=Dg/mi41n5nk6Po2TvGFJeQuqjCtbRSiDoUaijm2CxwtfYcNcqei2/ISGm0ez0NuTEB
         D5USo58K1OiOAdxowyyuJvfdkiZa5R58Z62diXZTQziKggEGuY1g+fguGQUnVOb+Jj+U
         0jgKYioul2SwEjZgpzXw5POg1E8nYZb4lPsWBqo4VmxwO+aejbBOv8D4/dVy/REh7sKE
         qdXZ9bfwKwQHUzLrzOHXA03N3xCwBJjTiAYxG38vutg9mBZq/bJZk4xOg8meHO8sm8SU
         ma98/AvTLnzpEe+ed9tqyE04ue4b7fi+k+dWp8AXRJy97Y1skttwFdnNvGeKVjzxM2t3
         w5Gg==
X-Gm-Message-State: AOAM5337GVp2AO+Vb4EVdN4VaGpGPzalbgh5Xkq0R0DWD1Dd/kqB8jYP
        oPux6TSM+MKNzVxdFHB6YmQWjPHDoEA=
X-Google-Smtp-Source: ABdhPJyqH4Vwy1jv5s1SagFkgxDAxpC7UtiuwruT9s7AI8zVcSEffJV7QBqL1S/B66x8HwTrzO9Xzw==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr35630997wrx.378.1637564556634;
        Sun, 21 Nov 2021 23:02:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm9426229wmq.48.2021.11.21.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:02:36 -0800 (PST)
Message-Id: <3b41ca3dec748a8467c99f051e9dfcca1091d6ee.1637564555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
        <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Aleen=20=E5=BE=90=E6=B2=9B=E6=96=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 07:02:33 +0000
Subject: [PATCH v9 1/2] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?q?Aleen=20=E5=BE=90=E6=B2=9B=E6=96=87?= 
        <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Aleen=20=E5=BE=90=E6=B2=9B=E6=96=87?= <aleen42@vip.qq.com>

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

