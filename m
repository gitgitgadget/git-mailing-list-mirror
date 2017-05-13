Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192C820188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758734AbdEMXQZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:25 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33730 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758672AbdEMXQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id o85so12526843qkh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTJqAOn1oLO7FuIhKHp3CJpe85U/reNXJmGmFDaq0D0=;
        b=UIQK6pvZlVIOlnNQxn+NKvV0J4ssCVYdZlCadr3aX0W/p5Ks1SQ09xWdJ6uG7QUeYo
         ++BBzkA47WMdL05fM2nU1LnBIHZcyTJTSO2o0pwlb7lg2Hp1mi3Ku8wf0WWhpQxEklp2
         I0QLAYP85FBINL2EMykvKQ6DJP+Ud1Bbp+9m8JdqEsXgjb89Yo/k2zZRUzOP2W9bTOP2
         tLCpzo2fiI2bzpThqZ4rROVBloV+vFe7iY4QThGlAjdhlDzlZFsAH818+POc/0QP1bNt
         TIMeoIMnjcCAvyctotzOrDBQ1Afc4PpaTY9N3zSfL9GpVWj8yq91weHJFY15u/5SW3lO
         JykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTJqAOn1oLO7FuIhKHp3CJpe85U/reNXJmGmFDaq0D0=;
        b=Qv30QJScgWYqzkK3qORqDxny1Fp87Cf2EtrzbXyB0t+xzNiArpLRi1N7ZO9OKOATqB
         4EJUh26zmQlp8vmTJ6dhXS59prv6DP3GxY+2vLYkRz5CpX26U/DZxxHsQAchzeDe/AKk
         +Svz44l8rzi8MWTQ11fM5/LnXAQBOdAxpL3cRnRfizMa4OPmopEpO9642iWvtiJUlgrr
         4F7CY7aqQQmuEXg3TmAiEjlvoJtn45i3aourGH1Q8UpQngfDS4GT6y9tGJIBzbbawXiL
         aQyzbiyCwAwnikejliR01gGlqe/wZTpUydFac3t8nUdUk7VyskiO3uC3ktOjsf9PKH5x
         kHOg==
X-Gm-Message-State: AODbwcDuVXWe03nNW5O8kJqoULDSZu6oN/SsmyIPyqLb/Wr2I6qYo3tv
        gc1/nG0GY/K2uw==
X-Received: by 10.55.221.8 with SMTP id n8mr9556923qki.103.1494717381032;
        Sat, 13 May 2017 16:16:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:20 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/29] grep: add a test helper function for less verbose -f \0 tests
Date:   Sat, 13 May 2017 23:14:51 +0000
Message-Id: <20170513231509.7834-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
index 9c9c378119..70e7868829 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -4,6 +4,29 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
+nul_match () {
+	status=$1
+	flags=$2
+	pattern=$3
+	pattern_human=$(echo "$pattern" | sed 's/Q/<NUL>/g')
+
+	if test "$status" = 1
+	then
+		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			git grep -f f $flags a
+		"
+	elif test "$status" = 0
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

