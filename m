Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7E41F461
	for <e@80x24.org>; Wed, 26 Jun 2019 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFZAD5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 20:03:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZAD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 20:03:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so250957wmm.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9L0gNaw3atoVAJlMx6D7/2ErCpu3IliNyyaS8shaVko=;
        b=TLZ7c/iahtIQwmpQ1OsdeWMjJK3FZI5kO4aTiOGhLXT+/c/1pSmxRVlj94R0G038o1
         xWETqHwXpIk80JuNDyzByQjJVRnK9tfUNXLYV8aewq78XV6afkVRGyGRMZ0cchQ6zQC+
         NUclhChb+iafF13lzBcplqqVL3iUiMA9/dyCFQRyNADk72TFw05pSs2btkH7cVhCKTTM
         9DDb5S1dUqu+iXgfPs8uMCZdjXjTNFEZdR2u5CB4fTrNtcb8Jwz3YSXTwW8cyOaq+CLm
         /x4dZbEA0anYd44j6adrwrPh89Xnul4CiWCL6/5mr6QZwS4q7z4WQD6jKRaeeSwzhZpQ
         lyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9L0gNaw3atoVAJlMx6D7/2ErCpu3IliNyyaS8shaVko=;
        b=LouUt3C+hoLunqwS49WS8QA0FCA9j1iqeyjr+Yz74sqMoIjahXDRWXSPZwc4ihfHz6
         2idRggpMnBRiOSIcjjA9dTGhaPGSSZgHxgcUfnkINzwmBF6+PiQMO6QyvwOjLSK8fwWW
         ul2YcUSu/Fa/Z3Go9qKUyDKR5Vwdy1Xua4Ww9HexPUM3s0lAu6KDLnMzT0rTvGW2vTME
         o79/wQaB2Jw3/OQjQ4nLbXV7fqi6djK/PnNpgCYtlHQAnuzJ1pKRytI7a8hkzsxkhUlW
         V5RxObZhwQ/mXGUuG1z8Q5XcQYw4/wQokmWPzWC4DQSHJogtt4xaHKhm14hrWgYCGV0R
         22Jw==
X-Gm-Message-State: APjAAAXzLfxQMvJGa8E691GAPRuN0CwDP2d5FqBnzvO370eZGvToasUW
        pnFJMJyh/itdW5ZUR78B9xtaf2Xa7yc=
X-Google-Smtp-Source: APXvYqyPasL7/LHaUpim5DT4nH8+SnClaI7zgFfN/cWs8LiiQfCgT6MYLwtIfKXhWbISPie+YfKKTQ==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr166003wmb.171.1561507433717;
        Tue, 25 Jun 2019 17:03:53 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm33645982wrg.40.2019.06.25.17.03.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:03:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 1/7] grep: inline the return value of a function call used only once
Date:   Wed, 26 Jun 2019 02:03:23 +0200
Message-Id: <20190626000329.32475-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <87r27u8pie.fsf@evledraar.gmail.com>
References: <87r27u8pie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e944d9d932 ("grep: rewrite an if/else condition to avoid
duplicate expression", 2016-06-25) the "ascii_only" variable has only
been used once in compile_regexp(), let's just inline it there.

This makes the code easier to read, and might make it marginally
faster depending on compiler optimizations.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..d3e6111c46 100644
--- a/grep.c
+++ b/grep.c
@@ -650,13 +650,11 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-	int ascii_only;
 	int err;
 	int regflags = REG_NEWLINE;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	ascii_only     = !has_non_ascii(p->pattern);
 
 	/*
 	 * Even when -F (fixed) asks us to do a non-regexp search, we
@@ -673,7 +671,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (opt->fixed ||
 	    has_null(p->pattern, p->patternlen) ||
 	    is_fixed(p->pattern, p->patternlen))
-		p->fixed = !p->ignore_case || ascii_only;
+		p->fixed = !p->ignore_case || !has_non_ascii(p->pattern);
 
 	if (p->fixed) {
 		p->kws = kwsalloc(p->ignore_case ? tolower_trans_tbl : NULL);
-- 
2.22.0.455.g172b71a6c5

