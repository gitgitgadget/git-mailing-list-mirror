Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D081C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 09:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhK3J6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 04:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbhK3J6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 04:58:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A011CC061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so22210347wrw.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=mXpheTkcy2yNisAAw0AGb8acrhhtboD9qeSnhWs2CQ5JASCDdjT5U7I4NPXzhD33/W
         UZ5ewgDlwGfLVqJwOmcPRxNdn2WnS7hRFx/hyd268Mab4gk+GNeq0itRgTQjWJpYQy/Z
         eKrYo1KsM52+1gQo6yYkHb+QT83AGRrmtHLqXkzKNlQ0WPSDSgB6iKok4/8Mpzbzd8Sn
         wX0z+IInW4H93kprJnpSJ4OmOv7QuODqJEhwPYIq0wkSy7FuP8NZrlAQbJYpT9txQxFO
         qHt587l91TvfAjbgWIXZ5dSFE8m+dO9w+e4qte4eY3ddn7C3zVax8UHPJ00aZUYqrTiI
         1bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=EboG77SEvnwFjioF01me/jqTqqyFFNDE2B4KVWv8J5kW1KI9Cdn2apVXm1OvjGeR19
         Z6IdU1FQ4rJSihnyb90iOPLcSrwwI8hvKyOT370nBVR+9k9q8Xr9T9Hks7snFqoKxCER
         hnNRnQD213iKviPrt9SWo8CwL6vEYX7VE8Khs+tsv2vGlrIG0iY38sKTnHXMl38pNqWl
         OVPVeYrYTyRZiyRFD/AtK043hhUZ/p1mZvRD3SRxF7uIuBhlVo4+36p+j971NvvRKHKr
         BCIiT8aRosng8K8ex45JJiVkVw8VdIdErtCMek4oYuInT12LLwmUIP94zs3TxwaDdMYz
         BlFw==
X-Gm-Message-State: AOAM531vZ4YOIImWF6Hp0kEt8rWzfp3FdiKpGZH67o9ziKbC+N4LwBLz
        KTktigNGJWnVrQkYHoIOOy3OA+zs/pA=
X-Google-Smtp-Source: ABdhPJyBfKHfG5u0jB1ElDba4MrMl4HBcSyNCgGGHrBh7+OXZW94yrAwClDrq3HTrMOi4bs5Z6SfHQ==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr39705620wry.407.1638266117108;
        Tue, 30 Nov 2021 01:55:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm1949564wmc.40.2021.11.30.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:55:16 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638266115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
References: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
        <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 09:55:13 +0000
Subject: [PATCH v13 1/3] doc: git-format-patch: describe the option --always
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

