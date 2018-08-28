Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E681F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH1Nnf (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeH1Nne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so954935wrw.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itloMKT4soFuIoF9ls+lIr/H/GVXWaezfcxKvISCCjM=;
        b=oDwBLw+REHHDzPA64xhHGtXj3VUOKMD9om3eyCbBKg3m4NhX9fmBeATBH2S+wA/H0Q
         crnVRiTJXoJpU8WX05/dC4V75u4grpHYakrSVYn4pOlel/oB5yi3DS173ASJ0YT6B8qm
         +s9wjPvaZMCxoepIIbtn9GZy9Q/ENtB7vxT7S+Gkl7kIAZ9b7q6+jaoopv7XnuTdbQi+
         ktbbGckiJoNakg46RXc+In529qV14x42h9W73dUyILqvMp/mmq2DA4/Go4RlDGnqo7sf
         tAy+zdK2dE8rTf2ibDja2VMgdouu6kerJ4R/wqrMyITsu+mRlBSGF6nlBqtkHBzfuboc
         k45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itloMKT4soFuIoF9ls+lIr/H/GVXWaezfcxKvISCCjM=;
        b=MPBnQWG+bLoHRs+d85qOQlitPu2L1eYUmh/NcuLQI4oJzahiOLb9Vsp9igSxYe4lsw
         3r9ThVq7ojDFK4Q1qgkpUU7XCAoAzUE1rwM53XhAR2/LwgkyApucCbpwFVB/uNS8JOdG
         /RutSbU29iN/lr2fm3pt+kEZQ1jalUyex8BXywdCdCQYT9yMCTgmIbUdm5aKDdpUwM/f
         sO2sJzOHnvrQ4nRv3d1vx6mEHffQRRgzY2Fi5fR6vjQuq+RCuQiHXWfekZu9tVe55Dc2
         zZbnSXAfdJxziYbhaT/G5t3Xv2p9JiR/JQTD7S8ushSZOTcCvxV2ecBGhHSXhj23WJhS
         8prw==
X-Gm-Message-State: APzg51AqIPiAceaQqB7nLSwE6/wdSFlLxnrcHPbEX3A30Jyx/e6UFogQ
        PogHD2ZwVufgwGWmcayKW6rF59j1DYQ=
X-Google-Smtp-Source: ANB0VdY9lLySEH4CF1hkQk7rt0bqnaAshLj3A/HC0nn0hBfkjO4AGZdo2Lpk/DhVFP1EQpxRObgBHg==
X-Received: by 2002:adf:a3d9:: with SMTP id m25-v6mr629137wrb.1.1535449961883;
        Tue, 28 Aug 2018 02:52:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/8] fsck: use oidset instead of oid_array for skipList
Date:   Tue, 28 Aug 2018 09:52:18 +0000
Message-Id: <20180828095219.23296-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Change the implementation of the skipList feature to use oidset
instead of oid_array to store SHA-1s for later lookup.

This list is parsed once on startup by fsck, fetch-pack or
receive-pack depending on the *.skipList config in use. I.e. only once
per invocation, but note that for "clone --recurse-submodules" each
submodule will re-parse the list, in addition to the main project.

Memory usage is a bit higher, but we don't need to keep track of the
sort order anymore. Embed the oidset into struct fsck_options to make
its ownership clear (no hidden sharing) and avoid unnecessary pointer
indirection.

