Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06C21F45F
	for <e@80x24.org>; Tue,  7 May 2019 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfEGJur (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 05:50:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46715 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGJuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 05:50:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so3902744pgb.13
        for <git@vger.kernel.org>; Tue, 07 May 2019 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhFes6xZNM7P/87cFOgX6ahtaqEr/nnEWAe2Vix4kxc=;
        b=ncbXCBtwWDgUx0Va75cJQvuJXyKrnD8KMBQR9t3Wxr5IAq70FwaevxY3ElbuKxBZER
         Q2xeMM+tqegCFPaqK5G+58MBsWkMmYVhcY1kLqrKOYFRCV4JJtcT21JJlyVYogd11PMp
         IiDQtX7fHa0EAMAfGvSOO9jvAKb6vj7u2cdH+XXQlSN3torCKPxvYsXMaU6WhvnAjF4v
         ST32Bkvu6m1SL3lfuoD0RkamvFoGQPVQ5gl/1hBU6DMNbASfBouzI8BLCqnR4GDo7UQJ
         SqM/tLjnltpCnQKa2sBwDKXG6bkD+QxRX7UizxhuvTgM/NqkLzUfbou9vnjctvjxjpmY
         gFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhFes6xZNM7P/87cFOgX6ahtaqEr/nnEWAe2Vix4kxc=;
        b=NP/1PsRRP1FxAcmHNf0vDr20NshVpd8reWv0fVZdNAd+nDEPOc2aF1Pfegra6Pnb+T
         oNEoc0BljQwwzao2+wE10BPdlIp/8J81wpUFle20/cQ8nnaRxc7ddQ4gW44+JvzN5vPF
         UwlMDRleFmKaiT0SKjGpiWBtaETl/Zt1fTS37zoXugGymyI1dO9X+vCT5ivmWWIpijLz
         TI3uQ2GKEPh8UBROZGuRaE5iAMOvfHQNfyC7ljSQ7YcLsSa++dw0kPjThXotYB5YYu0f
         yz0Dzf1uvUYHAPm3tXo6xU+bcWeMWnVEECUzbSpFL+vvs+AGwlMjlX/EYk02sKILfCG+
         pBpw==
X-Gm-Message-State: APjAAAXc1wt42vzGRU62SOj4NvThxzxisZdR4FeAJQuKvyctCeHqpGhk
        F7BSXK67NdaEQ0XvMgVnKglk9a6i
X-Google-Smtp-Source: APXvYqx1AWLqbd5D3sJF8lH2vRX8BuuUiHqyBssz3HiZfEulwW6n3jI/FagXjX2ntZ+qmxZSQc9Obg==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr38093237pgq.175.1557222645819;
        Tue, 07 May 2019 02:50:45 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id o71sm20088008pfi.174.2019.05.07.02.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 02:50:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 07 May 2019 16:50:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] submodule--helper: add a missing \n
Date:   Tue,  7 May 2019 16:50:37 +0700
Message-Id: <20190507095037.11630-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1120.gde2b49a866
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a complete line. We're not expecting the next function to add
anything to the same line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8c72ea864c..0bf4aa088e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1301,7 +1301,7 @@ static int add_possible_reference_from_superproject(
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_INFO:
-				fprintf(stderr, _("submodule '%s' cannot add alternate: %s"),
+				fprintf_ln(stderr, _("submodule '%s' cannot add alternate: %s"),
 					sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_IGNORE:
 				; /* nothing */
-- 
2.21.0.1120.gde2b49a866

