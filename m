Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C1E20196
	for <e@80x24.org>; Thu, 11 May 2017 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbdEKJUC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33342 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdEKJUA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so5507790wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGvPPxxHgtVIIsw7ZBkH/PyLn/7tANXGtETPaIIXg2I=;
        b=ABAreEHsBeyyN8cnIP0hF3eZKINDbilLucLSd3gomwskUbCTFlHKhIhCjnz/a5HnnN
         Qn/aQ/knyD0Frao7Je5jL2EmjWzAH3O/tMknRntMVzjXCjhzxfpak5SDM9WjbMZzcDGk
         d/YcvZraHbpA3JyWE4Lw4kMoCLuu7uq3KxCaD2nzeNK2f0Q7rfLK9s4Ivvt4neTw0tzp
         HvDgAArpMYVeEBTH6Slv/7jGydjchqIORV32sXqv3akBrsj5K7E5UAcBIdyjwMY0q/5l
         8R51VQ1WeS8zznjYVHGA0dFn4k2SXqUOeomSm0rFhp+qtT8pzROiMR0hNecknjISSh8Z
         5QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGvPPxxHgtVIIsw7ZBkH/PyLn/7tANXGtETPaIIXg2I=;
        b=NuHFFgUZbNcWIkDNqHPuVN0ui7tl0IYO93/lUIQ1JRHhSYEo3XOAOJ4E/fHFP7+2RJ
         j/7lCvba/MbviBmUH2mwNwbx39XkMoFJ2YVJ0+utivF/R1ExC55rfFjJe44518C75xQ0
         aF7qBmDRnb/FiryR/QW+z6Adr6kgc1PVgTsutzovR+9pnYoOF1pgU405TjltLNOV5Hop
         +sP5GW9PzQtpT5vJGWbaGOJFhMRBBIY52fcnok0uUvt43WiuS0eHBVzxtP48XgowAQrL
         R5zX/7urLElYrkIGBTdaJv2emHD7FavlnjeQGS0Fi5bDTtDnUioD/Ua8mSIgX/e88xJA
         dyaQ==
X-Gm-Message-State: AODbwcCjjj/O+JJh9nUQ7kXOEBUFJCArSvWvsIfZjroQ5tzfjX1l1YHU
        V0O/oF5+dKgLPw==
X-Received: by 10.80.136.43 with SMTP id b40mr17503edb.25.1494494399023;
        Thu, 11 May 2017 02:19:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:58 -0700 (PDT)
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
Subject: [PATCH 23/29] grep: change internal *pcre* variable & function names to be *pcre1*
Date:   Thu, 11 May 2017 09:18:23 +0000
Message-Id: <20170511091829.5634-24-avarab@gmail.com>
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

Change the internal PCRE variable & function names to have a "1"
suffix. This is for preparation for libpcre2 support, where having
non-versioned names would be confusing.

An earlier change in this series ("grep: change the internal PCRE
macro names to be PCRE1", 2017-04-07) elaborates on the motivations
behind this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 52 ++++++++++++++++++++++++++--------------------------
 grep.h |  8 ++++----
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/grep.c b/grep.c
index 0977cac723..4507765811 100644
--- a/grep.c
+++ b/grep.c
@@ -178,23 +178,23 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
 		opt->fixed = 0;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		opt->regflags |= REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
-		opt->pcre = 1;
+		opt->pcre1 = 1;
 		break;
 	}
 }
@@ -322,7 +322,7 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 }
 
 #ifdef USE_LIBPCRE1
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	const char *error;
 	int erroffset;
@@ -330,23 +330,23 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
-			p->pcre_tables = pcre_maketables();
+			p->pcre1_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
 	if (is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE_UTF8;
 
-	p->pcre_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
-				      p->pcre_tables);
-	if (!p->pcre_regexp)
+	p->pcre1_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
+				      p->pcre1_tables);
+	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre_extra_info = pcre_study(p->pcre_regexp, 0, &error);
-	if (!p->pcre_extra_info && error)
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, 0, &error);
+	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 }
 
-static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
+static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
 	int ovector[30], ret, flags = 0;
@@ -354,7 +354,7 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-	ret = pcre_exec(p->pcre_regexp, p->pcre_extra_info, line, eol - line,
+	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
@@ -367,25 +367,25 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	return ret;
 }
 
-static void free_pcre_regexp(struct grep_pat *p)
+static void free_pcre1_regexp(struct grep_pat *p)
 {
-	pcre_free(p->pcre_regexp);
-	pcre_free(p->pcre_extra_info);
-	pcre_free((void *)p->pcre_tables);
+	pcre_free(p->pcre1_regexp);
+	pcre_free(p->pcre1_extra_info);
+	pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
 }
 
-static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
+static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
 	return 1;
 }
 
-static void free_pcre_regexp(struct grep_pat *p)
+static void free_pcre1_regexp(struct grep_pat *p)
 {
 }
 #endif /* !USE_LIBPCRE1 */
@@ -476,8 +476,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre) {
-		compile_pcre_regexp(p, opt);
+	if (opt->pcre1) {
+		compile_pcre1_regexp(p, opt);
 		return;
 	}
 
@@ -833,8 +833,8 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN_BODY:
 			if (p->kws)
 				kwsfree(p->kws);
-			else if (p->pcre_regexp)
-				free_pcre_regexp(p);
+			else if (p->pcre1_regexp)
+				free_pcre1_regexp(p);
 			else
 				regfree(&p->regexp);
 			free(p->pattern);
@@ -913,8 +913,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
 	if (p->fixed)
 		hit = !fixmatch(p, line, eol, match);
-	else if (p->pcre_regexp)
-		hit = !pcrematch(p, line, eol, match, eflags);
+	else if (p->pcre1_regexp)
+		hit = !pcre1match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
 				   eflags);
diff --git a/grep.h b/grep.h
index 073b0e4c92..38ac82b638 100644
--- a/grep.h
+++ b/grep.h
@@ -46,9 +46,9 @@ struct grep_pat {
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
-	pcre *pcre_regexp;
-	pcre_extra *pcre_extra_info;
-	const unsigned char *pcre_tables;
+	pcre *pcre1_regexp;
+	pcre_extra *pcre1_extra_info;
+	const unsigned char *pcre1_tables;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -111,7 +111,7 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre;
+	int pcre1;
 	int relative;
 	int pathname;
 	int null_following_name;
-- 
2.11.0

