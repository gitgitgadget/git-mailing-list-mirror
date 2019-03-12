Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072812032D
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCLNa0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38243 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfCLNaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id h58so2304111edb.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vgE8u3JELRG3wC0Dr88hM793h48CEHKwFV0X/e7YFs=;
        b=F7nIfxL/kC+ZiSbawXOLdAnb7g5nVw40sBC1j7MI7ZOovjV6rO4S26fwiCDQaYViQs
         YEKNz8Rt9K7p4HEYtdMly3kliy4fOmUPKotiqHZ+1Wp2iVzk75/phPp2tE2ecq0bKNDB
         njrlJkmnGQpOIlnGNrT3t0xCoTX5JRV1TBc3eD2zs9Nd4mHEhNy0prN9fCbT963n/o8h
         Q945NldIwEr4ubyw1RUtL+WgqALOaVEz3ER8wUW2u/BtZrFGpp+6+wo9EuEuo98ipbM4
         K9F1rdtqhJMvxEqqd5R32yAyRQT58Y0ptipla9n+lPh8ktPccFvLrHhswhRZo50ILVHp
         lUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vgE8u3JELRG3wC0Dr88hM793h48CEHKwFV0X/e7YFs=;
        b=U/Dj1InQR/O1G0CUfqMy1lR6Y8Gqf3R3t5sG4porK0NXezUOIas+BW7thNEJc/3q9d
         FnxOSdsR2ozLfLd/WLnLedwkvG2+zkNwESQS0XkA4qde1xN+h6q1Cr0ems7myv8CiS7K
         TKJ7L5Kyzq2mY45mN4qGzzA04H3nhF+kv8Z6XTC4pG9YEk7M2RfdKgAJGrRGpwMGk7fF
         lUIrTCBSN8E3V804wmpLhFPuIaNtpRA0s8zVmzDaCuxQWBORUo6E7SpSErXBOTxpuK5W
         uEPyOA4UxUqNbw6yovTcv23v5vT/9fmtNAUAziRDE1hImE93uzn5D3CKq8PC7WOSJQn7
         5f6g==
X-Gm-Message-State: APjAAAUhSUYtH9tT9m6cFtrIINq5hVFfPeQiPx0eYycg4//+bTj5NqAv
        w5vQSgPVEpC8pDTMbz7Pp/HTFVyD
X-Google-Smtp-Source: APXvYqwvEVJlIOOOosy15pKp/QQlqKp2LC7It29+v9ow2Ut3LDJ/jQZS1UZDGHRKDZD4IYGEzm+7DA==
X-Received: by 2002:a17:906:d71:: with SMTP id s17mr24379683ejh.233.1552397422565;
        Tue, 12 Mar 2019 06:30:22 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 07/11] promisor-remote: parse remote.*.partialclonefilter
Date:   Tue, 12 Mar 2019 14:29:55 +0100
Message-Id: <20190312132959.11764-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
 promisor-remote.c             | 10 ++++++++++
 promisor-remote.h             |  5 ++++-
 t/t0410-partial-clone.sh      |  2 +-
 t/t5601-clone.sh              |  1 +
 t/t5616-partial-clone.sh      |  2 +-
 8 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7edf70ae6c..9d436bd727 100644
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
index dcf6ef6521..ed33dfa86c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -70,6 +70,16 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		free(remote_name);
 		return 0;
 	}
+	if (!strcmp(subkey, "partialclonefilter")) {
+		char *remote_name = xmemdupz(name, namelen);
+
+		o = promisor_remote_look_up(remote_name, NULL);
+		if (!o)
+			o = promisor_remote_new(remote_name);
+
+		free(remote_name);
+		return git_config_string(&o->partial_clone_filter, var, value);
+	}
 
 	return 0;
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index f96722bc66..f0d609a3f5 100644
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
 	const char *remote_name;
+	const char *partial_clone_filter;
 	struct promisor_remote *next;
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
2.21.0.166.gb5e4dbcfd3

