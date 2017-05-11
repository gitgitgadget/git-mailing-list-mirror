Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3310C1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755193AbdEKJTY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34210 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbdEKJTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so5504052wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0ktaPZ3aFyCQi8mS/t/SXgrhBY7oOmKZMCMNrhzqUc=;
        b=RF8IzdC/ni7Fi6z4+aCwHjWgWqW0SymcCHm2akXNvYmEAJma3zTOUDCEn3sSa60g5I
         i5xRV39sfKTEjR7E9ePysni6DQkLkEeoxB+vYhaxkTaZKdg3iLJKNo3Fve2VxZY+yY9m
         QyAV3rD3FcH/iyu0pBGKC66xgZvy1nGi01uwiuMOSwbXJpNbDe5syVvezMGlpdg8MJhk
         QpTiMi6KAKBfjnhr5wr2iz9eu2V/V5M6XgCKbc5LVdbyE5eDDOuhUKoiq6M8RNDZrA3q
         SmboUQb5PFdRTHiZtNQMhnpHrb4dLaPZtPqhzBzZPWim2Olatc8+Fqm/NjhMlosYJHo0
         0b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0ktaPZ3aFyCQi8mS/t/SXgrhBY7oOmKZMCMNrhzqUc=;
        b=BQ18mUk0FchdjMMIxiycrGtkOYPHKZm5ORN2sJ3/EArgt+3NDVvkAr+tMabcccZ9AS
         33u3UMhYCW/WEGIsZoTYmv8VM0HMtbzAa4P4b7SWQ7rcQrb64uJQgBWYdGlWeFfRg8xi
         ky6gJsR6daoDZfd9H3+Gj5gwTVhaX4aeOUfpVRmTX6brg6EdXH4wS7zIiRDlbR5HNb5j
         jYSj0GEpQKdqyzoYsFuarJDyAJl7/ZC88coBAVbczjuJAQ7EewiUvMExcigdTOWDJSms
         2BGoDIBeIXBcBDG12YaWSnEbDXGJWPaAMyyBQsRtsqC/Y4nYnYQCByBOGcIOH8VJym/7
         diHw==
X-Gm-Message-State: AODbwcBJ7Fl8i4bSlL6nQcafzyxM5PBlEsRq/YqcHQrzME9fhTZHZuT3
        RSsqM4WiKYfGLQ==
X-Received: by 10.80.165.23 with SMTP id y23mr41020edb.64.1494494360459;
        Thu, 11 May 2017 02:19:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/29] grep: add a test helper function for less verbose -f \0 tests
Date:   Thu, 11 May 2017 09:18:11 +0000
Message-Id: <20170511091829.5634-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to make the tests which check for patterns with
\0 in them more succinct. Right now this isn't a big win, but
subsequent commits will add a lot more of these tests.

The helper is based on the match() function in t3070-wildmatch.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7008-grep-binary.sh | 58 +++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 9c9c378119..6c1952eafa 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -4,6 +4,29 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
+nul_match() {
+	status=$1
+	flags=$2
+	pattern=$3
+	pattern_human=$(echo $pattern | sed 's/Q/<NUL>/g')
+
+	if test $status = "1"
+	then
+		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			git grep -f f $flags a
+		"
+	elif test $status = "0"
+	then
+		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			test_must_fail git grep -f f $flags a
+		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown status $status" 'false'
+	fi
+}
+
 test_expect_success 'setup' "
 	echo 'binaryQfile' | q_to_nul >a &&
 	git add a &&
@@ -69,35 +92,12 @@ test_expect_failure 'git grep .fi a' '
 	git grep .fi a
 '
 
-test_expect_success 'git grep -F y<NUL>f a' "
-	printf 'yQf' | q_to_nul >f &&
-	git grep -f f -F a
-"
-
-test_expect_success 'git grep -F y<NUL>x a' "
-	printf 'yQx' | q_to_nul >f &&
-	test_must_fail git grep -f f -F a
-"
-
-test_expect_success 'git grep -Fi Y<NUL>f a' "
-	printf 'YQf' | q_to_nul >f &&
-	git grep -f f -Fi a
-"
-
-test_expect_success 'git grep -Fi Y<NUL>x a' "
-	printf 'YQx' | q_to_nul >f &&
-	test_must_fail git grep -f f -Fi a
-"
-
-test_expect_success 'git grep y<NUL>f a' "
-	printf 'yQf' | q_to_nul >f &&
-	git grep -f f a
-"
-
-test_expect_success 'git grep y<NUL>x a' "
-	printf 'yQx' | q_to_nul >f &&
-	test_must_fail git grep -f f a
-"
+nul_match 1 '-F' 'yQf'
+nul_match 0 '-F' 'yQx'
+nul_match 1 '-Fi' 'YQf'
+nul_match 0 '-Fi' 'YQx'
+nul_match 1 '' 'yQf'
+nul_match 0 '' 'yQx'
 
 test_expect_success 'grep respects binary diff attribute' '
 	echo text >t &&
-- 
2.11.0

