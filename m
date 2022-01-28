Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB76C4332F
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiA1WYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 17:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbiA1WYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 17:24:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21390C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 14:24:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so13223505wrg.12
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=LCMttfKaXrdFiHDrfVC/LYZQxATxXPJytXA8cXZcrhK0enp8uvioePgxMGFYDGbT62
         hKgEc42RdE6BVkV7tJXEJNl7Fgd1GuC11FJWA1PPHCJPXleEbZmWof4zZaNJ8kjyBzV9
         trZDXib+2ibeHwX5oPNXG1MPpV9oIop8Zf8qvMgr+7Wx2h0nUzW2pEzcAgNzNDTd0ikv
         Jl4ME6cvqwh93ZbmO2QhvduPzsoR+2z9+EqjQVXKlYlzKxBPT0rYKDmQzYsRnnGJEuOs
         4EPsemRatn2eSAQEyDtizDKrGAgezTjbypxiryvQqVKkHbdlMFquI8wuCqyumqti/HWH
         tpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=DwpRSylJVVEVOJgLZGDrP1mzzzsNjRMxY+3oEq54FVWekH8pXFHC61fnzHkAM8AEID
         oBMFPEsK1cRN2rupHgL/GSTSnG7sPAfzbbVPr2ibsJ3Em36WPU8MPUadG7hAH9Oa8RRu
         nhAaAshvTBklzhihSYR0vXvVq2cX8aq8NcROEsxyS8KjyCPvEe+9Eh73QbGzk6dFzsyh
         5T7q9wKxNxo072Qo3o8k7f1CIETHhI5Xzutw9Wln0oH59ArFMknZosFn+frqBtf9maVc
         mNOwiB4jl+fw/RSfPwz+TgYUFG/EVg9PoZJO4kG+EdIJr0Y55FsbhHaZ5NdQtrNec9nD
         WvkA==
X-Gm-Message-State: AOAM532Iz26zUqs+nSSarmwPzdZaDZjoEfFQLXhMK7AVlfBiiIBKVy0o
        GbrbH7Hyg91JN4cj3N9R8DocSKauBMI=
X-Google-Smtp-Source: ABdhPJzEkXB8sgTPfBEr2oEphm0wIKnfJ46MeoaYGNu5oEhPvw2MNna030XJDX4teyWF/AMDaKXBRQ==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr8472394wrx.318.1643408651638;
        Fri, 28 Jan 2022 14:24:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm2703845wmd.44.2022.01.28.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:24:11 -0800 (PST)
Message-Id: <8b0057f61807eca7da268670bc6796a0bc91bfc3.1643408644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
        <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 22:24:03 +0000
Subject: [PATCH v2 4/4] i18n: transfer variables into placeholders in command
 synopsis
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This applies the style guide for documentation.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/fast-export.c | 2 +-
 builtin/reflog.c      | 4 ++--
 builtin/rev-list.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f1c730e587..510139e9b54 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -26,7 +26,7 @@
 #include "commit-slab.h"
 
 static const char *fast_export_usage[] = {
-	N_("git fast-export [rev-list-opts]"),
+	N_("git fast-export [<rev-list-opts>]"),
 	NULL
 };
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index ee5ee8d8cf6..343a10d371b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -17,10 +17,10 @@ static const char reflog_expire_usage[] =
 N_("git reflog expire [--expire=<time>] "
    "[--expire-unreachable=<time>] "
    "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
-   "[--verbose] [--all] <refs>...");
+   "[--verbose] [--all] <ref>...");
 static const char reflog_delete_usage[] =
 N_("git reflog delete [--rewrite] [--updateref] "
-   "[--dry-run | -n] [--verbose] <refs>...");
+   "[--dry-run | -n] [--verbose] <ref>...");
 static const char reflog_exists_usage[] =
 N_("git reflog exists <ref>");
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 777558e9b06..38528c7f156 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
+"git rev-list [<options>] <commit-id>... [-- <path>...]\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
 "    --max-age=<epoch>\n"
-- 
gitgitgadget
