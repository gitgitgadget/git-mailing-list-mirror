Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F361F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfAUWca (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:32:30 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49407 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAUWc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:32:28 -0500
Received: by mail-qk1-f202.google.com with SMTP id s14so20382626qkl.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WqhtwsxwpDV2Ccj3BLiSJs3MJjNMvGGkbrGHBlaiXGc=;
        b=qi4ofmvyTU6V2TfDsu4XRb13SQpuVDe4oVZCpA5/3mZNY04pH49OUqoZafuZdvozjG
         YhVY3dPws32YfK+oMdSSR27SjO/0l/dDh/CrHa3SHd/zQPEyW2X7Z1ck5B8drj9Z0hy1
         ybtLjjKQAt3JZXCOWqTt4FU+pnJGT/SD2o/2sF2xiMKIferq63mkesjmUM9eXFbh5tIU
         Jku7t7Cq1vGbL34CLjeVx/a3Ct0htDQL7Gqxt+roBPem3wJzj27iZPTDIko3lgWSJVfn
         4iAoZgIy3aJEiv2v6ihuLq6mu2RCkr7eZQzkzV03fVhikQCg6wpiULC3Az1sjnyHCX7Q
         mhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WqhtwsxwpDV2Ccj3BLiSJs3MJjNMvGGkbrGHBlaiXGc=;
        b=RKS/m0tm4BPNybDdgsnJTiFS7XlkU+PLM9HIghtkd4oYuPynwmAKnXUHJ0a433/zYK
         vyYJ20aQiDrCpixLKOv+Y/CtfbgHWo1L9YmgCpoimebINNK0+vIiZJyRfasSVhakdKVq
         TvdFgCkqCTHcUr0Ipo9NG7nnikj74A9gtxiWiAPHorQJNveEtbZewX0xPCUiZEb92ve+
         MWpVZfYOrSEtoxXUIZPR72STWcXsI8KvqjFQ2Lws77oUNxBeiAK0zrqpWF6uMgwYnGY2
         /PioEfrPe7aDA0vu9C7YYURoS53whCd+OkUGmZ7+t4LYMBMSYNM+OwcO5Seole3dyNxJ
         t+pw==
X-Gm-Message-State: AJcUukdVNzIZSsjq81spM4sQ2upd7TOYnYiwQXRAaWhS4Pbf8SFTEVd/
        cUAlNp/NS+aGMPWtZLOVp8S271NDDkv1JUZhEex5v5+eeQ77MRw+eC3VExXc7wcojj2gJQJxgwe
        eb1GweDHqAUyLFr4s2GjWcmTrLmzorHK1dOqYO9FRTedkYG+bJrl9qBJRiw==
X-Google-Smtp-Source: ALg8bN5gFROcQ2+kxqUD/Usw1ttANhBWKtup2LN04jSVMUtnx42V3YS6ETgyYtjes9rZell6SYXJ8E+2sgE=
X-Received: by 2002:a0c:add8:: with SMTP id x24mr20655991qvc.16.1548109947805;
 Mon, 21 Jan 2019 14:32:27 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:32:11 -0800
In-Reply-To: <20190121223216.66659-1-sxenos@google.com>
Message-Id: <20190121223216.66659-3-sxenos@google.com>
Mime-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH 3/8] evlove: Add the metas namespace to ref-filter
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

The metas namespace will contain refs for changes in progress. Add
support for searching this namespace.
---
 ref-filter.c | 8 ++++++--
 ref-filter.h | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 422a9c9ae3..4d7bd06880 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1925,7 +1925,8 @@ static int ref_kind_from_refname(const char *refname)
 	} ref_kind[] = {
 		{ "refs/heads/" , FILTER_REFS_BRANCHES },
 		{ "refs/remotes/" , FILTER_REFS_REMOTES },
-		{ "refs/tags/", FILTER_REFS_TAGS}
+		{ "refs/tags/", FILTER_REFS_TAGS },
+		{ "refs/metas/", FILTER_REFS_CHANGES }
 	};
 
 	if (!strcmp(refname, "HEAD"))
@@ -1943,7 +1944,8 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
 	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
+	    filter->kind == FILTER_REFS_TAGS ||
+	    filter->kind == FILTER_REFS_CHANGES )
 		return filter->kind;
 	return ref_kind_from_refname(refname);
 }
@@ -2128,6 +2130,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_CHANGES)
+			ret = for_each_fullref_in("refs/metas/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind & FILTER_REFS_ALL)
 			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, broken);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
diff --git a/ref-filter.h b/ref-filter.h
index 85c8ebc3b9..19a3e57845 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -18,9 +18,10 @@
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
 #define FILTER_REFS_OTHERS         0x0010
-#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
-				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
+#define FILTER_REFS_CHANGES        0X0040
+#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+				    FILTER_REFS_REMOTES | FILTER_REFS_CHANGES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
-- 
2.20.1.321.g9e740568ce-goog

