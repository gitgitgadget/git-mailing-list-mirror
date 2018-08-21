Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78ED91F97F
	for <e@80x24.org>; Tue, 21 Aug 2018 19:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeHUWuk (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:50:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34001 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHUWuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:50:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so8978874pfi.1
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mZqje63yJ4Au23xsfBMM4im3dLBIe54in3LoBEmAvBE=;
        b=tUqkAOibwEm053WsrmDbgaWjbtr3Ps1QIYpu0vfIGqATF1wDIMLLIm/RKbJMkl00nq
         /lcMVdGBBEsLK5jqInMVN4K/Nos63sO2P6cEyzCjsJ6QzJG+hdxtkNipHI+VGXfkjsTt
         GThicOqncgNEkcnaikb6qJFoUYbGy3SRc2N6QdTnQ+FR49Pl5J1odVo4OEZ7gs6l6hKI
         yBKXr1c5mlMBGo64RsF6q9qVfxipgvnr+d/aWcAdDnhhexMaz3y/gXGvOzBw4oNSzZlG
         5dHnKFtzToPA9ydJB7KUbnm5S67GlhYa15ApWHcaU6PN5X752oArweN71iX30GaUbcjn
         bExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mZqje63yJ4Au23xsfBMM4im3dLBIe54in3LoBEmAvBE=;
        b=GH5iVrf1XJv9LteYmhOiCMEsnlmh0ejAGKoZ4KXxuzp767uNVUsoIN7pzYPGGcTc+M
         2Dm18MIB4QsGouvpqBkaPIefkK1Ezhadf2ZsJn8B+Wt1pTORDl++EjVoX7/7I+g/uBbZ
         6uao1uvb4Zu3okx7dfJYXepCEvAOQUqwb8PopX8FSSKdVeCuJlNs/G5qf58/7ENirL6T
         78EFQ2MgFiyAPoi+XnMJotfbWHgtEkvsiMVhmio3s1ui9sDXH6322pQrMPjHbaLc4bdL
         qaJkHUxKYa7fu9AB9AGof8/yxLXOo19OOpjuRAHTntcTKrRxf3TXtU8Y7xgedH+IBiti
         7zew==
X-Gm-Message-State: AOUpUlEsi6YCnEovdUz2118t8qJL7YdXEIZaXky9BRco/2GFITvZt7I9
        bHv5hCgA9ctkRZ6D8aw9jSbbRisQ
X-Google-Smtp-Source: AA+uWPxMw+nE70Brjg/ySAMtVNbnD4yvYEAkyHRxEWVOu4iXB8Wor0SDT/o+sJu6IZo01Sd6knbdcA==
X-Received: by 2002:a63:4e25:: with SMTP id c37-v6mr48247949pgb.6.1534879752998;
        Tue, 21 Aug 2018 12:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id x66-v6sm27873330pff.123.2018.08.21.12.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:29:12 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:29:12 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 19:29:06 GMT
Message-Id: <4c66af6262b17f856f8ea35676f753058d12d6e2.1534879749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.22.v2.git.gitgitgadget@gmail.com>
References: <pull.22.git.gitgitgadget@gmail.com>
        <pull.22.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] Docs: Add commit-graph tech docs to Makefile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Ensure that the commit-graph.txt and commit-graph-format.txt files
are compiled to HTML using ASCIIDOC.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73..841e4f705 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -69,6 +69,8 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/commit-graph
+TECH_DOCS += technical/commit-graph-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
-- 
gitgitgadget

