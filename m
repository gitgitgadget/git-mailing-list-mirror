Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA6D1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbdEKJTr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33751 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755246AbdEKJTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5505826wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=b7p88OsTcRKlHntMP4GmhcplwTe+rvimiPnBsZMKB+Dvy3O7iOmSfjaPM9Q7utMkFG
         tN8qp3Csy/LMNsqON10NpahejGg6pGRoCb/5Y14IDDOQBkjkuCv2TTK4PYjVgqA5uRFj
         y7NVrz6eJGiN0c/dJDkP2UK4zqi9zNQB5EI4oNU0hxA+G3U4Q1KwPFSshdVlicd0unIP
         NSThslDkYcwdXVwKHPQfFy8B7NytGU3HfVpnt0PZyF5LpIpxdpKwwMcMNOgkqwgnKyuc
         7Y2g53hkU1Fbm9yaQFCn/NrvAPIqlXRoxDUM0Npkflr/mJB1KbcD4xO93qtFpSrVyU4I
         s9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=KYAveKjiu7C+hJyFoaM2Tfppkdp9M2pppPd21a0uDgJsIPYZyX7G+y/2Aa/2Eduv2T
         DLITn09S9rwUQmeAneL5V36Sj8lREdkWzjanvl3gvL7OyJHQAY7KM0t4EC321cu6ksyh
         iKZCNDUZc/RwGXEqnmwjCs2ue/2QavS8tBaSBwz9nHKLZ+m97Sd2aDbPy193pnsAV1lV
         yXS7gKzCLM9wqDV4RT24Ozvuv6C50p+AZwoCC5pjYxTxcaRyjvyc116AdjfuASDn7BhS
         vbXqWuLKTSFtmuC88laOZThgbmT7m8VS/RFH0STO+xaagAe8FII/VZz8JxaaE5spWTv6
         eSSA==
X-Gm-Message-State: AODbwcDmwtl0ofW5JSmycWcsNS8vhnWr6n+h5Db9V6v329g4RhJttA0J
        WyBmQT5TtKVNpg==
X-Received: by 10.80.208.206 with SMTP id g14mr8299edf.71.1494494382599;
        Thu, 11 May 2017 02:19:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:41 -0700 (PDT)
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
Subject: [PATCH 19/29] grep: remove redundant regflags assignment under PCRE
Date:   Thu, 11 May 2017 09:18:19 +0000
Message-Id: <20170511091829.5634-20-avarab@gmail.com>
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

Remove a redundant assignment to the "regflags" variable. This
variable is only used for POSIX regular expression matching, not when
the PCRE library is used.

This redundant assignment was added as a result of copy/paste
programming in commit 84befcd0a4 ("grep: add a grep.patternType
configuration setting", 2012-08-03). That commit modified already
working code in commit cca2c172e0 ("git-grep: do not die upon -F/-P
when grep.extendedRegexp is set.", 2011-05-09) which didn't assign to
regflags when under PCRE.

Revert back to that behavior, more to reduce "wait this is used under
PCRE how?" confusion when reading the code, than to to save ourselves
trivial CPU cycles by removing one assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.c b/grep.c
index 47cee45067..59ae7809f2 100644
--- a/grep.c
+++ b/grep.c
@@ -197,7 +197,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
 		opt->pcre = 1;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 	}
 }
-- 
2.11.0

