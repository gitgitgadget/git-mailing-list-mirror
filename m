Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417AFA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKABIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKABHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6A165B5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w14so18220220wru.8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3/06B+tN8VDLYpoq51dkxKW8dwQ9YorBO/1Gu/cg8g=;
        b=MP+pMItKZ8k7kNLYfcI/TUrqcXYKYqhDeUcpiFjuQ4NmdLxB7Hbo0uaucWNo770Ndu
         zfKCIk9rqQaqqDb5pHyU5XTN7N7Nqo/NY33mt806cNr2bkIT8473CZfQbl2sL8KGjRHl
         b15remwRJIYlnkMwn0EI8vKksq5P78L/uQglrS0ka2p0iKn2LLru7njb254P4VGZo9j+
         VvY+TCH6G4ET+Bx3MXyYuwOR6W9R7c0eCsSB5eDfSXOAgxKu8DT+t8eH7i36QAFqHQ7E
         IqaHgnkcM3llYXARNPL3xvIh6riMcRuaqp7Q+UeYxeUZHJTk9CAZfG+mX3EFEFXCDg/N
         4GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3/06B+tN8VDLYpoq51dkxKW8dwQ9YorBO/1Gu/cg8g=;
        b=vbukw2aaFFpHrIFztktEP6VI8lJPkWOOL59WauJneQBesD/fyOGEEgMxAyCxdkeCaz
         E7CI/VMxbUL7AgWu68mO3MLJykf/OuZ5VF8KaEcRT5iabgVd54cTKjOZUJfpbYaKKLbP
         9N2BLOAopF2TU5FZ86WuZatcBusMAhucMenaLQaxNfnM3R1JxajjIRES891HMONgkzZ4
         zCLQ/clS+iB3MrTRlVOybxwNp9sOECp6DixYIr2jVLIZ1qTr4udT3GJZexCmBTt85p0U
         34FBTLAaqx0D+XALXR/UA+B1++sUUAj8s73aPaDMrEoQsu/gH7vXQ7I7NluNrPfPNJU+
         FeuA==
X-Gm-Message-State: ACrzQf21+m58lK61HnQFwhHmOG0Jqh4UaDpMeo9KPIK9GH046jQQr8cU
        smdRuWCteZQ69Uhp3cXTst0emoKQK14=
X-Google-Smtp-Source: AMsMyM6qw03mnMhFCJLh1YkrMgB7gefr1OwCV9W44zHuXg/v5qXPdyb3lnE+qb96KOSZohTPmSywSA==
X-Received: by 2002:adf:fc07:0:b0:236:6f04:2010 with SMTP id i7-20020adffc07000000b002366f042010mr9739982wrr.227.1667264863298;
        Mon, 31 Oct 2022 18:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b003b435c41103sm9795860wmb.0.2022.10.31.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:42 -0700 (PDT)
Message-Id: <1c034bba744716b03c6ce4422a378001c9c7e39f.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:34 +0000
Subject: [PATCH 9/9] clone: unbundle the advertised bundles
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

A previous change introduced the transport methods to acquire a bundle
list from the 'bundle-uri' protocol v2 verb, when advertised _and_ when
the client has chosen to enable the feature.

Teach Git to download and unbundle the data advertised by those bundles
during 'git clone'.

Also, since the --bundle-uri option exists, we do not want to mix the
advertised bundles with the user-specified bundles.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c  | 26 +++++++++++++++++----
 t/t5601-clone.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 22b1e506452..09f10477ed6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1267,11 +1267,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-	/*
-	 * Populate transport->got_remote_bundle_uri and
-	 * transport->bundle_uri. We might get nothing.
-	 */
-	transport_get_remote_bundle_uri(transport, 1);
+	if (!bundle_uri) {
+		/*
+		* Populate transport->got_remote_bundle_uri and
+		* transport->bundle_uri. We might get nothing.
+		*/
+		transport_get_remote_bundle_uri(transport, 1);
+
+		if (transport->bundles &&
+		    hashmap_get_size(&transport->bundles->bundles)) {
+			/* At this point, we need the_repository to match the cloned repo. */
+			if (repo_init(the_repository, git_dir, work_tree))
+				warning(_("failed to initialize the repo, skipping bundle URI"));
+			if (fetch_bundle_list(the_repository,
+					      remote->url[0],
+					      transport->bundles))
+				warning(_("failed to fetch advertised bundles"));
+		} else {
+			clear_bundle_list(transport->bundles);
+			FREE_AND_NULL(transport->bundles);
+		}
+	}
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..d1d8139751e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -795,6 +795,65 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
 
+test_expect_success 'auto-discover bundle URI from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo2 "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo2.git repo2 &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
+test_expect_success 'auto-discover multiple bundles from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo3 "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	test_commit -C src new &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/new.bundle" HEAD~1..HEAD &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.mode all &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.new.uri "$HTTPD_URL/new.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo3.git repo3 &&
+
+	# We should fetch _both_ bundles
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/new.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget
