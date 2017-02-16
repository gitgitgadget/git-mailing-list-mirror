Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCD520136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754986AbdBPLtt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:49 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33264 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754835AbdBPLto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so1832118pgj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DhKeUlgBJZJj8KvnnenLS8no+ovVN4DZf9wxfUrhI4=;
        b=rsEm49fj4Q6ZYCDU0Qg8OdVryPIMxeHBJtT5Mwh+cpuiOYXxtiMmdP2nZ51VhFu5w8
         qby6ZqsWb95rFzf5fN5q9DZuND7pI3ktZt6Fy237ElNriQLEr/OqlJP/pWr1sZg4eMUB
         fkFgtyiUvrVYEwM1Nn/ouLI32u0n+jsiHUur/Jxsf9Z+HRjVS627ZPPihuMWZo8Cx6wO
         ToXybzpLVHvsm8yOwud/lM6AaX05IPbEC5fWQ2of9KYej4bVsBtWyCuLD/lF+dNISYf0
         Ytxd/8EQjR+gxYYIu38SuineCaJmfqXBs+XEZZXyy1XwzH/ppR46KBJ0RmmT9jvjFMTK
         aJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DhKeUlgBJZJj8KvnnenLS8no+ovVN4DZf9wxfUrhI4=;
        b=uGLYZioAvv8DKopUdj2tp0oK2O2hUxwz3NDA0jSzqbMmNQtGadkI9iMErf0uGuTiMQ
         6/exSedyqBfiQuxd78FuCrHM9UN39RkBTBF9eCcV3UY5HawNYiUNx4ycnYpjSaYnBnRy
         IRyhFf1bBQ7jbmBP085WOu7Z/VotcObFkxO5ndAIQbStmNI7Bub6KJSCTZGG+uay7wZH
         T1XoK00pKs47M577JZsofGMAslvLXBN6xfrWYp51XtuyJ+4ConkvNlnMnUMpqwfT8FY+
         Fi+qQUyCS/VXt0Ed4XDgx7RAQOIWop9UEPzczhvjFxMSSqsGKalS3yFSRNPM3Z+vX41n
         OT+w==
X-Gm-Message-State: AMke39l7zVHmKseURvGb2SSYBcMQ9y286At9Vj2rC1Q0LsIliC0zV90uhuFeRqzakZj0eQ==
X-Received: by 10.84.218.11 with SMTP id q11mr2591804pli.141.1487245784034;
        Thu, 16 Feb 2017 03:49:44 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 75sm13293333pfp.80.2017.02.16.03.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/16] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Thu, 16 Feb 2017 18:48:11 +0700
Message-Id: <20170216114818.6080-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
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
index 10994d992..ea13a5b86 100644
--- a/refs.c
+++ b/refs.c
@@ -1384,17 +1384,13 @@ static struct ref_store *main_ref_store;
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
@@ -1463,7 +1459,7 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
 	} else {
-		refs = lookup_ref_store(submodule);
+		refs = lookup_submodule_ref_store(submodule);
 
 		if (!refs) {
 			struct strbuf submodule_sb = STRBUF_INIT;
@@ -1474,7 +1470,6 @@ struct ref_store *get_ref_store(const char *submodule)
 			strbuf_release(&submodule_sb);
 		}
 	}
-
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

