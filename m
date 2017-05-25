Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD6F20284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036738AbdEYTrj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34716 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036732AbdEYTrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so55399819wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2pgMIXwCl9FG9wBoaT1RBpCIPjVhEpdor2sV6aRtes=;
        b=OMb7KCNphRDzhHi+iQSjDzdnqw/d8amOOP46LCFCuu9zMW8ouQI2ekaPLNNLJKSbF2
         PPO5NJlA1J2Zgum6s1IlGYpw8hT1aLDx21ooVFhJLm5DYq5zIt61opDDz4mXXbb2ULna
         9vny0yR11KPimoDLogM9jU0GG/bdBf9WEEB06Yr/9XVXZZBG0Q0/s1qKWYhUUizi49nl
         isrZ0pkxPuCeDjR/3UdS9WKrj0JJI6mbcbHE+hLULYW3mf+0zDy3VDXtiKBdvljFZ1lC
         cgM7yrDtM8zKPSzbLBTyhgBQksVVwiz81AKzcro3V1FsMgvkg0EGl6fzJTfUSHbEcQ0X
         A/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2pgMIXwCl9FG9wBoaT1RBpCIPjVhEpdor2sV6aRtes=;
        b=nblf5+PFlQWFTQZSsGct4diXVN4Gta0iJ1hCbypWq3qrhmt+JiPUtNiPo1b3Q4FoGv
         ow7F0St48fIV8o3wBnkpFLpNYmJrx5FE5ffpiWRtlBjaMOXy6tSBlT1CH5799VnBzzVw
         9Lu8mMvVjkU+dfgM31ZIgRL3biKHr2EK5hbpMc5VqqAsHPbEWpolwJJsBowaNoUp6S/q
         mcdbYBdSk88fRw/I9yR3nUOC3zHiUJ34j6dc7NdFElgZYvlmrKG/qIKp2zJ/1zDxOI4I
         lcoPt6k8rbJBvj2YHpg9MgVGA+oC1Merf92ZMR1/DJK1uAtEck7i2/nmKoZoVpuZmQZS
         k0Aw==
X-Gm-Message-State: AODbwcCmZOMJyj85HE/5WoeQCwaZJTfSoysjsv/p3YeJDylT8Faq9YOd
        Aq245lR3tV85xQ==
X-Received: by 10.28.130.196 with SMTP id e187mr11702770wmd.24.1495741632211;
        Thu, 25 May 2017 12:47:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:11 -0700 (PDT)
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
Subject: [PATCH v4 22/31] grep: remove redundant regflags assignments
Date:   Thu, 25 May 2017 19:45:26 +0000
Message-Id: <20170525194535.9324-23-avarab@gmail.com>
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

