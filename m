Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA84A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfA3Jsx (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:48:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41149 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:48:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so10821083plm.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OKrVEIdtHGuBbjw0txuo5PJ5Bolb0l97rR/T1Ood7I=;
        b=noLqwbHXQCMdQfBrLemZg2JJXVxbVmh7eVy97UcwU4dWW7obeppbyyLvXWrx1ThM8Z
         dydJSOwk4+V7OHh7opINc8Cw2eqVhvIAVGvGaBE74+Ku6SUIqX3aRHjq1Ht2dpGaqglC
         OC3yFQpxnNT7GsjYMxSyFUP50pFb1vzZAGt1G5sweN4nBTtTPTfYPCKJ6IGfcQafIhH1
         LkKzsm7MGPfxqG/jYGgaXj5Seb+jvFEF98P/DYqHOH8Cp0/14RhN6EQ7gDzJbVKvGkT1
         Rjvkh9fJ5aFA/I+uJT8TyfZdFGijtifwrQNQY72euMBEdOZXheijtB21fmd6aK36R1WK
         4BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OKrVEIdtHGuBbjw0txuo5PJ5Bolb0l97rR/T1Ood7I=;
        b=REOL4vw6Chp4sDiYRy5L84xb8HP/qFcp7HjF7b7s7j7y4WWqXjgNW749Ta713GBTF+
         xSjO0cVt2BEC+TyNFg6x+6l1fiM/fvvXfGxtjqXx5eqHxj1FgG/ixF1G6X08FDkQS63d
         MXoxvxSxZc5Jz5vHMrPvqzN5FEMfTkV1FS/9NOlCLi8V+nsX3gEdQ+XB6XD6bzeAqxcs
         tmz5bTg6bj7dP49jFwns2maPEtGdjGAFVq4yiIy4PmhKkez8ohiGijHUiVnat1GjPCWe
         I9kl7JlEN4Fac9aGlADAOyz2LgWvMwwqmPryuDJ6cDs2l17IT1DNP689eDqbMN4xvidk
         jXeA==
X-Gm-Message-State: AJcUukdjfKxprV470Gy4USfkThKohndv8jCQthl+gX1CjrXHx3wRwjBl
        cJu5yWL2tslGh+/dWEbaRxDkc74Q
X-Google-Smtp-Source: ALg8bN5KJmxQGaQE/qpkDVP+YpcXgWUPmWZQ1hy99wD24qNc84ZucOO3Go7uT4t6Nnnqn+LiMESaag==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr30171490ply.294.1548841732102;
        Wed, 30 Jan 2019 01:48:52 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 22sm5758411pgd.85.2019.01.30.01.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:48:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/19] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Wed, 30 Jan 2019 16:48:15 +0700
Message-Id: <20190130094831.10420-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old name does not really say that this is about 'checkout -b'. See
49d833dc07 (Revert "checkout branch: prime cache-tree fully" -
2009-05-12) for more information

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/{t2014-switch.sh => t2014-checkout-switch.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.20.1.682.gd5861c6d90

