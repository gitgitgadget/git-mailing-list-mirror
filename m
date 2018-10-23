Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A571F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJXGP7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:15:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41388 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:15:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so1282585pgc.8
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fj9sLIyAYq6QWX+SPVD8Ttd1q8ZtgtLBEtk21ZtH2Jg=;
        b=E5f9eacdBz+mktfVBxaa1M2WYzy6v5DkYsVBczFlTa9jBgbk893vTsgMpfipsxY//8
         Wu+r4teRBiM5ZNYlwCnyInA4/uJacU4xBlozMGB7n6xNYdGbYMcryogf2km1sXHy/GmN
         QMlXxqwxa5T9VtPSBekZMxdJTNFIDc18Q6nZOV7t47oBzc2biy1SOQ9UQ6F3Xx/G8v2F
         D5Cuq4HpJlev65Jj6Lg3978wQQzfijqi9qcxN0L9drYjLOMQQu0sB7o59K9zbtRnRhKG
         blOjgh0r+EG2tKZfXA0AG/uuChkk/e8PGLw/s8/q+t2VXdjCKiNfBDLWm65XfUTJRaGm
         n61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fj9sLIyAYq6QWX+SPVD8Ttd1q8ZtgtLBEtk21ZtH2Jg=;
        b=XZw9qiej5ffCqpAoY8nmlRQSm2WddSK/4Ai1ttGfKxsKm1whAafYyVrgcE7aMrndes
         5DsnbUIUkf9+Be9eWi5h2Ly/LTF8ouH9fwf/ZDxUR8FGILg1L7emx8rbLJmh+UZ0Y8y6
         vzyDIvZizTH6VBV6cjtWWlJaw/WRC92iaF/BzRg8kvpk5CYj980KNi8FifHTlxynnhz/
         NneB3jJBpOJgTJTskIxE4WtZcOvfz5YoAONRsL9/V46qEwEtfDq1qB1XCknkK+WUTXS5
         HevR/ELOw8fRAD88Ionx1rLXOYOAI3gmLeN/UEwEkGRDqvKfAOxPHOHRyUzzyWG+TH3o
         x8Jw==
X-Gm-Message-State: AGRZ1gKfDTVSoQ+1CYjdDn0Rs9CxgJg+JPTta+i+kMed2oTSxqfPNnoh
        Wt/2pnR9GfzHpfzJgzDbUHlfUo0LiEM=
X-Google-Smtp-Source: AJdET5doaLjx3+KgBdx75bZdoXECjoW0v2lrmasCryitQ9MIQdy6U8hOWfoyO0jlGE8RC/0XkDc1MQ==
X-Received: by 2002:a63:fa4e:: with SMTP id g14-v6mr42872pgk.18.1540331443423;
        Tue, 23 Oct 2018 14:50:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2766810pga.64.2018.10.23.14.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 14:50:43 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/2] commit-slabs: move MAYBE_UNUSED out
Date:   Tue, 23 Oct 2018 14:50:19 -0700
Message-Id: <20181023215020.18550-2-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215020.18550-1-carenas@gmail.com>
References: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
 <20181023215020.18550-1-carenas@gmail.com>
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
---
 commit-slab-impl.h | 4 ++--
 git-compat-util.h  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index ac1e6d409a..5c0eb91a5d 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -1,10 +1,10 @@
 #ifndef COMMIT_SLAB_IMPL_H
 #define COMMIT_SLAB_IMPL_H
 
-#define MAYBE_UNUSED __attribute__((__unused__))
+#include "git-compat-util.h"
 
 #define implement_static_commit_slab(slabname, elemtype) \
-	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
+	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
 
 #define implement_shared_commit_slab(slabname, elemtype) \
 	implement_commit_slab(slabname, elemtype, )
diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b24..e4d3967a23 100644
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

