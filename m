Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8651F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbdL1X2l (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:28:41 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33069 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdL1X2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:28:38 -0500
Received: by mail-wr0-f193.google.com with SMTP id v21so29717481wrc.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=JVDSqQy6nemZfpMfie6eJ1MEmQvMVSkjz84B/BveqpbYoFUlp2mP64N2hTf3MSshR5
         32keyNBOb5Qz+RLI1DAWt2HrS3W4PVdwsvrnPhe/U5h3SlGqq9SGslI36vD7d0IHHuRh
         vU/+fxO4SXUQjmVrbw8iXrFC4/B9vRoE5PPBB4dZsz8z/NiaFm8CKMdhr3jB/AcBA+10
         XN126l0HVn/H0cn6HTAHwFfB9xoXWRcGr1KP+xbfLQmqwYayhIdxcUbO2x7ado4FNUis
         hFjR+TiJJOHkT/oofUs4zkpdBvMmz+f4Xo23QgC6F2uh5NQpy2pXdEYTrfEz9LxpKHJe
         TPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=TZeotVs7vdB+gRlu/Pbd6B72t4JhA7/DxjuGsfEJxwlY+tocFX0Oq+60OxXiORndL8
         vjoK2TCfp5axgoByh6BtEkJxIexW6Gs++PpYfv6Jbq8HQlYpflIhsm9Dg6nU7s/2+Jys
         WS/dnbbZgd7ry+F+00Ghabu1IiGKzLAW3b5onbDWj+zxafjwBe5crGVenz8vwHj7H7vm
         bqC96D+NkAiXsGGp+WzrQZ/g03SFZ3o7YTQsdjiCyrWvXP8XVJsHWlfP6TH9ZZCaOpf1
         hhA259ITnTQ4Y/2zE6tA7mFoFKO9Ib79YcYEyOpZMy0wcvRxAWEDXYKhaRjI/2nVnO1v
         yz2Q==
X-Gm-Message-State: AKGB3mI3tStw8c8yZIgjUmkdL/ScUVqhlxYUXClMvnNbzjby8+PeljWA
        IxZ+grzy+H4SZEd6P7kzniV0D5fw
X-Google-Smtp-Source: ACJfBot/wDjhGXxYFV9x8e+zORToAvFFbXJaN6GU9lhNOqesr9TIx7Hl/42KHqmLSeMO4drQZkryDg==
X-Received: by 10.223.156.193 with SMTP id h1mr2914676wre.29.1514503716985;
        Thu, 28 Dec 2017 15:28:36 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c53sm23187346wrg.10.2017.12.28.15.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 15:28:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/7] wildmatch test: indent with tabs, not spaces
Date:   Thu, 28 Dec 2017 23:28:17 +0000
Message-Id: <20171228232823.14450-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171228232823.14450-1-avarab@gmail.com>
References: <20171228232823.14450-1-avarab@gmail.com>
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the 4-width mixed space & tab indentation in this file with
indentation with tabs as we do in most of the rest of our tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 54 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 163a14a1c2..27fa878f6e 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -5,39 +5,39 @@ test_description='wildmatch tests'
 . ./test-lib.sh
 
 match() {
-    if [ $1 = 1 ]; then
-	test_expect_success "wildmatch:     match '$3' '$4'" "
-	    test-wildmatch wildmatch '$3' '$4'
-	"
-    else
-	test_expect_success "wildmatch:  no match '$3' '$4'" "
-	    ! test-wildmatch wildmatch '$3' '$4'
-	"
-    fi
+	if [ $1 = 1 ]; then
+		test_expect_success "wildmatch:     match '$3' '$4'" "
+			test-wildmatch wildmatch '$3' '$4'
+		"
+	else
+		test_expect_success "wildmatch:  no match '$3' '$4'" "
+			! test-wildmatch wildmatch '$3' '$4'
+		"
+	fi
 }
 
 imatch() {
-    if [ $1 = 1 ]; then
-	test_expect_success "iwildmatch:    match '$2' '$3'" "
-	    test-wildmatch iwildmatch '$2' '$3'
-	"
-    else
-	test_expect_success "iwildmatch: no match '$2' '$3'" "
-	    ! test-wildmatch iwildmatch '$2' '$3'
-	"
-    fi
+	if [ $1 = 1 ]; then
+		test_expect_success "iwildmatch:    match '$2' '$3'" "
+			test-wildmatch iwildmatch '$2' '$3'
+		"
+	else
+		test_expect_success "iwildmatch: no match '$2' '$3'" "
+			! test-wildmatch iwildmatch '$2' '$3'
+		"
+	fi
 }
 
 pathmatch() {
-    if [ $1 = 1 ]; then
-	test_expect_success "pathmatch:     match '$2' '$3'" "
-	    test-wildmatch pathmatch '$2' '$3'
-	"
-    else
-	test_expect_success "pathmatch:  no match '$2' '$3'" "
-	    ! test-wildmatch pathmatch '$2' '$3'
-	"
-    fi
+	if [ $1 = 1 ]; then
+		test_expect_success "pathmatch:     match '$2' '$3'" "
+			test-wildmatch pathmatch '$2' '$3'
+		"
+	else
+		test_expect_success "pathmatch:  no match '$2' '$3'" "
+			! test-wildmatch pathmatch '$2' '$3'
+		"
+	fi
 }
 
 # Basic wildmat features
-- 
2.15.1.424.g9478a66081

