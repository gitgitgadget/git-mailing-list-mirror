Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974BF1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeAVLEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35373 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeAVLEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so15996946wme.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=GQqrf/lHIirnFsqvGSPawDtO3WotK1rf2QhR6Ygr+t+nWZNtvli+oUJgNKg/vOmar0
         VTbtOE5MMyQcR61J3+xvlAD7Q+DA3p2EadXAsIChZGIPCl0kN5jcF8QU071xghpYjWCz
         vSnrNk/HF8FwdsIidbWla8Vxm9UEw2d8NuzPnPkX4hqcNjavm9UXW8PvMnzM/IMCeKrK
         qL2dJLulI4LPXZ8ooyfdAjAsW/Fve/NiMyvXkR8/GbigELU33D6sXep35vga2CzDeAAs
         UmybtClDj9oiC0h6Pqx4LAiHGZdqtB68ER0BOtUeXSbju9TGYEpKsEvTRsQCr5VZHxmX
         GafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=GEcrSCNLaTp5DxDABa+LHiTUBOl2GNlbNBiePSVooRunyRThOHuksY1MZk6LtPp89i
         5WuM0ypiyCmgdzUFft5MnqRmqapvEg9Mog01uTAMzvHBI9OFEUAhWSjYVMgUxd9Oeq7a
         unCD0sCgrfY1uVygkwUmqS85pkNoQ5dJfRpzpkRxyUSyLTGi+4B4sL6wSRFjCP+UeUiV
         HuShahxIEVZHBCv5ZrECtrv6ZPVVOdi+ybYDFwXb4aDoj9TWSnbbyyw5uGaGKzsNhFkw
         W2i18ariYLp+1apW5f1hPT1SM+JLYgNKBzZW7sWghjcJ2pmG3Ut7QB08DaxXVxr11dLO
         aBxQ==
X-Gm-Message-State: AKwxyteqoBfLASye07irmtmOc8RJp3Um8v3IGWqsNGbJRXtggSgZ17h3
        24UjmwDFQyd6IJRdnXib+kBO/WfV
X-Google-Smtp-Source: AH8x226Fo9i9UCRXuUagm0LTx6UzoZhaRYnfdsohRF5mN3lcVuWfn7bM3mSM50oFc4KiXn+03yz5rg==
X-Received: by 10.80.147.72 with SMTP id n8mr12834131eda.189.1516619082629;
        Mon, 22 Jan 2018 03:04:42 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:41 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 02/14] clang-format: adjust penalty for return type line break
Date:   Mon, 22 Jan 2018 12:04:25 +0100
Message-Id: <2c3edc8b9f481c36b203ece2c6f70467ae9fd365.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The penalty of 5 makes clang-format very eager to put even short type
declarations (e.g. "extern int") into a separate line, even when
breaking parameters list is sufficient.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 611ab4750b..12a89f95f9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -163,7 +163,7 @@ PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
 PenaltyBreakString: 10
 PenaltyExcessCharacter: 100
-PenaltyReturnTypeOnItsOwnLine: 5
+PenaltyReturnTypeOnItsOwnLine: 60
 
 # Don't sort #include's
 SortIncludes: false
-- 
2.14.3

