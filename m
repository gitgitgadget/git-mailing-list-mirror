Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4771F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeCUQmY (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:42:24 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33875 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbeCUQmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:42:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id z184so6131133qkc.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlRAwi76GYXVxkbXmjzIXnQpaze1mI3eK3ZDin8Lxdc=;
        b=gW9J7/vF77IJEppgblAGWTxLjxQuAsApP0OSCWlhd+AFGT1CrIHXABMKUyKVI8FJlD
         eXu/IM3RQBVoirRMi6ixiEV6OaCuNaqRVC00yua3+Ge7V5fX5D9r4mnlx7nDn18scVFc
         fZ2S3Lp7Re92gOYTgt1jqx1RuqEjeTGGQBF9z4pfX/60t982uDdoy2S6DWBh2fM/3uwf
         k5vifK/av/ukxt4ltGx9JJBfl7/9lQpS3jtoB7VgVK9krnpV7zhtzpK5U6owLzP+IDON
         mKbngIS0m6WrM2k92W6CpowV1pzdJg6+xF6cSUM30ap5mNSv1yX37DrmEzerhd3TykYv
         C5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlRAwi76GYXVxkbXmjzIXnQpaze1mI3eK3ZDin8Lxdc=;
        b=aLNp1HBi3eEqAnG7Ry0rY0j6PSkE5riPsdhZNlqGse1yUrRJDcPFcxY1WQSNfru9Q/
         H/huX8UPlID0IwgghoSg3azDPWXhrUt+2jphDsQm3LnGaPHdCnWsupVUtxGcoxEARr5i
         UgEybIJnInNcOSXU5fnsj0s/K0iqCchWziQbTLacR0RcmvfZUSI2Vgd1CUS3TX1j6HIN
         HqHnDO3yCrOVXUgOQ3tXORExnnjSXiwkRacZCF8SLsILYOweXzyppLGgRUde1U/8UA2Q
         q+lDqdMP6J5UKqtYLoLFLA1E3+jpSTi1LCkyO2SKrMPAAX2a6f6Gzn6NTTkaAU1EkeMW
         qhjA==
X-Gm-Message-State: AElRT7FWxAA57JctJOCSnb+AeCwwcKEyroqy8NQHsomDicYzhUU1CXan
        0D+iEEJsuV4UUmUckxZe8ElpwthZ
X-Google-Smtp-Source: AG47ELuWokHVBDWZMkIOzflSBtHa8aQTVTSefjpktcIF0pMwDvNgVjWhidImTkhNKHq79cuW7IVV8w==
X-Received: by 10.55.147.65 with SMTP id v62mr30317942qkd.325.1521650541130;
        Wed, 21 Mar 2018 09:42:21 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id m24sm3235584qtc.81.2018.03.21.09.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:42:20 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 1/3] fast-import: rename mem_pool to fi_mem_pool
Date:   Wed, 21 Mar 2018 12:41:50 -0400
Message-Id: <20180321164152.204869-2-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Rename the mem_pool variables and structs in fast-import.c that will
conflict with an upcoming global mem_pool type.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 58ef360da4..4e68acc156 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -209,8 +209,8 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct mem_pool {
-	struct mem_pool *next_pool;
+struct fi_mem_pool {
+	struct fi_mem_pool *next_pool;
 	char *next_free;
 	char *end;
 	uintmax_t space[FLEX_ARRAY]; /* more */
@@ -304,9 +304,9 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
+static size_t fi_mem_pool_alloc = 2*1024*1024 - sizeof(struct fi_mem_pool);
 static size_t total_allocd;
-static struct mem_pool *mem_pool;
+static struct fi_mem_pool *mem_pool;
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -636,7 +636,7 @@ static unsigned int hc_str(const char *s, size_t len)
 
 static void *pool_alloc(size_t len)
 {
-	struct mem_pool *p;
+	struct fi_mem_pool *p;
 	void *r;
 
 	/* round up to a 'uintmax_t' alignment */
@@ -648,15 +648,15 @@ static void *pool_alloc(size_t len)
 			break;
 
 	if (!p) {
-		if (len >= (mem_pool_alloc/2)) {
+		if (len >= (fi_mem_pool_alloc/2)) {
 			total_allocd += len;
 			return xmalloc(len);
 		}
-		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct mem_pool), mem_pool_alloc));
+		total_allocd += sizeof(struct fi_mem_pool) + fi_mem_pool_alloc;
+		p = xmalloc(st_add(sizeof(struct fi_mem_pool), fi_mem_pool_alloc));
 		p->next_pool = mem_pool;
 		p->next_free = (char *) p->space;
-		p->end = p->next_free + mem_pool_alloc;
+		p->end = p->next_free + fi_mem_pool_alloc;
 		mem_pool = p;
 	}
 
-- 
2.14.3

