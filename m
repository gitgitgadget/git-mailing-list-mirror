Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D9520136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbdBQOGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34679 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so5048757pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DhKeUlgBJZJj8KvnnenLS8no+ovVN4DZf9wxfUrhI4=;
        b=gglCFO5Gbyxfni7KsORE4jAzHXRcGtntdBb/HIEUlByK3Gp2IUuiprv5AZkkjWYEqh
         UW7rxJDDnPyZlX94ZusgW+RHNOID1S+07DNBOUm7WxjZneZ9iN43V5w/I59CJO+YQWFo
         39zPpCTJWh+1Oa1QWNe3Zj8irn/sbkrGaoLSEuGybKOqYRgPq7wSdpNXmCAQ09zNAAe/
         pyYiC85H/y6VUK+Y9Nu2e5LNIQWzdEeJCEcbTFjc3keDhoL6rrzKSWj60SZhIlqLKPJN
         F72U+82jJyKLTumA9e9s0Ns9d8NMz1mca9NhwdJXDTgcCrnnoiCzOTwmGhPNIMH1SW9O
         IsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DhKeUlgBJZJj8KvnnenLS8no+ovVN4DZf9wxfUrhI4=;
        b=eWZgbTab6QILBsmuDWXp527Nb0NaIudFxQ2lY25wcdbgJYc+frQtD92mALLL1WmJMw
         knmMO0SJcYIX4k4A+w/MPjVpI6u8y2MXXqw4VQ1sltsft9Oi1FmLdJqV8Ew2SEQycuZa
         axsP2D2DMLLNEW8OELiqB9q1yZy7CsGsaHN5rFvM7SR2vZeuns77E2LFfUKpL+x+3QdC
         FcsHKwP1fVzz2AkfKx6RAMbJBgwBDhtvfLbM90fFXtp3zqxGyIjCGLzr1oPJgtnXP6Ax
         Dl7/Ya5K6vmM+7RE/mPtwIMGUfbwWImuQGFRj+6uIYf4fdFZusywFLTfxBNKRvJPAKhI
         H5Xg==
X-Gm-Message-State: AMke39kGdXpAdtyQaq37KopfgMpOmqBSrt5iXhxvHo1/Qf12B4cZVvXp0yOZbpXD1toPxA==
X-Received: by 10.98.11.9 with SMTP id t9mr2661475pfi.123.1487340357523;
        Fri, 17 Feb 2017 06:05:57 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id x15sm20103791pgo.56.2017.02.17.06.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:51 +0700
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
Subject: [PATCH v3 09/16] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Fri, 17 Feb 2017 21:04:29 +0700
Message-Id: <20170217140436.17336-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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

