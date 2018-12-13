Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7413120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLMVXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:23:18 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:41849 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:23:18 -0500
Received: by mail-qk1-f175.google.com with SMTP id 189so2045347qkj.8
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAYvLtf3VJvJ1Ihji1kTezPQvD1wgjn9L/1A5XuVHDM=;
        b=idZ1giwdlY8BRlM6/3pdIWB9ofi8nR+tzolyhpxq9eMpZG4toCJxCeRCoO0RvQJKb/
         Ehqi1F7oqDBCctUUUY548VMTGiOfnZQsgx19Lr5oRfgDZMayDfOcT//szimagQTObh7N
         N9Zv+rAUNY8QsAK0lKXSL66WrBg8EfQn3TGm5N5BOVXTwNJW3+slp5R9bxtPjb4jLVsO
         o7gbyTu+B/fO+MiBoZQURzbhrz+ExvSQnOLjTxCeJz8Q2mmjmtRsqgpTv51JPkftciaB
         mrY5ojMmJaNil07DgVptHB3rhjpXZ+NpF0xkCRNpOUD32XbbKvEuU8/zdwu/hywPKtsy
         2KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAYvLtf3VJvJ1Ihji1kTezPQvD1wgjn9L/1A5XuVHDM=;
        b=Yxcxl+nTmnVj4mAvZerF6Mr+UTgU2SSUUdwe9XTSlzlDuYNXCUrYj0RFEcol157t1N
         wcPlx2CmSe/Y2KWXyHdtuxaABQzEA+hYFdvJwbiBuEmcQtkgFYBZ5ej+LprIx95nOJ4d
         aeeMaIozxWBE7l3MA/zu8+tHL21zP6RWB43PGU9zE7f1XqIiuJh2J5IOHtw0cWPtWXO2
         UOAG5bxd0IadTEDLPuovGLW4Zwl0+00qFQl2UBdkHI0NF5oLuJ36lFiNJexBqhN5eWqr
         E3HFrBvfbMNA95Kpwrp8woUAhSqt1OIOe8E2QpIrZZV7EAosWL5KSdjYRI5OEnW6wodO
         FLwg==
X-Gm-Message-State: AA+aEWbQjNRkgqi77l/XUwAMIhRPPdqjTTKgvGdiM0H4+3IM/KeyQ2sP
        coc7dLtP9PcbaR7ofE4nrwvGovmf
X-Google-Smtp-Source: AFSGD/W2ot2Xlm20eij8/ehUGp2RR00hW79ZPhOJPH8UtV7S5J1BSMsHnTK/lLWVaMd3zYwyTt2Ojw==
X-Received: by 2002:a37:ac05:: with SMTP id e5mr418904qkm.102.1544736197035;
        Thu, 13 Dec 2018 13:23:17 -0800 (PST)
Received: from localhost.localdomain ([142.154.219.74])
        by smtp.gmail.com with ESMTPSA id f13sm1552840qkm.52.2018.12.13.13.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 13:23:16 -0800 (PST)
From:   John Passaro <john.a.passaro@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net,
        mgorny@gentoo.org, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH 2/4] t/t7510-signed-commit.sh: test new placeholders
Date:   Thu, 13 Dec 2018 16:22:54 -0500
Message-Id: <20181213212256.48122-3-john.a.passaro@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213212256.48122-1-john.a.passaro@gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test that %GR output ("Raw" contents of "gpgsig" header) looks like
ASCII-armored GPG signature.

Test %G+ (Y/N for presence/absence of "gpgsig" header) by adding it to
existing format tests for signed commits.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 t/t7510-signed-commit.sh | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 86d3f93fa2..aff6b1eb3a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -177,8 +177,9 @@ test_expect_success GPG 'show good signature with custom format' '
 	C O Mitter <committer@example.com>
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	73D758744BE721698EC54E8713B6F51ECDDE430D
+	Y
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
@@ -189,8 +190,9 @@ test_expect_success GPG 'show bad signature with custom format' '
 	C O Mitter <committer@example.com>
 
 
+	Y
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" $(cat forged1.commit) >actual &&
 	test_cmp expect actual
 '
 
@@ -201,8 +203,9 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 	Eris Discordia <discord@example.net>
 	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
+	Y
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -213,8 +216,9 @@ test_expect_success GPG 'show unknown signature with custom format' '
 
 
 
+	Y
 	EOF
-	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -225,11 +229,27 @@ test_expect_success GPG 'show lack of signature with custom format' '
 
 
 
+	N
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" seventh-unsigned >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'show lack of raw signature with custom format' '
+	git log -1 --format=format:"%GR" seventh-unsigned > actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success GPG 'show raw signature with custom format' '
+	git log -1 --format=format:"%GR" sixth-signed >output &&
+	cat output &&
+	head -n1 output | grep -q "^---*BEGIN PGP SIGNATURE---*$" &&
+	sed 1d output | grep -q "^$" &&
+	sed "1,/^$/d" output | grep -q "^[a-zA-Z0-9+/][a-zA-Z0-9+/=]*$" &&
+	tail -n2 output | head -n1 | grep -q "^=[a-zA-Z0-9+/][a-zA-Z0-9+/=]*$" &&
+	tail -n1 output | grep -q "^---*END PGP SIGNATURE---*$"
+'
+
 test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	test_config log.showsignature true &&
 	git show initial >actual &&
-- 
2.19.1

