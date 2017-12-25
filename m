Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032491F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbdLYA25 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:28:57 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34692 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdLYA24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:28:56 -0500
Received: by mail-wr0-f196.google.com with SMTP id y21so32183288wrc.1
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=IoAOg40QhDcP+LOdRs1xg0Ex+VseI2pcQKc4tVULuRzH1bLArcFFSCIF5KK48j70ke
         faizxkkzhuWGnucm5vw1HIrYvTINs5jBUcDYS1hY9kxTD8qgxSvIYcb4hYmz6yDk4IGe
         v09SfIU2n5H5tLu6jwKvBDNrzGSvnHszHfTnX9V1yg+TSAoXsCqcIyet3PjifplyqQWu
         7D5IdU3K9R7viMaRt9N5Cr5XPT0q3AHUDcoI37Yk7EB3+Pz4wPoKZEqS/c2vJLybtVB8
         yew8teH16RWc/wFURMM6dFHcawxTuVraOvN89pR648u7og+Q4gI7rMQ/cLXwTBO8AlAP
         swxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bnxCSziDZnIEC+a+RP5ZFj2QllK9DvCDpVF8KVbO19M=;
        b=Pn0MW4FofpA+GZqYGOsFzQL71NJiW8bfbNTVHqB+l7+oZZSX9N4WMGV5KLTi7ENmjZ
         DXEVHnbHUpWXfm9GhZgxFgEs5Qu3ymCuuwZhBBJ8tWl1hz5Yoec9Ku5iHq8K6k47TdlA
         KlzJGwSmGiRMBB9HixM2O4em1SHvjQAXOu8u4vN7J5FwI2/Ncrwb7kieRDrbhjdTyJ8Z
         YNpHot5FU79Sr9aAnLh31kWfL4PcTrYu9A0TiOjtfYcLuNksvsZBhW1VTrzUk5F4Eehg
         +oMjwh/MQCjSu6Wl3CzDDbmGgf9w2VI1kcOe2Y5O9Od93DkEgfp9lELBHqaAvDACvmbd
         I5sQ==
X-Gm-Message-State: AKGB3mJa1sNwpHvU8fSHOdZgaFZcqGWzr8DFb/f05wEDfK6gxHmMaWnE
        Utxgc8fKgcqxG2FOO0IWtSuAMMtC
X-Google-Smtp-Source: ACJfBoub3jmDncNx5iH1hNUC8lqIuPVjMb9vDNYo5P8qI4sy2xxtaiK4Nu8hkGbpkERbHnpzNn7RYg==
X-Received: by 10.223.136.13 with SMTP id d13mr21664756wrd.76.1514161734709;
        Sun, 24 Dec 2017 16:28:54 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:28:53 -0800 (PST)
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
Subject: [PATCH v2 1/7] wildmatch test: indent with tabs, not spaces
Date:   Mon, 25 Dec 2017 00:28:29 +0000
Message-Id: <20171225002835.29005-2-avarab@gmail.com>
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

