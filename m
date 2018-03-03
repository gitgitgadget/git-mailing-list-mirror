Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C901F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeCCLhm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:42 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44079 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeCCLhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:40 -0500
Received: by mail-pl0-f67.google.com with SMTP id 9-v6so1682064ple.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrJSa4q2aD9j19icE/ntk32JsKkvGK4YWTwbpKAdmUE=;
        b=d3cHObUCzt5Se0S25SzPyZecWN182YzRlXcFVuRmyVtIr6mW9nHjhh59SlogLrmikU
         LuKSIeg191uKsI+Y0iqiIujPKrXnrhy+dY+UuxCZfJlkLvOzROs0TGSYAvewnLfY8jQv
         LdOMU2N/kGjoYJuOx3C610ZeHaICQiLtY6e8PyrbKBK7QsJX/PXJwi/ITOW2ZFWpJ7xF
         CZICCyDI9Z2OjJRsvZK9IhdS7jLleKIT2oEwL6jq58/lKp5WrDdTVduMk2H8kClh+wFV
         yU4KWmAd4eRJQo0uwkyGN0QK8VnTXuSyzKR4T4sG72MdUmlTtshysnhqRGacmX95i+1E
         GbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrJSa4q2aD9j19icE/ntk32JsKkvGK4YWTwbpKAdmUE=;
        b=jBp4E74lRkHFEyXfUxyhV4sgev2BFT2ukyfmoTMo2SPzx+QxSI2d30glV7fA7fk3Gs
         8q1W404aJe/g5aXT8K+p2MuaU142jRf7dSNJD/m4HtFBcGtJJppRaOu7xPFwVHri2mLg
         r9YjN3B+69pKd2LgqApZEAhA4o14vfaS09FkfWhLCX1NCPs1NfPDvVoC50u83jbT+bdw
         Yp3lU5cGg5382+ddRkijs2yz1wK732YCcAl0zOszSRzW81ZCVIe0kRGsZKB4e/QdlX7t
         Svp7LrP8TIXJlunT+KdvMCSMeTbwv3Uc3IOP64mnKKKCMAxX4yWFQkX2Uf9FAxGKVkny
         bzXw==
X-Gm-Message-State: APf1xPDRCbq0uprmUFfXN5fmqjVWByIPXlOPYuPiFJIhCEMyIdX/tO/Z
        3OVMMTcBkc1kZ0JDCTKULckx3Q==
X-Google-Smtp-Source: AG47ELuVS4n7XYYOA+7CKRG7Oa0AgsldLIRo3uzPK2kL0gF7LmT5hpc3O8UwG8+Gg3aA9CU6dTcfBw==
X-Received: by 2002:a17:902:5203:: with SMTP id z3-v6mr8133563plh.392.1520077060260;
        Sat, 03 Mar 2018 03:37:40 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x1sm17582536pfk.144.2018.03.03.03.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/44] object-store: close all packs upon clearing the object store
Date:   Sat,  3 Mar 2018 18:36:04 +0700
Message-Id: <20180303113637.26518-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c           | 2 +-
 builtin/clone.c        | 2 +-
 builtin/fetch.c        | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 object.c               | 7 +++----
 packfile.c             | 4 ++--
 packfile.h             | 2 +-
 8 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5bdd2d7578..4762a702e3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1859,7 +1859,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_all_packs();
+		close_all_packs(&the_repository->objects);
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 101c27a593..13cfaa6488 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1217,7 +1217,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs();
+		close_all_packs(&the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..4d72efca78 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs();
+	close_all_packs(&the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..907ae44ab5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -411,7 +411,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_all_packs();
+			close_all_packs(&the_repository->objects);
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f52..ac478b7b99 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2026,7 +2026,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.git_cmd = 1;
 			proc.argv = argv_gc_auto;
 
-			close_all_packs();
+			close_all_packs(&the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
diff --git a/object.c b/object.c
index 83be6b1ecb..60ca76b285 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "packfile.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -475,8 +476,6 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->alt_odb_tail = NULL;
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
-	/*
-	 * TODO: call close_all_packs once migrated to
-	 * take an object store argument
-	 */
+	close_all_packs(o);
+	o->packed_git = NULL;
 }
diff --git a/packfile.c b/packfile.c
index d3c4a12ae0..1e38334ba2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -310,11 +310,11 @@ static void close_pack(struct packed_git *p)
 	close_pack_index(p);
 }
 
-void close_all_packs(void)
+void close_all_packs(struct raw_object_store *o)
 {
 	struct packed_git *p;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = o->packed_git; p; p = p->next)
 		if (p->do_not_close)
 			die("BUG: want to close pack marked 'do-not-close'");
 		else
diff --git a/packfile.h b/packfile.h
index 76496226bb..5b1ce00f84 100644
--- a/packfile.h
+++ b/packfile.h
@@ -66,7 +66,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
+extern void close_all_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.16.1.435.g8f24da2e1a

