Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E031F939
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeGMSGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbeGMSGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so25897756wra.13
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TELGS2/cH8VH7UmHxWBLz4TdgY10ZiWkZQGG2jFVApQ=;
        b=nMI/xfA/sY2A34WGbec8ZeORrzMEJF7A1nT4+M0RfT14XJn8hy8wB5pJ7mRURKl2O4
         X1aImw1wzlS94b+SJ+UmFuzIRk/Mxa0x69tDPqXADIoEVne+7+wVpzK+KjN96aLn7G2a
         SYCJcj6qHzj5FbOEu4R8Pu+FzPQvcMBG0TDf4fAmJG6RpNTyKyhRPYf0w9qjaAbLPObu
         EEMOQBB2QZaiMbJHLTEvIZ9YVadWl6vESELFjzv2XgiJUdBsFSBh7gpSNOpfgr7fx5h5
         5bk4exyheiI7kHCkaCFswOWS55+95fLCv0TNrllO0RRUAuj/YuK0DnFuIf81sRQ+BTo2
         LBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TELGS2/cH8VH7UmHxWBLz4TdgY10ZiWkZQGG2jFVApQ=;
        b=bqoGQ8ccaUT2ky69kg7VgZFlF6lwnMZASJO+fp3HcKxI1nKX2d/iFNR3AywELI7sK7
         IBXPnSTLHd0v0b4JEDihDLgtKgB4NSZFphN7W6LLKErqipn0oeLQ/thm5s0ad1wx3nOd
         QkZ4w0m2h+c63TXvQj+dy4f4CormWeo8ThqWH9LyjOnmZPiLMN+6flIHENc/0Y5w0sIQ
         smXICrx0azwqsoIeQleoTVLD3l2E2Y4PDHBOpFOUHnAaw9aWDsxGYVU6pM+O+QncVDFA
         n8iGdIkGdJ39xU4punDZxYi+9VMAMnnvpw9rF5DIHJVN1UL2frPMaWXbOBTZd6U9oAW2
         mafg==
X-Gm-Message-State: AOUpUlEToBYlvfLGvnEyl0KpmE6L3LhX9sb5RpAWC9LWJFXxHp09DMHz
        AVcm6EZHmZKXeHYBagPr6oJipkWJ
X-Google-Smtp-Source: AAOMgpfKgga40EB70TE/GDwh62Mtxy8EQ4zE1B+Cn190YsG+3wFNN1cnFLloZ0HUz8qisYnHlsGWnw==
X-Received: by 2002:adf:8162:: with SMTP id 89-v6mr5427271wrm.192.1531504228677;
        Fri, 13 Jul 2018 10:50:28 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:28 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 7/9] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Fri, 13 Jul 2018 19:49:57 +0200
Message-Id: <20180713174959.16748-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
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
index 53a72b4ba5..847a865057 100644
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
2.18.0.171.ge260395bfe

