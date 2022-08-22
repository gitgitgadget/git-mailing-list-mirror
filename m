Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB0C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiHVPTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiHVPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87A27B23
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so9336788wrr.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=hGP/DY7F9uw3HccMlGFYyDjtui5Vi5AEWmVQmMW/puU=;
        b=U5tn/ydBN20z/qmQa4eSLbJTHbszIJtEKHqhbMZsRmUpaA1ep0B/hOMifbn56KXzy6
         RnoO8Rz7hVxPwMB8HMGjBH+tfjGRRRs80m9QlR0gXf54BX0Osr0xhC+KD3NeOZ9oYgkA
         pEFI3e7uWJ1efNsmsLYiWC3vmMHajxd9oeBA8Dqa0JiM6UnzGcKTCMhTa3y8riR59AJ1
         0Wv1+bcBNMhDiFjD9ts9x+v0O4nuCNHiKKGooXwVvtJyW4XBEycz+GXtG6t1qTAu13mf
         GIu+kf9w/s3Alx6qblJ2okjbL4Oj2hhU1TES0cX+1zxUykPw2LwMwGYxu/N40g/6y3eL
         0ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=hGP/DY7F9uw3HccMlGFYyDjtui5Vi5AEWmVQmMW/puU=;
        b=MzHSENizn26MEzPBen1JXAl7bV22UVseVR7p+W+5wwneZmHf9XZcPmNHM+KiFRD6NE
         z3L1qMt/C5ifM5nXC5K8QLYMRG0k7zvbVRq39aUvL0e5tyTmYKWdNmNxpEq6TDH2Y+3p
         61QiYWiZdR3WJEUZIcXuD2AN2K4hmZn7BYeJZKHvXEJti4tKMO7YDIngnnhYkSPhcJXq
         UuWj1pQTm38QQALpYKv99sV1+aIvX63+fAIlAjNkUAFCHUBSJ2qXmdpBN1icrx0W+R1/
         xITNqcHYS8KG8dZW0hIYLdFYUCcZQ+C3kqZbojUmQqzGMisf5xecBEXUXK4G+PYmri9I
         Ah1Q==
X-Gm-Message-State: ACgBeo3pGBP/JebqOnxfYyNCB+WLbuW6qNuMQzxFcpoIf+ASEtV0Anz9
        m1EjeE2AuFkYCYUA6U70Ps2ckw9w1w8=
X-Google-Smtp-Source: AA6agR7QBnVtsWp1QWENmQCYptoWJVxvfyJgn7p4iCq+gBa1V4Dl/V6yXew5Haxfwp9y0oaHJ2eOOw==
X-Received: by 2002:a05:6000:1149:b0:225:29d4:67eb with SMTP id d9-20020a056000114900b0022529d467ebmr11132704wrx.254.1661181180820;
        Mon, 22 Aug 2022 08:13:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b003a4c6e67f01sm21243619wmq.6.2022.08.22.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:13:00 -0700 (PDT)
Message-Id: <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:52 +0000
Subject: [PATCH 5/7] bundle-uri: parse bundle list in config format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a bundle provider wants to operate independently from a Git remote,
they want to provide a single, consistent URI that users can use in
their 'git clone --bundle-uri' commands. At this point, the Git client
expects that URI to be a single bundle that can be unbundled and used to
bootstrap the rest of the clone from the Git server. This single bundle
cannot be re-used to assist with future incremental fetches.

To allow for the incremental fetch case, teach Git to understand a
bundle list that could be advertised at an independent bundle URI. Such
a bundle list is likely to be inspected by human readers, even if only
by the bundle provider creating the list. For this reason, we can take
our expected "key=value" pairs and instead format them using Git config
format.

Create parse_bundle_list_in_config_format() to parse a file in config
format and convert that into a 'struct bundle_list' filled with its
understanding of the contents.

Be careful to call git_config_from_file_with_options() because the
default action for git_config_from_file() is to die() on a parsing
error. The current warning isn't particularly helpful if it arises to a
user, but it will be made more verbose at a higher layer later.

Update 'test-tool bundle-uri' to take this config file format as input.
It uses a filename instead of stdin because there is no existing way to
parse a FILE pointer in the config machinery. Using
git_config_from_mem() is overly complicated and more likely to introduce
bugs than this simpler version. I would rather have a slightly confusing
test helper than complicated product code.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 29 +++++++++++++++++++++
 bundle-uri.h                | 10 ++++++++
 t/helper/test-bundle-uri.c  | 45 ++++++++++++++++++++++++++-------
 t/t5750-bundle-uri-parse.sh | 50 +++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index d56c5e33d5f..dca88ed1e89 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
