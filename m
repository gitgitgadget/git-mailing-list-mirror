Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E316B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbdBVOGu (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:50 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36113 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932695AbdBVOGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:48 -0500
Received: by mail-pg0-f65.google.com with SMTP id z128so539846pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/CzV/Pe5jgAId1AzONJ+laAh8f48dIWD4iiJnDhQUo=;
        b=pO50A1QuKXBsYtotW4K2tP0KxeachG+Bjibu3QZvS0aOlVRQ9SJ1imHXRY8zLjSXFD
         rZxu35XxAEsD1pW91fqvgIu47SMMUTpDosOTEBqGo3wQhh/xfQmdvGG0wLI6IQebeiZg
         xGqENe39keaZ6y/BimZVs7xEcjMQ/GpnMosa3zpBiFXPOJkKCR/YqT1GhPwyFZcTnWVO
         Y1x8ZG/1XxMOIrkWPBr6MMTgmBEvdIqWP0mPL3u1drAF7Faw+oBZVy1F2J5i+Mi66lvh
         ZF4IjupK3PVBoKQE4zt/hiOOzIXG+akSeGueQyXIAc2SPkiIjO4VRuRCYFgrWMn/QqoG
         T2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/CzV/Pe5jgAId1AzONJ+laAh8f48dIWD4iiJnDhQUo=;
        b=D9TtWTCUnzXdt2YKIUJ9C9s4A7JiEly4hbFHBWevdHoLYmZYP8zKH/btjpm4Qo8FTL
         CJ4MIk4cw2vi76XlMLyGMdqd1xtTgHDvotmJKwgco4s2jquu63tEqDtM3wnJwv2HGkBd
         AeKvjYh3KMzTyWaUG8ZgECsEwPw5AgDYT4SpH5Peaj9KPJvOfciXOkEAOhYA2eDtmFI4
         C8wZzccF6P/vbKIRCHN79KKAMl447H0IgldKXZyEafmC8WmXNq294g0phNDaRUebK1HU
         MblQvaaXhndWNxefUkUytljMnT9D5ZaXemBI2XcICpq0II91jHDRmTxroG+IRQHRLOZR
         LtJQ==
X-Gm-Message-State: AMke39lFKehEpnviw7q1XnqY3CD9HEwt9RUh1mOkXUHStz7D2fLgBypycQu67WK8twGkiw==
X-Received: by 10.98.59.8 with SMTP id i8mr16739026pfa.132.1487772407169;
        Wed, 22 Feb 2017 06:06:47 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b67sm4076977pfj.81.2017.02.22.06.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 10/24] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Wed, 22 Feb 2017 21:04:36 +0700
Message-Id: <20170222140450.30886-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With get_main_ref_store() being used inside get_ref_store(),
lookup_ref_store() is only used for submodule code path. Rename to
reflect that and delete dead code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index dab1a21ac..8b36d97c0 100644
--- a/refs.c
+++ b/refs.c
@@ -1395,17 +1395,13 @@ static struct ref_store *main_ref_store;
 static struct hashmap submodule_ref_stores;
 
 /*
- * Return the ref_store instance for the specified submodule (or the
- * main repository if submodule is NULL). If that ref_store hasn't
- * been initialized yet, return NULL.
+ * Return the ref_store instance for the specified submodule. If that
+ * ref_store hasn't been initialized yet, return NULL.
  */
-static struct ref_store *lookup_ref_store(const char *submodule)
+static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 {
 	struct submodule_hash_entry *entry;
 
-	if (!submodule)
-		return main_ref_store;
-
 	if (!submodule_ref_stores.tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
@@ -1474,7 +1470,7 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
 	} else {
-		refs = lookup_ref_store(submodule);
+		refs = lookup_submodule_ref_store(submodule);
 
 		if (!refs) {
 			struct strbuf submodule_sb = STRBUF_INIT;
@@ -1485,7 +1481,6 @@ struct ref_store *get_ref_store(const char *submodule)
 			strbuf_release(&submodule_sb);
 		}
 	}
-
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

