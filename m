Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C293D2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcF0SZp (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36618 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF0SZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so26938858wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2bkNRXUwdExnFoPCrYxiWz77eWjmdXhAdfdBK6tHK0=;
        b=Conr34oX/qpQPqHC93SSPOeP+4Kl0sus9+8rhQnBA+Ifm1n//8mWgvTkbLojqZSVug
         y2ODRJ4nG8mJL98KmUtpkmSnphdTlzK1BG0uKbU4XfNq4EDtDCuJ7KK0kz0dXj2XKygs
         nJ24LF7/9elkTU5heHEdqznw7tGxX8/dddNxXiKyIxzrN0oVm5A43tOa/pi9RPkqq1M9
         krTqR1rmVlzqLjFRND0lPdW4FtNIoTWQ7YbBYtZnGrM2l3R+NZLDgDq/PfFQ0cjVhoVa
         nz7+qyCvraFCbchZaL+KDyWQV7rLxtkMwzSN7M2WDvrZEm+L6xqrig67fzA5hfdYeI1X
         fHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2bkNRXUwdExnFoPCrYxiWz77eWjmdXhAdfdBK6tHK0=;
        b=h7GmLCEZszUYeZ7WHFGZQr2CbyHROLr+0ruv/OLHiib2ETK7ya0Ryn0PuTRsIQaoJb
         7p/1wfePowoq+1zLZ5qpXqF8MQ872oz6MeYSDT3hPBYlKXtm1+AwNK9dqfeGcoCZWtxf
         fVdjmA8I7YMNWgaqXTG7ILxfmHx42IpqiHXvWWagGB+jIDMVPxsUmFM4V/H1zXAxgbto
         MTdwCFHlaixWNwRD/MxvEEk8KxvdwdEa0NUhZhRhKA2gg7M6JGx7LyvGPArLTc2cO48z
         0a0ui8LCukCzouTBP+IO8vRF85kYTLKIeuTp11wRou6/b4V8Msjp9jOcNpPBHIeymyvB
         1A4A==
X-Gm-Message-State: ALyK8tLxH9SeTOEk0QkvIJXN0jumntWmQp7mBJgf7qzsbrBprzqkEv4LwAlXZAWn1StjAw==
X-Received: by 10.194.241.164 with SMTP id wj4mr2151523wjc.7.1467051919291;
        Mon, 27 Jun 2016 11:25:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:18 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 21/41] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:09 +0200
Message-Id: <20160627182429.31550-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cb3ef1c..b0fd5f7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4224,7 +4224,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4232,7 +4232,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4247,9 +4247,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4263,9 +4268,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(128);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.9.0.172.gfb57a78

