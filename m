Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC275C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiAVSgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiAVSf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 13:35:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80CC06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:36:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so5927653wrb.13
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=kfmHcuejI6eIfSVS1pVyK4odGTOmJYXfhEVnzcAtWdsjedPYL/J/gbpAkMVueuoebX
         +hXBvGXYh/yDTqVaKG1RXyvrtmQ3orawzpP15KjfwBIz/uL70FJqsgd+pwFiXxbvumBM
         AvAaCsiTE3i4vtZubqcOfRGIenqCRAwSqOn3XyDlRqc4tLEnZq2MOrvx9gHY63KuaySd
         1U2n5ASysXsS9iT303SOp5ARtvgZWUQYXdng+2GAGDzCrpBf8BkyBkZu52YZbT+iyPpl
         5A1tJG98U1eQdnGnpcj+rSyTLQNR0WDC2N7y8no2zqsO3HRlRaZyD8D8x5kkkUywq2y0
         KuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=setLvCe/Tayj7BmI2ha2ddGllmm0sAEogig2gdBHmxc=;
        b=b2grjM0MdKzjkSA0LYXA17RXRP0G4kOob3JEN9xvfwlY2Cff+qLp2N39CpBn2fBLN0
         Nwre50iaK3Ead02D6FtkRcwsOhFQstEMyB3dz9fcBNcNzrvRwam+kyO/nCHI2i9HyxIU
         irqTndE32zqu1Ru8rgvnUKSDtl8P82l11Sd6eUssRvPdQf8Wp5H+4hf7/nojDeb6Kq7S
         b70FbVuOWRvYHrRJ7uG/nDlOmg3QqZOM/yCFugfo8hFd9TKAc09whQjlW5DFWhMf9UiS
         sMsV2VWtR7VyjlaziGph+BMChVZCVHVa4qw3iJgnrBhlcWbpEkA67EoMTfoObn8DArk1
         CQtw==
X-Gm-Message-State: AOAM532tPujuhGNy4h5JhdrkaxMlLAsgu5U2kkx3TvhfSBkOmLj12289
        ASdkUVB0kzYSAR7JCyxcqlKKzbvuMtM=
X-Google-Smtp-Source: ABdhPJyxrurMrRfOjEdn3Gbz8r+6G13lqmC0qYR1VDiNfhY3eX01TLKqRwQ2IUfYPCgcX8AjHjA1WQ==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr8298947wri.575.1642876558771;
        Sat, 22 Jan 2022 10:35:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm9532665wmr.25.2022.01.22.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 10:35:58 -0800 (PST)
Message-Id: <643be0d82de11a286229d81ad96638b155e57a40.1642876553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 18:35:53 +0000
Subject: [PATCH 4/4] i18n: transfer variables into placeholders in command
 synopsis
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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
