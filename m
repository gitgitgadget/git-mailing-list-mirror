Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F141F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeDNP1H (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35297 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeDNP1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:27:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id b189-v6so16406972lfe.2
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMFgMzUD+cEx5ejrQyWE8QA/cT3BD2NsxF2gIwqlb0s=;
        b=B7sVx1s+dCtLszUJoSVarpT2adJ0b8axws9gh45vzNYpbPu6yNICmpTJyBs6NYgo3T
         fWxnV4k4wxwRGQrA/Ee637WxXsgiNT6Xt9jOp3NOHLEVvZRicIY8itY3b8z9ISxZX9gt
         jPw0OBRTdI934iuaAzBImiywozrMMjI0WApGzj5n0Vvvo7kk0oP78V5IKm/65DSJDISD
         xSQP8zpO/dEhvv0RFQ3QzaplNRXpjJ0tLusG5tkxHSybp56u0n+rvHrsLyPdlHcsnJhA
         Ym1UXWD3YY+v371Cx2sB0WGAe72aJ40gl/nzaR3wWZOdQwFS4nl8BY1B01rfdbv7ogIf
         SF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMFgMzUD+cEx5ejrQyWE8QA/cT3BD2NsxF2gIwqlb0s=;
        b=MYia5qBRAB/i2XjP9B3ZQYnSo/U7RcTEE+FtpSWUNtAywY/al3QksGeH/EW6e3r00l
         L47a1o61VmK7euuE7px4Nq0JqxENw3jxl/dBeHR+yTwHCwW6WlFCeutecIxWPaSHG2fL
         wwXTOsgWu5Pm36par3Vw1LI9STBvnpxlsavL+oAzdezQIRb4UqhG7BZUWk8smk9FbG8l
         AibgoK3eUf2sWlRaEy8mVXm24rFCNYcYzuKs7Oq8Of//A+00XxJGd9htNfVf7CiFASLJ
         iwXK4vYfRquyCrWwJgrv3Rr0w3MzkzFxYY0CWfl7iyTLQfXoRwtfE3q8igjUkqwwXQ4H
         ycZA==
X-Gm-Message-State: ALQs6tBWEZr9ggWRBd8Z0uXfeibz9I/8UXe3ntLb9gFPrIzZlRHv7n2n
        9/uxkPIn5dTCcuPSo2dIPiOLHQ==
X-Google-Smtp-Source: AIpwx4/ZqGDoKxKObKJiuTnh6Zk0o1cAVjbwlfwKGrexrCVA//DawjYKX/oAbGRD7a0LIzN+lW6KWg==
X-Received: by 2002:a19:ca10:: with SMTP id a16-v6mr10327959lfg.25.1523719621839;
        Sat, 14 Apr 2018 08:27:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:27:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/7] gc: add --keep-largest-pack option
Date:   Sat, 14 Apr 2018 17:26:38 +0200
Message-Id: <20180414152642.4666-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new repack mode that combines everything into a secondary
pack, leaving the largest pack alone.

This could help reduce memory pressure. On linux-2.6.git, valgrind
massif reports 1.6GB heap in "pack all" case, and 535MB in "pack
all except the base pack" case. We save roughly 1GB memory by
excluding the base pack.

This should also lower I/O because we don't have to rewrite a giant
pack every time (e.g. for linux-2.6.git that's a 1.4GB pack file)..

PS. The use of string_list here seems overkill, but we'll need it in
the next patch...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt |  6 +++++-
 builtin/gc.c             | 45 ++++++++++++++++++++++++++++++++++++----
 t/t6500-gc.sh            | 25 ++++++++++++++++++++++
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 3126e0dd00..8f903231da 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
@@ -84,6 +84,10 @@ be performed as well.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
+--keep-largest-pack::
+	All packs except the largest pack and those marked with a
+	`.keep` files are consolidated into a single pack.
+
 Configuration
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 3e67124eaa..f251662a8f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -166,6 +166,22 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static void find_base_packs(struct string_list *packs)
+{
+	struct packed_git *p, *base = NULL;
+
+	for (p = get_packed_git(the_repository); p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		if (!base || base->pack_size < p->pack_size) {
+			base = p;
+		}
+	}
+
+	if (base)
+		string_list_append(packs, base->pack_name);
+}
+
 static int too_many_packs(void)
 {
 	struct packed_git *p;
@@ -188,7 +204,13 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
-static void add_repack_all_option(void)
+static int keep_one_pack(struct string_list_item *item, void *data)
+{
+	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	return 0;
+}
+
+static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
@@ -197,6 +219,9 @@ static void add_repack_all_option(void)
 		if (prune_expire)
 			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
+
+	if (keep_pack)
+		for_each_string_list(keep_pack, keep_one_pack, NULL);
 }
 
 static void add_repack_incremental_option(void)
@@ -220,7 +245,7 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs())
-		add_repack_all_option();
+		add_repack_all_option(NULL);
 	else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
@@ -354,6 +379,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	int keep_base_pack = -1;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -366,6 +392,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
+			 N_("repack all other packs except the largest pack")),
 		OPT_END()
 	};
 
@@ -431,8 +459,17 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			 */
 			daemonized = !daemonize();
 		}
-	} else
-		add_repack_all_option();
+	} else {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (keep_base_pack != -1) {
+			if (keep_base_pack)
+				find_base_packs(&keep_pack);
+		}
+
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
+	}
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index d5255dd576..c42f60bc5b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,6 +43,31 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'gc --keep-largest-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		test_commit four &&
+		git repack -d &&
+		test_commit five &&
+		git repack -d &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 3 pack-list &&
+		git gc --keep-largest-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
-- 
2.17.0.367.g5dd2e386c3

