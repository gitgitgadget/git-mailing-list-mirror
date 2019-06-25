Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD441F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfFYNlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35003 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfFYNlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so19618957edd.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L10ZnmDZR3c3XSdNMQHUwIL5QsCHGJ48wMArTxZpXo8=;
        b=DyINuUEAhqFgpru32hBLBOW5AzRTerfOoaLPocxkDkQ9bhdDKvM1+2ZcyH+sitJxMp
         ySEKz89Y5+Wp76YhIeiyhkto5Kt2g7obEOzd12s1gNg6rGLK8Kd+yL0CrQk5VbIIZ4Ap
         P9SRKS4Wjwiabh8MXG4Fw70TtElZ6IjeUd8FxwCyscAK/11AiidIAH6WN4UJluSvq1W9
         bpc+GP8HA6DlWAibmMc/+g7a2ezVoeq0tL6Io2TYrn/0gbq6uQJtbAHhnKxC+/ClBH0y
         OKHPLcTN4L+5HUGCWmjtspb1ynT0HGyLUDnouXBbqJjB52bpSTJ73BbA2Zm1ZLfGHM0g
         7uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L10ZnmDZR3c3XSdNMQHUwIL5QsCHGJ48wMArTxZpXo8=;
        b=FbSE0bEbvdHmK9O0l9lMxgVNN29tI+gXPT6ECnYfpPoanJV/phAuJesDTntGtqJN8K
         q/f+e9etQ+M1IpZKJfBEl4e2wlhrwkIrfXUgHcOGP7PAPyrcUI3IzNQcS9ESdzb8xkPS
         XgiYBGOAP0FUS5I2oaEYgaUhE98nyirLFnlaw5eVVV6gwgbAC5YWcM9p5NZHbwWZODoX
         j8p5j1DJKmrXbu688xfPt9wkqegexrVwA+m81kOfNRRnw/7sJpcU+qTrnRUYb2/dZOMN
         aZ4fs/FYiHxi1xYVf4G5wdheLBQb5sHImhpyjQWgNyVrV8qMACRsV9DGeqie1Xz9YjcK
         1nVw==
X-Gm-Message-State: APjAAAXQj2EPKyyX7SMSeJO7p8rpk26/GKkUIBAMERJFEZKH8MWVghxW
        eFHjZXXgToxp6wKWR/+rYbT5dmqcu9w=
X-Google-Smtp-Source: APXvYqymoPtQvUR19rNVEbHsPbPriKvgHB0VoDcV7LG9PDiyoQ/rw3R2zEsftehJ1F8/vCtF/AYHWQ==
X-Received: by 2002:a17:906:2658:: with SMTP id i24mr35357135ejc.18.1561470081645;
        Tue, 25 Jun 2019 06:41:21 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:20 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 14/15] Move repository_format_partial_clone to promisor-remote.c
Date:   Tue, 25 Jun 2019 15:40:38 +0200
Message-Id: <20190625134039.21707-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
index bf20337ef4..e34b9e66d2 100644
--- a/cache.h
+++ b/cache.h
@@ -961,7 +961,6 @@ extern int grafts_replace_parents;
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
index 92c4c12c1c..31d51bb50e 100644
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
index 838cb092f3..8200dfc940 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -22,4 +22,10 @@ extern int promisor_remote_get_direct(struct repository *repo,
 				      const struct object_id *oids,
 				      int oid_nr);
 
+/*
+ * This should be used only once from setup.c to set the value we got
+ * from the extensions.partialclone config option.
+ */
+extern void set_repository_format_partial_clone(char *partial_clone);
+
 #endif /* PROMISOR_REMOTE_H */
diff --git a/setup.c b/setup.c
index 8dcb4631f7..25a3038277 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "string-list.h"
 #include "chdir-notify.h"
+#include "promisor-remote.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -478,7 +479,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_partial_clone = xstrdup_or_null(candidate->partial_clone);
+	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 
-- 
2.22.0.229.ga13d9ffdf7.dirty

