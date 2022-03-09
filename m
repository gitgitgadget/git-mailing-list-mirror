Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiCIQDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiCIQC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D02172E77
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so3741375wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x21zZXWoDS7htTo9KeOXoy/R1/9D5U1HzpQi0NNkuy0=;
        b=Mpzt3WoJWZ56waP/u8sy+QST7ZkSzMldE2tcwG6nGtdVdTHRVKh41vPsE1v3TzfzMm
         6Gmj5395HNKAtqB3TWuutd2VepBrh9Rs+3hpNLKMpHqkqsz2kCZBIYjADkCh881DY6T3
         N21iGY97XtiCeiMAUaT2zA1Q1j77y+EiuhiQ633MrmxFcdot/PkPGlZAQ1E85to/V2Vq
         9pULxi4zpY0LVWjVdpV1c/Yb9ZxbA13hfgbU1yRCJjulyauUqYt0sPgoiBXtIN0g7pRT
         Y6/YxlmKU6hilx0t7MFa67eyAdBxYWIcPYmBT3KEgh7oqmGpHkmKUUuqPLPWERQlrmy2
         iiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x21zZXWoDS7htTo9KeOXoy/R1/9D5U1HzpQi0NNkuy0=;
        b=ZtL4dizN3IVqZEkcs7F9Mdv7i6WP8xuujX9e7IcXznSc4uhh+mSsVauFZ+8nqbDWus
         /IbIhcsBbxNRQ9L7/qDg1chPuquQfQTZ3wq5KoSfW7NpvtzN50EFuIXUEo+ATRw5B1Z1
         GKQMMBzQmDS1/aK51kWlBp+QOR9obZNt96x3SetvrQDTjnpq7z1bv1GaT/ilEUtFJfeq
         O8kuBvfmOZfhDzsfNRJsrODpNSapDOwdkO9u9eATUj94QVmF3IGuUkoNCqP/mFOAPHDQ
         goIPkte5iMM/C1YmAnEvlVlnY1JGTFqobQtS9+qGlTkGUXXDJnzsP4LGE5rjsckHOYKQ
         SbUQ==
X-Gm-Message-State: AOAM532dc3dwZ+59dGmqCFL5FQOwVrwnhNEqNu8tRciYvi7TC2k5a93w
        EMV6j8QIceFRr3tjNMAWxL6Rev6O1P4=
X-Google-Smtp-Source: ABdhPJx3Oh/UU4YbXCUX8cqLblKRHY/dWZKczwylbh4hR+2xJtmkoX3UNiIFaQsTP+m794zP7vbdLw==
X-Received: by 2002:adf:f947:0:b0:1ef:9b55:7cba with SMTP id q7-20020adff947000000b001ef9b557cbamr261711wrr.142.1646841715732;
        Wed, 09 Mar 2022 08:01:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm2369863wml.29.2022.03.09.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:55 -0800 (PST)
Message-Id: <faf7a38b0e595e6fdb89b62563dcff855466c796.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:39 +0000
Subject: [PATCH v4 09/13] bundle: parse filter capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The v3 bundle format has capabilities, allowing newer versions of Git to
create bundles with newer features. Older versions that do not
understand these new capabilities will fail with a helpful warning.

Create a new capability allowing Git to understand that the contained
pack-file is filtered according to some object filter. Typically, this
filter will be "blob:none" for a blobless partial clone.

This change teaches Git to parse this capability, place its value in the
bundle header, and demonstrate this understanding by adding a message to
'git bundle verify'.

Since we will use gently_parse_list_objects_filter() outside of
list-objects-filter-options.c, make it an external method and move its
API documentation to before its declaration.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-bundle.txt              |  7 +++++--
 Documentation/technical/bundle-format.txt | 11 ++++++++---
 bundle.c                                  | 15 ++++++++++++++-
 bundle.h                                  |  2 ++
 list-objects-filter-options.c             | 17 +----------------
 list-objects-filter-options.h             | 20 ++++++++++++++++++++
 6 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 72ab8139052..ac4c4352aae 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -75,8 +75,11 @@ verify <file>::
 	cleanly to the current repository.  This includes checks on the
 	bundle format itself as well as checking that the prerequisite
 	commits exist and are fully linked in the current repository.
