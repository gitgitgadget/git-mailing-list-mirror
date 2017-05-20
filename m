Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95036201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbdETVnJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756392AbdETVnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so4766778wmc.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47KoWy1Ysi6D8auEdSVlBEVqMmsUAA/kz0THFHVzmAI=;
        b=dlOoR9U1OwBwc20x+HeU9HWpPu84lTOmYiplQnsu7D/1BrGcxQ1zwqgVn2dZd/RHNS
         BQyOa1EnwxWsr1HVHGPXU8kpWNxw87f53hhB7Kww+hRAtgt0JMQFEA4GvS9+eXQLysXe
         mis/RoJd6g6T6w00GcacIKeYZW3Ns2iO9AKH0uA2h8W+pAPDn5MX9VuVl1gffm333VOR
         miiA1wIQdwGJJILVPIjrkWAPHMHhunY0W4gF6LW2tEugi40HIAZojEeumosOuaPTdB9B
         dOyzvEAP7wEajVNFsrze/Amh1XkN2q97nKrme8uUZ50CIm91e3alz848HxkEUyjH341F
         k4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47KoWy1Ysi6D8auEdSVlBEVqMmsUAA/kz0THFHVzmAI=;
        b=eF5YsKbNsZmlFxhhjKh6cu+ftd0wE0Fbf6MyOJFSewJKVHQn4uz6uX+v7c6XhY0c0E
         vfdcHARL6+WprEbN6g3LB3La42tYSbPtCX5TipzYbU4qGMe4v6t2ET2p9sCEhu63U7QO
         LBSM0VQXqwuqhPD3WLWg1zuzunBWXz8dFP1/V2z5Ko11Sqhj+36f10L6v9qo0UPHcrLr
         FTZz5bcnqpuVDcInPRtdmzQHR3dOj1MULioBcf2isHD0ZSffayc/wPqz9FGdWddk9+6S
         KnPD6oYTzpB9sC9vNVNcZINLVvb9UGMR06LneJsrsjhg9SDJqf4QJTAco9ccwqIsJ2Ng
         ghpQ==
X-Gm-Message-State: AODbwcAradm+i7V4UlF57KV8PYHu1uk6rWerCTCLQva9CYc/ULYRcXX4
        rBgScLn29Cfeqg==
X-Received: by 10.28.139.18 with SMTP id n18mr22166634wmd.100.1495316579548;
        Sat, 20 May 2017 14:42:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:42:58 -0700 (PDT)
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
Subject: [PATCH v3 06/30] grep: add a test asserting that --perl-regexp dies when !PCRE
Date:   Sat, 20 May 2017 21:42:09 +0000
Message-Id: <20170520214233.7183-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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
 t/t4202-log.sh  |  4 +++-
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 547f4c19a7..dbed3efeee 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -418,7 +418,9 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			git log --pretty=tformat:%s --perl-regexp \
 				--grep="[\d]\|" >actual.perl.long-arg &&
 			test_cmp expect.perl actual.perl.long-arg
-
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
2.13.0.303.g4ebf302169

