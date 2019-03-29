Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6BF20248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfC2Mfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40146 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfC2Mfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so2401840wre.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6dWr6A6810kFLcrncLWbeqlzOLeTtogdcqCfQjl0kQ=;
        b=l5gb3Smg+Ex0xeTtVHj69DAGp2MH97D6+qsML6l0m72A3hH/hjgyfO+NF3ijmfmQ1Q
         Sx2cFn56yscPy7WOTfyA4sAvduR2N21RMeDyQELErSIhwoTWUzbIwenubE2SCAwMR46e
         U74NaB35YeFb1+J2mF7hshGv53dgPxgXMswkZJIvrEz0+V9sL4+zDkOcwjga7pX5KC8O
         Y24W9sP3dZrbtOGT9eAiP2YJ8xtLf9RVqIcyhMpSeyYQoDukxqKCm2OlbZg88QGq0VHR
         pVVHJPRgOgnS7qygW9vrBG0PwBTyyv1jkFm5EmyBCt6FZYooC0Jl646kTxHrVVjdAMQe
         apyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6dWr6A6810kFLcrncLWbeqlzOLeTtogdcqCfQjl0kQ=;
        b=bNbXLnrEVNFEB4N7pQGRrwfgBvufhxIm3v5K8NSza3rSmOTLFUsirSFJVCAxb5kbWi
         /66RPH1PBxwFK76lDQil6z59lwIP5IuHiokosTxAkqBUQw8HmaQzmDFC08SCo2LI1XQf
         dXOKc0hdXLAGIoIuaT3pqDgvpUPgCISboe7gPMbcjUq4e6zPQJrsvKbUfQqqjuR3O8bl
         7lSCD4H+5CukXf/Pqd1YX6Z6lMHI5qcFaNLvuf5EcWWvglC6/xOhaE0D0BxhjxmgbTZI
         ZaThrZCFg1VjXl4dzv5q+xbCOgeUaIQgk1EqWKmdGoINYDRJ/aK8MZolemzU2bbV/+1x
         ebkQ==
X-Gm-Message-State: APjAAAV3jdw14W3llFfu0yjj1yn11Gb2VpxvBFgj/0oaPsSgHLisDZex
        bYLMd97gCCoM/wQ6rxFi7Y2AhLDk
X-Google-Smtp-Source: APXvYqx6RrMFvnbW3CpjXZNIpZOPZqeUbD6DNhU75FChb9skyAe5zbM5gkBXQYykhVeOKw+rVBuTgw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr10461498wrr.147.1553862932049;
        Fri, 29 Mar 2019 05:35:32 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/6] Documentation/git-diff-tree.txt: fix formatting
Date:   Fri, 29 Mar 2019 13:35:15 +0100
Message-Id: <20190329123520.27549-2-szeder.dev@gmail.com>
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

