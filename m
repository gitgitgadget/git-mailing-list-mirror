Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64AC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhLGNl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhLGNlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C062C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1799330wme.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dtxgHuiXmVxNjjRkzOGJL0LrW2h0Q9w7V1oY0yFki+Y=;
        b=DG34I05LSs58SmbR/WE4ZjM1cEAyZCVq4Qbm3ewrExdxq4BoGUqeWdjz40gRlCiaZ4
         Brv5wtxWbOgHwRuRqEdIjpqzyi95AlgoJf5Ro5+WGkkGmGjlTdrRPn/F+3S7pVPZj1Ey
         Lk+fSZXB0apH23kxlOQGPYpvR09LfW+rLO0nw+DOP7MZXOSWL+mUnyoKSCNJBFfnTZZH
         XsglpBFJrjsNngQmmlMR60Wa9jwG6XSDRVLDnZhtdKy/+RNOLGt0HwpXNKmBFJIniCjT
         XbnhIs3bYJqzASUpMbvMWCRS5KP6NiqUEM+VsJpsiimjSg2L2AYhpb5sE/UuEHIJXZif
         Q0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dtxgHuiXmVxNjjRkzOGJL0LrW2h0Q9w7V1oY0yFki+Y=;
        b=1zdKVTHlR7IQXi+m0wb6hbzPNOgHGvW/KM90rXJZNaLdTFduVtyGNE3cYy3oFD5/PC
         ir4uABe619P0wqSRnuqdCPP9pZbPwZQsMh+RT9D5CY1OHecNHHpXb2j5wBIIGDtSwS1v
         068OME9Q6FWNj0FNNkF+Mtp2bw1oZSW2YlbTht9ei48RfrNDb8Adb7NwDQRjZN5q2Btm
         L870RGXwk3ZkSykx+aWkgjW9jkINlY4CvI4OwT9wTj5i9nsrNcpfdQBPGMJ3iGMoU8yd
         /kT1qNVOZtiirfO7JYVYO9jGUnvHjomC1XXhnh51DtEeFzSdloht7GhoM59wfyBT1uNt
         2EDA==
X-Gm-Message-State: AOAM533/pFpSBLcJ30vplaIQH8fGogg31Vd3b1275TO86WN4xAF5iou0
        sRT6M2KqEac1neS5r829w5Dr3iHg9To=
X-Google-Smtp-Source: ABdhPJxZ89KJRlFhVoMFwTVy+Y+pJpiKUmbVPFecMDVVENtY/OXbNUJ6Sr2AyjUwwEs22jP9/Jo3sg==
X-Received: by 2002:a05:600c:3553:: with SMTP id i19mr6987762wmq.97.1638884303451;
        Tue, 07 Dec 2021 05:38:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm3157444wmq.31.2021.12.07.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:23 -0800 (PST)
Message-Id: <865458bc0cb1c2abbc4c378f9e4e4317a05fa0b9.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:14 +0000
Subject: [PATCH v4 2/8] test-ref-store: parse symbolic flag constants
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This lets tests use REF_XXXX constants instead of hardcoded integers. The flag
names should be separated by a ','.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 66 ++++++++++++++++++++++++++++++++++-----
 t/t1405-main-ref-store.sh |  3 +-
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b795a56eedf..abb0ba101ae 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,6 +5,48 @@
 #include "object-store.h"
 #include "repository.h"
 
+struct flag_definition {
+	const char *name;
+	uint64_t mask;
+};
+
+#define FLAG_DEF(x)     \
+	{               \
+#x, (x) \
+	}
+
+static unsigned int parse_flags(const char *str, struct flag_definition *defs)
+{
+	struct string_list masks = STRING_LIST_INIT_DUP;
+	int i = 0;
+	unsigned int result = 0;
+
+	if (!strcmp(str, "0"))
+		return 0;
+
+	string_list_split(&masks, str, ',', 64);
+	for (; i < masks.nr; i++) {
+		const char *name = masks.items[i].string;
+		struct flag_definition *def = defs;
+		int found = 0;
+		while (def->name) {
+			if (!strcmp(def->name, name)) {
+				result |= def->mask;
+				found = 1;
+				break;
+			}
+			def++;
+		}
+		if (!found)
+			die("unknown flag \"%s\"", name);
+	}
+
+	string_list_clear(&masks, 0);
+	return result;
+}
+
+static struct flag_definition empty_flags[] = { { NULL, 0 } };
+
 static const char *notnull(const char *arg, const char *name)
 {
 	if (!arg)
@@ -12,9 +54,10 @@ static const char *notnull(const char *arg, const char *name)
 	return arg;
 }
 
-static unsigned int arg_flags(const char *arg, const char *name)
+static unsigned int arg_flags(const char *arg, const char *name,
+			      struct flag_definition *defs)
 {
-	return atoi(notnull(arg, name));
+	return parse_flags(notnull(arg, name), defs);
 }
 
 static const char **get_store(const char **argv, struct ref_store **refs)
@@ -64,10 +107,13 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	return argv + 1;
 }
 
+static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
+					       FLAG_DEF(PACK_REFS_ALL),
+					       { NULL, 0 } };
 
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
 
 	return refs_pack_refs(refs, flags);
 }
@@ -81,9 +127,15 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	return refs_create_symref(refs, refname, target, logmsg);
 }
 
+static struct flag_definition transaction_flags[] = {
+	FLAG_DEF(REF_NO_DEREF),
+	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
+	{ NULL, 0 }
+};
+
 static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 {
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
 
@@ -120,7 +172,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
 	struct object_id oid = *null_oid();
 	const char *refname = notnull(*argv++, "refname");
-	int resolve_flags = arg_flags(*argv++, "resolve-flags");
+	int resolve_flags = arg_flags(*argv++, "resolve-flags", empty_flags);
 	int flags;
 	const char *ref;
 	int ignore_errno;
@@ -209,7 +261,7 @@ static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 	const char *msg = notnull(*argv++, "msg");
 	const char *refname = notnull(*argv++, "refname");
 	const char *sha1_buf = notnull(*argv++, "old-sha1");
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	struct object_id old_oid;
 
 	if (get_oid_hex(sha1_buf, &old_oid))
@@ -224,7 +276,7 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
 	const char *refname = notnull(*argv++, "refname");
 	const char *new_sha1_buf = notnull(*argv++, "new-sha1");
 	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	struct object_id old_oid;
 	struct object_id new_oid;
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 5e0f7073286..63e0ae82bdf 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -17,8 +17,7 @@ test_expect_success 'setup' '
 test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	N=`find .git/refs -type f | wc -l` &&
 	test "$N" != 0 &&
-	ALL_OR_PRUNE_FLAG=3 &&
-	$RUN pack-refs ${ALL_OR_PRUNE_FLAG} &&
+	$RUN pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
 	N=`find .git/refs -type f` &&
 	test -z "$N"
 '
-- 
gitgitgadget

