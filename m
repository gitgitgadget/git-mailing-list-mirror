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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC1D20280
	for <e@80x24.org>; Sat, 20 May 2017 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbdETVnw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34049 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdETVns (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so24397354wmf.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2pgMIXwCl9FG9wBoaT1RBpCIPjVhEpdor2sV6aRtes=;
        b=kuVvg8zuuzdn0Rj47iHc1Hr2ovCtx6wmy5PLHGIiGDkTg2cDfNISbDiVXkpfhaJdMk
         9ojzwf0fsFsp6R+Uiy43I9mS0HcHtCUhJwplwUgd84tRTeib6Zq14Mr2gSIFlyyzmcY9
         rBLiD28FzhK3tQvs/w9rsCDN5xu7wRWgRT7xtmiSysG9+zhnIUmZ6VDpARwceduJIjc9
         PbSkTG+8nMWr75OI/BOIC08DWNVhX6zJINwKFgKB1S8bh+5kB3vLoumpUal5MkuWhV5W
         8/U65pWxyQG8NxnRS0qeMevVy3TR/4ZDejb/jpvkTMIKduAZyRX7X1TM5aU9mSxvqyxk
         n+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2pgMIXwCl9FG9wBoaT1RBpCIPjVhEpdor2sV6aRtes=;
        b=Zpcdd0p1fr2IV8YW+l7DUj7adOh/w15pZUf5c0H1deHHhOFTJXd9Q9vYUzkJQaH7EY
         xYb5fJnNsu3+ZhLkPZsuJZTF3mfjnCT6yXBFPGhSQ/nv0d3gW0oNiHf1rkZQJQ4tWx9M
         m37moIatmCqxh7QtwjegAAlh81ZNRsC9YrwIH3y9zXP1A/35WNg5t5D5+XOaBmMmQWrl
         D6ArA4XEFgEEhlEv85XbSTkBmRDCUKdpG9K37rocv39wIIz5UelAGURYUEBkKh1meHgs
         DxbJYZK6dG+8Xkltu37XOPqKx4weX3HNCcd60muo5H3u2HzXYPau9LQhtUKQetcHOZoe
         d32g==
X-Gm-Message-State: AODbwcCndcopgDiSQ+GT9cXUn/GN7QboIikgP87SdRV3Pl3Hbownx0um
        546fsuHFqTVKbQ==
X-Received: by 10.28.21.13 with SMTP id 13mr10375153wmv.13.1495316622001;
        Sat, 20 May 2017 14:43:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:41 -0700 (PDT)
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
Subject: [PATCH v3 21/30] grep: remove redundant regflags assignments
Date:   Sat, 20 May 2017 21:42:24 +0000
Message-Id: <20170520214233.7183-22-avarab@gmail.com>
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

Remove redundant assignments to the "regflags" variable. This variable
is only used set under GREP_PATTERN_TYPE_ERE, so there's no need to
un-set it under GREP_PATTERN_TYPE_{FIXED,BRE,PCRE}.

Back in 5010cb5fcc[1], we did do "opt.regflags &= ~REG_EXTENDED" upon
seeing "-G" on the command line and flipped the bit on upon seeing
"-E", but I think that was perfectly sensible and it would have been a
bug if we didn't.  They were part of the command line parsing that
could have seen "-E" on the command line earlier.

When cca2c172 ("git-grep: do not die upon -F/-P when
grep.extendedRegexp is set.", 2011-05-09) switched the command line
parsing to "read into a 'tentatively this is what we saw the last'
variable and then finally commit just once", we didn't touch
opt.regflags for PCRE and FIXED, but we still had to flip regflags
between BRE and ERE, because parsing of grep.extendedregexp
configuration variable directly touched opt.regflags back then, which
was done by b22520a3 ("grep: allow -E and -n to be turned on by
default via configuration", 2011-03-30).

When 84befcd0 ("grep: add a grep.patternType configuration setting",
2012-08-03) introduced extended_regexp_option field, we stopped
flipping regflags while reading the configuration, and that was when
we should have noticed and stopped dropping REG_EXTENDED bit in the
"now we can commit what type to use" helper function.

There is no reason to do this anymore, so stop doing it, more to
reduce "wait this is used under fixed/BRE/PCRE how?" confusion when
reading the code, than to to save ourselves trivial CPU cycles by
removing one assignment.

1. "built-in "git grep"", 2006-04-30.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 47cee45067..bf6c2494fd 100644
--- a/grep.c
+++ b/grep.c
@@ -179,7 +179,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
 		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
@@ -191,13 +190,11 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
 		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
 		opt->pcre = 1;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 	}
 }
@@ -415,10 +412,9 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int err;
-	int regflags;
+	int regflags = opt->regflags;
 
 	basic_regex_quote_buf(&sb, p->pattern);
-	regflags = opt->regflags & ~REG_EXTENDED;
 	if (opt->ignore_case)
 		regflags |= REG_ICASE;
 	err = regcomp(&p->regexp, sb.buf, regflags);
-- 
2.13.0.303.g4ebf302169

