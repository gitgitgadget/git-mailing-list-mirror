Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED712C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 07:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhLIH3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhLIH3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 02:29:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19C3C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 23:25:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so8008187wrs.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 23:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=pa53swp55VjCF243fUXzmqxTO0rlQVYvm7blAEho/TFdpDefMlCHR3S+w6w3q/S/JY
         Kb53f3svzfpXdKXxC2ICsvs8HNkT/fGuv5urbJZI4ZPag49Tt6bVN+CavLsMyZVT0l6c
         1Od0FZznGCsVp8tqAfTWnK2+u8bluH/UWGZLWowyr9Kq/qpyKTtEnZvLNi9rnVbHaeXK
         j1mXLRfYXJs85JwItiSlGKZn8t7GrChG0JHt92BtMbdojibKasw7sABX+ajHE+phHr+e
         aK1wI6dzYefcd9U/m+2cLNzUkR13mcH0snQ8TDhMbt3Ew51lMIlbC9Jp3YFFY3QbM2Q2
         gF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=Zy9YEtNYJSO+BUA68K7RmlF9ntT3CoSODtm58yY5ni0SM87Y9P2KJGqsti8vV2hQnB
         lOiywAaaSMP6EPgXC1W73qq6RQziB7OTKXAiOST2rqBTacs74YL3DGI0CrIbNc+ZmWjS
         J6BFYgNJ+dwgYntFqlXfy+OolJxfc/ilbMN2RagBYtps6silHQ7hK+zWBJmoljb2eX8i
         kGKZflBZkFRQUFWyJU+mRvr1gWsezqh9zGh42stmW8YWk3EoMJywfe5tjRyXunysZaBN
         2VfUGBvMAHVHKzIWlyZUYVIentPk7N4X8po/tGjRg10dQu/KDS+BTPrJpAyuXSn+idTB
         fOAw==
X-Gm-Message-State: AOAM532vq9N7EuT9LzaD8F4FRonRyVnJiIPh1BOOIAibO9cjbNZmFydT
        EysoNHhqAy9eskHarQ/0cE672dSMDUk=
X-Google-Smtp-Source: ABdhPJw7PV9ps39por4qgkR5uuzUVy8WZWR4TQQXqkAUpL8n5EOkjpnxfZyoGxoP7v7axITugmWXkQ==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr4606630wrx.292.1639034758047;
        Wed, 08 Dec 2021 23:25:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm7622743wmi.33.2021.12.08.23.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:25:57 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 07:25:53 +0000
Subject: [PATCH v19 1/3] doc: git-format-patch: describe the option --always
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

