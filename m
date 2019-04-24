Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E161F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfDXPOr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42268 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfDXPOq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so20669692qtc.9
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQGIytjRh9X3ZKArMmtc546ORvU00+dVpAORoSUQA4E=;
        b=I+J+3SoQdBX2zSho6n7lpjLai0lJOxcsS34NYQZs5TCdXa5iN6NRG2DozBR19Zit7O
         qWEfQAR/RTwtb81woKNtLnmw6PIJgzkf40jChyRo6ob1+Yv7DLeLMrIcO82f1paZFtoZ
         pX22e0tmAusTO8BTzV4UZD7aDhOtqRzzjaJS/iMKV8SWdclQmQUroOAos5N85MGMiRtR
         bSQLYlrjdYAXX/H+hyzrr3lK1mASK6zVSBuH1BcgBOwhw/wxBWGmAEflsAoFbN5aHDGK
         yOewhNEZgQ4SrSxKpxpT9Nc6NvEn1iFxhrBWuCUwR6UIYJPObIhaJiQMXY+WD0axw6uY
         552w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQGIytjRh9X3ZKArMmtc546ORvU00+dVpAORoSUQA4E=;
        b=V933RgDTybnrBwxZTBVVGfIkG09TH+UC7T329OI/d3+RrxXJTJsyb71Fb/gdXHsAno
         shG4uzTeuOFyeaf8/Tu7XmTFndk5aIza8WxSkOD3q/gArY8kxI+nC4b4NxSy+Xsjbsr1
         USkd6MqGXdOjNKd4AxO9NMoS2MfX3+GH6I77lE9KGJfQQo60Ec0ZRxSOHFGX2AISXDhZ
         +04pAkM/RMIZ3mZmkC+T6vzdySvV8CeLrzNz8npk1nXtg0G3re0rHiq3BwwSXuUpVzDZ
         /Lr5nleUAz0MNwfOnTSeAnz9KHfYolRn9FvzONbLtEfzTV+CpKyQdBciek6g1t/m6oD+
         3PPg==
X-Gm-Message-State: APjAAAU6srGHl2UEtUvljc0ZnwNXKp2dsTADhS4Pqm7mYBi1D3bCUQf3
        /oKz+8cutM6nq8FaJnwFNPe/d6ib
X-Google-Smtp-Source: APXvYqyT/ZpmRw537ODcWYvfObSOFdMvHeNC/Lgp0prSbcxLzcx8uYAW8mNcd0LErg2+nf6pFAl1nA==
X-Received: by 2002:a0c:fdc7:: with SMTP id g7mr6545251qvs.230.1556118885502;
        Wed, 24 Apr 2019 08:14:45 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:45 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Szeder=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 02/11] Docs: rearrange subcommands for multi-pack-index
Date:   Wed, 24 Apr 2019 11:14:19 -0400
Message-Id: <20190424151428.170316-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will add new subcommands to the multi-pack-index, and that will
make the documentation a bit messier. Clean up the 'verb'
descriptions by renaming the concept to 'subcommand' and removing
the reference to the object directory.

Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index f7778a2c85..1af406aca2 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <verb>
+'git multi-pack-index' [--object-dir=<dir>] <subcommand>
 
 DESCRIPTION
 -----------
@@ -23,13 +23,13 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+The following subcommands are available:
+
 write::
-	When given as the verb, write a new MIDX file to
-	`<dir>/packs/multi-pack-index`.
+	Write a new MIDX file.
 
 verify::
-	When given as the verb, verify the contents of the MIDX file
-	at `<dir>/packs/multi-pack-index`.
+	Verify the contents of the MIDX file.
 
 
 EXAMPLES
-- 
2.21.0.1096.g1c91fdc207

