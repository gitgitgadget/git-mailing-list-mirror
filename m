Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA511F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbdL1X2o (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:28:44 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43370 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbdL1X2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:28:42 -0500
Received: by mail-wr0-f196.google.com with SMTP id w68so27994301wrc.10
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=aRE5yzWuJruHwaPjcUzHMsfSsK2ZYGiNIylRhXFb0KH8pRXQDFYdHKGvZipRzlpa0s
         yvfN/H8vKYpIkRwzV+UaF/S2GOlasVbfLyq4KG4H8f6vOK0O3YTt2c31dNxhUW+9Zuva
         usQ8MXot90bO8GpMoexSijA97m9dit02ovdQ8pEgMXVZAddhMFkD3CRmvoGjRtx1ceui
         ADriSBpMAXFlMgROwrZDBQ0w0TLcC8lIbaWwGTI53ZnHjA/AfInQvQ5x0ZidQWPnikfe
         5M+DyuQJ6m13G2Q5+y97eekgv7iJ/ezVFiPHlHwWmUyiVnrIRqaak64xVuhU3u1sipCB
         5jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=ieiChlA652XGr1+ZBQm4KkDLSQDjHOniaUiPFLKQ+P/l3BenHeWw64p+X9xW0p7/df
         a5rXi+zIzq9/tR0E6qUlN+StRh2VxzAKtn5nXvcCMr40TX8unCXdYQ7uNKRWK3XdOZXn
         NpOafq4m17uM9ExLWj+xjzl3/lUrkM8JsObLo08+iPoku3QePB06IUizbxF/+re2ybnZ
         1wycoxUAWlW8unpvWiIHrwLESEfUSCmvedn5Ps8dXUrIwTF9ZcTgq2MCoaVs5gBlhu5D
         EjAuGrm7WBrIFsSIfeSpZOFQzvFzP7QzfoUBlE2eZa7x6Lh5esoqkulGA36uqg8tetNc
         tUgQ==
X-Gm-Message-State: AKGB3mKSTkaQw60r9z/sUu+lLXmvk0+MHQhtuwesYX+nW22y8UCuZvqe
        9YISqgvoZXysKXa0Z6J8hFD3ECmN
X-Google-Smtp-Source: ACJfBose9C6VYeGweQfoQzGxPxwuE5EtWjinzY0BNlM18D9cmo5Znn7cupsIZoFp2/8XSo/JkTQS6Q==
X-Received: by 10.223.199.70 with SMTP id b6mr21361326wrh.223.1514503720743;
        Thu, 28 Dec 2017 15:28:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c53sm23187346wrg.10.2017.12.28.15.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 15:28:39 -0800 (PST)
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
Subject: [PATCH v3 3/7] wildmatch test: don't try to vertically align our output
Date:   Thu, 28 Dec 2017 23:28:19 +0000
Message-Id: <20171228232823.14450-4-avarab@gmail.com>
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

