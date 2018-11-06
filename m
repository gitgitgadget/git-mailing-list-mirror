Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AB41F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbeKGAV1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 19:21:27 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37009 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388887AbeKGAV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 19:21:26 -0500
Received: by mail-pf1-f179.google.com with SMTP id u13-v6so6221513pfm.4
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qj4EEt47Qwle/7t/mAtoxotz2y56psQ4Sa69kqEENf4=;
        b=BuTjqvMwsIj2BFR4BlTvNJtgm/1Ev9kvKYjsdS5TalpM3ajL9Rbr29eCFtBA+r+9Jh
         LB7w/xLA4Cm1Yw+YYsaPxIG9GE3vcmkymj+Nju6kcvaOBLFli4P62nlPiNGy9gV8WbPT
         s3pJ6/WvubaV2nz0GFjhz/WNSHDBa3SjsMW1XJEHKZIVXfYQfv8NtMVOntknSKTRUfDT
         +8ASH3HUH86DWOjuCU2esnI33RdYNVB2qpsTVuFLuLcoWha4eJjGCl5Ui0vv/iud1top
         pMVv06FE/qltjcCQZgqPUAtBWklSubuMp15BurX88GI1KAMo370mXiCIb4lhWN5obN/T
         mbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qj4EEt47Qwle/7t/mAtoxotz2y56psQ4Sa69kqEENf4=;
        b=PjLRPMYPQkAWieAodm0vtHCU5ALpRFVyfIRVAiTS5d3bXYgbyo7uhz8wCmKHHJzoN5
         wc7MyZrCSFymPXPu+hB6LseNu7dAV1jeFwNKOk4uudZ7rXGUABEHP6KxN6anwajdu2oV
         UWWBepc5F/SC9e6KvBoUjo/ZRXPYdUU522wqVm/67LLqKS4lPPywFW+FRGHB0IQF3m49
         7CCgA8WupyynLYf5C0q0MMeYp3UycSndszg0afHQ/lZFGvw18T4ylxu4HyipF74ob846
         C/fMromCIZE81zWx2cU7k4e+6UahdzqLjJARozCJqW/a3nIVZJMUjZbo0WDGUircJBt2
         NW/A==
X-Gm-Message-State: AGRZ1gKVTsooIWCl5y5Cfb+DvaukmZGaX6Cn/g1GhZr6Mj8tfQWc+onA
        tbjOL7UQpw3TEiCh4BEvG8xWJuZGtY0=
X-Google-Smtp-Source: AJdET5fAjDaphCIew+V4OKmBSzyyFeleuijqZnn48aNpZrVg63+izZsvPkL5ABPyfNTh7P+t+gKeqw==
X-Received: by 2002:a63:ff62:: with SMTP id s34mr14465728pgk.325.1541516151133;
        Tue, 06 Nov 2018 06:55:51 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 18sm11511506pgl.50.2018.11.06.06.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:55:50 -0800 (PST)
Date:   Tue, 06 Nov 2018 06:55:50 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 14:55:47 GMT
Message-Id: <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.67.git.gitgitgadget@gmail.com>
References: <pull.67.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Windows: force-recompile git.res for differing
 architectures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When git.rc is compiled into git.res, the result is actually dependent
on the architecture. That is, you cannot simply link a 32-bit git.res
into a 64-bit git.exe.

Therefore, to allow 32-bit and 64-bit builds in the same directory, we
let git.res depend on GIT-PREFIX so that it gets recompiled when
compiling for a different architecture (this works because the exec path
changes based on the architecture: /mingw32/libexec/git-core for 32-bit
and /mingw64/libexec/git-core for 64-bit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bbfbb4292d..8375736c32 100644
--- a/Makefile
+++ b/Makefile
@@ -2110,7 +2110,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
-git.res: git.rc GIT-VERSION-FILE
+git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 	$(QUIET_RC)$(RC) \
 	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
 	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
-- 
gitgitgadget
