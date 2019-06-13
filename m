Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21361F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfFMP0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:26:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfFMLtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 07:49:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so1005299edb.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RMbR/sr9uFSB2sNfUSbwNcmXQ4wJeTPdpKIku5E/Tsk=;
        b=vTWGW71jlBSQFgV/McoYpFdMuHnVtrfRr/6PvTSgXas2ibc1GtnmqQBrKYislKLidJ
         WxUBiMPbCfry2L5piL3edhh5yg2nXSKb7yL94OIn4AGJkGPf+/kSFisIhowsEBbNl3Pa
         ThIFexXPcL9A6KA+U9Q2UNjPDJ/KAXLUe3Esq8W4qpheXjLLaJKhFnLzWj71m6K32HaA
         zaoKo1kwGiaHA7W0olBhwffTnbFuobK1X48p93104Z5c0cmPLtmTo6TWjAYQ6qi2KQtk
         KNTdqzYvIsvLEkgOabQ2aW0DIeXkP84GJLvbU24NweiYJYNQnfzI/IAvnKP5pMA2llli
         +qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RMbR/sr9uFSB2sNfUSbwNcmXQ4wJeTPdpKIku5E/Tsk=;
        b=d6Ko8hTL7Si/xlJUcn6NOKFgeoVxVFc/GiQAOHtd5RzjlIhEK+Dnmsh0xCX0sjASqu
         bxBsaRUY0eDwER8TjI4DXtnzZvA+Si9fvyIkbZjme1Mgbxw2I0vKYqBGoPDfvrYCuGlE
         8VCMtraI+EPxGB0/0wU4ezn0RUilaBXAQLhAYPDU4GI5TDsGvBcZhfFuzq38+4U8Kn+M
         SfYTeZht8F4Rdryz+14HK5JRdhPB80mtKIeC6nWlJzeqLnrl1IPENED/ms3qR75w1B6t
         kcb+uTbOPZDYY/oygMGBLncDMvAXuadKzDAZgH4MAzE+bELppwJRCsa8aoTbgjF29d+h
         L+SQ==
X-Gm-Message-State: APjAAAXbFC/wQv70NssXRVWVvyCq1qRGjobLEqMYGHMYNJzNS6MENq97
        UXBk4QTsbCyXcH8jp+U/t2GE+5Pi
X-Google-Smtp-Source: APXvYqx1Ks8hQbDE6LSOVvkU+yiC+09xgOtmJ/XU0jNLaCpJkDm7mizEjIB72ZwGahq8P48yXJ7b6g==
X-Received: by 2002:a50:ad45:: with SMTP id z5mr71444639edc.21.1560426586010;
        Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f36sm574333ede.47.2019.06.13.04.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:49:45 -0700 (PDT)
Date:   Thu, 13 Jun 2019 04:49:45 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 11:49:39 GMT
Message-Id: <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.265.git.gitgitgadget@gmail.com>
References: <pull.265.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] kwset: allow building with GCC 8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The kwset functionality makes use of the obstack code, which expects to
be handed a function that can allocate large chunks of data. It expects
that function to accept a `size` parameter of type `long`.

This upsets GCC 8 on Windows, because `long` does not have the same
bit size as `size_t` there.

Now, the proper thing to do would be to switch to `size_t`. But this
would make us deviate from the "upstream" code even further, making it
hard to synchronize with newer versions, and also it would be quite
involved because that `long` type is so invasive in that code.

Let's punt, and instead provide a super small wrapper around
`xmalloc()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 kwset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kwset.c b/kwset.c
index 4fb6455aca..efc2ff41bc 100644
--- a/kwset.c
+++ b/kwset.c
@@ -38,7 +38,13 @@
 #include "compat/obstack.h"
 
 #define NCHAR (UCHAR_MAX + 1)
-#define obstack_chunk_alloc xmalloc
+/* adapter for `xmalloc()`, which takes `size_t`, not `long` */
+static void *obstack_chunk_alloc(long size)
+{
+	if (size < 0)
+		BUG("Cannot allocate a negative amount: %ld", size);
+	return xmalloc(size);
+}
 #define obstack_chunk_free free
 
 #define U(c) ((unsigned char) (c))
-- 
gitgitgadget

