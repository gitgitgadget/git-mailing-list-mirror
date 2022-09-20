Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E40C6FA8E
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiITI0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiITIZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:25:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E963F2B
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g3so2922371wrq.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=S3wPBgJTO6dkmn/hje0kzTD5udOG5soGoSKMPEL/fwo=;
        b=ZUPRlQZ8jls4QW7e2DJJZh/c8BB/607GNStf+AVaLTVr0NLns8f8aPE9xB6/i4rZOK
         0g5xX6fLp3CMU+gPg4E8wjRvvbVgCXy23jyw0VNytru4Iw1UnyVCW8+AezHaiUTS//JP
         +k6BaizZ+IVm7pbm85kT8YAM3dqUFyeNZ+sBmpi9rkAgrL4fawIEKULz8TXUw47OiT2V
         KBZcMnT2Qok46EL5xpNNzytk7ePsGaRX/eoO2Y3VIG2wBrdfhB90pAUQVyuTrzwHT8z2
         Yp8u8DyutoinRDprfUqp1IWOgcZ+nqnUHJvXG/jvkJ2OncIaUCY+SfaAP8lnl2kXDhfV
         JAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S3wPBgJTO6dkmn/hje0kzTD5udOG5soGoSKMPEL/fwo=;
        b=sRe4dWGe7TzanpdQ9HWTlDQxtrNhNuLjvSQEOmUdiWLirIxGAhn9IppZ22+dJVjIBO
         yOK/X8STO0i5qy1SNYeODawHq+iJEG+eVEWjT2IB4CK6D5zbuwIBdaPMVRSYPzH62pWV
         qM7/YyEwV9p983gi/65ObPwrm1K6mjpBohiMAWfo0CKxGPFArWIjYY6yAlXDTPuZKOvl
         AgWbkJZYwKs1DGVI5pwIC9n+d+wJxFDJ8oB3uPxyBckwkXCe+LfMUX+Bn33X6Hb+dYxn
         qW76hLFtR3lbT/YwMHdQf7FhqNv1gHTNbilQvhdos1kM4FlCQ5AvwMvCxLm1gmKe8mvX
         Y1zA==
X-Gm-Message-State: ACrzQf19DMqtvBr4Ux1P90KvpvZENVyiHVGLoGqGAbSn4AUeikdR+V8c
        NAvwHrzwJCKBUQmy10q/jXXYrBoLkAc=
X-Google-Smtp-Source: AMsMyM5P6WqqyYNmomQ8tXINCH/ey0ZO7yheHYkx/KWOqnlivzFUQAqRUunDn159fQvgIW4ih+oG1g==
X-Received: by 2002:adf:c713:0:b0:22a:3670:b08d with SMTP id k19-20020adfc713000000b0022a3670b08dmr13346866wrg.175.1663662170432;
        Tue, 20 Sep 2022 01:22:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b003b4a699ce8esm19632036wms.6.2022.09.20.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:22:49 -0700 (PDT)
Message-Id: <f309e9534f2397fc575634108279aa7dd038feae.1663662167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
References: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 08:22:44 +0000
Subject: [PATCH v6 2/5] hiderefs: use a new flag to mark force hidden refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

If uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
is set to true, the private commits of hiding refs can be fetched by
the client. The new hide-refs hook is used to hide our refs and we wish
to hide the private commits either.

A new flag `HIDDEN_REF_FORCE` is used to mark a ref if hide-refs hook
decides to hide it, and we make sure the wire protocol V1 will reject
to send the private commits of this kind of refs even if
uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
is set to true.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 refs.c        | 39 +++++++++++++++++++++++++++++++++++++++
 refs.h        |  3 +++
 upload-pack.c | 14 --------------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 68368055946..5a9079fd4c4 100644
--- a/refs.c
+++ b/refs.c
@@ -1648,6 +1648,45 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 	return 0;
 }
 
+#define OUR_REF		(1u << 12)
+#define HIDDEN_REF	(1u << 19)
+/*
+ * Use this flag to mark a ref that is hidden by the hide-refs hook, its private
+ * commits (tip or non-tip commits, not reachable by the refs not hidden by the
+ * hide-refs hook) will be forced hidden to the client, which means a client can
+ * not fetch such kind of commits even uploadpack.allowTipSHA1InWant or
+ * uploadpack.allowReachableSHA1InWant are set to true
+ */
+#define HIDDEN_REF_FORCE	(1u << 20)
+
+static unsigned int ref_hidden_flag(const char *refname, const char *refname_full)
+{
+	if (ref_hidden_check(refname, refname_full, 1))
+		return HIDDEN_REF_FORCE;
+	else if (ref_hidden_check(refname, refname_full, 0))
+		return HIDDEN_REF;
+	return OUR_REF;
+}
+
+int mark_our_ref(const char *refname, const char *refname_full,
+		 const struct object_id *oid)
+{
+	struct object *o;
+	unsigned int flag;
+
+	if (!oid || is_null_oid(oid)) {
+		return 0;
+	}
+
+	o = lookup_unknown_object(the_repository, oid);
+	flag = ref_hidden_flag(refname, refname_full);
+	o->flags |= flag;
+
+	if (flag & OUR_REF)
+		return 0;
+	return 1;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index d6575b8c2bd..2feabfe35c4 100644
--- a/refs.h
+++ b/refs.h
@@ -819,6 +819,9 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+/* return non-zero if the ref is hidden, otherwise 0 */
+int mark_our_ref(const char *refname, const char *refname_full,
+		 const struct object_id *oid);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469e..a8ca5d1c26e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1155,20 +1155,6 @@ static void receive_needs(struct upload_pack_data *data,
 		packet_flush(1);
 }
 
-/* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid)
-{
-	struct object *o = lookup_unknown_object(the_repository, oid);
-
-	if (ref_is_hidden(refname, refname_full)) {
-		o->flags |= HIDDEN_REF;
-		return 1;
-	}
-	o->flags |= OUR_REF;
-	return 0;
-}
-
 static int check_ref(const char *refname_full, const struct object_id *oid,
 		     int flag, void *cb_data)
 {
-- 
gitgitgadget

