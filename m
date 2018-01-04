Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325051F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeADT1k (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:27:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39140 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADT1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:27:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so5231092wmf.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=PuWCIhe9kv1l2tzMMFzXgjaXH9dVSShsoqGx6PTPDb0EZX34/EHPexq8K0wQfjGdCA
         CJLNp4gEJVOu/sW4cL/VdpJYhs1FwtBZlg5JoZMVwWZcKtEv7Y4oh2y32ePLOR9GSSoY
         cK1sNcHjCCLvBgFSL1ybZbMUlx2YJX0gRJhFuLXmoz8fAtLTlCrz21TRxU+BIFkr/hz1
         cA/CV3wSJSNkqOkTRD7OJzfUSDoZXrxjO5mf8dnWUbp7RiWEzRuIIHDZTsXW1EtzLmcq
         frVzn/95sFY0Tm3Y0EI3cLRo+duIosvm3ruAP3t/67vN9D6MJRXuFXrmkNfU16F04+gi
         1dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=tcYLg5iyiIvjkWhZywn+QvUUD+V3m3DRfaJp6IetmoDlLU9cgKBBSR0DlCDB2EWrKQ
         ZIVKdTSs6qISITvUkHS08oVI+0UOohLBu7wtbmvx0VtNAOPHCyltKlDj2qN0aNIwDTKy
         UcHVjjLzCzI2vWcvKucJhFdcIuoufWVe0kkgPHuDn85lrfbnZixyHP4SRGI1sqmil2Nv
         Se92Xcx2xLwCouMl+W3POBH395Exb7EC4DmHoiA25EOhMkCCLuoSy0MtD8dXO4cIA9fb
         /rSAbs0srzNm5gEluSLmGOh7Cuot5e1jc54b6+6CxVgNuG2MNKCTMUwT6i5KcE9EE+2d
         z93Q==
X-Gm-Message-State: AKGB3mLiSptW3EluulRXF8YAoYTcWHxTf2vQaSyayJLel/87ee7VysT3
        QFgttmjtSHkL7BPutz2Cc/6/zYJh
X-Google-Smtp-Source: ACJfBovEXe01G+KfKcGaFmsAiqGFtaX2J3Evth5BaiQwBzQU4Au+cXTY8bXO+yS8t8F9ul9nIOBVJQ==
X-Received: by 10.28.54.168 with SMTP id y40mr387152wmh.156.1515094057087;
        Thu, 04 Jan 2018 11:27:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm2783838wre.92.2018.01.04.11.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 11:27:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/7] wildmatch test: indent with tabs, not spaces
Date:   Thu,  4 Jan 2018 19:26:51 +0000
Message-Id: <20180104192657.28019-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
In-Reply-To: <20180104115058.GF29210@dinwoodie.org>
References: <20180104115058.GF29210@dinwoodie.org>
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

