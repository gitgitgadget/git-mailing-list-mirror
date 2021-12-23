Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349393AbhLWRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbhLWRHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 12:07:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2529C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:07:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso3481043wmc.3
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+igZVruq9W9Ne1GB+hykQf046il2dVVa6A+wpiu3Yuc=;
        b=n588UIAvdIBwPgog0lBTUl0YcQy6XdA3wfW95vmhYdMbRWrIxf9huAAcNdP/x1mTNR
         e82+QG6hCoDy97LJfoQFzdjcN+A70dDrAhGo4PZduZ38VJFBv8QXAaz7j/pnqo1Ii1SX
         S+IFcqjEwuqhcQTmdMdki4lYl24THCsso2GjePhL+2Rsz/s6hjHIPb+4EqbZWaXahxIL
         rEH6RLtgXHy0/qqxGPgwZCobG0ATkufyLbhpHeLcaePJDXAOAk0cmEqxAOreTM8yak5M
         LGrN3lnQOhbbDgeOR/Tq40FMJBqoHev58c6aIjgUSJCt8xLPvdOfMS8cYRnC971nK9Pq
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+igZVruq9W9Ne1GB+hykQf046il2dVVa6A+wpiu3Yuc=;
        b=jvZRjPHWqiRHrnk/nVwiNHTY9kg2yn1Knv+JMbLopjPmO10ytFk5IocisEmjMfoTe3
         NV8U8LS5QYXmv8g+sulXLvRxZpjtlzDPfY4YnVv7FBQKpD5nu3u/jX9rFDcitg8L8Ue2
         NaTJSQ7QOWeSl65JdCdAu3x4eywdj/3w8v9MbqgMoHwiLUuNBnUwmkP/1z6HLavbgzSF
         nSG4nY+QDdFGiKYG1+GX+HzWYDYDaQReC+NgR8XZWYaa+cpiCe2QTxJNC5feWd5QElt2
         KyhRlE5N6ZP6Y+Je1gZGRdBD/GGsfO7DyM4D8fS5n2IWxqaJn4PnW93GYAbA0/UuKgPm
         07/Q==
X-Gm-Message-State: AOAM530tMVd+qGtGsuqopgXGAe5VeU5bE/zs8EAmSkh3mF8tIBnaobcS
        hTt1t4WIj7q90NTGDj+H/paswa01fNg=
X-Google-Smtp-Source: ABdhPJwcU8ppxb/vJQH4OmAs+fWBSedBYDthhZOvwbnHhlwkZeWdOPVo6a/y4C3UUop6V9HjTtaS2g==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr2244559wmq.64.1640279225076;
        Thu, 23 Dec 2021 09:07:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm4952414wmi.26.2021.12.23.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 09:07:04 -0800 (PST)
Message-Id: <pull.1106.git.1640279223893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 17:07:03 +0000
Subject: [PATCH] sparse-checkout: remove stray trailing space
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sparse-checkout: remove stray trailing space
    
    Reported at
    https://lore.kernel.org/git/CANYiYbE+1o-8KxY2UGaCMdZJEPtnbTWgBrcFf7E-_ra76=kWmQ@mail.gmail.com/.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1106%2Fnewren%2Fremove-stray-trailing-space-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1106/newren/remove-stray-trailing-space-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1106

 builtin/sparse-checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0dae44c5759..45e838d8f87 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -759,7 +759,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
+	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index]"),
 	NULL
 };
 

base-commit: d35954160a2c00a741e41030ff8449a9ae958439
-- 
gitgitgadget
