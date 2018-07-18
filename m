Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701661F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbeGRQvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:36 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35557 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:36 -0400
Received: by mail-lf0-f49.google.com with SMTP id f18-v6so3868566lfc.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Xn7hfb9S57WQ756R8BBn2tPRFt1bnEXQNQ9GaoyZVE=;
        b=Ri4z++H2HKtNCcwpfPJAm7QY5r9M2D6FFkepHSh4f013ZKEzXU8ctX17zrD4LcGVD+
         kywCNmGt//MKQU3XVa49dPNwyht1uZj0icNpe/Ray/AEph+/9+1nxy/xFqIwJKxKgSEo
         n0cfcPVGr9PFYok46LVjIjNSMwFWQADbzB7/uua0sr4+UBJYQEuyRf8goBgD5BnDh67e
         MGITkt4KmCRK99x7d5sqSMTaoD2yepyWl7nH1UyaxlvmYzEW/HHs6hx0Gn3hLPwTrBr6
         /WvFIODxRMSrom92ZJxhjdwubkd6DKd5sPM7YCJ04302ZsW0GYa6dl609GTtGdtgghaE
         tUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Xn7hfb9S57WQ756R8BBn2tPRFt1bnEXQNQ9GaoyZVE=;
        b=JAt6mIC0Z+ZlSN8waKCA8GmwlACliQnOwzGt8wwVAEmja8xzMcwYgXoi6bCfuQuqf9
         sN9v8vO2jrtIwxIoUX3maQn85BlyLBM2bnp7ZgMoNFyUgAZY35NeefNq+JRW58QA3isR
         1iZ6Mm3G+87/lLFhfnW6Ylv2zwk3yPJRY/RBs35JKAa04qN4BZjnGPNywxMp9OyKwP2+
         k+bDs0hCnxlXlKBKWv0i59t8JCCsC7QdNCV3ygcNyvaEo4drmFzmn8EaJcF2VkBq8ZeE
         Io9SJKxVIRjyhgd7U8qSndN5YXm/5AXNF4AQw6yYafUDuAMQFazT7N/PBv11t9wPf05+
         KHAQ==
X-Gm-Message-State: AOUpUlH11ONgbhEAmXaIRKLV82xZz8IAwUCe5Od8rGjb2JIYm96KHqSG
        H1QFneQsUflWOcGMgJGCkAIkCw==
X-Google-Smtp-Source: AAOMgpcLfI3OTCCse4IfO/WzyGAGnHM26VQqzyiZLpOYicw0EKjACWNEDI4KEarq5u3Gn8zG6+Bsxg==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr4390092lfi.76.1531930378595;
        Wed, 18 Jul 2018 09:12:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/23] environment.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:51 +0200
Message-Id: <20180718161101.19765-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 2a6de2330b..d129c4adc5 100644
--- a/environment.c
+++ b/environment.c
@@ -147,7 +147,7 @@ static char *expand_namespace(const char *raw_namespace)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
 	if (check_refname_format(buf.buf, 0))
-		die("bad git namespace path \"%s\"", raw_namespace);
+		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
 }
@@ -329,7 +329,7 @@ char *get_graft_file(void)
 static void set_git_dir_1(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		die("could not set GIT_DIR to '%s'", path);
+		die(_("could not set GIT_DIR to '%s'"), path);
 	setup_git_env(path);
 }
 
-- 
2.18.0.rc2.476.g39500d3211

