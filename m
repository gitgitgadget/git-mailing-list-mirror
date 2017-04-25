Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10CD207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954710AbdDYVGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36448 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948415AbdDYVGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so18442832wrc.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=PC8O9RkE5BgrcpwZIJT3Mcz6ZMhzJUnEXYK3CuvVttIuh2KaVF8pWP9mn0v2TuOkIv
         BwMfovo1+Puoq4iVLygNGcCV9grhvfikXOpyEtuPlh4SSA1UULXFX1dUl81a+3t/Sz1U
         p8EiNw66Gm1QZLZ+tolWyV6S7mSLNR3+8Qx3n1H29+wAHMXsanDj+GrPvUpMAz7QLmBo
         IcGlT1mau4BYPvJtB8on+G25EeYfDU+bzVLhL3FwadB0TFFcgR2pFqybVaO03RpVVg6c
         +N6eUs36JkgRDgwKFdZweRZYgSsPm/RE3M0D4u5igg6966KCKxqLkvGdUkttl8dla1wP
         b4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=mCepuzKQ1PnkV/9OXZ8UfST+lOWoLgMoBgpBF5obKeRuOPRI++CHEntEpLAwrO8AjJ
         vnrQxlghsufl7/7qOBRbGQcRKw5LA747ia8kJxS3OgAD3PSJQDHM42ijBsYtmMps4BFw
         s1qB92pzO0NNHRdjiQCiS8LyX99zb3gWUl1nLyWEORxAfpwTDZEdfkDcfXAN+KzFPE9K
         komNa3GEnETxzhXkFE70bWKdU8WuuYRWCnpkMQuRWsKhkZ2i/azoc5VXvVv1g84UINTW
         Yu35XoMrfzUNgX/bWzOy4LwHhh0YB0vYt85+SCOgxWDywkXtTv3ykAf1TIXZXoUxnFkt
         dzsw==
X-Gm-Message-State: AN3rC/6HD+myWOdN3fLdGj/f0DX+qinkxkYAGfyGlfNOKlQCUaUR6A5a
        glp+CS5DxTc2bg==
X-Received: by 10.223.165.138 with SMTP id g10mr12638985wrc.19.1493154374045;
        Tue, 25 Apr 2017 14:06:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:13 -0700 (PDT)
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
Subject: [PATCH v4 04/19] grep: remove redundant regflags assignment under PCRE
Date:   Tue, 25 Apr 2017 21:05:33 +0000
Message-Id: <20170425210548.24612-5-avarab@gmail.com>
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

