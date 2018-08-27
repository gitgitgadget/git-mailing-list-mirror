Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F201F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeH0Xbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36836 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeH0Xbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so121924wmj.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSDu03Htkfy+Hvq7eHdO3vS/MbQ/Yt0pgpanwxrqCsM=;
        b=OxzlGS0xdsB7rggWmso0FIwLCPRd+zen9XNEkpQE2+HuNX9WWYcdNJABVVcgWzny8L
         XXYjhs0S+acJkbVfz4NqSSYAGzlNALhJ2tH8chdqyT0R223QJaYRxP7EYmCgeWJQN4no
         qlrnOvsmjVZadZ5Yf8TgudCtTrBRKOCMiE3PJmmevfs5vz3gOgEAgsv2fJoRYatz23UB
         4cKk60XoT1RQIrk+qHwoSRtrMAG0Sax+VelaUWaW6RVl8IOeYxL6HdFUfMxIJx5vv16U
         o+oP4ApXkk4wj4KklNvUG+psG3C48Wg6PBZZL6jSksLFyx4FnBoMN9haEWL7Y64xJgTO
         5M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSDu03Htkfy+Hvq7eHdO3vS/MbQ/Yt0pgpanwxrqCsM=;
        b=LIbcZsfs7ytMwkfMxXq2foMjAL2uTBNFCMGMdIBE4pIpf8iEznv1yvJeTXUusQwHo/
         +SusgXVj8LNbcMlhxDGhUe1m76Kr5HmE/NNVJM2A9vqCM/2+lrpQxqrMlQlXpUsOYaCd
         pRm+stjOseQIm35owXtsQ0x6M2RNwfqrNtC4R58lUMK6i1usdjZRIvQTijDf4/Y2VeJA
         MmJtFxlywBWiqB7Gm0oWfsvkaZdCfO32wqoA+8szMcdIDTDS1eafpl5cGKfjlzFFGc6O
         7HF5Ky/VG01rv2zykPeUX0ARzLw+0A+8pNjnZ0bijaqxvIRvjMcGUHXYwNnKf1G6ouPf
         5C3Q==
X-Gm-Message-State: APzg51AYMtCy0k7gCXsX5yMdnBHkJTdEJbn1eESq3EKj48rvRk+oCI2s
        dFKhbP8fL9rH10uvRNNozP2JIbaQ2dg=
X-Google-Smtp-Source: ANB0VdaIs7u92dJOcmdi7BH5A/iXlnPYYpmcwUnQsC4PjROF6jDiYnBXto4KHk8T3bf6faCCOPwnbA==
X-Received: by 2002:a1c:9dc3:: with SMTP id g186-v6mr6518113wme.26.1535399024130;
        Mon, 27 Aug 2018 12:43:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:43 -0700 (PDT)
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
Subject: [PATCH v3 6/7] fsck: use oidset for skiplist
Date:   Mon, 27 Aug 2018 19:43:22 +0000
Message-Id: <20180827194323.17055-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Object IDs to skip are stored in a shared static oid_array.  Lookups do
a binary search on the sorted array.  The code checks if the object IDs
are already in the correct order while loading and skips sorting in that
case.  Lookups are done before reporting a (non-fatal) corruption and
before checking .gitmodules files.

Simplify the code by using an oidset instead.  Memory usage is a bit
higher, but we don't need to worry about any sort order anymore.  Embed
the oidset into struct fsck_options to make its ownership clear (no
hidden sharing) and avoid unnecessary pointer indirection.

Performance on repositories with a low number of reported issues and
.gitmodules files (i.e. the usual case) won't be affected much.  The
oidset should be a bit quicker with higher numbers of bad objects in
the skipList.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 11 ++++++-----
 fsck.c                   | 23 ++---------------------
 fsck.h                   |  8 +++++---
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a8dfafa61d..3d0556e85d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1729,11 +1729,12 @@ all three of them they must all set to the same values.
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

