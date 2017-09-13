Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28B420286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdIMVzY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:24 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:47848 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdIMVzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:13 -0400
Received: by mail-pg0-f44.google.com with SMTP id d8so2792197pgt.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edVIq0YiyYlUiS9do8Of8Pz5xSJteX0LD5xUmyZ8E5g=;
        b=bhwzvMFBEOgfhF+fb62so7PkgcmFJ1S1tiIaso0vXOVatD4mh17IuDImvuhI8G9dhj
         9VGnT44+HiN3riOB1MhgVNwQm4QWEpyT5mstGwAxIGujc8RpA+42HvlIXOpv1ruIY3Kt
         4ketvIRaRKV008vyHSHljy3qGrtfGnQcfqvsKYhnIrCuKHAyxv0xe+QC/iuo+JDexCwn
         Ut/PKh/mnE8dJFEkdNQwzPoeJ6GDMTZ6JJCpJzUa9YD+8ZfLqHIXH8ZbbnERYI7R1OpQ
         lSehEjj/w0rHciZH27ngTZpJNuLlw1E+ii7u0TzpZUIShyVfghcP0i99+2qtWnHaXTQH
         f7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edVIq0YiyYlUiS9do8Of8Pz5xSJteX0LD5xUmyZ8E5g=;
        b=gkPbSm7NFfUPUkNvMr4NcU0i9gOSWisn50g8XO99iD9KC1/Te7NM9UfX8gtYdlzZZB
         ig6coK0T6yJBRcurUJ9XJrQf80GEKUhZ1slhJRWDeYnHH9rJ7CVZbxMe2dXvYm7QNbEc
         xOjKaCqe3kThaoV2kLQz1CmFjAO650Iq8dGwX+fE7jgJTwb9MrxhCx+fWkkz0Vcgo0s2
         wIvlcQMxRncayZwVut8Zfy58QyIeBWxxdhOkbOmS2XydJE1tAmtqXULFWUhhtCZBvRHG
         QfeQPqZHTtI1h1p6jP8NSiNnPcdZnrZKhEMFw/08nBx2UaiLBoJ2oHswygB4yQZauM1y
         53vA==
X-Gm-Message-State: AHPjjUjoX6/fLA96bWxql52XQVCzEjc6cBl/d6FplV+moChx+74R7u05
        CdgMFxN/cVGttNzbKJ626g==
X-Google-Smtp-Source: ADKCNb4ZlWJyZSKyLwIjeFDJpCbvsUefcdd0mvIhlLGzcD2w6ErGWTwo8VcO76Ai/KumpPlPkqgHHg==
X-Received: by 10.99.100.131 with SMTP id y125mr19396373pgb.161.1505339712389;
        Wed, 13 Sep 2017 14:55:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 8/8] i5700: add interop test for protocol transition
Date:   Wed, 13 Sep 2017 14:54:48 -0700
Message-Id: <20170913215448.84674-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
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
2.14.1.690.gbb1197296e-goog

