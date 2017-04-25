Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA3D207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954713AbdDYVGV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33691 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954709AbdDYVGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so17339340wmh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AoozIM+7P8Rem4eQTct+Uw8dm3LhbaWzJQxUtDgGgw=;
        b=OdtNgalO2U/LMmAt+68U3ajtbtGuxSsAvNlg/6+XWUuhAw+3fWrdSG7DOXziWOU/UE
         Shqhy8nB+J0wwEofu8MnyG6U2L+zYyY6i+xtCZzD10cnsjAvSe12xcqWkVj0lUqf2Z1O
         yPybSbH2SqXke5dlCe1dKnxYHmAXnDe/mrGthXFt21Ie4SdPWxCMv/85daQcyDf4yjJc
         lPqcor/2OyY0KCU5PXV0zkAxf5QxMWeIcfJvY746r348PEtG9/QTj12s9c/AasNDcITq
         bwjiQVfjpX3e+R1sjpfHth9X1y9/TQFxpcCuucUDBduwzmhytfftAM+iQRCzxs2Q2fq3
         zW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AoozIM+7P8Rem4eQTct+Uw8dm3LhbaWzJQxUtDgGgw=;
        b=EZlHmruf19z7Eg3O67Ohvg6K4ShfOYDt811C0V8QPfgR0CQESlF/w71BB5a9uF6zgC
         +5MG+HFfB6rXJqvU7EuRCofbi31OAXHiswG2zhu4TBeWqJ59X7QuvzJEIa/8npatDpYy
         iziNWGBZ0++uUlrLgOUO7YuOBPzCfyqr93TcgVD5EV1Wm+5Bmkp9viXRSYtf5+VAEDzZ
         +qyvyQbPd4kH8rDh1JubnxuIvrNryZbrzXRxCDLqc3QUkxkaoTGKs/XeHUhiQtYlIAia
         l+0B49kR8TAyIEB/+wf+VN4xjdOotzteiclwpYnU1N+ytKjLauJvuyPYovhsIMvbsqSD
         3llQ==
X-Gm-Message-State: AN3rC/67IMUn3oBeHTVbUOXjgULcPwqSzGuno199oY35zmF2/Cue/QSp
        JuUMFp2YOvb6Fw==
X-Received: by 10.28.10.67 with SMTP id 64mr14717454wmk.126.1493154376641;
        Tue, 25 Apr 2017 14:06:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:15 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/19] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
Date:   Tue, 25 Apr 2017 21:05:34 +0000
Message-Id: <20170425210548.24612-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
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
 grep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/grep.c b/grep.c
index 59ae7809f2..6995f0989a 100644
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
@@ -417,7 +415,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 	int regflags;
 
 	basic_regex_quote_buf(&sb, p->pattern);
-	regflags = opt->regflags & ~REG_EXTENDED;
 	if (opt->ignore_case)
 		regflags |= REG_ICASE;
 	err = regcomp(&p->regexp, sb.buf, regflags);
-- 
2.11.0

