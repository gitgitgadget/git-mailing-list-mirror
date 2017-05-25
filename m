Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A50209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036690AbdEYTq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33769 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036686AbdEYTqV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so39668934wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2tkXSDF58i2EGqBY5DW8iZRsWMynDaSnBKzKfFxkx8=;
        b=GkAAeBKIgb8HNGc6E7b6gpUOuLdf6ipNg8/f9XjPuJiLwI+1pwFNKgQhELZEI8h25J
         vvISVUmh/86LPfuTl5RWM82ZdY9aD6w4U0YUtUL7Wm2LHBrTWLx6CjZPAImH6wkX24mE
         xPs6aiwhRi/iygYK0fGkOAIimxRPvFFqchIFlon41YlTEhRNDsKXncr2IcDOZ0vs6ex5
         J7xHwCaNHdVsUHizZhFN7p4jR9JLsuoccB7d3fq0GygCCw1HHiM3cng4dsXIUzlwSThw
         b5IApZKVDMj/bCBccKCY0xmFBBQRIay15SqrVuFQWC9IXM3SZoYI3e4+SY2MgD/CpCJw
         ZwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2tkXSDF58i2EGqBY5DW8iZRsWMynDaSnBKzKfFxkx8=;
        b=OHTyGPph4R/XbHkdRSXpElL4L3kR/8S0/y4jccsC9zWcfjvFqwCtqjy97S6LiTK9Lg
         eG8c5h7KyokhCefB06UHlmTYuV4FhUHmknkWRzoeclKskbAJtwfMEByTujtDVEouJsc7
         v+6c5FPbVKw8L5fuCIl021PR8wASmelODDdsGOolL1cBNTJ+VCxpaJ7ixMeAJwENnLuL
         tSGTDPHieDeIvzCvRY/ulhJckQFk1d5bO/gp2VHFqTsHyR3z1AX+P8pV3UCkRgy9Js8V
         H9w6K+VUYcExtLQ3zX8hVgRqdXMWyjzpkT422QhfUizEbgnDwcYqMZ/9Vbln30+qlwLN
         37Hw==
X-Gm-Message-State: AODbwcCEQJZCtGfW2r+/oyRk59sDpuzYXla0UdUddAhhxvpFvc4xqi/k
        UesZ7RbvIiIepAoS7Eg=
X-Received: by 10.28.211.5 with SMTP id k5mr2023667wmg.11.1495741569202;
        Thu, 25 May 2017 12:46:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:08 -0700 (PDT)
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
Subject: [PATCH v4 06/31] grep: add a test asserting that --perl-regexp dies when !PCRE
Date:   Thu, 25 May 2017 19:45:10 +0000
Message-Id: <20170525194535.9324-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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
index c25eb9afd1..c44c4337f8 100755
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

