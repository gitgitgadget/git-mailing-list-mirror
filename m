Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2836D2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbdEKRwQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:52:16 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36598 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933309AbdEKRv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:59 -0400
Received: by mail-qt0-f170.google.com with SMTP id m91so23526104qte.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqATgKwEwJAFqUkfz3nzxjfgels64NJXWBUSeW2tX8I=;
        b=oep05kUIxQLpW103q6OKSppJGVqLLeN5FwR5+UVc4QwIHNaljbgjkmWx65dWeDoByk
         HWNCx/8IOuRsLnSdd2+jzuFdOtylOXoFKZN96XxprExrEbGXSSwxr2TeJQ6kUwvg4ukG
         UqikevKOrQw9PQvsuXhB6czJLewbe3w2nfePq2/Tc6kCyWlHXb3Jw5HqoPpLCQvDfIMO
         iTf+MixQ3fy2lCepCRZzvCbimegA7abJoEn4WwHsL5/2yO40xcja5/geVkx0/H5JQUz4
         LkURRwlLYsVgjI8AFD5BvB1HcdJcC9+zvYkPwl9Zhp+pAk+C5bhk6R++HPJcQhhPLlj+
         2hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqATgKwEwJAFqUkfz3nzxjfgels64NJXWBUSeW2tX8I=;
        b=VXzBe19Wgq+NSATWwE1hciFwOmxwyrwBUZ+t19pgdIgRc6kgvm3H5DXrxuw9uyFFkw
         6rK04D4o9zK3DVQUwVTJEBg3trO6zL9mA+Xb1jUakNTgOqiKSdu2c1hR08NZcDHiYvDQ
         scvc4vI7//p4Fv4MnWAUe+64+vpnxwrwtPNcnRwwzrklRLAKg5oRhSRna/Oy+2X1ZNXh
         laHDt2ZalYtJtex4lH6wSl+9h+0xX4sIKAYhP5YMDt1+Atus9V/tSQoBBXD5ChKTfi4r
         QyUAK72ekwMTLfDCYjUTdWeJJrlIXAGC6K6btSc7vgMPjBfMHOY/jlnmMKCfk5Fj3Ssj
         SjZA==
X-Gm-Message-State: AODbwcDYRnF7LRNBLv4iHcXKQi1Arjro8sIIoA5lUSJKWe5ChqGpKXtj
        Jd4anLXgR6C4McmsajVw2A==
X-Received: by 10.200.45.17 with SMTP id n17mr42358qta.250.1494525117835;
        Thu, 11 May 2017 10:51:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:56 -0700 (PDT)
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
Subject: [PATCH/RFC 5/6] grep: support regex patterns containing \0 via PCRE v2
Date:   Thu, 11 May 2017 17:51:14 +0000
Message-Id: <20170511175115.648-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511175115.648-1-avarab@gmail.com>
References: <20170511175115.648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support regex patterns with embedded \0's, as an earlier commit[1]
notes this was previously impossible due to an internal limitation.

Before this change any regex metacharacters in patterns containing \0
were silently ignored and the pattern matched as if it were a
--fixed-strings pattern.

Now these patterns will be matched with PCRE instead, which supports
combining regex metacharacters with patterns containing \0.

A side-effect of this change is that these patterns which previously
would be considered --fixed-strings patterns regardless of the engine
requested now all implicitly become --perl-regexp instead.

