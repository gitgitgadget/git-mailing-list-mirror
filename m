Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC72B1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfI3Bvp (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45471 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bvo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so6386757qkb.12
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZfDqgFYsaqy0pboOGfXHX5w1U2DUJ/RUk17H0TOAIU=;
        b=q0yYY3CfNrEEkSGYlZSClpXp8xK3H8w3fk1Q5aSnoJ/BVngvxYI8lc4CKbf6vJllL7
         P4zVARGUBlXlhGvf9tnOjUEBUsG7jwEcZesGGxfv7iqj216r9Nc9Qel/I7wha3e7D/+6
         XMWMc5HVWFH9UZx2tHXZikhVvVfx391oyAV4dq6YomX5fVwlIcCOOG0i9bidUn0gMuOY
         wDWvNtVPSNu6Twvkz+k4rgB7bL0I3GPDaaRxRcti7aWAFdhi7w6oBZ8PWAGd0vilkCuk
         U8E9TOhFChzeqnqpQNK/Zy+h8E9oAc40PSWxUzyeWHEmLh994c802/rCuNLXN8sohfpg
         kITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZfDqgFYsaqy0pboOGfXHX5w1U2DUJ/RUk17H0TOAIU=;
        b=LYUGjLiX1VA0cjMKWj/WKhUR5oQ/WriEEj3lvrrgMKLjojJuyobF/+wv2HmPWQ6Uvx
         lTCMStfzvDhCsw83im+ysWS9cQx35lRjsvVc2a5p18ybHaFvyCfkFQjwUaitJi4gE5AO
         +ePAHPRkKmL7eChkikxRpb1ZpUgOGHiw+8e5c5tFu6j2cJE11J6ZEFGubgK+dch4X20q
         0VcOOGB1UrH9uzXgcDGQKV2aHU8+LZU7GeyLs0kYrwKejydnZ12iKj3QaDvgfBo6m4I/
         TTwjX3UxI8qprRoeKBV6zioJPNBQqFZzukn2+gHd/n+g9ogdvx9fSBKSm45JRaGnnlOI
         f+oQ==
X-Gm-Message-State: APjAAAWTUMjeCCthLmJyyO0DcmaSwgOVSuPe4vsqoqwfNV6JeQGlA3WN
        E2RzOKO06pRLYR2YBSsTFsEtQh4SO+o=
X-Google-Smtp-Source: APXvYqxsMN7rHwobtV5e+WRVuYlEvbdGXux8lQ8X2KmSVPkxqBhlrxX0RkOswycGz+eU52+d0xdtgA==
X-Received: by 2002:a37:a410:: with SMTP id n16mr16804090qke.429.1569808303498;
        Sun, 29 Sep 2019 18:51:43 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:43 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v2 09/11] grep: protect packed_git [re-]initialization
Date:   Sun, 29 Sep 2019 22:50:55 -0300
Message-Id: <ede35868d797ea5a3560422afe7280e977bc9f59.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some fields in struct raw_object_store are lazy initialized by the
thread-unsafe packfile.c:prepare_packed_git(). Although this function is
present in the call stack of git-grep threads, all paths to it are
currently protected by obj_read_lock() (and the main thread usually
indirectly calls it before firing the worker threads, anyway). However,
it's possible that future modifications add new unprotected paths to it,
introducing a race condition. Because errors derived from it wouldn't
happen often, it could be hard to detect. So to prevent future
headaches, let's force eager initialization of packed_git when setting
git-grep up. There'll be a small overhead in the cases where we didn't
really needed to prepare packed_git during execution but this shouldn't
be very noticeable.

Also, packed_git may be re-initialized by
packfile.c:reprepare_packed_git(). Again, all paths to it in git-grep
are already protected by obj_read_lock() but it may suffer from the same
problem in the future. So let's also internally protect it with
obj_read_lock() (which is a recursive mutex).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 8 ++++++--
 packfile.c     | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index c973ac46a7..0947596bcd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,6 +24,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "object-store.h"
+#include "packfile.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -1074,11 +1075,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			skip_first_line = 1;
 
 		/*
-		 * Pre-read gitmodules (if not read already) to prevent racy
-		 * lazy reading in worker threads.
+		 * Pre-read gitmodules (if not read already) and force eager
+		 * initialization of packed_git to prevent racy lazy
+		 * reading/initialization once worker threads are started.
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
+		if (startup_info->have_repository)
+			(void)get_packed_git(the_repository);
 
 		start_threads(&opt);
 	} else {
diff --git a/packfile.c b/packfile.c
index a336972174..5b32dac4ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1016,12 +1016,14 @@ void reprepare_packed_git(struct repository *r)
 {
 	struct object_directory *odb;
 
+	obj_read_lock();
 	for (odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
 	prepare_packed_git(r);
+	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
-- 
2.23.0

