Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE751F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCWRWr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38493 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeCWRV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id y2-v6so19396170lfc.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61ueaF1i2Lsl58cdCsUaSTpoeie1hg6FEP372ewWy2E=;
        b=XkVEwFIvzN/Ze1IrrbClQN78HlifTDbEkZquZBzF9UAFOoLZEAWfOjzHvM7Wy2BfSR
         aPDPUB/KSPBajlN7O96qWJjYIrbNSris5m7lI58FilvHSdKzFpvndd1Vcch89CB2sX1m
         lA7SI2r2SXSaHeKLkOEW/EpR25E9/WDzsWRrJJPxfqHFZsZfIjJKUiDa10xU7eBeD5Wn
         3dI/R+kp9u8zSzSacRylGm6pkRUZbu47QRD/NsH4EACtXkhs3Ud5bXoAURmZmaY/gfsb
         8LVd5T7Ud3/l7fb2QETYRME6nzhFb/Ghvb+Z7w0dO6VeoBn6trl2IPh5JU2FWJD0sYFf
         3Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61ueaF1i2Lsl58cdCsUaSTpoeie1hg6FEP372ewWy2E=;
        b=FQ9QaRXvYg+5r9fa61+dR4mGGNrskgkPjr7KOG5UV8EsO/Mj54WzxZwCKf1ZkDVZ8D
         Dpbv+Jrbn5Z/Zr2stY8KfkK6/nWw86CKnTMxxS3o/Y6pJAz6ePM0fUV0MrwmgWFTTYeQ
         DOI2Lq+VG4Tz+30+stkrAJynSmh/wJawh+OYJlfOOV9iwoYPtEUTteTIswwfhnXz3p7q
         xzEbyNaC+CxCPFM1ay1/2yOa9LMQw2oPFoeSs//Pj3rO+kqaqawZbALeKZxxsTEEQD2p
         bHQNtALJMi8oUasDvunGlAtn3EKwU6yCzTqqMr5WadyANOBZIbZY/qUZcEtwTN3jpUiz
         qCQQ==
X-Gm-Message-State: AElRT7E1NDZq4xj7fvI+DFywztO1rCCUVrjA9BSyS4XnSRQOFxfLxdUd
        Yw9WCIFd7Zyl/667lRKskbs=
X-Google-Smtp-Source: AIpwx4/GaG+itBXYKBTikCT7qD55AxtDXugD2+ghw84IRxF+LtM+n8nITzaTTU5AE91r9d8qJZ38ng==
X-Received: by 2002:a19:e1c5:: with SMTP id l66-v6mr2494746lfk.125.1521825716784;
        Fri, 23 Mar 2018 10:21:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/27] sha1_file: add repository argument to prepare_alt_odb
Date:   Fri, 23 Mar 2018 18:21:07 +0100
Message-Id: <20180323172121.17725-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
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
 sha1_file.c    | 12 ++++++------
 sha1_name.c    |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7707407275..3ef25fab97 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -719,7 +719,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		alt_odb_list = the_repository->objects->alt_odb_list;
 		for (alt = alt_odb_list; alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/object-store.h b/object-store.h
index b53e125902..79de470639 100644
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
index b0b24ea9b8..17170fc662 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,7 +890,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects->packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index ba4fc9103b..0fac75bd31 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -582,7 +582,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -668,7 +668,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects->alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -677,7 +677,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	if (the_repository->objects->alt_odb_tail)
 		return;
@@ -728,7 +728,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -887,7 +887,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -918,7 +918,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index ffff7d8710..4325f74e0c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -354,7 +354,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

