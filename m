Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0B11F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeGWOH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:07:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36259 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbeGWOH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:07:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id k15-v6so908098edr.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4exuKTq/6+DxaMXUWeBqrzx7EF4ogoBJvwIUSjK4/c=;
        b=FPQJLjZzKNFz5naba63enF/XC/7NqhglCJDEb3ggg1U/OhCLr4b4/H6lSdtoLBXVU8
         e4OER6BWfyfgpBDIa6or3SYJ6kkge0bUZnh+Qk/w5xpKOKCM/BFPDbAvh4FZnQBINeNc
         LEx9SWPQLPz3ed32qSDB4w12f9qiCAo4wVBsF9S+M+YoTQk99BLbyRu3rzdIxp1BF9Dk
         ttd5hXXUVv/YhF8nsrOfQf0sA0fTUBWGsZ1w4O/HsHDfU+WaZ4kcymT9d9kox4PWuKFX
         tppAXYQtNgTu18Kxz+SKUjLeK8IBNg1ZhAFHFeYEoV6EwO6ScIknJRLZid/YVP/6lLRn
         Zpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4exuKTq/6+DxaMXUWeBqrzx7EF4ogoBJvwIUSjK4/c=;
        b=tMgeICYnl+aDv9/FYJ64aG+YNsoGnZLUDN4RcuIFcuLFDa5hO9JxJs+3WKIF+mByx/
         7YlLAOYRbX4qYl+Q4D2SrG3lnvC5JiiU4+gxaRL/OC6gbqpQhAeiuyU0+aqHkjuk1LPN
         amPKWTZDm+OQVohornQdtA0Vi36LVTv97yFgY1LARMUsANczy5cC2uRC/LQZfUncMdfZ
         vj0MeK4EUqqI0wJztVzplX2tSXSwCu4dfb64/lRpZ/MK4fT9mV9f9oa2T+wqDInlsrEj
         VdGObv3Moxyaj6vpbhRlvo5zs6pKHSUk7bPBczL09IF+2nsGXyJMuoQvDr6Cmz024G6j
         BTbg==
X-Gm-Message-State: AOUpUlFt4fDJogN039Dd+fKUvuOYrl4Ud6RgfOMDuPkK+oDSCacN9Dkd
        6mGrMQ+58DtlqRMzt3yqT1I=
X-Google-Smtp-Source: AAOMgpdUcvleSKBMp6mCqvdYZFwyCVGACLHQC0/MUoG04norHVmir5NVap5InkryIyV6idh481uOlA==
X-Received: by 2002:a50:8ca9:: with SMTP id q38-v6mr14175583edq.2.1532351176026;
        Mon, 23 Jul 2018 06:06:16 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a2-v6sm4518704ede.21.2018.07.23.06.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:06:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/2 for pb/bisect-helper-2] squash! bisect--helper: `bisect_start` shell function partially in C
Date:   Mon, 23 Jul 2018 15:06:03 +0200
Message-Id: <20180723130603.22703-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723130230.22491-1-szeder.dev@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bisect--helper: use oid_to_hex()

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fc02f889e6..eac4c27787 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -547,7 +547,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		if (!get_oid(head, &head_oid) &&
 		    !starts_with(head, "refs/heads/")) {
 			strbuf_reset(&start_head);
-			strbuf_addstr(&start_head, sha1_to_hex(head_oid.hash));
+			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
 			/*
-- 
2.18.0.408.g42635c01bc

