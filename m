Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A3720248
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfCXVzw (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35059 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so7966859wrp.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aosOI7X8jOegorDWKC5cBD8GjBzQO0+hNli2kaJQGcg=;
        b=NgUM2pJEY8J0oAf6ku7pfh73X7al59/+MM5peR/hbvDdCxlLvj+8LFm5rdqQrSCMgr
         diYTnfrx/jKG8D05w8OhKKrnnKjpUJjY11+AxIA1cf7k2M6l1As+lIdWV7MBmIbteHrd
         zxQPo8WZvhp5HQlJ1OyURh8KMAD0NopA91i9iMK+1LcjDDxgRMg784gl2rOfJ1VkUN20
         j32zh9E86wwBoz2JITVFavXez6RQHWgYTxS7bRdTZGlkB8AXR5iQH4GRrGSSC+9W12IQ
         CdDX8K+gHZX8kGQcIuqm8nHXwz/Rl0NSQJxPM1iv6glk0fv++miRZuODtUd7aci4QW7i
         fQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aosOI7X8jOegorDWKC5cBD8GjBzQO0+hNli2kaJQGcg=;
        b=DarBkBoRhH35hEMPX8TerUrTQW0UWR0PQYUNXD/XH7lxNuMP8DnxtJRy/fXMhZs4Na
         4yOmOz26B6x37kSVe6dQSPF/w1Z6aSIvWtnvL2QanQBsMXiy/5HCE+I/G6eRGymDcprs
         CKk2V0aLQTAwMrOzBDxhtcL2/sJ0kRdEVOmyAMm1pVoYDOsjw4YLZ7j23yyhCakqk/9q
         Xujv1zK5nrEPsnr8OfGBzx6s6X+J9T/0/9aG8yBGjl3VsrufBwSWnyymtYK7lK575PCO
         zqfb++riJ8kapz0/BpuQklfTEYhUnzhviBOvCWgic4t6fS+jw2PjpDhm7ynODFwOVqXI
         5qLA==
X-Gm-Message-State: APjAAAW28rpxuMXf2tCrTGd3sEoDj+Som5d0tDypSp8xuqHWKbJUgkGV
        uc97nN0ghIdlgrAIog327ksiCuPa
X-Google-Smtp-Source: APXvYqxf92w870WlXOa4XHH6muKMxwsRbLj6c3qcHmFWt/tS9SgvMZxkgQ0FP0IxZ2lSob5zjWf/pg==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr13022556wrq.280.1553464549428;
        Sun, 24 Mar 2019 14:55:49 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/6] Documentation/technical/api-config.txt: fix formatting
Date:   Sun, 24 Mar 2019 22:55:30 +0100
Message-Id: <20190324215534.9495-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
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

