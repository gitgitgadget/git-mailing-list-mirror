Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E051F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935168AbeF3JJU (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:20 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:39883 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbeF3JIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:40 -0400
Received: by mail-lf0-f51.google.com with SMTP id y6-v6so446004lfg.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Xn7hfb9S57WQ756R8BBn2tPRFt1bnEXQNQ9GaoyZVE=;
        b=CahAwXXSATAFIqFIL4FmnisXEq2BuJHtrkY1FSYUuYKd8jYenHYBRKWhZg4mPQui53
         aoFyuzxQ0j4654Tls8cUM6daZSCPS6KtisCIB1T1MiKnoqOyzGvJMvM9tjWGglhnEBVs
         r/6pOnlp/AploxLS34RoYMnkWTQQ/9YMlqaSjBq5RROYeHe2U0Gz4J0kD8kMLtIK1pXe
         mCir8yOjFVS5BIHHmBI4IeZmJQrd2vbZFS4jybygxp8ziL9zlVrezIAlRMfE3E1hGHZe
         GLNLEbaBMlSLevBWXzgrH+V/cnUJtvrGNJwcRr/HxJ4C8R8/HfMrjbpTdJWTJTm3K1JW
         nzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Xn7hfb9S57WQ756R8BBn2tPRFt1bnEXQNQ9GaoyZVE=;
        b=J3ecWgUMCU9MmJjz0MFfnmWHykMpII+u/F9AFZ7FoQobIBBsFspsLr+lNQ0UNpVG8m
         biQEyfVWH9Nqf11PQVDmgIDspVdte24EP8WvVylB9Zt4Q2EOz1rkZ5/afFsL8j42zia1
         CCk0OCXH7xU8LUuYAEkGrCBKwgmi9zk7EEk7N86GUYU2nstmIHNJTDfGhqYKD1dMm6s7
         EiHbKZOpffkY0ON/Oz3gaVy65qvVqQmhMtcmhxF4I9tS8gM/Ujc0iyN4Q0j/klDLEcxa
         nFm/ipM9/qSPqDrZ1ItyWiWtmezmaIiT6dFMRQrHBJz0eRZW6d5BfVZTf/KeH85YO2ZS
         yBRA==
X-Gm-Message-State: APt69E2LDcFE5OgR9MsY50jnLu7QSbrYtBLrTrAGV7dJC7hXaowRkNnD
        QV4GNQEBSWQAATnCMpW8rJH+Ig==
X-Google-Smtp-Source: AAOMgpdURTh7y/VXKBSNgNSHInPF/ap/TZHvZWPzskvYimFS5IKbTSwU9mgD5cUTLxqQza5vx9DICA==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr11439887lfc.59.1530349719242;
        Sat, 30 Jun 2018 02:08:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/23] environment.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:08 +0200
Message-Id: <20180630090818.28937-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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

