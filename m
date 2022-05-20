Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12422C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352960AbiETSmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353014AbiETSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278D220D9
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h14so12641816wrc.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=egM23Z1gtXjOynBl3UOwVGse3TLP4q2+Rj1TiJL74ic=;
        b=XXZNtbvmiJudGjdb13YYdxIneIGqJlv7HZUW29QVHbqcYtcuJ0CVgsgqdz7KgPLqCy
         gZ5FoGxUjBVloCx/Ez56SlHvdQgGpM+Wtd6mPbCY7EDHRGihO1A8vjWA+bBwKBJ2xgH9
         PU8RfKpiNFz2ESivAAw29FwaITGPwsebvjLxxoSFvFubnaJmjwQr/HnWc2hWC+FwfMcF
         DjCgyVR1WQCBoRBUDnvvs6WZh5K0l8/4mwsKhdHzs8DqWOFe3YCHTZRMpZN+itBHwgpI
         l0SvKoDbKC4YmhWHZRsZrHpQ/IP5bqXmhqeX7fksZzhD7le69hCvAX9kWg5mQ3A083Oq
         1q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=egM23Z1gtXjOynBl3UOwVGse3TLP4q2+Rj1TiJL74ic=;
        b=dq8SLcbyww2yzYV32JEDu3OpZHACgiIrjeC1hzeWBmS4ySXLhpETVIV9eFBbxg8ajQ
         bNp5xCkAAfumOjgB7seGve02A+ZTtFmXl8lif81IdQ3uLHi6O1+rYRH3Fgaliu8vGlh+
         p/cuHfbSSeMUHxGfTGVOOEddaxfoAJMwtfhPUPf+3hTkCIkyZQORAf2HEJcy3qq5zeyb
         8hwdFxp5S37Bt2NAtd10GIGkfzSSw57qFfweMOxCcipZGG398I/25+ZvRCI8pjP8OIS9
         2hgyV43HPEGBErM8+sgGDVMm6zRnrMwKTJ64dErfHxnqOvwaYjog1DA3HoEqpmQa2JXw
         NEMw==
X-Gm-Message-State: AOAM531ANSTnevKWcmXp0Vw1pg6dQDhcCuCX9foIkYokIu94vGk+xZBA
        qBXFDkE6Voi2F2NHSSpqZYj+03TS/e0=
X-Google-Smtp-Source: ABdhPJxIY9ntMXjElJ85sa9c0x/Ls9N5B4Ag3e/WPcQXH6Vajep8evftyrq9+38/9FtGyAmee8Wqjg==
X-Received: by 2002:a5d:5910:0:b0:20d:6e9:d4e9 with SMTP id v16-20020a5d5910000000b0020d06e9d4e9mr9369560wrd.69.1653072062501;
        Fri, 20 May 2022 11:41:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfa742000000b0020c5253d8f2sm3071792wrd.62.2022.05.20.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:01 -0700 (PDT)
Message-Id: <94f552e771644aef60c23e5d9379723951542031.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:34 +0000
Subject: [PATCH 16/24] protocol v2: add server-side "bundle-uri" skeleton
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Add a skeleton server-side implementation of a new "bundle-uri" command
to protocol v2. This will allow conforming clients to optionally seed
their initial clones or incremental fetches from URLs containing
"*.bundle" files created with "git bundle create".

This change only performs the basic boilerplate of advertising a new
protocol v2 capability. The new 'bundle-uri' capability allows a client
to request a list of bundles. Right now, the server only returns a flush
packet, which corresponds to an empty advertisement.

The critical bit right now is that the new boolean
uploadPack.adverstiseBundleURIs config value signals whether or not this
capability should be advertised at all.

RFC TODO: Write documentation.

RFC TODO: Compare to original implementation.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c         | 36 ++++++++++++++++++++++++++++++++++++
 bundle-uri.h         |  7 +++++++
 serve.c              |  6 ++++++
 t/t5701-git-serve.sh | 40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 601e6e87822..79a6b7ed8b8 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -557,6 +557,42 @@ cleanup:
 	return result;
 }
 
+/**
+ * API for serve.c.
+ */
+
+static int advertise_bundle_uri = -1;
+
+int bundle_uri_advertise(struct repository *r, struct strbuf *value)
+{
+	if (advertise_bundle_uri != -1)
+		goto cached;
+
+	advertise_bundle_uri = 0;
+	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
+
+cached:
+	return advertise_bundle_uri;
+}
+
+int bundle_uri_command(struct repository *r,
+		       struct packet_reader *request)
+{
+	struct packet_writer writer;
+	packet_writer_init(&writer, 1);
+
+	while (packet_reader_read(request) == PACKET_READ_NORMAL)
+		die(_("bundle-uri: unexpected argument: '%s'"), request->line);
+	if (request->status != PACKET_READ_FLUSH)
+		die(_("bundle-uri: expected flush after arguments"));
+
+	/* TODO: Implement the communication */
+
+	packet_writer_flush(&writer);
+
+	return 0;
+}
+
 /**
  * General API for {transport,connect}.c etc.
  */
diff --git a/bundle-uri.h b/bundle-uri.h
index adce5dc07e2..9f6fc2d75f9 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -4,6 +4,7 @@
 #include "hashmap.h"
 #include "strbuf.h"
 
+struct packet_reader;
 struct repository;
 struct strbuf;
 struct string_list;
@@ -97,6 +98,12 @@ int parse_bundle_list_in_config_format(const char *uri,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * API for serve.c.
+ */
+int bundle_uri_advertise(struct repository *r, struct strbuf *value);
+int bundle_uri_command(struct repository *r, struct packet_reader *request);
+
 /**
  * General API for {transport,connect}.c etc.
  */
diff --git a/serve.c b/serve.c
index b3fe9b5126a..f3e0203d2c6 100644
--- a/serve.c
+++ b/serve.c
@@ -8,6 +8,7 @@
 #include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
+#include "bundle-uri.h"
 
 static int advertise_sid = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
@@ -136,6 +137,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = always_advertise,
 		.command = cap_object_info,
 	},
+	{
+		.name = "bundle-uri",
+		.advertise = bundle_uri_advertise,
+		.command = bundle_uri_command,
+	},
 };
 
 void protocol_v2_advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 1896f671cb3..f21e5e9d33d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -13,7 +13,7 @@ test_expect_success 'test capability advertisement' '
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
-	cat >expect <<-EOF &&
+	cat >expect.base <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs=unborn
@@ -21,8 +21,11 @@ test_expect_success 'test capability advertisement' '
 	server-option
 	object-format=$(test_oid algo)
 	object-info
+	EOF
+	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
@@ -342,4 +345,39 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement with uploadpack.advertiseBundleURIs' '
+	test_config uploadpack.advertiseBundleURIs true &&
+
+	cat >expect.extra <<-EOF &&
+	bundle-uri
+	EOF
+	cat expect.base \
+	    expect.extra \
+	    expect.trailer >expect &&
+
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: dies if not enabled' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	0000
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	cat >expect <<-\EOF &&
+	ERR serve: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out
+'
+
 test_done
-- 
gitgitgadget

