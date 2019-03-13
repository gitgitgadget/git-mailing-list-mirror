Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B3D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfCMTUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:20:31 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44864 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfCMTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:20:16 -0400
Received: by mail-ed1-f49.google.com with SMTP id b20so2526177edw.11
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+cWzBxcspPIbLQatGZXn0iceHlZ+TVbiKM0EY+YiwU=;
        b=u0KNvRQb/aQaQgnVzkZZsD44Ijh4rfYaz9DtXj90m6VYMPqZT8GfazaunOElJrj9ha
         Za1pTDltzMHaNrNuUX+ajV4aqkkYKPko8m0newgB+1ZJAmLj8DBzvBnACSn1JN29BW75
         xmdEv+PyfhwavfqJo9htYr0dwaoeSNAouiHyCNOjtJFGfKNHIon+a0c605+JRg1fSzSs
         sllRfnRXUfoViV/9IW4LHYvtk9BhY22LQMjUeoipHfnkPMjzB431QjsiD2i4EOG6rrQO
         VLSjNnf8/uUtUCV+GGXjJgLX+lgjTdfJCaJ72e4AvGZetY8AtxPDwT98t7YGC9kpE4iA
         J0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+cWzBxcspPIbLQatGZXn0iceHlZ+TVbiKM0EY+YiwU=;
        b=P4l7dbivzlTz3ohhncs9DNFJVx43Hg7ygZKfHHGkOBPJpA96Sg4G3Nww+XB7TtHe4a
         j0BeCZD2NoDm0qsEic6Oo6/Ri2exzVlCNjrVkeD4MtPtJS+6UizDFyY+zeuIFs6GjK/H
         a4fksIFCkdZODSF5zILif0EXPCwbYCrpPQNGYjV5qCxRlcRVQmL1OOJhz1/EptiRQkMH
         xjnLwza/rjYVOeL2qQX8KgYrSAoXuLvu4z0cHewFwGefIFgci+JCvPu2Tnkr7a67BqWh
         maWKaE8fIgH7NlM8Ks7w2B3M9B72E10SCLHLuZMszixvl84DX9aKDR/o547geAsTCIsM
         TjXA==
X-Gm-Message-State: APjAAAUTnyRGyYOlUwLXx6c1aI2khl+YXsUCVE8790Dxx/n8isSVmqQ9
        lIfR1XFkg6hoT/CfwUXOKVtUETWi
X-Google-Smtp-Source: APXvYqwXguihRe4d/bblJPzxMy0QxsmmmfNiA7ke6ZvSx0UQajHgY5hzbhZGCisCit+nXxb2Vq5Q8g==
X-Received: by 2002:a17:906:7045:: with SMTP id r5mr7293789ejj.147.1552504814495;
        Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm807822edr.78.2019.03.13.12.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 19:20:11 GMT
Message-Id: <2ad91f19c5b8c7e043e5944a1c075ad23612b59d.1552504812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] difftool: remove obsolete (and misleading) comment
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

We will always spawn something from `git difftool`, so we will always
have to set `GIT_DIR` and `GIT_WORK_TREE`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..31eece0c8d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -727,7 +727,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (tool_help)
 		return print_tool_help();
 
-	/* NEEDSWORK: once we no longer spawn anything, remove this */
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 
-- 
gitgitgadget

