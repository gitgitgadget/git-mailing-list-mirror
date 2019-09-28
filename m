Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4BF1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfI1UU1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 16:20:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfI1UU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 16:20:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so9271517wmd.3
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPxLbGLtTDRJFnnzqi0l0SPqUNy8CXqAnva3/jo1MBU=;
        b=tRxMoq1x2ejEIiO0oR0XfKq8BxECinji7nBYhc4tf5qSumgw0aS6oTXBXQSpLzUr2w
         ugaJQU/i046nm8CLud1aN1FFUlMYvfpHArss2E7ooZobKpw9COLTPbZ3llpIyEKXUfFv
         mU9SuQ4Xt/M1trTT0AHneh+AovWNy0pFxx3yzXQbX4vYyjI822iUO0Guu7BGbCSUa6N8
         pWnGOtk/V1JmTV5FdwE2IhZPpW75HbabX3+h9uKoD63Mrfj5mP/pnlL1I/vcyUDwVVaL
         JQBkSmGu9rE8pW8CeUBO/Nd0btCqF6BDjwtoHwup2Rpjj8fKp6qA1gBYlE//JkjNW7ud
         ZA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPxLbGLtTDRJFnnzqi0l0SPqUNy8CXqAnva3/jo1MBU=;
        b=JyRjr7kbZqLXcngpE3HiO9Txg0uKP2EpyMsSeXFIh/iIzwREpVRaLZnHHI2vN2CqUC
         LN5CJHUP6ket9QykZiidZWLnabUZmAEW9levhWGct2uGyWK0XhkZKOkfrnhc7Mmbt6M4
         b9A62949nKP50ubrlF4oUbYa4uOD8tFrk8vaQO2Op4b8MGM6kEiMl1/bWhkVQadWYylb
         h1uycgNaEiNAruGgYPuL64OwYl5q9GizJagAoNFsO1L0z7DqDUG5TuXiPxh1lOiugX78
         A8Qzt3hWEnDVHL8wQBAtN2dsVLeIuNY5cEWlwKzWoDT70JJ7tKjSAZJ2GwS9W6MxakZj
         Q0jQ==
X-Gm-Message-State: APjAAAWoh3qQC+y/TS4nXUFce2r2dSz+mdQSyVLA3GQAqirhwPwsptxy
        4RnHbX136Xq8RA==
X-Google-Smtp-Source: APXvYqwj7pxVqwx0rY/K132tBhXlyh/iePsbQ/Nk65xqypWxuuzpS/f9i7/6+VF8pK4R6IKQHJOtVg==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr11479327wmj.57.1569702025204;
        Sat, 28 Sep 2019 13:20:25 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id v6sm22566911wma.24.2019.09.28.13.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Sep 2019 13:20:24 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [PATCH] builtin/submodule--helper: fix usage string for 'update-clone'
Date:   Sat, 28 Sep 2019 22:20:23 +0200
Message-Id: <474b686ddb0fbb2287b43778f419772ed5f40192.1569701611.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.14.g3fe90158fc
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..89d6f02969 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1874,7 +1874,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update_clone [--prefix=<path>] [<path>...]"),
+		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
 		NULL
 	};
 	suc.prefix = prefix;
-- 
2.23.0.14.g3fe90158fc

