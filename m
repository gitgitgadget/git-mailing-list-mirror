Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00B720305
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDIQMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37121 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfDIQMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so21680265wrm.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6PjRo5DLBeEdKVtp29ZnCkB79MO7yqXoZpv9SpvVzQ=;
        b=kBoY2IL290DrlQ+mdQF1XNln5Bt1ZxHg/DKlLGdtEZSCmTxuFE3KcsoMjWW9+3CL0b
         Cy4nEhunLS1qzrLIWB0gwWTDxWwcQKvglHx6UAwY2oekNkAPSlkblfjSsjkMlHPepGCN
         i6Y1o+neyi9/rJqhatHcPGUQ9AwfCu7zJpdcQu1EKzFBAyowl/1XFb4xVXWY/rfJREGo
         mzq0BnP6nIFKl/iliDmsZQWlaFt+qIHjZfaO9IvL+K44cFJmUcQD5tE76oMxkKK54y42
         r6zY1MEN0zZl1A0kkCqpdulwvWF67Dz2ewSdp997H5j6HifIlxg97AB9XJsngY5JxbRH
         4Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6PjRo5DLBeEdKVtp29ZnCkB79MO7yqXoZpv9SpvVzQ=;
        b=fzO0XTzfbZ4zvjyMTw4b2HtZjL7bgOQbuRSUaYRhWARd5duMoNdmNK+FIBP/UMVzPX
         Gykccus03pv6qUauFRe2rQpCm93YaEMYND4WtsGWHUQn7j+WjQrTCWiyvtcWkrSuOVYj
         71gmCrh5aivkNEUiRSM8DF1vLM+eo+T22wiNoNgJ/CWFaymW7ecQwBNEXrLZy2GjYt08
         4LpzKlBladPRmi1Fz8Nfrv2deC6eBG/NoBOOpz9286i5LoDKhNPiu4nYGQNCqQVJp5Nt
         0+qBJU/jRetU2vvmc68IIGNYOWnXXTYgarweEVM4LCt/Sba4ewiVgiz2sG0R5DvB8avd
         3SPA==
X-Gm-Message-State: APjAAAWEBwCmglHupIp9GlIIaWodgVzBW9+Ie8WjGqBUsjs15bc6qbFy
        Py6AQS2FxL7vQro7pqhnw0O80lLt
X-Google-Smtp-Source: APXvYqyCczaVnMl2fiKIj6utsQjpYJwGmafvKm0r9PnOQrm9DXteDemC+BAg3XfNPwhBKUL64XWqOg==
X-Received: by 2002:adf:9c91:: with SMTP id d17mr22527613wre.285.1554826325390;
        Tue, 09 Apr 2019 09:12:05 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:12:03 -0700 (PDT)
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
Subject: [PATCH v5 15/16] Move repository_format_partial_clone to promisor-remote.c
Date:   Tue,  9 Apr 2019 18:11:15 +0200
Message-Id: <20190409161116.30256-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have has_promisor_remote() and can use many
promisor remotes, let's hide repository_format_partial_clone
as a static in promisor-remote.c to avoid it being use
for anything other than managing backward compatibility.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h           | 1 -
 environment.c     | 1 -
 promisor-remote.c | 7 +++++++
 promisor-remote.h | 6 ++++++
 setup.c           | 3 ++-
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index e928fe9d3b..217e434d5d 100644
--- a/cache.h
+++ b/cache.h
@@ -960,7 +960,6 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
-extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
 extern int repository_format_worktree_config;
 
diff --git a/environment.c b/environment.c
index 89af47cb85..8855d2fc11 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
-char *repository_format_partial_clone;
 const char *core_partial_clone_filter_default;
 int repository_format_worktree_config;
 const char *git_commit_encoding;
diff --git a/promisor-remote.c b/promisor-remote.c
index 066489b637..371c78385f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -4,6 +4,13 @@
 #include "config.h"
 #include "transport.h"
 
+static char *repository_format_partial_clone;
+
+void set_repository_format_partial_clone(char *partial_clone)
+{
+	repository_format_partial_clone = xstrdup_or_null(partial_clone);
+}
+
 static int fetch_refs(const char *remote_name, struct ref *ref)
 {
 	struct remote *remote;
diff --git a/promisor-remote.h b/promisor-remote.h
index 562c7ad8a4..c3c07c2a23 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -20,4 +20,10 @@ extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
 extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
 
+/*
+ * This should be used only once from setup.c to set the value we got
+ * from the extensions.partialclone config option.
+ */
+extern void set_repository_format_partial_clone(char *partial_clone);
+
 #endif /* PROMISOR_REMOTE_H */
diff --git a/setup.c b/setup.c
index d0c958c3b2..434628706b 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "string-list.h"
 #include "chdir-notify.h"
+#include "promisor-remote.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -477,7 +478,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_partial_clone = xstrdup_or_null(candidate->partial_clone);
+	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 
-- 
2.21.0.750.g68c8ebb2ac

