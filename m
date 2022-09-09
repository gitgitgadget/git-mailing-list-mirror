Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C504ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIIOdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiIIOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE870E4B
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b17so3084693wrq.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=XPliiiedpipNoHfTWL4Hk4yzxWT7G5AlKCKO0ykXu+w=;
        b=S2HU3fCf7nikLGK7RU6JqovgDWNksAaMjw4AyHgrQgqHcoJ8b6caM77Z1u04JQI57o
         TFy9fNAtJY8sGkYMotu4DlPglH3hzpSRbp0zEX6mmgdQQgDhGOU+Yn4VrelSnk4DdYE3
         MWwOV8DSzn9you27+Rvhl1OmZ16bhilC2K+NERpUrtmg+F5QSS6m1Zbc0SYB1FNFpdNs
         +/iAtS3RnWHPtQ3JjJuMVZJHWMj+tsMgmjF/a0aSTO/za/3PRAi4+ZayY++bwOkmYAee
         gJuvD2xOq6ewi4nATl735A2u/bhyQM1Wy6Ctv9vjuTULbxjkJnOD5v3BhJwIwKuD9nEJ
         EPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XPliiiedpipNoHfTWL4Hk4yzxWT7G5AlKCKO0ykXu+w=;
        b=6KvnwyIVikEkYN0/2yL4qnB02wRJdA2X47R953s/Phk7yI5nHprBu3v1WtMrM+Yc+f
         GMvJHhuG4aQV0g0Y+Fk63M/owp8QpeXlhBhq9aTGL+QdUka2B5l2nKHplia4IOl5kfY8
         Yd9sCx5cQ71EPfazGa3ZEoROY+N+p6gsxFXolkOyKvGc3g75eRJbborxhta/d1BB3j/F
         JiakfGknXuJilRY6te3zHH1t6dVZP9TeBEwKJSxGsxbMrGVH/HqPy5AQauqhIu1pxGL+
         HC4CVF/6z4GCRTLvt1egBlp+Ha3ivaMXi7lir9on2EOaJGMmQISnIbr3g8zrvsE+eEkW
         Eabw==
X-Gm-Message-State: ACgBeo2FrMpQ+F8CBtdgUA56Xzfn9Todxu8CbNDHoWhM6hLrZ67U9jtt
        86N7DlF3X96tKDj18tke3kQX1KDPXzw=
X-Google-Smtp-Source: AA6agR49ZyDHq2SnnlbsFuQzZq2Do/ZdE2Gmg/5PdM46zvR7CpbbTVMudrhRoKuSiqQ1GsJAbqXPhQ==
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr8551948wrb.54.1662734023080;
        Fri, 09 Sep 2022 07:33:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk12-20020a0560001d8c00b0022762b0e2a2sm711000wrb.6.2022.09.09.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:42 -0700 (PDT)
Message-Id: <70daef66833744fb8b870f431af8201222c7a2ba.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:30 +0000
Subject: [PATCH v2 4/9] bundle-uri: create base key-value pair parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

There will be two primary ways to advertise a bundle list: as a list of
packet lines in Git's protocol v2 and as a config file served from a
bundle URI. Both of these fundamentally use a list of key-value pairs.
We will use the same set of key-value pairs across these formats.

Create a new bundle_list_update() method that is currently unusued, but
will be used in the next change. It inspects each key to see if it is
understood and then applies it to the given bundle_list. Here are the
keys that we teach Git to understand:

* bundle.version: This value should be an integer. Git currently
  understands only version 1 and will ignore the list if the version is
  any other value. This version can be increased in the future if we
  need to add new keys that Git should not ignore. We can add new
  "heuristic" keys without incrementing the version.

* bundle.mode: This value should be one of "all" or "any". If this
  mode is not understood, then Git will ignore the list. This mode
  indicates whether Git needs all of the bundle list items to make a
  complete view of the content or if any single item is sufficient.

The rest of the keys use a bundle identifier "<id>" as part of the key
name. Keys using the same "<id>" describe a single bundle list item.

* bundle.<id>.uri: This stores the URI of the bundle item. This
  currently is expected to be an absolute URI, but will be relaxed to be
  a relative URI in the future.

While parsing, return an error if a URI key is repeated, since we can
make that restriction with bundle lists.

Make the git_parse_int() method global so we can parse the integer
version value carefully.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config.txt        |  2 +
 Documentation/config/bundle.txt | 24 +++++++++++
 bundle-uri.c                    | 76 +++++++++++++++++++++++++++++++++
 config.c                        |  2 +-
 config.h                        |  1 +
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/bundle.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..4280af6992e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,6 +387,8 @@ include::config/branch.txt[]
 
 include::config/browser.txt[]
 
