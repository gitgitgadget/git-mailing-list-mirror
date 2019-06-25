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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD7D1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfFYNla (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35007 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfFYNlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so19619057edd.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+Uh3OM2UyPjAqXRs0MwDF+mqy/zbc7X8AYuR/mZiNU=;
        b=MGbqvh5pI9gn2olY8opW1WM1MDH9FoX/KbW/1De/L+SlRGcAAotYBlftbHV6MUw6Rs
         6UMLAHZWr3TE6tKf3B9oOS6QP7qc/ag87v+Omq1/mm42oMvk8GWa04E525tyUN569DMY
         xcn/TT56KUWn+UJ+Z501TKNLIBhJjVLqddQPLludkpLfLou6XsK2jM3r7VWKnMMnnedD
         JmTBP+QpDl793xDZWepcUO7D+0dV7Ye7ydHA44XIEXYz/M0amjBKpzpLYgA2Qshz579F
         pT8x0Ar5YF7Hmg5t8xhHeUKxGdvrbQ9M8skTlJX3uBroj7mKzRjpDtXxa/YM0Av7V2bT
         h2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+Uh3OM2UyPjAqXRs0MwDF+mqy/zbc7X8AYuR/mZiNU=;
        b=idR03oAPFqhiHW0aFtu2zdJehvqi6e/Yh1dFSoAwv8bVKP8r1AHRh2wCcXqIvUU2Wh
         kU4vhAZNO2VZXVCuFdhTV+HjR3UXluSkXHcExa7vfOTxiYs7b55MpwiAXmGjb53pZTFO
         9C0tTJoCKuyeUyRjp/ojvFjBpXIG4cF9VetNtm9AB3kpBPGliGsL+z65039Z6B7rVY7i
         6j51AuHnVdas3Hk3N0tYOdWqcwhlOIFzw/jkWqAsKdaLqSB1JhOy8EJnEBaiw+i8KhKK
         qFpb5FK48pTpmzVaXprTxhJZYGyJjuafbFJB6ARknXtJymkRGFWK9akUHOlGvOKHfrQK
         btVw==
X-Gm-Message-State: APjAAAX1q2nnOuvSUkn2dEmILxIgmnKkadhBzgdixyg54NUATdtAJO0T
        FSrpohT0oQ163RHr/noG3IQltgz7MyY=
X-Google-Smtp-Source: APXvYqzrM4bNSqSqu/oN3jG7vx9wldWk206mZGN4GH2VO+wsnvnBcq5X3XuK89afpwtKFankBN+f3g==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr145425023eda.100.1561470082679;
        Tue, 25 Jun 2019 06:41:22 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:22 -0700 (PDT)
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
Subject: [PATCH v6 15/15] Move core_partial_clone_filter_default to promisor-remote.c
Date:   Tue, 25 Jun 2019 15:40:39 +0200
Message-Id: <20190625134039.21707-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
index e34b9e66d2..a4d7f84eeb 100644
--- a/cache.h
+++ b/cache.h
@@ -961,7 +961,6 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
-extern const char *core_partial_clone_filter_default;
 extern int repository_format_worktree_config;
 
 /*
diff --git a/config.c b/config.c
index 296a6d9cc4..317b226bc8 100644
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
index 31d51bb50e..9bc296cdde 100644
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
2.22.0.229.ga13d9ffdf7.dirty

