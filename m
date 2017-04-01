Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A114F20958
	for <e@80x24.org>; Sat,  1 Apr 2017 15:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdDAPbE (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 11:31:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33751 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdDAPbD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 11:31:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so3984401wmb.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o1otxjegA/alHEn3FXXcasggrW9kaRJ+k8/IkBOfpL8=;
        b=hQzOYuWs+Q2+E/l6lb9yLc4ogYFuCs9Ox/a69KugA3vO1t3esfdAY0HbyaQblWe0t2
         6Y2GjhrlkhNv0guBlNBZ2f8n5CmoLUAVbD3Oeiw4UrPAchQ/LvBBIqyUsw5llVUmGQlu
         9KOc8/mJ/uWFjOWsD7dC6iMtWTW64cw2QI9Yogs0Bdnx00A55GOQxtk0oFE6PO2zUrjP
         /oVJFVJXICP7+EdLYKIQW8wVH/F8zGlEwZsTObJtRypDsUBDNEbz+vIcF6BzWhUO6o1s
         rTvpkRsCgDQEKiQoTsScyWd6EHoIhiadNVQvPDKLNagSO000QrBNX7tFpiHBvJT5xL+Y
         p4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o1otxjegA/alHEn3FXXcasggrW9kaRJ+k8/IkBOfpL8=;
        b=aeOb2kq6Au+422CDbyicu4k4PEaPBKOVfZRKaWHkArsRZVddWDrQgX8J1ruobqrPqn
         joZ9jp8VumZiFDnmZA7Ce31H8IBc0yyjR6yyJ4ySuXnAeJAyl6aFyOAEJy7pWbVr2F/K
         BRT/VghHjGPQvWzqDCuwS1jkwXxQovxGd9bMfQTAHc6bHjLeoZDJFYvBv4RKSwRUyF4d
         fk+8AIlZbIcZgzaR2hE0dW3fN+D/f7lUQI19OUFPVBtt89RZ44B6tYdaf9CTaAl5ej6Q
         2Xqzwpj6q0FtXJBPsJ8eY6MgY2oR0IO+fF3O7S7QANpFs4Q5uGF0iIiJqR/uRvezXDti
         dtPg==
X-Gm-Message-State: AFeK/H0cABkQICI3pgtKKvC3Hkz8NUqfEMuy/CT1/aXdghcnBrLxGHHW
        0yTjphJfiH8s3w==
X-Received: by 10.28.62.139 with SMTP id l133mr2598999wma.130.1491060662588;
        Sat, 01 Apr 2017 08:31:02 -0700 (PDT)
Received: from localhost.localdomain ([178.156.154.74])
        by smtp.gmail.com with ESMTPSA id y22sm10924192wry.51.2017.04.01.08.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Apr 2017 08:31:01 -0700 (PDT)
From:   Robert Stanca <robert.stanca7@gmail.com>
To:     git@vger.kernel.org
Cc:     Robert Stanca <robert.stanca7@gmail.com>
Subject: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead of signed int for flags
Date:   Sat,  1 Apr 2017 18:30:49 +0300
Message-Id: <20170401153049.21400-2-robert.stanca7@gmail.com>
X-Mailer: git-send-email 2.12.2.577.g38c7602c8
In-Reply-To: <20170401153049.21400-1-robert.stanca7@gmail.com>
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 As rev_list_info's flag is unsigned int , var flags should have proper type.Also var cnt could be unsigned as there's no negative number of commits (all-reaches)

Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
---
 builtin/rev-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0aa93d589..eb4af53ab 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -211,7 +211,7 @@ static void print_var_int(const char *var, int val)
 
 static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
-	int cnt, flags = info->flags;
+	unsigned int cnt, flags = info->flags;
 	char hex[GIT_SHA1_HEXSZ + 1] = "";
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
-- 
2.12.2.575.gb14f27f91.dirty

