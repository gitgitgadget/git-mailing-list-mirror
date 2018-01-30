Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CD51F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeA3VVt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:21:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50669 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeA3VVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:21:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id f71so4043355wmf.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=JbuW/R96qxYyRkf6E91Aj+grOH2o3u5tW6DznKH3E1MBZRIbDT6hUAYb5wtKJLVgVf
         pimNdaJPrJfc38pV14X6MUhHU/ZeWfbFy33SO0iSy/fp9zuxLKH5byCK/88G+VhQC6dN
         05DCSCqELBCd8YoArM64FFg9zUGzGhhBJlJEizaLmeg5i5WmUKh3s42vv/6HjNwCk42q
         jStWZNCaeTaW2kBC+pTqjlK0Z7ggM70OA5MS6Hh133Zot0DgFDsRqh/hVCtkeI8d26h4
         EUWQZ3ts68WsNYvoYZ+K36wvEvOn9cGOrgdW3NMcImNSYEvVQnAG7qv4BNdCn2VzZyrs
         n5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=hhXvaIbe2n5uTK6oIDb6XF/pMPsCIuYzQO239HxnjPNTUThgrAvcbyTg21GnibSusq
         VQ2ZoJW97lfRjfZP7fpA09tovBj13xYw8NjWpmBtoY/NeNukRM/heIATMJ8zSc5Hm4yr
         gN6Yy+2OQk54u/F5Ax1TeCaaDosCVaNvLzwKBl7OdldQ9EnKHFM2N8aot/O7/EVgkLG+
         UDvb0DkK1AKpMZj1HsFWb1HjE87Q53U0gBUkj/YohV3e8UJtD2pZeTJ2OzF7UZHO3P0X
         ZV48OvByfqjpBedCdUSC9rTE0y98+USZ2iNp4rJcflVywqk7Pyo6mPnTWAYe2byEE9n1
         tL7g==
X-Gm-Message-State: AKwxytewNFapA8vXyT28Pl+Fox8ze6wmIimqc0Lt5XoxInpHewdkQ/BU
        0i7ZvT6jLs7JKv4gQ1ioLndaSgz/
X-Google-Smtp-Source: AH8x227N/stsZO6+nSOSN/99Dw/Yoviu2TooEJdgepM4P3KQHUbA+QvOMKbqHjrKcZxLde08O5E70g==
X-Received: by 10.80.180.184 with SMTP id w53mr27697621edd.149.1517347305067;
        Tue, 30 Jan 2018 13:21:45 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:21:44 -0800 (PST)
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
Subject: [PATCH v5 03/10] wildmatch test: don't try to vertically align our output
Date:   Tue, 30 Jan 2018 21:21:17 +0000
Message-Id: <20180130212124.2099-4-avarab@gmail.com>
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

