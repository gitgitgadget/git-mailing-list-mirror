Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B261FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765012AbdDSWlT (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:41:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35955 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764929AbdDSWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:41:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so7514206wmd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=G4fqveozO+ROHzJuLdXwmt5C+L3ULgRxsvJk/Zhnh2sD1NzTSV1VeM560jwvofOFSy
         n17ZlSNgyEWNMLxYXwBqaEfI0/eACz4VlsveBzkT4RsUVHAXqyhjndIbMuCI+SKcoxwz
         82yX1yQhx2RMZnVmlKg5cqxS3VtaRlDeqDU0WWi5QtOIBRMrvmFbFPv882NZ4QqNJk2J
         d1QmGB0w5DFUTAY1TaodkBmboB1NM+mqbTD8G4t3s6zbIUnCb/cgEafVNnplxqtoaXTo
         roDVwcUxDM1PgUWbqXllLCvb5r/rgYKbbgyv8z3ub5xPkQMbIeGM9shz7llzR9IoNCyf
         Q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=KNKAbRZUuaeis00lkBg4rrhS80C/ti0cKlQxeWBhgQIdy2JzZ/x0hNCkgUYOnYXQct
         4pRI7qu4EGnC28H/FXhEtOJ5k7hxHCU6VJ6Ylmz+WbcSGNfpotzmA99F0IR/u653zMCy
         lLgcxmHPtmwANSYgUXeIx4pMbR7uh0GVIhYzFYfVlaUj/WMMvDOYWRn3oVVZ7QbiE4yv
         8J7laC9rJvvmOdxIHnkBndZfMnjobuiLrH59AVBp5dPMzdcnAL0dS6V1ccPw+ZX324+2
         tgyFpX0kqVGd75+1YypMZ0o2FKJySA6XU1a+rJ7z/gMpfefH/pblBJU6jSgUkbKySQ9F
         RUxg==
X-Gm-Message-State: AN3rC/51AddWSofTWvyi+Y94JDp3i4kCD3QmZ5HqBPYisHv5EOFi80Bf
        giZEX8ntHP4lTVCOiM4=
X-Received: by 10.28.153.4 with SMTP id b4mr229546wme.58.1492641676810;
        Wed, 19 Apr 2017 15:41:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:15 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/13] grep: remove redundant regflags assignment under PCRE
Date:   Wed, 19 Apr 2017 22:40:41 +0000
Message-Id: <20170419224053.8920-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170419224053.8920-1-avarab@gmail.com>
References: <20170419224053.8920-1-avarab@gmail.com>
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

