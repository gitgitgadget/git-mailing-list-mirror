Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64310C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiKPTwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiKPTvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08E4875A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h9so31746260wrt.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC4MklC4EotCdkubgLTySzDpazds/cBLtZSjsLhluuw=;
        b=oEAqBQ3Gan0hPFcwrCrhmjCw0tuB/KiyK9/zv/lg0ypY8BNLsJm/DyULwKmBzspTzj
         9P/9o15ZbW4HWdZyinYANJ4iGx/0hdsYaksa0r4hXvA2yfMH+duqQUVhS5h8lq6cIZCa
         bdnb2B9GN1Smcw1bIJ4ygt23GRYEemtL5lCYaA4kgWwTRei8CKIFKs+w39SQCvxPmT9K
         esKcDQdv1wFrWr93rk60y1DxolgDcU3Zc0x1jCoG0uZOwU8LS71F06kNna5OhZJ0iCs4
         9VQAHt2UWIujkRHRuK0p7EQi3pCpBfHjl3QfTI59/Yj5bT0ne3Ed+O+u3CC1aokO+pPu
         PIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC4MklC4EotCdkubgLTySzDpazds/cBLtZSjsLhluuw=;
        b=mm9LTxIh9k5vwQYTA8vtiZhuSePdm3p8ds0utVxYI789Fy8RI7wzY2PDFqVrlQGNKG
         Wc2BjiUXXs1R5VCvDyurRxW2tFoh1foIBaXMpnSov2iMkH11aXF50oAP5lvIqWMLWkId
         LQzeHOjTSiHxBL/gWgE8tJCvF23I1ep03vb6FnBLCtovsbfZ69s+DEuHWtTgI7BnNJUj
         7SbqBlwcA86x5fV+SkW2L3zBkz66qR5hp54MC/3PFJ+5o6f/eQ48Uxn4qB05J6PoiJ9g
         cEnRH+36u2MqsPoSpuZg/bmFh03Z+itVj7JeoZvltgSSE/+Jtd6nbsGkj5A1Hm/Ri5RL
         lI/A==
X-Gm-Message-State: ANoB5plF0YBDT9j3DNqVQzOD07lAaM2CjcD0gfUwZ0HkRDDTMKKT+jcI
        GKMhlxbb3NnycwxhAfgmxF5WI2Tcv3g=
X-Google-Smtp-Source: AA0mqf5KhkbIATYSn1ARzuSkQiTI0cdkUNGD5aa8PqerJh4ZDAsiJrHwnGaMKvwNym5Ed759CJ1T6g==
X-Received: by 2002:a5d:5914:0:b0:236:6a5b:5610 with SMTP id v20-20020a5d5914000000b002366a5b5610mr14756797wrd.195.1668628308065;
        Wed, 16 Nov 2022 11:51:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003b47b80cec3sm3509053wms.42.2022.11.16.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:47 -0800 (PST)
Message-Id: <cd906f6d9818a36cbdee896c1ede44d6de3f8990.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:37 +0000
Subject: [PATCH v2 4/9] bundle-uri: serve bundle.* keys from config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Implement the "bundle-uri" protocol v2 capability by populating the
key=value packet lines from the local Git config. The list of bundles is
provided from the keys beginning with "bundle.".

In the future, we may want to filter this list to be more specific to
the exact known keys that the server intends to share, but for
flexibility at the moment we will assume that the config values are
well-formed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                          | 16 +++++++++++-
 t/lib-t5730-protocol-v2-bundle-uri.sh | 35 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2201b604b11..3469f1aaa98 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -585,6 +585,16 @@ cached:
 	return advertise_bundle_uri;
 }
 
+static int config_to_packet_line(const char *key, const char *value, void *data)
+{
+	struct packet_reader *writer = data;
+
+	if (!strncmp(key, "bundle.", 7))
+		packet_write_fmt(writer->fd, "%s=%s", key, value);
+
+	return 0;
+}
+
 int bundle_uri_command(struct repository *r,
 		       struct packet_reader *request)
 {
@@ -596,7 +606,11 @@ int bundle_uri_command(struct repository *r,
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("bundle-uri: expected flush after arguments"));
 
-	/* TODO: Implement the communication */
+	/*
+	 * Read all "bundle.*" config lines to the client as key=value
+	 * packet lines.
+	 */
+	git_config(config_to_packet_line, &writer);
 
 	packet_writer_flush(&writer);
 
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index c327544641b..000fcc5e20b 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -158,6 +158,8 @@ test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2" '
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
 	EOF
 	GIT_TRACE_PACKET="$PWD/log" \
 	test-tool bundle-uri \
@@ -181,6 +183,39 @@ test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 and ext
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	test-tool bundle-uri \
+		ls-remote \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+
+test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 with list" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle1.uri "$T5730_BUNDLE_URI_ESCAPED-1.bdl" &&
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle2.uri "$T5730_BUNDLE_URI_ESCAPED-2.bdl" &&
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle3.uri "$T5730_BUNDLE_URI_ESCAPED-3.bdl" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "bundle1"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-1.bdl
+	[bundle "bundle2"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-2.bdl
+	[bundle "bundle3"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-3.bdl
 	EOF
 	GIT_TRACE_PACKET="$PWD/log" \
 	test-tool bundle-uri \
-- 
gitgitgadget

