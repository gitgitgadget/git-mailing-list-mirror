Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F4C1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757102AbdLWVa2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:28 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34689 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdLWVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:27 -0500
Received: by mail-wr0-f194.google.com with SMTP id y21so30620402wrc.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=SZnTAwMQgeo7yzn3lww3x7uwv32W9QCKEn3iPnFV25YL5AvstevNQqhtUFgaNDMHXZ
         opX9D+jTWYuioqX4h84NSyph97u3aocD/iVV4OdQe1kLItMZR9qmDk3Bz71vv247XEux
         eLFFh0/yHBWZXfV6zyYA1IQEgCGST0CUKNItVmDonYsjxf5x0nwaryJHJB1Snsuv951V
         G17dntbdVSTzEZHMNG0AblFmif3LfDtW/aCQ+jGyFZLeIraWRdaKDNlhILg7uhLoLqC0
         XOiJfZCpJdzqs1HzG5SENJXvSxvXUe6J57+4mgrq2JLuKQoC0LjT4fU2OJwY1k6zMcxI
         2QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=Doqelaqh2JsV0FcJSWrj6JS3z7aY9Xzp0XOrqbBhsIvdFTyaRYgIPQ/pRkYzknvweT
         aLN7lNAckJT9qb2UgaUR4hf23+krKEb94iLV+OWDzwUuAYCdKROdcVewdC0gmpfxoBhn
         4NvhMSwlI/a0iFBfoblFf/b+xwJX22RoaBhf2c6MqPDUhCR3wyc6LeYkXMxZ0QzW7W/T
         Nnrn71TI3SJ0bZ6gmyKBzFxQTvXBvG07O+W0yYPJ3j1LkidYpOUkaxzfeUpwbGpbbj7b
         RjLCDv559OUitEFOXaFqnWoIjIiE4Db2jPkL5a90n9XcXMqFkhMPwJ8xrPd3oR75yiLo
         aKdw==
X-Gm-Message-State: AKGB3mKFpixigkxBaf0pRySG0gILzq2P8XF6ev8Sv/cy/1TokZzU/Qj9
        X1xz/drGXvKL3W0WVmvxAN5Z3TvW
X-Google-Smtp-Source: ACJfBov3McsCfM0d17dNQf7CZ8RDUsAK0AkySkn1rHfWvJg1tps+y+MMbbeUKvFBdjNzGm89nBvdag==
X-Received: by 10.223.184.244 with SMTP id c49mr18355165wrg.18.1514064625824;
        Sat, 23 Dec 2017 13:30:25 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] wildmatch test: indent with tabs, not spaces
Date:   Sat, 23 Dec 2017 21:30:07 +0000
Message-Id: <20171223213012.1962-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
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

