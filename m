Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7229120248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfC3LVS (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbfC3LVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so2444110pgq.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=DF/9jLnaXwtu1YxOv0Sr1AcuWs85kvdk3kiSfNv08MPS8h2iF7BnPf3TdbnJDc4BvN
         d9WL0MbKVwWl9ZpxHVzHmPdxjHPIQaejz4i0NV46RkpFrl4GHQTUdrqZKz9AGMG9CDfJ
         txQmwXUN+nfnvxPZLSCnfYKaQyscJBCraG+iq93XZNUc7s2xOmFAcX5qpCV432njZWPx
         lTbjRWT5sUPb9jcELjcNVqrJrjQcRpsZBFe/TlHqbkpTVN0COntDplwOgxyZTxqKWRk4
         0GFhXI53kdOgCNunAvUuzoDsQ/y8WzxRE05+F8OaY7b0Q++cd6UtYPhfP/LAd09n0ZvD
         l0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=jUv8wzz1lse9VggRs1wifnO84VUglr+hDSI8eT/BPTzocDCICjRbxIu4/1NLfX/DX+
         n/U/R7/BoUil++UFhDCvhz5fy6cFX191Iv0QqX0U1uTQ6ZkFpqXXSdMbZstOPB02lEx1
         nWm9Ag/ii1yjCL6OIXjkln9ybIfvIVJmR4jUWf62w7h8u3HjRf/JtlPqfgK0OHmBIzCJ
         VJblhFh3HqbhjuIR600zJlN4bzOSjPNLBTOyzN72nVFCJaDXIZsH4Pgm5K/It5Z8PuuW
         UwTAU/AFDOJDxjSTF8g/OiXO7Is4AKWx4X0VybQ9ATt+NyxI68NnyFB61abE1sKNlujJ
         kg9g==
X-Gm-Message-State: APjAAAW83KR1eILD8az+tYLwdxS5gP+uYInCBl6ADWeVWgLpCfglSSQG
        sWbb3X1azmFy2UM1XghsWX5yHlZI
X-Google-Smtp-Source: APXvYqw8wY4K5ssfTDynsXJ50ZTXJgSWH2Rov84mVJDDE5wGXn6fk42I6HhADFNSM/yAIFM7QOgmOw==
X-Received: by 2002:a62:7648:: with SMTP id r69mr18808222pfc.114.1553944877270;
        Sat, 30 Mar 2019 04:21:17 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id x9sm8279618pfn.60.2019.03.30.04.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/31] sha1-name.c: remove the_repo from sort_ambiguous()
Date:   Sat, 30 Mar 2019 18:19:06 +0700
Message-Id: <20190330111927.18645-11-pclouds@gmail.com>
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
 sha1-name.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 15a1107998..7558ce51a3 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -383,10 +383,11 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
-	int a_type = oid_object_info(the_repository, a, NULL);
-	int b_type = oid_object_info(the_repository, b, NULL);
+	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
@@ -411,6 +412,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
+{
+	/* mutex will be needed if this code is to be made thread safe */
+	sort_ambiguous_repo = r;
+	QSORT(a->oid, a->nr, sort_ambiguous);
+	sort_ambiguous_repo = NULL;
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -458,7 +467,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous_oid_array(the_repository, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.21.0.479.g47ac719cd3

