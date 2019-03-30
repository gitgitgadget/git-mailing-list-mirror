Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5025720248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfC3LVA (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3LU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so2210179pll.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=c9b4MHF8/qOwzP9en5FUc5ANBWLNXI5uifHkTZUMxuA8DBQdOfgK3lqvzgIxOle/2w
         jvSVIxwSLw8ObyF7kktIA4w/w/sOLB61PsUfuGfflqA9dYHltennFepPZT9xG3LoiYYb
         RgsUHUwqV3RMfL/NvvHygGlyb8G0MGqrdvAad9hHB4PkiGlF2uc/2KC/JVX9NeN5GRzK
         NYNkNB+tVjY5A0H6F3TFHy8AMnu9yHlofarywkAvUSjI34trcmXIGawoGSrck4GUp6PR
         jfRrKcLIeLb8DgaN4qrj2Op8CWVkd0yjhtRl+byfgnG2IILAwpBnOlQU3QAg1CqI/pfc
         8Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=B36BUqDgoTrYZeQThLQTejYHkUqSdujxDAWQq7cKGU/cAQVHStc0+MTDe/YEyciWIl
         NKapiKi4tYPI8SpNxvXQZ/Yag+iO7Test5Gy2m6PrfB7VOtjNjNIPBGBuugHKJ3doZOm
         8DvBpW2t2QaNcJwamdVqw0BshIgK+cucxjxMsu+Z3Kz0w8c8WmDlCgcJjfugwYa/Z4s1
         AZ0fWKBzsMbNycYIshvdrGTbj3z+ZGyP59WrFvnw5Ihzr8NDwIuRoc03dWK4O9/wCOFJ
         Af5ezByTJWOPI6I3XVzkXHCjgTaNhIqyWt4GJvl5tKoTKuiA3E6v2EYbjamyza0oh1oy
         Iiyw==
X-Gm-Message-State: APjAAAXRP0alDVOyc0ZLR57Dua5bCymaJkdUDFp+ZPU1cfwhvlP2/gOv
        aBhVuuYJTJEZhuxWxNASyKRFc9rw
X-Google-Smtp-Source: APXvYqzZz1wzbZ4K65mlegrNZ8cbYqAQkwqW9dQMW3/nWrmVs4pKnX+TjqARJW9Mz+K1Pn4FZ+xg7w==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr4555553plr.288.1553944857715;
        Sat, 30 Mar 2019 04:20:57 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id r3sm18977057pgb.82.2019.03.30.04.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/31] refs.c: add repo_dwim_ref()
Date:   Sat, 30 Mar 2019 18:19:02 +0700
Message-Id: <20190330111927.18645-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 12 +++++++++---
 refs.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1f5864aa36..bd0fec5776 100644
--- a/refs.c
+++ b/refs.c
@@ -555,14 +555,20 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
+	char *last_branch = substitute_branch_name(r, &str, &len);
+	int   refs_found  = expand_ref(r, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+{
+	return repo_dwim_ref(the_repository, str, len, oid, ref);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index b630d5bde7..fd3dc1d0f4 100644
--- a/refs.h
+++ b/refs.h
@@ -149,6 +149,7 @@ struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.479.g47ac719cd3

