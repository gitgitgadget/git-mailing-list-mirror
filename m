Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAFF1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbdEKJTN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35446 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbdEKJTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so5488633wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7jXea3tXxuL+dFji/7M3LW0E2IqaPW83D0pEs8h6OI=;
        b=aki+JMSzCUXMrN2oTGdyX/43N0x0uNqx4Eq/6xhio+skvsKkG06BW6qLvLNwgLRp5v
         o2Xnyfgtpix9L4xW54LdnooF5HifXJ/SGPNhJX1DmvlODjI1eDWPyjBw0XTowwN1w9Zl
         O3uAYy9LSmwt17pofMFHVZ/LxkLshRKYyy27fKBpxh8e6DxXLKGWcTEuh7mW24K1voOC
         sX8ZGjqbe+njJdYLv7RMlXhi4XS0u6INaIx/HFGcJ1/fXnyb2zyonGxepBVtD5tGARQC
         w7suEyqtO3lA5j43mjFpainmCVRelIwbt+HiS/mZGnXiE+W8W2GN+sjpQffJQLrUI7L7
         Sl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7jXea3tXxuL+dFji/7M3LW0E2IqaPW83D0pEs8h6OI=;
        b=nPudCmp59kfBuF/BqAoTcR7Jn/zXsUSiHWM0x6i8lRadAQK2uZPEJWj6EnO8zU8fk4
         VaVemQKLMSfRJv0T3wIqGLXyK3KeXYWfwqfHU1dAQqiKaVirtn6qOAfx1pJsIcgl+iie
         UwvMfVb3hvBEw09AtGqHG26tuAp/ApBOy6WRvsHKt835Qwjw90FH5/HhwS0KI+8OXAzS
         LqL6MqEHW+3kEqEFnBoduucLqwnYcGzG1yLXaYvJQiC1p+gr2Fm6tyJymYgdQvda132+
         2/gsqzvLN/9I/EjnH2Lo4Nq66yE79950tW7EDiBDlN2n0Bojq8tXaBZZVO2fRvg+ROHA
         hVSQ==
X-Gm-Message-State: AODbwcDW3e9vHJmUP4bJiQpDKifL0SJ0PAFiqYNoI5C8FIJAUnJAM4n/
        ZRg20AU+D9KdJXnBX/I=
X-Received: by 10.80.179.123 with SMTP id r56mr19613edd.1.1494494345179;
        Thu, 11 May 2017 02:19:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:04 -0700 (PDT)
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
Subject: [PATCH 05/29] grep: add a test asserting that --perl-regexp dies when !PCRE
Date:   Thu, 11 May 2017 09:18:05 +0000
Message-Id: <20170511091829.5634-6-avarab@gmail.com>
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

Add a test asserting that when --perl-regexp (and -P for grep) is
given to git-grep & git-log that we die with an error.

In developing the PCRE v2 series I introduced a regression where -P
would (through control-flow fall-through) become synonymous with basic
POSIX matching. I.e. 'git grep -P '[\d]' would match "d" instead of
digits.

The entire test suite would still pass with this serious regression,
since everything that tested for --perl-regexp would be guarded by the
PCRE prerequisite, fix that blind-spot by adding tests under !PCRE
asserting that git must die when given --perl-regexp or -P.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh  |  3 +++
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6d1411abea..b0122a1991 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -344,6 +344,9 @@ test_expect_success 'log with various grep.patternType configurations & command-
 		then
 			git log --pretty=tformat:%s --perl-regexp \
 				--grep="[\d]\|" >actual.perl.long-arg
+		else
+			test_must_fail git log --perl-regexp \
+				--grep="[\d]\|"
 		fi &&
 		test_cmp expect.fixed actual.fixed.long-arg &&
 		test_cmp expect.basic actual.basic.long-arg &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c84c4d99f9..8d69113695 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -281,6 +281,10 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success !PCRE "grep $L with grep.patterntype=perl errors without PCRE" '
+		test_must_fail git -c grep.patterntype=perl grep "foo.*bar"
+	'
+
 	test_expect_success "grep $L with grep.patternType=default and grep.extendedRegexp=true" '
 		echo "${HC}ab:abc" >expected &&
 		git \
@@ -1058,11 +1062,19 @@ test_expect_success PCRE 'grep --perl-regexp pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success !PCRE 'grep --perl-regexp pattern errors without PCRE' '
+	test_must_fail git grep --perl-regexp "foo.*bar"
+'
+
 test_expect_success PCRE 'grep -P pattern' '
 	git grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
+	test_must_fail git grep -P "foo.*bar"
+'
+
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
-- 
2.11.0

