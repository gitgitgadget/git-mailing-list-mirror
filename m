Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907A11F456
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeIYSBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeIYSBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so13350504wmc.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82/YC43NZuh9XZK3VNrWiW2adioe3Bp9GacznZijBkw=;
        b=UyiRSbzj3bNOrONdOw/bZ0KfNNUW8Yc/SFmLVhZyCIjK36RY2km3DSaRbcDm3Br6zB
         53Q/RSTPTPKqVyYTZ4RcVPp/tajoGmy85q7VyiwN52g1jg5lH+EA66X1qSZvlyXmaeF5
         i0xAUTZ+/nVIdR5AI9woe0BZMGEKDgawmfj9tZtToQ1+FVPOIoucBEyyQKAXB+T3fhIT
         RzIyXyGjSIIsrLYI6/xeu1twtBcdgMMg2mVeGq9UuH6srbrLYa8ncUxp6WS/V/jN/eXr
         2dV8JGWUZGUFDiw1CqRiUOKz7W9Om76Q6y/udo36arwblqts8tF4cAamLi+McKaYqZhq
         UL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82/YC43NZuh9XZK3VNrWiW2adioe3Bp9GacznZijBkw=;
        b=ZKI9LCOFxeu4vzQ/fE+TdoRPpyIrBVpHajJR8GVY9uHTc+bB1PbdM1mxMZXH/lvJ27
         xliJGsxhqEV16hwgzMgeM/zM9FJZzyY8vNphKeGEwYHDuFyLHFnLSQBugJYme63u92ly
         +bV3UAk24WA2bzJ43wseeCQFZMIGFGQ4WZZcd/U++z1/ZqPSUBAi4BGstnYJtwmliLpC
         oWHth/bI6TgYQKjikg6z2O58Uq9Wr+GIAQ1MdOxamy6M+fTs62tFm9PUpfdCQhJCll/2
         O/gGhKU/CaP1u33S4uBh8SIbmUedERN5iUgLICvCWlrbnxhggNk9bUJnrFdfCIVO/TlY
         mE/A==
X-Gm-Message-State: ABuFfoioI/0GIq07jWeDAgiHZYw+B3m5pOy8cty4gvSJoTwonTs3RYYy
        ei8IB6neNISa7w3GNfFaoG/WSMOw
X-Google-Smtp-Source: ACcGV60g7reiWmNdSp4ZVI+bKAiTpLyAglz/r2sKeXrlCPtN0OuykpzKSVEMhRnWq2DB19hB7b7C8g==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26-v6mr393520wmb.112.1537876449745;
        Tue, 25 Sep 2018 04:54:09 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:09 -0700 (PDT)
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
Subject: [PATCH v5 6/8] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Tue, 25 Sep 2018 13:53:39 +0200
Message-Id: <20180925115341.19248-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
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
 t/t0410-partial-clone.sh      |  2 +-
 t/t5616-partial-clone.sh      |  2 +-
 7 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e01b65950c..b8701ef7bc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1402,7 +1402,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
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
index 950f9f9cd1..9ec3ff5141 100644
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
index cd1b393b79..57d0215aaa 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -60,6 +60,8 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 
 		return 0;
 	}
+	if (!strcmp(subkey, "partialclonefilter"))
+		return git_config_string(&o->partial_clone_filter, var, value);
 
 	return 0;
 }
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 9ead9860f5..8b32be6417 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -26,7 +26,7 @@ promise_and_delete () {
 test_expect_success 'promisor remote without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
-	git -C client config --unset core.partialclonefilter &&
+	git -C client config --unset odb.origin.partialclonefilter &&
 	git -C client fetch origin
 '
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9897b8db12..12e964c1bc 100755
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
2.19.0.278.gca5b891cac

