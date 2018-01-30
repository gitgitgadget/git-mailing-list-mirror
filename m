Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86CB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeA3VVo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:21:44 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52243 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeA3VVm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:21:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id g1so4012174wmg.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=bu1INWwIEduTcAWKzXmeXtfoP+KBmIRcIm5gGkw753n3R0+uYD16YnKeynM/q/bOzp
         aCBrK6+jEgpD50HKZYHcgybczKne2YG3FGktRxSQ+K5arFj9odi+tKW9/OKk0wKxSAtT
         iAG806UIvg6STKnJyUc4IRJMMbOfYQmGOcRhj0PFUmM1hVw/XLdj/kTqHsgJoj6z0toI
         /XDQ2NXKObc31Jh/SlXWn3SkT3OJJHs4VDfCQgN/8/yLk9Yfp/7u7OP1875UoDuhva4Y
         BWKXiOG1cul9MdAJRYT9mIW6zce3hBDQtLLfrVOOFHeAMaR5qp6u1Us4Ln1AS1b41Dc8
         h8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=WOXNONkARoK8Wj1fuwkJ6x47nZ3xx5Nj8FB+yRb9i+3kp3BXaU29LcvQwnbJtR1JHP
         n6c6gZbqx72ps4UglOKeWyjAxU5sE1kNQRfX6ld4mlCNHAGSmJot0LmW6/e53YfF5+Uy
         TWawU688JpLJCwSgW/ncJhgFwxG7Qh6RTbam+O5c+GBCK10e9WpF1p3r539YESjqfajT
         2mqPSTMiSA6cDj/InwdqZc11Vr8ochOISQWu0Ptdg1r8RwJvNh6OszOsDWOg9ULyhZlE
         3of+VQSxNuSmmlgDrKXuzcfL08jtdATdNhV6TFZsOdXsi9mPHC5QCBPGgY3a9SgvYKFq
         RZIg==
X-Gm-Message-State: AKwxytdQrQsiVvo9jx59jnDRfFXw9BWUflCGrJWy14BIIh7D3GKmmnq2
        IsW2mCzxqTmvLXFui3dCU5mzmyHH
X-Google-Smtp-Source: AH8x224z3f823bMNF/glZBZ3oSTZk8BstRSZCTfCd647Zifir67Awc2RLeyWlE0USqlnZf4xD9CcdQ==
X-Received: by 10.80.146.87 with SMTP id j23mr52394494eda.53.1517347300650;
        Tue, 30 Jan 2018 13:21:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:21:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Kyle J . McKay" <mackyle@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/10] wildmatch test: indent with tabs, not spaces
Date:   Tue, 30 Jan 2018 21:21:15 +0000
Message-Id: <20180130212124.2099-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180130212124.2099-1-avarab@gmail.com>
References: <20180130212124.2099-1-avarab@gmail.com>
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
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

