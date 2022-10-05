Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F1C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJEPAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJEPAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1177B1ED
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w18so17611124wro.7
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=nN0VOrItuKyXwl5M7njT0w94ZFtf/Mfb8ythDPMhSVg=;
        b=D+4GAmA1QK+tY0BNnONsaDX4Z23i0QQc6EOXTx0xq7CEmCEXftsC8eJ81hxHXjZVIg
         JzhzjiT03vi8IRxQO0NTTQrz4ZtOEUFzFfKKqUs42sT5G0c90ValgYA6mp+L5tuYo9St
         yXt3LeTnRFb9VFbu9pWRplb95clfRwRYekbkhlcsY8GpL2vPhFLZrRDT7VKDCe8T7dWn
         kEKWyhjIVIVQTq7Re/5RttDJ0u9XwZzOFEnYNqi/kZGdcC7BMhiVg05DjEFs3uPdmtjw
         GLHGzqntRyUe+kplklwLeihC4ZR+JBNDmn0ccFYI1/lexjvEI9q+bfklWnRYpGxb6/pp
         kOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nN0VOrItuKyXwl5M7njT0w94ZFtf/Mfb8ythDPMhSVg=;
        b=HpRtpn4N3SueoKiPsqZ+0mHivNJzUGKTnb1xqso1ylzFenwLdGwzXA4GfPY+NXfl+E
         hjygwlTJL+CJVELWCz+NGbgJ2ac8ZPDuRRF2w6i/mGcVJjJENq8WS7tEwuafBLchfKEG
         KYF9chrE8oYn4569tYlMxhC+agAAu6LMBbXVUmNi4DamsWVEm/8fnvL+39zEKZgoQuik
         WrPr14EzYdlT+znxh2NEKF9PIe9qpFYBIAOjgrYnA0jU1k1Gw8MlQj+r8aVeRNyb0SBP
         Q2U8oUZITHZJf2FNOA2vCvz2TPK5ZF/Z+pSfGzRggmc6qvxX9QblNCCJBUSaNTN18YKb
         ZdYQ==
X-Gm-Message-State: ACrzQf1HbJnGXQCVgJ5zLhwmLBdLmIbDS3U5uGvkdKlsqv9Lwe8Nr4PJ
        gdorMpmf442pg6E5u5U+UlTBbqcHbjg=
X-Google-Smtp-Source: AMsMyM6MTjwX8oex7e2nv5svDuma49anQRDoHlhXHe1+UnGTPdJudX1uJlqDBeqpyYCkKadMD30v9w==
X-Received: by 2002:adf:9cd0:0:b0:22a:7cea:d3c3 with SMTP id h16-20020adf9cd0000000b0022a7cead3c3mr115464wre.196.1664981962866;
        Wed, 05 Oct 2022 07:59:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c3b08000000b003b535ad4a5bsm2305662wma.9.2022.10.05.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:22 -0700 (PDT)
Message-Id: <c59066ebc102301817659d5e886a310bd4d84271.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:10 +0000
Subject: [PATCH v2 03/10] ref-filter: add the metas namespace to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

The metas namespace will contain refs for changes in progress. Add
support for searching this namespace.

Signed-off-by: Chris Poucet <poucet@google.com>
---
 ref-filter.c | 8 ++++++--
 ref-filter.h | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fd1cb14b0f1..6a1789c623f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2200,7 +2200,8 @@ static int ref_kind_from_refname(const char *refname)
 	} ref_kind[] = {
 		{ "refs/heads/" , FILTER_REFS_BRANCHES },
 		{ "refs/remotes/" , FILTER_REFS_REMOTES },
-		{ "refs/tags/", FILTER_REFS_TAGS}
+		{ "refs/tags/", FILTER_REFS_TAGS},
+		{ "refs/metas/", FILTER_REFS_CHANGES }
 	};
 
 	if (!strcmp(refname, "HEAD"))
@@ -2218,7 +2219,8 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
 	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
+	    filter->kind == FILTER_REFS_TAGS ||
+	    filter->kind == FILTER_REFS_CHANGES)
 		return filter->kind;
 	return ref_kind_from_refname(refname);
 }
@@ -2435,6 +2437,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
+		else if (filter->kind == FILTER_REFS_CHANGES)
+			ret = for_each_fullref_in("refs/metas/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind & FILTER_REFS_ALL)
 			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf5..db3ee44e4dc 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,9 +16,11 @@
 #define FILTER_REFS_TAGS           0x0002
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
-#define FILTER_REFS_OTHERS         0x0010
+#define FILTER_REFS_CHANGES        0x0010
+#define FILTER_REFS_OTHERS         0x0040
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
-				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
+				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS | \
+				    FILTER_REFS_CHANGES)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
-- 
gitgitgadget