+#include "config.h"
 
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
@@ -172,6 +173,34 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
+static int config_to_bundle_list(const char *key, const char *value, void *data)
+{
+	struct bundle_list *list = data;
+	return bundle_list_update(key, value, list);
+}
+
+int parse_bundle_list_in_config_format(const char *uri,
+				       const char *filename,
+				       struct bundle_list *list)
+{
+	int result;
+	struct config_options opts = {
+		.error_action = CONFIG_ERROR_ERROR,
+	};
+
+	list->mode = BUNDLE_MODE_NONE;
+	result = git_config_from_file_with_options(config_to_bundle_list,
+						   filename, list,
+						   &opts);
+
+	if (!result && list->mode == BUNDLE_MODE_NONE) {
+		warning(_("bundle list at '%s' has no mode"), uri);
+		result = 1;
+	}
+
+	return result;
+}
+
 static int find_temp_filename(struct strbuf *name)
 {
 	int fd;
diff --git a/bundle-uri.h b/bundle-uri.h
index 41a1510a4ac..294ac804140 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -71,6 +71,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
 struct FILE;
 void print_bundle_list(FILE *fp, struct bundle_list *list);
 
+/**
+ * A bundle URI may point to a bundle list where the key=value
+ * pairs are provided in config file format. This method is
+ * exposed publicly for testing purposes.
+ */
+
+int parse_bundle_list_in_config_format(const char *uri,
+				       const char *filename,
+				       struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 5cb0c9196fa..23ce0eebca3 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -4,27 +4,52 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-static int cmd__bundle_uri_parse_key_values(int argc, const char **argv)
+enum input_mode {
+	KEY_VALUE_PAIRS,
+	CONFIG_FILE,
+};
+
+static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
 {
-	const char *usage[] = {
+	const char *key_value_usage[] = {
 		"test-tool bundle-uri parse-key-values <in",
 		NULL
 	};
+	const char *config_usage[] = {
+		"test-tool bundle-uri parse-config <input>",
+		NULL
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char **usage = key_value_usage;
 	struct strbuf sb = STRBUF_INIT;
 	struct bundle_list list;
 	int err = 0;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc)
-		goto usage;
+	if (mode == CONFIG_FILE)
+		usage = config_usage;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	init_bundle_list(&list);
-	while (strbuf_getline(&sb, stdin) != EOF) {
-		if (bundle_uri_parse_line(&list, sb.buf) < 0)
-			err = error("bad line: '%s'", sb.buf);
+
+	switch (mode) {
+	case KEY_VALUE_PAIRS:
+		if (argc)
+			goto usage;
+		while (strbuf_getline(&sb, stdin) != EOF) {
+			if (bundle_uri_parse_line(&list, sb.buf) < 0)
+				err = error("bad line: '%s'", sb.buf);
+		}
+		break;
+
+	case CONFIG_FILE:
+		if (argc != 1)
+			goto usage;
+		err = parse_bundle_list_in_config_format("<uri>", argv[0], &list);
+		break;
 	}
 	strbuf_release(&sb);
 
@@ -55,7 +80,9 @@ int cmd__bundle_uri(int argc, const char **argv)
 		goto usage;
 
 	if (!strcmp(argv[1], "parse-key-values"))
-		return cmd__bundle_uri_parse_key_values(argc - 1, argv + 1);
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
+	if (!strcmp(argv[1], "parse-config"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 675c1f1d2f4..dd9dc36bfd7 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -88,4 +88,54 @@ test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty lines' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: just URIs' '
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
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
+test_expect_success 'parse config format edge cases: empty key or value' '
+	cat >in1 <<-\EOF &&
+	= bogus-value
+	EOF
+
+	cat >err1 <<-EOF &&
+	error: bad config line 1 in file in1
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = <unknown>
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in1 >actual 2>err &&
+	test_cmp err1 err &&
+	test_cmp_config_output expect actual &&
+
+	cat >in2 <<-\EOF &&
+	bogus-key =
+	EOF
+
+	cat >err2 <<-EOF &&
+	warning: bundle list at '\''<uri>'\'' has no mode
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in2 >actual 2>err &&
+	test_cmp err2 err &&
+	test_cmp_config_output expect actual
+'
+
 test_done
-- 
gitgitgadget

