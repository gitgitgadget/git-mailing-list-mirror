Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4897203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbcHKSrC (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36247 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcHKSq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:46:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so835187wmf.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:46:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MMQKVRo7rHW/F/HHeiP6MrrFjwzs/zSAcXsarftOv/g=;
        b=XBBZF9/ccypgZL1FeOGd524gyi982UBpV/aqC+osf+984aEdispbtGfSN+29HsAwNB
         ovD1OEfifW56gg6b55mm3eHVfgaPv28lvwHnGL/d+5eHVziXp3NL1k+GqBx5f9Rg3/cX
         RwolDwEtxYTEaCmIOqSM3upLuCTsP5oXPHNhJljeaCPVgNEYY/wPtFUDUuD+l7dXGy9P
         596bBeln2q2ukJuMF8dGxG6oIw+ThC/yGwi3upF2FMu9BCf+LZiSpSFCcofrXWriPAXQ
         DfG/1LKM7ivw86By6PVhxiYxc12uYRtDGj0rg4MYhbNfNqwx3BjI2xr72jK4KhWlZlVT
         MhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MMQKVRo7rHW/F/HHeiP6MrrFjwzs/zSAcXsarftOv/g=;
        b=WySaEw5NIOL+ZcFG7hlTMDd66Flgd3qGjwkbXoK4mT+OrEPDCcZXi7HxB5SISPfEWU
         hKdVN30MW5NkLN0sCRm9uLTNI1nT+vd4qJsWPPkD2RLUPoV8MhzRJjA3j9BT8ChPmqUO
         sd1BvsN5bcpjny3X8GaUfbTT870zcPKwzpPSz2H5Qq8O5Z8rAGnP1J9RSYuZx5nsE99G
         qiC2AkhZQwlAlLBU+pllgFEm8zhTFQkDNvbLBobpIq/I0WJsPO99HqAkyTKlmOxLZgMd
         5/CSbKJrL4gh2cIEqXdhVkG/TjF8qQdsoaETOwKjr1D94+OJrH2gT7INnXTOMRN9uhxF
         4tcA==
X-Gm-Message-State: AEkoouszb3fu2vL5khRNHTbZfFJzJsb1lFq0f1sPCg38y3W9b3dW43N+b2U/M2QXL4YrIw==
X-Received: by 10.28.227.11 with SMTP id a11mr11297291wmh.29.1470941218056;
        Thu, 11 Aug 2016 11:46:58 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:46:57 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 07/13] apply: don't print on stdout in verbosity_silent mode
Date:	Thu, 11 Aug 2016 20:44:55 +0200
Message-Id: <20160811184501.384-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When apply_verbosity is set to verbosity_silent nothing should be
printed on both stderr and stdout.

To avoid printing on stdout, we can just skip calling the following
functions:

	- stat_patch_list(),
	- numstat_patch_list(),
	- summary_patch_list().

It is safe to do that because the above functions have no side
effects other than printing:

- stat_patch_list() only computes some local values and then call
show_stats() and print_stat_summary(), those two functions only
compute local values and call printing functions,
- numstat_patch_list() also only computes local values and calls
printing functions,
- summary_patch_list() calls show_file_mode_name(), printf(),
show_rename_copy(), show_mode_change() that are only printing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index df85cbc..ddbb0a2 100644
--- a/apply.c
+++ b/apply.c
@@ -4702,13 +4702,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && state->apply_verbosity > verbosity_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && state->apply_verbosity > verbosity_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.2.769.gc0f0333

