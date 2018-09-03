Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5371F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeICTKZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeICTKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so953381wrr.4
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ipmr5vLiFXoI5P04WJ0lOew4CplAhqBNYJgOnzWbTPk=;
        b=P8WoQ82rOkZFCxqccKrItQsKyefPTuQtemdXgv2XvalxxAcWM1yNefbNFEClm6TZd4
         vVJnhEhvE9bt7L0LtLyQ6BgdclKcmDG6W7qBjnTd8TAOywlFAchOO35fbnhXeW0jEZye
         F892BrjS3SFTwLbGfrUV01/oWIx19OUAXhbCys5TtGGafFbGhv13A7awTtZgS8BoxQ+c
         0+2TsL5P6HlTh2NpOPhe40gn76kDJ4dw1cioo2ii/9+EerYNycMUu6uvJINY34Z+IWuO
         rqEG2OV7Wzk9T4DN7oT0sgB6FDUbh77uD6Ch8qZZb96ApUzgOdoH4112ifU9teQASKpg
         iuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ipmr5vLiFXoI5P04WJ0lOew4CplAhqBNYJgOnzWbTPk=;
        b=t8ZPlylyOy4FHW4l5AhDYPgdy6Wv/Trup/cYCZrx2VMKtLiK9QzRRyYlbILvTLF/mg
         xPCC7gW1VkAuDTEfUg8HCYT7os7eZa58bEx0NMvutHIzT2HP3uXz/Jwd2kxXjxh28zTn
         Ma0AM2KTkX479MXOXE4sCD/KcdPkKUe+0VNjHlp2vScjZM5i7HJ0WRX1hBIC/RS023Gt
         NtOH3B+peZqulmIcM4BFr2D0kM2lwkuL0FtA9q343+/hj4LrE3BYVgmfy7c/fheJI5iM
         lOpGijMEPFuWCgqpO067aipFgnhJxyD/z6g63BRsmCDIfiRwqTE0nysL8lebg0cJ7B5z
         gJKg==
X-Gm-Message-State: APzg51DRFTo00yYeEYs4hiAPpNVwxezhDT0b+7u/Au4LUZkHc1acohE0
        sq7VHBzWRuChanSagrxBJg96XmT106c=
X-Google-Smtp-Source: ANB0Vdb9oQl49D6H3QnLF0EGd4THwQ/ZDVBMhcXullmtVDhWd9ZYSFfqKXo8mP4kD/DZk2wdpgtjPQ==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr20445420wrf.68.1535986193129;
        Mon, 03 Sep 2018 07:49:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:52 -0700 (PDT)
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
Subject: [PATCH v5 09/10] fsck: use oidset instead of oid_array for skipList
Date:   Mon,  3 Sep 2018 14:49:27 +0000
Message-Id: <20180903144928.30691-10-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
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
submodule will re-parse the list, in addition to the main project, and
it will be re-parsed when checking .gitmodules blobs, see
fb16287719 ("fsck: check skiplist for object in fsck_blob()",
2018-06-27).

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
index 3287c7ef8a..161ffe259e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1731,11 +1731,12 @@ all three of them they must all set to the same values.
 +
 Older versions of Git (before 2.20) documented that the object names
 list should be sorted. This was never a requirement, the object names
-can appear in any order, but when reading the list we track whether
-the list is sorted for the purposes of an internal binary search
-implementation, which can save itself some work with an already sorted
-list. Unless you have a humongous list there's no reason to go out of
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
2.19.0.rc1.350.ge57e33dbd1

