Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA4A207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954744AbdDYVG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32943 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954735AbdDYVGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so17341006wmh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R07lN/4jpeXUNSCArQEoVeH9bGB+CR1EVYJOldxkCaM=;
        b=ZgmzV0yP7imUiNm+3wu9MFqGtfXhpV8PifOb53AqbjstREzLXOUHbG4V2hVQt0PzK0
         32QAyaXcaVSvU4wbkm/UdDqH8ejwrLWRe3F1vJ2WrCf0ohtlEcCByBpDP7cq0ojc6MFS
         9OT2N8x6etQBWh/GRrNEP5Ok+fm9pohlJlQl/exgpOwdjDxVJOpXbV650YjLSk42x35+
         BASqFCjQpSCnsJqLIjUbb3EVEc8EWOo+cA1TQdkK1ZkUKwlg59hAqQZh3k4WreDyIgfY
         xweR1X7LLaOH9aqBReOJiRetMsjy6Y1XhUjk6nuGhqOR8LMdfuGffQy5bTnOKPM7xmhX
         HZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R07lN/4jpeXUNSCArQEoVeH9bGB+CR1EVYJOldxkCaM=;
        b=RUyjxA+ljFzgvel/aWoSvEaIvAqlO2QZbV4y1XUfhPifoYcUhlZysKyK/+x6M2jk8Y
         /0fAo0KtffD2wHrzB0Eo0FPDKyalM2VhLIYDXbLZtbX8/CpHfgYUhR0wl5VphNys3Hdt
         kFYBtw/UsquqUBvqZFeCzxim53xcorcjo+11a0aicpm/w3N5lB6VseqfjZD3C/FUUx28
         OEo5JjqaNUsFQ0R5904gru5mksjb0WQMgrWNsZ+el1dUsOHckQ13f98O2oIvuSMy4+IM
         nlLm4b++kSyhrSZFlZeZd8s83c4hEjVrcubYX4RLYdGReAP3Cmbw8vGgJs+8lYgfwj1q
         gafA==
X-Gm-Message-State: AN3rC/5Gx/QrkUdTEdZz8oh4KKcvNVrQ/k7/pqg1b7xNVuP423zofXsw
        BR8dpwk8lNHmxw==
X-Received: by 10.28.54.151 with SMTP id y23mr14987603wmh.90.1493154395476;
        Tue, 25 Apr 2017 14:06:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:34 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/19] grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
Date:   Tue, 25 Apr 2017 21:05:40 +0000
Message-Id: <20170425210548.24612-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the pattern types "pcre" & "pcre1" synonyms for the long-standing
"perl" grep.patternType.

This change is part of a longer patch series to add pcre2 support to
Git. It's nice to be able to performance test PCRE v1 v.s. v2 without
having to recompile git, and doing that via grep.patternType makes
sense.

However, just adding "pcre2" when we only have "perl" would be
confusing, so start by adding a "pcre" & "pcre1" synonym.

In the future "perl" and "pcre" might be changed to default to "pcre2"
instead of "pcre1", and depending on how Git is compiled the more
specific "pcre1" or "pcre2" pattern types might produce an error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt           |  9 +++++++++
 grep.c                             |  4 +++-
 t/t7810-grep.sh                    | 10 ++++++++++
 t/t7814-grep-recurse-submodules.sh |  4 ++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..5ef12d0694 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1624,6 +1624,15 @@ grep.patternType::
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
++
+The 'pcre' and 'pcre1' values are synonyms for 'perl'. The other
+values starting with 'pcre' are reserved for future use, e.g. if we'd
+like to use 'pcre2' for the PCRE v2 library.
++
+In the future 'perl' and 'pcre' might become synonyms for some other
+implementation or PCRE version, such as 'pcre2', while the more
+specific 'pcre1' & 'pcre2' might throw errors depending on whether git
+is compiled to include those libraries.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
diff --git a/grep.c b/grep.c
index 6995f0989a..62c3749d9f 100644
--- a/grep.c
+++ b/grep.c
@@ -60,7 +60,9 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 		return GREP_PATTERN_TYPE_ERE;
 	else if (!strcmp(arg, "fixed"))
 		return GREP_PATTERN_TYPE_FIXED;
-	else if (!strcmp(arg, "perl"))
+	else if (!strcmp(arg, "perl") ||
+		 !strcmp(arg, "pcre") ||
+		 !strcmp(arg, "pcre1"))
 		return GREP_PATTERN_TYPE_PCRE;
 	die("bad %s argument: %s", opt, arg);
 }
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ec8fe585a7..7199356d35 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1512,4 +1512,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE "grep with grep.patternType synonyms perl/pcre/pcre1" '
+	echo "#include <stdio.h>" >expected &&
+	git -c grep.patternType=perl  grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	git -c grep.patternType=pcre  grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	git -c grep.patternType=pcre1 grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index e1822feaf1..325fde53ef 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -358,6 +358,10 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 		EOF
 		test_cmp expect actual &&
 		git -c grep.patternType=perl grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+		test_cmp expect actual &&
+		git -c grep.patternType=pcre grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+		test_cmp expect actual &&
+		git -c grep.patternType=pcre1 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
 		test_cmp expect actual
 	fi
 '
-- 
2.11.0

