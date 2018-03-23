Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E80A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeCWRpw (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43394 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCWRpu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id v207-v6so19491195lfa.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBbjmbQPxWDR7pHjA5ZvsyGfKk3VhE19G7QXokvZnjQ=;
        b=rPz310xgx8y4iRh4HfTjcQrjdwE1ptx9wqR9Nak/G+kNUxS6wjrQVW0umYtczORWad
         LnmdRGtvxjBCACzleNAFykPGVrr3KHYJwYAprMgp9xKV15p1V+AVEY2UNqsA/wSOYKA2
         S+lCW5ul03SIqHQcH4eZmoN9jChKR5IluGqeGQjjl1qWdTC7H/eT6CVCo2tIVSRcfUxy
         zPwz4N5QHrz/Zdc4wJ1CoaXUcNOdDJqxd0WVlXHZGMXB8oc7Df2no01WHsbxIGJqO4Nh
         QpsVe1O1DyX6isbiFO4ZRFNxWtqFDxyUU7rDXHslqxnXYd01IevD+CUiu6mZqiwO6cJ6
         +yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBbjmbQPxWDR7pHjA5ZvsyGfKk3VhE19G7QXokvZnjQ=;
        b=VCx3Bx8OT3dz8lMrgB+tlIXGRnX4meaMRbjfos/UmpejYjMqlwm3Xg23xXc1nkIoUF
         KvcN+FLnB0GXdSX5UeE7DLwBtmEPRoxzVUu82mmw0/q1mOwbLZau3yWbH+XeW0NkYEVn
         llrGIj2F3UUJGE89nqkyBQsLmYWLqJp8S+xfWqpDXuuQhms2IQJKzAS9lckmXe+/0xSE
         NviiKFPsK6DjXRSreZfudZ+b2ZvnrXkqJfSRWp0iNTlUDPQReXeDyHlCNn0PFrjwrhLo
         c+9b16CK8BbNSW+4tRct9IA5lF1yfv55d4u85GlyZJQxkbqaD1zHnEJXSaFADFa1AHCn
         loPg==
X-Gm-Message-State: AElRT7GkIXR7Ld/3v4XAPjYiIei4LVdK3kCvARY2LNFGVQXNy1n1bjc4
        tE/flJaABt/5wY/8ADgqQsI=
X-Google-Smtp-Source: AG47ELuhfseSHjmTaeFCcWtlxXuSyQEQBCxp6bxCswxFNTYRFROYZOVTNCaURhAemLmpyKRQm2bxDA==
X-Received: by 2002:a19:cbd5:: with SMTP id b204-v6mr20881450lfg.116.1521827148717;
        Fri, 23 Mar 2018 10:45:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/12] packfile: add repository argument to reprepare_packed_git
Date:   Fri, 23 Mar 2018 18:45:21 +0100
Message-Id: <20180323174527.30337-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c           | 2 +-
 builtin/receive-pack.c | 3 ++-
 bulk-checkin.c         | 3 ++-
 fetch-pack.c           | 3 ++-
 packfile.c             | 2 +-
 packfile.h             | 3 ++-
 sha1_file.c            | 2 +-
 7 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4c7409946e..a78dad51aa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -478,7 +478,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return error(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a298a6711..469b916707 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "pack.h"
@@ -1777,7 +1778,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = finish_command(&child);
 		if (status)
 			return "index-pack abnormal exit";
-		reprepare_packed_git();
+		reprepare_packed_git(the_repository);
 	}
 	return NULL;
 }
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 3310fd210a..eadc2d5172 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
@@ -57,7 +58,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 }
 
 static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
diff --git a/fetch-pack.c b/fetch-pack.c
index 8253d746e0..eac5928a27 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "refs.h"
@@ -1192,7 +1193,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	prepare_shallow_info(&si, shallow);
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
diff --git a/packfile.c b/packfile.c
index bb090f8a29..1b4296277a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -899,7 +899,7 @@ void prepare_packed_git_the_repository(void)
 	the_repository->objects->packed_git_initialized = 1;
 }
 
-void reprepare_packed_git(void)
+void reprepare_packed_git_the_repository(void)
 {
 	the_repository->objects->approximate_object_count_valid = 0;
 	the_repository->objects->packed_git_initialized = 0;
diff --git a/packfile.h b/packfile.h
index 3f59456e7e..ab5046938c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,7 +36,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 #define prepare_packed_git(r) prepare_packed_git_##r()
 extern void prepare_packed_git_the_repository(void);
-extern void reprepare_packed_git(void);
+#define reprepare_packed_git(r) reprepare_packed_git_##r()
+extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
diff --git a/sha1_file.c b/sha1_file.c
index 0989bbd948..9c024cd957 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1274,7 +1274,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
+		reprepare_packed_git(the_repository);
 		if (find_pack_entry(real, &e))
 			break;
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

