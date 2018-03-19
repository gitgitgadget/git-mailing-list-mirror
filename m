Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C3D1FAE5
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeCSNcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51116 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933301AbeCSNc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id f19so2596014wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzSAv8Hnt4WpzQYMa0Q0g1ANehhc2XlfMP6Arh/TMQc=;
        b=lfuQ7QSmlpBTKyDd5MlDP9OyQv9UHoTvbb41L0d2Ov1XLOu5HBuG/40AM6qZZBzgn5
         2sif+2nP4RtD5R7WJF7gOXQlYv6PglT2vi3sJbzq/dA97Wx0J590WNm6iP0Ag3lpdK1u
         wShEO7c6blqu0XQ1nahaQ6WwGldMDW2suosC4cKWrupJGOXBJQ+I091Pui7F7qPfU/R8
         ZTMD+O3GyN2G8+sNTCw+f61yZzRVQ+BKEtY8E5jpUn3ELXfIXK+ot9nl4g0OSpdPFFlv
         D/XJHIPnPD9bLAQGEanRwt1m5Fo4dBJpzHbwJO0nyzl3v+xIH1Oi4m2OcVHRu5Zccwlk
         Sa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzSAv8Hnt4WpzQYMa0Q0g1ANehhc2XlfMP6Arh/TMQc=;
        b=VbL9LTlVjf73CvGjW3PcjGufV5NgGi254LJcaIZcJ328KdD8KK0Lerb7CZmPNwYwB0
         M+6io40OEnKq9F880ODKwO63FcE53YoclOn0HZlihvjBaZo7/irj6KeUotyA1W1zEJcY
         +xWzoCepSiZrakS3Q19UE3qqqjoqpXA94Dn6FREtXQqBLqciOmROv8g1+mG8WV/lIHwm
         1cJZ4j+nNKV6/yhYAX1cA39S0afxd/I35br/b2MGm+9fExVQePi2kNYKyXL46a6qt9nX
         SgzMvcNZoZoFYRbaiZoETwtkWnPSFzQCStkpaPQ1hYLxM90D0TpmDVJL32Jn9gp+G3qG
         fhZg==
X-Gm-Message-State: AElRT7Gl0csCjflKCNt1ytjo9P1g0E0ZwgAwZaCa8s29nh2TR7oosWDs
        dO6MXy4F1QfG22uyuoEznnsmtn5S
X-Google-Smtp-Source: AG47ELt7PyiGHLho4FFDKzIvhjxb0TA/VyB35feaMSBEfu3Y5nhAtYqXnGjyPOxsa+Rf6ujXYK8yaQ==
X-Received: by 10.28.178.136 with SMTP id b130mr1871959wmf.68.1521466348163;
        Mon, 19 Mar 2018 06:32:28 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:27 -0700 (PDT)
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
Subject: [PATCH v2 14/36] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Mon, 19 Mar 2018 14:31:25 +0100
Message-Id: <20180319133147.15413-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 external-odb.c                |  2 ++
 list-objects-filter-options.c | 23 +++++++++++++----------
 list-objects-filter-options.h |  3 ++-
 odb-helper.h                  |  1 +
 t/t5616-partial-clone.sh      |  2 +-
 6 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f4a138acc8..11c9561bb4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1333,7 +1333,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/external-odb.c b/external-odb.c
index 8be92277d2..c3d90f39fb 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -47,6 +47,8 @@ static int external_odb_config(const char *var, const char *value, void *data)
 		o->type = ODB_HELPER_SUBPROCESS_CMD;
 		return git_config_string(&o->dealer, var, value);
 	}
+	if (!strcmp(subkey, "partialclonefilter"))
+		return git_config_string(&o->partial_clone_filter, var, value);
 
 	return 0;
 }
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 12e52bf659..ff493b9163 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -7,6 +7,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "external-odb.h"
+#include "odb-helper.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -116,6 +117,7 @@ void partial_clone_register(
 	const struct list_objects_filter_options *filter_options)
 {
 	char *cfg_name;
+	char *filter_name;
 
 	/* Check if it is already registered */
 	if (find_odb_helper(remote, ODB_HELPER_GIT_REMOTE))
@@ -131,25 +133,26 @@ void partial_clone_register(
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
 	external_odb_reinit();
 }
 
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options)
+	struct list_objects_filter_options *filter_options,
+	const char *remote)
 {
+	struct odb_helper *helper = find_odb_helper(remote, ODB_HELPER_GIT_REMOTE);
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
index 2c529af6af..3ec2d8448f 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -17,6 +17,7 @@ struct odb_helper {
 	enum odb_helper_type type;
 	unsigned int supported_capabilities;
 	int initialized;
+	const char *partial_clone_filter;
 
 	struct odb_helper_object {
 		struct object_id oid;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5c84b0f95b..d9b8418275 100755
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
2.17.0.rc0.37.g8f476fabe9

