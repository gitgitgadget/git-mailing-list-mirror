Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84FC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiETSmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353002AbiETSlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE5366AB
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i82-20020a1c3b55000000b00397391910d5so1334654wma.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0mnaBMrlkQic6XfQD31U8lZCTSsgLKKcgpz+PwKfU=;
        b=EeOLaHgClKonOGNz2boGfvZWoloekNciFDj91smy5JhaA9yprtjY336cIO8NKycc2Y
         4dWJkOAZE9Zki6GtapRBuZB5wwnMSfIRXw1dKRguUhyM40Vp+bAtrHu/woOErxMYUi0P
         B7cS7GE/EKwnu7GY2wvqLN6WKVTe2xEFJxYiqiInxb+DApMMgBd6l9B+AX/42V/Kftjz
         YrZ8RvzPkFpG+ckFpjm1VtkO/i6Er8DTj5h0Wccc0z6e312gm2KS9amGX8irESF2Rd4Y
         eIpPHyiDNtj03lXS2OymtlwvL1/VB2QLawtCj2uQD8rgznmYYk6JkEvCJREiQdCXx1lc
         RNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0mnaBMrlkQic6XfQD31U8lZCTSsgLKKcgpz+PwKfU=;
        b=zbhCpo7SQq8bmavUT7mM5KkndYfRnINRLsLNfLd2mur2s7+c13UHShZJJW3ImeLnyf
         H/pbiSC06Igv/nbknwgeZFbpai38ILjW/Az8sTYEgRpRfw2uqpjX6yhNQap/tfu+vxTD
         hL8Fr4qELR6BWK5KwrH3xc4xHxijBOXWE9MseVuCiyHa8V/23Pn3MOqWTrb4h+yLwp27
         3DynuCVZiRf8WnBh/1HECa1Pl/N67ryYWLEPkhhZcDBTQE8RNWNtChYqn9m5yEcldbv7
         7LBi/ZCSVv6yKnv7gDJfvrY2KZnyEBPBU7pRIA0/vYolnGTbqn3oYQhnQi/boRTkrLC6
         M/Ug==
X-Gm-Message-State: AOAM531N+thZSm0DyDPxdOlSzKGJ6Zr/2TErPrS/zcUvxg8mZINw/Jam
        317065Tk+XbyfdtFgRVHmOm6J82p9IM=
X-Google-Smtp-Source: ABdhPJzmx7cSN8DmCGB5V8CWdQAKvdAZ0QDwmoDj6F0gReZTz9rleU9mO3roGrf07JCNM/MgmF8cqg==
X-Received: by 2002:a05:600c:5105:b0:394:7d22:aa93 with SMTP id o5-20020a05600c510500b003947d22aa93mr9355618wms.107.1653072054334;
        Fri, 20 May 2022 11:40:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0020c5253d8bdsm3779797wro.9.2022.05.20.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:53 -0700 (PDT)
Message-Id: <f87cb15a46d2da367e5abbd5da8bcdcc9e481514.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:27 +0000
Subject: [PATCH 09/24] bundle-uri: create bundle_list struct and helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It will likely be rare where a user uses a single bundle URI and expects
that URI to point to a bundle. Instead, that URI will likely be a list
of bundles provided in some format. Alternatively, the Git server could
advertise a list of bundles.

In anticipation of these two ways of advertising multiple bundles,
create a data structure that represents such a list. This will be
populated using a common API, but for now focus on what data can be
represented.

Each list contains a number of remote_bundle_info structs. These contain
an 'id' that is used to uniquely identify them in the list, and also a
'uri' that contains the location of its data. Finally, there is a strbuf
containing the filename used when Git downloads the contents to disk.

The list itself stores these remote_bundle_info structs in a hashtable
using 'id' as the key. The order of the structs in the input is
considered unimportant, but future modifications to the format and these
data structures will place ordering possibilities on the set. The list
also has a few "global" properties, including the version (used when
parsing the list) and the mode. The mode is one of these two options:

1. BUNDLE_MODE_ALL: all listed URIs are intended to be combined
   together. The client should download all of the advertised data to
   have a complete copy of the data.