-	'git bundle' prints a list of missing commits, if any, and exits
-	with a non-zero status.
+	Information about additional capabilities, such as "object filter",
+	is printed. See "Capabilities" in link:technical/bundle-format.html
+	for more information. Finally, 'git bundle' prints a list of
+	missing commits, if any. The exit code is zero for success, but
+	will be nonzero if the bundle file is invalid.
 
 list-heads <file>::
 	Lists the references defined in the bundle.  If followed by a
diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
index bac558d049a..b9be8644cf5 100644
--- a/Documentation/technical/bundle-format.txt
+++ b/Documentation/technical/bundle-format.txt
@@ -71,6 +71,11 @@ and the Git bundle v2 format cannot represent a shallow clone repository.
 == Capabilities
 
 Because there is no opportunity for negotiation, unknown capabilities cause 'git
-bundle' to abort.  The only known capability is `object-format`, which specifies
-the hash algorithm in use, and can take the same values as the
-`extensions.objectFormat` configuration value.
+bundle' to abort.
+
+* `object-format` specifies the hash algorithm in use, and can take the same
+  values as the `extensions.objectFormat` configuration value.
+
+* `filter` specifies an object filter as in the `--filter` option in
+  linkgit:git-rev-list[1]. The resulting pack-file must be marked as a
+  `.promisor` pack-file after it is unbundled.
diff --git a/bundle.c b/bundle.c
index 7ba60a573d7..41e75efab9a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -11,7 +11,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "strvec.h"
-
+#include "list-objects-filter-options.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -33,6 +33,7 @@ void bundle_header_release(struct bundle_header *header)
 {
 	string_list_clear(&header->prerequisites, 1);
 	string_list_clear(&header->references, 1);
+	list_objects_filter_release(&header->filter);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -45,6 +46,10 @@ static int parse_capability(struct bundle_header *header, const char *capability
 		header->hash_algo = &hash_algos[algo];
 		return 0;
 	}
+	if (skip_prefix(capability, "filter=", &arg)) {
+		parse_list_objects_filter(&header->filter, arg);
+		return 0;
+	}
 	return error(_("unknown capability '%s'"), capability);
 }
 
@@ -220,6 +225,8 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
+	list_objects_filter_copy(&revs.filter, &header->filter);
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
@@ -259,6 +266,12 @@ int verify_bundle(struct repository *r,
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
+
+		if (header->filter.choice) {
+			printf_ln("The bundle uses this filter: %s",
+				  list_objects_filter_spec(&header->filter));
+		}
+
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
diff --git a/bundle.h b/bundle.h
index 06009fe6b1f..7fef2108f43 100644
--- a/bundle.h
+++ b/bundle.h
@@ -4,12 +4,14 @@
 #include "strvec.h"
 #include "cache.h"
 #include "string-list.h"
+#include "list-objects-filter-options.h"
 
 struct bundle_header {
 	unsigned version;
 	struct string_list prerequisites;
 	struct string_list references;
 	const struct git_hash_algo *hash_algo;
+	struct list_objects_filter_options filter;
 };
 
 #define BUNDLE_HEADER_INIT \
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 449d53af69f..f02d8df1422 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -40,22 +40,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 	BUG("list_object_filter_config_name: invalid argument '%d'", c);
 }
 
-/*
- * Parse value of the argument to the "filter" keyword.
- * On the command line this looks like:
- *       --filter=<arg>
- * and in the pack protocol as:
- *       "filter" SP <arg>
- *
- * The filter keyword will be used by many commands.
- * See Documentation/rev-list-options.txt for allowed values for <arg>.
- *
- * Capture the given arg as the "filter_spec".  This can be forwarded to
- * subordinate commands when necessary (although it's better to pass it through
- * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
- * convenience of the current command.
- */
-static int gently_parse_list_objects_filter(
+int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 425c38cae9d..2eb6c983949 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -72,6 +72,26 @@ struct list_objects_filter_options {
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
+/*
+ * Parse value of the argument to the "filter" keyword.
+ * On the command line this looks like:
+ *       --filter=<arg>
+ * and in the pack protocol as:
+ *       "filter" SP <arg>
+ *
+ * The filter keyword will be used by many commands.
+ * See Documentation/rev-list-options.txt for allowed values for <arg>.
+ *
+ * Capture the given arg as the "filter_spec".  This can be forwarded to
+ * subordinate commands when necessary (although it's better to pass it through
+ * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
+ * convenience of the current command.
+ */
+int gently_parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
+
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
 
-- 
gitgitgadget

