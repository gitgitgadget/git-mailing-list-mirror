Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1035EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiAaWIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiAaWH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:07:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157F1C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so28124690wrb.6
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ig9w+iE8w9z4km8nv2RTHN3qRi3d5DdQnVZ6mGzMpf4=;
        b=A1mVexJJjAF9RJ3oKa4S96d7w+iNI50Zz1AqDgrJekaMOWbrSV6sIzYRDotaW7ZZms
         QgH5wlLEchex/QUWrZtTkkZvLaajDGq15IRTYqKfj+sZhWIkXvNpY1Jp+r3qnIA2+Tl6
         3pBJHATYwYTqLfr7ir1YsUuI+gdY1I+VQWUKrzwD7vQNYMIN/YyqQa+tf1Q27u/CoHII
         kU4QYv6V2qQ+JJF2l6vmvZmu4ttI6Oei6pcXHMDuierP6y87gplZZJWUT9sgtAShMcG1
         5bIjbbt698RPCmBwVlcoCqPS2DtC/K81PfU0crwB9VM9oUYy0N8uoa7mcF0tsnrp0j+L
         Snyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ig9w+iE8w9z4km8nv2RTHN3qRi3d5DdQnVZ6mGzMpf4=;
        b=lcKz2bn/yPtOr0/R3mSiAzdJNyy+z7J5TWpM3nimoFoRkcnP2N3Hs0nlGTQPLI+ITc
         K8nyctRXYo0nU91Qkv02GEDhEoKI8RZ8WcsNjgVJODOYa/ih9TftCspic9Bbk0OiY+18
         +ezerCTMCg5F4vNyzjt+RbVOR4Noerud8pPPRAgvWuppOGvFkj9VhdMqRKYeA0waldlX
         NXcTTP68tqQgyHo6XUg3g0rZ+PcuIXLDvGt2dPeSkEHVBPHa+dku1FK/FdHdbtQJa6bJ
         L6xt+ibWed7OLeYJfUB5qvidvnAfr6xI2Px4jMDVrKWP6/yLtaNQa0D297bDAXLwm77j
         XdCw==
X-Gm-Message-State: AOAM530cxJZn6n+62TSWFZMPUtxII6eay6Uongej/1Il1gWrh0FaoR3w
        vr8J2ZGI3XSfxQ4MvPvwCx5cC3G7ClM=
X-Google-Smtp-Source: ABdhPJz3ELk3YAV+1byrM9aUtVuFvReN5BgYq8pDyy+ePfp3DoORDv8KZy4E+l//MUlGXt3WsJ51Ng==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr18773843wrw.168.1643666874581;
        Mon, 31 Jan 2022 14:07:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm7134094wrx.108.2022.01.31.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:07:54 -0800 (PST)
Message-Id: <f37b03128b25a18e3257239d20574cddce791bff.1643666870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
        <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 22:07:49 +0000
Subject: [PATCH v4 4/4] i18n: fix some misformated placeholders in command
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

 * add '<>' around arguments where missing
 * convert plurals into '...' forms

This applies the style guide for documentation.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Reviewed-by: Phillip Wood <phillip.wood123@gmail.com>
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
