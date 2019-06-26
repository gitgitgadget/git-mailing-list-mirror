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
	by dcvr.yhbt.net (Postfix) with ESMTP id 309311F461
	for <e@80x24.org>; Wed, 26 Jun 2019 00:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfFZAEG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 20:04:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38391 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfFZAED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 20:04:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so246651wmj.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9SKxjLFLCkNLtyr/Q/URwyOQKTPhocuapVNs75AUWs=;
        b=irhJZBgY5Ic2P0AqXZvYH5eI4jI3FRHwVyebq1n5dEARSsCX6EnOQ8BWo6gRHcnM13
         7JC/enMYJta453pIXFkMe8DpBcCuhdLO0904j+IfsITC080jhlReqOPWeE/m+apUtr5r
         jDmxiroqjOeqcf33TFElTE/15BDMqEMl8FkWVN4XJ7SnZzTKuEkU9lUqk+sRKiImOiE/
         L713uVdnDj2EiEBOvpQHjLtxhpMbXIKWLIJSHnNWaoCzdU6C+TeB6/Me+0GaeyhV82ae
         XnCQytHQo5vcW458HNY/PLp6vk9A9OUBpnRub9Gs6hmgDhUwGzqtAxGqcQg5kn+Iy8aV
         3VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9SKxjLFLCkNLtyr/Q/URwyOQKTPhocuapVNs75AUWs=;
        b=qewVHkKp/fnWkjYih4JANpu7h2z4mLHhqL/im8+j5f2AcVzg/7iZ6EMu0udVpWBIPv
         M2GaHyZRitEzGYjQeGjv1R4uzZZ/zvhBth+Q3X/Gge1Vf2CvzM525jKx4/FeUPJNEAOT
         w5JWBRAKIFIKvN3zg6udXUO76l9CFzBtKBDwcJvxFhC7vBdfsujdErxBeZG9j6j0QjH1
         ngUX4MwFIkhSxLF3lS1U8Aa/JUS7ANH4mnLjBGqetRpPXT+HcsZ/tk+ziQN2uGCoZKU3
         eD3x5GA0C9pboKMgxQLehLu1KaqkfPNE9crtghA8qYUD/DXesuVjrzCMhm6bJFQpc2fj
         d88w==
X-Gm-Message-State: APjAAAXTnX4/+y0hGLMEcrXnbJTH4Ptl074g/QVLKS1txHrJ2OpWC/v7
        AtG4Izb4W9PhpBQGqL2ln+7bo8Iy6s8=
X-Google-Smtp-Source: APXvYqzIIVsDaUp6Nv0flCofAPFnVM9pWONAm5nZzVDWbyR4sePBVim5roWy7Gp6CFTvq156HEIrGg==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr253466wmb.19.1561507441357;
        Tue, 25 Jun 2019 17:04:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm33645982wrg.40.2019.06.25.17.04.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:04:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string search
Date:   Wed, 26 Jun 2019 02:03:29 +0200
Message-Id: <20190626000329.32475-8-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <87r27u8pie.fsf@evledraar.gmail.com>
References: <87r27u8pie.fsf@evledraar.gmail.com>
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

This brings back the optimization for "-F", without changing the
semantics of "\0" in patterns. As seen in previous commits in this
series we could support it now, but I'd rather just leave that
edge-case aside so the tests don't need to do one thing or the other
depending on what --fixed-strings backend we're using.

I could also support the v1 backend here, but that would make the code
more complex, and I'd rather aim for simplicity here and in future
changes to the diffcore. We're not going to have someone who
absolutely must have faster search, but for whom building PCRE v2
isn't acceptable.

1. https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 4716217837..6b75d5be68 100644
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
@@ -636,8 +649,38 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
+			 * pattern being restored, and unfortunately
+			 * there's no PCRE compile flag for "this is
+			 * fixed", so we need to munge it to
+			 * "\Q<pat>\E".
+			 */
+			char *old_pattern = p->pattern;
+			size_t old_patternlen = p->patternlen;
+			struct strbuf sb = STRBUF_INIT;
+
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
+#else
 		compile_fixed_regexp(p, opt);
+#endif
 		return;
 	}
 
-- 
2.22.0.455.g172b71a6c5

