Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F165EC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0F66138F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbhKRKyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbhKRKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:53:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16ABC061764
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az33-20020a05600c602100b00333472fef04so7229259wmb.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=ElIGrUtuL4Tz7r8+Es03/rNCIW0uEcA3HRUH1tH+euC+wq/VLeaaK+hpqSMFfYDJke
         djRQHv2Lpl76/SCVrd+cqYbVXcGQEJokoef7OkO6BWpPfwwMTZ7m+GJo1ohzVHgPD1dx
         O12ryTpfDSfB+qNCdzMmx9MwJxJ60E82BbfT91C5twrKn8sQF1G2I127FRug2icrB5JO
         947KhAaJgDY6xXGS50d8vg9UGQPzUGH0DugGBOM25MOVHMkHW/4Th3RKFiB13g7O9e8a
         ZssKqsQMACrnNKubQ/QP0+toV4CSKTJuVdVVEnnnQArz/RHfiWBz1aAnq3wMqrtwTcQt
         3I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=BQ00uZgmC3g5G38lFBqy9vfD5YdZe7oGT2kwK5DXJV1p2veGq8Zbc6PmArU9yiQKYg
         yan8HWeakrGUIt7mhAJxJl6bc3prFJ5wPPrlIEjFkwueMBggT+gQ/LA8nQMDV5JuJvci
         VBl62RyHBNnI4cKysaH9n+ktpeEEulkCItnibhPiYVt8R/8A/LSgIWiCBbleh8ruSNI/
         W707WomqoKC6btbLeMJ+TjaodbhLAtRI+SNdeABZWVvcJKNir0VTCKuMn5rGegfTQy6r
         qfGfinE/6BctARZIirRnwkNfmMKA9+KcAl4l4SCmb6sBRoZHSrykj3I34tjaWb0pd6Xi
         MThQ==
X-Gm-Message-State: AOAM530ei2GdxN/aep2ZApeenvqU1PRVryqxcYyI9r8QQgBYJtRJjsKq
        th3412SLMbu+FCT2qn4hvCUyOUXP7a4=
X-Google-Smtp-Source: ABdhPJyTzUPN/gANMLfi85Ntw8iXYhKov6XBNCwyk0rrZ7pAvXAIqUIHAYIMt77vGfBGC2GoZKR11Q==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr8640603wme.18.1637232638168;
        Thu, 18 Nov 2021 02:50:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34sm9769845wms.25.2021.11.18.02.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:50:37 -0800 (PST)
Message-Id: <9f1b3dd6d0b2d3f22fe960b0c3aaa3d888d26c88.1637232636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 10:50:34 +0000
Subject: [PATCH v6 1/3] doc: git-format-patch: describe the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
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

