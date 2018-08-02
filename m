Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A88C1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 06:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHBIFc (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50639 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1104581wmc.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JZJmD682YCNpSdPfFNLJ3k++6odwkQLckvo8d3jxtI=;
        b=TuUEiOziami1bJyEpKxWjIUmGsMSyTG1ruZITuE6xrx7ZlTT/IGAQfAwIJTNiKV7mg
         TLHW5EB5hyDsBUEewOUUIUe0RoFnGZHs3qPohi+Ms1Tyq2Mxzr0WfFp5vZAlVO+Zgubd
         JLYuYPDRX/YhINsSDws2cbsnFcnIExBiuDC5SqTV752VvODpZF/06b/BNa7IUosdyiZN
         da/ckogQvW12pB1AzzqdjRNhXJTTHfEJUatPNd2hppDceFwiVZvFoUUQHz7b6LCUCvZU
         6Ji8JKZMxFcPmY+HmwCmp6JeGpXDiZEM9MhwQ7bIRy+fA4jILEuhIzmdfepr4Fm9TeKE
         Ssmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JZJmD682YCNpSdPfFNLJ3k++6odwkQLckvo8d3jxtI=;
        b=S707L4BarkrK4UgMtwgyiPuNHuIUSs3jUHV+fsBmIvboWqPtfeicQPQEdX3AfM3nd6
         Q224LYozANSJNOhq3Z61l0smcFBkA93wGgVoGfMi8XoVtOtAWS+d1zzmWtHCHS8k6V1B
         1dpZvxnDL++9bgqYec86kRcBSTFN+uPyV8ob6RRqYWNXL/gK/xfT2BBzc02LmjYFAZH1
         1kBtKWwr3WWw4RecWd0LmZf1EjgAi4f84v6fU7swkDJX4q4jz3ygTT7A3CM3Cy7V2x12
         uCL/Hs85yeq5M/sGxatd5xo95jwxiXZIcF42v6WnN827FSg3sSghZuqZA+zbeBB40w4u
         9OOw==
X-Gm-Message-State: AOUpUlGIyyLkFn+R9HJenI+UcuzV4yf8M6NQdPbQMbzl//fUsGJCDXWw
        rlDMFflH7Qeve7e/BseA8Y+rnX/q
X-Google-Smtp-Source: AAOMgpdGzkrlo3NfH0W+dmDc7J5QPnvQ0Bvid3yzN1Uoq3zEOA95PTwqQskNRHRZrLaGwo/xFx6YIg==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr904615wmc.81.1533190558350;
        Wed, 01 Aug 2018 23:15:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 7/9] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Thu,  2 Aug 2018 08:15:03 +0200
Message-Id: <20180802061505.2983-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's make the partial clone filter specific to one odb
instead of general to all the odbs.

This makes it possible to have different partial clone
filters for different odbs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 28 ++++++++++++++++------------
 list-objects-filter-options.h |  3 ++-
 odb-helper.h                  |  1 +
 remote-odb.c                  |  2 ++
 t/t5616-partial-clone.sh      |  2 +-
 6 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9c7df8356c..f3dee73179 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1369,7 +1369,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 60452c8f36..755a793664 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -7,6 +7,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "remote-odb.h"
+#include "odb-helper.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -29,6 +30,9 @@ static int gently_parse_list_objects_filter(
 {
 	const char *v0;
 
+	if (!arg)
+		return 0;
+
 	if (filter_options->choice) {
 		if (errbuf) {
 			strbuf_init(errbuf, 0);
@@ -116,6 +120,7 @@ void partial_clone_register(
 	const struct list_objects_filter_options *filter_options)
 {
 	char *cfg_name;
+	char *filter_name;
 
 	/* Check if it is already registered */
 	if (find_odb_helper(remote))
@@ -131,27 +136,26 @@ void partial_clone_register(
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
-	 *
-	 * TODO: move core.partialclonefilter into odb.<name>
 	 */
-	core_partial_clone_filter_default =
-		xstrdup(filter_options->filter_spec);
-	git_config_set("core.partialclonefilter",
-		       core_partial_clone_filter_default);
+	filter_name = xstrfmt("odb.%s.partialclonefilter", remote);
+	git_config_set(filter_name, filter_options->filter_spec);
+	free(filter_name);
 
 	/* Make sure the config info are reset */
 	remote_odb_reinit();
 }
 
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options)
+	struct list_objects_filter_options *filter_options,
+	const char *remote)
 {
+	struct odb_helper *helper = find_odb_helper(remote);
+
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
-	if (!core_partial_clone_filter_default)
-		return;
-	gently_parse_list_objects_filter(filter_options,
-					 core_partial_clone_filter_default,
-					 NULL);
+	if (helper)
+		gently_parse_list_objects_filter(filter_options,
+						 helper->partial_clone_filter,
+						 NULL);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 0000a61f82..12ceef3230 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -74,6 +74,7 @@ void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options);
+	struct list_objects_filter_options *filter_options,
+	const char *remote);
 
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/odb-helper.h b/odb-helper.h
index 154ce4c7e4..4af75ef55c 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -10,6 +10,7 @@
 struct odb_helper {
 	const char *name;                 /* odb.<NAME>.* */
 	const char *remote;               /* odb.<NAME>.promisorRemote */
+	const char *partial_clone_filter; /* odb.<NAME>.partialCloneFilter */
 
 	struct odb_helper *next;
 };
diff --git a/remote-odb.c b/remote-odb.c
index f063ba0fda..49cf8e30aa 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -60,6 +60,8 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 
 		return 0;
 	}
+	if (!strcmp(subkey, "partialclonefilter"))
+		return git_config_string(&o->partial_clone_filter, var, value);
 
 	return 0;
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f7ed3c40e2..e2aeee1d7d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -41,7 +41,7 @@ test_expect_success 'do partial clone 1' '
 	test_cmp expect_1.oids observed.oids &&
 	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
 	test "$(git -C pc1 config --local odb.origin.promisorRemote)" = "origin" &&
-	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
+	test "$(git -C pc1 config --local odb.origin.partialclonefilter)" = "blob:none"
 '
 
 # checkout master to force dynamic object fetch of blobs at HEAD.
-- 
2.18.0.330.g17eb9fed90

