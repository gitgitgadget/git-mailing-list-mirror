Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1701F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437080AbfJQURb (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:31 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55313 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:31 -0400
Received: by mail-pg1-f201.google.com with SMTP id b14so2578390pgm.22
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xbePw5qFrrtu4A8JivCmOtF2bj2S91pEHOwOlx74Cv8=;
        b=saS/8c82X/5o0scb9VlPtZ/Au52oVPHAygRDlU4YiqLinKcmMM9iGF3S3Al3JIdiig
         +Phvs3czz017ardrx6L5IkcCSkdAxK+gAv65UlWQgeop/KAURPO0ggR6vYUTsVDL3HwR
         LH9YSNzEa1oX11hu4nIDI17YypjpIgi+lT+BENtraYirO0Gvz53i8X9VDSsE/+UwErs7
         7zBuhcwBipfxTTadH23h6aO79L/1P3L36z802Qx3s0Itjxq3AAwHaD0nIVHBZHeKBl/a
         CFGcOauI0ihfnvwdUZkIblSB5izS1I7rK7XM0iDLriQHMhKUkXEwNu4HG00dIevxeWZg
         BABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xbePw5qFrrtu4A8JivCmOtF2bj2S91pEHOwOlx74Cv8=;
        b=p+2ydvOD+zNnub/L0mzaMzEb4AmcC+9jga6gp8ZxArTuwiXQ9uXcmk2fu2GRx31U6H
         ApltkJJhRB2ls1xZrUrGveoyguweASVMUZduCFdV4FNYQa+YbPorVkI62GZG+fQWC4M+
         Ofi7O6widYeTgJ9IJv4L8lsolpOQbMs+SftcYoMQjrHbz4QQ3mKTHouQI6yhX+4YWizq
         Ebr9EQMPSmCF4H5U+vnwIohkNxGn5LJ9VvQ/yVk7xvPXIK8YGqMUNULULfaNh+GF5vok
         CrU9koBOdgfYAEopHcxUrdMoicxfMZZzJX/ZELpG1io1ykEyddWUXyYcwHRUXmz3KJk0
         jJ/g==
X-Gm-Message-State: APjAAAUhXM5M5SH1rJ/W/BjHYtKFdUYilyfLqO50kRiJ8/4aSJt+zJEB
        vTbZ9eggvtM0WjSVbt8QDxz6RTOlqBINM5Hbz8J91StikSzPkXyGNTG0dAj5rilOllIHDmvKhs5
        QEvYzxez43IbpOTfB4gFcF9BT4eZYXvRGFTuGUZXZun28TqiLUCC67/I1Xy0aUvgr55c7CVEEdu
        1m
X-Google-Smtp-Source: APXvYqyHO/0+Mts9pMY506xn5a/JF6KsrlxJg/AaYhHz2p69tSIDio2MbJWHJLDmscb8sMZcR2aqIFyWeAISeEAX1eaR
X-Received: by 2002:a63:e148:: with SMTP id h8mr5906629pgk.297.1571343448939;
 Thu, 17 Oct 2019 13:17:28 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:12 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <f01f069a080d705ddb52e2353fa303b979a3cb78.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 3/7] index-pack: remove redundant parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
the object type is already present in the name of the function. Remove
that parameter from these functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index df6b3b8cf6..296804230c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -614,7 +614,7 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
 	       0;
 }
 
-static int find_ofs_delta(const off_t offset, enum object_type type)
+static int find_ofs_delta(const off_t offset)
 {
 	int first = 0, last = nr_ofs_deltas;
 
@@ -624,7 +624,8 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 		int cmp;
 
 		cmp = compare_ofs_delta_bases(offset, delta->offset,
-					      type, objects[delta->obj_no].type);
+					      OBJ_OFS_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -637,10 +638,9 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 }
 
 static void find_ofs_delta_children(off_t offset,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ofs_delta(offset, type);
+	int first = find_ofs_delta(offset);
 	int last = first;
 	int end = nr_ofs_deltas - 1;
 
@@ -668,7 +668,7 @@ static int compare_ref_delta_bases(const struct object_id *oid1,
 	return oidcmp(oid1, oid2);
 }
 
-static int find_ref_delta(const struct object_id *oid, enum object_type type)
+static int find_ref_delta(const struct object_id *oid)
 {
 	int first = 0, last = nr_ref_deltas;
 
@@ -678,7 +678,8 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 		int cmp;
 
 		cmp = compare_ref_delta_bases(oid, &delta->oid,
-					      type, objects[delta->obj_no].type);
+					      OBJ_REF_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -691,10 +692,9 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 }
 
 static void find_ref_delta_children(const struct object_id *oid,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ref_delta(oid, type);
+	int first = find_ref_delta(oid);
 	int last = first;
 	int end = nr_ref_deltas - 1;
 
@@ -982,12 +982,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
 		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last,
-					OBJ_REF_DELTA);
+					&base->ref_first, &base->ref_last);
 
 		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last,
-					OBJ_OFS_DELTA);
+					&base->ofs_first, &base->ofs_last);
 
 		if (base->ref_last == -1 && base->ofs_last == -1) {
 			free(base->data);
-- 
2.23.0.866.gb869b98d4c-goog

