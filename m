Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F318020377
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfDAQlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so12925427wrq.8
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRvaOHZrhq0jAA/oA15gHJuClvo2KX/XJJUNX8gMdB8=;
        b=LnFnt93jo/tVGlfa+YoNG+Or3x3jZyFkrocPLr0jrC1UXAFOpn/Kz8vDEc/Z4zjaXR
         XXY7a+wJVIKM29I6kf3JqoIP1xzz5bNA15VOqtjWEaQXowLAlOpG0mgXmLp7b6QQT5QK
         zNpqpmheAEDEGw/DhHZFQLKwOFYNTrjy0qoSfRnvbs+74nsl4PlsR0tY/z8+Vzf+DU2G
         x8UIpGPI/+fq73yyN64D4ZfDvXl6lU8cRg2fGUoB82IyJ42ZsbEVelH//ots582NE1iW
         K+0l6DzKYbDSFbAFgHNBgWm4TlJ3KcgZOfQ7WE0hvUzhxAEWr8TUzVOOUZe29KRJeknC
         d6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRvaOHZrhq0jAA/oA15gHJuClvo2KX/XJJUNX8gMdB8=;
        b=hs+uiHQ+Iq/dUCfcx5G3xXmXeqIBX/sLSxO63e2gpO6qJiItUiRVP3DAEMtfVI+NGb
         zELRS0F5+Bg9ZV1BgD46OF9mOk5hft8/RQGOWAVoc8UA6bSdFgnEzq9pJYrwltRwKRE8
         d1Ms9UT5qza2xskNFk4Hd65uW6beL94bFT3qTvNGDSwcVxbT8cfGvG+k2LaJcj2slors
         eishuUvSMES/BnAXnOYo/C10asqYccViRv7PZiMc+jYMWTSY/patgpUw9MqUlqmbDSgv
         nLDnGth+mq8D1ZhtccDKuKNTi7VcTVnrUnJNMCSlUmOe/JSIUS5XX6itKnruq9m1RNL3
         27kA==
X-Gm-Message-State: APjAAAUQ6O1NMzOUq0lqVq+0qB8sBJjWzFrbDBp23Ru6mx+hXXaVUthe
        LQUK6/NLhZ7iz8MIQnspYXBPI3uV
X-Google-Smtp-Source: APXvYqzRcAZLUt4D+WNlqKDJqjHyeaShxjrPUGFQnPF/5WdzFUuwn60vj9yI7wFCi4W6fK+ALzgwfw==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr43852178wru.58.1554136882850;
        Mon, 01 Apr 2019 09:41:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:22 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 07/11] promisor-remote: parse remote.*.partialclonefilter
Date:   Mon,  1 Apr 2019 18:40:41 +0200
Message-Id: <20190401164045.17328-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
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
index 6a689737f0..dbbd1853ee 100644
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
index 071dd6bbca..e29cf507ab 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -3,10 +3,13 @@
 
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
index bce02788e6..9266037714 100755
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
index dd658f8b32..2e82c70f33 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -654,6 +654,7 @@ partial_clone () {
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
 	test_config -C client remote.origin.promisor "false" &&
+	git -C client config --unset remote.origin.partialclonefilter &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index e8ca825ab7..ba0489b41a 100755
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
2.21.0.203.gd44fa53258

