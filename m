Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5B220966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdCZCoU (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34381 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCZCoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id o126so4075332pfb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOfo50+d9wfE1e4305KBrFC3rS6RVFt9S36P2PUDijI=;
        b=Wi1vXvQVus8EqvRGQ6EZmqF/OcoGkb9m3CZV88gM6slbrNn/sxDclCsqfsUtE5djae
         gial5S7Z+AdjZTnryxj74A97aXE0wQq4HagiHEHXqP3vLecfYRhEH+fGWgZPddn3AUH7
         JaVyw5JrIhqynwoLeKVboRBJkgOeh4mBJofyLMCFPekUOYxj/hkr52zVcLeVo/+dOlEg
         ipebMT8WMD8WmO0Xpm5hTYWl6cOa3wb79foxhc5cD2bBm2PtvKZcYljBY+L5d1aaVE52
         YFI4HPGd7dgRgkuLrC8pKay7o1hk4BqSu/XG2oqF03iUo8+fC6KcBAqBcZOBmVqMphNW
         1imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOfo50+d9wfE1e4305KBrFC3rS6RVFt9S36P2PUDijI=;
        b=kGLNrNH0+intMODfG9rkAuy5aM4+Skz5V+hCrGEMxUZQ9uJMjAfVy6d1h84qmlQ9cL
         mZeBKomfWfW6c7yyx7ab+Fjbn8Me81PGiTiKpBDdCy4UaCBSzRCXTnvXvBksgX2MB/7o
         cra6VNaL/HCuO9Y6TAuGvrH7QOKElhFa7XEj3dsRlXwJmTYiZqUfv9bAySWuQuqsn86D
         JehdIbbC7GddkBZYH6UHc4Q8On459crJ/1q07SJbAMgQZOEpp/DSN5HWQhtnKNahHN3u
         XnafLp8xu4dMQ0n4dm/2z+DHuHIpt/bKLY0HdNBWoIA6eaOP4576gc3flCnO+er0RBZy
         oGYg==
X-Gm-Message-State: AFeK/H1Q2VBvMUIoLbWoqDtzKU+WxXZgxxZCXEaEwlMX2g7rUzLHVaD47PStAs23175h3Q==
X-Received: by 10.84.225.146 with SMTP id u18mr20517314plj.135.1490496253381;
        Sat, 25 Mar 2017 19:44:13 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id x68sm12821385pfx.45.2017.03.25.19.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 13/28] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Sun, 26 Mar 2017 09:42:26 +0700
Message-Id: <20170326024241.31984-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
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
index 8aa33af4e8..a4a1a4ccfd 100644
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
@@ -1471,7 +1467,7 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
 	} else {
-		refs = lookup_ref_store(submodule);
+		refs = lookup_submodule_ref_store(submodule);
 
 		if (!refs) {
 			struct strbuf submodule_sb = STRBUF_INIT;
@@ -1482,7 +1478,6 @@ struct ref_store *get_ref_store(const char *submodule)
 			strbuf_release(&submodule_sb);
 		}
 	}
-
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

