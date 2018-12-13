Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDE620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeLMP6j (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeLMP6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so2903226wmd.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGMlI3CZDbmq5C6f69hVH0JcGjD8Ih8XblrlBYwNo7U=;
        b=FSbELAXhYc0iUGnxCz0TdpP6JAJCHtYmbmgmCJ/XwUfxdiyXcQjX+izgoY8GY1NNcK
         PAH6yMuTJWk1r1hOrmW24GgVJSG+o8EzcNYD5TLUId4gsy8zDFanKQd1CfyMIzkDDnl4
         /bcCJtVrwVwhxHXkbFt1ALd1s2qd0213lZujT+Gt9DRzfFghVVv/2jxgy+/KRcLgKgtI
         sBi/De1MQVvyfn/aAufcOGdl0BQaHyT5HLmyE5u87/EPmeZ1qNwNGynYbrH8YKXMhnsP
         LyVXPqlFG3DUeczZnRkc3p2/ZcoJjZf5XwlSQwP7lmS7OiLA6WP+yd6KNJx8Q3yZEyj0
         wGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGMlI3CZDbmq5C6f69hVH0JcGjD8Ih8XblrlBYwNo7U=;
        b=G8u/BSbwZZCbTKf3R9eCn8Ldu0fOyOeBaxIDSsQLz2kUdnfNSw8SZ716BsDblC2TwO
         NplNpbrAsy3I4nSJmTpPjtSywp8Oqcsd/kD+nt4rs4Fmq77F9WW7xjJ3FxdJ9yZXrO8N
         Dn/IstO53M1Bqn9/mfwWoS1Nw1VyPgvns1Luu1Ski8JyJezoHP6h8G4b9gFeZPlVnfQC
         9KdGWvozsYXtGBztfKj3P+LCwjSR5qHPT9b7D1blr2MAULa2GS+gruI9axU5x+xBOl2A
         EBmmm3v11H5XehTiz0A/788yt2gnkIjkB/Dq3OewgBZZ7cTkG9k/jV5G+DToRiSagA1i
         99TQ==
X-Gm-Message-State: AA+aEWaGddAzbu2qkXrSfdmVocUkxDg5W5139CtnwA7FWlVn4NIipX2T
        q4Q5q2n0seQwtBjzEnQeAPad42yghbc=
X-Google-Smtp-Source: AFSGD/Vknf5MzUkGHX3eFX2A7BsCL+RVJpOcElMazrIc7+kJc9Gb6gdJxVQEa0Rjx1/KMR5Iyd4fbg==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr10654320wmb.80.1544716715600;
        Thu, 13 Dec 2018 07:58:35 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] tests: add a special setup where for protocol.version
Date:   Thu, 13 Dec 2018 16:58:14 +0100
Message-Id: <20181213155817.27666-6-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_PROTOCOL_VERSION=X test mode which is equivalent to
running with protocol.version=X. This is needed to spot regressions
and differences such as "ls-refs" behaving differently with
transfer.hideRefs. See
https://public-inbox.org/git/20181211104236.GA6899@sigill.intra.peff.net/
for a fix for that regression.

With this all tests pass with GIT_TEST_PROTOCOL_VERSION=0, but fail
with GIT_TEST_PROTOCOL_VERSION=[1|2]. That's OK since this is a new
test mode, subsequent patches will fix up these test failures.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 protocol.c               | 13 ++++++++++++-
 t/README                 |  6 ++++++
 t/t0410-partial-clone.sh |  3 ++-
 t/t5516-fetch-push.sh    |  3 ++-
 t/t5700-protocol-v1.sh   |  1 +
 t/t5702-protocol-v2.sh   |  1 +
 6 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/protocol.c b/protocol.c
index 5e636785d1..aa06c3b5bc 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,7 +17,18 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
-	if (!git_config_get_string_const("protocol.version", &value)) {
+	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
+	const char *git_test_v = getenv(git_test_k);
+
+	if (git_test_v && strlen(git_test_v)) {
+		enum protocol_version version = parse_protocol_version(git_test_v);
+
+		if (version == protocol_unknown_version)
+			die("unknown value for %s: %s", git_test_k,
+			    git_test_v);
+
+		return version;
+	} else if (!git_config_get_string_const("protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
 
 		if (version == protocol_unknown_version)
diff --git a/t/README b/t/README
index 28711cc508..89629c5818 100644
--- a/t/README
+++ b/t/README
@@ -311,6 +311,12 @@ marked strings" in po/README for details.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
+GIT_TEST_PROTOCOL_VERSION=<'protocol.version' config value>, when set,
+runs the test suite with the given protocol.version. E.g. "0", "1" or
+"2". Can be set to the empty string within tests themselves (e.g. "env
+GIT_TEST_PROTOCOL_VERSION= <cmd>") to unset the value in the
+environment as a workaround for "env --unset" not being portable.
+
 GIT_TEST_FULL_IN_PACK_ARRAY=<boolean> exercises the uncommon
 pack-objects code path where there are more than 1024 packs even if
 the actual number of packs in repository is below this limit. Accept
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..8ba3d9b5ab 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -178,7 +178,8 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 
 	rm -rf repo/.git/objects/* &&
 	rm -f trace &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo cat-file -p "$HASH" &&
+	GIT_TRACE_PACKET="$(pwd)/trace" env GIT_TEST_PROTOCOL_VERSION= \
+		git -C repo cat-file -p "$HASH" &&
 	grep "git< fetch=.*ref-in-want" trace
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..08cdee0b95 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1187,7 +1187,8 @@ test_expect_success 'fetch exact SHA1 in protocol v2' '
 
 	# fetching the hidden object succeeds by default
 	# NEEDSWORK: should this match the v0 behavior instead?
-	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
+	env GIT_TEST_PROTOCOL_VERSION= \
+		git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
 '
 
 for configallowtipsha1inwant in true false
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..e4d375c462 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -8,6 +8,7 @@ TEST_NO_CREATE_REPO=1
 
 # Test protocol v1 with 'git://' transport
 #
+unset GIT_TEST_PROTOCOL_VERSION
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..d1549f294e 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -8,6 +8,7 @@ TEST_NO_CREATE_REPO=1
 
 # Test protocol v2 with 'git://' transport
 #
+unset GIT_TEST_PROTOCOL_VERSION
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
-- 
2.20.0.405.gbc1bbc6f85

