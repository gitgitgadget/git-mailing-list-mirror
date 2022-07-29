Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63994C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiG2TaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiG2T3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B562A65
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so6199551wrp.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mnPtNgySTa7llJBb+s/lASeY/w+3Iuv0kFohfWZv/IA=;
        b=lW+FWjxtqOUV3eKFb9mBRH6Tg+tOxdOaq/bJqdGCd0QuGCOJCeJrHsutGJhdWjcyIp
         TVxP3l1oA+yIBiQ1cKhaFllCIm1XvSmdoCf7tb24anU/IbNDm0eO5iyls+mQNCJWfFpW
         3RZTJg6/AjifX12WqoyOpJ1/eEEWL2GDKqgrQUt3s1+cgE++VG90z7Q6sielM1Vj/m41
         LIP53xN8YDgm5bk2APjTXtcW8MyYzvQESp7HNSpp+AAyhoDHbgnUiSTk1glCCzFxPAGP
         YKxtbSY0zxsWbGnu3/rnFRzzCox2VmMeXATWceVKhS/3fAbIhTvVuFIV/RNfli8OSdMr
         9r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mnPtNgySTa7llJBb+s/lASeY/w+3Iuv0kFohfWZv/IA=;
        b=U1HKKPGhroWF5RvcMrlhxPb0xSmieNn3dhKZKMvtfatW33j7LFg0x/4sb81rpSw0gE
         yQMtrCUz60vYSPcGrd6dpXdjuqlMlaKJyteT5KKmH7OEJyjRL2wjjIFmMAGRSvXSZYuD
         yS2qlxiFH33jiC1iv7FPnZrk20EWWg5jWv912MzTqt2vXM16q1/VpuR8gA5jopFW+Y6K
         EeR2fgSQhq3QAzjfn4oi26oST/4VLxoR4rHmUewvQDB82AycaJbBYj45jrt2AAWGXC5C
         6Z/20CixtY7178D4nr4KTHvOknuemKiV+8ASOeUTN0UB1juLiyxVHmULTacI5xD2ZSU9
         BHmQ==
X-Gm-Message-State: ACgBeo0mg3GYltfwFTsMLOHMIcyUAPfT7eNfOUMPANX6rutjV1Faj9nu
        9bAtqT7v9MFW13t1t1tek+WWwO643Co=
X-Google-Smtp-Source: AA6agR7xOk1U57661RxVkATfpzvbZarTrHXHBxQT/3kId1MmkjNpheMK4wiuQn534ked32z2roPorg==
X-Received: by 2002:a5d:5c0c:0:b0:21e:7098:1903 with SMTP id cc12-20020a5d5c0c000000b0021e70981903mr3229391wrb.623.1659122986415;
        Fri, 29 Jul 2022 12:29:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b0021e5cc26dd0sm4399161wrr.62.2022.07.29.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:45 -0700 (PDT)
Message-Id: <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:34 +0000
Subject: [PATCH v2 05/10] log-tree: use ref_namespaces instead of if/else-if
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The add_ref_decoration() method uses an if/else-if chain to determine if
a ref matches a known ref namespace that has a special decoration
category. That decoration type is later used to assign a color when
writing to stdout.

The newly-added ref_namespaces array contains all namespaces, along
with information about their decoration type. Check this array instead
of this if/else-if chain. This reduces our dependency on string literals
being embedded in the decoration logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 log-tree.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index bb80f1a94d2..6075bdd334e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -137,6 +137,7 @@ static int ref_filter_match(const char *refname,
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
+	int i;
 	struct object *obj;
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
@@ -167,16 +168,21 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		return 0;
 	obj = lookup_object_by_type(the_repository, oid, objtype);
 
-	if (starts_with(refname, "refs/heads/"))
-		deco_type = DECORATION_REF_LOCAL;
-	else if (starts_with(refname, "refs/remotes/"))
-		deco_type = DECORATION_REF_REMOTE;
-	else if (starts_with(refname, "refs/tags/"))
-		deco_type = DECORATION_REF_TAG;
-	else if (!strcmp(refname, "refs/stash"))
-		deco_type = DECORATION_REF_STASH;
-	else if (!strcmp(refname, "HEAD"))
-		deco_type = DECORATION_REF_HEAD;
+	for (i = 0; i < NAMESPACE__COUNT; i++) {
+		struct ref_namespace_info *info = &ref_namespaces[i];
+
+		if (!info->decoration)
+			continue;
+		if (info->exact) {
+			if (!strcmp(refname, info->ref)) {
+				deco_type = info->decoration;
+				break;
+			}
+		} else if (starts_with(refname, info->ref)) {
+			deco_type = info->decoration;
+			break;
+		}
+	}
 
 	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
-- 
gitgitgadget

