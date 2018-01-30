Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75AF21F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeA3VWR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:22:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35948 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeA3VWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:22:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id f3so3976127wmc.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qZ4Lc3diFvc1HsmDRKuqXGsT8xs5S2fdB8Kob1WMBU8=;
        b=styL+n9m+AsDnYKbm3M0PlQdb+mQYieVSBmrZNZlJlmASRNPCH0NcPi/i3Gq2T7Jcu
         AlHnmDYQuoBZvVpP7+3F4mZ0TW2U3QYqg9K7ZBZrixMIi+cpZ7oonXQ6DaMWCnwlvLQi
         N0AMhvjAoyA4kZMWMqCf05pYnG4FV57c5xGsFZmfRKEY5P5kDsd4AeHFEWgvdnh5MFCF
         nobTQUFSFX6NdL2fWjM4ji4+B+zKGMwXZNifTkJA/ijriIE9fuq/pLQI69bDwoeLu2j9
         0bq1eXFvLlNQfcbX1VU7+oo+k2x0I2DwZaqYLO9dEYf3ySwkJwiEzMrhZ2qHHj0KmQQT
         3ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qZ4Lc3diFvc1HsmDRKuqXGsT8xs5S2fdB8Kob1WMBU8=;
        b=dM1AmctsZc+Ivx4qF/3kWkiUck0dzITDJDH0WFsD19fEe9WaOlflgCiQoAY75b7R2U
         usjQ5xKwOMnEJtWsSSJMgQxQlGOoIJWbuwmz4dkfukrUhMKnBK+lL+v4ApaczolN2bFs
         9GWSAasqx6xUe0Y1Ax9oh8c0mY/2PhGyAstHAV1QJMoQWpdfo/biCVjciwbCqNXVeo0p
         flaqIlTG/eq5KlbTmuVf+gitPie3Mb9kvVWqgJbETUoK81EZcTsmgo8pxQvEDuA7DhqK
         dFLfoMBDm87+niNeiIlXV+SaQhw/r+hNhjbwSl+1LC8aNN8cPIOnPMdDkcW6AmHAno5b
         enNQ==
X-Gm-Message-State: AKwxytcpn/SMLSv01wlPsqlWDdRAczx1A493w2vJMHBClZQ75bg+TG9C
        oaR4GCQdFRLmD+02FNy5Qd6ULCQk
X-Google-Smtp-Source: AH8x227/Pd++oOGjQRIXn+Y/m1PfBpfe3TG9XQeD/02rOASzEW1gOP6ur+h1SLFT4XUU1PLcIYxdPQ==
X-Received: by 10.80.180.184 with SMTP id w53mr27699120edd.149.1517347331748;
        Tue, 30 Jan 2018 13:22:11 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:22:10 -0800 (PST)
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
Subject: [PATCH v5 10/10] wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
Date:   Tue, 30 Jan 2018 21:21:24 +0000
Message-Id: <20180130212124.2099-11-avarab@gmail.com>
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

Mark the newly added test which creates test files on-disk as
EXPENSIVE_ON_WINDOWS. According to [1] it takes almost ten minutes to
run this test file on Windows after this recent change, but just a few
seconds on Linux as noted in my [2].

This could be done faster by exiting earlier, however by using this
pattern we'll emit "skip" lines for each skipped test, making it clear
we're not running a lot of them in the TAP output, at the cost of some
overhead.

1. nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet
   (https://public-inbox.org/git/nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet/)

2. 87mv1raz9p.fsf@evledraar.gmail.com
   (https://public-inbox.org/git/87mv1raz9p.fsf@evledraar.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index bd11e5acb0..c1fc6ca730 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -109,36 +109,36 @@ match_with_ls_files() {
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success "$match_function (via ls-files): match dies on '$pattern' '$text'" "
+			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match dies on '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
 				test_must_fail git$ls_files_args ls-files -z -- '$pattern'
 			"
 		else
-			test_expect_failure "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
 		fi
 	elif test "$match_expect" = 1
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success "$match_function (via ls-files): match '$pattern' '$text'" "
+			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
 				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
 				$match_stdout_stderr_cmp
 			"
 		else
-			test_expect_failure "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
 		fi
 	elif test "$match_expect" = 0
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success "$match_function (via ls-files): no match '$pattern' '$text'" "
+			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): no match '$pattern' '$text'" "
 				>expect &&
 				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
 				$match_stdout_stderr_cmp
 			"
 		else
-			test_expect_failure "$match_function (via ls-files): no match skip '$pattern' '$text'" 'false'
+			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): no match skip '$pattern' '$text'" 'false'
 		fi
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_expect" 'false'
@@ -174,7 +174,7 @@ match() {
 		pattern=${10}
 	fi
 
-	test_expect_success 'cleanup after previous file test' '
+	test_expect_success EXPENSIVE_ON_WINDOWS 'cleanup after previous file test' '
 		if test -e .git/created_test_file
 		then
 			git reset &&
@@ -184,7 +184,7 @@ match() {
 
 	printf '%s' "$text" >.git/expected_test_file
 
-	test_expect_success "setup match file test for $text" '
+	test_expect_success EXPENSIVE_ON_WINDOWS "setup match file test for $text" '
 		file=$(cat .git/expected_test_file) &&
 		if should_create_test_file "$file"
 		then
-- 
2.15.1.424.g9478a66081

