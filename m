Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683231F454
	for <e@80x24.org>; Thu, 25 Oct 2018 11:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJYThY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:37:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42030 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeJYThX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so3649572plo.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOdCWqNpxYFrjM+KrqrRbVpTskwxUHd5G9MwRSbZiBI=;
        b=TpF4QUeucHDXCNa2zWbgPWUnkoj9S0+DqlpkKhuxwBW3fiXmsnC6r26BX5ULjToMEV
         iwNRwIqmJUBsAHb/6jDKZZ+QZOsifFYl1tibVrXD1VGAVEj532qL6XWcFVI2m+DHbiGT
         A7EQTNmZamKoh6DQQsXdgl71PRLHiDPwrvRX39VZSihlFg2+74nnep5BjX03RdnKf6LQ
         1ViRcvE2yHLU4cuLYiszynPST9G9lq9RSAnWe8CHSymW218FmIDaw0M0UQp/ZLhOKVgW
         uW2eC++3ikC7wf/cgBmbI8MK66fLkmslzOrxNR0wtysddIBkvGGYb7ChaC3abpVgkHxD
         YmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOdCWqNpxYFrjM+KrqrRbVpTskwxUHd5G9MwRSbZiBI=;
        b=h3zyOFylkeX6A/QTXkZJfGkOHQ8Q1NYrukSdwyqNi9Ef4eqdfWFJriw/E2/VvjzzDu
         x8zLphgbCIZMzSrRuilkXz+LZEqFx2IkJjsNK/vQHu9QF2W1fo3ltl82HYyDXgLNQ3Pr
         SgcDy2A+XDJvFshoAr2K5dx1Qn1rntYfOSr+Fh6ULgGyzn8R6kvzh+SUu3v2ovSPwb3s
         GHFJknGuMIYEwpNTXwVXrBX4fhLI8RamqULbRhk8zAeS0ygsrYqJmvMjfoSBgwuYhGFb
         OFF8fDfa3ju7pWn9f8No0T75v7tlt2svfURt7bofQw+0nxy/K66fUfFh2DxGy90x/T9K
         tw8g==
X-Gm-Message-State: AGRZ1gKIvhGbFw4w0zqvJcOONnr4+OsULf3Wp5fOSp+5Oxht3LQGOh0K
        HjuYJR+EutSmQRzwrdnLw5Z+04GwMtw=
X-Google-Smtp-Source: AJdET5eQmu4bIdmzsSfUKj/enQVuAR0lrmvyu6Aa0aYQXm6AVgyojw472y3Y/WLfIpoTgSFWEFAUSw==
X-Received: by 2002:a17:902:6e08:: with SMTP id u8-v6mr1096408plk.64.1540465507248;
        Thu, 25 Oct 2018 04:05:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 74-v6sm17545405pfx.182.2018.10.25.04.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 04:05:06 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] commit-slab: move MAYBE_UNUSED into git-compat-util
Date:   Thu, 25 Oct 2018 04:04:25 -0700
Message-Id: <20181025110427.13655-2-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025110427.13655-1-carenas@gmail.com>
References: <20181025110427.13655-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

after 36da893114 ("config.mak.dev: enable -Wunused-function", 2018-10-18)
it is expected to be used to prevent -Wunused-function warnings for code
that was macro generated

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-slab-impl.h | 4 +---
 git-compat-util.h  | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index ac1e6d409a..e352c2f8c1 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -1,10 +1,8 @@
 #ifndef COMMIT_SLAB_IMPL_H
 #define COMMIT_SLAB_IMPL_H
 
-#define MAYBE_UNUSED __attribute__((__unused__))
-
 #define implement_static_commit_slab(slabname, elemtype) \
-	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
+	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
 
 #define implement_shared_commit_slab(slabname, elemtype) \
 	implement_commit_slab(slabname, elemtype, )
diff --git a/git-compat-util.h b/git-compat-util.h
index 48c955541e..8121b73b4a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -408,6 +408,8 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define LAST_ARG_MUST_BE_NULL
 #endif
 
+#define MAYBE_UNUSED __attribute__((__unused__))
+
 #include "compat/bswap.h"
 
 #include "wildmatch.h"
-- 
2.19.1

