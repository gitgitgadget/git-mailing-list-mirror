Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48B11F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeCCLiR (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:17 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36104 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:16 -0500
Received: by mail-pg0-f66.google.com with SMTP id i14so4872486pgv.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28rtqbL4qSphcGxHjEYteUB0wnt5Pu3K+4FZ2qKVrnI=;
        b=sxJmtg6X9P0Ge34eb2W5n+mSvXRDfjFgm4eF1BvZkBLzdsiUJWbDxFKsfeDG6mqgU3
         mmPoKYH3fBIWneIJWE4K7AA46SsLvCC3YSR3ghLYgdtu40VYDrw6OQgAwNJvJWPrxrEH
         wTcVW0C1ZdG5QYSOKmUz997oz6cbZmHNskYtqQBrFb6dpVYUQzXg4Ogl92263ke2ZnSM
         ZZQs0zNQPkaNBFqVLv+1YMtDpxInR+ll5Fyo46G4+j/b+qJ3XeXJzFSlfFwONW3VkTsL
         S+B2tbar47jYr5DP1IrzNHgG0gGtso1p8Y2JOY9xUwdPuqg5bajY52C8fpMYePh3EZxE
         zbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28rtqbL4qSphcGxHjEYteUB0wnt5Pu3K+4FZ2qKVrnI=;
        b=pZvTabLmDfRPwlZod13xrtc4Iwoj+TUwMs3zWBGsQfadufA6ED/EPpZs6W377rxdQe
         ujLzooAzZqmIq9fKVCNxIKELOHE8+/5UyhZ4TG34BnJgRuJVFaNfEgmD9qSvX0Luzf+q
         PcbvcrplGUU9S8Rf0txMihgt2B88xr5T+CdTeV/27FLPiOKjnITu/H6lqBKQUMbszs4n
         sCcn6ZmY5SKPyh5xvvpFAjo9VpSR/tzgTqWDqkDuBOKT3vj+9Ut0346Dfp/1+Tn8h2Dk
         J+mV8to/vX9Ffa+TFEoGCFs6znlDeybLx1dGFlk1OLTggvYYDbAoo0hjw/4z4EnCMdSM
         j2bA==
X-Gm-Message-State: APf1xPDvrvy5l6wPhD87detyyomMJk1pb2l5vErUKvnd/MarxWNSKX3Z
        YU05vFW+9AWCC+YHVKdQ4IGq/Q==
X-Google-Smtp-Source: AG47ELvqLQWoj+maSu+uRYhX/SLJ/9NUtm2KX7v9ZqMXSDD8G8mYRPNeL63rnb6RbuT6MhDv5J8Eww==
X-Received: by 10.98.16.23 with SMTP id y23mr8800341pfi.84.1520077095453;
        Sat, 03 Mar 2018 03:38:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t20sm15876648pfh.182.2018.03.03.03.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/44] sha1_file: add repository argument to prepare_alt_odb
Date:   Sat,  3 Mar 2018 18:36:11 +0700
Message-Id: <20180303113637.26518-19-pclouds@gmail.com>
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

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c |  2 +-
 object-store.h |  3 ++-
 packfile.c     |  2 +-
 sha1_file.c    | 13 +++++++------
 sha1_name.c    |  2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7aca9699f6..b0abba6e04 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -716,7 +716,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 		     alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/object-store.h b/object-store.h
index 56ed4bd9e9..3d0f8a87cb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -20,7 +20,8 @@ struct alternate_object_database {
 
 	char path[FLEX_ARRAY];
 };
-void prepare_alt_odb(void);
+#define prepare_alt_odb(r) prepare_alt_odb_##r()
+void prepare_alt_odb_the_repository(void);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/packfile.c b/packfile.c
index ce4cd7d5c9..a0842521e5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -889,7 +889,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index 4f9c07b547..027e0f3741 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
@@ -581,7 +582,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -667,7 +668,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -676,7 +677,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	if (the_repository->objects.alt_odb_tail)
 		return;
@@ -726,7 +727,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -885,7 +886,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -916,7 +917,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index bd4d7352ce..2065be90d2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -353,7 +353,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.16.1.435.g8f24da2e1a