The cumulative impact on performance of this & the preceding change,
using the test setup described in the previous commit:

    Test                                             HEAD~2            HEAD~                   HEAD
    ----------------------------------------------------------------------------------------------------------------
    1450.3: fsck with 0 skipped bad commits          7.70(7.31+0.38)   7.72(7.33+0.38) +0.3%   7.70(7.30+0.40) +0.0%
    1450.5: fsck with 1 skipped bad commits          7.84(7.47+0.37)   7.69(7.32+0.36) -1.9%   7.71(7.29+0.41) -1.7%
    1450.7: fsck with 10 skipped bad commits         7.81(7.40+0.40)   7.94(7.57+0.36) +1.7%   7.92(7.55+0.37) +1.4%
    1450.9: fsck with 100 skipped bad commits        7.81(7.42+0.38)   7.95(7.53+0.41) +1.8%   7.83(7.42+0.41) +0.3%
    1450.11: fsck with 1000 skipped bad commits      7.99(7.62+0.36)   7.90(7.50+0.40) -1.1%   7.86(7.49+0.37) -1.6%
    1450.13: fsck with 10000 skipped bad commits     7.98(7.57+0.40)   7.94(7.53+0.40) -0.5%   7.90(7.45+0.44) -1.0%
    1450.15: fsck with 100000 skipped bad commits    7.97(7.57+0.39)   8.03(7.67+0.36) +0.8%   7.84(7.43+0.41) -1.6%
    1450.17: fsck with 1000000 skipped bad commits   7.72(7.22+0.50)   7.28(7.07+0.20) -5.7%   7.13(6.87+0.25) -7.6%

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 11 ++++++-----
 fsck.c                   | 23 ++---------------------
 fsck.h                   |  8 +++++---
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7f033f036..ebaa044689 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1731,11 +1731,12 @@ all three of them they must all set to the same values.
 +
 Older versions of Git (before 2.20) documented that the object names
 list should be sorted. This was never a requirement, the object names
-can appear in any order, but when reading the list we track whether
-the list is sorted for the purposes of an internal binary search
-implementation, which can save itself some work with an already sorted
-list.  Unless you have a humongous list there's no reason to go out of
-your way to pre-sort the list.
+could appear in any order, but when reading the list we tracked whether
+the list was sorted for the purposes of an internal binary search
+implementation, which could save itself some work with an already sorted
+list. Unless you had a humongous list there was no reason to go out of
+your way to pre-sort the list. After Git version 2.20 a hash implementation
+is used instead, so there's now no reason to pre-sort the list.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/fsck.c b/fsck.c
index 972a26b9ba..4c643f1d40 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,7 +10,6 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
-#include "sha1-array.h"
 #include "decorate.h"
 #include "oidset.h"
 #include "packfile.h"
@@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 
 static void init_skiplist(struct fsck_options *options, const char *path)
 {
-	static struct oid_array skiplist = OID_ARRAY_INIT;
-	int sorted;
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 
-	if (options->skiplist)
-		sorted = options->skiplist->sorted;
-	else {
-		sorted = 1;
-		options->skiplist = &skiplist;
-	}
-
 	fp = fopen(path, "r");
 	if (!fp)
 		die("Could not open skip list: %s", path);
@@ -202,19 +192,12 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		const char *p;
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
 			die("Invalid SHA-1: %s", sb.buf);
-		oid_array_append(&skiplist, &oid);
-		if (sorted && skiplist.nr > 1 &&
-				oidcmp(&skiplist.oid[skiplist.nr - 2],
-				       &oid) > 0)
-			sorted = 0;
+		oidset_insert(&options->skiplist, &oid);
 	}
 	if (ferror(fp))
 		die_errno("Could not read '%s'", path);
 	fclose(fp);
 	strbuf_release(&sb);
-
-	if (sorted)
-		skiplist.sorted = 1;
 }
 
 static int parse_msg_type(const char *str)
@@ -319,9 +302,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 
 static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
 {
-	if (opts && opts->skiplist && obj)
-		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
-	return 0;
+	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
 }
 
 __attribute__((format (printf, 4, 5)))
diff --git a/fsck.h b/fsck.h
index 0c7e8c9428..b95595ae5f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,8 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
+#include "oidset.h"
+
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
 #define FSCK_IGNORE 3
@@ -35,12 +37,12 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_type;
-	struct oid_array *skiplist;
+	struct oidset skiplist;
 	struct decoration *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.19.0.rc0.228.g281dcd1b4d0

