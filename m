Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E7E1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeFEOlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52093 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeFEOlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so5445223wmc.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=UjZlQWD/8j6xcCh3xLEw6XG8Vn7z2wPDVtwrl8Y4ZfPNw5x1m+94CKbYcXxtLOU5xs
         YKxl8aNQjOwjjpzuBHni4YmLxmOXVJXrhDfbCLsyD9WIqd7cFFD6WzTfWtUuPxbDgo20
         I2A8+8NvM680poEamlCHy2rFkp/NwqutQ5rxp7A5FYKlTfecLRKgXGDvakFGztXfspKm
         x9crk3wdo6Jgwy82oplLIuRE6DdWGTbeFaqsMCQizgXyLQGFU27UMxR18h9Ms3mWfSAk
         +nrqypVV4opCt6LRc+yT6g0RQZSYODYCGuiWBJg1P3OsM/HahHsFrTthWBxkEBVag26G
         pCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=Hxd7NATY4C8XRNqhbzxZseSUgnQGCS4T0G43mT1Xfj9NjER9GEKoEe+qFazOsgOIti
         TEopMMfrJFI5eLoGWOfPrTQLw1NGrkaP7D1MvHi7ETYPmnexJrmIeo3x1A65Aklx1KTx
         ve6EWRWsdJ/vtMDF1EtHtQFqQXfmv9gMNEU5twuly77b0XfD4eWXMHagWyXp3g5VCnFr
         tEYqpJS8QIUi/dNPGQ+7XnajSz/vPcsSCDiiFbAZu4CAzqIuaXl15DPeqDM+WLeKraRT
         P9BQb4bFcsbRnKIpxiH5tef5QHsD4/O/z2b3Omdug64TQEta6uuBaYvi5wbrd2e4OvTR
         CHBw==
X-Gm-Message-State: APt69E1g9aMn4OfAfenhQ/ghWtb7ZkTLzNDaRISRtbbHXuOHAmi2pBdX
        fozWOAtM3knvXmNSba2tNruTnOII
X-Google-Smtp-Source: ADUXVKJBw8qq+C/DyXoO1C2wtVxxxASvIzEBKQdwt+3WBkJty/lneLJx+dOk54gyCuzqCrd6O9742Q==
X-Received: by 2002:a1c:6954:: with SMTP id e81-v6mr1264484wmc.124.1528209667977;
        Tue, 05 Jun 2018 07:41:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 6/8] builtin/checkout.c: use "ret" variable for return
Date:   Tue,  5 Jun 2018 14:40:47 +0000
Message-Id: <20180605144049.26488-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no point in doing this right now, but in later change the
"ret" variable will be inspected. This change makes that meaningful
change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 72457fb7d5..8c93c55cbc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1265,8 +1265,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new_branch_info.name);
-	else
+	if (opts.patch_mode || opts.pathspec.nr) {
+		int ret = checkout_paths(&opts, new_branch_info.name);
+		return ret;
+	} else {
 		return checkout_branch(&opts, &new_branch_info);
+	}
 }
-- 
2.17.0.290.gded63e768a

