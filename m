Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4E51F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeCCLjw (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:52 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40961 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLju (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:50 -0500
Received: by mail-pl0-f65.google.com with SMTP id k8-v6so7184442pli.8
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZznwJhZjVGkR1Y7sVHBOPBSx/5GvJGWfHHNV4ykvEA=;
        b=bqiQkyH/lYP7z2oKpCXH3+P1Q0HkWJO7nWEf54CQ2gBTnMh2dWGzmjNgTPH3UXPRYC
         J1UmEmEveZ+WKV10gJm4ro3mUVqu6G2XkzuMGR4jZnCSPcEAzoknJuudZmSEKabcxMNl
         hZx5kK3yUHDEyGVmHzlVgB/1sYx2k/hfIHilFGgz46Wyp8As2byAIDGwUmHbnAW/7GlL
         x5ZLOfRG9SF/51NFCJ4YrgIzCeqsB4vOmU6sI/SHg/poIaRl6msYRJO1msk9jXsUnPQ/
         2JiLpH6y1n7F51WAm1zQIMvqTlh8ywUN4KAhGYeT2m1GBEAlRsVtih9cfTevDaINiUt8
         9gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZznwJhZjVGkR1Y7sVHBOPBSx/5GvJGWfHHNV4ykvEA=;
        b=J/YAkX+B+gmGfVwmK5sYRHrEWUYiv0f9b1N9c2e8hADlnMpWZ/yqQNtIDBCgsZsd3B
         k2I/eT6PoHscGc+olPObEDTGOtiIUglPjvsvtyEUO9dmm3kfjink4DPfvptchE8phfXf
         a2PsSN0VvLCtbjJUsYC7SyR50FgUr1MNWMIVN21L4oeFahfhpIADQNKcd91KoPeFqQD6
         pC1BcrfpiMLgEnVRVAVSANyHC9Y+BwjrtxEX7a0huhnS4ISsVYP1up2M2H35IMdwPJtU
         a6JpqxzF4kOZUnod227RdW5qQPIHfqn9ui3La3e2aBw4Oopz0YmtoQC9bBr5pNjqrSmC
         G1nw==
X-Gm-Message-State: APf1xPChFOfKIuq1abYO/pvD6AsM6OiJtYSrp4Rq0Q24RAHHcfhyt/UR
        asHARJay1RymCvMegDhZZM+BgQ==
X-Google-Smtp-Source: AG47ELsaeniL5QEdMrMCs+UK+d+2MI/DxE4YGrZKfO3KS4MU2LfsNnUzQhw8BOeKe3FGzLu0Eff9Rw==
X-Received: by 2002:a17:902:b185:: with SMTP id s5-v6mr7937584plr.109.1520077189440;
        Sat, 03 Mar 2018 03:39:49 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id u21sm12572980pfg.60.2018.03.03.03.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 37/44] packfile: add repository argument to prepare_packed_git
Date:   Sat,  3 Mar 2018 18:36:30 +0700
Message-Id: <20180303113637.26518-38-pclouds@gmail.com>
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

Add a repository argument to allow prepare_packed_git callers to
be more specific about which repository to handle. See c28d027a52c
(sha1_file: add repository argument to link_alt_odb_entry, 2018-02-20)
for an explanation of the #define trick.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/count-objects.c  |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/gc.c             |  2 +-
 builtin/pack-objects.c   |  2 +-
 builtin/pack-redundant.c |  2 +-
 fast-import.c            |  2 +-
 http-backend.c           |  2 +-
 pack-bitmap.c            |  2 +-
 packfile.c               | 10 +++++-----
 packfile.h               |  3 ++-
 server-info.c            |  2 +-
 sha1_name.c              |  4 ++--
 12 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 5c7c3c6ae3..2793c98ed3 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -122,7 +122,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 		if (!get_packed_git(the_repository))
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b0abba6e04..7a3e323e9e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -726,7 +726,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 
 			if (show_progress) {
 				for (p = get_packed_git(the_repository); p;
diff --git a/builtin/gc.c b/builtin/gc.c
index dd30067ac1..526f06173e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -173,7 +173,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e5fde1d6b..6020a7e230 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3151,7 +3151,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d6d8a44959..bf42e164eb 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -630,7 +630,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 
 	if (load_all_packs)
 		load_all();
diff --git a/fast-import.c b/fast-import.c
index ec78e8ff47..985eb2eccc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3472,7 +3472,7 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index 22921d169a..659ddfb5f1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -518,7 +518,7 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index abed43cdb5..01c9cd1642 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -335,7 +335,7 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index d7658e6c45..b5ad6838f8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -816,7 +816,7 @@ unsigned long approximate_object_count(void)
 		unsigned long count;
 		struct packed_git *p;
 
-		prepare_packed_git();
+		prepare_packed_git(the_repository);
 		count = 0;
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -883,7 +883,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git(void)
+void prepare_packed_git_the_repository(void)
 {
 	struct alternate_object_database *alt;
 
@@ -902,7 +902,7 @@ void reprepare_packed_git(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 }
 
 struct packed_git *get_packed_git(struct repository *r)
@@ -1853,7 +1853,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (!the_repository->objects.packed_git)
 		return 0;
 
@@ -1907,7 +1907,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
diff --git a/packfile.h b/packfile.h
index 77442172f0..3f59456e7e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(void);
+#define prepare_packed_git(r) prepare_packed_git_##r()
+extern void prepare_packed_git_the_repository(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
diff --git a/server-info.c b/server-info.c
index 6fe64ede17..9604772522 100644
--- a/server-info.c
+++ b/server-info.c
@@ -200,7 +200,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index 2065be90d2..cb42e398b2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -195,7 +195,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -566,7 +566,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.16.1.435.g8f24da2e1a

