Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4138C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJJQEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJJQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6470E6F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so17704098wrb.8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23xdSrTs1L8KeO1BbMKQpiLa02wLnB63jG2LCHd+drg=;
        b=U5sKNQGUzP074BvDbIjbodBXuV2v4OJKhm2ufaWyknUi8h481hvehAPtR4gWa4C0Lm
         RKwCxn47Lo5OuTtGL4Kcxg6/HOTNOM0yxLfXMZbBM4iW6v84TdNejFU7rbr1fCgd8jV6
         ieZahrVbSBURRVMKjOinp/mRsi4rIHqZSbhEGVfwVrBGv/4+Aj93Xu07+MwMWI8RN4/8
         t7/e4YKhyJl3LSDKBI/8hCRmEPNDeZZf+3S9tSGKfWab1mNgmgn8y/u1+lf0nh1dYuF1
         ffvYb2isDfZxyiei9a7il+9wi7HvVuglXLA9j5IIyHQ3idisUbfISI4e0s5SRFiSEpML
         urLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23xdSrTs1L8KeO1BbMKQpiLa02wLnB63jG2LCHd+drg=;
        b=bQ/ocKYQZzcxyRI4h1tg3ZFQ9/4p1nioENrBK1Uc6N1Z8vRvr7qFlZ8oODyFD+aXpS
         gHyef0i6ZmdnYfekMEvPJe14u2EbCaD5cs6xKJeBRVKo+Hjaxy5Wp7C1z/jGymQh8/n4
         +gvm2HWjwra2BtE1AjmoIBR3NO2L4E6e5SGDpWz35i/Cbqg6ACbJdzVl02I1CizmpYF+
         LlIgMhOsrXHx2SOWAKAballjqpPzp+7UOzwkKs3Twx9QevGfBFJ2vkOlFFJLxanoVdI+
         nCJJ9k6Zt9PCFSUvgu4kxATBNanzUMzOyoP1qOxcOGm7qEibwCL25ffRRaTJ2klbvzH6
         149g==
X-Gm-Message-State: ACrzQf1Yv1m/3EbSM4hSsXNA9VWHDBTkudYO6ChcVjiBg6PiiTGKtmVP
        6+oRygiDsrV4fqEfnhrAgYcNK4Uqe5s=
X-Google-Smtp-Source: AMsMyM6fp5Mx/dkFuJL3Lc1gUX8zkBxCPcfa+MmXvokmdA6W1beLILHcyCarZSSXYin6nxOvElHtsQ==
X-Received: by 2002:a05:6000:10cc:b0:22e:39a:efe4 with SMTP id b12-20020a05600010cc00b0022e039aefe4mr12452800wrx.256.1665417868644;
        Mon, 10 Oct 2022 09:04:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v132-20020a1cac8a000000b003a541d893desm10806817wme.38.2022.10.10.09.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:28 -0700 (PDT)
Message-Id: <0ecae3a44b360fbb03a52b73536f83c457a6668d.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:14 +0000
Subject: [PATCH v4 06/11] bundle-uri: parse bundle list in config format
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

Create bundle_uri_parse_config_format() to parse a file in config format
and convert that into a 'struct bundle_list' filled with its
understanding of the contents.

Be careful to use error_action CONFIG_ERROR_ERROR when calling
git_config_from_file_with_options() because the default action for
git_config_from_file() is to die() on a parsing error.  The current
warning isn't particularly helpful if it arises to a user, but it will
be made more verbose at a higher layer later.

Update 'test-tool bundle-uri' to take this config file format as input.
It uses a filename instead of stdin because there is no existing way to
parse a FILE pointer in the config machinery. Using
git_config_from_mem() is overly complicated and more likely to introduce
bugs than this simpler version.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 27 ++++++++++++++++++++
 bundle-uri.h                |  9 +++++++
 t/helper/test-bundle-uri.c  | 49 +++++++++++++++++++++++++++---------
 t/t5750-bundle-uri-parse.sh | 50 +++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index c02e7f62eb1..3d44ec2b1e6 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -173,6 +173,33 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
+static int config_to_bundle_list(const char *key, const char *value, void *data)
+{
+	struct bundle_list *list = data;
+	return bundle_list_update(key, value, list);
+}
+
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list)
+{
+	int result;
+	struct config_options opts = {
+		.error_action = CONFIG_ERROR_ERROR,
+	};
+
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
 static char *find_temp_filename(void)
 {
 	int fd;
diff --git a/bundle-uri.h b/bundle-uri.h
index 0e56ab2ae5a..bc13d4c9929 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -62,6 +62,15 @@ int for_all_bundles_in_list(struct bundle_list *list,
 struct FILE;
 void print_bundle_list(FILE *fp, struct bundle_list *list);
 
+/**
+ * A bundle URI may point to a bundle list where the key=value
+ * pairs are provided in config file format. This method is
+ * exposed publicly for testing purposes.
+ */
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 0329c56544f..25afd393428 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -4,12 +4,21 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-static int cmd__bundle_uri_parse(int argc, const char **argv)
+enum input_mode {
+	KEY_VALUE_PAIRS,
+	CONFIG_FILE,
+};
+
+static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
 {
 	const char *key_value_usage[] = {
 		"test-tool bundle-uri parse-key-values <input>",
 		NULL
 	};
+	const char *config_usage[] = {
+		"test-tool bundle-uri parse-config <input>",
+		NULL
+	};
 	const char **usage = key_value_usage;
 	struct option options[] = {
 		OPT_END(),
@@ -19,21 +28,35 @@ static int cmd__bundle_uri_parse(int argc, const char **argv)
 	int err = 0;
 	FILE *fp;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc != 1)
-		goto usage;
+	if (mode == CONFIG_FILE)
+		usage = config_usage;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	init_bundle_list(&list);
-	fp = fopen(argv[0], "r");
-	if (!fp)
-		die("failed to open '%s'", argv[0]);
 
-	while (strbuf_getline(&sb, fp) != EOF) {
-		if (bundle_uri_parse_line(&list, sb.buf))
-			err = error("bad line: '%s'", sb.buf);
+	switch (mode) {
+	case KEY_VALUE_PAIRS:
+		if (argc != 1)
+			goto usage;
+		fp = fopen(argv[0], "r");
+		if (!fp)
+			die("failed to open '%s'", argv[0]);
+		while (strbuf_getline(&sb, fp) != EOF) {
+			if (bundle_uri_parse_line(&list, sb.buf))
+				err = error("bad line: '%s'", sb.buf);
+		}
+		fclose(fp);
+		break;
+
+	case CONFIG_FILE:
+		if (argc != 1)
+			goto usage;
+		err = bundle_uri_parse_config_format("<uri>", argv[0], &list);
+		break;
 	}
 	strbuf_release(&sb);
-	fclose(fp);
 
 	print_bundle_list(stdout, &list);
 
@@ -62,7 +85,9 @@ int cmd__bundle_uri(int argc, const char **argv)
 		goto usage;
 
 	if (!strcmp(argv[1], "parse-key-values"))
-		return cmd__bundle_uri_parse(argc - 1, argv + 1);
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
+	if (!strcmp(argv[1], "parse-config"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index fd142a66ad5..c2fe3f9c5a5 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -118,4 +118,54 @@ test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines
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
+		mode = all
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
+	error: bad config line 1 in file in2
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

