Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7ACF1F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbdLYA3C (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:29:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38884 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdLYA27 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:28:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so30168666wme.3
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=dyoECO6aRWRvwWhsA2eDjHtJXyFHUQ8zs4TLNW2zuJjHOcTcOczvtA1YwN3G61Ac+Y
         J0GJ7ZZKRkCUDGbZncjXo3plK5XW87Oy1ZNJZB5Ao0vh4020L5Om9R0DzCt3VQGT+JHP
         oX7FnRZDzdW2WXbnjXc2KAotUhvXocCmqPG3520iFc5YR+JyqSBdRVFnS4bocxYbmIMA
         Mv5nbVj62uDCOVlgMp5+V+/d42UDtANlaiMoYbhu/6ZlTsbjtwImjv9SXGV78NpIpbNm
         VejFvNRZe5exGX2dwor4sVPxVgWbwOKmKIB2L8K5k/gLjlEYnGGtrFJP0n3Xm77APAxk
         Yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=dm8+d5JXYuoY8eDKdM4FVcKdFjiAZ2pelTFC772cSfnmXDkLti3bkFxghijSz3AuJY
         JrjoDRxOs0pgW4+d+jOL1kMvoyFK4DTfC4jLSc1cOv2Zuy7AZtLtf6ISHwsDgd3rAY4e
         OKJpoPy32JJFkIexhL/SqS4dYpyHsbOiNNTtkWpk+y2iosKMAY6cBBB0V1ThHXjTswGm
         JxuSUkKxY3uGcM7K2SyTDzxeZz9t2ihVjpI5ZCpzPGUXokPx1UEaUEhnfeHDiLOlPyo9
         ydHpDaMpqhH84NW8ugnMwuM6VAL39jtL8T7ES8t2fDcgMgWo3I1L1QHEkVTPuiRjymoQ
         qt8g==
X-Gm-Message-State: AKGB3mK3IT34B1+ohzcCoIZt+Zdc+qJMns2dhQDcy4DEsb8WqcTqZhFL
        Uk4FprAYHawg5hTJc4JPnDrWi2CW
X-Google-Smtp-Source: ACJfBosj5LtHL4P3QnMSB5su59G20p5AjzFBtQoQ2731geUKSq4A5So/cwMOQYS7tSTVNgd/WB4Qvg==
X-Received: by 10.28.210.8 with SMTP id j8mr17012915wmg.159.1514161738302;
        Sun, 24 Dec 2017 16:28:58 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:28:57 -0800 (PST)
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
Subject: [PATCH v2 3/7] wildmatch test: don't try to vertically align our output
Date:   Mon, 25 Dec 2017 00:28:31 +0000
Message-Id: <20171225002835.29005-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't try to vertically align the test output, which is futile anyway
under the TAP output where we're going to be emitting a number for
each test without aligning the test count.

This makes subsequent changes of mine where I'm not going to be
aligning this output as I add new tests easier.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4d589d1f9a..19ea64bba9 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -7,11 +7,11 @@ test_description='wildmatch tests'
 match() {
 	if test "$1" = 1
 	then
-		test_expect_success "wildmatch:     match '$3' '$4'" "
+		test_expect_success "wildmatch: match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
 	else
-		test_expect_success "wildmatch:  no match '$3' '$4'" "
+		test_expect_success "wildmatch: no match '$3' '$4'" "
 			! test-wildmatch wildmatch '$3' '$4'
 		"
 	fi
@@ -20,7 +20,7 @@ match() {
 imatch() {
 	if test "$1" = 1
 	then
-		test_expect_success "iwildmatch:    match '$2' '$3'" "
+		test_expect_success "iwildmatch: match '$2' '$3'" "
 			test-wildmatch iwildmatch '$2' '$3'
 		"
 	else
@@ -33,11 +33,11 @@ imatch() {
 pathmatch() {
 	if test "$1" = 1
 	then
-		test_expect_success "pathmatch:     match '$2' '$3'" "
+		test_expect_success "pathmatch: match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
 	else
-		test_expect_success "pathmatch:  no match '$2' '$3'" "
+		test_expect_success "pathmatch: no match '$2' '$3'" "
 			! test-wildmatch pathmatch '$2' '$3'
 		"
 	fi
-- 
2.15.1.424.g9478a66081

