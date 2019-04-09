Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBD920377
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDIQMK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45543 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so21603966wra.12
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByOYcfo2Ie+3tPx+lyyUEesRW5ynkr17PCkvzC8Zauk=;
        b=UB609eS4ZlD2lC7aePL3hM/NHEwQ4/3vgBDbeqM/X7Jf0VqbtaSRKc7+4S/4xzC89i
         cmYVNm4uSSMDGlxTpLVeHWcU/zZdKBwxiMlGas5caET+eWcXuJwNWsMvHeuD9mECqpfb
         sI7F1hNd2CJu/i95aLJxW8eKDCVWjcm+/P7GoiLAs2yPQWNFE/mnu23zcFluf6ZpRPoJ
         MSGr0qJILZ4sNBwdQzqHUi92t7h+755//RmKOaViu2gLr5m9PrAhv/nhNB9Skee1x7mN
         sumpDAO1Eyg+YG6FHmLkoNGdUR0uOKj71m+AiGxt6fwjgqIRK46CucKIhr4r2dEfCE3b
         zo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByOYcfo2Ie+3tPx+lyyUEesRW5ynkr17PCkvzC8Zauk=;
        b=MzqeJm5UYB6llH+IO8hgxRZzCrT37kkLKShQfacSYl8ldeo4rU4BT1PSDFbfrsw1BT
         6fvlNye/46dHKHWhg8uzI4NTJrz5qDb/Ou6rY2dkGCPfDZ3kbq2YEaJOhW8cbX+8DrUo
         mveQsTqmDqoxZIZvzrbkujR3f52OvSmdd4RQ2qwatvYA2ww2r7u1C6Bydooj4sW+TBeF
         PzbddWwKhRuv7NOf6a0I2dnP4OEX0s3GFw59qp/bH3WaBUpzRfCW29BXrDYIPhG0XPYq
         JTEB2ElOOuVjjnOiCKzoZv0SQdbhgu4zH7/PAXUXyv2/yVg/4Ok8sMzNHdUvKuqdxyDx
         NxjA==
X-Gm-Message-State: APjAAAVs82/ddYxtxckdoJWH8L+9AIy5R2l3BdRHtcIM0ALJZCyy13+I
        5EzKNUoEmIlXN+idZumnHwMOENSf
X-Google-Smtp-Source: APXvYqwyXWzWSx5iNJzQ5wGAz9YjgvzjVCNfTRG5s9iUOEgTzJK0/8BiLE2ZVWIlGtrc0jLpg5LjwQ==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr5573301wrr.145.1554826327183;
        Tue, 09 Apr 2019 09:12:07 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:12:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 16/16] Move core_partial_clone_filter_default to promisor-remote.c
Date:   Tue,  9 Apr 2019 18:11:16 +0200
Message-Id: <20190409161116.30256-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we can have a different default partial clone filter for
each promisor remote, let's hide core_partial_clone_filter_default
as a static in promisor-remote.c to avoid it being use for
anything other than managing backward compatibility.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h           | 1 -
 config.c          | 5 -----
 environment.c     | 1 -
 promisor-remote.c | 5 +++++
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 217e434d5d..7ed867b119 100644
--- a/cache.h
+++ b/cache.h
@@ -960,7 +960,6 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
-extern const char *core_partial_clone_filter_default;
 extern int repository_format_worktree_config;
 
 /*
diff --git a/config.c b/config.c
index c2846df3f1..dd95b659b4 100644
--- a/config.c
+++ b/config.c
@@ -1344,11 +1344,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.partialclonefilter")) {
-		return git_config_string(&core_partial_clone_filter_default,
-					 var, value);
-	}
-
 	if (!strcmp(var, "core.usereplacerefs")) {
 		read_replace_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 8855d2fc11..efa072680a 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
-const char *core_partial_clone_filter_default;
 int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/promisor-remote.c b/promisor-remote.c
index 371c78385f..f77d0e3b50 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,6 +5,7 @@
 #include "transport.h"
 
 static char *repository_format_partial_clone;
+static const char *core_partial_clone_filter_default;
 
 void set_repository_format_partial_clone(char *partial_clone)
 {
@@ -103,6 +104,10 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	int namelen;
 	const char *subkey;
 
+	if (!strcmp(var, "core.partialclonefilter"))
+		return git_config_string(&core_partial_clone_filter_default,
+					 var, value);
+
 	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
-- 
2.21.0.750.g68c8ebb2ac

