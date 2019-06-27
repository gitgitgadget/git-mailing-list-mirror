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
	by dcvr.yhbt.net (Postfix) with ESMTP id C64871F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF0Xj1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53046 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0Xj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so7283929wms.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGETbHwR8FkQ1GAWFD9sYLqQAWVHiYH/Mnhtx31OTo0=;
        b=R0o5kPVKPyiEFhWIQkfwrU+k9zgyEJqg2GXi5pVCCpKzsxf6zJFmrTayp+5wzYJ4Bs
         s0vRecsnqSkW8wSU/9WZKwUgKnRuM/PnErYTcztEYfk9xwNSkfYiPnTYnDItQxxI0aSb
         GUoVfPL9n38TjLcR1BHh1rVa5c4+grPyoM7cuduLUOuI2yYQoH1l+a5/cCSDJRaAWEy5
         oGf0qxrjoCeLeNQSCM0roz+WIzk4GVHWjxbBX4NU9UidS1GJ8K8uNGWWuHo5EhbX0XCJ
         24c/q2Xm9m2XqkiKnkYy7/wgAkvnPdm5calzNf9vux/FEXO0vsv7tIUqZzxnjVpll1An
         gSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGETbHwR8FkQ1GAWFD9sYLqQAWVHiYH/Mnhtx31OTo0=;
        b=HqKUaL99GJCMTDgaRSMGsTj+XhqqxKdlnHvyRSNc4sj4t4o5x89g/zVcTddO78DLt8
         a9rM0D2q32B4iZbewBekcQUYiDfOSD2CIURPRjV1GUmjJuMApQrPg1aSvhhW0RmNc5oo
         P3cfEZMjzcEml67x/nR3IMH+DqbAnvdpkgwy0EkNytIgNdnrua4BqCZEf8G60gO74yaa
         DDXlZseyr8lddbb1m7Hr5+D/HRlOpRjGxbKfi9D57PxgcwGySDgIIlgbcg1UQp1kUmGI
         kOz3zDfycYECikB4duNcmD862ArmxX5nh7HZcA6vW+QJwz27JVlaP+VQeykE8Q0BEltU
         ubkg==
X-Gm-Message-State: APjAAAUMU/w+6ZV5zFeRF7RssIrgrgNXxlbUW3PIEp1G0kboyg6US3Jd
        oyhmhKHBOpd0X+SCX6GKiJHZh+Gk
X-Google-Smtp-Source: APXvYqyLTX0/1z452RBMpQsntl3YfmIUn1tVaC0H8kKudYl9KlRzosFWAKeschP1/GtevRNQJdpHvA==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr4861417wma.78.1561678765099;
        Thu, 27 Jun 2019 16:39:25 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] log tests: test regex backends in "--encode=<enc>" tests
Date:   Fri, 28 Jun 2019 01:39:04 +0200
Message-Id: <20190627233912.7117-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
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

