Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D0B1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfGAVVO (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so1020775wmm.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGETbHwR8FkQ1GAWFD9sYLqQAWVHiYH/Mnhtx31OTo0=;
        b=JrRGk1zlzDh6DJoLWvm0QG6wufkswfG6Tn3QUCf3ev2lViSz6is8glTkVcHURCK1vB
         nhU22AY+SLAqf4kDKVtPWWJMXvTDdrRVypYgvPOQfEsPXvIZJgnwWvfRljai6/QLflIk
         /yiWdNI76hOCo900hKuiiF2PHjxLVSOZUwfR/rlK3koQyDVQICG2e1Y5DFjM6YQ+IB0x
         6Ul6NZc2pKi2c8hsIydVM0T+jMb/wMGDtqEw0PqIbDi7NrdQ1iOoSG5awlU70337MI93
         U1YbXNS1/RIA0qmO9EY7ctsxZslIxVH0Cl6RoGesWO8SFM9iJc8rezPABmyDcjP0s2tK
         Da0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGETbHwR8FkQ1GAWFD9sYLqQAWVHiYH/Mnhtx31OTo0=;
        b=TLv5VE6HPiAFYGzIga/8/07F8ItFGsjPidR7+5utA663CiQI/R1rgZ0fsFG7PCb8YL
         920K63lVuniAztbCC5EAeSSMFTrQRyFBrmzAXaIjYfbhgE2lwi3NbaHFglNPEzHJ37Wo
         cDN41PQhFaOxq/5FLW1PAGu2Nkb1hxn8Ec7tXb/0S4C21lmAvAiZ/SqWeM+8SnmL1oKM
         00EvkmsoMJkyi8bBDvMZMONJeEePX3NnGKoIyFuz7SJaqbFynI3kcBM8Qv97vYd1Orm5
         +a1kRr6N0yU+WTTKcCnJx+H7hHujifc3A8g9rjhphi2jmcBNbLyv9o8PAaXksIDgG58u
         ZvBg==
X-Gm-Message-State: APjAAAXnaTT4UwdoSbPoOx98bCZkBrgEZkDBCWc1vdWum56fsEoovDBO
        Q0oxz9PJdlrPyeXqp/VpSGoY7vkypFk=
X-Google-Smtp-Source: APXvYqxEDJA2uPA+gZW6d05uXStjFicB/L9nFjKvo8U/4w12Jyuw1WwrdkFDzhnjKnkVTKS03BTuzQ==
X-Received: by 2002:a1c:7a01:: with SMTP id v1mr742462wmc.10.1562016070486;
        Mon, 01 Jul 2019 14:21:10 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] log tests: test regex backends in "--encode=<enc>" tests
Date:   Mon,  1 Jul 2019 23:20:51 +0200
Message-Id: <20190701212100.27850-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the tests added in 04deccda11 ("log: re-encode commit messages
before grepping", 2013-02-11) to test the regex backends. Those tests
never worked as advertised, due to the is_fixed() optimization in
grep.c (which was in place at the time), and the needle in the tests
being a fixed string.

We'd thus always use the "fixed" backend during the tests, which would
use the kwset() backend. This backend liberally accepts any garbage
input, so invalid encodings would be silently accepted.

In a follow-up commit we'll fix this bug, this test just demonstrates
the existing issue.

In practice this issue happened on Windows, see [1], but due to the
structure of the existing tests & how liberal the kwset code is about
garbage we missed this.

Cover this blind spot by testing all our regex engines. The PCRE
backend will spot these invalid encodings. It's possible that this
test breaks the "basic" and "extended" backends on some systems that
are more anal than glibc about the encoding of locale issues with
POSIX functions that I can remember, but PCRE is more careful about
the validation.

1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1906271113090.44@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4210-log-i18n.sh | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 7c519436ef..86d22c1d4c 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -1,12 +1,15 @@
 #!/bin/sh
 
 test_description='test log with i18n features'
-. ./test-lib.sh
+. ./lib-gettext.sh
 
 # two forms of é
 utf8_e=$(printf '\303\251')
 latin1_e=$(printf '\351')
 
+# invalid UTF-8
+invalid_e=$(printf '\303\50)') # ")" at end to close opening "("
+
 test_expect_success 'create commits in different encodings' '
 	test_tick &&
 	cat >msg <<-EOF &&
@@ -53,4 +56,40 @@ test_expect_success 'log --grep does not find non-reencoded values (latin1)' '
 	test_must_be_empty actual
 '
 
+for engine in fixed basic extended perl
+do
+	prereq=
+	result=success
+	if test $engine = "perl"
+	then
+		result=failure
+		prereq="PCRE"
+	else
+		prereq=""
+	fi
+	force_regex=
+	if test $engine != "fixed"
+	then
+	    force_regex=.*
+	fi
+	test_expect_$result GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+		cat >expect <<-\EOF &&
+		latin1
+		utf8
+		EOF
+		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
+		test_cmp expect actual
+	"
+
+	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
+		test_must_be_empty actual
+	"
+
+	test_expect_$result GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
+		test_must_be_empty actual
+	"
+done
+
 test_done
-- 
2.22.0.455.g172b71a6c5

