Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB3C43217
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 22:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiA3WCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 17:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiA3WCA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 17:02:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5FC06173B
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:02:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f22-20020a1c1f16000000b003525bf08b1eso3729332wmf.0
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=oFoz9DGXaHe+MW2VYb1zryNG+KMh5AbDW5xYj/oMwSIeApP45edtplPsHLP1ElzYTo
         ZdN7K5kszV+vaquhP9RSfbq84sm5Q2iOjSDgLywBXlRuXGwKYzIY9YAMEhHmvrcVAtUM
         YRo+YYfkw0QYAwbCDAxqdIgHow/xxDkK9RXn7yzVJx7msehzN2D6Sle5aWhL9d0DNicI
         01vD67n3gOOqVlDeVG2avfXbhff1njexaE1ArAuwqtq6zMpLbbwHPXRi5jzYQjQFdfAM
         8kTEAX+vJmnHNJ5Trxul27vdNTyGySsIWuYdOoi/TxoTAFz2eCCh/1izBYmVyxvwR3oT
         Vcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=P1CmqVCkdAcF6ulnWfTBSu1OyH7BrgCqEd2nOp41YeQTSILxnwUpENTbxOgixcaYiU
         v8mECqNaDhgqczaqHQGEkLkP6IaCDWqEtAmkWKKfPwKL3yz55NHGYqNMd8ajv8FnUbc9
         E2xAE6/S4LOJbXuEuBoTIZhn+U/KgTxGwMjgD+djTv40LzduiS4iKg+jz0dhrNNy7Jlr
         YcIUsbOEn8cbg9LPcWGGToVaUTL9PcaUrK+zL5FvZ3oyjR+viD2ut3iFthjYJPBWonVI
         u+J7UHqhAa0erEu9FN64k5arJpJ1Hy6RVcrS+4vAa7e0v444xflGzfxT4IX1s4yikCbI
         veNw==
X-Gm-Message-State: AOAM530RwxHZiIJ+5RoNClll7y4IdgLY5oM2zBmm0Cuya66bd20+OPnt
        G7xORjJc/ehz6F3hymBNyj/U6h7890o=
X-Google-Smtp-Source: ABdhPJyB3L2dj1RJjDOHzpo8LUrRFV2yvighI3bA8d8vCSMYNR1ALfFYx+wtz7MCkJg1yfWffC9KJg==
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr24243282wmb.43.1643580118524;
        Sun, 30 Jan 2022 14:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm7905002wmq.17.2022.01.30.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:01:58 -0800 (PST)
Message-Id: <b8e80e178eeb2fccd9e10d783c7cf4b5f4cc80e4.1643580113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
        <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 30 Jan 2022 22:01:53 +0000
Subject: [PATCH v3 4/4] i18n: transfer variables into placeholders in command
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
