Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79FF1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbdEKJTw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36012 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdEKJTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so2614105wrc.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qChLjPWMksS6+A1u3X/INnjIp25DdjDwGWfsz186jfY=;
        b=h8lujg792eggT1YTrXa0l/xLDokFnXDpPJT5wlXSvUVmojS9C3iHMmTb4QO8qmchYC
         SWC4BqTFqeuS1GHWWH3P3iiHr2VogK1Xg/Xx3xmz0rasqfX6pimRByOiRcRQ+PSbRIBm
         CZV2TARy4IIWNZH4yCEe9Vv4RExlk04S7Gf1rg5z6VO2ifp4CFnd1yUBsN6Iw6lgXPrX
         Kq5/sJtb0rppcVRQNmml6JlmMkuOuEU7RZkoMlzJg/RvWHTycr798fEGjerbGW7BaAf5
         PYWisR0YnGwXsACnEBtbpZpgnFXB0/l22RPRQzSTxA2xaEMf5krvHZiBanxGJiWJ7Yxa
         /nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qChLjPWMksS6+A1u3X/INnjIp25DdjDwGWfsz186jfY=;
        b=bK7cZJX77W5ahkdsAsT4GtHKG77eBL3iotzP10vwXdUKcxWK0dK3OQWowR6WtwUh1w
         7i6ZQz9biNvjSnhjtVZccfPdAvhjF+MS1NR5BXSSZ5KWM2cOSaDmJQ5f9+NC8JvdkHBd
         zYcWbWpbKwShDElv9qEKXCm2flZ7nt07M7H2d1GYViOZBE4vIbAOv3hTYgaYWYjDRlq2
         Ebc+BfGkk8jkjTMFMaJkp7lp+e6qAs5fRSAQU4nz8OIMvFo1WjUs3V2SIHbER0zxuo+n
         z+Vf7WFd39Sy34sY2NtU/7hd1fi8HpKZHl4jRqWwMm4slgi0tOmhqDNZUQ70GVg6fBmD
         Kz0g==
X-Gm-Message-State: AODbwcCFfUUqU6Ay4rkyf8BM5x3ze9xqzE26NBKQmUWy5P/lPLGF25CX
        PyrEErsTdQR1uQ==
X-Received: by 10.80.154.197 with SMTP id p63mr10088edb.59.1494494385872;
        Thu, 11 May 2017 02:19:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:44 -0700 (PDT)
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
Subject: [PATCH 20/29] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
Date:   Thu, 11 May 2017 09:18:20 +0000
Message-Id: <20170511091829.5634-21-avarab@gmail.com>
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

