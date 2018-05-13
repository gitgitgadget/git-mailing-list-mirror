Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049DC1F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEMKdK (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55885 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeEMKdG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:33:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so8842691wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ns/Z6MfXi+YiV3ezMXsPFKzU1RabluOGlozNbQL8xhM=;
        b=dONqyD34YALWPjXfSPM+TuBZSkn8QpyfF7uUWFLkeD/w+L0xQQ9sTjXZNRvlys3+oU
         MGbAya/BbS+qi+YFjipJ7FKRraVWX+sCxUdP44B79zR0Y2a6mfbk/jsmJfgLG3afAU5G
         4oiLIV51Ect2M71PQlNCfCmNL6qLE3iS5Z4MnC0fBhleGu3DQR12aK5Gv0G7VjQ7VydN
         zVDR8IRSzyUqr5tWPYAmgQAnVfFthYRGBt6GU4PgdNiiz6AuYnc5ue0s++XmguyzX6Gy
         m7/rBNO2kkZkTDDjH34bpkQGg+tvpRG7GxK75TRDq3S3MI4xlCWOAKWSsAecKIVo5tm9
         4JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ns/Z6MfXi+YiV3ezMXsPFKzU1RabluOGlozNbQL8xhM=;
        b=keBOgv2AsBd1Qnn8Bjr8b52mUBkkIukWq8N9jm1yMOhTKhVzN8WmiVSdliAb4eNPcf
         qd99zEqHs1XYUTCB9l6EhK92my97nldDtZ3GxkjLQr67oCuf6cTVNHaPFi03EbcOBVq+
         1yymBk9WhIJLjCb/OCBrQDk/k2Kd3mrl+qrmG+TelTp/Mb8juGtaCTXFJ3653+FUeru1
         2mzQF4M/nsSr6Sh21z1PGncvipoV7C8YMjJa0GXkiJBrCB7qGz9V2K4gx/PsLRFO6LpC
         TzLKawpCAh5090EcSsmZ8gYc1w0JrtJwNVgFi/MfApSO2Xq9H/tX9/+h9x4bvRhnHx4x
         0jSA==
X-Gm-Message-State: ALKqPwcjzGIyz3JVeR60TZIFH1+SnZsARsqMJSkz3RQumZVvRnqyN+vF
        EZrs1gszXRmxWo3cs2yEGED1uA6m
X-Google-Smtp-Source: AB8JxZqHUabALTbIftZnxY6VQ7ZbXvWhGKKWuDXwdyw4QM2g60LK6Itor9dFGirkl334CTN3nvFsPw==
X-Received: by 2002:a1c:a95:: with SMTP id 143-v6mr2755022wmk.134.1526207584735;
        Sun, 13 May 2018 03:33:04 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:33:04 -0700 (PDT)
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
Subject: [PATCH v1 7/8] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Sun, 13 May 2018 12:32:31 +0200
Message-Id: <20180513103232.17514-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
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
 odb-remote.c                  |  2 ++
 t/t5616-partial-clone.sh      |  2 +-
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82a3e655ba..288d58c0c5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1350,7 +1350,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f8a4642d17..59378dfb0a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -7,6 +7,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "odb-remote.h"
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
 	odb_remote_reinit();
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
index d63210d516..02bc3dbe13 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -4,6 +4,7 @@
 struct odb_helper {
 	const char *name;
 	const char *dealer;
+	const char *partial_clone_filter;
 
 	struct odb_helper *next;
 };
diff --git a/odb-remote.c b/odb-remote.c
index 0a734ff379..2c7c35c763 100644
--- a/odb-remote.c
+++ b/odb-remote.c
@@ -35,6 +35,8 @@ static int odb_remote_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(subkey, "promisorremote"))
 		return git_config_string(&o->dealer, var, value);
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
2.17.0.590.gbd05bfcafd

