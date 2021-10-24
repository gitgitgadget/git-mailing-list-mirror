Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBDC433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606E46101C
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJXRJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:09:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0701C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:07:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j35-20020a05600c1c2300b0032caeca81b7so2002467wms.0
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjS/vTILygJ71kOGppqN6Nh6KRec+qenUlyTN9EpopE=;
        b=OlJi08DpD4NWf8UCItsUeCzNVAcruqozD8NpgzOvfqXaL2sX7x+Or8vLrUYA1sU3YF
         9Mhs3ZO9WU/pAhbAj6qxvGl6K6a5lt3TvNfyvyGgRQFKcALSSXln5xwETalgeWxKVbGm
         eXr+vWQFrikZ8udiO7+NGt1yprG+zL8RxNBHsBqWbzyc3Fxps0bF23I6sTAOkrLLEk3T
         ZERUtVPRxtbOEH56Et1pSlWZt08TtxuyzmJ2w316Rr95VrRPBi4yMi1PHJ1UI718UuY+
         l7MiDdP+8qhZesSUF70Pz5/rlKBtWFX4xOlsixS0xqYRvO+sClQoDsyW5B4usyBMfMb1
         Aczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjS/vTILygJ71kOGppqN6Nh6KRec+qenUlyTN9EpopE=;
        b=ZZtjPAJr2huz0PbCOGZkAQwX4TNykE0HLjUYbnLiLsRyF96QbwY6dJJscZtI+0m2JM
         mfri3Pem4IB/brrm/2ZpAmkULZ2VLiyoxnbYV+rPLef2SrT9WKK/nAdSH00rKi7YuSD6
         e/Fw2gq2PhSGgJdtwLyKKqSefUs2W43yVMJpqWCrZkFIK28r8lf3mLsog8ahHxizDCsB
         fGAKdxLQgAh6b1CpG4uF2IyiVfI+ejhYAV5xwX3jETIXg8UaGxrkI+Fn+TGLReKHImBv
         fCORjjqU4cEoALxw/sEJnlcJni9gRSg11Bnr7+XRrm5DIcVQ3FjJ69cgdigvibI8JjtC
         9N8A==
X-Gm-Message-State: AOAM530DbQa8KNSutN2eKRMNFlECey2GthZraS2SJ6NaJhMmRryShqTc
        abAiaoTBOBQ0+H8axNsSkf7g/vf+kkk=
X-Google-Smtp-Source: ABdhPJwu0eP258nHPQcgqboktpCKpbVH8TMQ3jwE5I6dccL1neZgq00iyQQYP2KnymE2wrYwET/XTA==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr6751724wmo.76.1635095255220;
        Sun, 24 Oct 2021 10:07:35 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id v3sm14376847wrg.23.2021.10.24.10.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:07:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] command-list.txt: remove 'sparse-index' from main help
Date:   Sun, 24 Oct 2021 19:07:30 +0200
Message-Id: <20211024170730.3428123-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.1.1176.g03b4fe3d2b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since 'git sparse-checkout' was introduced [1] it is included in
'git --help' in the section "work on the current change" along with
the commands 'add', 'mv', 'restore', and 'rm'.  It clearly doesn't
belong to that group, moreover it can't be considered such a common
command to belong to 'git --help' in the first place, so remove it
from there.

[1] 94c0956b60 (sparse-checkout: create builtin with 'list'
                subcommand, 2019-11-21)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 command-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/command-list.txt b/command-list.txt
index a289f09ed6..eb9cee8dee 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -168,7 +168,7 @@ git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
-git-sparse-checkout                     mainporcelain           worktree
+git-sparse-checkout                     mainporcelain
 git-stash                               mainporcelain
 git-stage                                                               complete
 git-status                              mainporcelain           info
-- 
2.33.1.1176.g03b4fe3d2b

