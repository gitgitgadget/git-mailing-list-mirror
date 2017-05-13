Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA9420188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757248AbdEMXQ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34023 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbdEMXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:56 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so11212194qtb.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qChLjPWMksS6+A1u3X/INnjIp25DdjDwGWfsz186jfY=;
        b=PEvpcrKZ18cyixw8QWrkJA64Mc63YLP3kyQEY07wVJ46luhcJ1Qkstc0xR/McYFzRJ
         VHqyJQLxUV0r6DOUkZyEI+aSBLIwn5FcUjK++h7QmCcRpsJYuB0igivYcV6GNALUItwt
         GKHeTUIvFwNPn6fdJhhFtjtswLgsDfG3G3kH+uc8twct6X/6mRR9kxlkg76m6IH0tZAe
         fp/s0RS0/roQ952MNeUlhXq0Wh73HaABRJK+BoNXtbR7EPn48Z50gL4vzgIl+3P6vWCR
         z1+N4opj8WFmWsTuDo4oXnHTI42K9FIbEoobm24AOb11Kmv//ZtRnVY5TVHUXBD+TE/l
         oWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qChLjPWMksS6+A1u3X/INnjIp25DdjDwGWfsz186jfY=;
        b=it6UFL093lWsG/sl/dKINJWp4ayylOIm5qpLSh8orjjo00VT1AhRynsiMAifRTloU4
         9pJLZcqAK527JmGz+QOCkBjxDaIdihql1B+YNLlsE85VNqhLhywGjQnXRkwMW1eVeCiX
         cS531X8hXbz6O4NkpAqwe8HdECInkhzSorHdm4RWvXTaECTYOzKpxUfk0v5ci9oElh5c
         GtFV1g0LuVd+9kW81Tpp3NIYqhDJ+Or+Dy4028T1vmGFctn4xtdYvwIC8DHudaJfVK8t
         rPVEFtYabj7nek8UNZvdC4+2dcC4/GrRPmaXvvRRSNoJzyN5rnRnieStyG3b93Hh0pUb
         DPEw==
X-Gm-Message-State: AODbwcBq3TAJeYllmnGqwqNbUSLtVp5bzVblErsjPPpgA5cCFiGdHYnw
        I+FnnFeAHo35yg==
X-Received: by 10.200.36.232 with SMTP id t37mr9510711qtt.264.1494717414865;
        Sat, 13 May 2017 16:16:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:54 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/29] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
Date:   Sat, 13 May 2017 23:15:00 +0000
Message-Id: <20170513231509.7834-21-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove redundant assignments to the "regflags" variable. There are no
code paths that have previously set the regflags to anything, and
certainly not to `|= REG_EXTENDED`.

This code gave the impression that it had to reset its environment,
but it doesn't. This dates back to the initial introduction of
git-grep in commit 5010cb5fcc ("built-in "git grep"", 2006-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 59ae7809f2..bf6c2494fd 100644
--- a/grep.c
+++ b/grep.c
@@ -179,7 +179,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
 		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
@@ -191,7 +190,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
 		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
@@ -414,10 +412,9 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
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
2.11.0

