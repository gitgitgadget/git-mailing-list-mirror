Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3FB1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfFTVJn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFTVJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so4388145wrw.13
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjfHRkIGYSR7AXlx4CyOAU2hHCn0rLp4wrt2RXIWR0A=;
        b=sPQ5IR3jvjsc5UCpQ/FB7z4TLmov4AK/e6vQhCTg1TfCfcq7URnn3I6VKlU1F1WNN9
         bavIPVOGu9yeUKZ2YHJbA2x4UWADk4QSjldBKvfpg/W4wROhbcmZKgC9v/z33ZINgKS7
         nwtA8E2Gc61wQEzISgoRt1dJ1ItwmQadpbGM/RV43rmZ70+PB1mWaYrnKBsrhqamdoJW
         KR5PksNFhI73JZ2eTC61dDi/eaL0WaGrRbnnuI+phJITMyvnqGtHqnLcY9vVh+c6smX4
         e/nUyzzjMYGF6XsMLrYSVZvfEHznAUsd0cy87fFHR/Zcydu7qUAV64bTjYxuZklcxOKK
         KEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjfHRkIGYSR7AXlx4CyOAU2hHCn0rLp4wrt2RXIWR0A=;
        b=ckiZ9eKusyzQZQdT7Q6ideYgSMRmPDJ+CD1tser0N+HvNWEksErE+iIwhGHxWZc5p4
         NmaVAKkvL0Bbmqp4adc6O8hO4W1qbzbh5rgoRow0x8ZC9AiIUg3NRN3epbcVGq9HA8FC
         w5SLOF4l+f/teYYw3O8PChvoYYx4fq0xOSYgwQ2auANRMtFVmu0Cu0jz9xUamAXFpEdm
         BafxUqO4tcLO6Kjw6yys6SCjPdR3+qPSOEEw0VK1GV4zNnW3aKbBkoTifNhrSl3qi31e
         1YBu7bhi3lieoDtrG+n7wh2azCWb64GpeHfmknSyw7vjDI6X5s65RWLuZDtbYdta2nPB
         2Wog==
X-Gm-Message-State: APjAAAXkid62S0ph6mkqn1VWFhbjsHnn0ex5oRkqGKvqtbp5TDw94VtH
        zwPB/B5CCbz6ylZunnKPGs5jqZKm8gQ=
X-Google-Smtp-Source: APXvYqwmnaHxW0pAswVsNkuxO2KV/vWqNOuiL6miHeoZAqNObxDHWeEnCHqROy29unMt16od+vzBMA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr29578214wrv.63.1561064976869;
        Thu, 20 Jun 2019 14:09:36 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] tests: make GIT_TEST_FAIL_PREREQS a boolean
Date:   Thu, 20 Jun 2019 23:09:15 +0200
Message-Id: <20190620210915.11297-9-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GIT_TEST_FAIL_PREREQS variable from being "non-empty?" to
being a more standard boolean variable. I recently added the variable
in dfe1a17df9 ("tests: add a special setup where prerequisites fail",
2019-05-13), having to add another "non-empty?" special-case is what
prompted me to write the "git env--helper" utility being used here.

Converting this one is a bit tricky since we use it so early and
frequently in the guts of the test code itself, so let's set a
GIT_TEST_FAIL_PREREQS_INTERNAL which can be tested with the old "test
-n" for the purposes of the shell code, and change the user-exposed
and documented GIT_TEST_FAIL_PREREQS variable to a boolean.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                |  2 +-
 t/t0000-basic.sh        | 10 +++++-----
 t/test-lib-functions.sh |  2 +-
 t/test-lib.sh           | 25 +++++++++++++++++++++----
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/t/README b/t/README
index 072c9854d1..60d5b77bcc 100644
--- a/t/README
+++ b/t/README
@@ -334,7 +334,7 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
-GIT_TEST_FAIL_PREREQS<non-empty?> fails all prerequisites. This is
+GIT_TEST_FAIL_PREREQS=<boolean> fails all prerequisites. This is
 useful for discovering issues with the tests where say a later test
 implicitly depends on an optional earlier test.
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 31de7e90f3..e89438e619 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -726,7 +726,7 @@ donthaveit=yes
 test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
 	donthaveit=no
 '