A subsequent change introduces a POSIX to PCRE syntax converter, and
could be used to be 100% truthful to our documentation by using POSIX
basic syntax (which we haven't been in quite some time with kwset).

But due to a chicken & egg issue with this change being easier to
implement stand-alone first, the subsequent change depending on a SVN
trunk version of PCRE, but most importantly I don't think anyone will
mind this change, so I'm leaving it as it is.

This implementation is faster than the previous kwset implementation,
but I haven't bothered to come up with a \0-specific fixed-string
performance test.

See the next change in this series for a change which optionally
expands the PCRE v2 use to use it for all fixed-string patterns, the
performance tests for those will be applicable to these patterns as
well, since PCRE matches \0 like any other character.

1. ("grep: factor test for \0 in grep patterns into a function",
   2017-05-08)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c                 | 24 ++++++++++++++++
 t/t7008-grep-binary.sh | 74 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/grep.c b/grep.c
index 2ff4e253ff..5db614cf80 100644
--- a/grep.c
+++ b/grep.c
@@ -613,6 +613,30 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
+#ifdef USE_LIBPCRE2
+	if (has_null(p->pattern, p->patternlen)) {
+		struct strbuf sb = STRBUF_INIT;
+		if (icase)
+			strbuf_add(&sb, "(?i)", 4);
+		if (opt->fixed)
+			strbuf_add(&sb, "\\Q", 2);		
+		strbuf_add(&sb, p->pattern, p->patternlen);
+		if (opt->fixed)
+			strbuf_add(&sb, "\\E", 2);
+
+		p->pattern = sb.buf;
+		p->patternlen = sb.len;
+
+		/* FIXME: Check in compile_pcre2_pattern() that we're
+		 * using basic rx using !opt->pcre2 && <something>
+		 */
+		opt->pcre2 = 1;
+
+		compile_pcre2_pattern(p, opt);
+		return;
+	}
+#endif
+
 	/*
 	 * Even when -F (fixed) asks us to do a non-regexp search, we
 	 * may not be able to correctly case-fold when -i
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index ba3db06501..fc86ed5fce 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -124,35 +124,63 @@ nul_match 0 '-F' '[æ]Qð'
 nul_match 0 '-Fi' 'ÆQ[Ð]'
 nul_match 0 '-Fi' '[Æ]QÐ'
 
-# kwset is disabled on -i & non-ASCII. No way to match non-ASCII \0
-# patterns case-insensitively.
-nul_match T1 '-i' 'ÆQÐ'
-
-# \0 implicitly disables regexes. This is an undocumented internal
-# limitation.
-nul_match T1 '' 'yQ[f]'
-nul_match T1 '' '[y]Qf'
-nul_match T1 '-i' 'YQ[F]'
-nul_match T1 '-i' '[Y]Qf'
-nul_match T1 '' 'æQ[ð]'
-nul_match T1 '' '[æ]Qð'
-nul_match T1 '-i' 'ÆQ[Ð]'
-
-# ... because of \0 implicitly disabling regexes regexes that
-# should/shouldn't match don't do the right thing.
-nul_match T1 '' 'eQm.*cQ'
-nul_match T1 '-i' 'EQM.*cQ'
-nul_match T0 '' 'eQm[*]c'
-nul_match T0 '-i' 'EQM[*]C'
+if test_have_prereq LIBPCRE2
+then
+	# Regex patterns that should match without -F
+	nul_match 1 '' 'yQ[f]'
+	nul_match 1 '' '[y]Qf'
+	nul_match 1 '-i' 'YQ[F]'
+	nul_match 1 '-i' '[Y]Qf'
+	nul_match 1 '' 'æQ[ð]'
+	nul_match 1 '' '[æ]Qð'
+	nul_match 0 '-i' '[Æ]Qð'
+	nul_match 1 '' 'eQm.*cQ'
+	nul_match 1 '-i' 'EQM.*cQ'
+	nul_match 0 '' 'eQm[*]c'
+	nul_match 0 '-i' 'EQM[*]C'
+
+	# These should also match, but don't due to some heisenbug,
+	# they succeed when run manually!
+	nul_match T1 '-i' 'ÆQÐ'
+	nul_match T1 '-i' 'ÆQ[Ð]'
+else
+	# \0 implicitly disables regexes. This is an undocumented
+	# internal limitation.
+	nul_match T1 '' 'yQ[f]'
+	nul_match T1 '' '[y]Qf'
+	nul_match T1 '-i' 'YQ[F]'
+	nul_match T1 '-i' '[Y]Qf'
+	nul_match T1 '' 'æQ[ð]'
+	nul_match T1 '' '[æ]Qð'
+	nul_match T1 '-i' 'ÆQ[Ð]'
+
+	# ... because of \0 implicitly disabling regexes regexes that
+	# should/shouldn't match don't do the right thing.
+	nul_match T1 '' 'eQm.*cQ'
+	nul_match T1 '-i' 'EQM.*cQ'
+	nul_match T0 '' 'eQm[*]c'
+	nul_match T0 '-i' 'EQM[*]C'
+fi
 
 # Due to the REG_STARTEND extension when kwset() is disabled on -i &
 # non-ASCII the string will be matched in its entirety, but the
 # pattern will be cut off at the first \0.
 nul_match 0 '-i' 'NOMATCHQð'
-nul_match T0 '-i' '[Æ]QNOMATCH'
-nul_match T0 '-i' '[æ]QNOMATCH'
+if test_have_prereq LIBPCRE2
+then
+	nul_match 0 '-i' '[Æ]QNOMATCH'
+	nul_match 0 '-i' '[æ]QNOMATCH'
+else
+	nul_match T0 '-i' '[Æ]QNOMATCH'
+	nul_match T0 '-i' '[æ]QNOMATCH'
+fi
 # Matches, but for the wrong reasons, just stops at [æ]
-nul_match 1 '-i' '[Æ]Qð'
+if test_have_prereq LIBPCRE2
+then
+	nul_match T1 '-i' '[Æ]Qð'
+else
+	nul_match 1 '-i' '[Æ]Qð'
+fi
 nul_match 1 '-i' '[æ]Qð'
 
 # Ensure that the matcher doesn't regress to something that stops at
-- 
2.11.0

