Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F6B20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKVVy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:21:54 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38095 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKVVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:21:53 -0500
Received: by mail-wm1-f49.google.com with SMTP id m22so3809957wml.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhWPq0WpHuEyy9X3jRHVjriWxER6b0QvL7DMjO62ADY=;
        b=e5WAtttcOyKIz7/P+4U5vrTl2HwxDTY8TuCglb3OlZ+KIm9JHhLmOYX/zb968IWuNB
         syVWdQ26qH7cC+5KOVHWPm8hjMTg/IZHNh+8NMOTnwZce/o2VBJuBZWXWUvP/fynAL9P
         mcPiEZkMEujKc8ua1x1dmD2bPBvBCNIRo9rwj3gviG8IzZLG3ed3+dRCUjILlh15k68V
         5O6sGP7YKcKzVlOhNE833hodoG7UAHNT5UXuY9oFO2snF89PPqFg/s9PnHuS2pOQZTm0
         f2X+fwnDe088zx7tJS506EZo05q0xKDKeVSoDdPMPdbrOtm/n5Y+icoOBg+3ZsddLGnt
         xJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhWPq0WpHuEyy9X3jRHVjriWxER6b0QvL7DMjO62ADY=;
        b=CT0AgxQaHs0vHUmgVLqg191fcS8BS4VniXviAgruPrmOWxBVMdhSQcV6VbMyhVY0Ny
         K/9c5Smg9KrZSxSv2NcbZznq1A8+7BjjxqwNIr9aYXj6IB5PDKs2C2ZugibfN+v1I4vS
         R2uDaFWQMP+wkYYHf6HBXs6nkl+R87PGljoGwfcC2iMxguoyEMkQzUJ1F1r3eENzclK1
         xyqrluxcN7MaqJUH8nQ1RG3cVktKVzIIsIkePVxvHD90NG8NHO2fOLvb05smKLWWZSo0
         bBVT7I8r8Y2KKh9eXGdlUMv1tCA0uztzutRqlqr96cqbdreyvPzJWAB4cWnyRGNxL6GV
         tYPg==
X-Gm-Message-State: AA+aEWYph6TRon83KdT0p2yy5JXeKKxO/xmTv6K7nE+8Ftviemw+Z9YC
        bPWsNOJP91mF6PdhcMl+tpISjqyb
X-Google-Smtp-Source: AFSGD/UvrhZz3RIm+CfWJcK0QD1NFDEKYeEk5Wi0AamSLOz6k85qZIYVhOCvJIRew3p+560QSa8/tA==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr3947339wmi.144.1544563309578;
        Tue, 11 Dec 2018 13:21:49 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm1698118wmd.23.2018.12.11.13.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:21:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=1
Date:   Tue, 11 Dec 2018 22:21:34 +0100
Message-Id: <20181211212135.21126-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181211135501.GA13731@sigill.intra.peff.net>
References: <20181211135501.GA13731@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests are broken under GIT_TEST_PROTOCOL_VERSION=1, which as
protocol.version in git-config(1) notes is just the
GIT_TEST_PROTOCOL_VERSION=0 with a version number.

All of these cases look OK to me, and don't seem to show any
regressions or other behavior differences that are unexpected. These
tests are either testing exact v0 trace output, or trying to test the
v2 protocol.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0410-partial-clone.sh | 1 +
 t/t5400-send-pack.sh     | 2 +-
 t/t5516-fetch-push.sh    | 1 +
 t/t5601-clone.sh         | 1 +
 t/t5702-protocol-v2.sh   | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..786f96c467 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -171,6 +171,7 @@ test_expect_success 'fetching of missing objects' '
 '
 
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	# ref-in-want requires protocol version 2
 	git -C server config protocol.version 2 &&
 	git -C server config uploadpack.allowrefinwant 1 &&
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f1932ea431..b84618c925 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,7 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace \
+	GIT_TRACE_PACKET=$(pwd)/trace GIT_TEST_PROTOCOL_VERSION=0 \
 	    git push \
 		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
 		fork HEAD:foo &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..49e5d305e5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1172,6 +1172,7 @@ test_expect_success 'fetch exact SHA1' '
 '
 
 test_expect_success 'fetch exact SHA1 in protocol v2' '
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	mk_test testrepo heads/master hidden/one &&
 	git push testrepo master:refs/hidden/one &&
 	git -C testrepo config transfer.hiderefs refs/hidden &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8bbc7068ac..a9ce050ee9 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -345,6 +345,7 @@ expect_ssh () {
 }
 
 test_expect_success 'clone myhost:src uses ssh' '
+	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
 '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..df7cc2a43a 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -5,6 +5,7 @@ test_description='test git wire-protocol version 2'
 TEST_NO_CREATE_REPO=1
 
 . ./test-lib.sh
+sane_unset GIT_TEST_PROTOCOL_VERSION
 
 # Test protocol v2 with 'git://' transport
 #
-- 
2.20.0.405.gbc1bbc6f85

