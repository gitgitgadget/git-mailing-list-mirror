Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE411F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeF3Ig2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54989 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933727AbeF3IgM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so4295670wmf.4
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=risCJx6WjMoo1lHU3dITa/+sZ3YaK0bPsThyv+kBkoY=;
        b=jZ3lk8t/zWt8A1ZU0RC85ZFhkDklwUsflHQKcUqrdeNo5e50wY/oGxDymscgLu1WyK
         ENKBtaqc/9sq51A36B8bsNaf/5Zb1sQKsz13d1f/Eu8byphT/k7gcwTBJr1shmRqwJfF
         DkjfNrjg4ek5az/wrQX5DB/Zvq0+yjPhKIcwtZY1nAoEyrSZG24/R5C/SMVysRkXmMI1
         8fxZrIxREfMLBf4wVD3WCsDLcZ+dsM9lBrZW+Qo8xSy8jrkjzjmmdMsn8GLNGA+9uTXk
         bHCERUc565B67WqOnWLkThKffNSaV1okoE203udDDle8EgAUMSLv6Q1rV22l9QJP94Wk
         TPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=risCJx6WjMoo1lHU3dITa/+sZ3YaK0bPsThyv+kBkoY=;
        b=TnEu2O/COsqzRCB03Y1yAeToGwjMSDxsMw18fA/LrF3cjYYwfW0UFJiNpU2cCABLk2
         gzWU66VKMa8Nkwkr0zQRt9+BKuL1MTlsaA6obKArtl1sJaL5T3yr6zT1yiPMyHqKL2DR
         asl70DUMM1YiJHrS+VhKQvh2DZSoLOg8cLqJSKjEphNrT06s9LSZZ1U5K9fg5O6cG46y
         1LwGnhV8Qtk2DUyS73XyRFpMZkBkwXtf/At8/wf/8/CwpBklIActpLotjOfgZpIutj2y
         1R4K1louywMVGH38iNTnWRGnE+iV39+sRszD/nsC0s3PF5DhsEg9jCSI6py6oFBJx4d8
         InbQ==
X-Gm-Message-State: APt69E2WxYgiG0DAicTnzjrjNr8QlM0cEeynsF54487QG74QmmKRK4rJ
        hU1b4zOqehJUlh7batSKVzzxRO/i
X-Google-Smtp-Source: AAOMgpdAWX0ZonWC1o0iQ0af9iHMU2UhvSBR3L84CqiLq0RgpzBWN8Tjc8RQ7s8jmW/S5DaVjkw/nw==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr3869221wmg.58.1530347770392;
        Sat, 30 Jun 2018 01:36:10 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:09 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/9] Use odb.origin.partialclonefilter instead of core.partialclonefilter
Date:   Sat, 30 Jun 2018 10:35:40 +0200
Message-Id: <20180630083542.20347-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
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
index d465875a4d..eb580ca513 100644
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
2.18.0.138.gac082779dc

