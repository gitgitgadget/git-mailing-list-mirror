Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DEC61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjAFUg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbjAFUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076DDEFA
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs20so2367202wrb.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUUwq9dFOGqeBx/fgreovJsiUA+ilrJu9BTyknsKnfw=;
        b=cfIuBY1lnAkvvbL7F6OGZ2coWfvtHMGA47JE6yqrLX2ZSwKpDjytMNDklly1u607Zo
         PJ7YyawWSRPZ0z6NJ1O9sfUWS2KRLr3j6iGVJ6h7+wMThE+VPEsWN9V9nAeuelRdn1BY
         WjwezFVYVZeu5lLoNtNBXUq2WXQuP7oQZrzLFzQdZ1v7YcQuXY2yAxXLAWVYQgx4+9v7
         P0tTeDBqPTWfcvvyC+lxRbEMNY1v5pa2vlaVh/EO+WmvT19wlPELoJVUtUTV2BiU8WFv
         EonLuJy41TzURzkfUEzhVddFmXL1YAyW4wj18a9UPLVRsnahtPb3wqt28kVz+aX2resD
         mtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUUwq9dFOGqeBx/fgreovJsiUA+ilrJu9BTyknsKnfw=;
        b=JkzyetDIX6kMMPxZ+pbhg0C1w7m31s0zDIke5QoybU0OQ3Nqt26pLtyzKXWqOeofgs
         /ievf4ykvRUu46Q742DUmYNkfvvn71+2TxGud9BDf/mqYS4SImA7lp6AeCwopVJdspn8
         b2nBMEobd2Dls/QSLCcA1rWSZNpb58VWTw5bdeJjTRh/Q2d6xbsxqB9ZQlAeg+ZLevLI
         LNLqhPU4/OZfBMkk/+cUjyJMbhjpaBkbVFZkTdg+hn24fICRxSFLk+blAE2UB7Xluo1Y
         zWGkdanj8Jv01QX/7K5qcfPRLwqbaAADT66mK/ZmnXfHZiD3iCL/5gV566pNx3qVvqTj
         u5YQ==
X-Gm-Message-State: AFqh2kpJZ18RCW7Cuw02JUsFxLhs94VNGUibsgjauuTTsXw7qq8Yns2R
        UVxpiSQkYClcygJZgJvkW8UbMxkK9cM=
X-Google-Smtp-Source: AMrXdXskaiP7PUudo1CCGl+c3+QhLBNiPkjkclMRfU4IeJhGNCnjA7vsFS59XRsyESlD83kXSQWSsQ==
X-Received: by 2002:a5d:51c9:0:b0:29c:73e2:68f1 with SMTP id n9-20020a5d51c9000000b0029c73e268f1mr10793474wrv.54.1673037408807;
        Fri, 06 Jan 2023 12:36:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0024228b0b932sm2479307wro.27.2023.01.06.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:48 -0800 (PST)
Message-Id: <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:39 +0000
Subject: [PATCH 2/8] bundle-uri: parse bundle.heuristic=creationToken
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The bundle.heuristic value communicates that the bundle list is
organized to make use of the bundle.<id>.creationToken values that may
be provided in the bundle list. Those values will create a total order
on the bundles, allowing the Git client to download them in a specific
order and even remember previously-downloaded bundles by storing the
maximum creation token value.

Before implementing any logic that parses or uses the
bundle.<id>.creationToken values, teach Git to parse the
bundle.heuristic value from a bundle list. We can use 'test-tool
bundle-uri' to print the heuristic value and verify that the parsing
works correctly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/bundle.txt |  7 +++++++
 bundle-uri.c                    | 21 +++++++++++++++++++++
 bundle-uri.h                    | 14 ++++++++++++++
 t/t5750-bundle-uri-parse.sh     | 19 +++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
index daa21eb674a..3faae386853 100644
--- a/Documentation/config/bundle.txt
+++ b/Documentation/config/bundle.txt
@@ -15,6 +15,13 @@ bundle.mode::
 	complete understanding of the bundled information (`all`) or if any one
 	of the listed bundle URIs is sufficient (`any`).
 
+bundle.heuristic::
+	If this string-valued key exists, then the bundle list is designed to
+	work well with incremental `git fetch` commands. The heuristic signals
+	that there are additional keys available for each bundle that help
+	determine which subset of bundles the client should download. The
+	only value currently understood is `creationToken`.
+
 bundle.<id>.*::
 	The `bundle.<id>.*` keys are used to describe a single item in the
 	bundle list, grouped under `<id>` for identification purposes.
diff --git a/bundle-uri.c b/bundle-uri.c
index 36268dda172..56c94595c2a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -9,6 +9,11 @@
 #include "config.h"
 #include "remote.h"
 
+static const char *heuristics[] = {
+	[BUNDLE_HEURISTIC_NONE] = "",
+	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
+};
+
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
 			   const struct hashmap_entry *he2,
@@ -100,6 +105,9 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 	fprintf(fp, "\tversion = %d\n", list->version);
 	fprintf(fp, "\tmode = %s\n", mode);
 
+	if (list->heuristic)
+		printf("\theuristic = %s\n", heuristics[list->heuristic]);
+
 	for_all_bundles_in_list(list, summarize_bundle, fp);
 }
 
@@ -142,6 +150,19 @@ static int bundle_list_update(const char *key, const char *value,
 			return 0;
 		}
 
+		if (!strcmp(subkey, "heuristic")) {
+			int i;
+			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
+				if (!strcmp(value, heuristics[i])) {
+					list->heuristic = i;
+					return 0;
+				}
+			}
+
+			/* Ignore unknown heuristics. */
+			return 0;
+		}
+
 		/* Ignore other unknown global keys. */
 		return 0;
 	}
diff --git a/bundle-uri.h b/bundle-uri.h
index d5e89f1671c..ad82174112d 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -52,6 +52,14 @@ enum bundle_list_mode {
 	BUNDLE_MODE_ANY
 };
 
+enum bundle_list_heuristic {
+	BUNDLE_HEURISTIC_NONE = 0,
+	BUNDLE_HEURISTIC_CREATIONTOKEN,
+
+	/* Must be last. */
+	BUNDLE_HEURISTIC__COUNT,
+};
+
 /**
  * A bundle_list contains an unordered set of remote_bundle_info structs,
  * as well as information about the bundle listing, such as version and
@@ -75,6 +83,12 @@ struct bundle_list {
 	 * advertised by the bundle list at that location.
 	 */
 	char *baseURI;
+
+	/**
+	 * A list can have a heuristic, which helps reduce the number of
+	 * downloaded bundles.
+	 */
+	enum bundle_list_heuristic heuristic;
 };
 
 void init_bundle_list(struct bundle_list *list);
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 7b4f930e532..6fc92a9c0d4 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -250,4 +250,23 @@ test_expect_success 'parse config format edge cases: empty key or value' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: creationToken heuristic' '
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+	[bundle "two"]
+		uri = https://example.com/bundle.bdl
+	[bundle "three"]
+		uri = file:///usr/share/git/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-config expect >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
 test_done
-- 
gitgitgadget

