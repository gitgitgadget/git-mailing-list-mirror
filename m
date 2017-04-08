Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFDB720970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdDHNZz (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:25:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33047 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbdDHNZy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:25:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id g19so23518902wrb.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jql5ImJA3RnvSDu++oN0MJRvDBfBpZPa1mbd0hqU1A=;
        b=TFMa/ozL7rGv7kRxgLQZ/gSrxNQNcZFE50HFSIRFQXtKGDEBa+xDtZaWIa3A10HwZq
         ymtPZUuPb2j6YH4GOP3ZlEpKTECm3ObfckcjpmcArzygPe/0j1EYEnYv1NKL4avSO3HR
         SBMk5/zhD//X5ujiVdlmdlc+Kq8dlZJYOHFSWsVcbuV6uoOoCPzcpw/F1cwHUdgnHrRM
         xnJdqovNTW2xAikrlr+GZG/7QX6UXqAQ+V81M4aAQWgLYdeOm5XF2GVyRpaRfalFnlEE
         z8Ant+LLED4v+oofzJhPLRi+g0XkKx3PC32xFJ1qbWfSa4rbGVYF42TKPNajPiRusuD1
         OwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jql5ImJA3RnvSDu++oN0MJRvDBfBpZPa1mbd0hqU1A=;
        b=FrkD2qnhECJ6dsZbNBnU9OGtAPXOVLjnGV+yRFpHINxxlT7msLldJN9e9AISNlp7gF
         VGHz6SghNyJ87H5DV0or0Lvah0ZgVflGINpx/nFNgGzbbENcj1r8G8GBnOppuuWUjXFi
         Sl1r9sJWak6ZnsUg/OX9OYmrhr/27SqnvmBUmf5kcBnQC3r9AuMJiYgL2uJVGkh8ajrv
         8A8Eyo3YYtLEZI7DcAgwJjiCstaXcYJbaK2yt5dzlJYT/HHUL+RMnLhmOrOasvgCcD9Y
         6ICSy/oaoLden+UmSNKeL39tXTUA5vGJ+sOVtfCekCuw4rZ3kVI8/Z0wxEcMYjDC7G/L
         /pBg==
X-Gm-Message-State: AFeK/H0aYyqVdEiF0LgxI/N0FX8lqUhlBFlpA9EZBIrsdsEyZ1gwWkS7xjd7gVMP6lmqqQ==
X-Received: by 10.223.136.125 with SMTP id e58mr14262370wre.73.1491657952821;
        Sat, 08 Apr 2017 06:25:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:25:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/12] grep: remove redundant regflags assignment under PCRE
Date:   Sat,  8 Apr 2017 13:24:56 +0000
Message-Id: <20170408132506.5415-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
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
index 56ef0ecbff..8564fe726d 100644
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

