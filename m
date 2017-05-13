Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6F620188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbdEMXQ5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:57 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35365 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758875AbdEMXQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:52 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so11222485qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=VYlqjV/fwg6NTSnXbXvIujBhqa0n4K/tap7eCwwvfM8SpE6A+z5rEjH0uhkHIoDGJ8
         NJLAbgpp+4KiXQAxmZZyQg7bRSCDTFcgETCRdXXeFHygWYsw07Q5+tOVPMuOEPUVoCLm
         11UfAFomxOqr6GpTf+mFBsJ+uR6/6DOde0Wyg46G8mI80qgCSSd+E1+on7QU0OpOzK5r
         cydzNNpFeS3n17bltK0e1KpOFP4jPHXc0f55/JZtMiH1nuR5N4psjtEPwS87PRT2Q1Eq
         YsibVOAuV9WUpFFH+DayNXRLYWk8sTjOkONuu5shhzthR9kNRMVsqpVhJH6xRXVxIqje
         d5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=SqG8YDWfVsmNJJpXSeiaQMt+Qr70wuTOFUSB+tMavRy8HHNMKkM2hdjKrBiITFso6A
         W/ANj/Io8WQnSnZH+6Z1H4eHYD/kCsh1Jkx9vCCkksUWLVvZ8UtIm9inJwxicMV5VLUA
         gew1X9txmpEBUg7kPdF7sHjCbbNnyICQvq+RrgjKBuF5CpTC7AnTLQZvr3WY/opnMCY2
         3+4j/24NIo9/leIbbjmIdqOb1xRiaqLSAhmWetcob1q4az2YMmioyUG7pHwLCepExzsl
         7ang6s16qg4O6EbOyOKy8Jf4KMaMNgp9kiP6n4JYlG6iWfYvH3RIEKLXQ2KlRdgup79y
         I4lA==
X-Gm-Message-State: AODbwcBxQeDEUgcZA9jbTs9T6zRgbiD2/LyRtmpmIt78KMKF+2pO2TMg
        DeRnoH6XxVltTA==
X-Received: by 10.200.54.44 with SMTP id m41mr9773576qtb.273.1494717410582;
        Sat, 13 May 2017 16:16:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:49 -0700 (PDT)
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
Subject: [PATCH v2 19/29] grep: remove redundant regflags assignment under PCRE
Date:   Sat, 13 May 2017 23:14:59 +0000
Message-Id: <20170513231509.7834-20-avarab@gmail.com>
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