+include::config/bundle.txt[]
+
 include::config/checkout.txt[]
 
 include::config/clean.txt[]
diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
new file mode 100644
index 00000000000..daa21eb674a
--- /dev/null
+++ b/Documentation/config/bundle.txt
@@ -0,0 +1,24 @@
+bundle.*::
+	The `bundle.*` keys may appear in a bundle list file found via the
+	`git clone --bundle-uri` option. These keys currently have no effect
+	if placed in a repository config file, though this will change in the
+	future. See link:technical/bundle-uri.html[the bundle URI design
+	document] for more details.
+
+bundle.version::
+	This integer value advertises the version of the bundle list format
+	used by the bundle list. Currently, the only accepted value is `1`.
+
+bundle.mode::
+	This string value should be either `all` or `any`. This value describes
+	whether all of the advertised bundles are required to unbundle a
+	complete understanding of the bundled information (`all`) or if any one
+	of the listed bundle URIs is sufficient (`any`).
+
+bundle.<id>.*::
+	The `bundle.<id>.*` keys are used to describe a single item in the
+	bundle list, grouped under `<id>` for identification purposes.
+
+bundle.<id>.uri::
+	This string value defines the URI by which Git can reach the contents
+	of this `<id>`. This URI may be a bundle file or another bundle list.
diff --git a/bundle-uri.c b/bundle-uri.c
index 7a0bada6eda..4ccd14c8936 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
+#include "config.h"
 
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
@@ -65,6 +66,81 @@ int for_all_bundles_in_list(struct bundle_list *list,
 	return 0;
 }
 
+/**
+ * Given a key-value pair, update the state of the given bundle list.
+ * Returns 0 if the key-value pair is understood. Returns 1 if the key
+ * is not understood or the value is malformed.
+ */
+MAYBE_UNUSED
+static int bundle_list_update(const char *key, const char *value,
+			      struct bundle_list *list)
+{
+	struct strbuf id = STRBUF_INIT;
+	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
+	struct remote_bundle_info *bundle;
+	const char *subsection, *subkey;
+	size_t subsection_len;
+
+	if (parse_config_key(key, "bundle", &subsection, &subsection_len, &subkey))
+		return -1;
+
+	if (!subsection_len) {
+		if (!strcmp(subkey, "version")) {
+			int version;
+			if (!git_parse_int(value, &version))
+				return -1;
+			if (version != 1)
+				return -1;
+
+			list->version = version;
+			return 0;
+		}
+
+		if (!strcmp(subkey, "mode")) {
+			if (!strcmp(value, "all"))
+				list->mode = BUNDLE_MODE_ALL;
+			else if (!strcmp(value, "any"))
+				list->mode = BUNDLE_MODE_ANY;
+			else
+				return -1;
+			return 0;
+		}
+
+		/* Ignore other unknown global keys. */
+		return 0;
+	}
+
+	strbuf_add(&id, subsection, subsection_len);
+
+	/*
+	 * Check for an existing bundle with this <id>, or create one
+	 * if necessary.
+	 */
+	lookup.id = id.buf;
+	hashmap_entry_init(&lookup.ent, strhash(lookup.id));
+	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
+		CALLOC_ARRAY(bundle, 1);
+		bundle->id = strbuf_detach(&id, NULL);
+		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
+		hashmap_add(&list->bundles, &bundle->ent);
+	}
+	strbuf_release(&id);
+
+	if (!strcmp(subkey, "uri")) {
+		if (bundle->uri)
+			return -1;
+		bundle->uri = xstrdup(value);
+		return 0;
+	}
+
+	/*
+	 * At this point, we ignore any information that we don't
+	 * understand, assuming it to be hints for a heuristic the client
+	 * does not currently understand.
+	 */
+	return 0;
+}
+
 static char *find_temp_filename(void)
 {
 	int fd;
diff --git a/config.c b/config.c
index 015bec360f5..e93101249f6 100644
--- a/config.c
+++ b/config.c
@@ -1214,7 +1214,7 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 	return 0;
 }
 
-static int git_parse_int(const char *value, int *ret)
+int git_parse_int(const char *value, int *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
diff --git a/config.h b/config.h
index ca994d77147..ef9eade6414 100644
--- a/config.h
+++ b/config.h
@@ -206,6 +206,7 @@ int config_with_options(config_fn_t fn, void *,
 
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_int(const char *value, int *ret);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
-- 
gitgitgadget

