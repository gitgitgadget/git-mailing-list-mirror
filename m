Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5A81F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeDZHvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:51:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36159 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeDZHvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:51:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18-v6so28447488wrg.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90X0E6GBNvbn4u7euICffaAmUck2qVpaCYZkGRcWzCI=;
        b=hc75mf2NUFShd7WQjUn5Nj0cWHhU6P6E9YuLYG12R0p3Po8VSrLKTM+yfVS8Zprl47
         ex9pHa2u5djAiOqysOgmBYI3v2Z0209auHlyNhd/kRoCpJW2UWnQh4E+yhTgkOgXr4Dq
         e0jHA1DNQ8SeEOvMv3KHbhVMk0YElsWhCJfoG61Fk8SV/jBtphy8yM6PbzvWNdYqPyWB
         hJzIZqOtvP5EEeTl+tus/InP4mMstA3XYPtPDFrn5bH5d/PcbG1t/iL+5yiebI8LzD4h
         1CaD9Hsd9kODdxQRQacxZ7xzCiMSZiZkRoBaBN9taBQrnqbWofs/fWk1fHCqJeOwk9mh
         Dv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90X0E6GBNvbn4u7euICffaAmUck2qVpaCYZkGRcWzCI=;
        b=STKgMeQMVLiDYiuR8n/gDlXSdlKvAJxxoQIMGfO0Jw46k1N0aK8iTAuzrmhpleiplF
         YzXZY410sDqxiJ8bp8sugV49SWPdyFoB0MHuUt+1qNu8nY+IwK37lAnWkzxfYTad+KwN
         JhNqPjjn4VI5d4SKnaHEfz6q4qhd77Huj4IUDvM97ZZdHZ22wNC2g+kwqVXUNjNrITTx
         qZPY8tL2u4z6DC1OwT09WqG51Q8ZL1GDoJ5DCZRvAzYpYSeHhrHSZvzmVeYT6N/4K3K0
         fqMw2pSealgquVyy3jIfqZs0BDS384qleyP9W/dJByRl4xbVbP85SBZcLiEZAM2NEcLd
         a1UA==
X-Gm-Message-State: ALQs6tBWmd1vAqEiz1sQRucvFL7mj1ZsxhGYC60Gllm3OKQcWFavu738
        E2AfF3e2z1oSQ5kIprURP/dfdiDu
X-Google-Smtp-Source: AIpwx4/TEsetY+y1/6mXKWpNwn668+Pma42EcwjX2Ic7t0ShOKjYl6sVZo0EawjoFal8kUsTptkyIw==
X-Received: by 2002:adf:e64b:: with SMTP id b11-v6mr21918378wrn.51.1524729070625;
        Thu, 26 Apr 2018 00:51:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w6-v6sm3424551wra.16.2018.04.26.00.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:51:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] .gitattributes: add *.pl extension for Perl
Date:   Thu, 26 Apr 2018 07:50:56 +0000
Message-Id: <20180426075058.9322-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180426075058.9322-1-avarab@gmail.com>
References: <20180426075058.9322-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the list of Perl extensions added in 00ddc9d13c ("Fix build
with core.autocrlf=true", 2017-05-09) to also include *.pl, we have
some of those in the tree, e.g. in t/.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 8ce9c6b888..482af05a6a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,6 +2,7 @@
 *.[ch] whitespace=indent,trail,space diff=cpp
 *.sh whitespace=indent,trail,space eol=lf
 *.perl eol=lf
+*.pl eof=lf
 *.pm eol=lf
 /Documentation/git-*.txt eol=lf
 /command-list.txt eol=lf
-- 
2.17.0.290.gded63e768a

