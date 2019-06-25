Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C991F4BE
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfFYNlU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44675 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfFYNlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so27166570edr.11
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJddKki4i5LM7JqqBW9SQzb4BiJmxM38qI9ZRfQYRbY=;
        b=FD8dmn8uEFpVJobXchp+8zElWr2H7TveyRleliHLviZsoha2JUQ5p0i8+deYY3r7cI
         s7i8FcC6XB9dWlMR3jp18rH/nDubhA4a5tiBnv3Qyv2QMRv6uKC+YAQOsLW5S6KY4XDo
         NTbUEaLTXwEd7KvT3Lbb8pPhWMwdMhfZpzUBy0QcbHPgbW+7q4dTK+KMItYq8hUv/QDO
         jZMcvS83y0y3bkIozXAiJDm+RIOUnmwn3g8VH3Whdt9ZHFKJ6zIsGwp0EBzYJT1eGAug
         PYaeZVblngimHtXeZsfKLmrpqUl4NQ0rtLxkCHwMUjmazpSqTfjhmBW51S/jEOzwCa79
         I07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJddKki4i5LM7JqqBW9SQzb4BiJmxM38qI9ZRfQYRbY=;
        b=s4xWR97wuEfsi4WTP1ESaCDhuio5XgaHJwPfGySUmtVGlNqrZEZHkUqekOR6+setd9
         FfLYoL6vslnrLRfzBvAyaQ39oMHNfWh0CEpei10TeWbFK7XZJB89qiLpGW3oCI7fEe27
         PL3OMAQ2YFjdCfHALL0qlTJYg9J6SOSkRn7wFp3AtHbsG3h1RbNtZ3UIn3LQ/UR2KlGg
         H74vIDJh4eMMmUr8PAmS6+1Bch8SQo3Bmt7FsdBxwJobRFJH3cTZKuiwrKWVpx3gtFKq
         FB62yqQe60b/96MQ7L6mWUPDJ1TfR1+mGTmU+HiMAP1NWK3nmtSugKBmHYALNTPDkwIv
         c3IA==
X-Gm-Message-State: APjAAAW7dHQCm7iqxiazirql75U8M8yiFfwbLnvQaayOngfnFLTPExD5
        XwwLP7mFyx7w3EdACPsOYwnoOVrNZCU=
X-Google-Smtp-Source: APXvYqwV2FcoXNRHoYga8vWgUfykka9/PaGMMlZHtk7sJIiophkb1yr9r0kw0ilQuP8N39bpOmfPzw==
X-Received: by 2002:a17:906:914:: with SMTP id i20mr40607945ejd.213.1561470074961;
        Tue, 25 Jun 2019 06:41:14 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:13 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 08/15] promisor-remote: parse remote.*.partialclonefilter
Date:   Tue, 25 Jun 2019 15:40:32 +0200
Message-Id: <20190625134039.21707-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
index b0de7d3c17..28c571f922 100644
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
@@ -148,6 +151,7 @@ void partial_clone_register(
 	const struct list_objects_filter_options *filter_options)
 {
 	char *cfg_name;
+	char *filter_name;
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
@@ -162,27 +166,26 @@ void partial_clone_register(
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
index c54f0000fb..8deaa287b5 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -87,6 +87,7 @@ void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
-	struct list_objects_filter_options *filter_options);
+	struct list_objects_filter_options *filter_options,
+	const char *remote);
 
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/promisor-remote.c b/promisor-remote.c
index 6a8856f475..826890f7b8 100644
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
index dddd4048e0..838cb092f3 100644
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
index 534d03a4d7..078cf48dd6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -655,6 +655,7 @@ partial_clone () {
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
 	test_config -C client remote.origin.promisor "false" &&
+	git -C client config --unset remote.origin.partialclonefilter &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8f9a62aac0..8ae7ba9c95 100755
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
2.22.0.229.ga13d9ffdf7.dirty

