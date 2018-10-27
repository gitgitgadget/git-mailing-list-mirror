Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AA31F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJ0PE3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbeJ0PE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so3123648ljj.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Rf067jb9wDJqA5NvqPK2nKhSZiVpiq7BdzEb4qP1Sk=;
        b=p5EPoMtD9u/AM4POnyiO0ebNDoCV+ioNDc2EJ2zoOSCJc3GRqgS2PjcJPn+w+qAHH7
         ypCt+G9RNB38fN3z5jVZLIcvFPGQGoZaL3z6bmv8Z/SwK5doOubtEjRSRKx5P/0JhYvN
         HvdjL0RuAysqTGcePiM3mCSLnsUf9hFfi3RpT0oqwwFeIkNs9YmDTbnTbJ9jSzgWCRul
         UI+Fzr7xcPQKNR5mw7RJxcCUqZyxGu+0nzgdtNtlyLo/fDPeNhQ25xmXFgT0625rvqEF
         XApnz2h5rlvWyUs12WQYmjd3F28bxiA95wPDZdqtR4rtZUQZeEVtabGBPXOt8A0wMMLm
         GCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Rf067jb9wDJqA5NvqPK2nKhSZiVpiq7BdzEb4qP1Sk=;
        b=Mn8cuAW604GaTv98JamfU0YOL+uZ2U/ow1/xuOxDg4faA2r0HSIvI3w7EMYUWAooQc
         Vb1V9Z2wajgHD0VeVNA6k/YNI+/OYSBGT1SSXI7KgN1YayJb6fePbLVH4lbDGPgnHyvM
         RlZagEp7w/hn/ppl2JpW2A4rPQAllxoIM/1E26Ks83WV5/j4hXSGUPrP7TtZh0TPSCen
         e32rcCKiv85Wu65CQBVXpgt9Aq4d4f1etpYKcVPsge/GTbgWce30snWxzBcIMSVabtbB
         iU1PCigBUd/Nu3pknu69o085T5IH/h10Brkon4icKRNawn6kSsEbVW1oAPVegFdjF137
         Tc1w==
X-Gm-Message-State: AGRZ1gKeuQkCNL/CXIk6V91xRL8Yaxtty8VOX2i0rWK6rIp5hcIsaDPY
        bxO/0I0BkkCHtoP5QxYouOpuRDch
X-Google-Smtp-Source: AJdET5fbsnoyuL3YypIoXV0lal58LilngHC1IeqPPArSVADDb8soatJsJ/MBUXCqqVs4BnwN2OI+/g==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr4086894ljd.148.1540621472489;
        Fri, 26 Oct 2018 23:24:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/78] config.txt: move gui-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:04 +0200
Message-Id: <20181027062351.30446-32-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                         | 2 +-
 Documentation/{gui-config.txt => config/gui.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{gui-config.txt => config/gui.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f52b89883d..093a71e5d1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -343,7 +343,7 @@ include::config/grep.txt[]
 
 include::config/gpg.txt[]
 
-include::gui-config.txt[]
+include::config/gui.txt[]
 
 guitool.<name>.cmd::
 	Specifies the shell command line to execute when the corresponding item
diff --git a/Documentation/gui-config.txt b/Documentation/config/gui.txt
similarity index 100%
rename from Documentation/gui-config.txt
rename to Documentation/config/gui.txt
-- 
2.19.1.647.g708186aaf9

