Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E0A2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdCRCH0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33022 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id p189so4800866pfp.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akdNgP9CTOvQaRVrFyL/6OSatV8UOoYjFf6taERJCPY=;
        b=UitWGkbonC5BALgucia6Eu9KGFolR35H8agCUrIOxmQyXRvMzcqPkSehBoaIiVgITe
         LtjEZHLqAHaS0w0+k9RpDCx30300tlNLMaB4+/f+7rz2J/aJvNtAphu/sTL3bd0ihy1n
         d4b3PsWqrL2uV+0llPvwW4MgLJTx6dgOREoe3mGAiOAStfZ5/mwTq0Jgq2Hq9Z5k3gvk
         z7NI3FgOps+WrHUUrJOxuREFVVdbUdQZ9pUV1bLpJd163bPh3R1ItWTLGZPe60vua9S5
         i1D1vnMF7aNooyV+KivUSwNutfK2zbxifpgIvURgKzM19sbL1TP1OaVpFeoranmhC005
         jMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akdNgP9CTOvQaRVrFyL/6OSatV8UOoYjFf6taERJCPY=;
        b=RsrxOXPbHLohNwzI6Q4Pf0XL88QRci0Bpf0S8nt0PjrQLQoj1rA+3nyd0y9aOc874C
         LRGLwpf7gHEwd9uopESqvnoe6tL9Quqkp+2g0Sxih/rQ8gTtbppilSBELp/Wd0x22Egr
         tY4czr13ovS7LDp+72wV5jN/JgtSx9Jx8cGd/WXTSsdDr6b2Pzj8NCNsp/wbUoQBNmBJ
         JQ93RqbefM6bqbc2IXDambI1bvEjxMz+eiFfWU3UhFk572CqMNIh4FTEpFjEaRzhEx0U
         Xh6+AKiZ8MAVzGjCJJ2HCl0eSy24cozI1lE9XGcS8+6eQKAQWhpEAeUiXdr/NdtFwLwn
         Zlng==
X-Gm-Message-State: AFeK/H0kHCAecz4lRiAEyZGdIfmsMWQH2VWDe84u/7ih31+bpPHxXlaOLD4Y4dA/nKiA2A==
X-Received: by 10.98.142.1 with SMTP id k1mr19623821pfe.98.1489802803572;
        Fri, 17 Mar 2017 19:06:43 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id e13sm19279542pgn.38.2017.03.17.19.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:06:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:06:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 26/27] t1406: new tests for submodule ref store
Date:   Sat, 18 Mar 2017 09:03:36 +0700
Message-Id: <20170318020337.22767-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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

