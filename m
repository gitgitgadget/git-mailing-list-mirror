Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162A61F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeFEOlI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37561 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeFEOlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so2727822wro.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=nJ4yrblBZdVmLb5yuhdDy0HZlo+0d777/s845IQZfZzb85xniAU63dL8sahoB2RUAZ
         IZRjOXW0KIF5d2OUm4Yuf5AAbOQVopXC2vH2dUHwbMlnUZx5iYRBtRpvf9bbqnTXLCDc
         QJdd+RSmTb34nvlNaXidIeCRhEySMv6oyRFTBqJHZhbOLpmn0jGDqMELKxvZdu92z4Ve
         2lIKM3Gdox76KPCdTSgpqwVyb3+MOknndMgVbHfj3yyVgQm7FTvq4kjnlkUq5ZeD/0U9
         iqYhFLEKtCIWkVwn5M3xnQKtH5NZJcrm16JDuIzw+hlBlf0OF/Y2tp0ZT6hD1SxoZus2
         p/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=V96v1Rxt5lnyF6sAj2wzv216ZJ/nQC7H3CIznXDz0hK9oqILrjHJut9Cu+6r83b5rL
         wYzMC5Z/2+X5rcMEOUYHBZDADDtoaZ7YVBdkCwTsSmZKshFol34iuSOijbhNIWw+ywTr
         0mwGe4FlgcID55tIBQbfoQthjWw1daxbqE5NNTGilDrdPiM/vhfUDCIcuSozTf5bt1Dg
         gz2jxySFXLLIlMCoJFVL1wzMP4+txvv6VMVkdZ47hibnGP4N0N4Yhfb6OAJlkjJuUZ/+
         EA8Jt4pjmysipJqKAyH8OcWn9/zMFMZIDHx1L6hjU4+anGHB6VX0NRUp5Mt3RHjY1Dmz
         G8iw==
X-Gm-Message-State: ALKqPwcZHxRhnLp+Mw4Ji9LstEsJEfSSAIG36TujVCdrjanh4fC048Zk
        5cv8JQy1lwi8r3CnXlx/NpXh9zE/
X-Google-Smtp-Source: ADUXVKLncxGUmO6AOPXSppRTZQDMr0nPASZMBLbhPB2VnuQxebuw6KulFjscTrHFjUk9ndlpGWgg7A==
X-Received: by 2002:adf:e94e:: with SMTP id m14-v6mr19821140wrn.126.1528209662914;
        Tue, 05 Jun 2018 07:41:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:01 -0700 (PDT)
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
Subject: [PATCH v7 2/8] checkout.h: wrap the arguments to unique_tracking_name()
Date:   Tue,  5 Jun 2018 14:40:43 +0000
Message-Id: <20180605144049.26488-3-avarab@gmail.com>
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

The line was too long already, and will be longer still when a later
change adds another argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkout.h b/checkout.h
index 9980711179..4cd4cd1c23 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,6 +8,7 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-extern const char *unique_tracking_name(const char *name, struct object_id *oid);
+extern const char *unique_tracking_name(const char *name,
+					struct object_id *oid);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a

