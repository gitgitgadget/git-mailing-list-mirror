Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F5B1F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeFBLvI (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37413 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFBLvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:51:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so6668121wmb.2
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=A8ZyckwBFCw1FRqkUjbScQa3MJgUjwE/TQ1IcHDnmnjOYV1vh8f7t//ntmCSiaEcjv
         9Db7DKonxNGB/HXevl4lHqx0xpyT07E48bX56E0l6kXzc6njfvmngqG3mSw6wjmIljiM
         CTggLAnlQuLlDpWKLPICGffV33eHKc4IFXotl+mRrQ43DoKd3yAFGf+XzM9LQDLv9ncF
         xMZWWYM0q/xyBK64lsGKvP0R7LLsNYBWthK7u9YDLe+aWCEMHFtR94dczbP9hFuPghL/
         DJe28QAWvbBkwqDtQqS86QDl/GyXTKvBjduHJ6ShqdN64atS7vjpOswRDpW1tbukGzO2
         8Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bzFNuGMt8urtyjrCh2SToKlXKZnF5YcilkIqNpeteGA=;
        b=XYA3rmeLl9sn4sLEvq2dk3KIXS6p9VbsPZ2GKAVdef2TCWP/tzNF5IF4SbXFEMdbKx
         61AlP1zGiXiI0wEd7GXdYj3YYoiReIAumm4sUiN850XsbPJhaE0S4wdq1iNaLz7DKNGQ
         XeW3j8KWDHeAj/ujmfMpy9eAxIh3r6XwvUnU4n9P0p5lsIYw1qwf1ecZV4hLD9tYxW1z
         ombIh7MyQZ2F1LN6HYUq6jsIALQFGLcJuWoHJFmPwGM5HB2Ia8vscwipps1UJR2uqR4X
         aKUt6mENHQCcfU9SxAZxMfLK13uQqgznaKYWUnUmQwgsQlwnLKnnzIE81BXf/XazkYG9
         wApA==
X-Gm-Message-State: APt69E3Tp+tG6ju4mBOy1tAvbmB3z0wwUtjjxdpq2hAGjpIwl1WY07l9
        oDQcJPwjS4oPhNnA4exveF+Kx8yV
X-Google-Smtp-Source: ADUXVKJ1TLH8tEwVrGZB9Oxuyl5bCMbDdP3GVEwxflkUVizHyWMNBoZxpa1Xe/ODPcsrrFBVPJO0oA==
X-Received: by 2002:a1c:7401:: with SMTP id p1-v6mr4758718wmc.14.1527940261518;
        Sat, 02 Jun 2018 04:51:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:51:00 -0700 (PDT)
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
Subject: [PATCH v6 6/8] builtin/checkout.c: use "ret" variable for return
Date:   Sat,  2 Jun 2018 11:50:40 +0000
Message-Id: <20180602115042.18167-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
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

