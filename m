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
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B171F461
	for <e@80x24.org>; Wed, 26 Jun 2019 00:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFZAEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 20:04:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55810 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfFZAED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 20:04:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so244331wmj.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdoNQ0TfJ/p4eBhW4Nkh7l22S810fjQXtqd37reEIJM=;
        b=m8xv+sHhSseoJfwfd2xbevoHvUyWwyXuBELo+ODTDh1WcsXGEtd0ZKgITThLlnkfv7
         Az8DIQjtYh0dvJUvmjU/DqDOMvd5SV0wV6i7X+JhRUTeKbp3dSRn7H13OgjpzIHVQps9
         2e9hxNaAX2BOf/jFlu++c48DHRXjC33tqBhppVJCAIDGsgqWxKsvjwUii3HrISJj/HRl
         /OgqLNFiDodtIcf7yhYuUBlcgRHZQ/+6SvLb6kg/fFhbm+PvhPQpZHHa+rJ/UIduCU1V
         E7nRfdzNHTH/ojo9JTUwnvCLmhvxLuK3oiP4bc2mqaNZksO3NOlGSMuuIyKgJu2LjTYF
         4hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdoNQ0TfJ/p4eBhW4Nkh7l22S810fjQXtqd37reEIJM=;
        b=K0i9ZumlK7WSpUPbJS5ldD72bklp0GwA/3mqTOwh+aLSg/gf1EXzlrzmrtKl+35Jxa
         DLNlamVHJIR5a4FM5/79bzsO+MAL0TnLe2ArZ+8RrqrHTe59T2Mmplw/zuOukbjNlbdl
         F+Pmwk9E4LFi/hFxXRa6Lc7F8dpXhBT2GsJoTwN2vBou07UxhTmYpeepxAANZHrka5nL
         Sh35PxcG43YhWYysqMcOSEx3DNyreaA6nqSHEG1RyrBCdat8C9T20rS4PDX3B9KodvrW
         /OvW55JwS0a5EKds6eqj034/8f4T2I76TpxR2lkUUAa37Z0vm6rVeWUdr8gNj26fTCVH
         Cytw==
X-Gm-Message-State: APjAAAUf17J6KhSjW0gYmuVbNbN0NW23R9NX1UTMNEyoLpAKY0eNgnLm
        C11iDeGkCrP0tYAShlcedsIgD5TjyRo=
X-Google-Smtp-Source: APXvYqzr+DfSON7LZirTGZgds97Ql3LbuotzYAYbbxVIHDj2Ry9cxJEU4Za4FuNqvS/2QkPyVffcsA==
X-Received: by 2002:a1c:9a03:: with SMTP id c3mr45534wme.101.1561507440319;
        Tue, 25 Jun 2019 17:04:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm33645982wrg.40.2019.06.25.17.03.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:03:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 6/7] grep: remove the kwset optimization
Date:   Wed, 26 Jun 2019 02:03:28 +0200
Message-Id: <20190626000329.32475-7-avarab@gmail.com>
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

A later change will replace this optimization with a different one,
but as removing it and running the tests demonstrates no grep
semantics depend on this backend anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 63 +++-------------------------------------------------------
 grep.h |  2 --
 2 files changed, 3 insertions(+), 62 deletions(-)

diff --git a/grep.c b/grep.c
index 14570c7ac1..4716217837 100644
--- a/grep.c
+++ b/grep.c
@@ -356,18 +356,6 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
-static int is_fixed(const char *s, size_t len)
-{
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (is_regex_special(s[i]))
-			return 0;
-	}
-
-	return 1;
-}
-
 #ifdef USE_LIBPCRE1
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -643,38 +631,12 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+	p->fixed = opt->fixed;
 
 	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
-	/*
-	 * Even when -F (fixed) asks us to do a non-regexp search, we
-	 * may not be able to correctly case-fold when -i
-	 * (ignore-case) is asked (in which case, we'll synthesize a
-	 * regexp to match the pattern that matches regexp special
-	 * characters literally, while ignoring case differences).  On
-	 * the other hand, even without -F, if the pattern does not
-	 * have any regexp special characters and there is no need for
-	 * case-folding search, we can internally turn it into a
-	 * simple string match using kws.  p->fixed tells us if we
-	 * want to use kws.
-	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
-		p->fixed = !p->ignore_case || !has_non_ascii(p->pattern);
-
-	if (p->fixed) {
-		p->kws = kwsalloc(p->ignore_case ? tolower_trans_tbl : NULL);
-		kwsincr(p->kws, p->pattern, p->patternlen);
-		kwsprep(p->kws);
-		return;
-	}
-
 	if (opt->fixed) {
-		/*
-		 * We come here when the pattern has the non-ascii
-		 * characters we cannot case-fold, and asked to
-		 * ignore-case.
-		 */
 		compile_fixed_regexp(p, opt);
 		return;
 	}
@@ -1042,9 +1004,7 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (p->kws)
-				kwsfree(p->kws);
-			else if (p->pcre1_regexp)
+			if (p->pcre1_regexp)
 				free_pcre1_regexp(p);
 			else if (p->pcre2_pattern)
 				free_pcre2_pattern(p);
@@ -1104,29 +1064,12 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int fixmatch(struct grep_pat *p, char *line, char *eol,
-		    regmatch_t *match)
-{
-	struct kwsmatch kwsm;
-	size_t offset = kwsexec(p->kws, line, eol - line, &kwsm);
-	if (offset == -1) {
-		match->rm_so = match->rm_eo = -1;
-		return REG_NOMATCH;
-	} else {
-		match->rm_so = offset;
-		match->rm_eo = match->rm_so + kwsm.size[0];
-		return 0;
-	}
-}
-
 static int patmatch(struct grep_pat *p, char *line, char *eol,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
 
-	if (p->fixed)
-		hit = !fixmatch(p, line, eol, match);
-	else if (p->pcre1_regexp)
+	if (p->pcre1_regexp)
 		hit = !pcre1match(p, line, eol, match, eflags);
 	else if (p->pcre2_pattern)
 		hit = !pcre2match(p, line, eol, match, eflags);
diff --git a/grep.h b/grep.h
index 1875880f37..90ca435aad 100644
--- a/grep.h
+++ b/grep.h
@@ -32,7 +32,6 @@ typedef int pcre2_compile_context;
 typedef int pcre2_match_context;
 typedef int pcre2_jit_stack;
 #endif
-#include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
 
@@ -97,7 +96,6 @@ struct grep_pat {
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
 	uint32_t pcre2_jit_on;
-	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
-- 
2.22.0.455.g172b71a6c5

