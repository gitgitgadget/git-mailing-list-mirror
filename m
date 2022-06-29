Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A5C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiF2UlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiF2Uk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005A21E23
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so18533693wrc.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c3daSgqhZyWRm/HpwCJdfSqisVFlHMT0FBs106uF7NU=;
        b=J/xmwAkUudcJzJdnyjwxg3GSLtJJv/WacLnmTDPiVnc7pfTBsCm/YTEG6YIPcf+tO2
         RHSvlPkU4F5tnZ+rAEIUKZXm0LAVwMdtkzWn06ErxPMTO6wyY6SVa8YqBmwk7dxFeQtA
         Q3Hb0R5o4H3FWf+xbFf7BZdwBRvdYdvWSWJO2yfJTq16PF6qs/qruStEc0NoVvrvJMzS
         89S65/4H3AC8RE9v5ICwj2lJTnoZJGWUSahxRwoLsC8UlPxoOsigI14kAOaEYkLaBSg/
         L1Uyjl43zu/GdM7S1ionSMnojM6o/LxNx5J6BKL8tR4f1W/zEZITN895QzRo+gNO0i9o
         kvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c3daSgqhZyWRm/HpwCJdfSqisVFlHMT0FBs106uF7NU=;
        b=2wGPKsaCSOmSdUDSokZ/pPPGDuIcGHw2yfNg0uZMUObGL2yrBuiGnurkXtiYo6FsnT
         u4qvRFY89csvvU4H5w/4sMUXxA0yU6D7E6Ss2Msza0pCkM54x+w4uZlOhNCwTgRko0Sq
         cVxi3I1Ua/F9d7jpzK8nMObC8OFFuyltsUrL/LDBT2MnEHHhJqddHOU5C7CrtF2xdHRp
         gDn/YG2UhPPbWB0KsWXBFh6aXvw0RANKOMgZ1+Zd//8/Q/mzOgzNuC9lRjkbxQmE+yrv
         xjT4RZbu0GhUGgan1+uL1kAwb7a91tZXdoAHUqMk72/RqONdQyxRLpqZl9SyLyB+6Esa
         U5CQ==
X-Gm-Message-State: AJIora8bNppgzXOL6tEg4Dn5QmQHFwUWbmK/qP7OWt6c5Nj67KDqtB7R
        Ez4419vb3R/ticSHLjiNBzN1T7MRSPK6ww==
X-Google-Smtp-Source: AGRyM1uJK65D+XBgwlxBWnwvRdTE+LxzcdDSWM9NgkXIhBlnxilv+4SXH9Yn9bUDObFiCk6WWCP61g==
X-Received: by 2002:adf:dd05:0:b0:21d:ea5:7125 with SMTP id a5-20020adfdd05000000b0021d0ea57125mr5002837wrm.298.1656535254144;
        Wed, 29 Jun 2022 13:40:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003a047f64496sm4299905wme.7.2022.06.29.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:53 -0700 (PDT)
Message-Id: <a217e9a0640b45d21ef971d6e91cee3f1993f383.1656535245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:45 +0000
Subject: [PATCH v2 6/6] fetch: add 'refs/bundle/' to log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When fetching from a bundle URI, the branches of that bundle are stored
in a different ref namespace: refs/bundles/. This namespace is intended
to assist with later 'git fetch' negotiations with a Git server,
allowing the client to advertise which data it already has from a bundle
URI.

These references can be confusing for a user when they appear as a
decoration in 'git log' output. Add "refs/bundles/" to the multi-valued
log.excludeDecoration config value. This is similar to the way
"refs/prefetch/" is hidden by background prefetch operations in 'git
maintenance' as added by 96eaffebb (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/fetch-options.txt |  3 ++-
 bundle-uri.c                    |  7 +++++++
 t/t5558-fetch-bundle-uri.sh     | 12 +++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 09bd1feeed8..8b801bcc2f3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -321,4 +321,5 @@ endif::git-pull[]
 --bundle-uri=<uri>::
 	Instead of fetching from a remote, fetch a bundle from the given
 	`<uri>` and unbundle the data into the local repository. The refs
-	in the bundle will be stored under the `refs/bundle/*` namespace.
+	in the bundle will be stored under the hidden `refs/bundle/*`
+	namespace.
diff --git a/bundle-uri.c b/bundle-uri.c
index 4c793843a2a..6e0f1cb06fd 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "bundle-uri.h"
 #include "bundle.h"
+#include "config.h"
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
@@ -153,6 +154,12 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
 	if ((result = unbundle_from_file(r, filename.buf)))
 		goto cleanup;
 
+	git_config_set_multivar_gently("log.excludedecoration",
+					"refs/bundle/",
+					"refs/bundle/",
+					CONFIG_FLAGS_FIXED_VALUE |
+					CONFIG_FLAGS_MULTI_REPLACE);
+
 cleanup:
 	unlink(filename.buf);
 	strbuf_release(&filename);
diff --git a/t/t5558-fetch-bundle-uri.sh b/t/t5558-fetch-bundle-uri.sh
index 919db6f4551..bed4cc3e99c 100755
--- a/t/t5558-fetch-bundle-uri.sh
+++ b/t/t5558-fetch-bundle-uri.sh
@@ -28,7 +28,9 @@ test_expect_success 'fetch file bundle' '
 	git -C fetch-to fetch --bundle-uri="$(pwd)/fetch-from/B.bundle" &&
 	git -C fetch-to rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config -C fetch-to log.excludedecoration refs/bundle/
 '
 
 test_expect_success 'fetch file:// bundle' '
@@ -36,7 +38,9 @@ test_expect_success 'fetch file:// bundle' '
 	git -C fetch-file fetch --bundle-uri="file://$(pwd)/fetch-from/B.bundle" &&
 	git -C fetch-file rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config -C fetch-file log.excludedecoration refs/bundle/
 '
 
 #########################################################################
@@ -62,7 +66,9 @@ test_expect_success 'fetch HTTP bundle' '
 	git -C fetch-http fetch --bundle-uri="$HTTPD_URL/B.bundle" &&
 	git -C fetch-http rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config log.excludedecoration refs/bundle/
 '
 
 # Do not add tests here unless they use the HTTP server, as they will
-- 
gitgitgadget
