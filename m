Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C1A20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfC3LVi (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36689 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbfC3LVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so2437646pgc.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=RSxayYB3JUv7kVzoQxUHxQ9NIUCoMNFeRH4zKPXRy8aaeeoGgZgBTCdSBC2Rh5znb3
         oi7Z9yTiNAw9pmk5cUwoA/LNx7swZdSANlwDy28wfzrAez5GvbFC9RZ70kKvwGqxOIec
         5uVgb/1F/D7rGdL3dp/3SVe9+j53ox9EqL6wN0i1WfublSx76W93ZVWuxd51/Nv2canM
         OR+CJ9OCCdfdPbHVvy5VHFSdqeaZ5OQg9EB3silyweSmEDFGhxz0gG7QlmyQaeC85aBj
         vQLjFctfzaT0yLLJTmCiLCnHCr+ukeN6XPQxN4DNq0tqocgyprM+Lh0jzzilYuRjFRB6
         prhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=WF2uHdlmKULbCBomyfK3pexfNRS1Rlgp07mEVcrN9MRGJlHg2zBhIdRyEB9voTth7/
         C2NHgRXWi1vviIpn9FWhGF6Hv1KryehP/dE/Bbq5WPOdLy/itTSk4+Oh2xdzz9Wll78a
         cwIihPwUUybzvmD2PkSducdJMv0bdIbEu0LyRODTEr3gL2RImJyZdXz4lnKPSwraqp4C
         wdf1y5TFB2OFDweSm9Z2I6l2JdadIpltPKoNrkvwe6ek4DYAZZCbMgFXAgmViWHfSlY4
         36z3PzVeYZxIwSW3Z1qE5T4uCb/kaQQC0SsBeoFJvyJdZkdVnvAugNxpbrcISXjTPloh
         zVAA==
X-Gm-Message-State: APjAAAXta2OYUKUyN9jv5BbmhUl7t4UGFw08r8Drg89jWRQ6zX0oR/iI
        so0DyS/vdZMwDnr4M8Mj2sMVfYjP
X-Google-Smtp-Source: APXvYqxkM2dw9cwkCXp0OROzIHVaOqN4pLnFqLucFEITu6rQNZFfGoM9KQzCjLz+OzoOHGEDanDW4w==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr50850311pfb.226.1553944897840;
        Sat, 30 Mar 2019 04:21:37 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id i24sm6904862pfo.85.2019.03.30.04.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/31] sha1-name.c: add repo_for_each_abbrev()
Date:   Sat, 30 Mar 2019 18:19:10 +0700
Message-Id: <20190330111927.18645-15-pclouds@gmail.com>
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
 cache.h     | 3 ++-
 sha1-name.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 4f8ebb0a67..0cb95c0d4f 100644
--- a/cache.h
+++ b/cache.h
@@ -1392,7 +1392,8 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				struct object_context *oc);
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
-extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
+int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
+#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
 
 extern int set_disambiguate_hint_config(const char *var, const char *value);
 
diff --git a/sha1-name.c b/sha1-name.c
index a75992eb54..cdcf84b826 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -493,13 +493,14 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	return status;
 }
 
-int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
+int repo_for_each_abbrev(struct repository *r, const char *prefix,
+			 each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-- 
2.21.0.479.g47ac719cd3

