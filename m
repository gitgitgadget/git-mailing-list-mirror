Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF53207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 07:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S948081AbdDZHtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 03:49:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34030 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1435291AbdDZHtL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 03:49:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so30976915wmb.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/BII2U5tXVY/TMgQOk25KGPHixWfxCQClPbkO0Jq8I=;
        b=a4NN0C8ScMpAbzFhawdagZmLLxolTw0fvsd6GEXeCCWna4qK3heThLpnrPZF+zRjrN
         T5dlR4s/YeBRybO1fHnVKLHLAjpEV9tej794xWdAuTxIfjqhhLikUBNE6TLJa7R3U6zn
         vCF5Rq0jFeWwRB42qGgqKtE+vo5Z1kjFkRgyqyh33JAGh778zM0xqe0KdrYCNVxASRsK
         mtfzD8tRhsb2WTJF/BYqD0r373xKtGe2hwhdrJeEtgE/E31mysqBeveeJ34H0BEHlpI/
         wgD+Pi9cMbetQ+MRuSHJ8l0384Slw91PMDDIcqSuKXPVXcOYi+CsO+jIz6BRWpZkLU8K
         U+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/BII2U5tXVY/TMgQOk25KGPHixWfxCQClPbkO0Jq8I=;
        b=maT+Y40Lo9bamJiwmcSmOS4FTKmWkKLU0sZq0gaUucBmJv4r09m7E0X+8uVwueJAYG
         7PFziWUl8f7yIjaDUAPPNC5HNgVcx0BEO5oARcM4SBex4U95pSiTuhufiAlnEQ8C4Rzh
         vozSDOTC4h6CgdaP1HjcnbvqrODT/JuqvQfx79H2zZd3NrUxaKdo+Z+Jp60i0N1fG2F3
         zwN9USbJPa3W+tH4EcmNlH8XE5cVzI+O1OKC5FAu4PUQBbhZUUzV3QngIilX2mk/K0gE
         M5dRGdZ+o2hOmzdCwOzUppS8SLmukE5j1aB5u2OTCduD8hNKtUkI41JRaqK04zbSX/fp
         OgWw==
X-Gm-Message-State: AN3rC/5X4ojdR0xPleukd68M8Wfvs1aJutX/2YodBlXNKOIrulnMLYQE
        /eSg6rRqePI/VQ==
X-Received: by 10.28.232.137 with SMTP id f9mr4520778wmi.116.1493192949973;
        Wed, 26 Apr 2017 00:49:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 3sm28892146wrv.33.2017.04.26.00.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 00:49:08 -0700 (PDT)
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
Subject: [PATCH v5 05/19] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
Date:   Wed, 26 Apr 2017 07:48:56 +0000
Message-Id: <20170426074856.29903-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqvaprrb37.fsf@gitster.mtv.corp.google.com>
References: <xmqqvaprrb37.fsf@gitster.mtv.corp.google.com>
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

On Wed, Apr 26, 2017 at 7:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> @@ -417,7 +415,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>>       int regflags;
>>
>>       basic_regex_quote_buf(&sb, p->pattern);
>> -     regflags = opt->regflags & ~REG_EXTENDED;
>>       if (opt->ignore_case)
>>               regflags |= REG_ICASE;
>>       err = regcomp(&p->regexp, sb.buf, regflags);
>
> This hunk is wrong.  Now the use of regflags we see in the post
> context is mixing ICASE bit into an uninitialized garbage on the
> stack.

Oops, sorry about that. Here's a fixed version. Just sending a v5 for
this, not the entire rest of the series. If you'd like to grab it in
.git form it's github.com/avar/git:avar/pcre2-5, this is the only
change from v4.


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