2. BUNDLE_MODE_ANY: any one listed item is sufficient to have a complete
   copy of the data. The client can choose arbitrarily from these
   options. In the future, the client may use pings to find the closest
   URI among geodistributed replicas, or use some other heuristic
   information added to the format.

This API is currently unused, but will soon be expanded with parsing
logic and then be consumed by the bundle URI download logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 0692a62071a..b9a219d3202 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -5,6 +5,67 @@
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
+#include "hashmap.h"
+#include "pkt-line.h"
+
+static int compare_bundles(const void *hashmap_cmp_fn_data,
+			   const struct hashmap_entry *he1,
+			   const struct hashmap_entry *he2,
+			   const void *id)
+{
+	const struct remote_bundle_info *e1 =
+		container_of(he1, const struct remote_bundle_info, ent);
+	const struct remote_bundle_info *e2 =
+		container_of(he2, const struct remote_bundle_info, ent);
+
+	return strcmp(e1->id, id ? (const char *)id : e2->id);
+}
+
+void init_bundle_list(struct bundle_list *list)
+{
+	memset(list, 0, sizeof(*list));
+
+	/* Implied defaults. */
+	list->mode = BUNDLE_MODE_ALL;
+	list->version = 1;
+
+	hashmap_init(&list->bundles, compare_bundles, NULL, 0);
+}
+
+static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
+				    void *data)
+{
+	free(bundle->id);
+	free(bundle->uri);
+	strbuf_release(&bundle->file);
+	return 0;
+}
+
+void clear_bundle_list(struct bundle_list *list)
+{
+	if (!list)
+		return;
+
+	for_all_bundles_in_list(list, clear_remote_bundle_info, NULL);
+	hashmap_clear_and_free(&list->bundles, struct remote_bundle_info, ent);
+}
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data)
+{
+	struct remote_bundle_info *info;
+	struct hashmap_iter i;
+
+	hashmap_for_each_entry(&list->bundles, &i, info, ent) {
+		int result = iter(info, data);
+
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
 
 static void find_temp_filename(struct strbuf *name)
 {
diff --git a/bundle-uri.h b/bundle-uri.h
index 8a152f1ef14..0f95197744c 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -1,7 +1,74 @@
 #ifndef BUNDLE_URI_H
 #define BUNDLE_URI_H
 
+#include "hashmap.h"
+#include "strbuf.h"
+
 struct repository;
+struct strbuf;
+struct string_list;
+
+/**
+ * The remote_bundle_info struct contains information for a single bundle
+ * URI. This may be initialized simply by a given URI or might have
+ * additional metadata associated with it if the bundle was advertised by
+ * a bundle list.
+ */
+struct remote_bundle_info {
+	struct hashmap_entry ent;
+
+	/**
+	 * The 'id' is a name given to the bundle for reference
+	 * by other bundle infos.
+	 */
+	char *id;
+
+	/**
+	 * The 'uri' is the location of the remote bundle so
+	 * it can be downloaded on-demand. This will be NULL
+	 * if there was no table of contents.
+	 */
+	char *uri;
+
+	/**
+	 * If the bundle has been downloaded, then 'file' is a
+	 * filename storing its contents. Otherwise, 'file' is
+	 * an empty string.
+	 */
+	struct strbuf file;
+};
+
+#define REMOTE_BUNDLE_INFO_INIT { \
+	.file = STRBUF_INIT, \
+}
+
+enum bundle_list_mode {
+	BUNDLE_MODE_NONE = 0,
+	BUNDLE_MODE_ALL,
+	BUNDLE_MODE_ANY
+};
+
+/**
+ * A bundle_list contains an unordered set of remote_bundle_info structs,
+ * as well as information about the bundle listing, such as version and
+ * mode.
+ */
+struct bundle_list {
+	int version;
+	enum bundle_list_mode mode;
+	unsigned forFetch : 1;
+	struct hashmap bundles;
+};
+
+void init_bundle_list(struct bundle_list *list);
+void clear_bundle_list(struct bundle_list *list);
+
+typedef int (*bundle_iterator)(struct remote_bundle_info *bundle,
+			       void *data);
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data);
 
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
-- 
gitgitgadget

