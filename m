Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4B120248
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfCXVzv (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfCXVzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3727421wmi.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6dWr6A6810kFLcrncLWbeqlzOLeTtogdcqCfQjl0kQ=;
        b=Ak+ge2ixtnDpp7mKajo44mzMEylAbVHaxeP98knSpP2+TrhjrqIKyVIqt+4syQcEd5
         3v06O1UZgiCtXMCWlLxRNbTs1AbQFdDsAkz8PKI2tFXvyn6KcPZEFL2/vadP83eK0Svr
         eLxcTt4Xoxyu4GbABociET8bYPZZ9wzkey/TNaqlSCYqdU9XTyusNU64xG+cvtA2Ldjg
         5m2e5kvQ1WaOkTRjpqSQzvmB0rGacsCPbTWwrLwpqAf/GvB905rfculkER2LlF0lRFC6
         it8yzEoOEdzr1rrxMYzQK/VOa1ZJvBt6nB/kFyQMCMqVH6MPIi0ORj4f3r4M+LPCxSBU
         RNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6dWr6A6810kFLcrncLWbeqlzOLeTtogdcqCfQjl0kQ=;
        b=jDEeCQhDOdTtUrTT+dd+A9oWwtHZB4QuJYIYG6VXV9LYHoveh7MyIO7YIDh6x7TPmB
         pU0TNznj8WeKP2MKFhujjPZ4BKw1a+NHOF02l0SD+CBrVLQ4gZhvIggu2X29QnnQj7f6
         /1c2afSszbrd44YGXh7pn8Cmse6OACEWDNxUshKMTOoz6tmucAsCDmrUobxBCMD8JKgm
         DkvbiiWS31y1BmvXL6QNMqYXSo9Ud7z9nfKH9aIu81wK3KWaqh6/+HoOs2KVVp+ovG8B
         /6x5B6yDcaK7KUvycAczSMcZj0OQX+hiRpA+OJdy+e/qdxbaVHhcjT+l5rUGlRn8Cmvi
         Vmmg==
X-Gm-Message-State: APjAAAVFmD3s7dvkv3F+qqTLDfPsSqTTGwaVAnDsxGRwe1d0o6oPHe/z
        k5IXyWLAjIqr5CzfxnCh4rLryiX7
X-Google-Smtp-Source: APXvYqwCE+tdNVqRmWmZcf8k7k08b2awLDa0MUBceu9QB6aRsXKsAU2h0A3nExHreT0Dm7iUcfXOqw==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr9337012wmk.137.1553464548404;
        Sun, 24 Mar 2019 14:55:48 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/6] Documentation/git-diff-tree.txt: fix formatting
Date:   Sun, 24 Mar 2019 22:55:29 +0100
Message-Id: <20190324215534.9495-2-szeder.dev@gmail.com>
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

      ASCIIDOC git-diff-tree.xml
  asciidoctor: WARNING: diff-format.txt: line 2: unterminated listing block

This highlights an issue (even with older Asciidoctor versions) where
the "Raw output format" header is not rendered as a header, and the
rest of the document is rendered in monospace.  This is not caused by
'diff-format.txt' in itself, but rather by 'git-diff-tree.txt'
including 'pretty-formats.txt' and 'diff-format.txt' on subsequent
lines, while the former happens to end with monospace-formatted
example commands.

Fix this by inserting an empty line between the two include::
directives.

The page rendered with AsciiDoc doesn't have this formatting issue.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-diff-tree.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 24f32e8c54..5c8a2a5e97 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -118,6 +118,7 @@ include::pretty-options.txt[]
 
 
 include::pretty-formats.txt[]
+
 include::diff-format.txt[]
 
 GIT
-- 
2.21.0.539.g07239c3a71.dirty

