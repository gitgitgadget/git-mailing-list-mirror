Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A389620281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032796AbdIZX5E (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:57:04 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:51980 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032779AbdIZX5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:57:01 -0400
Received: by mail-pg0-f45.google.com with SMTP id k193so6778318pgc.8
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbYS41PUYpBE1jSNkxE3ijCgUHCgj7pbj4dz7B+x90M=;
        b=OBhPOX8pw+QsDu9Fkg/e05DFMuMkV3ImCR7MnZdVEB7chLno3vsZPFfGbR5EKduxDY
         HMGtPrxg7xyahOGKesoQa96dnkjzIMwhPoCsqsmwTwXjcR5H1/vSyGs8R7JyEF3Ou3Sk
         3PWJb4XPuSzxm94aEGHxVUjHohjFeLh5IOB6DqIxJr4wvQQPpqmUJ4thhVDB2ufV/iGv
         fhKWXOWVqFrYQpPFDiWAAuSpCIrVFZC8ZaGrkPwSUv2rHsk2OEmvXTDv84nbMJ1BX9oB
         CqYhF2humVhLanuGYyiWiIZwAzczJJkVd+2wBXLUMbsD+u2zs0gYcmd5P/EcAF6zswvV
         A9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbYS41PUYpBE1jSNkxE3ijCgUHCgj7pbj4dz7B+x90M=;
        b=ma7Us4WxXNaPttIuYmoFirdNFmUiMGq1Don+sRHKh27qsIoaQ8tOQ3Fv8Vxx+M302C
         IKnHSUROXC+U/uYDbCeOke8aJRaMjIm4B7VGNiAoXdFRyqm1elq/lMA7prxU8X6Aztji
         WhM0ZomrZ322dyC4wktgfOGok2gR7DYU4KfDMALV3ISkjYYAajY2oJh1n/d8OkyEnPR0
         kE3dkTqoLbCWeW0zrHsxQTEZtfi89o4OhGWecklTgH+AGw6cJRPFlYRreLe0hQ2Bvntc
         jDWq8TeH1CK8JRH+JmEibB70zxE/CBd3K+wicZNlY1lH+wjBk/g/B+E2g7rk1xj2ljR4
         LW4A==
X-Gm-Message-State: AHPjjUgj2d1nscuawvpWFJ77L/3cMRzzNd9GTFLzheRoYOrqkPWz0sSZ
        uSiNdlF2xJxvijszS6OsMYVJHARAx1g=
X-Google-Smtp-Source: AOwi7QCeawRDUpeYtS84UNrMgZXxZYFYgLiPfaGlD+hC1Xd6VDSG+dN4wBLVTqLq+vZ8prPcU5k/ag==
X-Received: by 10.98.82.71 with SMTP id g68mr12240565pfb.125.1506470220144;
        Tue, 26 Sep 2017 16:57:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 9/9] i5700: add interop test for protocol transition
Date:   Tue, 26 Sep 2017 16:56:27 -0700
Message-Id: <20170926235627.79606-10-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/interop/i5700-protocol-transition.sh | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 t/interop/i5700-protocol-transition.sh

diff --git a/t/interop/i5700-protocol-transition.sh b/t/interop/i5700-protocol-transition.sh
new file mode 100755
index 000000000..9e83428a8
--- /dev/null
+++ b/t/interop/i5700-protocol-transition.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+VERSION_A=.
+VERSION_B=v2.0.0
+
+: ${LIB_GIT_DAEMON_PORT:=5600}
+LIB_GIT_DAEMON_COMMAND='git.b daemon'
+
+test_description='clone and fetch by client who is trying to use a new protocol'
+. ./interop-lib.sh
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+start_git_daemon --export-all
+
+repo=$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo
+
+test_expect_success "create repo served by $VERSION_B" '
+	git.b init "$repo" &&
+	git.b -C "$repo" commit --allow-empty -m one
+'
+
+test_expect_success "git:// clone with $VERSION_A and protocol v1" '
+	GIT_TRACE_PACKET=1 git.a -c protocol.version=1 clone "$GIT_DAEMON_URL/repo" child 2>log &&
+	git.a -C child log -1 --format=%s >actual &&
+	git.b -C "$repo" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+	grep "version=1" log
+'
+
+test_expect_success "git:// fetch with $VERSION_A and protocol v1" '
+	git.b -C "$repo" commit --allow-empty -m two &&
+	git.b -C "$repo" log -1 --format=%s >expect &&
+
+	GIT_TRACE_PACKET=1 git.a -C child -c protocol.version=1 fetch 2>log &&
+	git.a -C child log -1 --format=%s FETCH_HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "version=1" log &&
+	! grep "version 1" log
+'
+
+stop_git_daemon
+
+test_expect_success "create repo served by $VERSION_B" '
+	git.b init parent &&
+	git.b -C parent commit --allow-empty -m one
+'
+
+test_expect_success "file:// clone with $VERSION_A and protocol v1" '
+	GIT_TRACE_PACKET=1 git.a -c protocol.version=1 clone --upload-pack="git.b upload-pack" parent child2 2>log &&
+	git.a -C child2 log -1 --format=%s >actual &&
+	git.b -C parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+	! grep "version 1" log
+'
+
+test_expect_success "file:// fetch with $VERSION_A and protocol v1" '
+	git.b -C parent commit --allow-empty -m two &&
+	git.b -C parent log -1 --format=%s >expect &&
+
+	GIT_TRACE_PACKET=1 git.a -C child2 -c protocol.version=1 fetch --upload-pack="git.b upload-pack" 2>log &&
+	git.a -C child2 log -1 --format=%s FETCH_HEAD >actual &&
+
+	test_cmp expect actual &&
+	! grep "version 1" log
+'
+
+test_done
-- 
2.14.1.992.g2c7b836f3a-goog

