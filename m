Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD1A20248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfC2Mfg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46320 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfC2Mff (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so2370898wrw.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aosOI7X8jOegorDWKC5cBD8GjBzQO0+hNli2kaJQGcg=;
        b=WKiy5A8sp3g5M7o/zG53RYoQ0B1018fGdZAFrTdPvnJpTcloljNtt3uyEkNAj1P5YK
         ug2V0trIQ1NKKZZhXZhlhP8GWQnXLtZys2HJVSjxYMTGtSWBap+dZkn+PKvgxy324sVf
         W0URRcXZckhX3dN4qf0t0JJ89Rib0bLCI3Aybk42RnmrnAq7kwdVGCylTvrb2QvbQvYh
         X5ml5BFEpAGohHoyGBvYNAgJ6UAXtL9K1gQGD2nc2kFKfqony/zQUPT4ikMJ27aJHe0W
         N8d1XQ8J+gmmfjZhD+uuUgEjRVtMoOb9ESTq3LlpVAXZke7P30uxb/bWlFWefiEdHf0b
         EHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aosOI7X8jOegorDWKC5cBD8GjBzQO0+hNli2kaJQGcg=;
        b=pIhP8XtXRCX9+p1FWnGS3ro1PhQRiElBvFxtlivT/kGjxK337iskdxu3E598R97aCb
         NEGYY+WjB4dgEtte4CO1XSB2l3HVprtULQ19PKpyKvFU/vnALnkuV+dIKxtX7tezI6yS
         /3XDvOkxmvIG9AO7JC7mwQ/RVxpi80COP3OYeqc0X8h1AC1o8EbeZdTs6CT/tRhLQMl0
         UBdeJBFcn16UHuBTeq2UTbxJG9A3Ha4823vLZ2oJzcqXNotHbx8THPhg72ESkaTVYj38
         usxpPnAfYo5bLgr518h6GXTUozxEzyN3/62XZCaxkX5sUj05q9RguqD9PmJBeSRlWHZU
         ahVQ==
X-Gm-Message-State: APjAAAV8QwVjvSFARd+Zx9Y6U0V2tLwZMweJHrAPILlnLt+TUF+UH0Qj
        GpGXp/Wj/124ls+hPXggoDs=
X-Google-Smtp-Source: APXvYqzE9LCRRP6CX2ufauIBql/KVkLzZLQj9bY7fygxqOUOLHtTmQnlJT1bW2vqeQ653Q+fagDXig==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr31951646wrx.115.1553862933124;
        Fri, 29 Mar 2019 05:35:33 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/6] Documentation/technical/api-config.txt: fix formatting
Date:   Fri, 29 Mar 2019 13:35:16 +0100
Message-Id: <20190329123520.27549-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190329123520.27549-1-szeder.dev@gmail.com>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190329123520.27549-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor versions v1.5.7 or later print the following warning while
building the documentation:

      ASCIIDOC technical/api-config.html
  asciidoctor: WARNING: api-config.txt: line 232: unterminated listing block

This highlight an issue (even with older Asciidoctor versions) where
the length of the '----' lines surrounding a code example don't match,
and the rest of the document is rendered in monospace.

Fix this by making sure that the length of those lines match.

The page rendered with AsciiDoc doesn't have this formatting issue.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index fa39ac9d71..7d20716c32 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -229,7 +229,7 @@ A `config_set` can be used to construct an in-memory cache for
 config-like files that the caller specifies (i.e., files like `.gitmodules`,
 `~/.gitconfig` etc.). For example,
 
----------------------------------------
+----------------------------------------
 struct config_set gm_config;
 git_configset_init(&gm_config);
 int b;
-- 
2.21.0.539.g07239c3a71.dirty

