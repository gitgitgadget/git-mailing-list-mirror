Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0B21F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeCCLj5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:57 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40967 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLjz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:55 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8-v6so7184501pli.8
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikKevR0RMcHGWd8NIz82Eg++MMo6QinOHcQckogn1/Y=;
        b=k2E73JFsOSD/TN22GiQYblFGHO3phXsJoEHMbyUsoK+DB6NiAb2BHu/Exul0RIM+Vx
         LiRMzYkQZqOAQUiFmlSrD5DRpBpPB0UAqlI5XfF2bbD6LaEh8WqJltcDkkLSQuuD5J4L
         U3rch3vIpb574flI9651xB7WlqtwAbbZ2E7WRjCqifTMA4mpJjBRJmBFVawwm99/0VZo
         vO5U6dS823ZnvsmaF8sI9NB3yD7bNeRcXG+N3xmwB6IpE8NGV1RdZk8NDGf7fiPdXH/w
         AT50917iB6S5Jf1rqLXnBzDLmfr3p/awloAN9/uYyPjGmFBA5G+rY6RC6/5iH1OMrh+o
         rOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikKevR0RMcHGWd8NIz82Eg++MMo6QinOHcQckogn1/Y=;
        b=Arl7SbIJc8v1QL3B8QemiAKkg+WID0NrOMJS2ro1VvvzqwPZDbN8yzWgrisqmMgf9d
         wlOn21SxY5bJFhqwsH9XMxu5N+Wsp7Wzg0qsjQ7WZ5fLXw3cwzmhL0W6FZVJCeoaA3Un
         nfmXIWiXzxaC9rUW2D+cVCXi/jGRRUK+WYj1wdrp9Em6doaE395m6smMF3d0RX8jsvPd
         QYq4jct0Tu7QLREVcFD5zGyRVKFXC+8Iq00IlOBIRYm2Ba9UwhL7mVa3TZWrLcUitGtd
         ygTQHlqPgbGZAX+Omqq4zdeBL5ClL371v9L90DbhgBCW2cIifWstcyotvLvQpjqnmAsE
         Puaw==
X-Gm-Message-State: APf1xPAZrxd6qsW1sn9XJ14DBP/D/x3SCEUf2xY367ub6iOefc2bzCVF
        DPQJnaVbBaPGVG+k0ayRkkPMCw==
X-Google-Smtp-Source: AG47ELuJ5GNFVS0sIXjEeziZimfKUupN9G0uhT8twD+lEpZXFQtoZ00IL65vMmgSmKWp5gBhHEjLlg==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34-v6mr8058694plp.429.1520077194236;
        Sat, 03 Mar 2018 03:39:54 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id k66sm17493157pfb.123.2018.03.03.03.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 38/44] packfile: add repository argument to reprepare_packed_git
Date:   Sat,  3 Mar 2018 18:36:31 +0700
Message-Id: <20180303113637.26518-39-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
index 526f06173e..560d58daec 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -477,7 +477,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return error(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ac478b7b99..dfc69be1a2 100644
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
index b5ad6838f8..53db240d0f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -898,7 +898,7 @@ void prepare_packed_git_the_repository(void)
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git(void)
+void reprepare_packed_git_the_repository(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
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
index 7066d4c9ce..be84f84373 100644
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
2.16.1.435.g8f24da2e1a

