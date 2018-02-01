Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63EC1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeBAKPP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:15:15 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44758 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBAKPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:15:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id v31so18275135wrc.11
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsZnLRfe/Gia07CSQBIdXCCkgSC30ylbxJ1tB9Xgy6Q=;
        b=iythpFvodwg/iPQGcrlFhpHBeBugTKRN/SDx6xTxiri7JPpuRbwDiOHqg/Bf/R6Hrj
         KGQ6AsJCKPl9/5eGcywW862TOPC4+wGKbjvg4hFJMyfws29+vjN42QrqRxMnLZ6BrY7/
         wnXKeLJRVTA4sFhE0JnwnboC4wq68ghrRo5yhoAPSX3DW0mwQDsRmkLIwhi62cTi/5Ej
         wEWKNOIe1LyHpYwKqBipWvUko2/KnaR6uEtqCXLVdVlWaUmNoYsUbgDPqb6mm/Ml7F3A
         aDzQLNdeYHU6x3/6PrVIOjlcLokVkQ6lm0pkdpfLfeIDk23yFG7SXj10x+8iX768EdnM
         Nclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nsZnLRfe/Gia07CSQBIdXCCkgSC30ylbxJ1tB9Xgy6Q=;
        b=ELq/j0KxCB+YteOtMe7TODSK5wkbjc3IlHwqrpAn0NBvIjjQePF/y/os47Ovo1jktt
         2N2Hbq0pQZV1uKrV3BUtJrvgmke+BVt9StDMZG4uiei+uQivTAIP6Z7DVhELsHH3rIdh
         sqwZm8fgsrOr6tkOrW4miRl60I1vcRAW/b9+ueS5N/XQmYUiqlF3Cf4/c3nLIv+KHoI/
         g0L8ACxHV6nCkXZiE2sYWNShNtcTrr+U1xA5Qytk9hUPBo4B45LHVV2DUFgXvEWlEUNs
         u+sN6fIqKHaExhCtmPrMfOtZ6oeZgfSza4YyOGXau6XEdmswwyS1LrQ6Ji7tGyFsBgMh
         HfKQ==
X-Gm-Message-State: AKwxytfyxv5ijEcrbK5A7sHVQV67wrnYrkx1wyoKayw7MylyWT7EAD1F
        m+PHAKpx0qMboYzfuywR00Fn25Wv
X-Google-Smtp-Source: AH8x2274uneWNjgPnOzzUOADWNpX1Gv+RSY7j9eQXOw9NqB0FCd5rcGDfa6Is0q22bsBN0uGFmdcDg==
X-Received: by 10.223.179.193 with SMTP id x1mr27961026wrd.171.1517480107758;
        Thu, 01 Feb 2018 02:15:07 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id e16sm21203466wre.5.2018.02.01.02.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 02:15:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 3/3] perf/aggregate: sort JSON fields in output
Date:   Thu,  1 Feb 2018 11:14:34 +0100
Message-Id: <20180201101434.5383-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
In-Reply-To: <20180201101434.5383-1-chriscool@tuxfamily.org>
References: <20180201101434.5383-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is much easier to diff the output against a previous
one when the fields are sorted.

Helped-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The only change compared to v1 is a typo fix suggested by Philip in
the commti message.

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index a609292491..749d6689f9 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -253,7 +253,7 @@ sub print_codespeed_results {
 		}
 	}
 
-	print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
+	print to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
 }
 
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
-- 
2.16.0.rc2.45.g09a1bbd803