-if test -z "$GIT_TEST_FAIL_PREREQS" -a $haveit$donthaveit != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit != yesyes
 then
 	say "bug in test framework: prerequisite tags do not work reliably"
 	exit 1
@@ -747,7 +747,7 @@ donthaveiteither=yes
 test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test to be skipped' '
 	donthaveiteither=no
 '
-if test -z "$GIT_TEST_FAIL_PREREQS" -a $haveit$donthaveit$donthaveiteither != yesyesyes
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit$donthaveiteither != yesyesyes
 then
 	say "bug in test framework: multiple prerequisite tags do not work reliably"
 	exit 1
@@ -763,7 +763,7 @@ test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '
 	donthavetrue=no
 '
 
-if test -z "$GIT_TEST_FAIL_PREREQS" -a "$havetrue$donthavetrue" != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a "$havetrue$donthavetrue" != yesyes
 then
 	say 'bug in test framework: lazy prerequisites do not work'
 	exit 1
@@ -779,7 +779,7 @@ test_expect_success LAZY_FALSE 'missing negative lazy prereqs will skip' '
 	havefalse=no
 '
 
-if test -z "$GIT_TEST_FAIL_PREREQS" -a "$nothavefalse$havefalse" != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a "$nothavefalse$havefalse" != yesyes
 then
 	say 'bug in test framework: negative lazy prerequisites do not work'
 	exit 1
@@ -790,7 +790,7 @@ test_expect_success 'tests clean up after themselves' '
 	test_when_finished clean=yes
 '
 
-if test -z "$GIT_TEST_FAIL_PREREQS" -a $clean != yes
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $clean != yes
 then
 	say "bug in test framework: basic cleanup command does not work reliably"
 	exit 1
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 527508c350..3fba71c358 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -309,7 +309,7 @@ test_unset_prereq () {
 }
 
 test_set_prereq () {
-	if test -n "$GIT_TEST_FAIL_PREREQS"
+	if test -n "$GIT_TEST_FAIL_PREREQS_INTERNAL"
 	then
 		case "$1" in
 		# The "!" case is handled below with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c45b0d2611..238ef62401 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1389,6 +1389,27 @@ yes () {
 	done
 }
 
+# The GIT_TEST_FAIL_PREREQS code hooks into test_set_prereq(), and
+# thus needs to be set up really early, and set an internal variable
+# for convenience so the hot test_set_prereq() codepath doesn't need
+# to call "git env--helper". Only do that work if needed by seeing if
+# GIT_TEST_FAIL_PREREQS is set at all.
+GIT_TEST_FAIL_PREREQS_INTERNAL=
+if test -n "$GIT_TEST_FAIL_PREREQS"
+then
+	if git env--helper --mode-bool --variable=GIT_TEST_FAIL_PREREQS \
+		--default=0 --exit-code --quiet
+	then
+		GIT_TEST_FAIL_PREREQS_INTERNAL=true
+		test_set_prereq FAIL_PREREQS
+	fi
+else
+	test_lazy_prereq FAIL_PREREQS '
+		git env--helper --mode-bool --variable=GIT_TEST_FAIL_PREREQS \
+			--default=0 --exit-code --quiet
+	'
+fi
+
 # Fix some commands on Windows
 uname_s=$(uname -s)
 case $uname_s in
@@ -1605,7 +1626,3 @@ test_lazy_prereq SHA1 '
 test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
-
-test_lazy_prereq FAIL_PREREQS '
-	test -n "$GIT_TEST_FAIL_PREREQS"
-'
-- 
2.22.0.455.g172b71a6c5

