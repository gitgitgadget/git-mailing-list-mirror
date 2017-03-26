Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084F820966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdCZCqj (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:46:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33384 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdCZCqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:46:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id p189so4078739pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akdNgP9CTOvQaRVrFyL/6OSatV8UOoYjFf6taERJCPY=;
        b=cMACvvUxDU5ekL4nZr0qFHwCDCEbBOEEVfd/4GA4Uj5DbaJEumV/lgxq/72P5PR03N
         o0at2bYcNC55A80g0qbQqQ5oUBOgm0+5UH47tKBiWta5Z9+Hpn70GIIVQGDsfm8ydeR8
         O5M5aLeAJg6+E0zn0lX/e8KHYpyzqsL/Lp7fUn5ptfzVvLTcsiBb9sv7qY5BxFdp0TBK
         OEu6eGZ+r4fnRTgIXshtKRniZonj9Wxys+d0tvRcnN/XZckjub73eDY+/SChgOv5ElnO
         l/kAI8YLEb1cPZ9H4Sz9QJlmAXjJHwcvu0oLrvGYEiQwEU1tMWxFMXu8gy9TnOJowX75
         NGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akdNgP9CTOvQaRVrFyL/6OSatV8UOoYjFf6taERJCPY=;
        b=LfxW1z/wJ3aodiVdCoYjpWQRuhAMLUNWQhkibimj+yN/kwkL93wX3P5J9fp3yPUwwJ
         np8hM97Q8do7rrUGDUGOIZPSkiHYSHs8ZxQD7gtY3wfrWC4ftC5oowDE4uLw30C/a0GL
         vcr4Zzg/Xxp/YsNrAtZfzvGp+SEIQYNU3cULXa851e1tC8dgKMF9Tc/c21SnDU7oGQWe
         JOFq2n8hSLSNz9MWWVPVxSax0+L73o+UZFSlT6IC6IGvsmIxtUpTxPrTbC4x87PlYIQN
         TxSZQn+3cO8NXfx7VOKratcJSzL7OuxWgOPaKRIJbIPjlDvFUpQYO9D3EGVYGgRVmvZP
         7NMQ==
X-Gm-Message-State: AFeK/H2rcYNACwyEiZ1nCgsoUKUyThK1DOk9qiidRn10szqpMoUYfvIUVeC66iW9wIdx6A==
X-Received: by 10.99.114.16 with SMTP id n16mr14096410pgc.230.1490496344062;
        Sat, 25 Mar 2017 19:45:44 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id s26sm12820717pge.33.2017.03.25.19.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 27/28] t1406: new tests for submodule ref store
Date:   Sun, 26 Mar 2017 09:42:40 +0700
Message-Id: <20170326024241.31984-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 t/t1406-submodule-ref-store.sh

diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
new file mode 100755
index 0000000000..22214ebd32
--- /dev/null
+++ b/t/t1406-submodule-ref-store.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='test submodule ref store api'
+
+. ./test-lib.sh
+
+RUN="test-ref-store submodule:sub"
+
+test_expect_success 'setup' '
+	git init sub &&
+	(
+		cd sub &&
+		test_commit first &&
+		git checkout -b new-master
+	)
+'
+
+test_expect_success 'pack_refs() not allowed' '
+	test_must_fail $RUN pack-refs 3
+'
+
+test_expect_success 'peel_ref(new-tag)' '
+	git -C sub rev-parse HEAD >expected &&
+	git -C sub tag -a -m new-tag new-tag HEAD &&
+	$RUN peel-ref refs/tags/new-tag >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'create_symref() not allowed' '
+	test_must_fail $RUN create-symref FOO refs/heads/master nothing
+'
+
+test_expect_success 'delete_refs() not allowed' '
+	test_must_fail $RUN delete-refs 0 FOO refs/tags/new-tag
+'
+
+test_expect_success 'rename_refs() not allowed' '
+	test_must_fail $RUN rename-ref refs/heads/master refs/heads/new-master
+'
+
+test_expect_success 'for_each_ref(refs/heads/)' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	cat >expected <<-\EOF &&
+	master 0x0
+	new-master 0x0
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'resolve_ref(master)' '
+	SHA1=`git -C sub rev-parse master` &&
+	echo "$SHA1 refs/heads/master 0x0" >expected &&
+	$RUN resolve-ref refs/heads/master 0 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify_ref(new-master)' '
+	$RUN verify-ref refs/heads/new-master
+'
+
+test_expect_success 'for_each_reflog()' '
+	$RUN for-each-reflog | sort | cut -c 42- >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	refs/heads/master 0x0
+	refs/heads/new-master 0x0
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'for_each_reflog_ent()' '
+	$RUN for-each-reflog-ent HEAD >actual && cat actual &&
+	head -n1 actual | grep first &&
+	tail -n2 actual | head -n1 | grep master.to.new
+'
+
+test_expect_success 'for_each_reflog_ent_reverse()' '
+	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep master.to.new &&
+	tail -n2 actual | head -n1 | grep first
+'
+
+test_expect_success 'reflog_exists(HEAD)' '
+	$RUN reflog-exists HEAD
+'
+
+test_expect_success 'delete_reflog() not allowed' '
+	test_must_fail $RUN delete-reflog HEAD
+'
+
+test_expect_success 'create-reflog() not allowed' '
+	test_must_fail $RUN create-reflog HEAD 1
+'
+
+test_done
-- 
2.11.0.157.gd943d85

