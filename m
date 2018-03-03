Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CAB1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCCLkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:25 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35164 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCCLkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:40:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id l131so4866465pga.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmflhrT5X6/Ptfdfj6tGgai6qpeolm9M7w2ySsuUex0=;
        b=bYGY2cSC1lAS76G8Cvhyr3dhV6sdApa4R0GgWDMgbmqAG/JIlfjjFEeGTEBhu/e4Bf
         ev1xVbJtRYIzfVTN2ls/cv416sEnefuUWlRdal3IhKZh0Bv/SnDRvdF8EB05ccNgUsXC
         /eKI9EGD1bwWMFsbl5dd19RRDeKzl9pBa58WU/gkJ4lCyI7XLDt6DpgLMnIbKv1dNnEB
         v3tzt65ZwttQOFn8dWnhCnCFe02bDYXxC9vJYvif6KDbmDYiCIvEP1m6rYjmnw3y+A2a
         pq3WIPG5ZJ2sh6PW0dkBG2DKp/E5LgLhum9ewidpbYV2wr9KDIKp4r9C6yMCCxC7x5LU
         4p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmflhrT5X6/Ptfdfj6tGgai6qpeolm9M7w2ySsuUex0=;
        b=H7n+vUk2/vE9HhcM2fJn746ZYfJwBv9BRqUSB6KcYa6A9mLNQTQQuqVw4snpsAH7nQ
         8FGMSOWyWs/4q7RlUKfBdrmo3ky67vhL6IfMnkVnI6zO9taSJvsmiRnkRVQ8Fn5jCv4A
         9biDefcTe0gJsfjOJiGUgGntbauZBMq6maNBw+dkfxkaqpyqRZGpVS0hrJXTSRTAJFyF
         mn1zWWUXpF6mrXDhxTk3hi53NWy5JZp99cVo1poOYef39Or6TbKwUYv7PZpTX8vvAmpg
         jGXSTyRnYwl3xmZTxVnlLMWhJs/hz23hE5Sl/I4JxlTlILYvYrD9c3LKwWdA5VL6b2xw
         D7kw==
X-Gm-Message-State: APf1xPApah8w1wlxBYBnu/11xKfrxHkl8QReuYUqa3NCB2+R73O89Q0r
        IY4iVKXAtYJW51S3oI1+oEICzw==
X-Google-Smtp-Source: AG47ELts9b6XAo26luMVyQplU3+E9DyLUTgSFFalhTUcXBF1OmyFcmSiPqQSldlRc2UoNoCs2BITVw==
X-Received: by 10.99.170.5 with SMTP id e5mr6806406pgf.92.1520077223224;
        Sat, 03 Mar 2018 03:40:23 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n13sm17739348pfg.45.2018.03.03.03.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:40:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:40:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 44/44] packfile: keep prepare_packed_git() private
Date:   Sat,  3 Mar 2018 18:36:37 +0700
Message-Id: <20180303113637.26518-45-pclouds@gmail.com>
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

The reason callers have to call this is to make sure either packed_git
or packed_git_mru pointers are initialized since we don't do that by
default. Sometimes it's hard to see this connection between where the
function is called and where packed_git pointer is used (sometimes in
separate functions).

Keep this dependency internal because now all access to packed_git and
packed_git_mru must go through get_xxx() wrappers.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/count-objects.c  | 3 +--
 builtin/fsck.c           | 2 --
 builtin/gc.c             | 1 -
 builtin/pack-objects.c   | 1 -
 builtin/pack-redundant.c | 2 --
 fast-import.c            | 1 -
 http-backend.c           | 1 -
 pack-bitmap.c            | 1 -
 packfile.c               | 5 ++++-
 packfile.h               | 1 -
 server-info.c            | 1 -
 sha1_name.c              | 2 --
 12 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 2793c98ed3..ee6ae35244 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -121,8 +121,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
-		if (!get_packed_git(the_repository))
-			prepare_packed_git(the_repository);
+
 		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a3e323e9e..9911c52bc8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -726,8 +726,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git(the_repository);
-
 			if (show_progress) {
 				for (p = get_packed_git(the_repository); p;
 				     p = p->next) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 560d58daec..be63bec09c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -173,7 +173,6 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git(the_repository);
 	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6020a7e230..435f091a69 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3151,7 +3151,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index bf42e164eb..02b5f0becc 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -630,8 +630,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git(the_repository);
-
 	if (load_all_packs)
 		load_all();
 	else
diff --git a/fast-import.c b/fast-import.c
index 985eb2eccc..2298bfcdfd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3472,7 +3472,6 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index 659ddfb5f1..22d2e1668e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -518,7 +518,6 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 01c9cd1642..2a007b5539 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -335,7 +335,6 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index bafe81544d..773cd99a13 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,6 +802,7 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	strbuf_release(&path);
 }
 
+static void prepare_packed_git(struct repository *r);
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -882,7 +883,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git(struct repository *r)
+static void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
@@ -906,11 +907,13 @@ void reprepare_packed_git(struct repository *r)
 
 struct packed_git *get_packed_git(struct repository *r)
 {
+	prepare_packed_git(r);
 	return r->objects.packed_git;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
+	prepare_packed_git(r);
 	return &r->objects.packed_git_mru;
 }
 
diff --git a/packfile.h b/packfile.h
index fe1a6380e6..efda10329c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,6 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(struct repository *r);
 extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
diff --git a/server-info.c b/server-info.c
index 9604772522..af737acd24 100644
--- a/server-info.c
+++ b/server-info.c
@@ -200,7 +200,6 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index cb42e398b2..f25a0970ca 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -195,7 +195,6 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -566,7 +565,6 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.16.1.435.g8f24da2e1a

