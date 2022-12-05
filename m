Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1CC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiLERwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiLERvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45A60CB
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so19802051wrl.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDKpSmBn+STnbwuijw/6VlfTrIRU0b/XAk8TQ+voHE0=;
        b=eJdCJ0cIwRHv/iZvrB/6NkRESnsJC8+CqHifnqVx6JfTvPcL3y0i/GwdoB53oG7IaX
         3qvEmQBr1Zui+P8OlZFWnaW8XkUq9fZwq8SIF1q541xLd3SEj8LOm0lzKhsw/vi9VJZ1
         +IxhOL3fhchloHr7txPccUDROgCNwfw03rCS89M/pKMd9Mnvi2EjUHKuWCiWCkldIpXe
         SKlb3SVd7mcERX7iTZzwY6Y/0jXSMRFjJDh5zP85hGAtFEpswQrPD15Eu45xtlZIFC6l
         rfAhX97amMm87dao3y7tT/6Ar4zTBwnd7sC42dip1NEl6602u+3arLVCVo4+2qv7MkSG
         hURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDKpSmBn+STnbwuijw/6VlfTrIRU0b/XAk8TQ+voHE0=;
        b=lvsWQjZNY50FxsiHQzadgM9yWNUjQEwrzY/NpAzYpOQh3JROrRya6wW/vC+pC9h6K4
         syEaPWM6Mi7ncjXqaSyNDEVI/wrfWbOIYePJygnFyXhoBkwTgD5GlCwhsoUr4DmUhabZ
         HjJd6chkDkZWrMZmQRF2/aSeBJgTxVKUkQaLJ+CeZ6KdAwrGPBVrwEgEUnOwmTX5BooT
         MO9glm3+0nXJw1YBKzWwOIJ11bbjmE0QENhGFYTuQhPLy3KK13mXxeLI2AAY73qfZBRY
         jcqYDk3S04wCXVZeevfZ4/aHOeRbCRk6ZL0UQ0NoAO424lpJxZGAddYum9mYfefYIKnc
         ow8A==
X-Gm-Message-State: ANoB5plFuqdz6ns9t2+6U6ST7rzHXc4yy79HML5mriiotXKfRVWHqLNb
        K6MoZlAAELJizV9GppP3OFR+rXIsWU4=
X-Google-Smtp-Source: AA0mqf7c4k1j/WjJg0jFYvtjm88P2YT8t/pHaMx1SAFRoEbiaajEHp6w+2AHI+UlWWkLfl21KUO/CQ==
X-Received: by 2002:a5d:4a4c:0:b0:242:322c:c098 with SMTP id v12-20020a5d4a4c000000b00242322cc098mr5669670wrs.210.1670262643028;
        Mon, 05 Dec 2022 09:50:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b003c65c9a36dfsm18098934wmb.48.2022.12.05.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:42 -0800 (PST)
Message-Id: <fcdfef2012a74a4e08df53834d3c32bfd2bd10a1.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:30 +0000
Subject: [PATCH v3 02/11] t: create test harness for 'bundle-uri' command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

The previous change allowed for a Git server to advertise the
'bundle-uri' command as a capability based on the
uploadPack.advertiseBundleURIs config option. Create a set of tests that
check that this capability is advertised using 'git ls-remote'.

In order to test this functionality across three protocols (file, git,
and http), create lib-bundle-uri-protocol.sh to generalize the tests,
allowing the other test scripts to set an environment variable and
otherwise inherit the setup and tests from this script.

The tests currently only test that the 'bundle-uri' command is
advertised or not. Other actions will be tested as the Git client learns
to request the 'bundle-uri' command and parse its response.

To help with URI escaping, specifically for file paths with a space in
them, extract a 'sed' invocation from t9199-git-svn-info.sh into a
helper function for use here, too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/lib-bundle-uri-protocol.sh           | 85 ++++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh | 17 ++++++
 t/t5731-protocol-v2-bundle-uri-git.sh  | 17 ++++++
 t/t5732-protocol-v2-bundle-uri-http.sh | 17 ++++++
 t/t9119-git-svn-info.sh                |  2 +-
 t/test-lib-functions.sh                |  7 +++
 6 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-bundle-uri-protocol.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh

diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
new file mode 100644
index 00000000000..2da22a39cb8
--- /dev/null
+++ b/t/lib-bundle-uri-protocol.sh
@@ -0,0 +1,85 @@
+# Set up and run tests of the 'bundle-uri' command in protocol v2
+#
+# The test that includes this script should set BUNDLE_URI_PROTOCOL
+# to one of "file", "git", or "http".
+
+BUNDLE_URI_TEST_PARENT=
+BUNDLE_URI_TEST_URI=
+BUNDLE_URI_TEST_BUNDLE_URI=
+case "$BUNDLE_URI_PROTOCOL" in
+file)
+	BUNDLE_URI_PARENT=file_parent
+	BUNDLE_URI_REPO_URI="file://$PWD/file_parent"
+	BUNDLE_URI_BUNDLE_URI="$BUNDLE_URI_REPO_URI/fake.bdl"
+	test_set_prereq BUNDLE_URI_FILE
+	;;
+git)
+	. "$TEST_DIRECTORY"/lib-git-daemon.sh
+	start_git_daemon --export-all --enable=receive-pack
+	BUNDLE_URI_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
+	BUNDLE_URI_REPO_URI="$GIT_DAEMON_URL/parent"
+	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq BUNDLE_URI_GIT
+	;;
+http)
+	. "$TEST_DIRECTORY"/lib-httpd.sh
+	start_httpd
+	BUNDLE_URI_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
+	BUNDLE_URI_REPO_URI="$HTTPD_URL/smart/http_parent"
+	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq BUNDLE_URI_HTTP
+	;;
+*)
+	BUG "Need to pass valid BUNDLE_URI_PROTOCOL (was \"$BUNDLE_URI_PROTOCOL\")"
+	;;
+esac
+
+test_expect_success "setup protocol v2 $BUNDLE_URI_PROTOCOL:// tests" '
+	git init "$BUNDLE_URI_PARENT" &&
+	test_commit -C "$BUNDLE_URI_PARENT" one &&
+	git -C "$BUNDLE_URI_PARENT" config uploadpack.advertiseBundleURIs true
+'
+
+case "$BUNDLE_URI_PROTOCOL" in
+http)
+	test_expect_success "setup config for $BUNDLE_URI_PROTOCOL:// tests" '
+		git -C "$BUNDLE_URI_PARENT" config http.receivepack true
+	'
+	;;
+*)
+	;;
+esac
+BUNDLE_URI_BUNDLE_URI_ESCAPED=$(echo "$BUNDLE_URI_BUNDLE_URI" | test_uri_escape)
+
+test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: no bundle-uri" '
+	test_when_finished "rm -f log" &&
+	test_when_finished "git -C \"$BUNDLE_URI_PARENT\" config uploadpack.advertiseBundleURIs true" &&
+	git -C "$BUNDLE_URI_PARENT" config uploadpack.advertiseBundleURIs false &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$BUNDLE_URI_REPO_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	! grep bundle-uri log
+'
+
+test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: have bundle-uri" '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$BUNDLE_URI_REPO_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep "< bundle-uri" log
+'
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
new file mode 100755
index 00000000000..37bdb725bca
--- /dev/null
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'file://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'file://' transport
+#
+BUNDLE_URI_PROTOCOL=file
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
new file mode 100755
index 00000000000..8add1b37abc
--- /dev/null
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+BUNDLE_URI_PROTOCOL=git
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
new file mode 100755
index 00000000000..129daa02269
--- /dev/null
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'http://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'http://' transport
+#
+BUNDLE_URI_PROTOCOL=http
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 8201c3e808a..088d1c57a88 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -28,7 +28,7 @@ test_cmp_info () {
 	rm -f tmp.expect tmp.actual
 }
 
-quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
+quoted_svnrepo="$(echo $svnrepo | test_uri_escape)"
 
 test_expect_success 'setup repository and import' '
 	mkdir info &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 29d914a12ba..5f6966a404b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1755,6 +1755,13 @@ test_path_is_hidden () {
 	return 1
 }
 
+# Poor man's URI escaping. Good enough for the test suite whose trash
+# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
+# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
+test_uri_escape() {
+	sed 's/ /%20/g'
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget

