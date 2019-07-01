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
	by dcvr.yhbt.net (Postfix) with ESMTP id 557521F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGAVV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34845 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id c27so7654515wrb.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKD+OlAHzq6XbVAiOK/4PPFfIewNGcJHpWW9mariSAs=;
        b=KZHcpik4nAIxOVND9IZSZOEHe9Udlf3ikYbW2uOSGYAzxNna0gtc3lawsdqCAe9NC2
         SHQaWlKx0JM2ZSypdovjhtOGJrmOr5MAmE+meyBrRL5umvuDAnopfEMgwWsTtaP7w3mO
         dEQ3bdWSidBG+OMt9ZWMeQ12EKwK9Svr2wk7EgsrWpZLhnQy6R+VTCxQJOV2guqW6kmN
         COoNHlvbpX18m2JRkUz8f2hAkR8TQSE+r9Q89arL06XKUQ6UPjRAOEPDQ+ij/NtHgHLh
         GLWjzZsvUIBxFRWwbzEMOM1JmxpXapok65gO7CULTIMSHyp0MIDv86KfGMbOpaL2lY6A
         dstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKD+OlAHzq6XbVAiOK/4PPFfIewNGcJHpWW9mariSAs=;
        b=JDOlYO3H4P/FVX/zZ3kWKomOf4YMtLJWWxxdl528IIVepUz9VURhpS+AgsX83tIoKf
         kZCxdTnQXQ7yoQg+wUig4kaU3SwPbrbZ6uX8x/GLZbsjK1HhO/Ql/fjo+dK+Yr69e+cA
         3BGGM01ud2oxIPiaHjYcmeOmZbT9VaJbv32I5eBltCxoG44x/xpzBXVxPr1NdZt59bUp
         Iy7hBnmL+O1Ix1DH1XJ3hEf4pxQPIdgaDnSgymbrh5lbKyyuTNFfTp/CPmOr1TR+ze9N
         7+6U5cVYUikYV7bGJnKuDbheG8qTL5bx/wiqZYZ5HzWW0Ad7A7RIBPxMRLZgQXlLmr7m
         JfxQ==
X-Gm-Message-State: APjAAAXgyuiHSDKRcx4KHGGYTH70SiWwWN7PLbpRFSQmd5bw+f1LYJdh
        e/7xZsZpJ1auEoxsmPUa3zAi+8i7f3I=
X-Google-Smtp-Source: APXvYqxK1RuS0PPrqn7VF5vV2rNix6IHGff8XJijZLPr7LwJqzLDVI3+o0Nt6CitH2akrzmlJXwngQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr19632892wrn.120.1562016082483;
        Mon, 01 Jul 2019 14:21:22 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] grep: use PCRE v2 for optimized fixed-string search
Date:   Mon,  1 Jul 2019 23:21:00 +0200
Message-Id: <20190701212100.27850-11-avarab@gmail.com>
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

Bring back optimized fixed-string search for "grep", this time with
PCRE v2 as an optional backend. As noted in [1] with kwset we were
slower than PCRE v1 and v2 JIT with the kwset backend, so that
optimization was counterproductive.

This brings back the optimization for "--fixed-strings", without
changing the semantics of having a NUL-byte in patterns. As seen in
previous commits in this series we could support it now, but I'd
rather just leave that edge-case aside so we don't have one behavior
or the other depending what "--fixed-strings" backend we're using. It
makes the behavior harder to understand and document, and makes tests
for the different backends more painful.

This does change the behavior under non-C locales when "log"'s
"--encoding" option is used and the heystack/needle in the
content/command-line doesn't have a matching encoding. See the recent
change in "t4210: skip more command-line encoding tests on MinGW" in
this series. I think that's OK. We did nothing sensible before
then (just compared raw bytes that had no hope of matching). At least
now the user will get some idea why their grep/log never matches in
that edge case.

I could also support the PCRE v1 backend here, but that would make the
code more complex. I'd rather aim for simplicity here and in future
changes to the diffcore. We're not going to have someone who
absolutely must have faster search, but for whom building PCRE v2
isn't acceptable.

The difference between this series of commits and the current "master"
is, using the same t/perf commands shown in the last commit:

