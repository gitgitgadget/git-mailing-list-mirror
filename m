Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF551F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeFWMTQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55437 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeFWMTM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so4631110wmh.5
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rh5rjK7taLEw+OZ8ks/PxL85/7a3WLCpJBPSxQEi5Vk=;
        b=uBJaPRGLfCIzEGgqG1svelA/gDPUVXQvv+HVMzPOesReyTHtadA1MC5PXvucXc6y4P
         ykLDyjiytPxf3t2GVOAZyT134RyGg6Lbby/GvtM4+TWyMHdBREs6aDY5muiFZUgOp6wQ
         ziL/ChVI1mZzcrz+RqiWdPq18IffP+uLB5pccevJTKUzHRkBJuLYyswCZUlbYDasOZbc
         ggVVWbIRfjIKEzCcXoh6UDa5Smxe7w7cEgSTYf0MYdWQJwo385mBS1mBiIh3yDI07zu/
         4RNrGCGrViBxWZ4z3xO/+NnZpPlc4aZBkp2nVaqXHt/zojwlE6wmSoarLCqCCxRRZGC1
         E6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rh5rjK7taLEw+OZ8ks/PxL85/7a3WLCpJBPSxQEi5Vk=;
        b=i4Kd0pT2359KNkUSzY6YAMxyV+ILwz9Jl/1qG5UEG4aHHljrdxEABvMByiG/TQ5Duz
         3S3PgxOQ6rE+My6mIkREVBwMik0svK3HsJccStvyL0caUyUWP+RO7CbS2oav01fMw6S9
         209Umiyed6yxkAHVvCdSr0LHeCXTgu3VJhIPPtabhT9N86yuieP6euNpJUNjVjJhEyOJ
         YPiE6xCZ/jhkKkcvUcT74f6uFmSaZrn6q/aFXI4S/0remmHe8SyCQe80HNXMqYD9zfm5
         0Z5YCaCOxwb4bpt9UD7crvGaQKEZLtbZnB1mv5OwwqMjmKNwWZOeLSPqb7whjzqpogOM
         Em1g==
X-Gm-Message-State: APt69E0ml1WrBXoZIBTrZ393st8wdkI5I7sjn+oJihzDK2OlYXrEdcxq
        z000z5mmwuig11FaVFBUC+WK6zAO
X-Google-Smtp-Source: ADUXVKIYZNePzI5CvOXSlxWqsK28A34VOaEqFzd3G/Kb1CR2FwnRxrwopFUeRGCkUFaTQWLljNsZ/w==
X-Received: by 2002:a1c:124f:: with SMTP id 76-v6mr4488500wms.29.1529756350716;
        Sat, 23 Jun 2018 05:19:10 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:10 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 07/11] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Sat, 23 Jun 2018 14:18:44 +0200
Message-Id: <20180623121846.19750-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make the partial clone filter specific to one odb
instead of general to all the odbs.

This makes it possible to have different partial clone
filters for different odbs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 26 ++++++++++++++++----------
 list-objects-filter-options.h |  3 ++-
 odb-helper.h                  |  1 +
 remote-odb.c                  |  2 ++
 t/t5616-partial-clone.sh      |  2 +-
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1fd4dfd024..52ec2fd200 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1343,7 +1343,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 8e7b9ae776..755a793664 100644
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
@@ -131,25 +136,26 @@ void partial_clone_register(
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
index 2b93d13abd..5b9d1930b5 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -35,6 +35,8 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(subkey, "promisorremote"))
 		return git_config_string(&o->remote, var, value);
+	if (!strcmp(subkey, "partialclonefilter"))
+		return git_config_string(&o->partial_clone_filter, var, value);
 
 	return 0;
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5ddd1e011c..4231121181 100755
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
2.17.0.762.g886f54ea46

