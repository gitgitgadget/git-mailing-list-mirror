Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9839620374
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDIQMA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36362 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfDIQL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so21664692wrd.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7kJteAebVRyJIp9QFI9Vj/9kYAzKjTFmNSjo80SK4s=;
        b=l6gmz23nLdhmAn25y2zOT8RLh8UO/DfbEYR7Fjm7a0xgtm9TZm6c5AEPxQoR5+2Rvj
         PRjKpS1RgHWG8TJy86XbE9io42NWea1NuN3MI6SiBjbtp/e7HSkzuU4ZpQTO7Uiv13Fa
         cJaMNi+Agj5irUhX0r4ZiW0m5HTdTw4Q09vjaeYau0C7ON7AVij+puoV9wJ7JHG6VDsr
         y5z4C5dahm8I1gl9JMJFukiLzca4WJ4GPVngh0/bnQ4zL/CiUr9WT2Eju/+OTtJ6LAcu
         fJXl+krFqUSD/PofS7k5LFaC33F2hkyvIjGidquE/lsxbjShWmdci3EJPh8HBTIvRf93
         bpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7kJteAebVRyJIp9QFI9Vj/9kYAzKjTFmNSjo80SK4s=;
        b=XGG8IGKek2b9+NaitNzkLSj5Byg4vXSj4i+xb84qiIerL5+RhZdn3sC9Uxf9jwuYXW
         DCFEEdW+b2FGLKC8g9ayR7JUBehLzsuue2jvUvr8OS0l5JLlEugzVwuUL6xzCyLhSFr+
         8VXNWwCrh0sPsk13X0EEF17mXpWxproBkb14N908rt4FWQ7qTjypLanbqOTf51xtU9bD
         rNUvTR0blE69TBEtTQ3axJrcMKUTYzM7P1Ke/6BFa6GXToQq+2LptIusZwhPoBdhxJJw
         PlbkHT034ZGaOejeAJ1sJUUOhjkf5ZvlWFDYKPJoOTEx5MRVgCRSOv9dpeufXxjxoqSL
         6qWA==
X-Gm-Message-State: APjAAAXIfST43pd3s1LZ50R/yHGlI+DqRN+aZ7vnWGPTlZKEoDSaTBxu
        ZITgNewLTwz+fVlb2U6nKzu1CGAG
X-Google-Smtp-Source: APXvYqygIFQ+ckuLyUGVVA9JbqPGNtP6T8/Sg0tQ+KswSfhIUWM3cDTkJ1QoGj7sFvp2T18X+qOT7A==
X-Received: by 2002:adf:e510:: with SMTP id j16mr24485764wrm.259.1554826315645;
        Tue, 09 Apr 2019 09:11:55 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 09/16] promisor-remote: parse remote.*.partialclonefilter
Date:   Tue,  9 Apr 2019 18:11:09 +0200
Message-Id: <20190409161116.30256-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to specify a different partial clone
filter for each promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 27 +++++++++++++++------------
 list-objects-filter-options.h |  3 ++-
 promisor-remote.c             | 15 +++++++++++++++
 promisor-remote.h             |  5 ++++-
 t/t0410-partial-clone.sh      |  2 +-
 t/t5601-clone.sh              |  1 +
 t/t5616-partial-clone.sh      |  2 +-
 8 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f74bd78144..13d8133130 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1491,7 +1491,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f41a831fce..02f48b7c40 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -30,6 +30,9 @@ static int gently_parse_list_objects_filter(
 {
 	const char *v0;
 
+	if (!arg)
+		return 0;
+
 	if (filter_options->choice) {
 		if (errbuf) {
 			strbuf_addstr(
@@ -146,6 +149,7 @@ void partial_clone_register(
 	const struct list_objects_filter_options *filter_options)
 {
 	char *cfg_name;
+	char *filter_name;
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
@@ -160,27 +164,26 @@ void partial_clone_register(
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
-	 *
-	 * TODO: record it into remote.<name>.partialclonefilter
 	 */
-	core_partial_clone_filter_default =
-		xstrdup(filter_options->filter_spec);
-	git_config_set("core.partialclonefilter",
-		       core_partial_clone_filter_default);
+	filter_name = xstrfmt("remote.%s.partialclonefilter", remote);
+	git_config_set(filter_name, filter_options->filter_spec);
+	free(filter_name);
 
 	/* Make sure the config info are reset */
 	promisor_remote_reinit();
 }
 
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options)
+	struct list_objects_filter_options *filter_options,
+	const char *remote)
 {
+	struct promisor_remote *promisor = promisor_remote_find(remote);
+
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
-	if (!core_partial_clone_filter_default)
-		return;
-	gently_parse_list_objects_filter(filter_options,
-					 core_partial_clone_filter_default,
-					 NULL);
+	if (promisor)
+		gently_parse_list_objects_filter(filter_options,
+						 promisor->partial_clone_filter,
+						 NULL);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..70d27f44ef 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -89,6 +89,7 @@ void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options);
+	struct list_objects_filter_options *filter_options,
+	const char *remote);
 
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/promisor-remote.c b/promisor-remote.c
index 737689d044..707a8005c5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -75,6 +75,21 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		free(remote_name);
 		return 0;
 	}
+	if (!strcmp(subkey, "partialclonefilter")) {
+		struct promisor_remote *r;
+		char *remote_name = xmemdupz(name, namelen);
+
+		r = promisor_remote_lookup(remote_name, NULL);
+		if (!r)
+			r = promisor_remote_new(remote_name);
+
+		free(remote_name);
+
+		if (!r)
+			return 0;
+
+		return git_config_string(&r->partial_clone_filter, var, value);
+	}
 
 	return 0;
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index ff69963907..562c7ad8a4 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -5,10 +5,13 @@ struct object_id;
 
 /*
  * Promisor remote linked list
- * Its information come from remote.XXX config entries.
+ *
+ * Information in its fields come from remote.XXX config entries or
+ * from extensions.partialclone or core.partialclonefilter.
  */
 struct promisor_remote {
 	struct promisor_remote *next;
+	const char *partial_clone_filter;
 	const char name[FLEX_ARRAY];
 };
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 3559313bd0..3082eff2bf 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -26,7 +26,7 @@ promise_and_delete () {
 test_expect_success 'extensions.partialclone without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
-	git -C client config --unset core.partialclonefilter &&
+	git -C client config --unset remote.origin.partialclonefilter &&
 	git -C client fetch origin
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 15720847b0..8842b029bd 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -654,6 +654,7 @@ partial_clone () {
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
 	test_config -C client remote.origin.promisor "false" &&
+	git -C client config --unset remote.origin.partialclonefilter &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c9e5f14165..107b247336 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -43,7 +43,7 @@ test_expect_success 'do partial clone 1' '
 	test_cmp expect_1.oids observed.oids &&
 	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
 	test "$(git -C pc1 config --local remote.origin.promisor)" = "true" &&
-	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
+	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
 # checkout master to force dynamic object fetch of blobs at HEAD.
-- 
2.21.0.750.g68c8ebb2ac

