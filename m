Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D63A2141D
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfAVOmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43263 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfAVOmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so27589800wrs.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZRENqqB1Cr05lFyho5k6QBIbX3AIqDSaA42cqBx5AI=;
        b=fwL6HfNnc/Xlpqsm7kxWcP87eQLsyaR7AJ0BZdx7ZGQpMALKDpNNpPmmoM3cUWbUX6
         q2C+EHkJ3T7sWSo8JIEmgIjeCDetETFmK4tu8+2WnOSn6i4b2U4nl+e2TIQzCoeDno1a
         SxCYSnv1Di+6vpdX4NZLXU5AoPfHh1b179PlPmc1QQr6tQKLXNasWx2y8Hxeokh3WpEM
         kI3C3A5Qo1f1SBJU4+fX0fRnBNis+AF++0F+TIXmzFLdis0JJfixcWKXqH9iH2OIDDD/
         nv18k/pjxFGoXS1VDnMNhGYPPDrBO0jixaC4pU3EdprWNH9aOcUD/PMpYYsgjaG4MpWo
         UVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZRENqqB1Cr05lFyho5k6QBIbX3AIqDSaA42cqBx5AI=;
        b=poL30Dt8wpWulM3EtA6Ewzt3alFEIv+iNxDC7mIINqJVvC0PWx+FOnB6L6OSv/yinH
         5yJJ/MnCoppu0A7SYqzUdriSFFTS4A4zRzAhvwSJtwkh+wSlL0Hj8Rg15cBjinIr6r45
         FeYSY6sUsQLF6zPFQav8CL+dqF3jS3Z5t5qmAk7T14qv2G00cS5LPKjRi5DNQvQ1IpkM
         uhl47txMxn4xowJ9cR0atf9+us7A5fpaobBCuIp0d2G51HVJxclfZrRRM9+uT0c+q7Hq
         d8DdIqzo6p7Yd9jUaODN+VU8jPCUKznCe8oT6+ddC35BBd3+GuuDV0oWjiR94Hm3ExXQ
         pLcw==
X-Gm-Message-State: AJcUukeRVte0OKMZxz7vUBDB0yaKJEcMh8/+kJVtQs0qCm6I5k6LJ4yz
        czVTIXsX90yfe2agePNFKqOP8lMi
X-Google-Smtp-Source: ALg8bN5Y7RvQGy81j7U4w3blPwZLmu51UpR7QiuPdXQKis1KevsUO89EUB5371qD9p2XKt/oQTZHEA==
X-Received: by 2002:adf:b502:: with SMTP id a2mr35222324wrd.54.1548168157101;
        Tue, 22 Jan 2019 06:42:37 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:36 -0800 (PST)
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
Subject: [PATCH v2 09/13] promisor-remote: parse remote.*.partialclonefilter
Date:   Tue, 22 Jan 2019 15:42:08 +0100
Message-Id: <20190122144212.15119-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
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
index d327cd9ef5..75746c50e0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1490,7 +1490,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 4e6b47b177..a70a16bf5c 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -29,6 +29,9 @@ static int gently_parse_list_objects_filter(
 {
 	const char *v0;
 
+	if (!arg)
+		return 0;
+
 	if (filter_options->choice) {
 		if (errbuf) {
 			strbuf_addstr(
@@ -127,6 +130,7 @@ void partial_clone_register(
 	const struct list_objects_filter_options *filter_options)
 {
 	char *cfg_name;
+	char *filter_name;
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
@@ -141,27 +145,26 @@ void partial_clone_register(
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
index af64e5c66f..8c10ec2d3a 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -75,6 +75,7 @@ void partial_clone_register(
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
2.20.1.322.gd6b9ae60d4

