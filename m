Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EBC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347364AbiEPU2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348776AbiEPU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BED18B04
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r30so4248195wra.13
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Rxz1a4zZC6o57lCcj9M69sbc6FwXw2jSbZhUr70qzu4=;
        b=etAX13F7sY5lN+AU3WzK8rT1IO99Kbdoxw6QMDiNAT8x6/VbrDjddIb+pvfU9LzKNI
         AwnHNFW+jO8K72cMKufs8z7YZes4IiB3JZnA1u1Qi7y1NVkyG9YYovYr7Zk3JllxiGCj
         5bO1sAjE232nr/U5b/Bi27ShEtmBZ56NsSrfSX4zRQMk4/UQkwVtRsOL2HpVC+4z0BWv
         HRYcwKy48h1o34ZtTIzt1aUlTqYjUh35kaksgO4AAgu4VG6Ybka7E22r+HTU6e+npjWw
         jd81rYOB0eSE5KCEOVOFX8VVHZ+XgmaJCSLGbdZzGLE7IMJm95S1+0alaRA15+WZwOnT
         nSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Rxz1a4zZC6o57lCcj9M69sbc6FwXw2jSbZhUr70qzu4=;
        b=aaCX0P6D/m1z9ohv7O3zMyvGiaNnLXDcA/pzCTd8La5OoyFZaTub1/3MD6vk9kqIoW
         KoJT/aoghrcleOqn/AbJrCHodRgohGqw0sh1IaXHTNBwJK+qSVYYycOSVS9KTxKmIATw
         Han2SSJV/UxlxuqSNbl2Q+L2S31uLIxaCAnIFn5H7apgP4bD9DOcORRwHxdrxp1Iizf5
         Rt3BLEz7kbY5qFccehVE/sldacqLcpjR2M5fBGJFv3afxhBqOs9d2MXcD8kEwH3KvcRW
         KnYNVarvX74/JLzP7i7kVGZzvh+SJpZtyxTIwJWmwSL9r5glDOpvFL80h0bC8wqbLX3k
         kECQ==
X-Gm-Message-State: AOAM532aLDhDq2H5jkHpmYOGKeR5Gv9e9ZrIEMy6sJm68IPABFxq3gAR
        Uto6dr4pzH5xYJhaOHAGIuMopQvxjxw=
X-Google-Smtp-Source: ABdhPJz0jvMaYv1O4Q15SlOy2RXA08KPtDfEnJSXPT8acGdJmT864zr6kgC7puUgmQzmiYJSN6lTGA==
X-Received: by 2002:a5d:47cc:0:b0:20c:6b7c:8a19 with SMTP id o12-20020a5d47cc000000b0020c6b7c8a19mr14859951wrc.608.1652731871386;
        Mon, 16 May 2022 13:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6-20020a056000154600b0020d0b2de858sm3471337wry.33.2022.05.16.13.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:10 -0700 (PDT)
Message-Id: <2a563b5f18cc9c42cb71a9547344a5435f6bc058.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:00 +0000
Subject: [PATCH 3/8] fetch-pack: add a deref_without_lazy_fetch_extended()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Add a version of the deref_without_lazy_fetch function which can be
called with custom oi_flags and to grab information about the
"object_type". This will be used for the bundle-uri client in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 fetch-pack.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 4e1e88eea09..d0aa3a5c229 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -115,11 +115,12 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
-static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
+							int mark_tags_complete,
+							enum object_type *type,
+							unsigned int oi_flags)
 {
-	enum object_type type;
-	struct object_info info = { .typep = &type };
+	struct object_info info = { .typep = type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
@@ -128,9 +129,9 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
+					     oi_flags))
 			return NULL;
-		if (type == OBJ_TAG) {
+		if (*type == OBJ_TAG) {
 			struct tag *tag = (struct tag *)
 				parse_object(the_repository, oid);
 
@@ -144,7 +145,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 		}
 	}
 
-	if (type == OBJ_COMMIT) {
+	if (*type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (!commit || repo_parse_commit(the_repository, commit))
 			return NULL;
@@ -154,6 +155,16 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	return NULL;
 }
 
+
+static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
+					       int mark_tags_complete)
+{
+	enum object_type type;
+	unsigned flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
+	return deref_without_lazy_fetch_extended(oid, mark_tags_complete,
+						 &type, flags);
+}
+
 static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 			       const struct object_id *oid)
 {
-- 
gitgitgadget

