Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5768A1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfA0Tlk (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:41:40 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51140 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0Tlj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:41:39 -0500
Received: by mail-vs1-f73.google.com with SMTP id f203so6695814vsd.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W7uFzqyjRWxwkCF3xj4LWTSLlruZYya9JwjsYbq/8mE=;
        b=AWSicmcISiv8dXabesvyP6wsHPIIJQJFDAe0P8LCdN8H+/AkytcCy6QFaAC89qtPJ5
         dQ1kLmW5sdKUGNTCrlX4w4lV39e4mY0yO759j120CdqeB6uZTFa3mOKbD+fwqZYk9f7n
         aZ4bH36sQxT6mqlR6H3t+FlQ3AElnrpRBKHw3ORotQKkGEEoO9CLCifq7ulg7CLSD74/
         qYLvXIn7qkH+gAW6tXOTPpEK8PG2unKGKjo4NAETgNObfiNdgiXJJ+x2MuOecBN8zWfE
         KXfWaRv3vpjpzkb4pO/T7ZsmGII5uJmwHxbxCKxAQAbkfQHt0bCuEFrrdmr2thkFsI7m
         pq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W7uFzqyjRWxwkCF3xj4LWTSLlruZYya9JwjsYbq/8mE=;
        b=ZmKjAtIL4DPpTpvlxtiqDslzruJpxVVpYzYvh5ttDFI0XM35CYxNVTet9gbFMuXBct
         DwW5S/BMJ5nKxwEUEpZ5XRDxrE6Ehp5N+LIOjJ4EmXuYiAIB3vM8Q1f6RAxwBHPp5znc
         ATcjfgHO1atcW9E/LfpR0+g3FPpvAeYiOFxkrPiVzEc2ztwEoDzxsfouasRIa8A7YrpM
         7BX3Qykwu/nPnSQ5TDuB2MT5Gbjr8+ypPJ9q5HyMi6k4Gv7JjM9l5UV1qWgi89dXMpWC
         zybuHFoRljbihKtmfBIMmPLhT2qXE4M2d7Y3kDOHsNe2s0LzDabDUuCZd1H3Ru4HiDEw
         Cw6Q==
X-Gm-Message-State: AJcUukeUiZkE2j+hN7acwWKXAPj/FK/o8kBlKKNrcqrClhKAXcUtBhrR
        PMY4MF6T+oOkXrx0erdlEl+6gnDafWOI1e4pynSFpGrO+wiTrn+UpcjftNio92Mr2WR+YOiOHYt
        ozKgLgJtKvmutWpGbrB437FJWYCgg0HbtF9y968Y8pYaeSuXUcEuGJlUsZg==
X-Google-Smtp-Source: ALg8bN5PMV38Mu6Kdf9mdzZomH9+vGQl+nQ9cBCgZVvdms2ftCToDPye3OeTI5FMObWU+3AYOkLmiKaEyps=
X-Received: by 2002:ab0:278e:: with SMTP id t14mr16505669uap.5.1548618098191;
 Sun, 27 Jan 2019 11:41:38 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:41:23 -0800
In-Reply-To: <20190127194128.161250-1-sxenos@google.com>
Message-Id: <20190127194128.161250-3-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194128.161250-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v2 3/8] ref-filter: Add the metas namespace to ref-filter
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

Signed-off-by: Stefan Xenos <sxenos@google.com>
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
2.20.1.495.gaa96b0ce6b-goog

