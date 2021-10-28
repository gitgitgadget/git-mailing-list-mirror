Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711FBC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CB4610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1QYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJ1QYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139FC061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d3so11177146wrh.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=p1ahdGu13XL0fyH2Unz47nL2oIoFyIdM8BeaWqqajgY=;
        b=c0Nsif24MEPkLFjpPLS5jqHrD9JgASl3vomd7u4L0HNVkFChDzqOFLdpPKY2Iooymz
         Gy8r9yoj0MDTtodKPXGN+wwoTg4dSDzG+idG7fhv86WQxQ2YTyjqNC7JDThivUDUYHyq
         oFbqvZ+08jVJ+7563Md36NLGrjpEs3iuvnvVFH2aeTUlTFfsNwX4eXzOafMK1z13JRyK
         577Wdvx/yLsf/pgpyuqOD5yr2PEeWmv4z5Ze4qVsze3sneX0hSZi2WMxw75UEtPauU+9
         mNb+JUWELUCP2zyVFB3mdL5KjNWm3wpUkcnff6vKN+G5hp9w3Jkes6tNyNtyxV6A5+m5
         U9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=p1ahdGu13XL0fyH2Unz47nL2oIoFyIdM8BeaWqqajgY=;
        b=zoctKKqtU2Om0jAYWOXzDLTMCmqotZ1Wj+m5QO5xIKWZ/7IO9QAjyveoGyZqvwjpuy
         XLGY3SBloXiMPljpbuzeWmYqNJ2jY0cpj3WoVbBe7gJgX3s6jJrYlfcfTjP34TC7p+aN
         DlZEQfXvXP3wB6kWP5j508G/6w27NBHwWuPjQJFTfUhbJOraBSWu0BZahiHaITPPKgmw
         dSUtUlz3PH0syDGVE+KmnAciZpNzY4EdkGSkmNNHtO+RV9qDa1r31f64e5us8EE3ZFxs
         RIqELUUDkF9kBYnBH/iDXee7H/K/LIbW0HDhCOOq5dzRcdfagDzibX1DynDDsZwWryOu
         7L9Q==
X-Gm-Message-State: AOAM531BVBGKhUQp0yHBLqsxDi0USESMqzPZBTg0snxtJQM1Kkr14Vus
        kWLLbSTJtGq/ifA+fu8JOdBJeHm8G7Q=
X-Google-Smtp-Source: ABdhPJzCKtWOK4liHmZFPCaXa+WwwE8bvBIC25NmPcJcszIeYp1a8WjvrP0I2zjZaS2wo/EzNOMUUg==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr6951951wry.12.1635438126347;
        Thu, 28 Oct 2021 09:22:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm2964829wmq.0.2021.10.28.09.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:06 -0700 (PDT)
Message-Id: <4d1fa80d471e02f79803330dfff886e400fffdff.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:56 +0000
Subject: [PATCH v2 1/9] doc: fix git credential synopsis
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The subcommand of git credential is not optional.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-credential.txt | 2 +-
 builtin/credential.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 206e3c5f407..f18673017f5 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
 SYNOPSIS
 --------
 ------------------
-git credential <fill|approve|reject>
+'git credential' (fill|approve|reject)
 ------------------
 
 DESCRIPTION
diff --git a/builtin/credential.c b/builtin/credential.c
index d75dcdc64aa..d7b304fa084 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -4,7 +4,7 @@
 #include "config.h"
 
 static const char usage_msg[] =
-	"git credential [fill|approve|reject]";
+	"git credential (fill|approve|reject)";
 
 int cmd_credential(int argc, const char **argv, const char *prefix)
 {
-- 
gitgitgadget

