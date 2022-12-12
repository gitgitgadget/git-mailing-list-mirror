Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676EC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiLLReH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiLLRdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5572BD6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o15so6112343wmr.4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3VR5CgNDreUZEiN6rEeyLwig5BrH+18sd2ZOklikX4=;
        b=ercE4EPhT02BTQXygQjB8nDQOnAfJWCbPoFP4+uvMi4mmL/x+lXMB2fSfiWD/50UwW
         FGZ5zmCWVYe35H2ir24JWV6qn1IaYfJQ8nf+TodzEBhdJMeQLl3rbofvkIM5P93t2/PN
         ruFeybkzVAuOR3ppWpIqUWHr6hnozTSRi5nWwOh57Y/G81pLmaLnQLyCaSguPA/2D8lC
         F32hkDgZRS/YSp7JyxkbyUas98GLRtg57HY4l241t4lHgBZ7qW/SBWRVKQFgP0fPCy1J
         AqB1iKvlvU0Yskj2UzTW71QnWIVuXOa5EHl4WQcu/M9VlGW8ERUEUcFZxCATM6zYUlxd
         sPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3VR5CgNDreUZEiN6rEeyLwig5BrH+18sd2ZOklikX4=;
        b=gZYw2nCZN5pBGVmVeDogYZXGmStiWtOTtoGhflgxeUPNdJX5mu1Hab8AUPs9CiWHqV
         ipnUj3T80eVSSpYu/yDiIoiD1ohUPwu+CZaZOG4sc3MVGJ9xmWn/fEP7s7LJh5EyJNXY
         zFD62Nh0raD3GyQTTrCN1idX4NRxFKe2CHju/lscGu67d4j0cW73Hb5i64a8fe+5hgg3
         ET5pbsdiypdiKrK1dGUK8HA7+ELt8fvBYH4ad5svHpsP9LPQIMCN2A6Aw4FsKxDRpmbm
         6YWrg3OvvJ5XNrLmxYN8a1KjR0KLMBULz/Va7XPF/R/U6l3NN/1piaiQzwcDYO/ZYW6a
         De3Q==
X-Gm-Message-State: ANoB5pmdEZx7Mvvm31SJAJO9oSq32y3iY12ViYQUvTYaH1b3E6/DxkbX
        DecLeksMlXpyL7A3J+IgEwpxOF4jiYA=
X-Google-Smtp-Source: AA0mqf6lsc6zf+dV+Nb/PS/g/j4rtdA1gDJlqLDOk/HdEVfyI+HBPjhHEWBl7kKwkCuNIAajO4FdZQ==
X-Received: by 2002:a1c:7303:0:b0:3cf:a258:971 with SMTP id d3-20020a1c7303000000b003cfa2580971mr16600580wmb.41.1670866410003;
        Mon, 12 Dec 2022 09:33:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b47e75b401sm11181430wmo.37.2022.12.12.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:33:29 -0800 (PST)
Message-Id: <aafee168fbae2a1887f53febc4abd15522b12bc2.1670866407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 17:33:26 +0000
Subject: [PATCH 3/3] bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The GIT_TEST_BUNDLE_URI environment variable is used in the t573* suite
of tests that consume the bundle URIs advertised by the Git server. This
variable is equivalent to setting transfer.bundleURI=true, so we can do
that in these tests instead.

The environment variable has a name that implies it would be useful
outside of these tests. It is not useful to set across all tests since
it would do very little without some setup on the server side. Remove
it.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/lib-bundle-uri-protocol.sh | 12 ++++++++----
 t/t5601-clone.sh             |  8 ++++----
 transport.c                  |  5 ++---
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 73e2d45bc8b..a4a1af8d029 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -88,8 +88,8 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	test_when_finished "rm -rf log* cloned*" &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
-	GIT_TEST_BUNDLE_URI=0 \
 	git \
+		-c transfer.bundleURI=false \
 		-c protocol.version=2 \
 		clone "$BUNDLE_URI_REPO_URI" cloned \
 		>actual 2>err &&
@@ -137,6 +137,13 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	! grep "> command=bundle-uri" log3
 '
 
+# The remaining tests will all assume transfer.bundleURI=true
+#
+# This test can be removed when transfer.bundleURI is enabled by default.
+test_expect_success 'enable transfer.bundleURI for remaining tests' '
+	git config --global transfer.bundleURI true
+'
+
 test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
 	test_config -C "$BUNDLE_URI_PARENT" \
 		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
@@ -150,7 +157,6 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
 	EOF
 
-	GIT_TEST_BUNDLE_URI=1 \
 	test-tool bundle-uri \
 		ls-remote \
 		"$BUNDLE_URI_REPO_URI" \
@@ -174,7 +180,6 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
 	EOF
 
-	GIT_TEST_BUNDLE_URI=1 \
 	test-tool bundle-uri \
 		ls-remote \
 		"$BUNDLE_URI_REPO_URI" \
@@ -203,7 +208,6 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl
 	EOF
 
-	GIT_TEST_BUNDLE_URI=1 \
 	test-tool bundle-uri \
 		ls-remote \
 		"$BUNDLE_URI_REPO_URI" \
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a08a691ec4c..1928ea1dd7c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -786,9 +786,9 @@ test_expect_success 'auto-discover bundle URI from HTTP clone' '
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
 		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
 
-	GIT_TEST_BUNDLE_URI=1 \
 	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git -c protocol.version=2 clone \
+		git -c protocol.version=2 \
+		    -c transfer.bundleURI=true clone \
 		$HTTPD_URL/smart/repo2.git repo2 &&
 	cat >pattern <<-EOF &&
 	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
@@ -815,9 +815,9 @@ test_expect_success 'auto-discover multiple bundles from HTTP clone' '
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
 		bundle.new.uri "$HTTPD_URL/new.bundle" &&
 
-	GIT_TEST_BUNDLE_URI=1 \
 	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git -c protocol.version=2 clone \
+		git -c protocol.version=2 \
+		    -c transfer.bundleURI=true clone \
 		$HTTPD_URL/smart/repo3.git repo3 &&
 
 	# We should fetch _both_ bundles
diff --git a/transport.c b/transport.c
index 957dca4923c..241f8a6ba2d 100644
--- a/transport.c
+++ b/transport.c
@@ -1533,10 +1533,9 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 
 	/*
 	 * Don't request bundle-uri from the server unless configured to
-	 * do so by GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
+	 * do so by the transfer.bundleURI=true config option.
 	 */
-	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
-	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
+	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
 		return 0;
 
 	if (!transport->bundles->baseURI)
-- 
gitgitgadget
