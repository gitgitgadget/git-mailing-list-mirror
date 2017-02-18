Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F4067201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbdBRNeU (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36656 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdBRNeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:19 -0500
Received: by mail-pg0-f65.google.com with SMTP id a123so4597614pgc.3
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cXRrhmN/Gr/rZlEn7K7IUxQdz/mB/RJHAno1g4vDpA=;
        b=GLtZ7x14e02MqgSEh4CApGUqdRMW2jb0KHbhaNBn4LycVa8sHhT9iyuFOLVgI57SCd
         XSY0Kl5d+8oElLxv5ou+5NAAafFmNtiWJ1mf3Ya3+ayuWhIE5MX9Es8Y9wlqbgIYphpM
         t9I4MxDJ1oGXsEKZmH8w4wm5/BFO/teHKmsG6HJ3YVdD2Vxe2YAO8c4MSZpxbZlwDxNg
         lx5w0EXq7fFHlrDe/7SUSH9B0CLGjHZhojUVasZR9X+ZmNQig6vrOSkOL1Zmni5nuAt0
         OBnqEOIMuUFJfL6qh3BrjJE1kAeBZrXkoR7e6CrUOiYMCjlclgqlPhD5N9kOZliN5mqM
         vM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cXRrhmN/Gr/rZlEn7K7IUxQdz/mB/RJHAno1g4vDpA=;
        b=lrEkYhFrkDQpjZKNzGi1ueeMhnNTb3ddz6tLhxr99ctcKNB21Bhq6VUtla0O3Xdq0a
         ouaust0L5qYL9OgjeedVyeR1rFkfgtATdncsb+q35oVYcolAWMcUpBEAntHYQxp0SYL4
         ASVl5+0vGzKBa0WCHHDloYHolpd9GTOwdn/lTms2BVgMjiETz9d++8IdhBoIOp2Xh0Pp
         GSbt1B9Ya1AGPncYa1V3Z+JTz/yrnhtP7Mt53kS9Srl5wz8fRWkf8kcTGLi6lu5Icf9U
         sVW+OYNFm7JKcYfdT5dAjf7Ggh3tQj3f1hR+eyKWbXDy/xQq2vzZGZLXrkZCdU9CIqCi
         ObMg==
X-Gm-Message-State: AMke39nICXwwxd/T4Y9teGyc0pkkQe5Whdu/ZTSdxFO8HcP372XxQ4rhwdVeDOXULle4Cw==
X-Received: by 10.99.146.7 with SMTP id o7mr16157233pgd.6.1487424858634;
        Sat, 18 Feb 2017 05:34:18 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id p17sm25464193pfi.97.2017.02.18.05.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:11 +0700
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
Subject: [PATCH v4 08/15] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Sat, 18 Feb 2017 20:32:56 +0700
Message-Id: <20170218133303.3682-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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
index c3bdc99d8..6aab5e4ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,17 +1389,13 @@ static struct ref_store *main_ref_store;
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
@@ -1468,7 +1464,7 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
 	} else {
-		refs = lookup_ref_store(submodule);
+		refs = lookup_submodule_ref_store(submodule);
 
 		if (!refs) {
 			struct strbuf submodule_sb = STRBUF_INIT;
@@ -1479,7 +1475,6 @@ struct ref_store *get_ref_store(const char *submodule)
 			strbuf_release(&submodule_sb);
 		}
 	}
-
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