plain grep:

    Test                             origin/master     HEAD
    -------------------------------------------------------------------------
    7821.1: fixed grep int           0.55(1.67+0.56)   0.41(0.98+0.60) -25.5%
    7821.2: basic grep int           0.58(1.65+0.52)   0.41(0.96+0.57) -29.3%
    7821.3: extended grep int        0.57(1.66+0.49)   0.42(0.93+0.60) -26.3%
    7821.4: perl grep int            0.54(1.67+0.50)   0.43(0.88+0.65) -20.4%
    7821.6: fixed grep uncommon      0.21(0.52+0.42)   0.16(0.24+0.51) -23.8%
    7821.7: basic grep uncommon      0.20(0.49+0.45)   0.17(0.28+0.47) -15.0%
    7821.8: extended grep uncommon   0.20(0.54+0.39)   0.16(0.25+0.50) -20.0%
    7821.9: perl grep uncommon       0.20(0.58+0.36)   0.16(0.23+0.50) -20.0%
    7821.11: fixed grep æ            0.35(1.24+0.43)   0.16(0.23+0.50) -54.3%
    7821.12: basic grep æ            0.36(1.29+0.38)   0.16(0.20+0.54) -55.6%
    7821.13: extended grep æ         0.35(1.23+0.44)   0.16(0.24+0.50) -54.3%
    7821.14: perl grep æ             0.35(1.33+0.34)   0.16(0.28+0.46) -54.3%

grep with -i:

    Test                                origin/master     HEAD
    ----------------------------------------------------------------------------
    7821.1: fixed grep -i int           0.62(1.81+0.70)   0.47(1.11+0.64) -24.2%
    7821.2: basic grep -i int           0.67(1.90+0.53)   0.46(1.07+0.62) -31.3%
    7821.3: extended grep -i int        0.62(1.92+0.53)   0.53(1.12+0.58) -14.5%
    7821.4: perl grep -i int            0.66(1.85+0.58)   0.45(1.10+0.59) -31.8%
    7821.6: fixed grep -i uncommon      0.21(0.54+0.43)   0.17(0.20+0.55) -19.0%
    7821.7: basic grep -i uncommon      0.20(0.52+0.45)   0.17(0.29+0.48) -15.0%
    7821.8: extended grep -i uncommon   0.21(0.52+0.44)   0.17(0.26+0.50) -19.0%
    7821.9: perl grep -i uncommon       0.21(0.53+0.44)   0.17(0.20+0.56) -19.0%
    7821.11: fixed grep -i æ            0.26(0.79+0.44)   0.16(0.29+0.46) -38.5%
    7821.12: basic grep -i æ            0.26(0.79+0.42)   0.16(0.20+0.54) -38.5%
    7821.13: extended grep -i æ         0.26(0.84+0.39)   0.16(0.24+0.50) -38.5%
    7821.14: perl grep -i æ             0.16(0.24+0.49)   0.17(0.25+0.51) +6.3%

plain log:

    Test                                     origin/master     HEAD
    --------------------------------------------------------------------------------
    4221.1: fixed log --grep='int'           7.24(6.95+0.28)   7.20(6.95+0.18) -0.6%
    4221.2: basic log --grep='int'           7.31(6.97+0.22)   7.20(6.93+0.21) -1.5%
    4221.3: extended log --grep='int'        7.37(7.04+0.24)   7.22(6.91+0.25) -2.0%
    4221.4: perl log --grep='int'            7.31(7.04+0.21)   7.19(6.89+0.21) -1.6%
    4221.6: fixed log --grep='uncommon'      6.93(6.59+0.32)   7.04(6.66+0.37) +1.6%
    4221.7: basic log --grep='uncommon'      6.92(6.58+0.29)   7.08(6.75+0.29) +2.3%
    4221.8: extended log --grep='uncommon'   6.92(6.55+0.31)   7.00(6.68+0.31) +1.2%
    4221.9: perl log --grep='uncommon'       7.03(6.59+0.33)   7.12(6.73+0.34) +1.3%
    4221.11: fixed log --grep='æ'            7.41(7.08+0.28)   7.05(6.76+0.29) -4.9%
    4221.12: basic log --grep='æ'            7.39(6.99+0.33)   7.00(6.68+0.25) -5.3%
    4221.13: extended log --grep='æ'         7.34(7.00+0.25)   7.15(6.81+0.31) -2.6%
    4221.14: perl log --grep='æ'             7.43(7.13+0.26)   7.01(6.60+0.36) -5.7%

log with -i:

    Test                                        origin/master     HEAD
    ------------------------------------------------------------------------------------
    4221.1: fixed log -i --grep='int'           7.31(7.07+0.24)   7.23(7.00+0.22) -1.1%
    4221.2: basic log -i --grep='int'           7.40(7.08+0.28)   7.19(6.92+0.20) -2.8%
    4221.3: extended log -i --grep='int'        7.43(7.13+0.25)   7.27(6.99+0.21) -2.2%
    4221.4: perl log -i --grep='int'            7.34(7.10+0.24)   7.10(6.90+0.19) -3.3%
    4221.6: fixed log -i --grep='uncommon'      7.07(6.71+0.32)   7.11(6.77+0.28) +0.6%
    4221.7: basic log -i --grep='uncommon'      6.99(6.64+0.28)   7.12(6.69+0.38) +1.9%
    4221.8: extended log -i --grep='uncommon'   7.11(6.74+0.32)   7.10(6.77+0.27) -0.1%
    4221.9: perl log -i --grep='uncommon'       6.98(6.60+0.29)   7.05(6.64+0.34) +1.0%
    4221.11: fixed log -i --grep='æ'            7.85(7.45+0.34)   7.03(6.68+0.32) -10.4%
    4221.12: basic log -i --grep='æ'            7.87(7.49+0.29)   7.06(6.69+0.31) -10.3%
    4221.13: extended log -i --grep='æ'         7.87(7.54+0.31)   7.09(6.69+0.31) -9.9%
    4221.14: perl log -i --grep='æ'             7.06(6.77+0.28)   6.91(6.57+0.31) -2.1%

So as with e05b027627 ("grep: use PCRE v2 for optimized fixed-string
search", 2019-06-26) there's a huge improvement in performance for
"grep", but in "log" most of our time is spent elsewhere, so we don't
notice it that much.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 4468519d5c..fc0ed73ef3 100644
--- a/grep.c
+++ b/grep.c
@@ -356,6 +356,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int is_fixed(const char *s, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (is_regex_special(s[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
 #ifdef USE_LIBPCRE1
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -602,7 +614,6 @@ static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre2_pattern(struct grep_pat *p)
 {
 }
-#endif /* !USE_LIBPCRE2 */
 
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
@@ -623,11 +634,13 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 		compile_regexp_failed(p, errbuf);
 	}
 }
+#endif /* !USE_LIBPCRE2 */
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 	int regflags = REG_NEWLINE;
+	int pat_is_fixed;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
@@ -636,8 +649,42 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
-	if (opt->fixed) {
+	pat_is_fixed = is_fixed(p->pattern, p->patternlen);
+	if (opt->fixed || pat_is_fixed) {
+#ifdef USE_LIBPCRE2
+		opt->pcre2 = 1;
+		if (pat_is_fixed) {
+			compile_pcre2_pattern(p, opt);
+		} else {
+			/*
+			 * E.g. t7811-grep-open.sh relies on the
+			 * pattern being restored.
+			 */
+			char *old_pattern = p->pattern;
+			size_t old_patternlen = p->patternlen;
+			struct strbuf sb = STRBUF_INIT;
+
+			/*
+			 * There is the PCRE2_LITERAL flag, but it's
+			 * only in PCRE v2 10.30 and later. Needing to
+			 * ifdef our way around that and dealing with
+			 * it + PCRE2_MULTILINE being an error is more
+			 * complex than just quoting this ourselves.
+			*/
+			strbuf_add(&sb, "\\Q", 2);
+			strbuf_add(&sb, p->pattern, p->patternlen);
+			strbuf_add(&sb, "\\E", 2);
+
+			p->pattern = sb.buf;
+			p->patternlen = sb.len;
+			compile_pcre2_pattern(p, opt);
+			p->pattern = old_pattern;
+			p->patternlen = old_patternlen;
+			strbuf_release(&sb);
+		}
+#else /* !USE_LIBPCRE2 */
 		compile_fixed_regexp(p, opt);
+#endif /* !USE_LIBPCRE2 */
 		return;
 	}
 
-- 
2.22.0.455.g172b71a6c5

