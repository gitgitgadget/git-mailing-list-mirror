Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3081F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeGaOsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32887 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGaOsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so11005858wmh.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3C0Uy2LZg46xcBt8+cjgXEy6XNuiNnMQqZ3OJMDPxI=;
        b=lzk+bOmJG+QGDy3vmJHp/2Jjw1h7DZCclGs1PWlRULXTKXD+7qc4TMoO94J3nhqmqU
         3y3fdtUVpux9V00noxrOCD+L/Dw9r5FyT11Yl8asHtYevr6JM/d4/NZsn0WVlMzDYhJS
         oFAJ+PApxQEl7mJ3lHCbVTIazDR+QYm2XeYQdiqMltStMt6Ra9QzsToX+Ne0cHdA8Ms6
         Yq5OnTw8BHSci/Tpo/k9iLaEnY0K5nlifQaAzleXNW/yLBjHq4me6o1/tMpiHEbgaGYR
         KOcD4PblHx0gBrkP4c4am6L82gyFiKzcvInbMdqwb61ARVi8SMojoUw6nKsA7MbTvgXw
         nFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3C0Uy2LZg46xcBt8+cjgXEy6XNuiNnMQqZ3OJMDPxI=;
        b=gkonWorkn0P/ZZEodyDocxpwly4VHgvzHTR5AAc2dnjhgm+bGm2qV/vyPYgU9b4SI1
         reuDNLqL4z9Ni+IdmR+J9Wbh26NHxUYiPvu3+efBpg22UmwcNSXe4BQnqc/DEDktYTf3
         nXEPL6b49Zp+ZPPB0gWikAJcggAIWWY0UXyjK7CATEgXGjup6Fqw4BzXPkDxmpeuEXIK
         1EemXYcuaLd+DMEVHikTT/OvHFj8K70mrzOUB8WfNG/QutRQ0o4xa/BzguXoR+3Cww1f
         LWl+EN9Cnxih3mn0glrkARQcqVGWbCjHeWEX85QTCuOxDx+EhXiVfHtd0FRh35XXuKh+
         pvZw==
X-Gm-Message-State: AOUpUlFJSab+dinbwNVVO7PXpQO24zmpMaqoFBvt9uuhTJDVwuhdr3s6
        j/9JyhDnSSHj7IVBoHJcIvpuyKy4rwg=
X-Google-Smtp-Source: AAOMgpd1HMCeoTuMZYJxhqwePFokP/Q16soRdyJTquYsgKXdM/fxdz8Qiwqzw4N9ZwC5847bcnvSrg==
X-Received: by 2002:a1c:6b90:: with SMTP id a16-v6mr2173903wmi.74.1533042469235;
        Tue, 31 Jul 2018 06:07:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] pull doc: fix a long-standing grammar error
Date:   Tue, 31 Jul 2018 13:07:17 +0000
Message-Id: <20180731130718.25222-10-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It should be "is not an empty string" not "is not empty string". This
fixes wording originally introduced in ab9b31386b ("Documentation:
multi-head fetch.", 2005-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index c579793af5..f1fb08dc68 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -33,7 +33,7 @@ name.
 it requests fetching everything up to the given tag.
 +
 The remote ref that matches <src>
-is fetched, and if <dst> is not empty string, the local
+is fetched, and if <dst> is not an empty string, the local
 ref that matches it is fast-forwarded using <src>.
 If the optional plus `+` is used, the local ref
 is updated even if it does not result in a fast-forward
-- 
2.18.0.345.g5c9ce644c3

