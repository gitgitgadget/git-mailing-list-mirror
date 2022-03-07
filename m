Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722AC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiCGVwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C975C20
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u10so23833227wra.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pG883uuRxGScAGZLkzkCwsxEbvbsGhxKaXCIEY7WmT0=;
        b=Hla3zQIPkJa3RUiQjavN7Rml/zTiTsXFx+9Aof+soN6njpFbR0SPWeeHU5Uvvg0Xt+
         AAv/i/qryDbPHc1gLksRLBt3aB4w6mn6tMGLduQ+sXnFVdpSMMaS+Ay72aR42srbYK/k
         dgV3kjEQ70fL9RNXkP04CYrDf/CNk9O11HX/dxfesrMZUHzljk9has9VRTil1TFf8Mn3
         22ShDsBAIE/Ps0u/hlt8mtGTF4ebOPYmW3Fvyf61aiQqGutbx+o5tXONfi3XK0Y0jYQE
         GaGZzY4d0eF6YFS9S53AuUyY0XQ0S1srxZMyJRohtX866tpBWMe1f0Y+Q07kCHLeJxTA
         KN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pG883uuRxGScAGZLkzkCwsxEbvbsGhxKaXCIEY7WmT0=;
        b=BgDQJ2rtBT5uGdf04umZioXsiSQ3vgGoP5J9Qo/8dRY5zPSB6mPhKiKjGt2tzQBl33
         PKvrBI6Bzmk1yoa34NUweTZZc6necwMCExndwt91D5npzr35DQtDOfkUhW3vmYXFHMPI
         W55vJecUP68HyS58e9s1bcNn1eUkmUuB+mfOhyAruRIgkA8AGr08fcLWpMd9SArFJx+u
         /TEFw2+f6VOq5WbDZm3Nc3V1+0Z4b0GEQcn4Che0xS/n1wZvN0Q+b2vQTVhFTAfx/IGZ
         +Xjr0aiLWcljXipjTAZC5dgSaAtrsHcsMT8YE9msWvVgVQpSWz8NGIeIhai1kFmiN11A
         DDOw==
X-Gm-Message-State: AOAM530AXDrb46cr1/ATgB7kC3coEVkMmB34GHv6BN73uICiud48Huqb
        2wrG+e1sypHzE/CCcCSD3AYzh8GEnvY=
X-Google-Smtp-Source: ABdhPJyH5nxgtpKz8jDuUrRF5ipdLSZjVhRBbeK5Tb70vrrXU5b9JNFcYzYvd1rD1WjWU9G60DOnJA==
X-Received: by 2002:adf:f6d0:0:b0:1f0:7ab4:f905 with SMTP id y16-20020adff6d0000000b001f07ab4f905mr9863259wrp.54.1646689849378;
        Mon, 07 Mar 2022 13:50:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6a03000000b001f06621641fsm10216611wru.96.2022.03.07.13.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:48 -0800 (PST)
Message-Id: <898a7d945131042c48f8e99acccf26378a4c8586.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:36 +0000
Subject: [PATCH v2 08/12] bundle: parse filter capability
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
 Documentation/technical/bundle-format.txt | 11 ++++++++---
 bundle.c                                  | 17 ++++++++++++++++-
 bundle.h                                  |  3 +++
 list-objects-filter-options.c             | 17 +----------------
 list-objects-filter-options.h             | 20 ++++++++++++++++++++
 5 files changed, 48 insertions(+), 20 deletions(-)

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
index dc56db9a50a..2afced4d991 100644
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
@@ -33,6 +33,8 @@ void bundle_header_release(struct bundle_header *header)
 {
 	string_list_clear(&header->prerequisites, 1);
 	string_list_clear(&header->references, 1);
+	list_objects_filter_release(header->filter);
+	free(header->filter);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
 		header->hash_algo = &hash_algos[algo];
 		return 0;
 	}
+	if (skip_prefix(capability, "filter=", &arg)) {
+		CALLOC_ARRAY(header->filter, 1);
+		parse_list_objects_filter(header->filter, arg);
+		return 0;
+	}
 	return error(_("unknown capability '%s'"), capability);
 }
 
@@ -220,6 +227,8 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
+	revs.filter = header->filter;
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
@@ -259,6 +268,12 @@ int verify_bundle(struct repository *r,
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
+
+		if (header->filter) {
+			printf_ln("The bundle uses this filter: %s",
+				  list_objects_filter_spec(header->filter));
+		}
+
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
diff --git a/bundle.h b/bundle.h
index 06009fe6b1f..eb026153d56 100644
--- a/bundle.h
+++ b/bundle.h
@@ -5,11 +5,14 @@
 #include "cache.h"
 #include "string-list.h"
 
+struct list_objects_filter_options;
+
 struct bundle_header {
 	unsigned version;
 	struct string_list prerequisites;
 	struct string_list references;
 	const struct git_hash_algo *hash_algo;
+	struct list_objects_filter_options *filter;
 };
 
 #define BUNDLE_HEADER_INIT \
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..d8597cdee36 100644
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
index da5b6737e27..f6fe6a3d2ca 100644
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

