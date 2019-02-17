Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10681F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfBQKKE (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37240 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so7276244plr.4
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lm42Q/wC0Ztr+5skw3SdWf5M+qFQHnFyFkjCHqp9Evo=;
        b=o48pbhmN8HXRjOsMav5JXIad+SxKz1tZddZ0L/I172HgdVve8g3sR14TffnqztFsOp
         gbUwaSvHFRvaBt/iIrW6BDKq3iFyomKbfIJZPA7FYFEDIf7ZVfGNd7UJkZ4UV0OlwhG1
         kO3kHK+LrxcPZ0oFadmmM+NdyN2JhZRG6RDrlcJqepjexqYLoJ+pwSUEZHRqwWfZNsN6
         Vf7F3AIPy7SZQyK26fbT9Nwyau2/WC0J2/tbrPr6BSmRt8+FPKwsvO+s2pxv9rlSCX6X
         rkXBhAnD8KhnuD3AIy0qSKdXUABtEdbUFyB7LWjF7BJhOdQYyoEz1vHINZg+CFIxLhrl
         74Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lm42Q/wC0Ztr+5skw3SdWf5M+qFQHnFyFkjCHqp9Evo=;
        b=obFhURwL4CDIE9eI7znPUJ4JDT9uIRUGw4+Ltm3F25jkrzR23kOJohIOxwgiCmEE6u
         tt3dVV3/DNWCV8vSa+RtR3cVFzYOzi0mDN4A4gJRaoqNSoDK6qbqhTkCSDAEbx5PDbex
         RKjORqUITdMqVIaPWivCkNoeAgTbF5VHOJLsyN+kZD+W+6nDmIfjI2hHEJKDwIg8vQXp
         88UGoRIvkUfyEdoL5dq9u2cROLrNIYL7Ut8BdZINeEexf6ndleyozsFsVkuXwjdF49V5
         4q72CtR1rlJgkJej7SuXrldr4OVlv3+LjhWFOTgs089Z67hLRQU1fLEernbs6N1DoX0p
         yXyA==
X-Gm-Message-State: AHQUAuYu5i4p0BHYUVTJNfLP5odTwFLlhTgcWXdkT+QOmDKozSYm8hkE
        nMAv3lnVsbOpTTqc0XaUulULe5q/
X-Google-Smtp-Source: AHgI3IZRkMaPcZsZ7B0xd9zP7z9gCsunUmu8M8lBiAj5kA5TYvnSRVFqE8egGNHifM+IS4XOoVyMkQ==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr19589904pln.285.1550398203047;
        Sun, 17 Feb 2019 02:10:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l12sm98045pgn.83.2019.02.17.02.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/31] sha1-name.c: remove the_repo from sort_ambiguous()
Date:   Sun, 17 Feb 2019 17:08:52 +0700
Message-Id: <20190217100913.4127-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 15a1107998..7558ce51a3 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -383,10 +383,11 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
-	int a_type = oid_object_info(the_repository, a, NULL);
-	int b_type = oid_object_info(the_repository, b, NULL);
+	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
@@ -411,6 +412,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
+{
+	/* mutex will be needed if this code is to be made thread safe */
+	sort_ambiguous_repo = r;
+	QSORT(a->oid, a->nr, sort_ambiguous);
+	sort_ambiguous_repo = NULL;
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -458,7 +467,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous_oid_array(the_repository, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.21.0.rc0.328.g0e39304f8d

