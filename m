Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA9620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeLKF2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32816 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbeLKF2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so12755163wrr.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JopPhLuZtJC25WBpernMBJypqfqVE5+GOpbILRKKbwQ=;
        b=lcwpDEm661QerXRAGPi5RTKEI64ab7IsjnMsxxaGs2Y3BfUEEHtmbX4XSb1Jdjajua
         hnCAT4xqQFbO4uqvX4AGoC8q0qncUsvjRHUo8UfbT3U/lwUG+nX0HHfhjrV8yosXjyBk
         Fh+L4JWa7QbzlaBrAbmoKcZFLZasGyFFIqT4rF0TM3lQDt16pZEUA1ygkVL2H+gXzV4J
         8pV6rdJebj6JRQASLvFjew58n6yEEYtZlCBZkjH2E6uElu5aBunZAbXbPdrlVYRvGE07
         PDYqNyLqt+Zjf4NEBcPQLYfPTeFqO5DEzFnSgBr5Walftobu9QzpA2jMQ1N9iHImdwH4
         wrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JopPhLuZtJC25WBpernMBJypqfqVE5+GOpbILRKKbwQ=;
        b=JOuzkNf61jhiey5BLy14zgXDsmt/FXaBSPsmd6/TUOv8thIu0/T73uXUCpqDQWFMF+
         aMgVYxBi0imTOrHktP03K8pPzW17E0+0xys/VVAtWFVEPlFD9TTG9KGXq2/ZhDzj+Zjn
         H3mG27ljZ9IwyiSazu2hWjvXK7229BzgKL1tw94xlEDjPdQLIPXIwTAoj71CRUOJWyKt
         OnSbQ3PLE/nRqCsF8qT5uA0haeEiHGHd6zhHAngKRqi5Y2UCYn8M2vEiRkc+atHKlZ+B
         GEiBoLdGWgtB2e9tbLZk9WM5UeqipLm8Qgh4bGsn/HVO3+JBoMCG8zPeOLut0peSeVVb
         Q5bQ==
X-Gm-Message-State: AA+aEWYGjbYd8wSRPpW3Ju/YUfs/5+9Kq/nDLSgblgRgG8q8Piujah4p
        OCdr8y0BD0AavO2uYovjRagBnQoi
X-Google-Smtp-Source: AFSGD/UlctMuDJ9UWi402JWWkp7c6OcoQVugT+Ysv9haJrugDdB15lVBZmMrynWgaqZyQP6r9mmxdw==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr11773786wrs.268.1544506094829;
        Mon, 10 Dec 2018 21:28:14 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:14 -0800 (PST)
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
Subject: [PATCH v1 7/8] promisor-remote: parse remote.*.partialclonefilter
Date:   Tue, 11 Dec 2018 06:27:45 +0100
Message-Id: <20181211052746.16218-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
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
 promisor-remote.c             | 13 +++++++++++--
 promisor-remote.h             |  5 ++++-
 t/t0410-partial-clone.sh      |  2 +-
 t/t5601-clone.sh              |  1 +
 t/t5616-partial-clone.sh      |  2 +-
 8 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 647a60b26c..53494c5864 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1489,7 +1489,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * the config.
 	 */
 	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options);
+		partial_clone_get_default_filter_spec(&filter_options, remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 3b5ff55480..ea0148f709 100644
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
 	if (!find_promisor_remote(remote)) {
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
+	struct promisor_remote *promisor = find_promisor_remote(remote);
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
index e4a0625426..d1bd9fbf49 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -60,6 +60,16 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		free(remote_name);
 		return 0;
 	}
+	if (!strcmp(subkey, "partialclonefilter")) {
+		char *remote_name = xmemdupz(name, namelen);
+
+		o = do_find_promisor_remote(remote_name);
+		if (!o)
+			o = promisor_remote_new(remote_name);
+
+		free(remote_name);
+		return git_config_string(&o->partial_clone_filter, var, value);
+	}
 
 	return 0;
 }
@@ -76,8 +86,7 @@ static void promisor_remote_do_init(int force)
 
 	if (repository_format_partial_clone &&
 	    !do_find_promisor_remote(repository_format_partial_clone))
-		promisor_remote_new(repository_format_partial_clone,
-				    strlen(repository_format_partial_clone));
+		promisor_remote_new(repository_format_partial_clone);
 }
 
 static inline void promisor_remote_init(void)
diff --git a/promisor-remote.h b/promisor-remote.h
index 873ddfb5ed..431edafcdd 100644
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
index ba3887f178..462229e445 100755
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
index aafe55b8b7..72a04669e4 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -654,6 +654,7 @@ partial_clone () {
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
 	test_config -C client remote.origin.promisor "false" &&
+	git -C client config --unset remote.origin.partialclonefilter &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index d09dee1f14..9057ad25d3 100755
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
2.20.0.rc2.14.g1379de12fa.dirty

