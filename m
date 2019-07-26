Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83551F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbfGZPJK (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbfGZPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so1650508wrt.6
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZ/w1lSHdkPbdWhdGQSuekUaVPK1hxxgQnFp3e4/tWc=;
        b=QqQaCy43hmgV2+NGUm6TbF/ZMJyg22D0cjH3wCrks1GAGOGesdJ97Tlzg0wLlki8Ub
         krPk1Jg6TXz+gTXXM+38S0gfkc5mLhTEEu78e4pIDNgnh15vZQViJrry88f7iNsqo9H3
         EVMG+h25vva6YKkeeDPHd7C5KhhJcZyaeuKelr9xfQFHF+5/wooMCGb3aem81NlyBNzh
         5LQQC6RRvwu1CPnfbz2eCdXoX+VPhhMA5tyc/xN1CR8yBzizO3Ml9yTeRVIbW/ZieiPy
         jVw05wLxl56j3IVEWzNven5NVBU+s0eeEBizPpZf9daAep0gfvyC2RdRM6aKI0YBIZnr
         45nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZ/w1lSHdkPbdWhdGQSuekUaVPK1hxxgQnFp3e4/tWc=;
        b=sX5bS6eXuP1cgRfVV2quOBnFSeJpJtyas7GMVucQ8HMDpDvR8ydO3+ACYJIuhKJo2F
         iTYKBP4vodquV15gtWWt6zWx4oRZvE4OrJ/gg97BKnAB1sdvwR5N9fw40ri0DOpli/2/
         pRcT+lj+0Ty7eiRbSR7ZfxHTYeX7V2xTjhI7haI9ClflfdM8RN1kFj0tmxGl0shmLG/e
         WjJjAnqjQtAfbgWsJlc9fIpXlnKp8R9ElJlHkfehvKTcYci4Qc45lf9jkgyuKucwNMlY
         gOTnVpi95/Bu48U23UnRgOBq89fSVZOzV1TRVygJ2Ym5uFn30NhTyLuFylJFvBUJSqJ7
         edVA==
X-Gm-Message-State: APjAAAVEiQGkaPU8oH3mqSDoqsEkDVCcTFZUd8GUfwL41eL8ybYePsO8
        2zCYzWE0XPEzhY5Xdl1ZT1yMAqD/jzs=
X-Google-Smtp-Source: APXvYqyibzje7DvZ0txyy1/lCINh22bTZg9Qe/peWFe+7wbAMMHRN+dIeiTCWu1OmRXdppXNa2Qomg==
X-Received: by 2002:adf:f601:: with SMTP id t1mr6170341wrp.337.1564153744266;
        Fri, 26 Jul 2019 08:09:04 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.09.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:09:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] grep: stess test PCRE v2 on invalid UTF-8 data
Date:   Fri, 26 Jul 2019 17:08:16 +0200
Message-Id: <20190726150818.6373-7-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since my b65abcafc7 ("grep: use PCRE v2 for optimized fixed-string
search", 2019-07-01) we've been dying on invalid UTF-8 data when
grepping for fixed strings if the following are all true:

    * The subject string is non-ASCII (e.g. "ævar")
    * We're under a is_utf8_locale(), e.g. "en_US.UTF-8", not "C"
    * We compiled with PCRE v2
    * That PCRE v2 did not have JIT support

The last of those is why this wasn't caught earlier, per pcre2jit(3):

    "unless PCRE2_NO_UTF_CHECK is set, a UTF subject string is tested
    for validity. In the interests of speed, these checks do not
    happen on the JIT fast path, and if invalid data is passed, the
    result is undefined."

I.e. the subject being matched against our pattern was invalid, but we
were lucky and getting away with it on the JIT path, but the non-JIT
one is stricter.

This patch does nothing to fix that, instead we sneak in support for
fixed patterns starting with "(*NO_JIT)", this disables the PCRE v2
jit with implicit fixed-string matching for testing, see
pcre2syntax(3) the syntax.

This is technically a change in behavior, but it's so obscure that I
figured it was OK. We'd previously consider this an invalid regular
expression as regcomp() would die on it, now we feed it to the PCRE v2
fixed-string path. I thought this was better than introducing yet
another GIT_TEST_* environment variable.

We're also relying on a behavior of PCRE v2 that technically could
change, but I think the test coverage is worth dipping our toe into
some somewhat undefined behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c                          | 10 ++++++++++
 t/t7812-grep-icase-non-ascii.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/grep.c b/grep.c
index 6d60e2e557..5bc0f4f32a 100644
--- a/grep.c
+++ b/grep.c
@@ -615,6 +615,16 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
+#ifdef USE_LIBPCRE2
+       if (!p->fixed && !p->is_fixed) {
+	       const char *no_jit = "(*NO_JIT)";
+	       const int no_jit_len = strlen(no_jit);
+	       if (starts_with(p->pattern, no_jit) &&
+		   is_fixed(p->pattern + no_jit_len,
+			    p->patternlen - no_jit_len))
+		       p->is_fixed = 1;
+       }
+#endif
 	if (p->fixed || p->is_fixed) {
 #ifdef USE_LIBPCRE2
 		opt->pcre2 = 1;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 0c685d3598..96c3572056 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -53,4 +53,32 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
 	test_cmp expected actual
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UTF-8 data' '
+	printf "\\200\\n" >invalid-0x80 &&
+	echo "ævar" >expected &&
+	cat expected >>invalid-0x80 &&
+	git add invalid-0x80
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UTF-8 data' '
+	git grep -h "var" invalid-0x80 >actual &&
+	test_cmp expected actual &&
+	git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data' '
+	test_might_fail git grep -h "æ" invalid-0x80 >actual &&
+	test_cmp expected actual &&
+	test_must_fail git grep -h "(*NO_JIT)æ" invalid-0x80 &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
+	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
+	test_cmp expected actual &&
+	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.22.0.455.g172b71a6c5

